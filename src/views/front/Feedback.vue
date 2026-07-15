<template>
  <div style="width: 50%; margin: 10px auto; padding: 30px" class="card">
    <div style="font-size: 20px; margin-bottom: 30px; text-align: center">Please enter your feedback</div>
    <el-form :model="form" label-width="100px" style="padding-right: 50px" :rules="rules" ref="formRef">
      <el-form-item label="Subject" prop="title">
        <el-input v-model="form.title" placeholder="Please enter a subject"></el-input>
      </el-form-item>
      <el-form-item label="Content" prop="content">
        <el-input type="textarea" v-model="form.content" placeholder="Please enter content"></el-input>
      </el-form-item>
      <el-form-item label="Phone" prop="phone">
        <el-input v-model="form.phone" placeholder="Please enter a phone number"></el-input>
      </el-form-item>
      <el-form-item label="Email" prop="email">
        <el-input v-model="form.email" placeholder="Please enter an email address"></el-input>
      </el-form-item>
      <div style="text-align: center">
        <el-button type="primary" @click="save">Submit Feedback</el-button>
      </div>
    </el-form>
  </div>
</template>

<script>
export default {
  name: "Feedback",
  data() {
    return {
      form: {},
      rules: {
        title: [
          { required: true, message: 'Please enter a subject', trigger: 'blur' }
        ],
        content: [
          { required: true, message: 'Please enter content', trigger: 'blur' }
        ]
      }
    }
  },
  created() {

  },
  methods: {
    save() {   // Logic triggered by save button, it triggers create or update
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          this.$request({
            url: '/feedback/add',
            method: 'POST',
            data: this.form
          }).then(res => {
            if (res.code === '200') {  // Indicates successful save
              this.$message.success('Submitted successfully')
            } else {
              this.$message.error(res.msg)  // Pop up error message
            }
          })
        }
      })
    },
  }
}
</script>

<style scoped>

</style>