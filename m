Return-Path: <cgroups+bounces-12711-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9643FCDDC51
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 13:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 830F93002D3D
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 12:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A685322B7D;
	Thu, 25 Dec 2025 12:45:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CD37263B;
	Thu, 25 Dec 2025 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766666757; cv=none; b=E4sN260g7rwkuS4JFfjFzHJHe7r4ySRdTbtfjEDhgxUjismyXWo0oy94fedtkrbImgiagK6u5vGVER7GWR+OZxNGZuXx2iP3gieNaRprz3dZrXhSZ7Yt1cFqYNwoCvl8cooQrnr5NoXcBlZ+2OoCo6odimBafsAOPDzD6DiF+oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766666757; c=relaxed/simple;
	bh=0T9kISK2w8BIvPD5DMPZ+zWF1jhhxroUrxQ3iqUGseA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MK601ZktSBvyuW9iYwjhcCw2dPZ8I8M+XYbfdMXVT0to165A9hIB5hZzEv+u3KZWocOQY5iwULFpIXqRndiK3gNHJ9+/nAj5ztILbHi2gepsxBCTIO6mFlOR7qhboTKBGJAS+vnOe1nFJ2Jm4WKOoX2D7c56ej1lVce45reVop8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dcT3p64yGzYQv0M;
	Thu, 25 Dec 2025 20:45:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2EC4440579;
	Thu, 25 Dec 2025 20:45:51 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgDHdfb1MU1pT76_BQ--.27441S6;
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
Subject: [PATCH RESEND -next 04/21] cpuset: introduce partition_disable()
Date: Thu, 25 Dec 2025 12:30:41 +0000
Message-Id: <20251225123058.231765-5-chenridong@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDHdfb1MU1pT76_BQ--.27441S6
X-Coremail-Antispam: 1UD129KBjvJXoW7CryUtryUuF13Zr1kJF4fXwb_yoW8Kw43pF
	1DCr43t3yYgr13u3sxJan7uw1rKa1kXFW7tw17Xw1rXFy7Aa4qva4vk39Iv3WUXFyDW345
	ZFsIqr4xWF17A3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAV
	WUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUYcTQUUUU
	U
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Add partition_disable() to consolidate updates to key cpuset structures
during partition disablement, including:
1. remote_partition
2. effective_xcpus
3. partition_root_state
4. prs_err

Key operations performed:
1. Cleaning up remote_partition
2. Removing exclusive CPUs via partition_xcpus_del()
3. Recomputing effective exclusive CPUs mask
4. Updating partition state and error status
5. Triggering required scheduler domain rebuilds
6. Clear exclusive flag.
7. Sends partition change notifications

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index dbcb5e4d1f2c..d1bf1a2f6acd 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1525,6 +1525,39 @@ static void partition_enable(struct cpuset *cs, struct cpuset *parent,
 	notify_partition_change(cs, old_prs);
 }
 
+/**
+ * partition_disable - Disable partition root state for a cpuset
+ * @cs: The cpuset to disable partition for
+ * @parent: Parent cpuset of @cs, NULL for remote parent
+ * @new_prs: New partition root state (should be non-positive)
+ * @prs_err: Error code to set if disabling due to validation failure
+ */
+static void partition_disable(struct cpuset *cs, struct cpuset *parent,
+			      int new_prs, enum prs_errcode prs_err)
+{
+	int old_prs;
+
+	lockdep_assert_held(&cpuset_mutex);
+	WARN_ON_ONCE(new_prs > 0);
+	WARN_ON_ONCE(!cpuset_v2());
+
+	old_prs = cs->partition_root_state;
+	spin_lock_irq(&callback_lock);
+	cs->remote_partition = false;
+	/* disable a partition should only delete exclusive cpus */
+	partition_xcpus_del(cs->partition_root_state,
+			    parent, cs->effective_xcpus);
+	/* effective_xcpus may need to be changed */
+	compute_excpus(cs, cs->effective_xcpus);
+	partition_state_update(cs, new_prs, prs_err);
+	spin_unlock_irq(&callback_lock);
+	update_isolation_cpumasks();
+	cpuset_force_rebuild();
+	/* Clear exclusive flag; no errors are expected */
+	update_partition_exclusive_flag(cs, new_prs);
+	notify_partition_change(cs, old_prs);
+}
+
 /*
  * remote_partition_enable - Enable current cpuset as a remote partition root
  * @cs: the cpuset to update
-- 
2.34.1


