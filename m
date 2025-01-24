Return-Path: <cgroups+bounces-6260-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 313FEA1B110
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 08:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176941889D83
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 07:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6311DB136;
	Fri, 24 Jan 2025 07:46:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362BE1D5AC3;
	Fri, 24 Jan 2025 07:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737704773; cv=none; b=MbdfR77jelV8Ggs62Up0xCwxqpb8x1utDV9WGwsI9d2mhuq5vO/01Wj/yNLH0AOYHS2xn6GwBN7grn8Vj1iIyWJnoO11B7JhyG+jpvaq1YpkTSdx5OsTmMRvmLfTo22LKy2U4T/3hTWYILWve0N2v1iNkxjbL18FayMakwsDtm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737704773; c=relaxed/simple;
	bh=pqBNUa10aAkxdtFdlO8H32/Ka9k1FpyTkekuXy6puWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IGiyy9BX+9gA5X2VfBSebo6eJcQo2OX61PfCl57vW4dPrnPJGIm0PMdBcAT/bdfyU7vxYkPF6jtyCBmYIaKfiDPtXj+WzewTaTheh/QqSyv9TQz69ooNXqsBS39ksFF3d7q2xt37CfdSLL/z0ubbmQ4+n7BvyjCAk+MNYladXlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YfVGz2rHtz4f3lDG;
	Fri, 24 Jan 2025 15:45:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5A6471A1388;
	Fri, 24 Jan 2025 15:46:09 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP1 (Coremail) with SMTP id cCh0CgBHqnozRZNn89xFBw--.58969S6;
	Fri, 24 Jan 2025 15:46:09 +0800 (CST)
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
Subject: [PATCH -v4 next 4/4] memcg: add CONFIG_MEMCG_V1 for 'local' functions
Date: Fri, 24 Jan 2025 07:35:14 +0000
Message-Id: <20250124073514.2375622-5-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124073514.2375622-1-chenridong@huaweicloud.com>
References: <20250124073514.2375622-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHqnozRZNn89xFBw--.58969S6
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4xWFyxuFyUtF17ZFykAFb_yoW5ZrW7pF
	nxKan0q3yfJ3y5Wr1akFyUu3sayw1xX345trWxt34IvF9xtw1YgFnxCw4DZrW5CFyrXFsx
	J3s0yr1DJ3yYy3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Add CONFIG_MEMCG_V1 for the 'local' functions, which are only used in
memcg v1, so that they won't be built for v2.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 mm/memcontrol-v1.h | 6 +++---
 mm/memcontrol.c    | 6 ++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 144d71b65907..ecff454373e2 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -60,15 +60,15 @@ unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
 void drain_all_stock(struct mem_cgroup *root_memcg);
 
 unsigned long memcg_events(struct mem_cgroup *memcg, int event);
-unsigned long memcg_events_local(struct mem_cgroup *memcg, int event);
-unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx);
 unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
-unsigned long memcg_page_state_local_output(struct mem_cgroup *memcg, int item);
 int memory_stat_show(struct seq_file *m, void *v);
 
 /* Cgroup v1-specific declarations */
 #ifdef CONFIG_MEMCG_V1
 
+unsigned long memcg_events_local(struct mem_cgroup *memcg, int event);
+unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx);
+unsigned long memcg_page_state_local_output(struct mem_cgroup *memcg, int item);
 bool memcg1_alloc_events(struct mem_cgroup *memcg);
 void memcg1_free_events(struct mem_cgroup *memcg);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b10e0a8f3375..daa74af15b05 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -706,6 +706,7 @@ void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
 	trace_mod_memcg_state(memcg, idx, val);
 }
 
+#ifdef CONFIG_MEMCG_V1
 /* idx can be of type enum memcg_stat_item or node_stat_item. */
 unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
 {
@@ -722,6 +723,7 @@ unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
 #endif
 	return x;
 }
+#endif
 
 static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
 				     enum node_stat_item idx,
@@ -869,6 +871,7 @@ unsigned long memcg_events(struct mem_cgroup *memcg, int event)
 	return READ_ONCE(memcg->vmstats->events[i]);
 }
 
+#ifdef CONFIG_MEMCG_V1
 unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
 {
 	int i = memcg_events_index(event);
@@ -878,6 +881,7 @@ unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
 
 	return READ_ONCE(memcg->vmstats->events_local[i]);
 }
+#endif
 
 struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p)
 {
@@ -1447,11 +1451,13 @@ unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item)
 		memcg_page_state_output_unit(item);
 }
 
+#ifdef CONFIG_MEMCG_V1
 unsigned long memcg_page_state_local_output(struct mem_cgroup *memcg, int item)
 {
 	return memcg_page_state_local(memcg, item) *
 		memcg_page_state_output_unit(item);
 }
+#endif
 
 #ifdef CONFIG_HUGETLB_PAGE
 static bool memcg_accounts_hugetlb(void)
-- 
2.34.1


