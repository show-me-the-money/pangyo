<head>
</head>

<body>
    <button id="withdrawalBtn" onclick="logout()">
        진짜, 진짜로 탈퇴할껀가요? 다시한번만 생각해줘요ㅠㅠ
    </button>

    <script type="text/javascript">
        function logout() {
            $.ajax({
                url : '/api/member/withdrawal',
                type : 'GET',
                contentType : "application/json",
                success: function() {
                    alert('힝ㅠ 친구 손잡고 다시 와요!?');
                },
                error: function(res) {
                    console.log(res);
                    alert('일부러 그런건 아닙니다! 탈퇴 실패한 김에 한번 더 고민해 봐요!');
                }
            });
        }
    </script>
</body>
