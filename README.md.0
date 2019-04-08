## 目录结构

    roles/
    └── app
        ├── default
        ├── files
        ├── handlers
        ├── tasks
        │   ├── cp_kubelet.yml
        │   ├── install_gcc.yml
        │   ├── main.yml
        │   ├── start.yml
        │   └── update_time.yml
        ├── template
        │   └── kubelet.j2
        └── vars
            └── main.yml

# 任务执行必须在roles同级目录下,执行检查语法命令.  
ansible-playbook -C main.yml  
# 如果成功就执行  
ansible-playbook -i hosts main.yml
