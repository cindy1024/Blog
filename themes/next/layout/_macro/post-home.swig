{% macro render(post) %}



      <li class="post-home-listing-item">
      <time datetime="{{  date(post.date, config.date_format)  }}">{{  date(post.date, 'YYYY-MM-DD')  }}</time>
      <a href="{{  url_for(post.path)  }}" title="{{  post.title  }}">{{post.title}}</a>

      </li>
    





{#
    <div id="post-home-post-pagination" class="paginator">

  
      <span class="previous disabled">&lt;前页</span>
      <span class="current-page">1</span>
      <a href="/page2">2</a>
      <a class="next" href="/page2">后页&gt;</a>
      共{{}}篇
    </div>
#}


{% endmacro %}




