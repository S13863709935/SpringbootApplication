<template>
  <div>
    <img :src="$baseUrl + captchaUrl" @click="refreshCaptcha" alt="验证码">
  </div>
</template>

<script>
import Cookies from 'js-cookie';
export default {
  data() {
    return {
      captchaUrl: '/captcha',
    };
  },
  methods: {
    refreshCaptcha() {
      this.captchaUrl = `/captcha?timestamp=${new Date().getTime()}`;
    },
    check(code) {
      return code.toLowerCase() === Cookies.get('captchaCode').toLowerCase()
    }
  }
};
</script>

<style scoped>
img {
  vertical-align: middle;
  margin-right: 10px;
}
</style>
