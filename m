Return-Path: <cgroups+bounces-7349-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 682D7A7B579
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 03:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F3A1899ED4
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 01:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5225477F;
	Fri,  4 Apr 2025 01:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gtp/lT7A"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A0817578
	for <cgroups@vger.kernel.org>; Fri,  4 Apr 2025 01:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743730778; cv=none; b=XSaV5fQRG9jXoy4nkaMX7DD8F73YDZPa2Ad7wi6z4hQ9m15k4qqEjVfpVzSfumVJ7Cn9EHv0pj9F81SEHNR7W7CflrqHFbHnvt3toEDJaPYAcQunpPCUGOy/azS8GIAAWy9ig10QSeXLVMjl5u37zJXOKkylnvOSEwmMMRWWSaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743730778; c=relaxed/simple;
	bh=Wt9frfyEWA8VJjXPXQvYvV1auqH17c8eWrrofBDNj+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyrYUjYo0OOyTJJfYJCJ89NHRse1dc4jPqarEJTxjENGHpDHEmDVPSTJdXA+JYFl9d6cwEO/7zVSVbLeiGfGgX7vIxnbOoKLRUk3E/9zjs5uAef/w8X00grTjdqNGTvNaAeMciK/gWmdnsLMbwYsw+pjL5c651oDGpH5dsvsugc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gtp/lT7A; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743730773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Umv4btRy/nEoNx2OIY9ZLc4o2g+KibZrAp3iooZEy6Y=;
	b=Gtp/lT7ARKgjwmrfUuMxwEW+dvted/jx4y+oaBXV12gQbAtjbE8JtTP3C+4yGfOpV4rVeI
	zGYBza0gUb2vsRxmh6rV2dHte5ZmqbcQmI0Clp8KzTFduq0UEOnqRA/K9SlVURO2f6fy75
	aLWZys/FK/LwV7mCWlcNJVI/EbRZjuk=
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
Subject: [PATCH v2 1/9] memcg: remove root memcg check from refill_stock
Date: Thu,  3 Apr 2025 18:39:05 -0700
Message-ID: <20250404013913.1663035-2-shakeel.butt@linux.dev>
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

refill_stock can not be called with root memcg, so there is no need to
check it. Instead add a warning if root is ever passed to it.

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b16b5b807d7c..ae1e953cead7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1893,13 +1893,13 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	unsigned long flags;
 
+	VM_WARN_ON_ONCE(mem_cgroup_is_root(memcg));
+
 	if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
 		/*
 		 * In case of unlikely failure to lock percpu stock_lock
 		 * uncharge memcg directly.
 		 */
-		if (mem_cgroup_is_root(memcg))
-			return;
 		page_counter_uncharge(&memcg->memory, nr_pages);
 		if (do_memsw_account())
 			page_counter_uncharge(&memcg->memsw, nr_pages);
-- 
2.47.1


