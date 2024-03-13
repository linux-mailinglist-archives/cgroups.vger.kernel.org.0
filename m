Return-Path: <cgroups+bounces-2056-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9224987B016
	for <lists+cgroups@lfdr.de>; Wed, 13 Mar 2024 19:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A9C1C26A06
	for <lists+cgroups@lfdr.de>; Wed, 13 Mar 2024 18:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE3C12BF3D;
	Wed, 13 Mar 2024 17:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i9O5fi+S"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC3212BF21
	for <cgroups@vger.kernel.org>; Wed, 13 Mar 2024 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351254; cv=none; b=D5c4aBhQK27i2UKPru7SAttWc9/k3QRAH1vfJqZPPEavr9T2EGimZDBoDjI59mkGpfWKsoYoUhxf5LQAZvevLqaf7wZSTaeBBVFzF9CnhBTMUTgYdgato/nhll+ulW0s1O+d4QxOBNoBNqJL0g81zxldPWTR7aOM2BjeQlQeiQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351254; c=relaxed/simple;
	bh=ppg7LETEv608reOT2Zj9XxQBtbO706NvbrnIiSiiOGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPfvG1bbpx9RUgOLSWHILFOSalCNs0EiWZKRNBan7ciQK2PC08xT7t12i3mKPcG3OWmFQu9jKgWzDrcF71E/UGngThGezdcVlf53rCQpCsT3bvnWrutAiL9sfCZa2ashoFSY6Z63W5PbUSIb/ITYyFFkemB7hDQlUm+lDgpgICM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i9O5fi+S; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 13 Mar 2024 10:34:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710351249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wol+p/8LL2LDmxvbQ9tqtsHeVEpgewKE43vwTQIQciI=;
	b=i9O5fi+SXWvJdxW5Y+LAyDuRwOq8j5mxhExsiND2GKS/paYNKMzxa8ft6bhjUogbgbM/k6
	rNA6LgBgasXbGfI1+VcTZUQH8VlOXLZs1sFopHRnBTidvxUOvmqdZUMEdvGbeuER3AyX9J
	3g5ZwMx3uU/mQrxbBF1Fh7x7Jgyzo+0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, Kees Cook <kees@kernel.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 1/4] mm, slab: move memcg charging to post-alloc hook
Message-ID: <ZfHjivosHTM2xLfU@P9FQF9L96D>
References: <20240301-slab-memcg-v1-0-359328a46596@suse.cz>
 <20240301-slab-memcg-v1-1-359328a46596@suse.cz>
 <ZfCkfpogPQVMZnIG@P9FQF9L96D>
 <bd05d62d-9f46-46b5-b444-6c4814526459@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd05d62d-9f46-46b5-b444-6c4814526459@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 13, 2024 at 11:55:04AM +0100, Vlastimil Babka wrote:
> On 3/12/24 19:52, Roman Gushchin wrote:
> > On Fri, Mar 01, 2024 at 06:07:08PM +0100, Vlastimil Babka wrote:
> >> The MEMCG_KMEM integration with slab currently relies on two hooks
> >> during allocation. memcg_slab_pre_alloc_hook() determines the objcg and
> >> charges it, and memcg_slab_post_alloc_hook() assigns the objcg pointer
> >> to the allocated object(s).
> >>
> >> As Linus pointed out, this is unnecessarily complex. Failing to charge
> >> due to memcg limits should be rare, so we can optimistically allocate
> >> the object(s) and do the charging together with assigning the objcg
> >> pointer in a single post_alloc hook. In the rare case the charging
> >> fails, we can free the object(s) back.
> >>
> >> This simplifies the code (no need to pass around the objcg pointer) and
> >> potentially allows to separate charging from allocation in cases where
> >> it's common that the allocation would be immediately freed, and the
> >> memcg handling overhead could be saved.
> >>
> >> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> >> Link: https://lore.kernel.org/all/CAHk-=whYOOdM7jWy5jdrAm8LxcgCMFyk2bt8fYYvZzM4U-zAQA@mail.gmail.com/
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > 
> > Nice cleanup, Vlastimil!
> > Couple of small nits below, but otherwise, please, add my
> > 
> > Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> 
> Thanks!
> 
> >>  	/*
> >>  	 * The obtained objcg pointer is safe to use within the current scope,
> >>  	 * defined by current task or set_active_memcg() pair.
> >>  	 * obj_cgroup_get() is used to get a permanent reference.
> >>  	 */
> >> -	struct obj_cgroup *objcg = current_obj_cgroup();
> >> +	objcg = current_obj_cgroup();
> >>  	if (!objcg)
> >>  		return true;
> >>  
> >> +	/*
> >> +	 * slab_alloc_node() avoids the NULL check, so we might be called with a
> >> +	 * single NULL object. kmem_cache_alloc_bulk() aborts if it can't fill
> >> +	 * the whole requested size.
> >> +	 * return success as there's nothing to free back
> >> +	 */
> >> +	if (unlikely(*p == NULL))
> >> +		return true;
> > 
> > Probably better to move this check up? current_obj_cgroup() != NULL check is more
> > expensive.
> 
> It probably doesn't matter in practice anyway, but my thinking was that
> *p == NULL is so rare (the object allocation failed) it shouldn't matter
> that we did current_obj_cgroup() uselessly in case it happens.
> OTOH current_obj_cgroup() returning NULL is not that rare (?) so it
> could be useful to not check *p in those cases?

I see... Hm, I'd generally expect a speculative execution of the second check
anyway (especially with an unlikely() hint for the first one), and because as
you said p == NULL is almost never true, the additional cost is zero.
But the same is true otherwise, so it really doesn't matter that much.
Thanks for explaining your logic, it wasn't obvious to me.

