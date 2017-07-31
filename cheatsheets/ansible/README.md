# init

ansible all -u ubuntu -a "/bin/echo hello"
ansible-playbook -u ubuntu playbook.yml

  - name: install an apple
      command: "{{item}}"
      with_items:
      - echo "hello" > cool.txt
      - cp cool.txt cool2.txt
      - rm cool2.txt


          - name: Rename.
      shell: cp cool.txt cool2.txt
      args:
        creates: cool2.txt

         - name: Remove.
      shell: rm cool2.txt