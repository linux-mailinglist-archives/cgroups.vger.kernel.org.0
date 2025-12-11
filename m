Return-Path: <cgroups+bounces-12330-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D99D0CB4743
	for <lists+cgroups@lfdr.de>; Thu, 11 Dec 2025 02:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDCAC3016BB0
	for <lists+cgroups@lfdr.de>; Thu, 11 Dec 2025 01:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467FC238C2A;
	Thu, 11 Dec 2025 01:45:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291851DE8BE;
	Thu, 11 Dec 2025 01:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765417522; cv=none; b=DhP+dIMPRTJ63fTWemaYb1E0MvIfylYtc6JdLiLqsUyWQrj+hXHrQ5zgXqbrcqnUEVtZ0sV4QpYNipXFrrPgxJJQW2NHq5R662HigQmDwJbD++Kh2ArBkugsdgQSiqCc+NFYTljNIqWTk1r5tYNKOjDgUqygyGCD0ncpnOn61II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765417522; c=relaxed/simple;
	bh=2HekbkaluU8TRZHlvMLWjDLidQwLmuj2r2anhiCtgsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=McLGFYeTutaJy3shWWPt3QOz2bc58AqcumkrZqXDx+Y8lTuwvQ/cEvP6rJBeBB6pBtSKm9olbL5KJH0HUtg69tuumrYu5dCqDSyHNNs6ZfKiVRmeN1uaKcpStnBtLVn2fYUuTjsM1iRn/c9HRSRU/VM9ccK62BD9LNJkIA4kTWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dRb3g4s87zKHMP3;
	Thu, 11 Dec 2025 09:44:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 8BBB81A1938;
	Thu, 11 Dec 2025 09:45:16 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgB3VlAgIjpp39lLBQ--.49534S4;
	Thu, 11 Dec 2025 09:45:16 +0800 (CST)
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
Subject: [PATCH -next v3 2/2] memcg: remove mem_cgroup_size()
Date: Thu, 11 Dec 2025 01:30:19 +0000
Message-Id: <20251211013019.2080004-3-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251211013019.2080004-1-chenridong@huaweicloud.com>
References: <20251211013019.2080004-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB3VlAgIjpp39lLBQ--.49534S4
X-Coremail-Antispam: 1UD129KBjvJXoWxur1kKF4UtrWrZFWUKw18Grg_yoWrCry7pF
	sFy3y3tw4YyrW3WrZIka4UZa4fAw48ta45Jry7Gw1xZ3ZIqw15XFy2yw18XFWUCF9aqFy7
	Za90yr1kC3y2krUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjTRRCJPDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The mem_cgroup_size helper is used only in apply_proportional_protection
to read the current memory usage. Its semantics are unclear and
inconsistent with other sites, which directly call page_counter_read for
the same purpose.

Remove this helper and get its usage via mem_cgroup_protection for
clarity. Additionally, rename the local variable 'cgroup_size' to 'usage'
to better reflect its meaning.

No functional changes intended.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 include/linux/memcontrol.h | 18 +++++++-----------
 mm/memcontrol.c            |  5 -----
 mm/vmscan.c                |  9 ++++-----
 3 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6a48398a1f4e..603252e3169c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -557,13 +557,15 @@ static inline bool mem_cgroup_disabled(void)
 static inline void mem_cgroup_protection(struct mem_cgroup *root,
 					 struct mem_cgroup *memcg,
 					 unsigned long *min,
-					 unsigned long *low)
+					 unsigned long *low,
+					 unsigned long *usage)
 {
-	*min = *low = 0;
+	*min = *low = *usage = 0;
 
 	if (mem_cgroup_disabled())
 		return;
 
+	*usage = page_counter_read(&memcg->memory);
 	/*
 	 * There is no reclaim protection applied to a targeted reclaim.
 	 * We are special casing this specific case here because
@@ -919,8 +921,6 @@ static inline void mem_cgroup_handle_over_high(gfp_t gfp_mask)
 
 unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg);
 
-unsigned long mem_cgroup_size(struct mem_cgroup *memcg);
-
 void mem_cgroup_print_oom_context(struct mem_cgroup *memcg,
 				struct task_struct *p);
 
@@ -1102,9 +1102,10 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
 static inline void mem_cgroup_protection(struct mem_cgroup *root,
 					 struct mem_cgroup *memcg,
 					 unsigned long *min,
-					 unsigned long *low)
+					 unsigned long *low,
+					 unsigned long *usage)
 {
-	*min = *low = 0;
+	*min = *low = *usage = 0;
 }
 
 static inline void mem_cgroup_calculate_protection(struct mem_cgroup *root,
@@ -1328,11 +1329,6 @@ static inline unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
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
index 670fe9fae5ba..9a6ee80275fc 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2451,9 +2451,9 @@ static inline void calculate_pressure_balance(struct scan_control *sc,
 static unsigned long apply_proportional_protection(struct mem_cgroup *memcg,
 		struct scan_control *sc, unsigned long scan)
 {
-	unsigned long min, low;
+	unsigned long min, low, usage;
 
-	mem_cgroup_protection(sc->target_mem_cgroup, memcg, &min, &low);
+	mem_cgroup_protection(sc->target_mem_cgroup, memcg, &min, &low, &usage);
 
 	if (min || low) {
 		/*
@@ -2485,7 +2485,6 @@ static unsigned long apply_proportional_protection(struct mem_cgroup *memcg,
 		 * again by how much of the total memory used is under
 		 * hard protection.
 		 */
-		unsigned long cgroup_size = mem_cgroup_size(memcg);
 		unsigned long protection;
 
 		/* memory.low scaling, make sure we retry before OOM */
@@ -2497,9 +2496,9 @@ static unsigned long apply_proportional_protection(struct mem_cgroup *memcg,
 		}
 
 		/* Avoid TOCTOU with earlier protection check */
-		cgroup_size = max(cgroup_size, protection);
+		usage = max(usage, protection);
 
-		scan -= scan * protection / (cgroup_size + 1);
+		scan -= scan * protection / (usage + 1);
 
 		/*
 		 * Minimally target SWAP_CLUSTER_MAX pages to keep
-- 
2.34.1


