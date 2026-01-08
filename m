Return-Path: <cgroups+bounces-12974-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A580CD0335A
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 15:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B7E13041F4F
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 13:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568D2421A12;
	Thu,  8 Jan 2026 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gUjrkfjA"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF9542315E
	for <cgroups@vger.kernel.org>; Thu,  8 Jan 2026 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865980; cv=none; b=FGnTP6BnOclRsMJSqUUNbdQBPkg13Px4Oa+ieVhTlEzLZem4f15Yh15YKdgKo4A8u7bxNVkDbesN41tSH0aLof+ug2H7+ReVsKnm7k1qdM2VyG3PaZBzGgb4gmBp8uCNMF8fCU7EqSDcK6bkzRnqvJYY2VMFg0zCi2870c7MAiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865980; c=relaxed/simple;
	bh=bO6KZMXOUIL5pfEiqfs7/ImweeEy4Fx/m66twiWO6z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLkvtjR47fdNxrNrS2d1tixYXienyW0A4AOBGaEanYzCIovOgOyJCu1d4wRTKAD4Adr3JJ5ltWLVc3xwjFdnwTeSRvGHNIeU31t2LFblR3w/aJLYc1bdV6mQQWalJ1dZW4Ww/ozZxZlyPdtCL2g+mMkdyOfuYJgIm9RIU1q7T5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gUjrkfjA; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 8 Jan 2026 17:52:27 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767865966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EvzdJy+9zMHN27Ed9/NnkvWwqWU86nRfgPXwwBdMWUY=;
	b=gUjrkfjAhdKKfbMv/eiJaUta2YOhQyBJ7HZUUfgaP6FBr5rYm01/XZ+qMxw4ZMlMELB2dN
	ibCm1rZ3M7V81o8nDuv4lyG91PsbFGgSzuu2WldMaCvevXx2lSVhYisgFCHJ6tiqFaXxOK
	phROM+SBVI0qFg84BcCLqHKFaox/Il4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, andreyknvl@gmail.com, 
	cl@gentwo.org, dvyukov@google.com, glider@google.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev, rientjes@google.com, 
	roman.gushchin@linux.dev, ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, 
	surenb@google.com, vincenzo.frascino@arm.com, yeoreum.yun@arm.com, tytso@mit.edu, 
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org
Subject: Re: [PATCH V5 8/8] mm/slab: place slabobj_ext metadata in unused
 space within s->size
Message-ID: <7uiizca4ejiqw6zegjwmou5va4kw7na7wivy4kxebrju7dsdwo@5brr7vhwf5oh>
References: <20260105080230.13171-1-harry.yoo@oracle.com>
 <20260105080230.13171-9-harry.yoo@oracle.com>
 <fgx3lapibabra4x7tewx55nuvxz235ruvm3agpprjbdcmt3rc6@h54ln5tfdssz>
 <aV9tnLlsecX8ukMv@hyeyoo>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV9tnLlsecX8ukMv@hyeyoo>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 08, 2026 at 05:41:00PM +0900, Harry Yoo wrote:
> On Thu, Jan 08, 2026 at 01:52:09PM +0800, Hao Li wrote:
> > On Mon, Jan 05, 2026 at 05:02:30PM +0900, Harry Yoo wrote:
> > > When a cache has high s->align value and s->object_size is not aligned
> > > to it, each object ends up with some unused space because of alignment.
> > > If this wasted space is big enough, we can use it to store the
> > > slabobj_ext metadata instead of wasting it.
> > 
> > Hi, Harry,
> 
> Hi Hao,
> 
> > When we save obj_ext in s->size space, it seems that slab_ksize() might
> > be missing the corresponding handling.
> 
> Oops.
> 
> > It still returns s->size, which could cause callers of slab_ksize()
> > to see unexpected data (i.e. obj_ext), or even overwrite the obj_ext data.
> 
> Yes indeed.
> Great point, thanks!
> 
> I'll fix it by checking if the slab has obj_exts within the object
> layout and returning s->object_size if so.

Makes sense - I think there's one more nuance worth capturing.
slab_ksize() seems to compute the maximum safe size by applying layout
constraints from most-restrictive to least-restrictive:
redzones/poison/KASAN clamp it to object_size, tail metadata
(SLAB_TYPESAFE_BY_RCU / SLAB_STORE_USER) clamps it to inuse, and only
when nothing metadata lives does it return s->size.

With that ordering in mind, SLAB_OBJ_EXT_IN_OBJ should behave like
another "tail metadata" cap: put the check right before `return s->size`,
and if it's set, return s->inuse instead. Curious what you think.

-- 
Thanks,
Hao

> 
> -- 
> Cheers,
> Harry / Hyeonggon

