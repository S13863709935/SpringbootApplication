<template>
  <div style="width: 80%; margin: 10px auto" class="card">
    <div style="margin-bottom: 10px">
      <el-button type="primary" plain @click="handleAdd">Post Wanted</el-button>
    </div>

    <div style="margin: 10px auto">
      <el-table :data="tableData" strip>
        <el-table-column prop="title" label="Title"></el-table-column>
        <el-table-column prop="content" label="Content" show-overflow-tooltip></el-table-column>
        <el-table-column prop="img" label="Image">
          <template v-slot="scope">
            <el-image v-if="scope.row.img" style="width: 50px" :src="scope.row.img" :preview-src-list="[scope.row.img]"></el-image>
          </template>
        </el-table-column>
        <el-table-column prop="time" label="Date Posted"></el-table-column>
        <el-table-column prop="solved" label="Solved Status">
          <template v-slot="scope">
            <el-tag type="danger" v-if="scope.row.solved === '未解决'">Unresolved</el-tag>
            <el-tag type="success" v-if="scope.row.solved === '已解决'">Resolved</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="status" label="Audit Status">
          <template v-slot="scope">
            <el-tag type="info" v-if="scope.row.status === '待审核'">Pending</el-tag>
            <el-tag type="success" v-if="scope.row.status === '通过'">Approved</el-tag>
            <el-tag type="danger" v-if="scope.row.status === '拒绝'">Rejected</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="Actions" align="center" width="180">
          <template v-slot="scope">
            <el-button v-if="scope.row.status !== '通过'" size="mini" type="success" plain @click="handleEdit(scope.row)">Edit</el-button>
            <el-button size="mini" type="danger" plain @click="del(scope.row.id)">Delete</el-button>
          </template>
        </el-table-column>
      </el-table>

      <div style="margin: 15px auto">
        <el-pagination
            background
            @current-change="handleCurrentChange"
            :current-page="pageNum"
            :page-sizes="[5, 10, 20]"
            :page-size="pageSize"
            layout="total, prev, pager, next"
            :total="total">
        </el-pagination>
      </div>
    </div>

    <el-dialog title="Wanted Information" :visible.sync="fromVisible" width="40%" :close-on-click-modal="false" destroy-on-close>
      <el-form :model="form" label-width="120px" style="padding-right: 50px" :rules="rules" ref="formRef">
        <el-form-item label="Title" prop="title">
          <el-input v-model="form.title" placeholder="Title"></el-input>
        </el-form-item>
        <el-form-item label="Content" prop="content">
          <el-input type="textarea" v-model="form.content" placeholder="Content"></el-input>
        </el-form-item>
        <el-form-item label="Image" prop="img">
          <el-upload
              :action="$baseUrl + '/files/upload'"
              :headers="{ token: user.token }"
              list-type="picture"
              :on-success="handleImgSuccess"
          >
            <el-button type="primary">Upload</el-button>
          </el-upload>
        </el-form-item>
        <el-form-item label="Solved Status" prop="solved">
          <el-select style="width: 100%" v-model="form.solved">
            <el-option label="Unresolved" value="未解决"></el-option>
            <el-option label="Resolved" value="已解决"></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="fromVisible = false">Cancel</el-button>
        <el-button type="primary" @click="save">Confirm</el-button>
      </div>
    </el-dialog>


  </div>
</template>
<script>
export default {
  name: "UserHelp", // Corrected from 'title' to standard Vue property 'name'
  data() {
    return {
      tableData: [],  // All data
      pageNum: 1,   // Current page number
      pageSize: 10,  // Number of items displayed per page
      total: 0,
      title: null,
      fromVisible: false,
      form: {},
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      rules: {
      },
      ids: []
    }
  },
  created() {
    this.load(1)
  },
  methods: {
    changeStatus(row, status) {
      this.$confirm('Are you sure you want to change status to ' + status + '?', 'Confirm Action', {type: "warning"}).then(response => {
        this.form = JSON.parse(JSON.stringify(row))  // Assign value to form object. Note: deep copy is required
        this.form.status = status
        this.$request.put('/help/update', this.form).then(res => {
          if (res.code === '200') {  // Indicates successful save
            this.$message.success('Operation successful')
            this.load(1)
          } else {
            this.$message.error(res.msg)  // Pop up error message
          }
        })
      }).catch(err => {})
    },
    handleAdd() {   // Create data
      this.form = {}  // Clear data when creating
      this.fromVisible = true   // Open modal
    },
    handleEdit(row) {   // Edit data
      this.form = JSON.parse(JSON.stringify(row))  // Assign value to form object. Note: deep copy is required
      this.fromVisible = true   // Open modal
    },
    save() {   // Logic triggered by save button, it triggers create or update
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          this.$request({
            url: this.form.id ? '/help/update' : '/help/add',
            method: this.form.id ? 'PUT' : 'POST',
            data: this.form
          }).then(res => {
            if (res.code === '200') {  // Indicates successful save
              this.$message.success('Saved successfully')
              this.load(1)
              this.fromVisible = false
            } else {
              this.$message.error(res.msg)  // Pop up error message
            }
          })
        }
      })
    },
    del(id) {   // Single delete
      this.$confirm('Are you sure you want to delete?', 'Confirm Delete', {type: "warning"}).then(response => {
        this.$request.delete('/help/delete/' + id).then(res => {
          if (res.code === '200') {   // Indicates successful operation
            this.$message.success('Operation successful')
            this.load(1)
          } else {
            this.$message.error(res.msg)  // Pop up error message
          }
        })
      }).catch(() => {
      })
    },
    handleSelectionChange(rows) {   // All currently selected row data
      this.ids = rows.map(v => v.id)
    },
    delBatch() {   // Batch delete
      if (!this.ids.length) {
        this.$message.warning('Please select data')
        return
      }
      this.$confirm('Are you sure you want to batch delete these items?', 'Confirm Delete', {type: "warning"}).then(response => {
        this.$request.delete('/help/delete/batch', {data: this.ids}).then(res => {
          if (res.code === '200') {   // Indicates successful operation
            this.$message.success('Operation successful')
            this.load(1)
          } else {
            this.$message.error(res.msg)  // Pop up error message
          }
        })
      }).catch(() => {
      })
    },
    load(pageNum) {  // Paginated search
      if (pageNum) this.pageNum = pageNum
      this.$request.get('/help/selectPage', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          title: this.title,
        }
      }).then(res => {
        if (res.code === '200') {
          this.tableData = res.data?.list
          this.total = res.data?.total
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    reset() {
      this.title = null
      this.load(1)
    },
    handleCurrentChange(pageNum) {
      this.load(pageNum)
    },
    handleImgSuccess(response, file, fileList) {
      this.form.img = response.data
    },
  }
}
</script>

<style scoped>

</style>