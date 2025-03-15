Return-Path: <cgroups+bounces-7086-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D46A630FE
	for <lists+cgroups@lfdr.de>; Sat, 15 Mar 2025 18:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBB33AAA0D
	for <lists+cgroups@lfdr.de>; Sat, 15 Mar 2025 17:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F78F2054FC;
	Sat, 15 Mar 2025 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ejy9vqLu"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF43204F8A
	for <cgroups@vger.kernel.org>; Sat, 15 Mar 2025 17:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742060990; cv=none; b=E3Lc7/ly8teemsTDdUdNsdFxVqkiFl5XaIu3fGTfvs7mEDvLYTY7yuhMO+dFD31dEC41OV5v7IxeCitr/y1ZCh6M0mROCbkjTFgLO5EPWBqLkWG1bY0F/Z/N0Qdjqb0caqrpCBvd793qonuhXhxfTCGTXPKkHrCq8NGv6aibtX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742060990; c=relaxed/simple;
	bh=7GVz3MJvICmIWhsoo81qI+uaCmHIr1hzLPA6oLWv2RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkFo6fafh05nUAJkyCP/4SccH0naBEE0OGI1T2G2sl07heMftGW3GVEISnLwDmpkLpr7wxlGXGR8hoj6JlWWANqeknz/PqhGxyzRbJ41iTjjG7WXWIzdF/cMFcqWrWA15Ua+bWDDaNMjEgLyg++w3dzix1zDOyyGcmha17o2r6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ejy9vqLu; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742060986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oUGjl5IUOeohrue8CflY3qReHtC2T034o0a04sP/4ac=;
	b=Ejy9vqLuhMtkzwYa4BWZ2IiChp1s5sstyd4OAgBMSkax1T0pVT20KV+VkvWvY5R0mCrrCA
	CWNQcrKeNlCZoz9SnQEPbL3cjNDbBmqiM/2TtzFlraiYrRnTqDXLQBiBdgjMSa88A7UtW7
	qGO2/7k9JcdwLvf0v1aCNfGdPeArjgs=
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
Subject: [PATCH 2/9] memcg: decouple drain_obj_stock from local stock
Date: Sat, 15 Mar 2025 10:49:23 -0700
Message-ID: <20250315174930.1769599-3-shakeel.butt@linux.dev>
In-Reply-To: <20250315174930.1769599-1-shakeel.butt@linux.dev>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently drain_obj_stock() can potentially call __refill_stock which
accesses local cpu stock and thus requires memcg stock's local_lock.
However if we look at the code paths leading to drain_obj_stock(), there
is never a good reason to refill the memcg stock at all from it.

At the moment, drain_obj_stock can be called from reclaim, hotplug cpu
teardown, mod_objcg_state() and refill_obj_stock(). For reclaim and
hotplug there is no need to refill. For the other two paths, most
probably the newly switched objcg would be used in near future and thus
no need to refill stock with the older objcg.

In addition, __refill_stock() from drain_obj_stock() happens on rare
cases, so performance is not really an issue. Let's just uncharge
directly instead of refill which will also decouple drain_obj_stock from
local cpu stock and local_lock requirements.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/memcontrol.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c09a32e93d39..28cb75b5bc66 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2855,7 +2855,12 @@ static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
 
 			mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
 			memcg1_account_kmem(memcg, -nr_pages);
-			__refill_stock(memcg, nr_pages);
+			if (!mem_cgroup_is_root(memcg)) {
+				page_counter_uncharge(&memcg->memory, nr_pages);
+				if (do_memsw_account())
+					page_counter_uncharge(&memcg->memsw,
+							      nr_pages);
+			}
 
 			css_put(&memcg->css);
 		}
-- 
2.47.1


