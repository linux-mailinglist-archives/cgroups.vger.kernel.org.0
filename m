Return-Path: <cgroups+bounces-3862-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F3B93A3DD
	for <lists+cgroups@lfdr.de>; Tue, 23 Jul 2024 17:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0CB5B22D26
	for <lists+cgroups@lfdr.de>; Tue, 23 Jul 2024 15:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA6415746B;
	Tue, 23 Jul 2024 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AFWubk18"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2AC1534FB
	for <cgroups@vger.kernel.org>; Tue, 23 Jul 2024 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721749456; cv=none; b=YLbuji25Gx5fp7WdhTfKoJYC57J2aobXOJF8iPigSM+nSVdLOdHrPLtO0vtW+4DnPGln8cUNmI9fAhZ8rR09rMAYdHU6LjkkYC+cVCBpVAQu48aEsfyz5bNwu35TnkpJpaG4qLBvrFMpGoXKJK+uVG7OALmzmf2d4TRT111OJcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721749456; c=relaxed/simple;
	bh=HcchCygp9GRZgjNi2QKGr5J9TB0bQiERqF74RyCaZzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFeLLLgiWFECPEtS8jjhtObIoxrrkuwlzNTaqy9R1Ete57mRRAEWvX1DVlXWqB/B+FiZjSusmJpm+kiw1sjmQbrXx090fhQuGt0286trhOGlu4v2l6n9IqN3+oeA/wWxNA+shC1E89V+tY3kOYxwKZ742jspA9/4kHVR3i/4pAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AFWubk18; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: oliver.sang@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721749450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BzOavXBxTEmctX7/gPCPhp7QPQ125ryV696udEGlprI=;
	b=AFWubk18jH2pDOFUO30PGFuVdPj4sx6AweKRiBHY7NFRU0y1BETM/e/NPRMcQ37/GHjjFL
	aoCH96eoFsL4amxaJhQ6miIubhmZxgYWqK7z/HRkx8A7657cOnVuD8YWcs+h0Xe/5pZLx2
	e+6pykHoWS103NFurddF+DHX2Lr5aj0=
X-Envelope-To: roman.gushchin@linux.dev
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
Date: Tue, 23 Jul 2024 08:44:01 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
	"oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>, lkp <lkp@intel.com>, 
	Linux Memory Management List <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, 
	"Huang, Ying" <ying.huang@intel.com>, "Tang, Feng" <feng.tang@intel.com>, 
	"Yin, Fengwei" <fengwei.yin@intel.com>
Subject: Re: [linux-next:master] [mm]  :  aim7.jobs-per-min -29.4% regression
Message-ID: <vlp7oxwkvzddnslivtpaiaiuexo5r7smziuvtrjdmckszbsbgs@zib46axtkiqy>
References: <202407121335.31a10cb6-oliver.sang@intel.com>
 <ZpF-A9rl8TiuZJPZ@google.com>
 <ZpUux8bvpL8ARYDE@xsang-OptiPlex-9020>
 <ZpWgP-h5X7GKj1ay@google.com>
 <ZpYm9clw/f8f/tEj@xsang-OptiPlex-9020>
 <Zpqe6NSVBQGiS86m@google.com>
 <Zp8mqTnJN7VJZ/C/@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zp8mqTnJN7VJZ/C/@xsang-OptiPlex-9020>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 23, 2024 at 11:42:33AM GMT, Oliver Sang wrote:
> hi, Roman,
> 
> On Sat, Jul 20, 2024 at 01:14:16AM +0800, Roman Gushchin wrote:
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
> 
> you are welcome!
> 
> though we saw there are further discussions, we still share our test results to
> you.
> 
> in our tests, by your new version patch, the regression is entirely resoloved.
> 
[...]

This is very interesting as this shows (possibly) there was false
sharing between lruvec and lru_zone_size. I will check if these two
fields were accidentally on different cacheline before the series.

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
> > 

