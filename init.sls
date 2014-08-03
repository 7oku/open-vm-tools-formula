{% from "open-vm-tools/patch-map.jinja" import patch with context %}

open-vm-tools:
  pkg:
    - installed

  service:
    - name: open-vm-tools
    - running
    - enable: True
    - reload: True
    - watch:
      - pkg: open-vm-tools

{% if 'required' in patch and patch['required'] %}
    - require:
      - file: /etc/init.d/open-vm-tools

/etc/init.d/open-vm-tools:
  file.patch:
    - source: salt://open-vm-tools/files/open-vm-tools.patch
    - hash: {{ patch['hash'] }}
{% endif %}
