<template>
  <div style="margin: 10px auto; width: 70%">
    <div class="card" style="margin-bottom: 10px; padding: 10px; display: flex">
      <div style="flex: 1">
        <el-button type="primary" @click="handleAdd">Create Post</el-button>
      </div>
      <div>
        <el-input placeholder="Enter title keywords to search" style="width: 260px" v-model="title"></el-input>
        <el-button type="info" plain style="margin-left: 10px" @click="load(1)">Search</el-button>
        <el-button type="warning" plain style="margin-left: 10px" @click="reset">Reset</el-button>
      </div>
    </div>

    <div class="card">
      <el-table :data="tableData" strip>
        <el-table-column prop="img" label="Image">
          <template v-slot="scope">
            <el-image v-if="scope.row.img" style="width: 50px" :src="scope.row.img" :preview-src-list="[scope.row.img]"></el-image>
          </template>
        </el-table-column>
        <el-table-column prop="title" label="Title" show-overflow-tooltip></el-table-column>
        <el-table-column label="Content" width="120px">
          <template v-slot="scope">
            <el-button @click="preview(scope.row.content)">View Content</el-button>
          </template>
        </el-table-column>
        <el-table-column prop="time" label="Date Posted" show-overflow-tooltip></el-table-column>
        <el-table-column prop="circle" label="Community"></el-table-column>
        <el-table-column prop="descr" label="Description"></el-table-column>
        <el-table-column prop="readCount" label="Views"></el-table-column>
        <el-table-column prop="status" label="Audit Status">
          <template v-slot="scope">
            <el-tag type="info" v-if="scope.row.status === '待审核'">Pending</el-tag>
            <el-tag type="success" v-if="scope.row.status === '通过'">Approved</el-tag>
            <el-tag type="danger" v-if="scope.row.status === '拒绝'">Rejected</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="Actions" align="center" width="180">
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

    <el-dialog title="Post Information" :visible.sync="fromVisible" width="50%" :close-on-click-modal="false" destroy-on-close>
      <el-form :model="form" label-width="100px" style="padding-right: 50px" :rules="rules" ref="formRef">
        <el-form-item label="Title" prop="title">
          <el-input v-model="form.title" placeholder="Title"></el-input>
        </el-form-item>
        <el-form-item label="Description" prop="descr">
          <el-input type="textarea" v-model="form.descr" placeholder="Description"></el-input>
        </el-form-item>
        <el-form-item label="Community" prop="circle">
          <el-select style="width: 100%" v-model="form.circle">
            <el-option v-for="item in circles" :key="item.id" :value="item.name" :label="item.name"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="Image" prop="img">
          <el-upload
              :action="$baseUrl + '/files/upload'"
              :headers="{ token: user.token }"
              list-type="picture"
              :on-success="handleImgSuccess"
          >
            <el-button type="primary">Upload Image</el-button>
          </el-upload>
        </el-form-item>
        <el-form-item label="Content" prop="content">
          <div id="editor"></div>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="fromVisible = false">Cancel</el-button>
        <el-button type="primary" @click="save">Confirm</el-button>
      </div>
    </el-dialog>

    <el-dialog title="Post Content" :visible.sync="fromVisible1" width="50%" :close-on-click-modal="false" destroy-on-close>
      <div class="w-e-text">
        <div v-html="content"></div>
      </div>

      <div slot="footer" class="dialog-footer">
        <el-button @click="fromVisible1 = false">Close</el-button>
      </div>
    </el-dialog>

  </div>
</template>
<script>
import E from "wangeditor"
export default {
  name: "UserPosts", // Corrected from 'title' to standard Vue property 'name'
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
      ids: [],
      editor: null,
      content: '',
      fromVisible1: false,
      circles: []
    }
  },
  created() {
    this.load(1)
    this.loadCircles()
  },
  methods: {
    loadCircles() {
      this.$request.get('/circles/selectAll').then(res => {
        this.circles = res.data || []
      })
    },
    changeStatus(row, status) {
      this.$confirm('Are you sure you want to change status to ' + status + '?', 'Confirm Action', {type: "warning"}).then(response => {
        this.form = JSON.parse(JSON.stringify(row))  // Assign value to form object. Note: deep copy is required
        this.form.status = status
        this.$request.put('/posts/update', this.form).then(res => {
          if (res.code === '200') {  // Indicates successful save
            this.$message.success('Operation successful')
            this.load(1)
          } else {
            this.$message.error(res.msg)  // Pop up error message
          }
        })
      }).catch(err => {})
    },
    preview(content) {
      this.content = content
      this.fromVisible1 = true
    },
    handleAdd() {   // Create data
      this.form = {}  // Clear data when creating
      this.fromVisible = true   // Open modal
      this.setRichText('')
    },
    handleEdit(row) {   // Edit data
      this.form = JSON.parse(JSON.stringify(row))  // Assign value to form object. Note: deep copy is required
      this.fromVisible = true   // Open modal
      this.setRichText(this.form.content)
    },
    save() {   // Logic triggered by save button, it triggers create or update
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          this.form.content = this.editor.txt.html()
          this.$request({
            url: this.form.id ? '/posts/update' : '/posts/add',
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
        this.$request.delete('/posts/delete/' + id).then(res => {
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
        this.$request.delete('/posts/delete/batch', {data: this.ids}).then(res => {
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
      this.$request.get('/posts/selectPage', {
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
    setRichText(html) {
      this.$nextTick(() => {
        this.editor = new E(`#editor`)
        this.editor.config.uploadImgServer = this.$baseUrl + '/files/editor/upload'
        this.editor.config.uploadFileName = 'file'
        this.editor.config.uploadImgHeaders = {
          token: this.user.token
        }
        this.editor.config.uploadImgParams = {
          type: 'img',
        }
        this.editor.create()  // Create
        this.editor.txt.html(html)
      })
    },
    handleImgSuccess(response, file, fileList) {
      this.form.img = response.data
    },
  }
}
</script>

<style scoped>

</style>