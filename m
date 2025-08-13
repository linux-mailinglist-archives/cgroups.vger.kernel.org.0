Return-Path: <cgroups+bounces-9132-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9918BB24CCB
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 17:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E17188EE62
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 15:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E719E2FF143;
	Wed, 13 Aug 2025 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I3u5d4XV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BPoRvRPO"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4002FE583;
	Wed, 13 Aug 2025 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755097081; cv=none; b=X2SJh83KFt3yBu8uKs72iDb1MZzmSJUcosCv8ilJkIbrXQOR3+SLL1R1SJzkcQxlk05Y+aDCEcfCQYWQ145ndTvJnCq7ygUpIaNeTNcvKv03m3mVHt5o8eo4q3kO6BH7/XwvUMDILz+B6xSzfMgtAROuHeQ3sfKXrIdGw8RW1fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755097081; c=relaxed/simple;
	bh=I2IWMtoFl5keplxHSLJtItCr7nzwxIzEBEtLkTKoLhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k3+e1CZGAVyTv13iG1aEhHSGGlzuskxEq0oP/gQw4smr2B8iZInxLFSw9GEwUmOdBpalRd5Cuz2MrN79mOL5EAQyShnXkRo1f/V3duuoN63zDWDxmb7fKG+QR5nNJMWoVOIyzOn4TAQ+jVauvuEET5tfwqKjUMpMqSsBGrhtPyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I3u5d4XV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BPoRvRPO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755097076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=LK0fse9piQMDsNEawnHa17CJtTGb1+S7lgjGFKtF0tc=;
	b=I3u5d4XVCbp9sJAiqzUxxnN8jogvVz330rmXlvPc4EIs9kOtcf3Mj8uSjIxg1fRTrbwecl
	TMhr5g/y26FthJ72gtEwrU4u6dRhFhPmFvZEuofvCR2S34BZx0XaO71/N7GdY3Si7KdKQH
	rRll7+2m0QLENvmItC7EZWe2cT/j1aiQ6gFxiMmD1YFmNrWvCltHacGpPwgXO0KxHf97IA
	wynDG8BsBzIwHDNhNCP7ES+PQV4KCfRw73ymS0am7NjJRjrB20+Ua//P3TMmK8Xia9SQNY
	/xlAJETgVH3RXlHC8LNh3uYz9R0F8OR6g5b5Bwckh4QWwwVqXxslL1lpiee33Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755097076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=LK0fse9piQMDsNEawnHa17CJtTGb1+S7lgjGFKtF0tc=;
	b=BPoRvRPOD4TmXUa3bcE7pvCwZh4VhvmvEvaz/Zod57Zu5kVP4MdtmFgc2nUPCdQq1DcUDv
	jEKTQlAF2z04ZwDw==
To: linux-mm@kvack.org
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko
 <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Shakeel
 Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 cgroups@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] memcg: Optimize exit to user space
Date: Wed, 13 Aug 2025 16:57:55 +0200
Message-ID: <87tt2b6zgs.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

memcg uses TIF_NOTIFY_RESUME to handle reclaiming on exit to user
space. TIF_NOTIFY_RESUME is a multiplexing TIF bit, which is utilized by
other entities as well.

This results in a unconditional mem_cgroup_handle_over_high() call for
every invocation of resume_user_mode_work(), which is a pointless
exercise as most of the time there is no reclaim work to do.

Especially since RSEQ is used by glibc, TIF_NOTIFY_RESUME is raised
quite frequently and the empty calls show up in exit path profiling.

Optimize this by doing a quick check of the reclaim condition before
invoking it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/memcontrol.h |    8 +++++++-
 mm/memcontrol.c            |    4 ++--
 2 files changed, 9 insertions(+), 3 deletions(-)

--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -900,7 +900,13 @@ unsigned long mem_cgroup_get_zone_lru_si
 	return READ_ONCE(mz->lru_zone_size[zone_idx][lru]);
 }
 
-void mem_cgroup_handle_over_high(gfp_t gfp_mask);
+void __mem_cgroup_handle_over_high(gfp_t gfp_mask);
+
+static inline void mem_cgroup_handle_over_high(gfp_t gfp_mask)
+{
+	if (unlikely(current->memcg_nr_pages_over_high))
+		__mem_cgroup_handle_over_high(gfp_mask);
+}
 
 unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg);
 
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2203,7 +2203,7 @@ static unsigned long calculate_high_dela
  * try_charge() (context permitting), as well as from the userland
  * return path where reclaim is always able to block.
  */
-void mem_cgroup_handle_over_high(gfp_t gfp_mask)
+void __mem_cgroup_handle_over_high(gfp_t gfp_mask)
 {
 	unsigned long penalty_jiffies;
 	unsigned long pflags;
@@ -2486,7 +2486,7 @@ static int try_charge_memcg(struct mem_c
 	if (current->memcg_nr_pages_over_high > MEMCG_CHARGE_BATCH &&
 	    !(current->flags & PF_MEMALLOC) &&
 	    gfpflags_allow_blocking(gfp_mask))
-		mem_cgroup_handle_over_high(gfp_mask);
+		__mem_cgroup_handle_over_high(gfp_mask);
 	return 0;
 }
 

