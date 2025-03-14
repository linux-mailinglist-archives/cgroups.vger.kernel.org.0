Return-Path: <cgroups+bounces-7058-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DA2A60916
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 07:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B1C3AF8F6
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 06:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A55A192D66;
	Fri, 14 Mar 2025 06:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NzN2MoMP"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F4818EFD4
	for <cgroups@vger.kernel.org>; Fri, 14 Mar 2025 06:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932950; cv=none; b=P9G9blnxz9RLJwSPqjDHq/I+rsSNETusJeXvfn7HVvaAsOkJXse5SghvXUQmUQqXdDbnxWzhh47LHtgbEhr4Lvqp32XSnsSslim7N1nSxPQpRndwFPsFXYO6FzlQ6yVI4YpVQ16hsuDbA2mqTNTYZ8UnVL+kUwe9t1VxkaNWFxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932950; c=relaxed/simple;
	bh=hPS0VKbMCZoTwVyonLwRfLAvT0JQ45gt7M89UuV5fWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWduI6nF7GQpGtFTY1TASVRNGRwmLPhsAA384TUv7w+rN6rKvcpZshAZb7ntXPDiO6gjBmoNB0pckzD3OsudA9jJSlVFvpGXcGxEK8+AgJ05HiFrpR5vW7ckZ0E6kceZ3Q53ReXfz/dHf88UIyI89Tugbdf58LM0lg2jWrIrp4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NzN2MoMP; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741932947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/vOofDJKYjkd25R4JYNyNwQOb8YH2uyqN/2EfEOuLI=;
	b=NzN2MoMPHTfdCiaak06HUc74OdZQIvqLAIVFB9SwXO8961DljO4pkXWKDSORvkMJpuOHCT
	mHFDQrUN3h5Kvgdym+MQodLK/7gwfoGuo9VU27qQeiMZAjNPLBgsbxldVen9H+7J4RVwG7
	h535Oyanb8IayGBPoUMgidcRMWV3aoY=
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
Subject: [RFC PATCH 07/10] memcg: use __mod_memcg_state in drain_obj_stock
Date: Thu, 13 Mar 2025 23:15:08 -0700
Message-ID: <20250314061511.1308152-8-shakeel.butt@linux.dev>
In-Reply-To: <20250314061511.1308152-1-shakeel.butt@linux.dev>
References: <20250314061511.1308152-1-shakeel.butt@linux.dev>
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

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3c4de384b5a0..dfe9c2eb7816 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -707,10 +707,12 @@ void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
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
@@ -2845,7 +2847,7 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
 
 			memcg = get_mem_cgroup_from_objcg(old);
 
-			mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
+			__mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
 			memcg1_account_kmem(memcg, -nr_pages);
 			if (!mem_cgroup_is_root(memcg))
 				memcg_uncharge(memcg, nr_pages);
-- 
2.47.1


