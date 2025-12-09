Return-Path: <cgroups+bounces-12308-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A58FCB00A2
	for <lists+cgroups@lfdr.de>; Tue, 09 Dec 2025 14:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 233313073A18
	for <lists+cgroups@lfdr.de>; Tue,  9 Dec 2025 13:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E290328B4D;
	Tue,  9 Dec 2025 13:17:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A2619005E;
	Tue,  9 Dec 2025 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765286274; cv=none; b=TYNSM2Aq2gHwKwO1d0C5WrA9tL3FadiT8LB+Nxnqxve0NV9/0wdXraOH4WsQ03NFe7m71b/F3wD0MFpnyjMTJkkAAqiPzyTXDbndndBzCLh4BnWP3KgikO1D+PdGWs/DBApfh55j6qanCIwHssNZ6RLvvCZ0MNS+eIfmUmH8nGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765286274; c=relaxed/simple;
	bh=JpeHjh2D4RYEdBW/05l/FRoE07PGkVGpOYuGXfkpTcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MCHUm0jwZX4dMNvLf1OdNcpwQchd2uDIC6jr+MvETDu6xxPRPUB5WllNdt6mEFntsWi4YV+gIzfVlHMDg8aEPpARosIYU0DSon5ofuVDhlsi5hFB7Ga3UqtwMaKo1JYpLNtkqNLE7BPvsuGrjUPYZQKmWw0Vm6MmMHwREHdrM6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dQfWj5QzPzKHMKd;
	Tue,  9 Dec 2025 21:16:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4F7051A1A75;
	Tue,  9 Dec 2025 21:17:48 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP1 (Coremail) with SMTP id cCh0CgAnYn5wIThpE+mPBA--.4181S3;
	Tue, 09 Dec 2025 21:17:48 +0800 (CST)
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
Subject: [PATCH -next 1/2] memcg: move mem_cgroup_usage memcontrol-v1.c
Date: Tue,  9 Dec 2025 13:02:50 +0000
Message-Id: <20251209130251.1988615-2-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251209130251.1988615-1-chenridong@huaweicloud.com>
References: <20251209130251.1988615-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAnYn5wIThpE+mPBA--.4181S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1fZF1fWrW8Jw4fJFW5ZFb_yoW5XFW5pF
	sak3ZxZa1rJ398Wr4akFyDur9ava1Iqay5t3s7tryfZwnxtwn0q347t3yrAFW5CF97Xrnr
	Xws0yw1xGFWYkw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I
	0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxAqzxv26xkF
	7I0En4kS14v26r4a6rW5MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0piKsU_UUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Currently, mem_cgroup_usage is only used for v1, just move it to
memcontrol-v1.c

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 mm/memcontrol-v1.c | 22 ++++++++++++++++++++++
 mm/memcontrol-v1.h |  2 --
 mm/memcontrol.c    | 22 ----------------------
 3 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 6eed14bff742..0b50cb122ff3 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -427,6 +427,28 @@ static int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
 }
 #endif
 
+static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
+{
+	unsigned long val;
+
+	if (mem_cgroup_is_root(memcg)) {
+		/*
+		 * Approximate root's usage from global state. This isn't
+		 * perfect, but the root usage was always an approximation.
+		 */
+		val = global_node_page_state(NR_FILE_PAGES) +
+			global_node_page_state(NR_ANON_MAPPED);
+		if (swap)
+			val += total_swap_pages - get_nr_swap_pages();
+	} else {
+		if (!swap)
+			val = page_counter_read(&memcg->memory);
+		else
+			val = page_counter_read(&memcg->memsw);
+	}
+	return val;
+}
+
 static void __mem_cgroup_threshold(struct mem_cgroup *memcg, bool swap)
 {
 	struct mem_cgroup_threshold_ary *t;
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 6358464bb416..e92b21af92b1 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -22,8 +22,6 @@
 	     iter != NULL;				\
 	     iter = mem_cgroup_iter(NULL, iter, NULL))
 
-unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
-
 void drain_all_stock(struct mem_cgroup *root_memcg);
 
 unsigned long memcg_events(struct mem_cgroup *memcg, int event);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e2e49f4ec9e0..dbe7d8f93072 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3272,28 +3272,6 @@ void folio_split_memcg_refs(struct folio *folio, unsigned old_order,
 	css_get_many(&__folio_memcg(folio)->css, new_refs);
 }
 
-unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
-{
-	unsigned long val;
-
-	if (mem_cgroup_is_root(memcg)) {
-		/*
-		 * Approximate root's usage from global state. This isn't
-		 * perfect, but the root usage was always an approximation.
-		 */
-		val = global_node_page_state(NR_FILE_PAGES) +
-			global_node_page_state(NR_ANON_MAPPED);
-		if (swap)
-			val += total_swap_pages - get_nr_swap_pages();
-	} else {
-		if (!swap)
-			val = page_counter_read(&memcg->memory);
-		else
-			val = page_counter_read(&memcg->memsw);
-	}
-	return val;
-}
-
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
 	struct obj_cgroup *objcg;
-- 
2.34.1


