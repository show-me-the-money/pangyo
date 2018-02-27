<#import "/macro/common.ftl" as common />

<html>
<head>
    <title>Posts</title>
</head>
<body>
    <h2><a href="/post/edit">등록하러 가기</a></h2>

    <div id="listSection">
        <#list postList as post>
            <div style="border: 1px solid; padding: 10px; width:400px">
                <div>
                    <img src="${post.user.profileImg!"http://t1.daumcdn.net/profile/TfdXX_AUCLw0"}"  style="width: 50px; height: 50px">
                    <strong>${post.user.name!"없는유저"}</strong>
                    <span>${post.dateTime.reg!}</span>
                </div>

                <p>${post.body!}</p>
                <#if post.img?has_content>
                    <img src="${post.img!}" style="width: 200px; height: 200px">
                </#if>

                <div>
                    <span>조회 ${post.viewCount!}</span>
                    <span>좋아요 ${post.likeCount!}</span>
                    <span>댓글 ${post.commentCount!}</span>
                    <a href="/post/${post.id!}">[더 보기]</a>
                </div>
            </div>
        </#list>
    </div>

    <script type="text/template" id="post-detail-template">
        <div id="postDetailSection" style="border: 1px solid; padding: 10px; width:400px">
            <div>
                <img src="<%= user.profileImg %>"  style="width: 50px; height: 50px">
                <strong><%= user.name %></strong>
                <span><%= dateTime.reg %></span>
            </div>

            <p><%= body %></p>
            <% if (img) { %>
                <img src="<%= img %>" style="width: 200px; height: 200px">
            <% } %>

            <div>
                <span>조회 <%= viewCount %></span>
                <span>좋아요 <%= likeCount %></span>
                <span>댓글 <%= commentCount %></span>
                <a href="/post/<%= id %>">[더 보기]</a>
            </div>
        </div>
    </script>

    <@common.importJS />

    <script type="text/javascript">
        $(document).ready(function() {
        });

        var postList = {
            lastId: null,

            appendItem: function() {
                postList.getData().then(function(data){
                    if(data.length == 0) {
                        return;
                    }

                    var template = _.template($("#post-detail-template").html());
                    data.forEach(function(e, i){
                        if (e.user.name == null)          e.user.name = '무명';
                        if (e.user.profileImg == null)    e.user.profileImg = 'http://t1.daumcdn.net/profile/TfdXX_AUCLw0';

                        $('#listSection').append(template(e));
                    });

                    postList.lastId = data[data.length-1].id;
                });
            },

            getData: function() {
                var data = {};
                if (postList.lastId != null) {
                    data.lastId = postList.lastId;
                }

                return $.ajax({
                    url : '/api/post',
                    data : data,
                    type : 'GET',
                    success: function(result) {
                        return result;
                    },
                    error: function(res) {
                        console.log(res);
                        return {};
                    }
                });
            }
        };

        // TODO : 더보기 구현
    </script>
</body>
</html>
