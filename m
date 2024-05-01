Return-Path: <cgroups+bounces-2741-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E496C8B8847
	for <lists+cgroups@lfdr.de>; Wed,  1 May 2024 11:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE6B283ADC
	for <lists+cgroups@lfdr.de>; Wed,  1 May 2024 09:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4339651C2A;
	Wed,  1 May 2024 09:54:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A463F8D1;
	Wed,  1 May 2024 09:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714557274; cv=none; b=GkA2gMCrX2kQMau8RUP7lhZAc4AF1B58P+989+cA1X+9REHv4l7bd0m8QheBBc4L4zIhm7Lpgafmd+nnv0bFgfcVa3/Uy856sMArTRpQ5fsxLYGKtcv1H3NomDNzujgLkhUKzWD4dlE2St5I5CCl37Y302w6wn8KlWP8Qx7lUnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714557274; c=relaxed/simple;
	bh=fjHyRUL7YP0isUZEI5cMAO42zj1xrbSUasGtrUqaUe4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ULoswf5SQlCdzYCN0Syr0gBYNRxQOcH4vIh1c1qAK9A7qxlUHpeSYHSeo5d8/xKIDLHqLRaBfFD9KN+6vDuNueGJVedMdr93VV3nJGS9Bj/DT0XPjZ7eDXllvYL2ZY4vRiIeOUxTvfNoI9ffE0U4yt7YCQflFKJrw8Y3+se+LIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a55ab922260so866252366b.3;
        Wed, 01 May 2024 02:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714557271; x=1715162071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WW4YFzextgKm5BBgMPVLqw63E3+hwQm6VSxunaunImg=;
        b=sxHCqJX3CzQhwZ4uIDIFN7r8f/fboJ1zbu2aHvJGjgy5EcA8cRfHzu+C+pb3CySJXi
         +mUmdrZbv2JO5OHrFTPbEoKqaZ441w6P6kLSX+zUCdTJ72e/0u6a/hEZZBK0dyzv8ITx
         Bl+JiI72PYvGur8VFiSvBowvv/sEmqeXyocGyoS1N66yi0vjyVSOVeVlajVGB/YtUUwQ
         EaqERFBfQ0io5jlmvtA312fY4/3QirnSnjwigHomT0hia3YTsXHik4gJ3UkhKJIhyFW+
         B1fEZdIwH4F6kPD36F8Iquo8gkIo0PZ150Jl91e/f9P7ruDjP/QRzVJaiFi4AHd7JRU9
         hAOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2cR/i6uw2BUj0RtrjFkAbPSahuSvWBl9ZZV2rzxr7i8ZEdOV+RHmYRqvx3Da5GHkEJmiH+SAc8Ts/4KfKOhiKLp74EE0xTIPZxCGLCtNyLF+NBl7bHpCa11nU/3fWqzKRnv1iqw==
X-Gm-Message-State: AOJu0YwrO3RHcwLRhMliWKHYBiyLLI4sBKKjXreJnaUHFpj2cwv4v+Z0
	affspa8zEC3qfJv1KCUDpz7WGh7h6wPQYJSZAkpUtAT5ucGa9eGg
X-Google-Smtp-Source: AGHT+IFslaSpA43sRj0374yg9dqVLoR6TIA5xhmPQL4CDOEGxNr4bzGxXsIGDpXERDabnIuw8Z9npQ==
X-Received: by 2002:a17:906:6d55:b0:a58:c559:3c83 with SMTP id a21-20020a1709066d5500b00a58c5593c83mr1642315ejt.59.1714557270581;
        Wed, 01 May 2024 02:54:30 -0700 (PDT)
Received: from localhost (fwdproxy-lla-118.fbsv.net. [2a03:2880:30ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id n26-20020a1709061d1a00b00a525860ecc5sm16074917ejh.180.2024.05.01.02.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 02:54:30 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: paulmck@kernel.org,
	cgroups@vger.kernel.org (open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)),
	linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mm: memcg: use READ_ONCE()/WRITE_ONCE() to access stock->nr_pages
Date: Wed,  1 May 2024 02:54:20 -0700
Message-ID: <20240501095420.679208-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A memcg pointer in the per-cpu stock can be accessed by drain_all_stock()
and consume_stock() in parallel, causing a potential race.

KCSAN shows this data-race clearly in the splat below:

	BUG: KCSAN: data-race in drain_all_stock.part.0 / try_charge_memcg

	write to 0xffff88903f8b0788 of 4 bytes by task 35901 on cpu 2:
	try_charge_memcg (mm/memcontrol.c:2323 mm/memcontrol.c:2746)
	__mem_cgroup_charge (mm/memcontrol.c:7287 mm/memcontrol.c:7301)
	do_anonymous_page (mm/memory.c:1054 mm/memory.c:4375 mm/memory.c:4433)
	__handle_mm_fault (mm/memory.c:3878 mm/memory.c:5300 mm/memory.c:5441)
	handle_mm_fault (mm/memory.c:5606)
	do_user_addr_fault (arch/x86/mm/fault.c:1363)
	exc_page_fault (./arch/x86/include/asm/irqflags.h:37
		        ./arch/x86/include/asm/irqflags.h:72
			arch/x86/mm/fault.c:1513
			arch/x86/mm/fault.c:1563)
	asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:623)

	read to 0xffff88903f8b0788 of 4 bytes by task 287 on cpu 27:
	drain_all_stock.part.0 (mm/memcontrol.c:2433)
	mem_cgroup_css_offline (mm/memcontrol.c:5398 mm/memcontrol.c:5687)
	css_killed_work_fn (kernel/cgroup/cgroup.c:5521 kernel/cgroup/cgroup.c:5794)
	process_one_work (kernel/workqueue.c:3254)
	worker_thread (kernel/workqueue.c:3329 kernel/workqueue.c:3416)
	kthread (kernel/kthread.c:388)
	ret_from_fork (arch/x86/kernel/process.c:147)
	ret_from_fork_asm (arch/x86/entry/entry_64.S:257)

	value changed: 0x00000014 -> 0x00000013

This happens because drain_all_stock() is reading stock->nr_pages, while
consume_stock() might be updating the same address, causing a potential
data-race.

Make the shared addresses bulletproof regarding to reads and writes,
similarly to what stock->cached_objcg and stock->cached.
Annotate all accesses to stock->nr_pages with READ_ONCE()/WRITE_ONCE().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 mm/memcontrol.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fabce2b50c69..d3befe3b62fa 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2310,6 +2310,7 @@ static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages)
 static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	struct memcg_stock_pcp *stock;
+	unsigned int stock_pages;
 	unsigned long flags;
 	bool ret = false;
 
@@ -2319,8 +2320,9 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	local_lock_irqsave(&memcg_stock.stock_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
-	if (memcg == READ_ONCE(stock->cached) && stock->nr_pages >= nr_pages) {
-		stock->nr_pages -= nr_pages;
+	stock_pages = READ_ONCE(stock->nr_pages);
+	if (memcg == READ_ONCE(stock->cached) && stock_pages >= nr_pages) {
+		WRITE_ONCE(stock->nr_pages, stock_pages - nr_pages);
 		ret = true;
 	}
 
@@ -2334,16 +2336,18 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
  */
 static void drain_stock(struct memcg_stock_pcp *stock)
 {
+	unsigned int stock_pages = READ_ONCE(stock->nr_pages);
 	struct mem_cgroup *old = READ_ONCE(stock->cached);
 
 	if (!old)
 		return;
 
-	if (stock->nr_pages) {
-		page_counter_uncharge(&old->memory, stock->nr_pages);
+	if (stock_pages) {
+		page_counter_uncharge(&old->memory, stock_pages);
 		if (do_memsw_account())
-			page_counter_uncharge(&old->memsw, stock->nr_pages);
-		stock->nr_pages = 0;
+			page_counter_uncharge(&old->memsw, stock_pages);
+
+		WRITE_ONCE(stock->nr_pages, 0);
 	}
 
 	css_put(&old->css);
@@ -2380,6 +2384,7 @@ static void drain_local_stock(struct work_struct *dummy)
 static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	struct memcg_stock_pcp *stock;
+	unsigned int stock_pages;
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (READ_ONCE(stock->cached) != memcg) { /* reset if necessary */
@@ -2387,9 +2392,10 @@ static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		css_get(&memcg->css);
 		WRITE_ONCE(stock->cached, memcg);
 	}
-	stock->nr_pages += nr_pages;
+	stock_pages = READ_ONCE(stock->nr_pages) + nr_pages;
+	WRITE_ONCE(stock->nr_pages, stock_pages);
 
-	if (stock->nr_pages > MEMCG_CHARGE_BATCH)
+	if (stock_pages > MEMCG_CHARGE_BATCH)
 		drain_stock(stock);
 }
 
@@ -2428,7 +2434,7 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 
 		rcu_read_lock();
 		memcg = READ_ONCE(stock->cached);
-		if (memcg && stock->nr_pages &&
+		if (memcg && READ_ONCE(stock->nr_pages) &&
 		    mem_cgroup_is_descendant(memcg, root_memcg))
 			flush = true;
 		else if (obj_stock_flush_required(stock, root_memcg))
-- 
2.43.0


