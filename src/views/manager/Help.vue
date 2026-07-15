<template>
  <div>
    <div class="search">
      <el-input placeholder="Enter title keyword to search" style="width: 200px" v-model="title"></el-input>
      <el-button type="info" plain style="margin-left: 10px" @click="load(1)">Search</el-button>
      <el-button type="warning" plain style="margin-left: 10px" @click="reset">Reset</el-button>
    </div>

    <div class="operation">
      <el-button type="danger" plain @click="delBatch">Batch Delete</el-button>
    </div>

    <div class="table">
      <el-table :data="tableData" strip @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center"></el-table-column>
        <el-table-column prop="id" label="ID" width="70" align="center" sortable></el-table-column>
        <el-table-column prop="title" label="Title"></el-table-column>
        <el-table-column prop="content" label="Content" show-overflow-tooltip></el-table-column>
        <el-table-column prop="img" label="Image">
          <template v-slot="scope">
            <el-image v-if="scope.row.img" style="width: 50px" :src="scope.row.img" :preview-src-list="[scope.row.img]"></el-image>
          </template>
        </el-table-column>
        <el-table-column prop="userId" label="User ID"></el-table-column>
        <el-table-column prop="userName" label="Username"></el-table-column>
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
        <el-table-column label="Actions" align="center" width="260">
          <template v-slot="scope">
            <el-button size="mini" type="success" plain @click="changeStatus(scope.row, '通过')">Approve</el-button>
            <el-button size="mini" type="danger" plain @click="changeStatus(scope.row, '拒绝')">Reject</el-button>
            <el-button size="mini" type="danger" plain @click="del(scope.row.id)">Delete</el-button>
          </template>
        </el-table-column>
      </el-table>

      <div class="pagination">
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
          <el-input v-model="form.content" placeholder="Content"></el-input>
        </el-form-item>
        <el-form-item label="Image" prop="img">
          <el-input v-model="form.img" placeholder="Image URL"></el-input>
        </el-form-item>
        <el-form-item label="Status" prop="status">
          <el-input v-model="form.status" placeholder="Status"></el-input>
        </el-form-item>
        <el-form-item label="User ID" prop="userId">
          <el-input v-model="form.userId" placeholder="User ID"></el-input>
        </el-form-item>
        <el-form-item label="Date Posted" prop="time">
          <el-input v-model="form.time" placeholder="Date Posted"></el-input>
        </el-form-item>
        <el-form-item label="Solved Status" prop="solved">
          <el-input v-model="form.solved" placeholder="Solved Status"></el-input>
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
  name: "Help", // Corrected from 'title' to standard Vue property 'name'
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
      this.$confirm('Are you sure you want to proceed?', 'Confirm Action', {type: "warning"}).then(response => {
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
  }
}
</script>

<style scoped>

</style>