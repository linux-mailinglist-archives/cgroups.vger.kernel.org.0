Return-Path: <cgroups+bounces-7052-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B97EA60908
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 07:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E73219C12C0
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 06:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483471632D3;
	Fri, 14 Mar 2025 06:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FeQvgZ0y"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16A92AEE1
	for <cgroups@vger.kernel.org>; Fri, 14 Mar 2025 06:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932936; cv=none; b=o7VO0HFyiGt7d51vF1HBC4IEef6zUyIoWPBYJYbhKf650hhg5Xy2Ebmav11VugOntV7StPpTDDshrOU7TZ085mw++xfisjgrDJh1DogqRmWWmcGuM24ZhXsJC0slpofJxRTyA9GoRrEkufS7Cud6YNQkkPwtvkLDx+58NlO/tIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932936; c=relaxed/simple;
	bh=W/+dT0JeMfCNVWYLzWA9JLxOlfjfaJDgqzXPPWZp9qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhqOA3rSnFk2dcb0A58hkA4BPsACT9n2Sq90yqPgMnIIuLtsn74jiA8Cur1CyJbCwYJwiYdrh3k+T3qIbcRNDBjHBnoHRZ+SMBThcVYiy3Fi2U7jb9T2DXqucQ7+iNywXmQ8NGRPz2e5wTbynU4G/RFfjODOnwe7iwusW+TP28A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FeQvgZ0y; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741932932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4gcQPtwIR/hVm1yRr4cRacE1bGrzLqevTybXQMDqJ14=;
	b=FeQvgZ0yXEZ1YmVQs936nWoNHKfUiPJcFKFvpqK16/CwDxmnMaVmA7QENZTzMSIQbHs7WV
	BdIx05IJWLFoRUTmqjG0ITtgCcDG/oQDslGjV7+zAa+Ar1pyCIytzoVik0svc/mmlR+U1G
	xzLDhIBey5JN/Ok/Tv5oW3YZhsF2aIA=
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
Subject: [RFC PATCH 02/10] memcg: decouple drain_obj_stock from local stock
Date: Thu, 13 Mar 2025 23:15:03 -0700
Message-ID: <20250314061511.1308152-3-shakeel.butt@linux.dev>
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


