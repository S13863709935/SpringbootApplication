package com.example.utils;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;

public class CaptchaUtil {
    private static final String CHAR_SET = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    private static final int WIDTH = 120;
    private static final int HEIGHT = 40;
    private static final int CODE_LENGTH = 4;

    public static String generateCaptchaCode() {
        Random random = new Random();
        StringBuilder captchaCode = new StringBuilder();
        for (int i = 0; i < CODE_LENGTH; i++) {
            int index = random.nextInt(CHAR_SET.length());
            captchaCode.append(CHAR_SET.charAt(index));
        }
        return captchaCode.toString();
    }

    public static BufferedImage generateCaptchaImage(String captchaCode) {
        BufferedImage image = new BufferedImage(WIDTH, HEIGHT, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = image.createGraphics();

        // 设置背景色
        g.setColor(Color.WHITE);
        g.fillRect(0, 0, WIDTH, HEIGHT);

        // 设置字体
        g.setFont(new Font("Arial", Font.BOLD, 24));

        // 绘制验证码字符
        for (int i = 0; i < captchaCode.length(); i++) {
            char c = captchaCode.charAt(i);
            g.setColor(new Color(new Random().nextInt(256), new Random().nextInt(256), new Random().nextInt(256)));
            g.drawString(String.valueOf(c), 20 + i * 20, 30);
        }

        // 绘制干扰线
        for (int i = 0; i < 5; i++) {
            int x1 = new Random().nextInt(WIDTH);
            int y1 = new Random().nextInt(HEIGHT);
            int x2 = new Random().nextInt(WIDTH);
            int y2 = new Random().nextInt(HEIGHT);
            g.setColor(new Color(new Random().nextInt(256), new Random().nextInt(256), new Random().nextInt(256)));
            g.drawLine(x1, y1, x2, y2);
        }

        g.dispose();
        return image;
    }
}
