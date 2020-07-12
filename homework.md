---
layout: page
title: Homework
permalink: /homework/
---

Clicking the title of the homework will open the assignment pdf in a new tab.

<i class="fab fa-github"></i> = Github directory for homework; <i class="fab fa-r-project"></i> = source Rmarkdown document for homework. 


<ul id="archive">
{% for homework in site.data.homework %}
      <li class="archiveposturl">
        <span><a href="{{ site.url }}{{ site.baseurl }}/homework/{{ homework.dirname }}/{{ homework.filename }}.pdf" target="_blank">{{ homework.title }}</a></span><br>
<span class = "postlower">
<strong>due date:</strong> {{ homework.due }}</span>
<strong style="font-size:100%; font-family: 'Titillium Web', sans-serif; float:right; padding-right: .5em">
	<a href="https://github.com/{{ site.githubdir}}/tree/master/homework/{{ homework.dirname }}"><i class="fab fa-github"></i></a>&nbsp;&nbsp;
<a href="https://github.com/{{ site.githubdir}}/tree/master/homework/{{ homework.dirname }}/{{ homework.filename}}.Rmd"><i class="fab fa-r-project"></i></a>
</strong> 
      </li>
{% endfor %}
</ul>
