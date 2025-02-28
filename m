Return-Path: <cgroups+bounces-6738-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91184A48E87
	for <lists+cgroups@lfdr.de>; Fri, 28 Feb 2025 03:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4280916EAC8
	for <lists+cgroups@lfdr.de>; Fri, 28 Feb 2025 02:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EB114A09E;
	Fri, 28 Feb 2025 02:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rs+9tShZ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178353596A
	for <cgroups@vger.kernel.org>; Fri, 28 Feb 2025 02:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740709451; cv=none; b=tgIgcBFMDgueigck2t/tovvuUVj/PoQR+AnAr37mayalm050L6BaKRPdMVczzDsp4aUStQuDKaseICidROSLF9i/6r7nyToF0mtcl1ZEWpur03jQgen0fiIbMr7w3DOK9BJZfc7S7ELYQ4QI5c3vahmXQzu7SL6tP5nSDjZiko4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740709451; c=relaxed/simple;
	bh=t+z+Ab5hCBy0d3nX2BW88pd29C4FlZnEv8vt1DthmI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kF3Umik3mkuIgQXSm/HRTq8A2R6xVOVf5URxKAYZ2qsBdZoNT3YwomoReYYLO1sf2FoI6AFQq9HACewIFDdutMaO4yyjSVEGZvMRww+o1tcRx1Nhy8GCYd4HK3qM0E3XjBbp3vfsks0PEiDJg5q4TwBibboLJlhE29AWyPJwhwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rs+9tShZ; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740709445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9qFzyRfTPW1C1fRHIqsxr2Zjz7ISCd8XwmKzi9XRiC8=;
	b=rs+9tShZb+fPHx4CoGGzSymGkA9Ypd47eJItJS1loSkNgOz0npB/+TJ2u8BwU1qUfKNZnn
	reOdn3qAUbVW/fTm7504Fg1fGf1w8nbCzlM7EETpDR98cfdRcrfif3oWRmNJI5UkgY4oGI
	B9InCh/wppTkkvPwDWT3J6jkS7AJ348=
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
Subject: [PATCH] memcg: bypass root memcg check for skmem charging
Date: Thu, 27 Feb 2025 18:23:54 -0800
Message-ID: <20250228022354.2624249-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The root memcg is never associated with a socket in mem_cgroup_sk_alloc,
so there is no need to check if the given memcg is root for the skmem
charging code path.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f571c67ab088..55b0e9482c00 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4879,7 +4879,7 @@ bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return memcg1_charge_skmem(memcg, nr_pages, gfp_mask);
 
-	if (try_charge(memcg, gfp_mask, nr_pages) == 0) {
+	if (try_charge_memcg(memcg, gfp_mask, nr_pages) == 0) {
 		mod_memcg_state(memcg, MEMCG_SOCK, nr_pages);
 		return true;
 	}
-- 
2.43.5


