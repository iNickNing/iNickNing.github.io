{% extends '_layout.swig' %}
{% import '_macro/post-collapse.swig' as post_template %}
{% import '_macro/sidebar.swig' as sidebar_template %}

{% block title %}{{ __('title.links') }} | {{ title }}{% endblock %}

{% block content %}

  {#################}
  {### links BLOCK ###}
  {#################}
  <div class="post-block links">


    <div id="posts" class="posts-expand">
      <div class="post-block page">
        <header class="post-header">
          <h1 class="post-title" itemprop="name headline">{{ __('title.links') }}</h1>
        </header>
      </div>
    </div>

    <div class="links-box">
        <ul class="links">
          {% for link in site.data.links.links_list %}

            <li>
              <a href="{{ link.url }}" target="_blank">
                <img src="{{ link.img }}" alt="">
                <span>{{ link.title }}</span>
              </a>
            </li>

          {% endfor %}
        </ul>
      </div>

      <div class="note">
        <p>下面是怎么申请友链:</p>
        <p>发送邮件到: <a target="_blank" href="mailto:inickning@outlook.com">inickning@outlook.com</a></p>
        <p>格式如下(信件主题:友链互换):</p>
        <ul class="links-format">
          <li>名称：xxx</li>
          <li>网站：xxx.xxx</li>
          <li>头像：图片地址</li>
          <li>邮箱：xxx@xx.xx</li>
        </ul>
      </div>

  </div>
  {#####################}
  {### END links BLOCK ###}
  {#####################}

  {% include '_partials/pagination.swig' %}

{% endblock %}

{% block sidebar %}
  {{ sidebar_template.render(false) }}
{% endblock %}
