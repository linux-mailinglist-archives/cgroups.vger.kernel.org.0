Return-Path: <cgroups+bounces-3847-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C831939477
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2024 21:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC1441F2214A
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2024 19:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0C117108A;
	Mon, 22 Jul 2024 19:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ITglKGYy"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61A71DA53
	for <cgroups@vger.kernel.org>; Mon, 22 Jul 2024 19:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721677920; cv=none; b=qqpbgd+j4I7vBTlhfNZp/VlSzbS+FKPBbzqYNo+xfT//lc/5WguAOaIQ/ioM6Jg30q+Rr8f/cG+4KLwIFpbL4naHxp1iMsQf/cPkBt82qczgpOUmIcRjiWFcxMWh6xX8ohQ6a2lgf/ijTT4WCphMr/oV/oU+4Ke8Eq/Le4s995Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721677920; c=relaxed/simple;
	bh=ICtYFPSlt4Nlh3tm6XgLAmvVCvUWr5ig6gEgb3Rj4h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zhbcl8l0wwXd7EyLwXfyZWEt24PSJ3Qm9UCDBmVKnmKXWVdI9y4ezDZ2ec8aIKlWMeZyn1yTr2vgJW3HppBBDjQJ/CvezlgX+qEnJqMH7lqfk/tN4fxTJznBjzeaROc9aYaPIEGwq3ZBGbmF0rkrVIaXr9pI9rOPYFd2zwuIVHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ITglKGYy; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721677915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kXpFkO6uVCl721nl42w3K5FFXtikI48+rMf+SJkzYvU=;
	b=ITglKGYyb1lXrwUVKVZGsl363SW1nV8/rrDKZtK20AOANCms50ADpRQ+QpigmbwmCHOSFG
	lX7WVgVCUc9WW+JvThFJe2h5OU09mOhq76FCQgdnp7qvTvyjAA+YP5DMue5thFFgqPYZy9
	tWeKHb64TGFbIgXopPg+cmgFdKX2PW4=
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
Date: Mon, 22 Jul 2024 12:51:46 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linux-next:master] [mm]  98c9daf5ae:  aim7.jobs-per-min -29.4%
 regression
Message-ID: <ro4jb3noagpeb4dnacexutfqwbdfygryrpfbqa3zbnj5a32nya@jymadbhn7r3y>
References: <202407121335.31a10cb6-oliver.sang@intel.com>
 <ZpF-A9rl8TiuZJPZ@google.com>
 <ZpUux8bvpL8ARYDE@xsang-OptiPlex-9020>
 <ZpWgP-h5X7GKj1ay@google.com>
 <ZpYm9clw/f8f/tEj@xsang-OptiPlex-9020>
 <Zpqe6NSVBQGiS86m@google.com>
 <x2vfqt3frbghlxonagfx52suetu7fod7taktrc6fnt2jwmzg6l@kbdwghkf3htr>
 <Zp58t2DNWwlYQaHe@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zp58t2DNWwlYQaHe@google.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jul 22, 2024 at 03:37:27PM GMT, Roman Gushchin wrote:
> On Fri, Jul 19, 2024 at 03:38:26PM -0700, Shakeel Butt wrote:
> > On Fri, Jul 19, 2024 at 05:14:16PM GMT, Roman Gushchin wrote:
> > > On Tue, Jul 16, 2024 at 03:53:25PM +0800, Oliver Sang wrote:
> > > > hi, Roman,
> > > > 
> > > > On Mon, Jul 15, 2024 at 10:18:39PM +0000, Roman Gushchin wrote:
> > > > > On Mon, Jul 15, 2024 at 10:14:31PM +0800, Oliver Sang wrote:
> > > > > > hi, Roman Gushchin,
> > > > > > 
> > > > > > On Fri, Jul 12, 2024 at 07:03:31PM +0000, Roman Gushchin wrote:
> > > > > > > On Fri, Jul 12, 2024 at 02:04:48PM +0800, kernel test robot wrote:
> > > > > > > > 
> > > > > > > > 
> > > > > > > > Hello,
> > > > > > > > 
> > > > > > > > kernel test robot noticed a -29.4% regression of aim7.jobs-per-min on:
> > > > > > > > 
> > > > > > > > 
> > > > > > > > commit: 98c9daf5ae6be008f78c07b744bcff7bcc6e98da ("mm: memcg: guard memcg1-specific members of struct mem_cgroup_per_node")
> > > > > > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > > > > > 
> > > > > > > Hello,
> > > > > > > 
> > > > > > > thank you for the report!
> > > > > > > 
> > > > > > > I'd expect that the regression should be fixed by the commit
> > > > > > > "mm: memcg: add cache line padding to mem_cgroup_per_node".
> > > > > > > 
> > > > > > > Can you, please, confirm that it's not the case?
> > > > > > > 
> > > > > > > Thank you!
> > > > > > 
> > > > > > in our this aim7 test, we found the performance partially recovered by
> > > > > > "mm: memcg: add cache line padding to mem_cgroup_per_node" but not fully
> > > > > 
> > > > > Thank you for providing the detailed information!
> > > > > 
> > > > > Can you, please, check if the following patch resolves the regression entirely?
> > > > 
> > > > no. in our tests, the following patch has little impact.
> > > > I directly apply it upon 6df13230b6 (if this is not the proper applyment, please
> > > > let me know, thanks)
> > > 
> > > Hm, interesting. And thank you for the confirmation, you did everything correct.
> > > Because the only thing the original patch did was a removal of few fields from
> > > the mem_cgroup_per_node struct, there are not many options left here.
> > > Would you mind to try the following patch?
> > > 
> > > Thank you and really appreciate your help!
> > > 
> > > 
> > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > index 7e2eb091049a..0e5bf25d324f 100644
> > > --- a/include/linux/memcontrol.h
> > > +++ b/include/linux/memcontrol.h
> > > @@ -109,6 +109,7 @@ struct mem_cgroup_per_node {
> > > 
> > >         /* Fields which get updated often at the end. */
> > >         struct lruvec           lruvec;
> > > +       CACHELINE_PADDING(_pad2_);
> > >         unsigned long           lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
> > >         struct mem_cgroup_reclaim_iter  iter;
> > >  };
> > > 
> > > 
> > 
> > I suspect we need padding in the struct mem_cgroup instead of in struct
> > mem_cgroup_per_node. I am planning to run some experiments and will
> > report back once I have some convincing numbers.
> 
> You mean the regression was attributed to the wrong commit?
> Because the blamed commit only removed few fields from the middle
> of mem_cgroup_per_node.
> 

The whole series changed the layout of multiple memcg structs, so
focusing on a single patch is not necessarily correct. We need to accept
the current status and work towards improving the charge and stats
update path to similar or better than before performance.

