Return-Path: <cgroups+bounces-3842-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D79979391E6
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2024 17:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 140FC1C214C9
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2024 15:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1A116E868;
	Mon, 22 Jul 2024 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m6lucmiF"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5A616CD18
	for <cgroups@vger.kernel.org>; Mon, 22 Jul 2024 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721662659; cv=none; b=O6OJTJ9IU5O15mssVbQKmmWoeEmOHJ4sP4WumM31y2Ecq804FeE7uT+OJ52ig3NGj15Fw2HZXmhirB71zetGpXnAw8h0OFos+Lr5YCQUkjqhtJxyy/rS9Xt99UARmn0PcTwbLK61//dz00qVTDc1w6ZiZjJuLy8yE9lPpNDO+fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721662659; c=relaxed/simple;
	bh=ccGX4Hq8QkwkTlm1qIwKYP4OkJFuZCRdVnsU0izN/l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mn2mobSB09qF70e+1Q8JIyWfv4r/Xwms/ccpVCkOdtgSmjlEzHiJssOC9QO1XMz01iXz7iFUvCYdxXtosjYBqY53CAsQYCYWUrDQLR0PTLhIkZkfQZMFqLV6ANRGyXNiKLh3E+aXa9jDIcjZxX4083R+69QAr42Rqcf0r89FEe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m6lucmiF; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: shakeel.butt@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721662655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l5rKqb5oYX28jAL5sq1lJYXnRV7xYOZ3odZ9hgHn7Ko=;
	b=m6lucmiFNhPS9bPEABMuT1JdzTiR1gPEV6zFaDlc3vDA5ZgKApbXqNLVCfVPNDFJX+t6aw
	gPCjpR8ipWX0qTIi/iXyCsO4sWfepIGUhH/X2YOSrRF2C5nct/SdAWcIB3vzSwvXcxxvZf
	GBJvZrsM2ESih664q5rH22PjdQmhqR8=
X-Envelope-To: oliver.sang@intel.com
X-Envelope-To: oe-lkp@lists.linux.dev
X-Envelope-To: lkp@intel.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: ying.huang@intel.com
X-Envelope-To: feng.tang@intel.com
X-Envelope-To: fengwei.yin@intel.com
Date: Mon, 22 Jul 2024 15:37:27 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linux-next:master] [mm]  98c9daf5ae:  aim7.jobs-per-min -29.4%
 regression
Message-ID: <Zp58t2DNWwlYQaHe@google.com>
References: <202407121335.31a10cb6-oliver.sang@intel.com>
 <ZpF-A9rl8TiuZJPZ@google.com>
 <ZpUux8bvpL8ARYDE@xsang-OptiPlex-9020>
 <ZpWgP-h5X7GKj1ay@google.com>
 <ZpYm9clw/f8f/tEj@xsang-OptiPlex-9020>
 <Zpqe6NSVBQGiS86m@google.com>
 <x2vfqt3frbghlxonagfx52suetu7fod7taktrc6fnt2jwmzg6l@kbdwghkf3htr>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x2vfqt3frbghlxonagfx52suetu7fod7taktrc6fnt2jwmzg6l@kbdwghkf3htr>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 19, 2024 at 03:38:26PM -0700, Shakeel Butt wrote:
> On Fri, Jul 19, 2024 at 05:14:16PM GMT, Roman Gushchin wrote:
> > On Tue, Jul 16, 2024 at 03:53:25PM +0800, Oliver Sang wrote:
> > > hi, Roman,
> > > 
> > > On Mon, Jul 15, 2024 at 10:18:39PM +0000, Roman Gushchin wrote:
> > > > On Mon, Jul 15, 2024 at 10:14:31PM +0800, Oliver Sang wrote:
> > > > > hi, Roman Gushchin,
> > > > > 
> > > > > On Fri, Jul 12, 2024 at 07:03:31PM +0000, Roman Gushchin wrote:
> > > > > > On Fri, Jul 12, 2024 at 02:04:48PM +0800, kernel test robot wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > Hello,
> > > > > > > 
> > > > > > > kernel test robot noticed a -29.4% regression of aim7.jobs-per-min on:
> > > > > > > 
> > > > > > > 
> > > > > > > commit: 98c9daf5ae6be008f78c07b744bcff7bcc6e98da ("mm: memcg: guard memcg1-specific members of struct mem_cgroup_per_node")
> > > > > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > > > > 
> > > > > > Hello,
> > > > > > 
> > > > > > thank you for the report!
> > > > > > 
> > > > > > I'd expect that the regression should be fixed by the commit
> > > > > > "mm: memcg: add cache line padding to mem_cgroup_per_node".
> > > > > > 
> > > > > > Can you, please, confirm that it's not the case?
> > > > > > 
> > > > > > Thank you!
> > > > > 
> > > > > in our this aim7 test, we found the performance partially recovered by
> > > > > "mm: memcg: add cache line padding to mem_cgroup_per_node" but not fully
> > > > 
> > > > Thank you for providing the detailed information!
> > > > 
> > > > Can you, please, check if the following patch resolves the regression entirely?
> > > 
> > > no. in our tests, the following patch has little impact.
> > > I directly apply it upon 6df13230b6 (if this is not the proper applyment, please
> > > let me know, thanks)
> > 
> > Hm, interesting. And thank you for the confirmation, you did everything correct.
> > Because the only thing the original patch did was a removal of few fields from
> > the mem_cgroup_per_node struct, there are not many options left here.
> > Would you mind to try the following patch?
> > 
> > Thank you and really appreciate your help!
> > 
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 7e2eb091049a..0e5bf25d324f 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -109,6 +109,7 @@ struct mem_cgroup_per_node {
> > 
> >         /* Fields which get updated often at the end. */
> >         struct lruvec           lruvec;
> > +       CACHELINE_PADDING(_pad2_);
> >         unsigned long           lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
> >         struct mem_cgroup_reclaim_iter  iter;
> >  };
> > 
> > 
> 
> I suspect we need padding in the struct mem_cgroup instead of in struct
> mem_cgroup_per_node. I am planning to run some experiments and will
> report back once I have some convincing numbers.

You mean the regression was attributed to the wrong commit?
Because the blamed commit only removed few fields from the middle
of mem_cgroup_per_node.

Thanks

