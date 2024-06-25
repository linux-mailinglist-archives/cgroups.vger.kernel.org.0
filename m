Return-Path: <cgroups+bounces-3326-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB50915B58
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 03:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3925F283E01
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 01:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70222BB10;
	Tue, 25 Jun 2024 00:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SFL+k+TQ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14FE1CA8D
	for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 00:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719277182; cv=none; b=XsZumzVq0jP5M216IsKfT9+hBHIlxMOjKxXkAUojYiFtmFHXvtBF9zaaR32OGB5AC1GbzHsaVM2fkPPc8xirfZ7y6uVRcGaSBk9uAvWKTKMiQ9bBa7CfeArOMmTuzXLXj0RY9Md2BIhp+Hha1/TViWk2HOtr+TWBwogko7vrOsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719277182; c=relaxed/simple;
	bh=xv9NOCGodCEQxYKo91VaisLIINAyjCN1JxW1krl4FrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzqXord3CaIBYZAJ5nvGdlMmIb4Ss4g18wVCIC4taB2bKuyJLZYhz+4e0BwuSX5T35ZBJLShWjczaH9onPajPUPR6EFu2OB16VOXzr582JSPxffHew7QtB0bNwHs+Oqg6l4a9/5/N+FvuHijbIH7qIQbHdxtY07Vzlbvm/PJD3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SFL+k+TQ; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719277177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v/tf3lBw3jG/rT7MJZGDLV/4uYe72LY+pJRmiKuAdfM=;
	b=SFL+k+TQiNlRjgoH6x50pq3n0QiBjYIdOlFT3DK3/1aCGerHYnl1GSqWHiUELtnGjVl6cf
	EHBcQ4kFu/PRip99CGJsa6MpFTpsdvUA9eQKJSLiBJ56N+W0FFhsvBi6fisG0L48+JrNBH
	AoKWwYioVwfLl56ihuUsHU1AN4cR280=
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: roman.gushchin@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 05/14] mm: memcg: rename charge move-related functions
Date: Mon, 24 Jun 2024 17:58:57 -0700
Message-ID: <20240625005906.106920-6-roman.gushchin@linux.dev>
In-Reply-To: <20240625005906.106920-1-roman.gushchin@linux.dev>
References: <20240625005906.106920-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Rename exported function related to the charge move to have
the memcg1_ prefix.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/memcontrol-v1.c | 14 +++++++-------
 mm/memcontrol-v1.h |  8 ++++----
 mm/memcontrol.c    |  8 ++++----
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index f4c8bec5ae1b..c25e038ac874 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -384,7 +384,7 @@ static bool mem_cgroup_under_move(struct mem_cgroup *memcg)
 	return ret;
 }
 
-bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg)
+bool memcg1_wait_acct_move(struct mem_cgroup *memcg)
 {
 	if (mc.moving_task && current != mc.moving_task) {
 		if (mem_cgroup_under_move(memcg)) {
@@ -1056,7 +1056,7 @@ static void mem_cgroup_clear_mc(void)
 	mmput(mm);
 }
 
-int mem_cgroup_can_attach(struct cgroup_taskset *tset)
+int memcg1_can_attach(struct cgroup_taskset *tset)
 {
 	struct cgroup_subsys_state *css;
 	struct mem_cgroup *memcg = NULL; /* unneeded init to make gcc happy */
@@ -1126,7 +1126,7 @@ int mem_cgroup_can_attach(struct cgroup_taskset *tset)
 	return ret;
 }
 
-void mem_cgroup_cancel_attach(struct cgroup_taskset *tset)
+void memcg1_cancel_attach(struct cgroup_taskset *tset)
 {
 	if (mc.to)
 		mem_cgroup_clear_mc();
@@ -1285,7 +1285,7 @@ static void mem_cgroup_move_charge(void)
 	atomic_dec(&mc.from->moving_account);
 }
 
-void mem_cgroup_move_task(void)
+void memcg1_move_task(void)
 {
 	if (mc.to) {
 		mem_cgroup_move_charge();
@@ -1294,14 +1294,14 @@ void mem_cgroup_move_task(void)
 }
 
 #else	/* !CONFIG_MMU */
-static int mem_cgroup_can_attach(struct cgroup_taskset *tset)
+int memcg1_can_attach(struct cgroup_taskset *tset)
 {
 	return 0;
 }
-static void mem_cgroup_cancel_attach(struct cgroup_taskset *tset)
+void memcg1_cancel_attach(struct cgroup_taskset *tset)
 {
 }
-static void mem_cgroup_move_task(void)
+void memcg1_move_task(void)
 {
 }
 #endif
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 55e7c4f90c39..d377c0be9880 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -29,11 +29,11 @@ static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n);
 void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n);
 
-bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg);
+bool memcg1_wait_acct_move(struct mem_cgroup *memcg);
 struct cgroup_taskset;
-int mem_cgroup_can_attach(struct cgroup_taskset *tset);
-void mem_cgroup_cancel_attach(struct cgroup_taskset *tset);
-void mem_cgroup_move_task(void);
+int memcg1_can_attach(struct cgroup_taskset *tset);
+void memcg1_cancel_attach(struct cgroup_taskset *tset);
+void memcg1_move_task(void);
 
 struct cftype;
 u64 mem_cgroup_move_charge_read(struct cgroup_subsys_state *css,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3332c89cae2e..da2c0fa0de1b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2582,7 +2582,7 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * At task move, charge accounts can be doubly counted. So, it's
 	 * better to wait until the end of task_move if something is going on.
 	 */
-	if (mem_cgroup_wait_acct_move(mem_over_limit))
+	if (memcg1_wait_acct_move(mem_over_limit))
 		goto retry;
 
 	if (nr_retries--)
@@ -6030,12 +6030,12 @@ struct cgroup_subsys memory_cgrp_subsys = {
 	.css_free = mem_cgroup_css_free,
 	.css_reset = mem_cgroup_css_reset,
 	.css_rstat_flush = mem_cgroup_css_rstat_flush,
-	.can_attach = mem_cgroup_can_attach,
+	.can_attach = memcg1_can_attach,
 #if defined(CONFIG_LRU_GEN) || defined(CONFIG_MEMCG_KMEM)
 	.attach = mem_cgroup_attach,
 #endif
-	.cancel_attach = mem_cgroup_cancel_attach,
-	.post_attach = mem_cgroup_move_task,
+	.cancel_attach = memcg1_cancel_attach,
+	.post_attach = memcg1_move_task,
 #ifdef CONFIG_MEMCG_KMEM
 	.fork = mem_cgroup_fork,
 	.exit = mem_cgroup_exit,
-- 
2.45.2


