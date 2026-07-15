package com.example.controller;

import com.example.utils.CaptchaUtil;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.imageio.ImageIO;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;

@RestController
public class CaptchaController {

    @GetMapping("/captcha")
    public void getCaptcha(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("image/jpeg");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);

        // 生成验证码
        String captchaCode = CaptchaUtil.generateCaptchaCode();

        // 设置 Cookie
        Cookie captchaCookie = new Cookie("captchaCode", captchaCode);
        captchaCookie.setPath("/");
        captchaCookie.setMaxAge(60); // 设置 Cookie 有效期为 60 秒
        response.addCookie(captchaCookie);

        // 生成验证码图片并写入输出流
        BufferedImage image = CaptchaUtil.generateCaptchaImage(captchaCode);
        OutputStream os = response.getOutputStream();
        ImageIO.write(image, "JPEG", os);
        os.flush();
        os.close();
    }
}
