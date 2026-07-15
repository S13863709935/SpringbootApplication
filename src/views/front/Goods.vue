<template>
  <div style="width: 70%; margin: 10px auto" class="card">

    <div>
      <el-table :data="tableData" strip>
        <el-table-column prop="name" label="Name" show-overflow-tooltip></el-table-column>
        <el-table-column prop="price" label="Price">
          <template v-slot="scope">
            <span style="color: red">${{ scope.row.price }}</span>
          </template>
        </el-table-column>
        <el-table-column prop="content" label="Details" width="100">
          <template v-slot="scope">
            <el-button @click="preview(scope.row.content)">Show Details</el-button>
          </template>
        </el-table-column>
        <el-table-column prop="address" label="Shipping Address"></el-table-column>
        <el-table-column prop="img" label="Image">
          <template v-slot="scope">
            <el-image v-if="scope.row.img" style="width: 50px" :src="scope.row.img" :preview-src-list="[scope.row.img]"></el-image>
          </template>
        </el-table-column>
        <el-table-column prop="date" label="Listing Date"></el-table-column>
        <el-table-column prop="status" label="Audit Status">
          <template v-slot="scope">
            <el-tag type="info" v-if="scope.row.status === '待审核'">Pending</el-tag>
            <el-tag type="success" v-if="scope.row.status === '通过'">Approved</el-tag>
            <el-tag type="danger" v-if="scope.row.status === '拒绝'">Rejected</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="category" label="Category"></el-table-column>
        <el-table-column prop="saleStatus" label="Sale Status"></el-table-column>
        <el-table-column prop="readCount" label="Views"></el-table-column>
        <el-table-column label="Actions" align="center" width="160">
          <template v-slot="scope">
            <el-button size="mini" type="primary" plain @click="handleEdit(scope.row)">Edit</el-button>
            <el-button size="mini" type="danger" plain @click="del(scope.row.id)">Delete</el-button>
          </template>
        </el-table-column>
      </el-table>

      <div style="margin: 15px 0">
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

    <el-dialog title="Content" :visible.sync="fromVisible1" width="60%" :close-on-click-modal="false" destroy-on-close>
      <div v-html="content"></div>
    </el-dialog>


  </div>
</template>
<script>
export default {
  name: "FrontGoods",
  data() {
    return {
      tableData: [],  // All data
      pageNum: 1,   // Current page number
      pageSize: 10,  // Number of items displayed per page
      total: 0,
      name: null,
      fromVisible: false,
      form: {},
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      rules: {
      },
      ids: [],
      content: '',
      fromVisible1: false
    }
  },
  created() {
    this.load(1)
  },
  methods: {
    preview(content) {
      this.content = content
      this.fromVisible1 = true
    },
    changeStatus(row, status) {
      this.$confirm('Are you sure you want to proceed?', 'Confirm Action', {type: "warning"}).then(response => {
        this.form = JSON.parse(JSON.stringify(row))  // Assign value to form object. Note: deep copy is required
        this.form.status = status
        this.$request.put('/goods/update', this.form).then(res => {
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
      this.$router.push('/front/addGoods?id=' + row.id)
    },
    save() {   // Logic triggered by save button, it triggers create or update
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          this.$request({
            url: this.form.id ? '/goods/update' : '/goods/add',
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
        this.$request.delete('/goods/delete/' + id).then(res => {
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
        this.$request.delete('/goods/delete/batch', {data: this.ids}).then(res => {
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
      this.$request.get('/goods/selectPage', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          name: this.name,
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
      this.name = null
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