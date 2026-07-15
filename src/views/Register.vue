<template>
  <div class="container">
    <div style="width: 500px;">
      <img src="@/assets/imgs/bg.jpg" alt="" style="width: 100%; margin-top: -150px">
    </div>
    <div style="flex: 1; background-color: #f8f8f8">
      <div style="height: 50px; display: flex; align-items: center; background-color: white; padding-left: 20px">
        <img src="@/assets/imgs/logo1.png" alt="" style="width: 40px">
        <span style="font-size: 24px; margin-left: 5px">Local Community Flea Market System</span>
      </div>
      <div style="height: calc(100vh - 50px); display: flex; align-items: center; justify-content: center">
        <div style="width: 400px; padding: 40px; background-color: white; border-radius: 5px;">
          <div style="display: flex; margin-bottom: 50px; font-size: 24px">
            <a style="color: #333" href="/login"><div>Login</div></a>
            <div style="margin-left: 10px; border-bottom: 2px solid orangered; padding-bottom: 10px">Register</div>
          </div>
          <el-form :model="form" :rules="rules" ref="formRef">
            <el-form-item prop="username">
              <el-input size="medium" prefix-icon="el-icon-user" placeholder="Please enter your username" v-model="form.username"></el-input>
            </el-form-item>
            <el-form-item prop="password">
              <el-input size="medium" prefix-icon="el-icon-lock" placeholder="Please enter your password" show-password  v-model="form.password"></el-input>
            </el-form-item>
            <el-form-item prop="confirmPassword">
              <el-input size="medium" prefix-icon="el-icon-lock" placeholder="Please confirm your password" show-password  v-model="form.confirmPassword"></el-input>
            </el-form-item>
            <el-form-item>
              <el-button size="medium" style="width: 100%; background-color: orangered; border-color: orangered; color: white" @click="login">Register</el-button>
            </el-form-item>
          </el-form>
        </div>
      </div>

    </div>


  </div>
</template>

<script>
export default {
  name: "Register",
  data() {
    // Password confirmation validation
    const validatePassword = (rule, confirmPass, callback) => {
      if (confirmPass === '') {
        callback(new Error('Please confirm your password'))
      } else if (confirmPass !== this.form.password) {
        callback(new Error('Passwords do not match'))
      } else {
        callback()
      }
    }
    return {
      form: { role: 'USER' },
      rules: {
        username: [
          { required: true, message: 'Please enter your username', trigger: 'blur' },
        ],
        password: [
          { required: true, message: 'Please enter your password', trigger: 'blur' },
        ],
        confirmPassword: [
          { validator: validatePassword, trigger: 'blur' }
        ]
      }
    }
  },
  created() {

  },
  methods: {
    login() {
      this.$refs['formRef'].validate((valid) => {
        if (valid) {
          // Validation passed
          this.$request.post('/register', this.form).then(res => {
            if (res.code === '200') {
              this.$router.push('/login')
              this.$message.success('Registration successful')
            } else {
              this.$message.error(res.msg)
            }
          })
        }
      })
    }
  }
}
</script>

<style scoped>
.container {
  height: 100vh;
  overflow: hidden;
  display: flex;
}
a {
  color: #2a60c9;
}
</style>