package com.bangbang;

import java.sql.*;
import java.util.Scanner;

public class BangBangRunClient {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/bangbang_run?useSSL=false&serverTimezone=Asia/Shanghai&characterEncoding=utf8";
    private static final String USER = "root";//输入自己的
    private static final String PASSWORD = "your_password";//输入自己的

    public static void main(String[] args) {
        System.out.println("=== 校园帮帮跑 - 业务管理系统 ===");
        try (Scanner scanner = new Scanner(System.in)) {
            while (true) {
                printMenu();
                String choice = scanner.nextLine().trim();
                switch (choice) {
                    case "1":
                        queryUser(scanner);
                        break;
                    case "2":
                        viewOrderHall();
                        break;
                    case "3":
                        viewRunnerRanking();
                        break;
                    case "4":
                        completeOrder(scanner);
                        break;
                    case "5":
                        acceptOrder(scanner);
                        break;
                    case "6":
                        System.out.println("程序退出，再见！");
                        return;
                    default:
                        System.out.println("无效输入，请重新选择。");
                }
            }
        } catch (Exception e) {
            System.out.println("程序发生未预料的异常: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static void printMenu() {
        System.out.println("\n请选择操作（输入数字编号）:");
        System.out.println("1. 查询用户信息（按学号或手机号）");
        System.out.println("2. 查看任务大厅（所有订单详情）");
        System.out.println("3. 查看接单员排行榜（业绩统计）");
        System.out.println("4. 完成订单并结算（调用存储过程）");
        System.out.println("5. 接单（调用存储过程）");      // 新增
        System.out.println("6. 退出");
        System.out.print("> ");
    }

    // 功能1：查询用户
    private static void queryUser(Scanner scanner) {
        System.out.print("请输入学号或手机号: ");
        String keyword = scanner.nextLine().trim();
        if (keyword.isEmpty()) {
            System.out.println("输入不能为空。");
            return;
        }

        String sql = "SELECT id, phone, student_id, name, avatar_url, register_time, account_status, is_runner, balance " +
                "FROM user WHERE student_id = ? OR phone = ?";

        try (Connection conn = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, keyword);
            pstmt.setString(2, keyword);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    System.out.println("\n查询结果：");
                    System.out.println("用户ID: " + rs.getLong("id"));
                    System.out.println("手机号: " + rs.getString("phone"));
                    System.out.println("学号: " + rs.getString("student_id"));
                    System.out.println("姓名: " + rs.getString("name"));
                    System.out.println("头像: " + rs.getString("avatar_url"));
                    System.out.println("注册时间: " + rs.getTimestamp("register_time"));
                    System.out.println("账号状态: " + (rs.getInt("account_status") == 1 ? "正常" : "禁用"));
                    System.out.println("是否接单员: " + (rs.getInt("is_runner") == 1 ? "是" : "否"));
                    System.out.println("账户余额: " + rs.getDouble("balance"));
                } else {
                    System.out.println("未找到匹配的用户。");
                }
            }
        } catch (SQLException e) {
            System.out.println("查询用户失败: " + e.getMessage());
        }
    }

    // 功能2：任务大厅
    private static void viewOrderHall() {
        String sql = "SELECT 订单编号, 任务描述, 悬赏金额, 订单状态, 截止时间, 发布者姓名, 接单员姓名, 评价评分 " +
                "FROM v_order_detail ORDER BY 发布时间 DESC LIMIT 20";

        try (Connection conn = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            System.out.println("\n【任务大厅】最新订单（最多20条）：");
            System.out.println("订单编号 | 任务描述 | 悬赏金额 | 状态 | 截止时间 | 发布者 | 接单员 | 评分");
            System.out.println("--------------------------------------------------------------------------------");

            boolean hasData = false;
            while (rs.next()) {
                hasData = true;
                System.out.printf("%-8d | %-12s | %-8.2f | %-6s | %-16s | %-6s | %-6s | %-4s%n",
                        rs.getInt("订单编号"),
                        truncate(rs.getString("任务描述"), 12),
                        rs.getDouble("悬赏金额"),
                        rs.getString("订单状态"),
                        rs.getTimestamp("截止时间").toString().substring(0, 16),
                        rs.getString("发布者姓名"),
                        rs.getString("接单员姓名") == null ? "无" : rs.getString("接单员姓名"),
                        rs.getDouble("评价评分") == 0 ? "-" : String.valueOf(rs.getDouble("评价评分"))
                );
            }
            if (!hasData) {
                System.out.println("当前暂无订单。");
            }
        } catch (SQLException e) {
            System.out.println("查询任务大厅失败: " + e.getMessage());
        }
    }

    // 功能3：接单员排行榜
    private static void viewRunnerRanking() {
        String sql = "SELECT runner_name, phone, avg_rating, wallet_balance, total_completed_orders, total_earnings " +
                "FROM v_runner_performance ORDER BY total_earnings DESC";

        try (Connection conn = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            System.out.println("\n【接单员排行榜】（按总收入降序）：");
            System.out.println("姓名 | 手机号 | 平均评分 | 钱包余额 | 完成订单数 | 总收入");
            System.out.println("------------------------------------------------------------");

            boolean hasData = false;
            while (rs.next()) {
                hasData = true;
                System.out.printf("%-8s | %-11s | %-8.1f | %-10.2f | %-10d | %-8.2f%n",
                        rs.getString("runner_name"),
                        rs.getString("phone"),
                        rs.getDouble("avg_rating"),
                        rs.getDouble("wallet_balance"),
                        rs.getInt("total_completed_orders"),
                        rs.getDouble("total_earnings")
                );
            }
            if (!hasData) {
                System.out.println("暂无已认证的接单员数据。");
            }
        } catch (SQLException e) {
            System.out.println("查询接单员排行榜失败: " + e.getMessage());
        }
    }

    // 功能4：完成订单（已有）
    private static void completeOrder(Scanner scanner) {
        System.out.print("请输入要完成的订单ID: ");
        String input = scanner.nextLine().trim();
        if (input.isEmpty()) {
            System.out.println("订单ID不能为空。");
            return;
        }
        long orderId;
        try {
            orderId = Long.parseLong(input);
        } catch (NumberFormatException e) {
            System.out.println("订单ID必须是数字。");
            return;
        }

        String callSql = "{call complete_order_and_settle_with_tx(?)}";

        try (Connection conn = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
             CallableStatement cstmt = conn.prepareCall(callSql)) {

            cstmt.setLong(1, orderId);
            cstmt.execute();

            System.out.println("订单 " + orderId + " 已完成，报酬已结算给接单员。");

        } catch (SQLException e) {
            System.out.println("订单完成失败: " + e.getMessage());
            if (e.getMessage().contains("尚未被接单")) {
                System.out.println("提示：该订单当前没有接单员，无法完成。");
            } else if (e.getMessage().contains("不是进行中")) {
                System.out.println("提示：该订单状态不是'进行中'，可能已完成或已取消。");
            }
        }
    }

    // ========== 功能5（新增）：接单 ==========
    private static void acceptOrder(Scanner scanner) {
        System.out.print("请输入要接的订单ID: ");
        String orderInput = scanner.nextLine().trim();
        if (orderInput.isEmpty()) {
            System.out.println("订单ID不能为空。");
            return;
        }
        long orderId;
        try {
            orderId = Long.parseLong(orderInput);
        } catch (NumberFormatException e) {
            System.out.println("订单ID必须是数字。");
            return;
        }

        System.out.print("请输入接单员ID: ");
        String runnerInput = scanner.nextLine().trim();
        if (runnerInput.isEmpty()) {
            System.out.println("接单员ID不能为空。");
            return;
        }
        long runnerId;
        try {
            runnerId = Long.parseLong(runnerInput);
        } catch (NumberFormatException e) {
            System.out.println("接单员ID必须是数字。");
            return;
        }

        // 调用存储过程：{call accept_order(?, ?, ?)}  第三参数是OUT输出
        String callSql = "{call accept_order(?, ?, ?)}";

        try (Connection conn = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
             CallableStatement cstmt = conn.prepareCall(callSql)) {

            // 设置IN参数
            cstmt.setLong(1, orderId);
            cstmt.setLong(2, runnerId);
            // 注册OUT参数（VARCHAR类型）
            cstmt.registerOutParameter(3, Types.VARCHAR);

            // 执行存储过程
            cstmt.execute();

            // 获取OUT参数中的结果信息
            String result = cstmt.getString(3);
            System.out.println("接单结果: " + result);

        } catch (SQLException e) {
            System.out.println("接单操作失败: " + e.getMessage());
        }
    }

    // 辅助工具：截断过长的字符串
    private static String truncate(String str, int maxLen) {
        if (str == null) return "null";
        if (str.length() <= maxLen) return str;
        return str.substring(0, maxLen - 3) + "...";
    }
}