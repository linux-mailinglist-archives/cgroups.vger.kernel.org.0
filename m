Return-Path: <cgroups+bounces-3279-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 916BC913373
	for <lists+cgroups@lfdr.de>; Sat, 22 Jun 2024 13:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB7F1F22D78
	for <lists+cgroups@lfdr.de>; Sat, 22 Jun 2024 11:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D8E155A34;
	Sat, 22 Jun 2024 11:44:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E9615382E;
	Sat, 22 Jun 2024 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719056697; cv=none; b=pkVkjN6u9B3uqU6CIsgcju1T4xowVROj4+vSOKOKM1Zf80kE64e6EwHNoZLAXZkH+HiceAjUsC30zY3PUp/fa/YemA1rVE7ZVT8zLdX/GOCQwwQqSZQCLc/isFPZULPFzP+YYRwpo/jyQBxWXt8UIe/yfYqQ6VVn0qvUAEjiA7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719056697; c=relaxed/simple;
	bh=Y7ZpAfhDTUE6U93lIBNlr/+c6AoW+cOzf76hzYC8mwI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HL9OPbQRQJtI7Is4wa5it8BvF2oDk1kYTYeMt3DVXgN5z4S6H+wONxGVP6rnM0DQUEQ2VsltoXorWFXXp/O7ietQeBfgT/y8h7Gzo6CSCla+JCCDVv1WAd1qCjVbqjswZHGlBs8msnYb0mHYImyDeNQg62IKxIOOK7W0qsjSbH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W5sjV4QPNzxSXn;
	Sat, 22 Jun 2024 19:40:30 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 11ED818007E;
	Sat, 22 Jun 2024 19:44:46 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Sat, 22 Jun
 2024 19:44:45 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>
CC: <bpf@vger.kernel.org>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next] cgroup: fix uaf when proc_cpuset_show
Date: Sat, 22 Jun 2024 11:38:14 +0000
Message-ID: <20240622113814.120907-1-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd100013.china.huawei.com (7.221.188.163)

We found a refcount UAF bug as follows:

BUG: KASAN: use-after-free in cgroup_path_ns+0x112/0x150
Read of size 8 at addr ffff8882a4b242b8 by task atop/19903

CPU: 27 PID: 19903 Comm: atop Kdump: loaded Tainted: GF
Call Trace:
 dump_stack+0x7d/0xa7
 print_address_description.constprop.0+0x19/0x170
 ? cgroup_path_ns+0x112/0x150
 __kasan_report.cold+0x6c/0x84
 ? print_unreferenced+0x390/0x3b0
 ? cgroup_path_ns+0x112/0x150
 kasan_report+0x3a/0x50
 cgroup_path_ns+0x112/0x150
 proc_cpuset_show+0x164/0x530
 proc_single_show+0x10f/0x1c0
 seq_read_iter+0x405/0x1020
 ? aa_path_link+0x2e0/0x2e0
 seq_read+0x324/0x500
 ? seq_read_iter+0x1020/0x1020
 ? common_file_perm+0x2a1/0x4a0
 ? fsnotify_unmount_inodes+0x380/0x380
 ? bpf_lsm_file_permission_wrapper+0xa/0x30
 ? security_file_permission+0x53/0x460
 vfs_read+0x122/0x420
 ksys_read+0xed/0x1c0
 ? __ia32_sys_pwrite64+0x1e0/0x1e0
 ? __audit_syscall_exit+0x741/0xa70
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x67/0xcc

This is also reported by: https://syzkaller.appspot.com/bug?extid=9b1ff7be974a403aa4cd

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

To solve this issue, we have added a cgroup reference count in
the proc_cpuset_show function to ensure that css.cgrp->root will not
be freed prematurely. This is a temporary solution. Let's see if anyone
has a better solution.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index c12b9fdb22a4..782eaf807173 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -5045,6 +5045,7 @@ int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
 	char *buf;
 	struct cgroup_subsys_state *css;
 	int retval;
+	struct cgroup *root_cgroup = NULL;
 
 	retval = -ENOMEM;
 	buf = kmalloc(PATH_MAX, GFP_KERNEL);
@@ -5052,9 +5053,28 @@ int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
 		goto out;
 
 	css = task_get_css(tsk, cpuset_cgrp_id);
+	rcu_read_lock();
+	/*
+	 * When the cpuset subsystem is mounted on the legacy hierarchy,
+	 * the top_cpuset.css->cgroup does not hold a reference count of
+	 * cgroup_root.cgroup. This makes accessing css->cgroup very
+	 * dangerous because when the cpuset subsystem is remounted to the
+	 * default hierarchy, the cgroup_root.cgroup that css->cgroup points
+	 * to will be released, leading to a UAF issue. To avoid this problem,
+	 * get the reference count of top_cpuset.css->cgroup first.
+	 *
+	 * This is ugly!!
+	 */
+	if (css == &top_cpuset.css) {
+		cgroup_get(css->cgroup);
+		root_cgroup = css->cgroup;
+	}
+	rcu_read_unlock();
 	retval = cgroup_path_ns(css->cgroup, buf, PATH_MAX,
 				current->nsproxy->cgroup_ns);
 	css_put(css);
+	if (root_cgroup)
+		cgroup_put(root_cgroup);
 	if (retval == -E2BIG)
 		retval = -ENAMETOOLONG;
 	if (retval < 0)
-- 
2.34.1


