Return-Path: <cgroups+bounces-12982-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F02D030EC
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 14:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F167300B348
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 13:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEA33876AD;
	Thu,  8 Jan 2026 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lt/FEwjd"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1CE3815DB
	for <cgroups@vger.kernel.org>; Thu,  8 Jan 2026 12:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876554; cv=none; b=TTyva9+YE8RFWgMCg/Aov2FEy0lZzZ3N65GPBauRlTM3zuSNLTeN/WtMQtrw8x92nJfjnUJQk8yzRrqGx22t5fZXYgTdco+wcPFuw1BDZYfS5hiEspxLy7D6Xk5Ca3vqm73sNMFh5PygfQMTNaVKYoDe8WjJN1PBnvMbYHw9t1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876554; c=relaxed/simple;
	bh=MIyM81sGiJTLsmuORBJqhRlvVCg2Z6QAf9JAHjCnbU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihbt41EyZSbp3ia9Elb333HXSkgLrV6i+rN8y0jcAuvjvmauSJRIDdLGWULA13vH48lp6dNBcqp9LTbTMlj3r6F1jjYxgKXuozEXnf67B3LPKTh51xIDaBOluB2KmXCEaxsS2t5nE7RikI22BrfvnSs+b8eeWoaYpof5vSwE4sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lt/FEwjd; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 8 Jan 2026 20:48:46 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767876540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=41tszTVbNyb1pXQ8d9AUh0ygD/K3N/1floSqYXpSeHk=;
	b=lt/FEwjdv9cQk1Ejc0NPM1jhoA3VfUQ3CR4BWtX6aURYnKEvIyEzT/JdOtXzLkEq9rF2kZ
	mHryCyyxFAxHlBuV/YeIcOudNg57pGZAGLQb56iy3+rkn3x+4Fdc++OUcqJHUbinO2t0GB
	QRbGRvWdTKzhwAHDmKD9VVaHoOKyktQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, akpm@linux-foundation.org, 
	andreyknvl@gmail.com, cl@gentwo.org, dvyukov@google.com, glider@google.com, 
	hannes@cmpxchg.org, linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev, 
	rientjes@google.com, roman.gushchin@linux.dev, ryabinin.a.a@gmail.com, 
	shakeel.butt@linux.dev, surenb@google.com, vincenzo.frascino@arm.com, 
	yeoreum.yun@arm.com, tytso@mit.edu, adilger.kernel@dilger.ca, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH V5 8/8] mm/slab: place slabobj_ext metadata in unused
 space within s->size
Message-ID: <pyhgduyryvfoxfb72hdnojd63fkgwx2jbn5r2h4cuthkki2ouf@ntuesnpnterc>
References: <20260105080230.13171-1-harry.yoo@oracle.com>
 <20260105080230.13171-9-harry.yoo@oracle.com>
 <fgx3lapibabra4x7tewx55nuvxz235ruvm3agpprjbdcmt3rc6@h54ln5tfdssz>
 <aV9tnLlsecX8ukMv@hyeyoo>
 <7uiizca4ejiqw6zegjwmou5va4kw7na7wivy4kxebrju7dsdwo@5brr7vhwf5oh>
 <aV-Kn8vfyL5mnlJv@hyeyoo>
 <30ecc144-ea2c-4259-afbf-3d96849aded2@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30ecc144-ea2c-4259-afbf-3d96849aded2@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 08, 2026 at 11:52:36AM +0100, Vlastimil Babka wrote:
> On 1/8/26 11:44, Harry Yoo wrote:
> > On Thu, Jan 08, 2026 at 05:52:27PM +0800, Hao Li wrote:
> >> On Thu, Jan 08, 2026 at 05:41:00PM +0900, Harry Yoo wrote:
> >> > On Thu, Jan 08, 2026 at 01:52:09PM +0800, Hao Li wrote:
> >> > > On Mon, Jan 05, 2026 at 05:02:30PM +0900, Harry Yoo wrote:
> >> > > > When a cache has high s->align value and s->object_size is not aligned
> >> > > > to it, each object ends up with some unused space because of alignment.
> >> > > > If this wasted space is big enough, we can use it to store the
> >> > > > slabobj_ext metadata instead of wasting it.
> >> > > 
> >> > > Hi, Harry,
> >> > 
> >> > Hi Hao,
> >> > 
> >> > > When we save obj_ext in s->size space, it seems that slab_ksize() might
> >> > > be missing the corresponding handling.
> >> > 
> >> > Oops.
> >> > 
> >> > > It still returns s->size, which could cause callers of slab_ksize()
> >> > > to see unexpected data (i.e. obj_ext), or even overwrite the obj_ext data.
> >> > 
> >> > Yes indeed.
> >> > Great point, thanks!
> >> > 
> >> > I'll fix it by checking if the slab has obj_exts within the object
> >> > layout and returning s->object_size if so.
> >> 
> >> Makes sense - I think there's one more nuance worth capturing.
> >> slab_ksize() seems to compute the maximum safe size by applying layout
> >> constraints from most-restrictive to least-restrictive:
> >> redzones/poison/KASAN clamp it to object_size, tail metadata
> >> (SLAB_TYPESAFE_BY_RCU / SLAB_STORE_USER) clamps it to inuse, and only
> >> when nothing metadata lives does it return s->size.
> > 
> > Waaaait, SLAB_TYPESAFE_BY_RCU isn't the only case where we put freelist
> > pointer after the object.
> > 
> > What about caches with constructor?
> > We do place it after object, but slab_ksize() may return s->size? 
> 
> I think the freelist pointer is fine because it's not used by allocated objects?
> Also ksize() should no longer be used to fill more of the object than that
> was requested in the first place.

Yes - being conservative here seems safest. Exposing extra bytes that
callers don't expect could easily break assumptions and lead to subtle
bugs.

-- 
Thanks,
Hao

> 
> 
> 

