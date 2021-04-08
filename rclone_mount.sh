# meant to be run on lab computer, not h2
# need to set hoffman2 as a remote with rclone config -> sftp

fusermount -uz /home/tev/project-ernst/raw_almonds
rclone mount --vfs-cache-mode full --poll-interval 30s --vfs-cache-poll-interval 30s hoffman2:raw_almonds /home/tev/project-ernst/raw_almonds
fusermount -u /home/tev/project-ernst/raw_almonds
