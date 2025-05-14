Return-Path: <cgroups+bounces-8196-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DD5AB749C
	for <lists+cgroups@lfdr.de>; Wed, 14 May 2025 20:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F594C5D49
	for <lists+cgroups@lfdr.de>; Wed, 14 May 2025 18:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C7E28C860;
	Wed, 14 May 2025 18:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XsH+sSP2"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC18628C5B8
	for <cgroups@vger.kernel.org>; Wed, 14 May 2025 18:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747248171; cv=none; b=GIWy9Ma3pC7I3LBjubOIETy/m+OU0RLZRHd3W1q1sIZF+B3Z/4bofPr1f0sZxHvfniN3PAgR3G69MKPTRjzGRXOPs8z6wa6XK54sxy1W3XKEGSWTyHy6v2L0PLxsenHiW1ircKiTLpo5aw7N9nH0ETnZQKlFUbL7PuCceTre4xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747248171; c=relaxed/simple;
	bh=F3WEBTPiQLWz9cCb+hjP8Ux7u/ANXbxtzcyn85cfhmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sb0yatj5dzMu439A++76SXXUu/R9u6W1rZzOAUehqWRRfyydNMhS3tUsjg9ZCAlCKNGuOSWfFiVdnyeI4NKe92aa43dprk7w3dUK54sRp5L9eFu03w0yE3w5oMxqQLmGuX2KtTuQ7AqnfkDjWCkd1y8Hh+NdIuueVEH62n5l6QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XsH+sSP2; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747248167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tl4rUg93LkTokTk1IS4m9ISxrd6enFA07YnhN9En2KU=;
	b=XsH+sSP2IqgV4b7JFzKmne3RJ7B8fs6sll5nB5jaO2ynnf01GgAFSgEyNXGG86e9Z7QQ1C
	xAVYpXslEoie+4agb0gtbili30uXYuaShK5I8zmCyUoS39PXhQWaMMqSpDmDEFLEr7kO7A
	tKA3XPMFfwrhihunQK+imHxFUbmwrx0=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Harry Yoo <harry.yoo@oracle.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v2 6/7] memcg: no stock lock for cpu hot-unplug
Date: Wed, 14 May 2025 11:41:57 -0700
Message-ID: <20250514184158.3471331-7-shakeel.butt@linux.dev>
In-Reply-To: <20250514184158.3471331-1-shakeel.butt@linux.dev>
References: <20250514184158.3471331-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Previously on the cpu hot-unplug, the kernel would call
drain_obj_stock() with objcg local lock. However local lock was not
needed as the stock which was accessed belongs to a dead cpu but we kept
it there to disable irqs as drain_obj_stock() may call
mod_objcg_mlstate() which required irqs disabled. However there is no
need to disable irqs now for mod_objcg_mlstate(), so we can remove the
local lock altogether from cpu hot-unplug path.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/memcontrol.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1071db0b1df8..04d756be708b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2025,17 +2025,8 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 
 static int memcg_hotplug_cpu_dead(unsigned int cpu)
 {
-	struct obj_stock_pcp *obj_st;
-	unsigned long flags;
-
-	obj_st = &per_cpu(obj_stock, cpu);
-
-	/* drain_obj_stock requires objstock.lock */
-	local_lock_irqsave(&obj_stock.lock, flags);
-	drain_obj_stock(obj_st);
-	local_unlock_irqrestore(&obj_stock.lock, flags);
-
 	/* no need for the local lock */
+	drain_obj_stock(&per_cpu(obj_stock, cpu));
 	drain_stock_fully(&per_cpu(memcg_stock, cpu));
 
 	return 0;
-- 
2.47.1


