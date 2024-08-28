Return-Path: <cgroups+bounces-4543-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C9E9630A6
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 21:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82D312878C4
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 19:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2361AB531;
	Wed, 28 Aug 2024 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K2ALeeyA"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0AB155316
	for <cgroups@vger.kernel.org>; Wed, 28 Aug 2024 19:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724871842; cv=none; b=HFNcZkvQNmHoBXir+gSg7H+12un63mOCV22yRF20vFbozbjFgx4+uxlA1HGKwHi9Ipnv1t/ddJtgpA7ZihlAti5TEV/V1+xJHsONVEJ2fWkPx44u3Pe3kKWfQLKjEivej83o8y5u6QUnq0tqWR/OvKRKxEWfeJARiJJppM/CDeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724871842; c=relaxed/simple;
	bh=YRKAlMOxna+bxN7n5yTMSkuaQlQNsXOc/8IG9jDt9/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHlqemdGbKf1Y4d3Oy7t40GhjQUqTJVVDli2Fc/8inoEHQ4dbhxn+J4RmNHjwo6LKtP7LlGpBdBkrYfO1TwdCjwKK1inO5wX/5bF6sCKyX64O5dUhBhWjQNO8KkA2r7iYdZ+QFna3bsYMTj14GzHKII0oNxX0AeQ0VYu1YLloaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K2ALeeyA; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 28 Aug 2024 12:03:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724871837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j7vkDyir+DMrxX+HGm5Ta48lUpr2OMfmyuMnb1CIktI=;
	b=K2ALeeyATuD5JWGchJFR5gsyyuMm7THk7aHTDFHr6e83Ffrdzp/9RjjjjTcyTlbHI4BBrD
	IzXEqYz3NBwTZ/Qrb0nmDnDELPUQNbI+VqsUl2PRJp1x0AarYG5err9xiLm3VVjdGO54WM
	U3u/VnwamuC2tX4goM0KqKWdtkQiQN4=
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
Message-ID: <a5rzw7uuf7pgrhhut7keoy66c6u4rgiuxx2qmwywbvl2iktfku@23dzxczejcet>
References: <20240826232908.4076417-1-shakeel.butt@linux.dev>
 <Zs1CuLa-SE88jRVx@google.com>
 <yiyx4fh6dklqpexfstkzp3gf23hjpbjujci2o6gs7nb4sutzvb@b5korjrjio3m>
 <EA5F7851-B519-4570-B299-8A096A09D6E7@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EA5F7851-B519-4570-B299-8A096A09D6E7@linux.dev>
X-Migadu-Flow: FLOW_OUT

Hi Muchun,

On Wed, Aug 28, 2024 at 10:36:06AM GMT, Muchun Song wrote:
> 
> 
> > On Aug 28, 2024, at 01:23, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > 
[...]
> >> 
> >> Does it handle the case of a too-big-to-be-a-slab-object allocation?
> >> I think it's better to handle it properly. Also, why return false here?
> >> 
> > 
> > Yes I will fix the too-big-to-be-a-slab-object allocations. I presume I
> > should just follow the kfree() hanlding on !folio_test_slab() i.e. that
> > the given object is the large or too-big-to-be-a-slab-object.
> 
> Hi Shakeel,
> 
> If we decide to do this, I suppose you will use memcg_kmem_charge_page
> to charge big-object. To be consistent, I suggest renaming kmem_cache_charge
> to memcg_kmem_charge to handle both slab object and big-object. And I saw
> all the functions related to object charging is moved to memcontrol.c (e.g.
> __memcg_slab_post_alloc_hook), so maybe we should also do this for
> memcg_kmem_charge?
> 

If I understand you correctly, you are suggesting to handle the general
kmem charging and slab's large kmalloc (size > KMALLOC_MAX_CACHE_SIZE)
together with memcg_kmem_charge(). However that is not possible due to
slab path updating NR_SLAB_UNRECLAIMABLE_B stats while no updates for
this stat in the general kmem charging path (__memcg_kmem_charge_page in
page allocation code path).

Also this general kmem charging path is used by many other users like
vmalloc, kernel stack and thus we can not just plainly stuck updates to
NR_SLAB_UNRECLAIMABLE_B in that path.

Thanks for taking a look.
Shakeel

