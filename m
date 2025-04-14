Return-Path: <cgroups+bounces-7522-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB0FA88A6C
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 19:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 184F617CCA9
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 17:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D48027FD6F;
	Mon, 14 Apr 2025 17:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g9WWJcrG"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA121A3144
	for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 17:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744653161; cv=none; b=nUS28H4svE8Z5mIW3jlVkOnSMn6Wyrim6fWMQ7ITV1mql3lI+PM+hvUlVgQX3INjhW05njIYHK7ijUP5kax8gsW6aCL2d6GeFx/9rqC3VhYjnOXDQT0lWT1CCr+CAsBeqikl3dk/ZU0H1WuvlnoiSdlaJuS246X//i3BbEKmOyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744653161; c=relaxed/simple;
	bh=/aPR+YUw+zlRGMujxpVHDk1l/K2U3+U+DrTMLtSmwQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDmF/HyRK8+nfOuyPFkNBA+O6ZU3dFByuM+E53vcxKO3KfwUhARnHVWo/lb4VoZKS+/0bBRM8PUVgLpMT8MVLnZKME2uZ0AL3MHblUA47ZQ3RKqZileTtkbL+FNdkl7NSvjZjSIKhh+9iks/c0H8J651S5KXj6rK3mDz2FQN6UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g9WWJcrG; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 14 Apr 2025 10:52:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744653147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vRe+MVQPZViiLA1Y9m/i86MGRkDnhLyhpBrzwZ9S78=;
	b=g9WWJcrGGa6VfsOyy66ejvsC8a9ns51UGLMfC7TehddsWRPhsAYhu5+yrVx8AMEV9Vl2HO
	BmUhiw4ujHxWXEPdWzIbQhMJZ5My6t5GVvuCZ9PAp4huYwFfKq9senhQxgiKXojuyajV4M
	ZGMx3yO1XdiEP5RGtAemrdUkIMDGvYs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Waiman Long <llong@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: decouple memcg_hotplug_cpu_dead from stock_lock
Message-ID: <atnweqyv7rnyzei3at2dm4xxca4ctvuod2w7brejg4b5zydgdm@xobzurjmjhy5>
References: <20250410210623.1016767-1-shakeel.butt@linux.dev>
 <20250410220618.405d00875ca61043c4ffa6e1@linux-foundation.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410220618.405d00875ca61043c4ffa6e1@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

(I was trying to reply last week but my email stopped working, so trying
again)

On Thu, Apr 10, 2025 at 10:06:18PM -0700, Andrew Morton wrote:
> On Thu, 10 Apr 2025 14:06:23 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> > The function memcg_hotplug_cpu_dead works on the stock of a remote dead
> > CPU and drain_obj_stock works on the given stock instead of local stock,
> > so there is no need to take local stock_lock anymore.
> > 
> > @@ -1964,10 +1964,10 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
> >  
> >  	stock = &per_cpu(memcg_stock, cpu);
> >  
> > -	/* drain_obj_stock requires stock_lock */
> > -	local_lock_irqsave(&memcg_stock.stock_lock, flags);
> > -	drain_obj_stock(stock);
> > -	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
> > +	local_irq_save(flag);
> > +	/* stock of a remote dead cpu, no need for stock_lock. */
> > +	__drain_obj_stock(stock);
> > +	local_irq_restore(flag);
> >  
> 
> s/flag/flags/
> 
> Obviously what-i-got isn't what-you-tested.  Please check what happened
> here,

Sorry about that. I tested the previous version where I had
drain_obj_stock() as a separate function but after seeing that there is
just one caller, I manually inlined it but forgot to test before
sending.

