Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBDA149A35
	for <lists+cgroups@lfdr.de>; Sun, 26 Jan 2020 11:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgAZKqP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 26 Jan 2020 05:46:15 -0500
Received: from relay.sw.ru ([185.231.240.75]:37994 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729353AbgAZKqP (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 26 Jan 2020 05:46:15 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1ivfQg-0007UW-68; Sun, 26 Jan 2020 13:46:11 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] __cgroup_procs_start cleanup
To:     cgroups@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Message-ID: <029e25db-1176-3d45-4384-5c06e92ac130@virtuozzo.com>
Date:   Sun, 26 Jan 2020 13:46:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

__cgroup_procs_start() makes an extra cgroup_procs_next() call and skip current entry

[test@localhost ~]$ dd if=/sys/fs/cgroup/cgroup.procs bs=8 count=1
2
3
4
5
1+0 records in
1+0 records out
8 bytes copied, 0,000267297 s, 29,9 kB/s
[test@localhost ~]$ dd if=/sys/fs/cgroup/cgroup.procs bs=1 count=8
2
4 <<< NB! 3 was skipped
6 <<<    ... and 5 too
8 <<<    ... and 7 
8+0 records in
8+0 records out
8 bytes copied, 5,2123e-05 s, 153 kB/s
[test@localhost ~]$ mount | grep cgroup
cgroup2 on /sys/fs/cgroup type cgroup2 (rw,nosuid,nodev,noexec,relatime,seclabel,nsdelegate)
[test@localhost ~]$ uname -a
Linux localhost.localdomain 5.4.7-200.fc31.x86_64 #1 SMP Tue Dec 31 22:25:12 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 kernel/cgroup/cgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 8361eac..f79ec3b 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4628,7 +4628,8 @@ static void *__cgroup_procs_start(struct seq_file *s, loff_t *pos,
 	} else if (!(*pos)++) {
 		css_task_iter_end(it);
 		css_task_iter_start(&cgrp->self, iter_flags, it);
-	}
+	} else
+		return it->cur_task;
 
 	return cgroup_procs_next(s, NULL, NULL);
 }
-- 
1.8.3.1

