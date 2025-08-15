Return-Path: <cgroups+bounces-9205-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBC1B27A00
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 09:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26BCD16825A
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 07:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6AF319866;
	Fri, 15 Aug 2025 07:20:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9421016CD33;
	Fri, 15 Aug 2025 07:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755242400; cv=none; b=SkHKZVgxKigfHo7Jk0X1WQIIecxcpVL/g3ok0LmAl+hcU8AQX0/xBH9o3vH8gh7gnZpPUFr7npnI7XkwN/EU3jdtmIqb51rl5dxGt/fFuamBuTomKNwJ8zzL0Fk5RlM9LrLAVOaaoQVkdC3Wi5c3vMUKFmqr5XeuPimHJGDg48A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755242400; c=relaxed/simple;
	bh=i9y0M6PJQuhMG/WWP0zJwScWVZ7i9otIXltFKi0rXic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q/TITlgzIxJ5GUISSuWZT4r4Q0JiEVxJpHtsy5yGiq1Ey5FhG4Fm8wPBY2441q38cV2PV6aDcvlVPf046T0LGk5yUozRNXcB/fX6z7qVeGS9fsYD+UOwJ5gJ7jkHfr6585z1+yDoRgOr73I39cDel18haCqHtCHpd54eO3cAs/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c3D5R0SWszKHLvc;
	Fri, 15 Aug 2025 15:19:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5DDB81A0CC1;
	Fri, 15 Aug 2025 15:19:54 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgA3ARKK355ovg_7Dg--.13866S2;
	Fri, 15 Aug 2025 15:19:52 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	lizefan@huawei.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com,
	hdanton@sina.com
Subject: [PATCH v3] cgroup: cgroup: drain specific subsystems when mounting/destroying a root
Date: Fri, 15 Aug 2025 07:05:18 +0000
Message-Id: <20250815070518.1255842-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3ARKK355ovg_7Dg--.13866S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar1DCry8XF48ArWfuw4xtFb_yoWxAF13pF
	4DCw1ayw4rKF1DK34kta40gFySga1vqw4UK34xJ348Ar17X34jq3WI9F17ZF1jyFsrCFy2
	yrZYvw1j9w1jyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

A hung task can occur during [1] LTP cgroup testing when repeatedly
mounting/unmounting perf_event and net_prio controllers with
systemd.unified_cgroup_hierarchy=1. The hang manifests in
cgroup_lock_and_drain_offline() during root destruction.

Related case:
cgroup_fj_function_perf_event cgroup_fj_function.sh perf_event
cgroup_fj_function_net_prio cgroup_fj_function.sh net_prio

Call Trace:
	cgroup_lock_and_drain_offline+0x14c/0x1e8
	cgroup_destroy_root+0x3c/0x2c0
	css_free_rwork_fn+0x248/0x338
	process_one_work+0x16c/0x3b8
	worker_thread+0x22c/0x3b0
	kthread+0xec/0x100
	ret_from_fork+0x10/0x20

Root Cause:

CPU0                            CPU1
mount perf_event                umount net_prio
cgroup1_get_tree                cgroup_kill_sb
rebind_subsystems               // root destruction enqueues
				// cgroup_destroy_wq
// kill all perf_event css
                                // one perf_event css A is dying
                                // css A offline enqueues cgroup_destroy_wq
                                // root destruction will be executed first
                                css_free_rwork_fn
                                cgroup_destroy_root
                                cgroup_lock_and_drain_offline
                                // some perf descendants are dying
                                // cgroup_destroy_wq max_active = 1
                                // waiting for css A to die

Problem scenario:
1. CPU0 mounts perf_event (rebind_subsystems)
2. CPU1 unmounts net_prio (cgroup_kill_sb), queuing root destruction work
3. A dying perf_event CSS gets queued for offline after root destruction
4. Root destruction waits for offline completion, but offline work is
   blocked behind root destruction in cgroup_destroy_wq (max_active=1)

Solution:
Introduce ss_mask for cgroup_lock_and_drain_offline() to selectively drain
specific subsystems rather than all subsystems.

There are two primary scenarios requiring offline draining:
1. Root Operations - Draining all subsystems in cgrp_dfl_root when mounting
   or destroying a cgroup root
2. Draining specific cgroup when modifying cgroup.subtree_control or
   cgroup.threads

For case 1 (Root Operations), it only need to drain the specific subsystem
being mounted/destroyed, not all subsystems. The rationale for draining
cgrp_dfl_root is explained in [2].

For case 2, it's enough to drain subsystems enabled in the cgroup. Since
other subsystems cannot have descendants in this cgroup, adding ss_mask
should not have a hurt.

[1] https://github.com/linux-test-project/ltp/blob/master/runtest/controllers
[2] https://lore.kernel.org/cgroups/39e05402-40c7-4631-a87b-8e3747ceddc6@huaweicloud.com/T/#t
Fixes: 334c3679ec4b ("cgroup: reimplement rebind_subsystems() using cgroup_apply_control() and friends")
Reported-by: Gao Yingjie <gaoyingjie@uniontech.com>
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---

v2->v3: add ss_mask for cgroup_lock_and_drain_offline to fix this issue.

v2: https://lore.kernel.org/cgroups/20250815024020.4579-1-hdanton@sina.com/T/#t

 kernel/cgroup/cgroup-internal.h |  2 +-
 kernel/cgroup/cgroup-v1.c       |  4 ++--
 kernel/cgroup/cgroup.c          | 11 ++++++++---
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index b14e61c64a34..3c7443d8b3b7 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -257,7 +257,7 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 void cgroup_procs_write_finish(struct task_struct *task, bool locked)
 	__releases(&cgroup_threadgroup_rwsem);
 
-void cgroup_lock_and_drain_offline(struct cgroup *cgrp);
+void cgroup_lock_and_drain_offline(struct cgroup *cgrp, u16 ss_mask);
 
 int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode);
 int cgroup_rmdir(struct kernfs_node *kn);
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 2a4a387f867a..1be439c62fbe 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -1096,7 +1096,7 @@ int cgroup1_reconfigure(struct fs_context *fc)
 	int ret = 0;
 	u16 added_mask, removed_mask;
 
-	cgroup_lock_and_drain_offline(&cgrp_dfl_root.cgrp);
+	cgroup_lock_and_drain_offline(&cgrp_dfl_root.cgrp, root->subsys_mask);
 
 	/* See what subsystems are wanted */
 	ret = check_cgroupfs_options(fc);
@@ -1261,7 +1261,7 @@ int cgroup1_get_tree(struct fs_context *fc)
 	if (!ns_capable(ctx->ns->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
-	cgroup_lock_and_drain_offline(&cgrp_dfl_root.cgrp);
+	cgroup_lock_and_drain_offline(&cgrp_dfl_root.cgrp, ctx->subsys_mask);
 
 	ret = cgroup1_root_to_use(fc);
 	if (!ret && !percpu_ref_tryget_live(&ctx->root->cgrp.self.refcnt))
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index d8b82afed181..c76c23186fd3 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1346,7 +1346,7 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 
 	trace_cgroup_destroy_root(root);
 
-	cgroup_lock_and_drain_offline(&cgrp_dfl_root.cgrp);
+	cgroup_lock_and_drain_offline(&cgrp_dfl_root.cgrp, root->subsys_mask);
 
 	BUG_ON(atomic_read(&root->nr_cgrps));
 	BUG_ON(!list_empty(&cgrp->self.children));
@@ -1681,7 +1681,7 @@ struct cgroup *cgroup_kn_lock_live(struct kernfs_node *kn, bool drain_offline)
 	kernfs_break_active_protection(kn);
 
 	if (drain_offline)
-		cgroup_lock_and_drain_offline(cgrp);
+		cgroup_lock_and_drain_offline(cgrp, cgrp->subtree_ss_mask);
 	else
 		cgroup_lock();
 
@@ -3147,12 +3147,14 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
 /**
  * cgroup_lock_and_drain_offline - lock cgroup_mutex and drain offlined csses
  * @cgrp: root of the target subtree
+ * @ss_mask: bitmask of subsystem to be drained
  *
  * Because css offlining is asynchronous, userland may try to re-enable a
  * controller while the previous css is still around.  This function grabs
  * cgroup_mutex and drains the previous css instances of @cgrp's subtree.
  */
-void cgroup_lock_and_drain_offline(struct cgroup *cgrp)
+
+void cgroup_lock_and_drain_offline(struct cgroup *cgrp, u16 ss_mask)
 	__acquires(&cgroup_mutex)
 {
 	struct cgroup *dsct;
@@ -3168,6 +3170,9 @@ void cgroup_lock_and_drain_offline(struct cgroup *cgrp)
 			struct cgroup_subsys_state *css = cgroup_css(dsct, ss);
 			DEFINE_WAIT(wait);
 
+			if (!(ss_mask & 1U << ssid))
+				continue;
+
 			if (!css || !percpu_ref_is_dying(&css->refcnt))
 				continue;
 
-- 
2.34.1


