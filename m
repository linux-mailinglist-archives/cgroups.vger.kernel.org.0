Return-Path: <cgroups+bounces-7059-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A461A6091A
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 07:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74CDE3BFACF
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 06:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98869198E77;
	Fri, 14 Mar 2025 06:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vhAfmg//"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3278E78F3A
	for <cgroups@vger.kernel.org>; Fri, 14 Mar 2025 06:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932954; cv=none; b=fMz7W+kRVwg46oAOMa2+yDZwaesGWi/x4kEEdAyJjgEWvTpkunKu9aY8NRtKnDjI/F6nlXGtckLo7PKmCUS6QiO7WBKbsNXq/njAQCD1EOER4zwYFxPHnMvAaAvps3rYhfUHmchW8aTEQyKrP94nGxBAdcDTH5cdSxqTi6PAlRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932954; c=relaxed/simple;
	bh=DOSr7hMbbaWwE7vTOYq2OQeJLGOdT9916XhVh5YD7mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vqax2Zr23zRUtPqerO5SPxEGp6K8GCTIzR58avsw+86uQwxSifc2J3vjvcsxkRbD642wwXs9d3z4pDA6NzqERwJnTpg3rOIrvAPus6G4wNS8ditHVv/aeZbHHuYfmi4z2rwm+A2ktBYlaCg3iu0dbIXuaTd/99KtLZ+ASiT5xMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vhAfmg//; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741932950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5fE+tfATBs+u3OomjlvcpPVaZLFEEe7to/tRcynNlOg=;
	b=vhAfmg//mk5ht4EXslf1UpxrBhoU+6iHYa0Fdob5JRoSmvL+p5JjLl+AsS2rCYbTMyvkEM
	Uk2TH3CtPmlMCFALAhBM+VV80oT4jcCeobDv8g/awWwP8Xvz3ivJmp4jmuhu6Wr1xd0gwF
	/Ajsj8Phh2rDKYPW9ZJL0S9rCQRj/i0=
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
Subject: [RFC PATCH 08/10] memcg: assert in_task for couple of local_lock holders
Date: Thu, 13 Mar 2025 23:15:09 -0700
Message-ID: <20250314061511.1308152-9-shakeel.butt@linux.dev>
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

The drain_local_stock() and memcg_hotplug_cpu_dead() only run in task
context, so there is no need to localtry_trylock_irqsave() the local
stock_lock in those functions. The plan is to convert all stock_lock
users which can be called in multiple context to use
localtry_trylock_irqsave() and subsequently switch to non-irq disabling
interface. So, for functions which are never called in non-task context,
this patch adds the asserts.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index dfe9c2eb7816..c803d2f5e322 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1857,6 +1857,8 @@ static void drain_local_stock(struct work_struct *dummy)
 	struct memcg_stock_pcp *stock;
 	unsigned long flags;
 
+	lockdep_assert_once(in_task());
+
 	/*
 	 * The only protection from cpu hotplug (memcg_hotplug_cpu_dead) vs.
 	 * drain_stock races is that we always operate on local CPU stock
@@ -1953,6 +1955,8 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 	struct memcg_stock_pcp *stock;
 	unsigned long flags;
 
+	lockdep_assert_once(in_task());
+
 	stock = &per_cpu(memcg_stock, cpu);
 
 	/* drain_obj_stock requires stock_lock */
-- 
2.47.1


