Return-Path: <cgroups+bounces-11703-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BC0C44C17
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 03:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371413AFE0A
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 02:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D17B23B607;
	Mon, 10 Nov 2025 02:07:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB8C34D395;
	Mon, 10 Nov 2025 02:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762740463; cv=none; b=T5lDzCUDaStOCt95Ss3l9u5qIveE+5E4kebD645xvQ1MrP1KQ6digceoH3V+jtKfH7DU1CVOZNLG+TzwK+38SScfjoUczcS8n7nS1riDoNUl8NuMn2EnFKFw1ROTgAS4ZPTXZ4bkM2/SK12kg11MXZijQ6wS6NNWMOIuq7VHuRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762740463; c=relaxed/simple;
	bh=gGd3la4AyOU2leXqeS6koFFQL/parkUNhYrfsYMD7/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q96L08Lt/26mQyTdxFqmaNO75fFfZ7NqlQCS4Uj/RzOx/6Y9Jgvr3Xwfi7Wl4YZCliOHZsSXdtnz/UEXAbofYQsvFBfdGBU8IGFGcKbMZWgy+dHUecYYR7Hha9XN4UlIGFlNBLBjl02+42py53+uoi1wt51AxszPPMppBse5POU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d4Y2Z3pXrzKHMSf;
	Mon, 10 Nov 2025 10:07:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7EF841A19BF;
	Mon, 10 Nov 2025 10:07:32 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP1 (Coremail) with SMTP id cCh0CgBXkUrUSBFpPBDaAA--.6382S4;
	Mon, 10 Nov 2025 10:07:32 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next 2/3] cpuset: remove global remote_children list
Date: Mon, 10 Nov 2025 01:52:27 +0000
Message-Id: <20251110015228.897736-3-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110015228.897736-1-chenridong@huaweicloud.com>
References: <20251110015228.897736-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXkUrUSBFpPBDaAA--.6382S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAFyxJr48tr17trWfWr45Jrb_yoWrGF4xpF
	n8GF43GFWUtr1rCa4UJF4ku3s3Kwn7JFW7KwnxX34fAF13Za4qkFyjka98Z34YqryDurW5
	ZFs093yxZFnrAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2FApUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The remote_children list is used to track all remote partitions attached
to a cpuset. However, it serves no other purpose. Using a boolean flag to
indicate whether a cpuset is a remote partition is a more direct approach,
making remote_children unnecessary.

This patch replaces the list with a remote_partition flag in the cpuset
structure and removes remote_children entirely.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset-internal.h |  4 ++--
 kernel/cgroup/cpuset.c          | 14 +++++---------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 5cac42c5fd97..7308e8bc4dde 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -172,8 +172,8 @@ struct cpuset {
 	/* Handle for cpuset.cpus.partition */
 	struct cgroup_file partition_file;
 
-	/* Remote partition silbling list anchored at remote_children */
-	struct list_head remote_sibling;
+	/* Whether cpuset is a remote partition */
+	bool remote_partition;
 
 	/* Used to merge intersecting subsets for generate_sched_domains */
 	struct uf_node node;
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index c90476d52f09..c357bfb69fe2 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -94,9 +94,6 @@ static bool isolated_cpus_updating;
 static cpumask_var_t	boot_hk_cpus;
 static bool		have_boot_isolcpus;
 
-/* List of remote partition root children */
-static struct list_head remote_children;
-
 /*
  * A flag to force sched domain rebuild at the end of an operation.
  * It can be set in
@@ -219,7 +216,7 @@ static struct cpuset top_cpuset = {
 		 BIT(CS_MEM_EXCLUSIVE) | BIT(CS_SCHED_LOAD_BALANCE),
 	.partition_root_state = PRS_ROOT,
 	.relax_domain_level = -1,
-	.remote_sibling = LIST_HEAD_INIT(top_cpuset.remote_sibling),
+	.remote_partition = false,
 };
 
 /*
@@ -1572,7 +1569,7 @@ static int compute_trialcs_excpus(struct cpuset *trialcs, struct cpuset *cs)
 
 static inline bool is_remote_partition(struct cpuset *cs)
 {
-	return !list_empty(&cs->remote_sibling);
+	return cs->remote_partition;
 }
 
 static inline bool is_local_partition(struct cpuset *cs)
@@ -1621,7 +1618,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 
 	spin_lock_irq(&callback_lock);
 	partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
-	list_add(&cs->remote_sibling, &remote_children);
+	cs->remote_partition = true;
 	cpumask_copy(cs->effective_xcpus, tmp->new_cpus);
 	spin_unlock_irq(&callback_lock);
 	update_isolation_cpumasks();
@@ -1651,7 +1648,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 	WARN_ON_ONCE(!cpumask_subset(cs->effective_xcpus, subpartitions_cpus));
 
 	spin_lock_irq(&callback_lock);
-	list_del_init(&cs->remote_sibling);
+	cs->remote_partition = false;
 	partition_xcpus_del(cs->partition_root_state, NULL, cs->effective_xcpus);
 	if (cs->prs_err)
 		cs->partition_root_state = -cs->partition_root_state;
@@ -3603,7 +3600,7 @@ cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
 	__set_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
 	fmeter_init(&cs->fmeter);
 	cs->relax_domain_level = -1;
-	INIT_LIST_HEAD(&cs->remote_sibling);
+	cs->remote_partition = false;
 
 	/* Set CS_MEMORY_MIGRATE for default hierarchy */
 	if (cpuset_v2())
@@ -3874,7 +3871,6 @@ int __init cpuset_init(void)
 	nodes_setall(top_cpuset.effective_mems);
 
 	fmeter_init(&top_cpuset.fmeter);
-	INIT_LIST_HEAD(&remote_children);
 
 	BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
 
-- 
2.34.1


