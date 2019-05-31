{% extends '_layout.swig' %}
{% import '_macro/post-collapse.swig' as post_template %}
{% import '_macro/sidebar.swig' as sidebar_template %}

{% block title %}{{ __('title.links') }} | {{ title }}{% endblock %}

{% block content %}

  {#################}
  {### links BLOCK ###}
  {#################}
  <div class="post-block links">

    <div id="posts" class="posts-collapse">
      {% for post in page.posts %}
        {{ post_template.render(post) }}
      {% endfor %}
    </div>
    还没有放链接
  </div>
  {#####################}
  {### END links BLOCK ###}
  {#####################}

  {% include '_partials/pagination.swig' %}

{% endblock %}

{% block sidebar %}
  {{ sidebar_template.render(false) }}
{% endblock %}
