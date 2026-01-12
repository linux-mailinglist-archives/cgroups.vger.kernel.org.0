Return-Path: <cgroups+bounces-13103-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D99D1573F
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 22:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E6A9F300926C
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 21:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693E7341072;
	Mon, 12 Jan 2026 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m9m5QVTT"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E7231352F
	for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 21:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768253788; cv=none; b=LkzAyMMFcErVJFg33UBNXicXGG8Uc/y6+PBmP6Ig/JKCcHqK3tv2lxWNpQ5CHGTqezGUvrw4LYL4I+3Fsxce08rzhSj1l6v03xBbDSLfOAuRWShc7fukPTvWwdfRvizoLN7o+h49avdAahTLxHeR8uDeFZf4w51hfK3RoGWAiqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768253788; c=relaxed/simple;
	bh=JRHRyYV/O3DnaieVuW9WQbLrDAUMyJJpI/o1z8oEpZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoWGzd6pO+yKkPkKlgB0HO+hidV91zeoXEf7rrLZSEAybggbAA47e4x2NjR8eg1mti+li4U5Y2vUA72IkRgrAlmUE6Gxsd/ruCDb+eKkIHaz0e6GL6q7Ku2/y1nPf35H1G91+e5SZZTf3neCq/mhAb9isuOmjJkyrEPb5E6F4SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m9m5QVTT; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 12 Jan 2026 13:36:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768253784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T3BjtoAAstlY6b/etRhy75SWXFb2D/YEwMqRuShF6b4=;
	b=m9m5QVTTu18qp8eRE/apJolgPvKzpkMqNnIXlpc3SbPa2JdSjsDVvGS7ImBzThOacvugFB
	MwqB5jlAH93aGBWWWUL7ptUT9Qf8SUsLwB+ebL0V/ezVEw5FPfiB8/5r5ta2NYtf6qsTUN
	XG58PScDJPtcXLX1t8Dn445oIXrPFWk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] memcg: rename mem_cgroup_ino() to mem_cgroup_id()
Message-ID: <flkqanhyettp5uq22bjwg37rtmnpeg3mghznsylxcxxgaafpl4@nov2x7tagma7>
References: <20251225232116.294540-9-shakeel.butt@linux.dev>
 <20260108045954.78552-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108045954.78552-1-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 07, 2026 at 08:59:53PM -0800, SeongJae Park wrote:
> On Thu, 25 Dec 2025 15:21:16 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:
[...]
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 3e7d69020b39..5a1161cadb8d 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> [...]
> > -struct mem_cgroup *mem_cgroup_get_from_ino(u64 ino);
> > +struct mem_cgroup *mem_cgroup_get_from_id(u64 ino);
> 
> Nit.  How about renaming the argument from 'ino' to 'id'?
> 
> [...]
> > -static inline struct mem_cgroup *mem_cgroup_get_from_ino(u64 ino)
> > +static inline struct mem_cgroup *mem_cgroup_get_from_id(u64 ino)
> 
> Ditto.
> 
> [...]
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -3615,7 +3615,7 @@ struct mem_cgroup *mem_cgroup_from_private_id(unsigned short id)
> >  	return xa_load(&mem_cgroup_private_ids, id);
> >  }
> >  
> > -struct mem_cgroup *mem_cgroup_get_from_ino(u64 ino)
> > +struct mem_cgroup *mem_cgroup_get_from_id(u64 ino)
> 
> Ditto.
> 

Thanks a lot SJ for the review and suggestions.

Andrew, can you please squash the following fix into the series?


From 7bf26690649ab9c555d17a2acb7215e768232d13 Mon Sep 17 00:00:00 2001
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Mon, 12 Jan 2026 13:34:27 -0800
Subject: [PATCH] memcg: replace ino with id

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h | 4 ++--
 mm/memcontrol.c            | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 538fddd3ef77..b6c82c8f73e1 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -835,7 +835,7 @@ static inline u64 mem_cgroup_id(struct mem_cgroup *memcg)
 	return memcg ? cgroup_id(memcg->css.cgroup) : 0;
 }
 
-struct mem_cgroup *mem_cgroup_get_from_id(u64 ino);
+struct mem_cgroup *mem_cgroup_get_from_id(u64 id);
 
 static inline struct mem_cgroup *mem_cgroup_from_seq(struct seq_file *m)
 {
@@ -1293,7 +1293,7 @@ static inline u64 mem_cgroup_id(struct mem_cgroup *memcg)
 	return 0;
 }
 
-static inline struct mem_cgroup *mem_cgroup_get_from_id(u64 ino)
+static inline struct mem_cgroup *mem_cgroup_get_from_id(u64 id)
 {
 	return NULL;
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d4ac9b527f91..bd2ab72386d4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3615,7 +3615,7 @@ struct mem_cgroup *mem_cgroup_from_private_id(unsigned short id)
 	return xa_load(&mem_cgroup_private_ids, id);
 }
 
-struct mem_cgroup *mem_cgroup_get_from_id(u64 ino)
+struct mem_cgroup *mem_cgroup_get_from_id(u64 id)
 {
 	struct cgroup *cgrp;
 	struct cgroup_subsys_state *css;
-- 
2.47.3


