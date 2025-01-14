Return-Path: <cgroups+bounces-6128-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934BFA106C2
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 13:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD2833A6417
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 12:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEFF2361EB;
	Tue, 14 Jan 2025 12:36:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDA720F982;
	Tue, 14 Jan 2025 12:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736858166; cv=none; b=J1Z8zyjqjnqr6sMfQbRzZesYcawFWiIhQ11WO0xOXJBacTpAOGgjrMriq3UQk7XFft8xsU6VGbDfhUJyQa5AS6dNCDabDxbrhdiZ1myVmeNV782egqNqcW9S15xmow1/v9QozGLk7kYvjCKySvyqUWtK71r9Fn2j2zhBabcs6CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736858166; c=relaxed/simple;
	bh=7N6VbmzBSOkCvDHBiSI5r92a2bakgBAWy/93QtDi8sk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uYV+cXHvU/aqq5F2zAfMCJK+VGyK7sp8WbQlkEyudJQEP+KbPE8ffOtjgcIRnwyM+zxqXGiqghB8QHkLNAUIfGrwtRgXz4S4ghCH3OBo2wf3ozoSXKTcpT9EOvanwsPKqamMKf+1Tahev+d7fVLy7oyGeODujgLfO2uSf7TXSaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YXTB322Scz4f3khN;
	Tue, 14 Jan 2025 20:35:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A0F901A18A1;
	Tue, 14 Jan 2025 20:35:59 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP3 (Coremail) with SMTP id _Ch0CgB3F8IhWoZnN4KvAw--.1325S6;
	Tue, 14 Jan 2025 20:35:59 +0800 (CST)
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
Subject: [PATCH -v2 next 4/4] memcg: factor out stat(event)/stat_local(event_local) reading functions
Date: Tue, 14 Jan 2025 12:25:19 +0000
Message-Id: <20250114122519.1404275-5-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250114122519.1404275-1-chenridong@huaweicloud.com>
References: <20250114122519.1404275-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB3F8IhWoZnN4KvAw--.1325S6
X-Coremail-Antispam: 1UD129KBjvJXoWxKw4kZFyrKw4rJr18tryxXwb_yoW7XFWUpF
	sxtayY9rW3Jw4F9r1ftFWjv34rA3WxX3yUJryxJ3ySvasxtw1Yg3ZxKF9rZrW5Cr95ZF13
	Jayqyr1DJ3y2qa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07UZTmfUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The only difference between 'lruvec_page_state' and
'lruvec_page_state_local' is that they read 'state' and 'state_local',
respectively. Factor out an inner functions to make the code more concise.
Do the same for reading 'memcg_page_stat' and 'memcg_events'.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 mm/memcontrol.c | 72 +++++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 42 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b10e0a8f3375..14541610cad0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -375,7 +375,8 @@ struct lruvec_stats {
 	long state_pending[NR_MEMCG_NODE_STAT_ITEMS];
 };
 
-unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx)
+static unsigned long __lruvec_page_state(struct lruvec *lruvec,
+		enum node_stat_item idx, bool local)
 {
 	struct mem_cgroup_per_node *pn;
 	long x;
@@ -389,7 +390,8 @@ unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx)
 		return 0;
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	x = READ_ONCE(pn->lruvec_stats->state[i]);
+	x = local ? READ_ONCE(pn->lruvec_stats->state_local[i]) :
+		    READ_ONCE(pn->lruvec_stats->state[i]);
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
@@ -397,27 +399,16 @@ unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx)
 	return x;
 }
 
+
+unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx)
+{
+	return __lruvec_page_state(lruvec, idx, false);
+}
+
 unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 				      enum node_stat_item idx)
 {
-	struct mem_cgroup_per_node *pn;
-	long x;
-	int i;
-
-	if (mem_cgroup_disabled())
-		return node_page_state(lruvec_pgdat(lruvec), idx);
-
-	i = memcg_stats_index(idx);
-	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
-		return 0;
-
-	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	x = READ_ONCE(pn->lruvec_stats->state_local[i]);
-#ifdef CONFIG_SMP
-	if (x < 0)
-		x = 0;
-#endif
-	return x;
+	return __lruvec_page_state(lruvec, idx, true);
 }
 
 /* Subset of vm_event_item to report for memcg event stats */
@@ -651,7 +642,7 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
 	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
 }
 
-unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
+static unsigned long __memcg_page_state(struct mem_cgroup *memcg, int idx, bool local)
 {
 	long x;
 	int i = memcg_stats_index(idx);
@@ -659,7 +650,9 @@ unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
 	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
 		return 0;
 
-	x = READ_ONCE(memcg->vmstats->state[i]);
+	x = local ? READ_ONCE(memcg->vmstats->state_local[i]) :
+		    READ_ONCE(memcg->vmstats->state[i]);
+
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
@@ -667,6 +660,11 @@ unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
 	return x;
 }
 
+unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
+{
+	return __memcg_page_state(memcg, idx, false);
+}
+
 static int memcg_page_state_unit(int item);
 
 /*
@@ -709,18 +707,7 @@ void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
 /* idx can be of type enum memcg_stat_item or node_stat_item. */
 unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
 {
-	long x;
-	int i = memcg_stats_index(idx);
-
-	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
-		return 0;
-
-	x = READ_ONCE(memcg->vmstats->state_local[i]);
-#ifdef CONFIG_SMP
-	if (x < 0)
-		x = 0;
-#endif
-	return x;
+	return __memcg_page_state(memcg, idx, true);
 }
 
 static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
@@ -859,24 +846,25 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 	memcg_stats_unlock();
 }
 
-unsigned long memcg_events(struct mem_cgroup *memcg, int event)
+static unsigned long __memcg_events(struct mem_cgroup *memcg, int event, bool local)
 {
 	int i = memcg_events_index(event);
 
 	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, event))
 		return 0;
 
-	return READ_ONCE(memcg->vmstats->events[i]);
+	return local ? READ_ONCE(memcg->vmstats->events_local[i]) :
+		    READ_ONCE(memcg->vmstats->events[i]);
 }
 
-unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
+unsigned long memcg_events(struct mem_cgroup *memcg, int event)
 {
-	int i = memcg_events_index(event);
-
-	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, event))
-		return 0;
+	return __memcg_events(memcg, event, false);
+}
 
-	return READ_ONCE(memcg->vmstats->events_local[i]);
+unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
+{
+	return __memcg_events(memcg, event, true);
 }
 
 struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p)
-- 
2.34.1


