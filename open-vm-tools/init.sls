{% from "open-vm-tools/patch-map.jinja" import patch with context %}
{% set osrelease = salt['grains.get']('osrelease') %}

open-vm-tools:
  pkg:
    - installed

  service:
    - name: open-vm-tools
    - running
    - enable: True
    - watch:
      - pkg: open-vm-tools

{% if 'required' in patch and patch['required'] %}
    - require:
      - file: /etc/init.d/open-vm-tools

/etc/init.d/open-vm-tools:
  file.patch:
    - source: salt://open-vm-tools/files/{{ patch['patchfile'] }}
    - hash: {{ patch['hash' ~ osrelease] }}
{% endif %}
