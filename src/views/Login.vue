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
            <div style="border-bottom: 2px solid orangered; padding-bottom: 10px">Login</div>
            <a style="color: #333" href="/register"><div style="margin-left: 10px;">Register</div></a>
          </div>
          <el-form :model="form" :rules="rules" ref="formRef">
            <el-form-item prop="username">
              <el-input size="medium" prefix-icon="el-icon-user" placeholder="Please enter your username" v-model="form.username"></el-input>
            </el-form-item>
            <el-form-item prop="password">
              <el-input size="medium" prefix-icon="el-icon-lock" placeholder="Please enter your password" show-password  v-model="form.password"></el-input>
            </el-form-item>
            <el-form-item prop="captcha">
              <el-row>
                <el-col :span="16"><el-input size="medium" prefix-icon="el-icon-lock" placeholder="Please enter the verification code" show-password  v-model="form.captcha"></el-input></el-col>
                <el-col :span="8"><Captcha ref="captcha" /></el-col>
              </el-row>
            </el-form-item>
            <el-form-item prop="role">
              <el-select v-model="form.role" style="width: 100%">
                <el-option label="Administrator" value="ADMIN"></el-option>
                <el-option label="User" value="USER"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item>
              <el-button size="medium" style="width: 100%; background-color: orangered; border-color: orangered; color: white" @click="login">Login</el-button>
            </el-form-item>
          </el-form>
        </div>
      </div>

    </div>

  </div>
</template>

<script>
import Captcha from '@/components/Captcha.vue';
export default {
  name: "Login",
  components: {
    Captcha
  },
  data() {
    return {
      form: { role: 'ADMIN' },
      rules: {
        username: [
          { required: true, message: 'Please enter your username', trigger: 'blur' },
        ],
        password: [
          { required: true, message: 'Please enter your password', trigger: 'blur' },
        ],
        captcha: [
          { required: true, message: 'Please enter the verification code', trigger: 'blur' },
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
          if (!this.$refs.captcha.check(this.form.captcha)) {
            this.$message.error("Verification code error")
            return
          }
          // Validation passed
          this.$request.post('/login', this.form).then(res => {
            if (res.code === '200') {
              localStorage.setItem("xm-user", JSON.stringify(res.data))  // Store user data
              if (res.data.role === 'ADMIN') {
                this.$router.push('/home')  // Navigate to home page
              } else {
                this.$router.push('/front/home')  // Navigate to frontend home page
              }
              this.$message.success('Login successful')
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