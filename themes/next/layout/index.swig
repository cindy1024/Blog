{% extends '_layout.swig' %}
{% import '_macro/post.swig' as post_template %}
{% import '_macro/post-home.swig' as post_home %}
{% import '_macro/sidebar.swig' as sidebar_template %}

{% block title %}{{ config.title }}{% if theme.index_with_subtitle and config.subtitle %} - {{config.subtitle }}{% endif %}{% endblock %}

{% block page_class %}
  {% if is_home() %}page-home{% endif -%}
{% endblock %}



{% block content %}
    <article class="post-home-content">
      <section class="post-home-post">
        <ul class="post-home-listing">
          {% for post in page.posts %}
            {{ post_home.render(post) }}
          {% endfor %}
        </ul>
      </section> 
    </article>
{#
  <section id="posts" class="posts-expand">
    {% for post in page.posts %}
      {{ post_template.render(post, true) }}
    {% endfor %}
  </section>
#}
  {% include '_partials/pagination.swig' %}
{% endblock %}

{% block sidebar %}
  {{ sidebar_template.render(false) }}
{% endblock %}