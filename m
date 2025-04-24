Return-Path: <cgroups+bounces-7786-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126E7A99F9E
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 05:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB924623BE
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 03:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AF617B506;
	Thu, 24 Apr 2025 03:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W4ZjFaEc"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88585198851
	for <cgroups@vger.kernel.org>; Thu, 24 Apr 2025 03:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745465498; cv=none; b=QaPpvTJTFPnfSQ23VHIAirPQdQfsXns5yO/ku6y3eGruSt/wExRSTqxwQ9JBAGAJcZQrlMaQtAvRelu1mXvBlIVNpxpToYru6kVVbHxf1mkeAw8c8zrWUiTpFG4CudleRD8g3YY2PUoKwVUTyV3owqp3BYxn9BJquXqSbbuqOJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745465498; c=relaxed/simple;
	bh=myVeZki5kl3rn1vxZyH9N9VwH0GO58e55paaJT0M4WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEkXDnotxdnEkZ2Ez8UbDrbKGo415aD0ijNtMVAhOFfXFDG/kqcrZkRu5mldhYuLJLBKkl+Fvtc6JIacmHepA9cmYLydGpiw6iffFNEJ7eNLUX1yItg3mcHgUgukBBDnUvAjHpUK8ipygNx6ixNoQcbsmL7211qTBFZ7H/coVfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W4ZjFaEc; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 23 Apr 2025 20:31:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745465494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DeaKk60E/kzeqVMGJJGoBhBfYcDEvCUOFG7Nv4xRzV4=;
	b=W4ZjFaEcUWJs2mYyhmZzzwkPM7j8mzynlEFPEoEReon5sMBmgHjrChq5BsFwt9oKoDkKas
	vFrJyK6upHqjAPpOli8KkaiVaQILHU1N8Bj/NuLQwBr+r5pNv0taT0MKVa6y4FV/sFgO8E
	CuGV+cwhJa6lzIvZHRGh3dSlrzNnKuE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Huan Yang <link@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH 1/2] mm/memcg: use kmem_cache when alloc memcg
Message-ID: <3txgkddzf62xhxwlzm63ip3tqv3r2tmd4elnka2z5ya7ngqr62@f554paqdco5s>
References: <20250423084306.65706-1-link@vivo.com>
 <20250423084306.65706-2-link@vivo.com>
 <20250423145912.3e0062864b6969b3623c8ff6@linux-foundation.org>
 <dp5frcrqofkjjp77hw5sbkri6etnpdsvxnahs6nazvakaxt6im@xouxw25rggci>
 <142e6a02-80bf-4e7e-9165-1b5690fde690@vivo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <142e6a02-80bf-4e7e-9165-1b5690fde690@vivo.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 24, 2025 at 10:45:05AM +0800, Huan Yang wrote:
> Hi Shakeel
> 
> 在 2025/4/24 06:13, Shakeel Butt 写道:
> > On Wed, Apr 23, 2025 at 02:59:12PM -0700, Andrew Morton wrote:
> > > On Wed, 23 Apr 2025 16:43:04 +0800 Huan Yang <link@vivo.com> wrote:
> > > 
> > > > @@ -3652,7 +3654,10 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
> > > >   	int __maybe_unused i;
> > > >   	long error;
> > > > -	memcg = kzalloc(struct_size(memcg, nodeinfo, nr_node_ids), GFP_KERNEL);
> > > > +	memcg = likely(memcg_cachep) ?
> > > > +			kmem_cache_zalloc(memcg_cachep, GFP_KERNEL) :
> > > > +			kzalloc(struct_size(memcg, nodeinfo, nr_node_ids),
> > > > +				GFP_KERNEL);
> > > Why are we testing for memcg_cachep=NULL?
> > > 
> > > > @@ -5055,6 +5061,10 @@ static int __init mem_cgroup_init(void)
> > > >   		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
> > > >   			  drain_local_stock);
> > > > +	memcg_size = struct_size_t(struct mem_cgroup, nodeinfo, nr_node_ids);
> > > > +	memcg_cachep = kmem_cache_create("mem_cgroup", memcg_size, 0,
> > > > +					 SLAB_PANIC | SLAB_HWCACHE_ALIGN, NULL);
> > > If it's because this allocation might have failed then let's not
> > > bother.  If an __init-time allocation failed, this kernel is unusable
> > > anyway.
> > > 
> > > +1 to Andrew's point. SLAB_PANIC is used here, so, memcg_cachep can't be
> > > NULL later.
> 
> I see cgroup_init(in start_kernel) ahead of initcall( which in rest_init->kernel_init->...->initcall). So, root_mem_cgroup create use
> 
> cachep will trigger NULL pointer access.

So, either create a new function which creates this kmem cache before
cgroup_init() or just call mem_cgroup_init() before cgroup_init()
(similar to cpuset_init()).

