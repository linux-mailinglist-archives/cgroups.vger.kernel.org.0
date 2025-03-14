Return-Path: <cgroups+bounces-7051-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890ECA60905
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 07:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60F457A11B3
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 06:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6364615749C;
	Fri, 14 Mar 2025 06:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IFAk3ny3"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1264566A
	for <cgroups@vger.kernel.org>; Fri, 14 Mar 2025 06:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932933; cv=none; b=PwFp2zzZQxBE8QQ7QIh6sZLcU0JF7oV36VYOERWY91MDAhOY/PF5ZIcIVAvZCk349rMab+RljS1VmYmvYjQ6JO7qsbiFV4Ojug+z9APqtaty6vgloqwcVqLJtcaf41x+GTpYI9YVNueCJhMPpLFUTP8nS6ltfHW1yZRh88EB7Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932933; c=relaxed/simple;
	bh=rR4VRO/qCn9tibn4IiHZRnKTQxDzvVTiAx2JBG5cZJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1chhc3hgqpNicCeG6h11v0xZ9ostsUrvRl9NbZeQj+u/71CLDHoRVJ7W0+xh09s97SypezrP4sdlMkPQ71o2DTjd/rlfmloe5TpB7I+UmmyHBkc2nFxkSTbKFez3VCpozsHfm7trM+MIPduSQMI2GNOM9SBvk4EoRQJi+woTFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IFAk3ny3; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741932928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cmS5hv6xwjGOhhAkz0IaR50zSoZuuoSBRO/S5eqp4mA=;
	b=IFAk3ny3UqE/iQCJa7lOm0f18gE7d5o7rhlz8Rsi6NYU4Rbjj03rJ/JizQmPAY0O6BVqup
	yEGTkuAJggm5Z9B13K0mwm3oUigTkR+xQtR8TVgwbpmnqyYUpzzkXSWkBOkqt3KwZEJQDf
	A6ZNhSvExzpbiw9PsZYYi1jj0cgmXsA=
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
Subject: [RFC PATCH 01/10] memcg: remove root memcg check from refill_stock
Date: Thu, 13 Mar 2025 23:15:02 -0700
Message-ID: <20250314061511.1308152-2-shakeel.butt@linux.dev>
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


