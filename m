Return-Path: <cgroups+bounces-11812-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E230DC4E364
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 14:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0441881F10
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 13:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646AC34251F;
	Tue, 11 Nov 2025 13:41:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049B034250E;
	Tue, 11 Nov 2025 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868494; cv=none; b=ne6M+HwnJKKqKOwyf3Zh2bmAvvmiIbG+vVCxhYO5pH42WlhqBTJhs+gGpo6UbQBN9PO8C6RPtdECaMcLi06tDN9R751XITQDTgclI+V9WXcDJ0t/0kB1kQ0sZJGQlikJltFmGp9dFcmKQT+TVjWjn58yCTYzPUXy4AbeatfRfNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868494; c=relaxed/simple;
	bh=AbvKSx7vC67OhF/7i/zPtL9E2fBqY+7RtT5lCcWX8Eo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=roaqmqlnGs2zDr4MaFNWl7+6hDIWcFXO1NFbHDFg6pAUir6cslHU91O6i9TVb9JV0DiYA4pBBXtO7CZSOvpGRtZCP+uBlA3+RiMThmrAXK9nPRp4xPY99QnYjj32nr/e03w5sRMitlAtjLbKQHhBCVZf7a68ER8XE/zAreOu4SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d5SNZ6VzrzYQtpK;
	Tue, 11 Nov 2025 21:41:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B62B11A192A;
	Tue, 11 Nov 2025 21:41:29 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgB3oF3_PBNpieeFAQ--.15547S2;
	Tue, 11 Nov 2025 21:41:29 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH next] cpuset: Treat tasks in attaching process as populated
Date: Tue, 11 Nov 2025 13:26:32 +0000
Message-Id: <20251111132632.950430-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3oF3_PBNpieeFAQ--.15547S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1fuF1UWFWUXFyxZF1UKFg_yoW5Xry3pF
	WDuay7JayYg3W7C393Gayxu34Fgw1ktF17Jrn8Kw1rXFy7J3Wjkr1qvas8tFy3XF97C34f
	ZFs8Zr40g3ZFyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbiF4tUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Currently, the check for whether a partition is populated does not
account for tasks in the process of attaching. This is a corner case
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
tasks in the attaching process. This new helper is used in validate_change
and partition_is_populated.

Fixes: e2d59900d936 ("cgroup/cpuset: Allow no-task partition to have empty cpuset.cpus.effective")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index daf813386260..3ffa0c02a020 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -356,6 +356,13 @@ static inline bool is_in_v2_mode(void)
 	      (cpuset_cgrp_subsys.root->flags & CGRP_ROOT_CPUSET_V2_MODE);
 }
 
+static inline bool cs_is_populated(struct cpuset *cs)
+{
+	/* Tasks in the process of attaching should be considered as populated */
+	return cgroup_is_populated(cs->css.cgroup) ||
+		cs->attach_in_progress;
+}
+
 /**
  * partition_is_populated - check if partition has tasks
  * @cs: partition root to be checked
@@ -376,7 +383,8 @@ static inline bool partition_is_populated(struct cpuset *cs,
 	struct cgroup_subsys_state *css;
 	struct cpuset *child;
 
-	if (cs->css.cgroup->nr_populated_csets)
+	if (cs->css.cgroup->nr_populated_csets ||
+	    cs->attach_in_progress)
 		return true;
 
 	rcu_read_lock();
@@ -385,7 +393,7 @@ static inline bool partition_is_populated(struct cpuset *cs,
 			continue;
 		if (is_partition_valid(child))
 			continue;
-		if (cgroup_is_populated(child->css.cgroup)) {
+		if (cs_is_populated(child)) {
 			rcu_read_unlock();
 			return true;
 		}
@@ -670,7 +678,7 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 	 * be changed to have empty cpus_allowed or mems_allowed.
 	 */
 	ret = -ENOSPC;
-	if ((cgroup_is_populated(cur->css.cgroup) || cur->attach_in_progress)) {
+	if (cs_is_populated(cur)) {
 		if (!cpumask_empty(cur->cpus_allowed) &&
 		    cpumask_empty(trial->cpus_allowed))
 			goto out;
-- 
2.34.1


