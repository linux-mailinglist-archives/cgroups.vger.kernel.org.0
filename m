Return-Path: <cgroups+bounces-7448-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6FAA8361D
	for <lists+cgroups@lfdr.de>; Thu, 10 Apr 2025 03:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D021F7B0D1D
	for <lists+cgroups@lfdr.de>; Thu, 10 Apr 2025 01:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E08C1E7C3A;
	Thu, 10 Apr 2025 01:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jRHpHQ8N"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2DB1E47C5
	for <cgroups@vger.kernel.org>; Thu, 10 Apr 2025 01:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744249799; cv=none; b=L9SbrRPMGDxlmJc2XbDl4jv3tu147eXs+D9zymY9Z64ec2SJlwBoU+12J3DsrNEfhm0qQETo4/hAhy+xqko56/Zs0IVEUZjAcsh7MIu2bybewsT1zpjT9TeUXBCCNTNbKfWUzoP0MxDnuEbWb6lH0PPzsE0k7aHo+mDuFctxbEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744249799; c=relaxed/simple;
	bh=+tEHy5lttbAc8Ylpd9LWtWPiqQ0eSE9GUg3aIRG8uR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMsYkbS5oSJXpznyBrcA/d1h0tVQMZeXMn7XZmof1e8L1EEnpo3nHGfBfV1TMsZrAeF9+kz+KOrfLZFzKXDmcu+DjWXB/1xcRB0Duz3MaDPL0InofhIDKZHltoUA2dnm6UwvXfsX14QLiVuJMNPRj4BXw9BfiJj3n1TZkFqXnZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jRHpHQ8N; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 9 Apr 2025 18:49:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744249794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l5MFaTOZFaoro0+UqXxVA4jEbrcDys049VFW8hr5/UU=;
	b=jRHpHQ8Nvyqhw228VoAb1Jqlkz69cF7OtyvG+mUI4omFTbebjZeXChIB1IsXdvYvCocOVZ
	33H8/sGCOVdvl1rnT1HsHsbE/QdcNASkfkYOChaRCIbU4jFZ8sMqGiHJgXKJrQFC0w2PZx
	2dj5Lx6YuWCiUX56oOWQK94E5RgLnhw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Waiman Long <llong@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: optimize memcg_rstat_updated
Message-ID: <z2uigo5ku5qihgdbsopodj6rblghjhg2d7q3qv2vjwsjtsar5n@6tlsyphswauq>
References: <20250409234908.940121-1-shakeel.butt@linux.dev>
 <2f9d478d-3359-40c8-8607-be906eaeea04@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f9d478d-3359-40c8-8607-be906eaeea04@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 09, 2025 at 09:20:34PM -0400, Waiman Long wrote:
> On 4/9/25 7:49 PM, Shakeel Butt wrote:
> > Currently the kernel maintains the stats updates per-memcg which is
> > needed to implement stats flushing threshold. On the update side, the
> > update is added to the per-cpu per-memcg update of the given memcg and
> > all of its ancestors. However when the given memcg has passed the
> > flushing threshold, all of its ancestors should have passed the
> > threshold as well. There is no need to traverse up the memcg tree to
> > maintain the stats updates.
> > 
> > Perf profile collected from our fleet shows that memcg_rstat_updated is
> > one of the most expensive memcg function i.e. a lot of cumulative CPU
> > is being spent on it. So, even small micro optimizations matter a lot.
> > 
> > Signed-off-by: Shakeel Butt<shakeel.butt@linux.dev>
> > ---
> >   mm/memcontrol.c | 16 +++++++++-------
> >   1 file changed, 9 insertions(+), 7 deletions(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 421740f1bcdc..ea3e40e589df 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -585,18 +585,20 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
> >   	cgroup_rstat_updated(memcg->css.cgroup, cpu);
> >   	statc = this_cpu_ptr(memcg->vmstats_percpu);
> >   	for (; statc; statc = statc->parent) {
> > +		/*
> > +		 * If @memcg is already flushable then all its ancestors are
> > +		 * flushable as well and also there is no need to increase
> > +		 * stats_updates.
> > +		 */
> > +		if (!memcg_vmstats_needs_flush(statc->vmstats))
> > +			break;
> > +
> 
> Do you mean "if (memcg_vmstats_needs_flush(statc->vmstats))"?
> 

Yup you are right, thanks for catching this. I will send a v2.

