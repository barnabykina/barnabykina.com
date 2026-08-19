---
title: F1's Win-Contributing Factors ft. Machine Learning
description: A short summary.
date: 2026-05-20
featured: True
---

Details coming soon...

{::nomarkdown}
{% assign jupyter_path = 'assets/jupyter/formula1-ml.ipynb' | relative_url %}
{% capture notebook_exists %}{% file_exists assets/jupyter/formula1-ml.ipynb %}{% endcapture %}
{% if notebook_exists == 'true' %}
    {% jupyter_notebook jupyter_path %}
{% else %}
    <p>Sorry, the notebook you are looking for does not exist.<p>
{% endif %}
{:/nomarkdown}
