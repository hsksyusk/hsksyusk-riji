tags: python
---
# fabricをfabコマンドを使わずにライブラリとして使う

やりかたがわからずかなりハマったのでメモ。

executeを使うと吉。

例えばこんなfabfile.py

    #! /usr/bin/env python
    from fabric.api import run, env
    from fabric.tasks import execute
    
    def all_hosts():
        env.hosts=['host-a.jp','host-b.com']
    
    def hostname():
        run('hostname')
    
    if __name__ == '__main__':
        execute(all_hosts)
        execute(hostname,hosts=env.hosts)

直接実行すれば`fab all_hosts hostname`と同じ動きになる。

設定ファイルとして呼ばれるときは下3行は無視されるから、`fab -H host-c.net hostname`みたいにも使える。

via. (http://docs.fabfile.org/en/1.8/api/core/tasks.html#fabric.tasks.execute)
