Return-Path: <cgroups+bounces-12055-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47189C6850D
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 09:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 49D6E2A55F
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 08:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B63311C39;
	Tue, 18 Nov 2025 08:52:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D478304BDA;
	Tue, 18 Nov 2025 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763455922; cv=none; b=pvL/IDMjoDfc7yC9DKH7LNgz6Gd3E3VPda5bgFTwjPFkGZKgtVcau6F33vXl07LIe4aA2ofYFkuxbtqA0UCR17hSjqG1nTC2jI2G6CEjSGLrdN1vkhzse84Fs/zgL+gUPBprsdaMeCDD6QGOm7106Ru+5rQEFI4fhS+I937BWc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763455922; c=relaxed/simple;
	bh=3SiuzLV3cxOAu7Ji/1FZZXNRwCvxnxU1ASI8oWLcZ2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XFqw0ceZvhzprT/I483/aMs0EeGNoZVCL2GQe3fi5AZGZ3YocBHa23dge2VWRM77VN6hwPqYsRpL1ldBW9Vc61BZOOq2XoFr34c9NqVbSz9V4ICZ3n1m9+vMHtwlre3tG+hxiNoJ7lf8WONt322HI3Qo4QWwu97Oi7wr6d2ElEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d9dd74jJ1zKHMlq;
	Tue, 18 Nov 2025 16:51:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 133A91A1686;
	Tue, 18 Nov 2025 16:51:50 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgBHcF2SMxxppSKjBA--.4747S2;
	Tue, 18 Nov 2025 16:51:49 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel.m.jordan@oracle.com,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next] cpuset: Remove unnecessary checks in rebuild_sched_domains_locked
Date: Tue, 18 Nov 2025 08:36:43 +0000
Message-Id: <20251118083643.1363020-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHcF2SMxxppSKjBA--.4747S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWryxWr17WrWrJrykCw1rWFg_yoW5GF17pF
	Z5KF47Zr45Kr1UC39xtay3ZryF9an7Jay7t3ZxWr18AF17A3Z29ryjya43XrWUWr9xC34U
	ZFn09w43uFnFyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU10PfPUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Commit 406100f3da08 ("cpuset: fix race between hotplug work and later CPU
offline")added a check for empty effective_cpus in partitions for cgroup
v2. However, thischeck did not account for remote partitions, which were
introduced later.

After commit 2125c0034c5d ("cgroup/cpuset: Make cpuset hotplug processing
synchronous"),cgroup v2's cpuset hotplug handling is now synchronous. This
eliminates the race condition with subsequent CPU offline operations that
the original check aimed to fix.

Instead of extending the check to support remote partitions, this patch
removes the redundant partition effective_cpus check. Additionally, it adds
a check and warningto verify that all generated sched domains consist of
active CPUs, preventing partition_sched_domains from being invoked with
offline CPUs.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index daf813386260..1ac58e3f26b4 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1084,11 +1084,10 @@ void dl_rebuild_rd_accounting(void)
  */
 void rebuild_sched_domains_locked(void)
 {
-	struct cgroup_subsys_state *pos_css;
 	struct sched_domain_attr *attr;
 	cpumask_var_t *doms;
-	struct cpuset *cs;
 	int ndoms;
+	int i;
 
 	lockdep_assert_cpus_held();
 	lockdep_assert_held(&cpuset_mutex);
@@ -1107,30 +1106,14 @@ void rebuild_sched_domains_locked(void)
 	    !cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
 		return;
 
-	/*
-	 * With subpartition CPUs, however, the effective CPUs of a partition
-	 * root should be only a subset of the active CPUs.  Since a CPU in any
-	 * partition root could be offlined, all must be checked.
-	 */
-	if (!cpumask_empty(subpartitions_cpus)) {
-		rcu_read_lock();
-		cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
-			if (!is_partition_valid(cs)) {
-				pos_css = css_rightmost_descendant(pos_css);
-				continue;
-			}
-			if (!cpumask_subset(cs->effective_cpus,
-					    cpu_active_mask)) {
-				rcu_read_unlock();
-				return;
-			}
-		}
-		rcu_read_unlock();
-	}
-
 	/* Generate domain masks and attrs */
 	ndoms = generate_sched_domains(&doms, &attr);
 
+	for (i = 0; i < ndoms; ++i) {
+		if (WARN_ON_ONCE(!cpumask_subset(doms[i], cpu_active_mask)))
+			return;
+	}
+
 	/* Have scheduler rebuild the domains */
 	partition_sched_domains(ndoms, doms, attr);
 }
-- 
2.34.1


