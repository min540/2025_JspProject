package jspproject;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailSender {
    public static void sendVerificationEmail(String recipientEmail, String verificationCode) {
        final String username = "qkrdbsdk417@gmail.com";
        final String password = "rkvb vwbg shsa fnex"; // 실제 이메일 계정의 앱 비밀번호 등을 사용하세요.
        String host = "smtp.gmail.com";
        int port = 587;
        
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        // 아래 속성 추가: TLS 프로토콜을 명시적으로 TLSv1.2로 사용
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", String.valueOf(port));
        
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });
        
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("qkrdbsdk417@gmail.com"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("오늘, 내일 이메일 인증 코드");
            String content = "회원가입 완료를 위해 아래 인증 코드를 입력하세요 : \n" + verificationCode + "\n 타인에게 노출하지 않도록 주의 하세요.";
            message.setText(content);
            Transport.send(message);
            System.out.println("인증 코드 이메일 발송 완료");
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
}
