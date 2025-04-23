Return-Path: <cgroups+bounces-7767-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CF8A99B52
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 00:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67CC11647BD
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 22:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDA81EBA08;
	Wed, 23 Apr 2025 22:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FpZ6E9zE"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61365101F2
	for <cgroups@vger.kernel.org>; Wed, 23 Apr 2025 22:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745446448; cv=none; b=U5bIn66b0/vUU/I0w7c+VikcX8dCd0ZcUIQa+wpeu6iqmA8eoBbGPfx+TFWZl8Dk414W4LWFpjnqKs7Bz+qBx6a1lf9M0ZGwGU4FB5Sg8doKnBV4noOpRi8yuj23BxsQS0vVgWcnMbMgVmuStyfRBOsYo0fz1xWDirk1lwiXzbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745446448; c=relaxed/simple;
	bh=rzqv/y3yi54Tdp14FpA0KdAPOU65g0x0e/dLqWnvJo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpNdcr8SWcRtaxZPfg1SlolbpX2A8fZ+vqXGswtaqa+spJGBvPHuTPAy8GK4gkgMnpsgv1oyqLbYuZV7vc217B6S+mgID/SpL1fep+wTuBwHPNXPyPy+HNxwhCx+NGKz10GlSSg2szzjzinq+eLv1kVjjLc3+yF2AiGETOAFU9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FpZ6E9zE; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 23 Apr 2025 15:13:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745446432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2+E9cdn9Glqpj5x7uDYNuQcvdwYFdyCr3nSZbwJvgho=;
	b=FpZ6E9zEa+lLOExpS2FXQfpVOhVk22iM5558fY6pBKGIx5nUk5rvnPXAh2Li02cLFagoGK
	OLM3zqppzThUDt8Ebm84CgZtwLFYLtcIdMfSFcs1R1OyAOn4/VEjskTOJEk7sgFeInW5SI
	gWJdZBVbOzkF52EO6pCqjjWzTpIIytI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Huan Yang <link@vivo.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH 1/2] mm/memcg: use kmem_cache when alloc memcg
Message-ID: <dp5frcrqofkjjp77hw5sbkri6etnpdsvxnahs6nazvakaxt6im@xouxw25rggci>
References: <20250423084306.65706-1-link@vivo.com>
 <20250423084306.65706-2-link@vivo.com>
 <20250423145912.3e0062864b6969b3623c8ff6@linux-foundation.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423145912.3e0062864b6969b3623c8ff6@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 23, 2025 at 02:59:12PM -0700, Andrew Morton wrote:
> On Wed, 23 Apr 2025 16:43:04 +0800 Huan Yang <link@vivo.com> wrote:
> 
> > @@ -3652,7 +3654,10 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
> >  	int __maybe_unused i;
> >  	long error;
> >  
> > -	memcg = kzalloc(struct_size(memcg, nodeinfo, nr_node_ids), GFP_KERNEL);
> > +	memcg = likely(memcg_cachep) ?
> > +			kmem_cache_zalloc(memcg_cachep, GFP_KERNEL) :
> > +			kzalloc(struct_size(memcg, nodeinfo, nr_node_ids),
> > +				GFP_KERNEL);
> 
> Why are we testing for memcg_cachep=NULL?
> 
> > @@ -5055,6 +5061,10 @@ static int __init mem_cgroup_init(void)
> >  		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
> >  			  drain_local_stock);
> >  
> > +	memcg_size = struct_size_t(struct mem_cgroup, nodeinfo, nr_node_ids);
> > +	memcg_cachep = kmem_cache_create("mem_cgroup", memcg_size, 0,
> > +					 SLAB_PANIC | SLAB_HWCACHE_ALIGN, NULL);
> 
> If it's because this allocation might have failed then let's not
> bother.  If an __init-time allocation failed, this kernel is unusable
> anyway.

+1 to Andrew's point. SLAB_PANIC is used here, so, memcg_cachep can't be
NULL later.

