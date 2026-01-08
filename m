Return-Path: <cgroups+bounces-12980-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AADBAD044BB
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 17:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A986311F8FA
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 15:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41364478E24;
	Thu,  8 Jan 2026 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hXrLYYwT"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125C947885D
	for <cgroups@vger.kernel.org>; Thu,  8 Jan 2026 11:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873521; cv=none; b=sejbMbSzrfDQ7o2a8L0T5yn5IclvCiR+O5o57Cn1O56iX8D0M8StYnGNnCDpUdLDb7pfiCFi38yEHOza/4V6Mg/TrgQV+s79wdQIzY3mA1mQPHWKHB1mbzOImZe3SfYzLrPq3K/qhExSQ0hRTCCSokLS9e0ZOF3jWnxMKELXVvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873521; c=relaxed/simple;
	bh=QdgW7/Ywb3ypVra4qAU0CBPlI3FV3Ye6csN8xmiewuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+q8qpXVWoAyHovo/ij6qNAASeT828dDGs61E0qG372kiA2BJ9RndQuh286yEn5BQjtXNW375yIhqZ6Iq/WsEmxYC7JXxwMETGsAIxPaapZQLzmumzvui4dnGO0SA45bCQvjLtULnBGZKqz3j/xYAqkc2VDEzJa2Ij+MGVN8ikA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hXrLYYwT; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 8 Jan 2026 19:57:59 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767873504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0m0duLtHTkYn6eVmR3FYjJRUqSe/1NoTjqwhsTnSDn4=;
	b=hXrLYYwTptrwpyONDcA5ygx/VKWJnwg8tyeYPLPPeBnrpVYqmqkrK7o1wsDxwwLcfSZzJe
	8OAdxdWQgKCBXlFuuL/gbtJqft/mIHqLdOzY7cuPAQHwRrTM78y47kkDOC0Pgc67pRSEtN
	MeggUj29Bust2hNfTWVo+fBUu6i0Vf8=
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
Message-ID: <he2zo2ct4zkv34iiakp7zjzgdbl2n7nj3w7c3dlldvegbs6vxd@zyqrpczadamc>
References: <20260105080230.13171-1-harry.yoo@oracle.com>
 <20260105080230.13171-9-harry.yoo@oracle.com>
 <fgx3lapibabra4x7tewx55nuvxz235ruvm3agpprjbdcmt3rc6@h54ln5tfdssz>
 <aV9tnLlsecX8ukMv@hyeyoo>
 <7uiizca4ejiqw6zegjwmou5va4kw7na7wivy4kxebrju7dsdwo@5brr7vhwf5oh>
 <aV-Kn8vfyL5mnlJv@hyeyoo>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV-Kn8vfyL5mnlJv@hyeyoo>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 08, 2026 at 07:44:47PM +0900, Harry Yoo wrote:
> On Thu, Jan 08, 2026 at 05:52:27PM +0800, Hao Li wrote:
> > On Thu, Jan 08, 2026 at 05:41:00PM +0900, Harry Yoo wrote:
> > > On Thu, Jan 08, 2026 at 01:52:09PM +0800, Hao Li wrote:
> > > > On Mon, Jan 05, 2026 at 05:02:30PM +0900, Harry Yoo wrote:
> > > > > When a cache has high s->align value and s->object_size is not aligned
> > > > > to it, each object ends up with some unused space because of alignment.
> > > > > If this wasted space is big enough, we can use it to store the
> > > > > slabobj_ext metadata instead of wasting it.
> > > > 
> > > > Hi, Harry,
> > > 
> > > Hi Hao,
> > > 
> > > > When we save obj_ext in s->size space, it seems that slab_ksize() might
> > > > be missing the corresponding handling.
> > > 
> > > Oops.
> > > 
> > > > It still returns s->size, which could cause callers of slab_ksize()
> > > > to see unexpected data (i.e. obj_ext), or even overwrite the obj_ext data.
> > > 
> > > Yes indeed.
> > > Great point, thanks!
> > > 
> > > I'll fix it by checking if the slab has obj_exts within the object
> > > layout and returning s->object_size if so.
> > 
> > Makes sense - I think there's one more nuance worth capturing.
> > slab_ksize() seems to compute the maximum safe size by applying layout
> > constraints from most-restrictive to least-restrictive:
> > redzones/poison/KASAN clamp it to object_size, tail metadata
> > (SLAB_TYPESAFE_BY_RCU / SLAB_STORE_USER) clamps it to inuse, and only
> > when nothing metadata lives does it return s->size.
> 
> Waaaait, SLAB_TYPESAFE_BY_RCU isn't the only case where we put freelist
> pointer after the object.
> 
> What about caches with constructor?
> We do place it after object, but slab_ksize() may return s->size? 

That's a really good question - thanks for calling it out. I took
another look at the code, and the comment for ksize() notes that it's
only meant to be used with kmalloc()-family allocations; those objects
don't have a ctor pointer. So as long as callers stick to that contract,
I think we should be fine and don't need to worry too much about this
case.

-- 
Thanks,
Hao

