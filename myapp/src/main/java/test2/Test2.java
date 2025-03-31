package test2;

import javax.swing.*;
import java.awt.*;

public class Test2 {
    public static void main(String[] args) {
        JFrame frame = new JFrame("회원정보수정");
        frame.setSize(400, 350);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLayout(new GridBagLayout());
        
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.insets = new Insets(5, 5, 5, 5);
        gbc.fill = GridBagConstraints.HORIZONTAL;
        gbc.gridx = 0;
        gbc.gridy = 0;
        
        frame.add(new JLabel("회원정보수정"), gbc);
        
        gbc.gridy++;
        frame.add(new JLabel("이름"), gbc);
        gbc.gridx = 1;
        JTextField nameField = new JTextField(15);
        frame.add(nameField, gbc);
        
        gbc.gridx = 0;
        gbc.gridy++;
        frame.add(new JLabel("학번"), gbc);
        gbc.gridx = 1;
        JTextField idField = new JTextField("disable", 15);
        idField.setEnabled(false);
        frame.add(idField, gbc);
        
        gbc.gridx = 0;
        gbc.gridy++;
        frame.add(new JLabel("비밀번호 변경"), gbc);
        gbc.gridx = 1;
        JPasswordField passwordField = new JPasswordField(15);
        frame.add(passwordField, gbc);
        
        gbc.gridx = 0;
        gbc.gridy++;
        frame.add(new JLabel("비밀번호 확인"), gbc);
        gbc.gridx = 1;
        JPasswordField confirmPasswordField = new JPasswordField(15);
        frame.add(confirmPasswordField, gbc);
        
        gbc.gridx = 1;
        gbc.gridy++;
        JLabel matchLabel = new JLabel("일치/불일치");
        frame.add(matchLabel, gbc);
        
        gbc.gridx = 0;
        gbc.gridy++;
        frame.add(new JLabel("학과"), gbc);
        gbc.gridx = 1;
        String[] departments = {""};
        JComboBox<String> departmentBox = new JComboBox<>(departments);
        frame.add(departmentBox, gbc);
        
        gbc.gridx = 0;
        gbc.gridy++;
        frame.add(new JLabel("전화번호"), gbc);
        gbc.gridx = 1;
        JTextField phoneField = new JTextField(15);
        frame.add(phoneField, gbc);
        
        gbc.gridx = 0;
        gbc.gridy++;
        gbc.gridwidth = 2;
        JButton completeButton = new JButton("완료");
        frame.add(completeButton, gbc);
        
        // "완료" 버튼 클릭 시 처리
        completeButton.addActionListener(e -> {
            String stName = nameField.getText();
            String stPw = new String(passwordField.getPassword());
            String confirmPw = new String(confirmPasswordField.getPassword());
            String stTel = phoneField.getText();
            String department = (String) departmentBox.getSelectedItem();
            int stId = Integer.parseInt(idField.getText());

            // 비밀번호 일치 여부 확인
            if (!stPw.equals(confirmPw)) {
                matchLabel.setText("비밀번호 불일치");
                return;
            } else {
                matchLabel.setText("비밀번호 일치");
            }

            // StudentBean 객체 생성
            StudentBean student = new StudentBean(stId, stName, stTel, stPw, 1);  // dmId는 임시 값

            // Test2Mgr 객체 생성 후 DB 수정
            Test2Mgr mgr = new Test2Mgr();
            mgr.updateStudentInfo(student);

            JOptionPane.showMessageDialog(frame, "회원정보가 수정되었습니다.");
        });
        
        frame.setVisible(true);
        
    }
}
