Return-Path: <cgroups+bounces-12316-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CD64ACB22F6
	for <lists+cgroups@lfdr.de>; Wed, 10 Dec 2025 08:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 289973023F9A
	for <lists+cgroups@lfdr.de>; Wed, 10 Dec 2025 07:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7132FB965;
	Wed, 10 Dec 2025 07:26:45 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE31E1DE8A4;
	Wed, 10 Dec 2025 07:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765351605; cv=none; b=fNCvcHiH1ZfN1lTVoTYp5gg6fkR6KbeIHlSuqupCVaTX86ZbwF0oUGMDak7QyY5E7UojvZ57ByRg9OZ3lekndoUOP2Ycu/yZcNIL1nBw+v8majbhuT+4fiKplbBrTNpDtHDdjWnaU33/T3xHthVRfjFTR0p/FBFKWwMbuTxQg0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765351605; c=relaxed/simple;
	bh=TWYu5jX7iyHbZtMjImPfNCsO2jUPL7vZzN5I3Pk6hfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TDtpa87KnNDyfkWfHl+0Hi+3mqmIeyQ2DkqiHl1W+RP+Lq2Z3SZDPDEWRM8BJILfePXeMPWJv3ZAhza/eXEfeXrsfYzD0uUuPGPn1iOhQ83mXFldN/Nhq3h7jmIuTPGScEFCOzk3YM0IlPMdaoT5gqFrtZh+xF0jmg02EmXsr8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dR6hw756LzYQtqb;
	Wed, 10 Dec 2025 15:26:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B7B8B1A0359;
	Wed, 10 Dec 2025 15:26:39 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgC33pujIDlpfef4BA--.9918S4;
	Wed, 10 Dec 2025 15:26:39 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	david@kernel.org,
	zhengqi.arch@bytedance.com,
	lorenzo.stoakes@oracle.com
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com
Subject: [PATCH -next v2 2/2] memcg: remove mem_cgroup_size()
Date: Wed, 10 Dec 2025 07:11:42 +0000
Message-Id: <20251210071142.2043478-3-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251210071142.2043478-1-chenridong@huaweicloud.com>
References: <20251210071142.2043478-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC33pujIDlpfef4BA--.9918S4
X-Coremail-Antispam: 1UD129KBjvJXoWxur1kur4rXF4kAr47AFWkWFg_yoW5KF4kpF
	nFk3y3Jw45trW5Gr4aka4UZa4fAa18ta43Jry7Gw18Z3Zxtw1YqF9Fyw18XrWUCF93XF17
	Za909r48C3y2y3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjTRNiSHDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The mem_cgroup_size helper is used only in apply_proportional_protection
to read the current memory usage. Its semantics are unclear and
inconsistent with other sites, which directly call page_counter_read for
the same purpose.

Remove this helper and replace its usage with page_counter_read for
clarity. Additionally, rename the local variable 'cgroup_size' to 'usage'
to better reflect its meaning.

This change is safe because page_counter_read() is only called when memcg
is enabled in the apply_proportional_protection.

No functional changes intended.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 include/linux/memcontrol.h | 7 -------
 mm/memcontrol.c            | 5 -----
 mm/vmscan.c                | 8 +++++---
 3 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6a48398a1f4e..bedeb606c691 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -919,8 +919,6 @@ static inline void mem_cgroup_handle_over_high(gfp_t gfp_mask)
 
 unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg);
 
-unsigned long mem_cgroup_size(struct mem_cgroup *memcg);
-
 void mem_cgroup_print_oom_context(struct mem_cgroup *memcg,
 				struct task_struct *p);
 
@@ -1328,11 +1326,6 @@ static inline unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
 	return 0;
 }
 
-static inline unsigned long mem_cgroup_size(struct mem_cgroup *memcg)
-{
-	return 0;
-}
-
 static inline void
 mem_cgroup_print_oom_context(struct mem_cgroup *memcg, struct task_struct *p)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index dbe7d8f93072..659ce171b1b3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1621,11 +1621,6 @@ unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
 	return max;
 }
 
-unsigned long mem_cgroup_size(struct mem_cgroup *memcg)
-{
-	return page_counter_read(&memcg->memory);
-}
-
 void __memcg_memory_event(struct mem_cgroup *memcg,
 			  enum memcg_memory_event event, bool allow_spinning)
 {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 670fe9fae5ba..fe48d0376e7c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2451,6 +2451,7 @@ static inline void calculate_pressure_balance(struct scan_control *sc,
 static unsigned long apply_proportional_protection(struct mem_cgroup *memcg,
 		struct scan_control *sc, unsigned long scan)
 {
+#ifdef CONFIG_MEMCG
 	unsigned long min, low;
 
 	mem_cgroup_protection(sc->target_mem_cgroup, memcg, &min, &low);
@@ -2485,7 +2486,7 @@ static unsigned long apply_proportional_protection(struct mem_cgroup *memcg,
 		 * again by how much of the total memory used is under
 		 * hard protection.
 		 */
-		unsigned long cgroup_size = mem_cgroup_size(memcg);
+		unsigned long usage = page_counter_read(&memcg->memory);
 		unsigned long protection;
 
 		/* memory.low scaling, make sure we retry before OOM */
@@ -2497,9 +2498,9 @@ static unsigned long apply_proportional_protection(struct mem_cgroup *memcg,
 		}
 
 		/* Avoid TOCTOU with earlier protection check */
-		cgroup_size = max(cgroup_size, protection);
+		usage = max(usage, protection);
 
-		scan -= scan * protection / (cgroup_size + 1);
+		scan -= scan * protection / (usage + 1);
 
 		/*
 		 * Minimally target SWAP_CLUSTER_MAX pages to keep
@@ -2508,6 +2509,7 @@ static unsigned long apply_proportional_protection(struct mem_cgroup *memcg,
 		 */
 		scan = max(scan, SWAP_CLUSTER_MAX);
 	}
+#endif
 	return scan;
 }
 
-- 
2.34.1


