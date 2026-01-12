Return-Path: <cgroups+bounces-13042-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABF1D1065B
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 03:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D928301FF55
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 02:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5067306496;
	Mon, 12 Jan 2026 02:57:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0302F1FFC;
	Mon, 12 Jan 2026 02:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768186671; cv=none; b=cXU08eSEDuuvioQcxS3zmFcRWq2NKkVzSCjBiCSuIDUzFOHma8YneqE0SDGkuQ6q0mIWZzovytYAUoC+PDiyzoszcMjQzy/mEVdFybZVFz8fysbkx2wLGB16gXPsMHgryI/tmXxmGCXApAwVQi2n+njOQt8NjFNmNwYA7hDenRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768186671; c=relaxed/simple;
	bh=0IlPd5a8IfYRl1FL2HoJFgTlPQNlNEORJ4Gj8Te0E/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KPG/fXFGzcVQGUcvsCPO+j6R/7qFo/Vv7ybHk2yWhHBK2ebJFu/OIttBYvhQKCn093N2A5JqHnliMW0VOLruw5qTkkxurWmPWIey1a6ba5T10+dr40h4o3jxnODl7f2YtxJpFU4gbc6lZxi7ZDc1LzYdWvhcs/H2LRRhSZqCVtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dqH8m44HtzKHMSf;
	Mon, 12 Jan 2026 10:56:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E21B740539;
	Mon, 12 Jan 2026 10:57:44 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgAniPgiY2RpYgX6DQ--.4124S2;
	Mon, 12 Jan 2026 10:57:44 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	lizefan.x@bytedance.com,
	tj@kernel.org,
	hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org,
	stable@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com
Subject: [PATCH] cpuset: Treat cpusets in attaching as populated
Date: Mon, 12 Jan 2026 02:42:57 +0000
Message-Id: <20260112024257.1073959-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260109112140.992393920@linuxfoundation.org>
References: <20260109112140.992393920@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAniPgiY2RpYgX6DQ--.4124S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4DJw1xXF48Kw1UXrW8Zwb_yoWrGryxpF
	WDua47Jw4UG3W7C393G3WIv34Fga1ktF1UJr1fKw1rJFy7JF1jkrn0v3Z0qFy3JF97C34f
	ZFsIvr4vg3ZFyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUr2-eDU
	UUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Ridong <chenridong@huawei.com>

[ Upstream commit b1bcaed1e39a9e0dfbe324a15d2ca4253deda316 ]

Currently, the check for whether a partition is populated does not
account for tasks in the cpuset of attaching. This is a corner case
that can leave a task stuck in a partition with no effective CPUs.

The race condition occurs as follows:

cpu0				cpu1
				//cpuset A  with cpu N
migrate task p to A
cpuset_can_attach
// with effective cpus
// check ok

// cpuset_mutex is not held	// clear cpuset.cpus.exclusive
				// making effective cpus empty
				update_exclusive_cpumask
				// tasks_nocpu_error check ok
				// empty effective cpus, partition valid
cpuset_attach
...
// task p stays in A, with non-effective cpus.

To fix this issue, this patch introduces cs_is_populated, which considers
tasks in the attaching cpuset. This new helper is used in validate_change
and partition_is_populated.

Fixes: e2d59900d936 ("cgroup/cpuset: Allow no-task partition to have empty cpuset.cpus.effective")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/cpuset.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index eadb028916c8..3c466e742751 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -453,6 +453,15 @@ static inline bool is_in_v2_mode(void)
 	      (cpuset_cgrp_subsys.root->flags & CGRP_ROOT_CPUSET_V2_MODE);
 }
 
+static inline bool cpuset_is_populated(struct cpuset *cs)
+{
+	lockdep_assert_held(&cpuset_mutex);
+
+	/* Cpusets in the process of attaching should be considered as populated */
+	return cgroup_is_populated(cs->css.cgroup) ||
+		cs->attach_in_progress;
+}
+
 /**
  * partition_is_populated - check if partition has tasks
  * @cs: partition root to be checked
@@ -465,21 +474,31 @@ static inline bool is_in_v2_mode(void)
 static inline bool partition_is_populated(struct cpuset *cs,
 					  struct cpuset *excluded_child)
 {
-	struct cgroup_subsys_state *css;
-	struct cpuset *child;
+	struct cpuset *cp;
+	struct cgroup_subsys_state *pos_css;
 
-	if (cs->css.cgroup->nr_populated_csets)
+	/*
+	 * We cannot call cs_is_populated(cs) directly, as
+	 * nr_populated_domain_children may include populated
+	 * csets from descendants that are partitions.
+	 */
+	if (cs->css.cgroup->nr_populated_csets ||
+	    cs->attach_in_progress)
 		return true;
 	if (!excluded_child && !cs->nr_subparts_cpus)
-		return cgroup_is_populated(cs->css.cgroup);
+		return cpuset_is_populated(cs);
 
 	rcu_read_lock();
-	cpuset_for_each_child(child, css, cs) {
-		if (child == excluded_child)
+	cpuset_for_each_descendant_pre(cp, pos_css, cs) {
+		if (cp == cs || cp == excluded_child)
 			continue;
-		if (is_partition_valid(child))
+
+		if (is_partition_valid(cp)) {
+			pos_css = css_rightmost_descendant(pos_css);
 			continue;
-		if (cgroup_is_populated(child->css.cgroup)) {
+		}
+
+		if (cpuset_is_populated(cp)) {
 			rcu_read_unlock();
 			return true;
 		}
@@ -751,7 +770,7 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 	 * be changed to have empty cpus_allowed or mems_allowed.
 	 */
 	ret = -ENOSPC;
-	if ((cgroup_is_populated(cur->css.cgroup) || cur->attach_in_progress)) {
+	if (cpuset_is_populated(cur)) {
 		if (!cpumask_empty(cur->cpus_allowed) &&
 		    cpumask_empty(trial->cpus_allowed))
 			goto out;
-- 
2.34.1


