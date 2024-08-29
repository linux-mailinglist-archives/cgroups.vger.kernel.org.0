Return-Path: <cgroups+bounces-4570-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC691964A86
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 17:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2451F244A3
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 15:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00AD1B3B18;
	Thu, 29 Aug 2024 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FG2DPyp9"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ED51922E6
	for <cgroups@vger.kernel.org>; Thu, 29 Aug 2024 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946580; cv=none; b=nXJaUG4CKIzlHwznbbFPZhXMMiBJkJtny36Zk2tyhr4wdcMVtu1qWdBNbIlcbTOoso1QPn29gdILpImYomwddmnFxfvMgfD9o1/SEU7KZVvMZFpwn+HDideDJruN2rIcBswZ3uO4Fqze00+kPbSCc3iwITiiQvay1PtGMb7b+6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946580; c=relaxed/simple;
	bh=ugyvySIO2uNTkY3T/MUNXgyaVyZ2XD1kpVyCqFgpWE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pONJlgA5wpNRyhjQHdmrBm+yEzlWhF43Fpa8izYYVTZna3v8vml7Tmv/muiD1vULnkyqURYtGIwllz7/MJjv7LIwge1CR9Dt65db05HJS+HZQxZHTsVz0q5PfttdlmI1kN3H6ZWwVAOZg2MAYp8g9tMH2+DK9fp2FjG2Wr6SZIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FG2DPyp9; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Aug 2024 08:49:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724946576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JSVZiXj9uWNsdq1CBv+qiytgVutH4w3/0Njr6e1mFG0=;
	b=FG2DPyp9orc0RU6IR4u4nURavRjF22n5a/J740GoG1zfzgAUlDCqamGIA3VjPaCLdQNchZ
	xUTHqVPrMvi0y8SG8PzZA+xJgXeUlQBZ6zsxocob5xVk45+e2C8dy4wYQY5Xrss549CaNW
	ZunWROmbBtjp53RvCLZV9owEL4jM97Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Muchun Song <muchun.song@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Linux Memory Management List <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, 
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org, netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH v1] memcg: add charging of already allocated slab objects
Message-ID: <nt5zhccndtrj2pyyjm6wkah4iizzijdamaqce24t7nqioy4c5y@3vtipktwtzkn>
References: <20240826232908.4076417-1-shakeel.butt@linux.dev>
 <Zs1CuLa-SE88jRVx@google.com>
 <yiyx4fh6dklqpexfstkzp3gf23hjpbjujci2o6gs7nb4sutzvb@b5korjrjio3m>
 <EA5F7851-B519-4570-B299-8A096A09D6E7@linux.dev>
 <a5rzw7uuf7pgrhhut7keoy66c6u4rgiuxx2qmwywbvl2iktfku@23dzxczejcet>
 <97F404E9-C3C2-4BD2-9539-C40237E71B2B@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97F404E9-C3C2-4BD2-9539-C40237E71B2B@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 29, 2024 at 10:36:01AM GMT, Muchun Song wrote:
> 
> 
> > On Aug 29, 2024, at 03:03, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > 
> > Hi Muchun,
> > 
> > On Wed, Aug 28, 2024 at 10:36:06AM GMT, Muchun Song wrote:
> >> 
> >> 
> >>> On Aug 28, 2024, at 01:23, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >>> 
> > [...]
> >>>> 
> >>>> Does it handle the case of a too-big-to-be-a-slab-object allocation?
> >>>> I think it's better to handle it properly. Also, why return false here?
> >>>> 
> >>> 
> >>> Yes I will fix the too-big-to-be-a-slab-object allocations. I presume I
> >>> should just follow the kfree() hanlding on !folio_test_slab() i.e. that
> >>> the given object is the large or too-big-to-be-a-slab-object.
> >> 
> >> Hi Shakeel,
> >> 
> >> If we decide to do this, I suppose you will use memcg_kmem_charge_page
> >> to charge big-object. To be consistent, I suggest renaming kmem_cache_charge
> >> to memcg_kmem_charge to handle both slab object and big-object. And I saw
> >> all the functions related to object charging is moved to memcontrol.c (e.g.
> >> __memcg_slab_post_alloc_hook), so maybe we should also do this for
> >> memcg_kmem_charge?
> >> 
> > 
> > If I understand you correctly, you are suggesting to handle the general
> > kmem charging and slab's large kmalloc (size > KMALLOC_MAX_CACHE_SIZE)
> > together with memcg_kmem_charge(). However that is not possible due to
> > slab path updating NR_SLAB_UNRECLAIMABLE_B stats while no updates for
> > this stat in the general kmem charging path (__memcg_kmem_charge_page in
> > page allocation code path).
> > 
> > Also this general kmem charging path is used by many other users like
> > vmalloc, kernel stack and thus we can not just plainly stuck updates to
> > NR_SLAB_UNRECLAIMABLE_B in that path.
> 
> Sorry, maybe I am not clear . To make sure we are on the same page, let
> me clarify my thought. In your v2, I thought if we can rename
> kmem_cache_charge() to memcg_kmem_charge() since kmem_cache_charge()
> already has handled both big-slab-object (size > KMALLOC_MAX_CACHE_SIZE)
> and small-slab-object cases. You know, we have a function of
> memcg_kmem_charge_page() which could be used for charging big-slab-object
> but not small-slab-object. So I thought maybe memcg_kmem_charge() is a
> good name for it to handle both cases. And if we do this, how about moving
> this new function to memcontrol.c since all memcg charging functions are
> moved to memcontrol.c instead of slub.c.
> 

Oh you want the core function to be in memcontrol.c. I don't have any
strong opinion where the code should exist but I do want the interface
to still be kmem_cache_charge() because that is what we are providing to
the users which charging slab objects. Yes some of those might be
big-slab-objects but that is transparent to the users.

Anyways, for now I will go with my current approach but on the followup
will explore and discuss with you on which code should exist in which
file. I hope that is acceptable to you.

thanks,
Shakeel

