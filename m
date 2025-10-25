Return-Path: <cgroups+bounces-11171-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A759FC08CD2
	for <lists+cgroups@lfdr.de>; Sat, 25 Oct 2025 09:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC39D1C63B5E
	for <lists+cgroups@lfdr.de>; Sat, 25 Oct 2025 07:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B082E7F2C;
	Sat, 25 Oct 2025 07:04:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CCD2E22A6;
	Sat, 25 Oct 2025 07:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761375843; cv=none; b=mEuknc41+radXSzuvesw3bW/eV8LP9E/tharb2THgkVW68VgGxVIscHU2NEYwpZk4V/MDw/B6Dqo8M4LCzSL3W2W7s3rqWP1ILJBpy8FkauH56H9fsjL6s8l3a9KRk+UD68CYHKB2V/rt7OPBxmZbLhRrMqEzkHhazNrUPuTwOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761375843; c=relaxed/simple;
	bh=8taEKR3JGN44BjQ00YXnzEW+MrY8I4MoMFB305Ebnj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nD3n8kvfPna+KsgoVzz9wyTDIjIumN6mEMBeLxKqozm+EZK6Hv5PNmp/MkwUNVVwfJESL3dcwSVR/GP+vuohB9HvD5bWIlNQtROFNd2VUg7fZcLrOb80b0pMjGQkRGeo9zQ44JfTurcLh8Udcpe3U+j9p18vcX7+kBK+Vuy3x4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ctrLz46kTzYQtvd;
	Sat, 25 Oct 2025 15:02:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 400041A123A;
	Sat, 25 Oct 2025 15:03:50 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgCHKUJGdvxovSssBg--.49460S8;
	Sat, 25 Oct 2025 15:03:50 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH RFC v2 06/22] cpuset: introduce partition_update()
Date: Sat, 25 Oct 2025 06:48:28 +0000
Message-Id: <20251025064844.495525-7-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251025064844.495525-1-chenridong@huaweicloud.com>
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCHKUJGdvxovSssBg--.49460S8
X-Coremail-Antispam: 1UD129KBjvJXoWxuF45Xw43ur1rAF1kGw45KFg_yoW5AF15pF
	ykCr4Sqayjgr13u3sxtan2kw4rKa1kXF1jywnrXryrJFy7ta4vva4qy3s8Jr45X3sxG345
	XFs0qr4SgF1UArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1l_M7UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Introduce partition_update() to centralize updates to key cpuset structures
during a partition update, including:
- effective_xcpus
- exclusive_cpus

Key operations performed:
- Adding and removing exclusive CPUs via partition_xcpus_add()/del()
- Synchronizing the effective exclusive CPUs mask
- Updating the exclusive CPUs mask when modification is required
- Triggering necessary system updates and workqueue synchronization
- Updating the partition's exclusive flag
- Sending partition change notifications

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 47 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 4a79db1cdec1..3e414e19ae31 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1604,6 +1604,53 @@ static void partition_disable(struct cpuset *cs, struct cpuset *parent,
 	notify_partition_change(cs, old_prs);
 }
 
+/**
+ * partition_update - Update an existing partition configuration
+ * @cs: The cpuset to update
+ * @prs: Partition root state (must be positive)
+ * @xcpus: New exclusive CPUs mask for the partition (NULL to keep current)
+ * @excpus: New effective exclusive CPUs mask
+ * @tmp: Temporary masks
+ *
+ * Updates partition-related fields. The tmp->addmask is the CPU mask that
+ * will be added to the subpartitions_cpus and removed from parent's
+ * effective_cpus, and the tmp->delmask vice versa.
+ */
+static void partition_update(struct cpuset *cs, int prs, struct cpumask *xcpus,
+				  struct cpumask *excpus, struct tmpmasks *tmp)
+{
+	bool isolcpus_updated;
+	bool excl_updated;
+	struct cpuset *parent;
+	int old_prs;
+
+	lockdep_assert_held(&cpuset_mutex);
+	WARN_ON_ONCE(!cpuset_v2());
+	WARN_ON_ONCE(prs <= 0);
+
+	parent = is_remote_partition(cs) ? NULL : parent_cs(cs);
+	old_prs = cs->partition_root_state;
+	excl_updated = !cpumask_empty(tmp->addmask) ||
+		       !cpumask_empty(tmp->delmask);
+
+	spin_lock_irq(&callback_lock);
+	isolcpus_updated = partition_xcpus_add(prs, parent, tmp->addmask);
+	isolcpus_updated |= partition_xcpus_del(prs, parent, tmp->delmask);
+	/*
+	 * Need to update effective_xcpus and exclusive_cpus now as
+	 * update_sibling_cpumasks() below may iterate back to the same cs.
+	 */
+	cpumask_copy(cs->effective_xcpus, excpus);
+	if (xcpus)
+		cpumask_copy(cs->exclusive_cpus, xcpus);
+	spin_unlock_irq(&callback_lock);
+	update_unbound_workqueue_cpumask(isolcpus_updated);
+	if (excl_updated)
+		cpuset_force_rebuild();
+	update_partition_exclusive_flag(cs, prs);
+	notify_partition_change(cs, old_prs);
+}
+
 /*
  * prstate_housekeeping_conflict - check for partition & housekeeping conflicts
  * @prstate: partition root state to be checked
-- 
2.34.1


