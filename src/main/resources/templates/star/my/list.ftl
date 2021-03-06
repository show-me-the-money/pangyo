<head>
    <style>
        table {
            width: 400px;
            border: 1px solid;
            border-collapse: collapse;
        }
        th, td {
            border-bottom: 1px solid;
            padding: 10px;
        }
    </style>
</head>

<body>
    <h2>MY STAR</h2>
    <table id="listSection">
        <#list myStarFeed.list as myStar>
            <#if myStar??>
                <tr>
                    <td>
                        <h2>${myStar.ranking!}</h2>
                    </td>
                    <td>
                        <h3><a href="/fanClub/${myStar.content.id!}">${myStar.content.name!}</a></h3>
                        <span>${myStar.content.fanCount!}fans</span>
                    </td>
                    <td style="text-align: center">
                        <img src="${myStar.content.profileImg!}" style="max-height:100px;">
                    </td>
                </tr>
            </div>
            </#if>
        </#list>
    </table>

    <div id="endOfListSection"></div>

    <script type="text/template" id="star-list-template">
        <tr>
            <td>
                <h2><%= ranking %></h2>
            </td>
            <td>
                <h3><a href="/fanClub/<%= content.id %>"><%= content.name %></a></h3>
                <span><%= content.fanCount %>fans</span>
            </td>
            <td style="text-align: center">
                <img src="<%= data.profileImg %>" style="max-height: 100px">
            </td>
        </tr>
    </script>

    <script src="/js/jquery.visible.js"></script>

    <script type="text/javascript">
        var starList = {
            lastId: ${myStarFeed.lastId!},
            hasMore: ${myStarFeed.hasMore!?string},
            isLoading: false,

            appendItem: function() {
                starList.isLoading = true;
                starList.getData().then(function(data){
                    if(data.list == null || data.list.length == 0) {
                        return;
                    }

                    var template = _.template($("#star-list-template").html());
                    data.list.forEach(function(e, i){
                        $('#listSection').append(template(e));
                    });

                    starList.lastId = data.lastId;
                    starList.hasMore = data.hasMore;
                    starList.isLoading = false;
                });
            },

            getData: function() {
                var data = {};
                if (starList.lastId != null) {
                    data.rankId = starList.lastId;
                }

                return $.ajax({
                    url : '/api/star/me',
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

        $(document).ready(function() {
            $(window).scroll(function(e) {
                if ($("#endOfListSection").visible(true) && starList.hasMore && !starList.isLoading) {
                    starList.appendItem();
                }
            });
        });
    </script>
</body>
