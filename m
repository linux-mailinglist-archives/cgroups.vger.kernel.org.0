Return-Path: <cgroups+bounces-7031-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD450A5EB47
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 06:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347501739C8
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 05:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89A61531DB;
	Thu, 13 Mar 2025 05:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ISR4blKM"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FA812F399
	for <cgroups@vger.kernel.org>; Thu, 13 Mar 2025 05:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741844902; cv=none; b=WCjWSLsN43FmnMiCdu+T7xB/reRtusQT7MyCdJRcgx4KhCaQ37KIzdSLOeFEbI+s3jo83sZpuumMIDsPqzzy0NeGqtfx/fYf7Mwu9yVgPrGdJKkAf4SFJO9ikVtb+TFsIzjEMDS7LZ7zgN/9nNmzUqW/pjoEedpPt3CbAzohW58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741844902; c=relaxed/simple;
	bh=Y81T/0tN+oB0qmAPDllz5PACPLuoxGpwd/0r1MySa+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mMkKDpGK45KmoUJSnLt6ZjSYVJoDNXC62QrkMxBjnmrl2WBzlimUMlRTQAQULuC9B7jQfzHGwnV5doLZtO9CDuDivb5FxEB4an1mXgwJcUJ2VyxUA/3uBTbSE9YMQr8eLEZ8DVx1PBDCre8tHRyb6nH768sbHRzqxQPLOqqLQ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ISR4blKM; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741844898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+8crqbD29LSFVEIGtcAdrNxdm4twGCIk3Dwd45ote5E=;
	b=ISR4blKMWbn1Gw1Y7OO9kCorcO7ZLrAbHXWZBgblKZdMfChIsp8oZ1KwNGXICgyCG38BPX
	0Z/0WjlHlK29AG2uiilYcnTyeRlGdojdRdlwDiSLkNCnJfXSemQu69HF3w08qj+UWdqKcv
	L3W+SoYDjwVURSZnGuHYcx7xUGhNjRY=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH] memcg: avoid refill_stock for root memcg
Date: Wed, 12 Mar 2025 22:48:12 -0700
Message-ID: <20250313054812.2185900-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We never charge the page counters of root memcg, so there is no need to
put root memcg in the memcg stock. At the moment, refill_stock() can be
called from try_charge_memcg(), obj_cgroup_uncharge_pages() and
mem_cgroup_uncharge_skmem().

The try_charge_memcg() and mem_cgroup_uncharge_skmem() are never called
with root memcg, so those are fine. However obj_cgroup_uncharge_pages()
can potentially call refill_stock() with root memcg if the objcg object
has been reparented over to the root memcg. Let's just avoid
refill_stock() from obj_cgroup_uncharge_pages() for root memcg.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e08ce52caabd..393b73aec6dd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2643,7 +2643,8 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 
 	mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
 	memcg1_account_kmem(memcg, -nr_pages);
-	refill_stock(memcg, nr_pages);
+	if (!mem_cgroup_is_root(memcg))
+		refill_stock(memcg, nr_pages);
 
 	css_put(&memcg->css);
 }
-- 
2.47.1


