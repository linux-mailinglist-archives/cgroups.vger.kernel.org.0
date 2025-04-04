Return-Path: <cgroups+bounces-7355-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFB9A7B580
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 03:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D6C3B9901
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 01:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608111632F2;
	Fri,  4 Apr 2025 01:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GpZWu2DG"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A16D14F125
	for <cgroups@vger.kernel.org>; Fri,  4 Apr 2025 01:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743730807; cv=none; b=bC/0Mw8i1RysnXWiavpZ7iCxit2Kv12d7zOM2Qe53SQK4dsw/ZdsvbvA7ZjSCfzbRymCv/gTnnruaS+QaJXasPyw7dpq9zAXDomKSn0aG/IF9Mswvs9KmP8JwcQeEkvudWpszgZxLu5GPOnjfPoO4MhNrynaMvF2fhtv7QYOzNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743730807; c=relaxed/simple;
	bh=ApEjdjytrgizlDO/HJPlE1/U020o/eLJy1AJRVwvHi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjw9Q6DiQLB8GNWZ9urBLs69v3WBFaWPWSR/KV+Vx7wvzfMcJReQJ1cG4j8xji5JJgkDu9RkiQaObm0U2OIPe26yRA45fzSfGM+bJO1IsTSNLzEgCKfKz8g9ervuNkvDrblThBEFXw4c/h1pOBNg1cF6ChqxY/D+uRBbRFTFkqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GpZWu2DG; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743730802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5u+sGrpirO29d1KihT1tXkrq4oUxzHcwoOXUn/c4rxU=;
	b=GpZWu2DG35VYXPGZhdFuTR+e+p9ZnkPyl3xCS2z4XczcVBbXrTjmdDatecs8Z3InFGsO6m
	b/G9QZFGWTsRdvp8vgZQ7i9qVB+FhSS2T9ZuxyYQWMcowKCC84xKlbPgOFphFlxWb7A2d/
	Nn+F5vsLhhPGaCYx6WQdqaUTaFypiVU=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v2 7/9] memcg: use __mod_memcg_state in drain_obj_stock
Date: Thu,  3 Apr 2025 18:39:11 -0700
Message-ID: <20250404013913.1663035-8-shakeel.butt@linux.dev>
In-Reply-To: <20250404013913.1663035-1-shakeel.butt@linux.dev>
References: <20250404013913.1663035-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

For non-PREEMPT_RT kernels, drain_obj_stock() is always called with irq
disabled, so we can use __mod_memcg_state() instead of
mod_memcg_state(). For PREEMPT_RT, we need to add memcg_stats_[un]lock
in __mod_memcg_state().

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7988a42b29bf..33aeddfff0ba 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -710,10 +710,12 @@ void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
 	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
 		return;
 
+	memcg_stats_lock();
 	__this_cpu_add(memcg->vmstats_percpu->state[i], val);
 	val = memcg_state_val_in_pages(idx, val);
 	memcg_rstat_updated(memcg, val);
 	trace_mod_memcg_state(memcg, idx, val);
+	memcg_stats_unlock();
 }
 
 #ifdef CONFIG_MEMCG_V1
@@ -2866,7 +2868,7 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
 
 			memcg = get_mem_cgroup_from_objcg(old);
 
-			mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
+			__mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
 			memcg1_account_kmem(memcg, -nr_pages);
 			if (!mem_cgroup_is_root(memcg))
 				memcg_uncharge(memcg, nr_pages);
-- 
2.47.1


