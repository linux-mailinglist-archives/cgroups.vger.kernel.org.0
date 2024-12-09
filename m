Return-Path: <cgroups+bounces-5786-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D82A09E9D49
	for <lists+cgroups@lfdr.de>; Mon,  9 Dec 2024 18:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF1D218872AA
	for <lists+cgroups@lfdr.de>; Mon,  9 Dec 2024 17:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5871552EE;
	Mon,  9 Dec 2024 17:44:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CED14B077;
	Mon,  9 Dec 2024 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766286; cv=none; b=UubqS8unB5vogkqZ7lyoc9xayM/hqQIjAKLDRnEaT4ICUJpWaoJkPqBgO6g9FDfaRl6XNW2hn/ns/mK6IvbB3VkP1EN5YU6Cm8H9tW1GmV6kxEtsMRBxwWjeyYmMUl2ESdNHKB/RskaBIrETNFr4BWNlTAnaMgDmK2l5A9UjGPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766286; c=relaxed/simple;
	bh=ctEk7vED6J0clSTPSfX+Yoo7x5NNwaJto1rvh/9GcJA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bLIzEg/wDCbvf3Q3HtpUjEXP3YNgKTuWAF/8UyVi2QRhbi6+o6WLpjX4jVAHqA9kUvuNmgxE1vlB08nWrZ8cWkLFcu6McyVekOgM805HCx94WVo9chYuu2vu07hiuNFlBuacHX8suUMAymwmRgf7+okebxehk8iCWkgcD/OBquY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:82e7:cf5d:dfd9:50ef] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tKhmE-0000000017H-24VO;
	Mon, 09 Dec 2024 12:42:34 -0500
Date: Mon, 9 Dec 2024 12:42:33 -0500
From: Rik van Riel <riel@surriel.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Muchun
 Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 cgroups@vger.kernel.org
Subject: [PATCH] mm: allow exiting processes to exceed the memory.max limit
Message-ID: <20241209124233.3543f237@fangorn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@surriel.com

It is possible for programs to get stuck in exit, when their
memcg is at or above the memory.max limit, and things like
the do_futex() call from mm_release() need to page memory in.

This can hang forever, but it really doesn't have to.

The amount of memory that the exit path will page into memory
should be relatively small, and letting exit proceed faster
will free up memory faster.

Allow PF_EXITING tasks to bypass the cgroup memory.max limit
the same way PF_MEMALLOC already does.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 mm/memcontrol.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7b3503d12aaf..d1abef1138ff 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2218,11 +2218,12 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 
 	/*
 	 * Prevent unbounded recursion when reclaim operations need to
-	 * allocate memory. This might exceed the limits temporarily,
-	 * but we prefer facilitating memory reclaim and getting back
-	 * under the limit over triggering OOM kills in these cases.
+	 * allocate memory, or the process is exiting. This might exceed
+	 * the limits temporarily, but we prefer facilitating memory reclaim
+	 * and getting back under the limit over triggering OOM kills in
+	 * these cases.
 	 */
-	if (unlikely(current->flags & PF_MEMALLOC))
+	if (unlikely(current->flags & (PF_MEMALLOC | PF_EXITING)))
 		goto force;
 
 	if (unlikely(task_in_memcg_oom(current)))
-- 
2.47.0


