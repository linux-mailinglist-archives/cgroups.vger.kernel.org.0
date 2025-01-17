Return-Path: <cgroups+bounces-6211-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E935A147FB
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 03:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBFFC188E4C7
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 02:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677F71F63D3;
	Fri, 17 Jan 2025 02:14:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13371F5603;
	Fri, 17 Jan 2025 02:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737080099; cv=none; b=XVa2ZWETANwBEgX4WWUuJZfMC7IyejyVPjQz8x047Q4x4hci2V5o7tsy45XcOHquuH4NMU2/WUxx6g+FPihws2KAohN59FpGDdzZtant8AhuyFpzKqP59NfJRa38yVSfCAMQDEmbWZMOYlw6VM0MjnINjw+ClIIGG+BfYa7G3y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737080099; c=relaxed/simple;
	bh=l1kCOwteYrIcyq+dm+I29IOPNOtGzICZ2j2iAum8Nno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C5Q0qaARqZYkFY9B50A9UYE5/pjKXrW++hxUwKqIEJO6w5tHg9olftwXa0jbQbYWordWui2gp7iaCMOueyErj2rMh+9HdDL/1oBMtWsiBeoL5sCrbGVt2CHhkD1AzL7mOqPAi4wBbpTj0xsiYvMVpGMsgxoSCRu6OfNrDELDBc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YZ2t05VKwz4f3lDc;
	Fri, 17 Jan 2025 09:57:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 6F8E51A178E;
	Fri, 17 Jan 2025 09:57:34 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgCnsWT7uIln8NWrBA--.20802S7;
	Fri, 17 Jan 2025 09:57:34 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: akpm@linux-foundation.org,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	davidf@vimeo.com,
	vbabka@suse.cz,
	mkoutny@suse.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: [PATCH v3 next 5/5] memcg: move the 'local' functions to memcontrol-v1.c
Date: Fri, 17 Jan 2025 01:46:45 +0000
Message-Id: <20250117014645.1673127-6-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250117014645.1673127-1-chenridong@huaweicloud.com>
References: <20250117014645.1673127-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCnsWT7uIln8NWrBA--.20802S7
X-Coremail-Antispam: 1UD129KBjvJXoWxWr4Dur4rJr4UCryUtFyUGFg_yoWrGryUpF
	n3Ga13Kw47Jw45WF1akFyUu3s3Zw1fXrW5t3yxt34xZa43twn0gasIgrZ8ZrW5GrWFqFsx
	J3yYyr1kJ3yUtaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
	UbXAw7UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Move the 'local' functions, which are only used in memcg v1, to the
memcontrol-v1.c.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 include/linux/memcontrol.h |  6 ------
 mm/memcontrol-v1.c         | 17 +++++++++++++++++
 mm/memcontrol-v1.h         |  7 +------
 mm/memcontrol.c            |  8 +-------
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index ec469c5f7491..6895b2958835 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -938,12 +938,6 @@ static inline void mod_memcg_page_state(struct page *page,
 
 unsigned long __memcg_page_state(struct mem_cgroup *memcg, int idx, bool local);
 
-/* idx can be of type enum memcg_stat_item or node_stat_item. */
-static inline unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
-{
-	return __memcg_page_state(memcg, idx, true);
-}
-
 static inline unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
 {
 	return __memcg_page_state(memcg, idx, false);
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 2be6b9112808..2e8529b63366 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -106,6 +106,23 @@ static struct lockdep_map memcg_oom_lock_dep_map = {
 
 DEFINE_SPINLOCK(memcg_oom_lock);
 
+static unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
+{
+	return __memcg_events(memcg, event, true);
+}
+
+/* idx can be of type enum memcg_stat_item or node_stat_item. */
+static unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
+{
+	return __memcg_page_state(memcg, idx, true);
+}
+
+static unsigned long memcg_page_state_local_output(struct mem_cgroup *memcg, int item)
+{
+	return memcg_page_state_local(memcg, item) *
+		memcg_page_state_output_unit(item);
+}
+
 static void __mem_cgroup_insert_exceeded(struct mem_cgroup_per_node *mz,
 					 struct mem_cgroup_tree_per_node *mctz,
 					 unsigned long new_usage_in_excess)
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index f68c0064d674..d76e9a47adaa 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -65,13 +65,8 @@ static inline unsigned long memcg_events(struct mem_cgroup *memcg, int event)
 	return __memcg_events(memcg, event, false);
 }
 
-static inline unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
-{
-	return __memcg_events(memcg, event, true);
-}
-
+int memcg_page_state_output_unit(int item);
 unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
-unsigned long memcg_page_state_local_output(struct mem_cgroup *memcg, int item);
 int memory_stat_show(struct seq_file *m, void *v);
 
 /* Cgroup v1-specific declarations */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 404bbdfa352f..3f32d4ab55b3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1367,7 +1367,7 @@ static int memcg_page_state_unit(int item)
 }
 
 /* Translate stat items to the correct unit for memory.stat output */
-static int memcg_page_state_output_unit(int item)
+int memcg_page_state_output_unit(int item)
 {
 	/*
 	 * Workingset state is actually in pages, but we export it to userspace
@@ -1402,12 +1402,6 @@ unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item)
 		memcg_page_state_output_unit(item);
 }
 
-unsigned long memcg_page_state_local_output(struct mem_cgroup *memcg, int item)
-{
-	return memcg_page_state_local(memcg, item) *
-		memcg_page_state_output_unit(item);
-}
-
 #ifdef CONFIG_HUGETLB_PAGE
 static bool memcg_accounts_hugetlb(void)
 {
-- 
2.34.1


