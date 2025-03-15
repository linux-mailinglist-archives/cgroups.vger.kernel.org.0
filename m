Return-Path: <cgroups+bounces-7088-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 657EFA6310D
	for <lists+cgroups@lfdr.de>; Sat, 15 Mar 2025 18:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABB916F4A7
	for <lists+cgroups@lfdr.de>; Sat, 15 Mar 2025 17:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4132054F4;
	Sat, 15 Mar 2025 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LVtOFiDf"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DDF205E32
	for <cgroups@vger.kernel.org>; Sat, 15 Mar 2025 17:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742060997; cv=none; b=AWc3JAuFFhYm6YtvugpFBizcgsh/xpo5/WFK4OP00rHHAGTYNvPsCx/hMNr8y+jLrhr3ma8cQSFIR0UW22KmxEaCItZmHaZNbIdHiAZ/9Z/l2U0IqoQQdG6QSBQOj7KmkvOszESkDEB6NfH7niILhK47YCoMcE9ntLH0nawqyNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742060997; c=relaxed/simple;
	bh=rR4VRO/qCn9tibn4IiHZRnKTQxDzvVTiAx2JBG5cZJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eFyjQsXm317Q1D79elWX9ri4qgFWGZic4Ck61o1EWTXltZxzHRhbXlajyBHbLrriRFjf42I91Cw4biurNKHxmxqC4PSSwIPwV3z6a8rfaylhDHFtwDj45UoA4BogNfR5Ut7pbwiXNniUBAT0xqIneuB4/hS8iXydUs199HmnRIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LVtOFiDf; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742060984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cmS5hv6xwjGOhhAkz0IaR50zSoZuuoSBRO/S5eqp4mA=;
	b=LVtOFiDfJTfbraclra86x+fCaQarFRpDuvgbtcbJPyfEGkmeTvyYet4jd9Nwe7MYVclJnn
	uuJLQQVD62W9ZBqiSKhDpcCrLRrD//QYT9PyfmzobpzgN56PeZJewgqDV+tc22Dfa0cBft
	3TEADM+PDuzpeOAVrq4zauWky81Tgxs=
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
Subject: [PATCH 1/9] memcg: remove root memcg check from refill_stock
Date: Sat, 15 Mar 2025 10:49:22 -0700
Message-ID: <20250315174930.1769599-2-shakeel.butt@linux.dev>
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

refill_stock can not be called with root memcg, so there is no need to
check it.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b29433eb17fa..c09a32e93d39 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1883,6 +1883,7 @@ static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		drain_stock(stock);
 }
 
+/* Should never be called with root_mem_cgroup. */
 static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	unsigned long flags;
@@ -1892,8 +1893,6 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
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


