Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E542514D919
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2020 11:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgA3KfL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Jan 2020 05:35:11 -0500
Received: from relay.sw.ru ([185.231.240.75]:50302 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbgA3KfL (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 30 Jan 2020 05:35:11 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1ix7A3-000461-Ip; Thu, 30 Jan 2020 13:34:59 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2 2/2 RESEND] cgroup: cgroup_procs_next should increase
 position index
To:     cgroups@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20200128172737.GA21791@blackbody.suse.cz>
Message-ID: <821bde4f-bdaf-994c-d864-a8a97d7d6b13@virtuozzo.com>
Date:   Thu, 30 Jan 2020 13:34:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200128172737.GA21791@blackbody.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

If seq_file .next fuction does not change position index,
read after some lseek can generate unexpected output:

1) dd bs=1 skip output of each 2nd elements
$ dd if=/sys/fs/cgroup/cgroup.procs bs=8 count=1
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

 This happen because __cgroup_procs_start() makes an extra
 extra cgroup_procs_next() call

2) read after lseek beyond end of file generates whole last line.
3) read after lseek into middle of last line generates
expected rest of last line and unexpected whole line once again.

Additionally patch removes an extra position index changes in
__cgroup_procs_start()

Cc: stable@vger.kernel.org
https://bugzilla.kernel.org/show_bug.cgi?id=206283
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 kernel/cgroup/cgroup.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 735af8f..9d06eb5 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4599,6 +4599,9 @@ static void *cgroup_procs_next(struct seq_file *s, void *v, loff_t *pos)
 	struct kernfs_open_file *of = s->private;
 	struct css_task_iter *it = of->priv;
 
+	if (pos)
+		(*pos)++;
+
 	return css_task_iter_next(it);
 }
 
@@ -4614,7 +4617,7 @@ static void *__cgroup_procs_start(struct seq_file *s, loff_t *pos,
 	 * from position 0, so we can simply keep iterating on !0 *pos.
 	 */
 	if (!it) {
-		if (WARN_ON_ONCE((*pos)++))
+		if (WARN_ON_ONCE((*pos)))
 			return ERR_PTR(-EINVAL);
 
 		it = kzalloc(sizeof(*it), GFP_KERNEL);
@@ -4622,10 +4625,11 @@ static void *__cgroup_procs_start(struct seq_file *s, loff_t *pos,
 			return ERR_PTR(-ENOMEM);
 		of->priv = it;
 		css_task_iter_start(&cgrp->self, iter_flags, it);
-	} else if (!(*pos)++) {
+	} else if (!(*pos)) {
 		css_task_iter_end(it);
 		css_task_iter_start(&cgrp->self, iter_flags, it);
-	}
+	} else
+		return it->cur_task;
 
 	return cgroup_procs_next(s, NULL, NULL);
 }
-- 
1.8.3.1

