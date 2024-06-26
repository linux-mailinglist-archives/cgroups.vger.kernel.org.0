Return-Path: <cgroups+bounces-3375-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 821C6917CDB
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2024 11:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B424F1C22E1F
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2024 09:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6344016CD2D;
	Wed, 26 Jun 2024 09:47:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F13515F3E2;
	Wed, 26 Jun 2024 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719395263; cv=none; b=r2gcPjsxJiF875v2Te4xGz83HCpbfnBoOWlZh8+mlY8g1PkwVIyu6oungpFOn8TcJwgz2V9ONYRWVD2TaD2ySW+GO9XxmAfi/v7y/2o7tvviS2Ml8qfF1sWDnSoD3ZCjzoe56BkTQqUY1HXm+wxBaR5fZBZvvyFDHIMwNhnbiWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719395263; c=relaxed/simple;
	bh=PAhCxBgLcYR0QuNHwNTpftUmpwDzIpBMz2w/ct/55pQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iwXKMj4HQTRVMLVeO8ltvvo4hPAyoLEI4Nby+GxEixb1g5TEjbJBQ2ArP/pgRPM8BhqJnfyi0SjBOaRQ7eNu7PZ8xcr6UbcAWEjDloWoYAh/Mbil++UfyMZwR8vytX67Jka09QUJbnVSjm56MmmHrNHzGq3zsJRTY8obTJ46KSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W8GwN6MXdzxTTH;
	Wed, 26 Jun 2024 17:43:16 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id A1A35180086;
	Wed, 26 Jun 2024 17:47:36 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Wed, 26 Jun
 2024 17:47:36 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V3] cgroup/cpuset: Prevent UAF in proc_cpuset_show()
Date: Wed, 26 Jun 2024 09:41:01 +0000
Message-ID: <20240626094101.472912-1-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100013.china.huawei.com (7.221.188.163)

An UAF can happen when /proc/cpuset is read as reported in [1].

This can be reproduced by the following methods:
1.add an mdelay(1000) before acquiring the cgroup_lock In the
 cgroup_path_ns function.
2.$cat /proc/<pid>/cpuset   repeatly.
3.$mount -t cgroup -o cpuset cpuset /sys/fs/cgroup/cpuset/
$umount /sys/fs/cgroup/cpuset/   repeatly.

The race that cause this bug can be shown as below:

(umount)		|	(cat /proc/<pid>/cpuset)
css_release		|	proc_cpuset_show
css_release_work_fn	|	css = task_get_css(tsk, cpuset_cgrp_id);
css_free_rwork_fn	|	cgroup_path_ns(css->cgroup, ...);
cgroup_destroy_root	|	mutex_lock(&cgroup_mutex);
rebind_subsystems	|
cgroup_free_root 	|
			|	// cgrp was freed, UAF
			|	cgroup_path_ns_locked(cgrp,..);

When the cpuset is initialized, the root node top_cpuset.css.cgrp
will point to &cgrp_dfl_root.cgrp. In cgroup v1, the mount operation will
allocate cgroup_root, and top_cpuset.css.cgrp will point to the allocated
&cgroup_root.cgrp. When the umount operation is executed,
top_cpuset.css.cgrp will be rebound to &cgrp_dfl_root.cgrp.

The problem is that when rebinding to cgrp_dfl_root, there are cases
where the cgroup_root allocated by setting up the root for cgroup v1
is cached. This could lead to a Use-After-Free (UAF) if it is
subsequently freed. The descendant cgroups of cgroup v1 can only be
freed after the css is released. However, the css of the root will never
be released, yet the cgroup_root should be freed when it is unmounted.
This means that obtaining a reference to the css of the root does
not guarantee that css.cgrp->root will not be freed.

Fix this problem by using rcu_read_lock in proc_cpuset_show().
As cgroup root_list is already RCU-safe, css->cgroup is safe.
This is similar to commit 9067d90006df ("cgroup: Eliminate the
need for cgroup_mutex in proc_cgroup_show()")

[1] https://syzkaller.appspot.com/bug?extid=9b1ff7be974a403aa4cd

Fixes: a79a908fd2b0 ("cgroup: introduce cgroup namespaces")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index c12b9fdb22a4..7f4536c9ccce 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -21,6 +21,7 @@
  *  License.  See the file COPYING in the main directory of the Linux
  *  distribution for more details.
  */
+#include "cgroup-internal.h"
 
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
@@ -5052,8 +5053,15 @@ int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
 		goto out;
 
 	css = task_get_css(tsk, cpuset_cgrp_id);
-	retval = cgroup_path_ns(css->cgroup, buf, PATH_MAX,
-				current->nsproxy->cgroup_ns);
+	rcu_read_lock();
+	spin_lock_irq(&css_set_lock);
+	/* In case the root has already been unmounted */
+	if (css->cgroup)
+		retval = cgroup_path_ns_locked(css->cgroup, buf, PATH_MAX,
+					       current->nsproxy->cgroup_ns);
+
+	spin_unlock_irq(&css_set_lock);
+	rcu_read_unlock();
 	css_put(css);
 	if (retval == -E2BIG)
 		retval = -ENAMETOOLONG;
-- 
2.34.1


