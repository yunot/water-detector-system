package com.isoftstone.platform.common.uitl;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;

import javax.imageio.ImageIO;

public class ValidateVodeUtil
{
    
    /**
     * Ĭ��ͼƬ���
     */
    private static final int DEFAULT_WIDTH = 180;
    
    /**
     * Ĭ��ͼƬ�߶�
     */
    private static final int DEFAULT_HEIGHT = 46;
    
    /**
     * Ĭ�ϸ���������
     */
    private static final int DEFAULT_LINESIZE = 80;
    
    /**
     * Ĭ����������ַ�����
     */
    private static final int DEFAULT_STRINGNUM = 5;
    
    /**
     * ����������ַ���
     */
    private static String randString = "23456789ABCDEFGHJKLMNPQRSTUVWXYZ";
    
    /**
     * ���������
     */
    private static Random random = new Random();
    
    public static String genValidateVode(OutputStream ops)
        throws IOException
    {
        
        // BufferedImage���Ǿ��л�������Image��,Image������������ͼ����Ϣ����
        BufferedImage image = new BufferedImage(DEFAULT_WIDTH, DEFAULT_HEIGHT, BufferedImage.TYPE_INT_BGR);
        
        // ����Image�����Graphics����,�Ķ��������ͼ���Ͻ��и��ֻ��Ʋ���
        Graphics g = image.getGraphics();
        
        g.fillRect(0, 0, DEFAULT_WIDTH, DEFAULT_HEIGHT);
        g.setFont(new Font("Times New Roman", Font.ROMAN_BASELINE, 18));
        g.setColor(getRandColor(110, 133));
        
        // ���Ƹ�����
        for (int i = 0; i <= DEFAULT_LINESIZE; i++)
        {
            drowLine(g);
        }
        
        // ��������ַ�
        String randomString = "";
        for (int i = 1; i <= DEFAULT_STRINGNUM; i++)
        {
            randomString = drowString(g, randomString, i);
        }
        
        g.dispose();
        ImageIO.setUseCache(false);
        ImageIO.write(image, "JPEG", ops);
        
        return randomString;
        
    }
    
    /**
     * ���Ƹ�����
     */
    private static void drowLine(Graphics g)
    {
        int x = random.nextInt(DEFAULT_WIDTH);
        int y = random.nextInt(DEFAULT_HEIGHT);
        int xl = random.nextInt(13);
        int yl = random.nextInt(15);
        g.drawLine(x, y, x + xl, y + yl);
    }
    
    /**
     * ��ȡ������ַ�
     */
    public static String getRandomString(int num)
    {
        return String.valueOf(randString.charAt(num));
    }
    
    /**
     * �����ַ���
     */
    private static String drowString(Graphics g, String randomString, int i)
    {
        g.setFont(getFont());
        g.setColor(new Color(random.nextInt(101), random.nextInt(111), random.nextInt(121)));
        String rand = String.valueOf(getRandomString(random.nextInt(randString.length())));
        randomString += rand;
        g.translate(random.nextInt(3), random.nextInt(3));
        g.drawString(rand, 25 * i, 30);
        return randomString;
    }
    
    /**
     * �������
     */
    private static Font getFont()
    {
        return new Font("Fixedsys", Font.CENTER_BASELINE, 30);
    }
    
    /**
     * �����ɫ
     */
    private static Color getRandColor(int fc, int bc)
    {
        if (fc > 255)
            fc = 255;
        if (bc > 255)
            bc = 255;
        int r = fc + random.nextInt(bc - fc - 16);
        int g = fc + random.nextInt(bc - fc - 14);
        int b = fc + random.nextInt(bc - fc - 18);
        return new Color(r, g, b);
    }
    
}
