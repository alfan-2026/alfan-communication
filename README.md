# alfan-communication-25
Package ini berisikan program untuk komunikasi antar-robot melalui <i>Data Distribution System</i> dari ROS2. Kedua robot perlu dalam satu jaringan (Wi-Fi) yang sama, serta memiliki ROS_DOMAIN_ID yang sama untuk dapat mengakses <i>node</i> satu sama lain.

<b>Langkah instalasi:</b>
1. Clone repository ini ke dalam <i>directory <b>src</b></i> pada workspace-mu! (jalankan terminal '<b><i>git clone [link git repository]</i></b>' di dalam <i>{nama_workspace}/src/</i>).
2. Jika berhasil, maka akan muncul folder baru di dalam <i>{workspace}/src/</i> yaitu program ini sendiri.
3. Buka terminal lalu kembali ke <i>root</i> dari <i>workspace</i>-mu (bisa menggunakan perintah '<i><b>cd ..</b></i>' sehingga terminal akan berada di <i>root workspace</i>)
4. Build package ini dengan menjalankan perintah '<i><b>colcon build --packages-select alfan_communication</b></i>'
5. Jika sudah, jalankan perintah '<i><b>source install/setup.bash</b></i>'
6. Program ini dapat dijalankan dengan menggunakan perintah <b><i>'ros2 run alfan_communication service'</i></b>

<b>Note:</b>
- Variabel THIS_ROBOT_NAME merujuk pada nama robot itu sendiri
- Variabel OTHER_ROBOT_NAME merujuk pada nama robot lainnya
- Kedua variabel tersebut digunakan untuk mempermudah komunikasi melalui DDS node-topic-service ROS2
- Pastikan bahwa kedua robot memiliki ROS_DOMAIN_ID yang sama
- Pastikan juga bahwa ROS_LOCALHOST_ONLY di-set menjadi 0 agar tidak terbatas pada Local Host saja
