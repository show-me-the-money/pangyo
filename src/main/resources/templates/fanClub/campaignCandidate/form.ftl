<#import "/macro/common.ftl" as common />

<html>
<head>
    <title>CampaignCandidate/Edit</title>
</head>
<body>
    <form>
    <#if campaignCandidate??>
         <div>
             <label for="id">id:</label>
             <input type="text" name="id" value="<#if campaignCandidate??>${campaignCandidate.id}</#if>" />
         </div>
        <div>
            <label for="status">status:</label>
            <input type="text" name="status" value="<#if campaignCandidate??>${campaignCandidate.status}</#if>"/>
        </div>
        <div>
            <label for="regDttm">regDttm:</label>
            <input type="text" name="reg" value="<#if campaignCandidate?? && campaignCandidate.dateTime ??>${campaignCandidate.dateTime.reg}</#if>" />
        </div>
        <div>
            <label for="upDttm">upDttm:</label>
            <input type="text" name="up" value="<#if campaignCandidate?? && campaignCandidate.dateTime ??>${campaignCandidate.dateTime.up}</#if>" />
        </div>
    </#if>
        <div>
            <label for="starId">starId:</label>
            <input type="text" name="star.id" value="<#if campaignCandidate??>${campaignCandidate.star.Id!}<#else>${starId!}</#if>"/>
        </div>
        <div>
            <label for="userId">userId:</label>
            <input type="text" name="user.id" value="<#if campaignCandidate??>${campaignCandidate.user.id!}</#if>"/>
        </div>
        <div>
            <label for="title">title:</label>
            <input type="text" name="title" value="<#if campaignCandidate??>${campaignCandidate.title!}</#if>" />
        </div>
        <div>
            <label for="body">body:</label>
            <input type="text" name="body" value="<#if campaignCandidate??>${campaignCandidate.body!}</#if>" />
        </div>
        <div>
            <label for="randingUrl">randingUrl:</label>
            <input type="text" name="randingUrl" value="<#if campaignCandidate??>${campaignCandidate.randingUrl!}</#if>" />
        </div>
        <div>
            <label for="bannerImg">bannerImg:</label>
            <input type="text" name="bannerImg" value="<#if campaignCandidate??>${campaignCandidate.bannerImg!}</#if>" />
        </div>
        <div>
            <label for="pollCount">pollCount:</label>
            <input type="text" name="pollCount" value="<#if campaignCandidate??>${campaignCandidate.pollCount}</#if>"/>
        </div>

        <div class="button">
            <button id="submitButton"><#if campaignCandidate??>수정<#else>등록</#if></button>
        </div>
    </form>

    <@common.importJS />

    <!-- 아 몰랑.. 나중에;; -->
    <script type="text/javascript">
        $(document).ready(function() {
            $('#submitButton').click(submit);
        });

        function submit() {
            var type = 'POST';
            <#if campaignCandidate??>
                type = 'PUT';
            </#if>

            var data = {
                <#if campaignCandidate??>
                    id: ${campaignCandidate.id!},
                </#if>
                star: {id:${star.id!}},
                user: {id:1},  // TODO : 실 USER 주입
                body: $('#body').val(),
                title: $('#title').val(),
                randingUrl: $('#randingUrl').val(),
                bannerImg: $('#bannerImg').val()
            };

            $.ajax({
                url : '/api/fanClub/'${starId}'/campaign-candidate',
                type : type,
                data : JSON.stringify(data),
                contentType : "application/json",
                success: function(result) {
                    // TODO : api 성공여부 확인
                    location.replace('/fanClub/${starId}/campaign-candidate');
                },
                error: function(res) {
                    console.log(res);
                    alert('글쓰기에 실패했습니다.');
                }
            });
        }
    </script>
</body>
</html>