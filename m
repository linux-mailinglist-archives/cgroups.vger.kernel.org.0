Return-Path: <cgroups+bounces-12710-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8B7CDDC6C
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 13:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88E483047AF2
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 12:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250FC322B6E;
	Thu, 25 Dec 2025 12:45:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D354B652;
	Thu, 25 Dec 2025 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766666757; cv=none; b=hd32NJRn27USP+qnknoSzq/KYpzPbgROotB1uOsPBcjphRRUaQa+9JX8XW3cXq22+JRAsmFr3ul5BSuF0TP2NakvlLESDDRrTlImQQScG3PPSpQ/R4FU8iffB9P471jNJ35dFb4SFqYrQh5un8DpvF1GjrQ+m+R72kdC+/Qc4Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766666757; c=relaxed/simple;
	bh=moIaCb89mdVky4zpojCE8mSOkoUY6pDGbjFLWXlWu+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RYqljl9BwICyCjnDQfa5TvCpJzbSqcthq+nZqaz0FuR1T4mx9otA96xKvMeKxMrI/OELXUFcGxEDosnBEjFr190l98m4HbaXAelFTWm3bmX/7tsyC0q5T7C+vVylA6C193fgz7CHucMR8SNFU7swrFikgfudk+YPY4TsieHx/8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dcT495fZGzKHMRw;
	Thu, 25 Dec 2025 20:45:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2380940578;
	Thu, 25 Dec 2025 20:45:51 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgDHdfb1MU1pT76_BQ--.27441S5;
	Thu, 25 Dec 2025 20:45:51 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com
Subject: [PATCH RESEND -next 03/21] cpuset: introduce partition_enable()
Date: Thu, 25 Dec 2025 12:30:40 +0000
Message-Id: <20251225123058.231765-4-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251225123058.231765-1-chenridong@huaweicloud.com>
References: <20251225123058.231765-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHdfb1MU1pT76_BQ--.27441S5
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4rKrW5Jw15JF43GF48JFb_yoW5WrWkpF
	n8Cr43J3yUKry3C3sxXFs7uw4Fgan7XF17twnxX3WrX3W7Ja4qka4jk398ta1jqryDG345
	ZanIgr4xWFnrA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUYdb1UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Add partition_enable() to consolidate updates to key cpuset structures
during partition enablement, including:
1. remote_partition
2. effective_xcpus
3. partition_root_state
4. prs_err

Key operations performed:
1. Invokes partition_xcpus_add() to assign exclusive CPUs
2. Maintains remote partition flag
3. Syncs the effective_xcpus mask
4. Updates partition_root_state and prs_err
5. Triggers scheduler domain rebuilds
6. Sends partition change notifications

This helper enables transitions between root and isolated states. All
fields except remote_sibling are reassigned during the transition.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 48 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 4543c2452be0..dbcb5e4d1f2c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1477,6 +1477,54 @@ static enum prs_errcode validate_partition(struct cpuset *cs, int new_prs,
 	return PERR_NONE;
 }
 
+static void partition_state_update(struct cpuset *cs, int new_prs,
+				   enum prs_errcode prs_err)
+{
+	lockdep_assert_held(&callback_lock);
+
+	cs->partition_root_state = new_prs;
+	WRITE_ONCE(cs->prs_err, prs_err);
+	if (!is_partition_valid(cs))
+		reset_partition_data(cs);
+}
+
+/**
+ * partition_enable - Transitions a cpuset to a partition root
+ * @cs: The cpuset to enable partition for
+ * @parent: Parent cpuset of @cs, NULL for remote parent
+ * @new_prs: New partition state to set
+ * @new_excpus: New effective exclusive CPUs mask for the partition
+ *
+ * Transitions a cpuset to a partition root, only for v2.
+ * It supports the transition between root and isolated partition.
+ */
+static void partition_enable(struct cpuset *cs, struct cpuset *parent,
+			     int new_prs, struct cpumask *new_excpus)
+{
+	int old_prs;
+
+	lockdep_assert_held(&cpuset_mutex);
+	WARN_ON_ONCE(new_prs <= 0);
+	WARN_ON_ONCE(!cpuset_v2());
+
+	if (cs->partition_root_state == new_prs)
+		return;
+
+	old_prs = cs->partition_root_state;
+	spin_lock_irq(&callback_lock);
+	/* enable partition should only add exclusive cpus */
+	partition_xcpus_add(new_prs, parent, new_excpus);
+	/* enable remote partition */
+	if (!parent)
+		cs->remote_partition = true;
+	cpumask_copy(cs->effective_xcpus, new_excpus);
+	partition_state_update(cs, new_prs, PERR_NONE);
+	spin_unlock_irq(&callback_lock);
+	update_isolation_cpumasks();
+	cpuset_force_rebuild();
+	notify_partition_change(cs, old_prs);
+}
+
 /*
  * remote_partition_enable - Enable current cpuset as a remote partition root
  * @cs: the cpuset to update
-- 
2.34.1


