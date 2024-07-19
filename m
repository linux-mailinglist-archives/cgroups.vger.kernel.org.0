Return-Path: <cgroups+bounces-3825-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3FE937DDC
	for <lists+cgroups@lfdr.de>; Sat, 20 Jul 2024 00:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7F53B21513
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 22:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820001487FF;
	Fri, 19 Jul 2024 22:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="flyW6R6x"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B905146A85
	for <cgroups@vger.kernel.org>; Fri, 19 Jul 2024 22:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721428718; cv=none; b=JqMkmIwJKnetMcfzov/3vQ0u4uqmwygSW81X2p4TCTKOqb4FZtcUcLpjnfLb20xwjvcvX2Yyu3IdOikHmw3+7PR92tlJTZReRtti2o0k0ddkpUb1nZH8q0+I4bWoNZ5DvqQRotfDXPc8G4x0cL/mJOth55jjI8LV+4cRixvblL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721428718; c=relaxed/simple;
	bh=ItjYX9S8D3vGOx/nd5jhdAF+cMwqqIq0wHcSMIe1Y9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etY0XfSEvGSuwQ86kUcXA2FfplV0yGJ3FmuYb4+8aH8YPaTJEw3iWVDxnsFs7paE96wmvdVVVmf0AvrJ3AnkgMz+ZtmC4iaytwY0eLNkoIMaypVcqaRT2ca+kwwRiJH59JA83YRmkzCvO58LwrnA4r81BCeTU6QIxZEDhhxGwxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=flyW6R6x; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721428713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VY4/Hju5Y9WjjUEbutvnN+TSGFpL24vOvQj6GSXvk90=;
	b=flyW6R6xKncUCwD2FDk4Ewhyf20qukFAeY7JK2qSIKabuKNSgrq6U8k1dA16zHUI8XqwWI
	t//LodQVNk8G84y+ogKmxorE9WF1csy+3UBuS44ivOfE9dFD49zNbnQq3YCEP5RiO3xOJR
	FWUhsjGFzEHkpKbyFgOv4OKtz4QcD30=
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
Date: Fri, 19 Jul 2024 15:38:26 -0700
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
Message-ID: <x2vfqt3frbghlxonagfx52suetu7fod7taktrc6fnt2jwmzg6l@kbdwghkf3htr>
References: <202407121335.31a10cb6-oliver.sang@intel.com>
 <ZpF-A9rl8TiuZJPZ@google.com>
 <ZpUux8bvpL8ARYDE@xsang-OptiPlex-9020>
 <ZpWgP-h5X7GKj1ay@google.com>
 <ZpYm9clw/f8f/tEj@xsang-OptiPlex-9020>
 <Zpqe6NSVBQGiS86m@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zpqe6NSVBQGiS86m@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 19, 2024 at 05:14:16PM GMT, Roman Gushchin wrote:
> On Tue, Jul 16, 2024 at 03:53:25PM +0800, Oliver Sang wrote:
> > hi, Roman,
> > 
> > On Mon, Jul 15, 2024 at 10:18:39PM +0000, Roman Gushchin wrote:
> > > On Mon, Jul 15, 2024 at 10:14:31PM +0800, Oliver Sang wrote:
> > > > hi, Roman Gushchin,
> > > > 
> > > > On Fri, Jul 12, 2024 at 07:03:31PM +0000, Roman Gushchin wrote:
> > > > > On Fri, Jul 12, 2024 at 02:04:48PM +0800, kernel test robot wrote:
> > > > > > 
> > > > > > 
> > > > > > Hello,
> > > > > > 
> > > > > > kernel test robot noticed a -29.4% regression of aim7.jobs-per-min on:
> > > > > > 
> > > > > > 
> > > > > > commit: 98c9daf5ae6be008f78c07b744bcff7bcc6e98da ("mm: memcg: guard memcg1-specific members of struct mem_cgroup_per_node")
> > > > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > > > 
> > > > > Hello,
> > > > > 
> > > > > thank you for the report!
> > > > > 
> > > > > I'd expect that the regression should be fixed by the commit
> > > > > "mm: memcg: add cache line padding to mem_cgroup_per_node".
> > > > > 
> > > > > Can you, please, confirm that it's not the case?
> > > > > 
> > > > > Thank you!
> > > > 
> > > > in our this aim7 test, we found the performance partially recovered by
> > > > "mm: memcg: add cache line padding to mem_cgroup_per_node" but not fully
> > > 
> > > Thank you for providing the detailed information!
> > > 
> > > Can you, please, check if the following patch resolves the regression entirely?
> > 
> > no. in our tests, the following patch has little impact.
> > I directly apply it upon 6df13230b6 (if this is not the proper applyment, please
> > let me know, thanks)
> 
> Hm, interesting. And thank you for the confirmation, you did everything correct.
> Because the only thing the original patch did was a removal of few fields from
> the mem_cgroup_per_node struct, there are not many options left here.
> Would you mind to try the following patch?
> 
> Thank you and really appreciate your help!
> 
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 7e2eb091049a..0e5bf25d324f 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -109,6 +109,7 @@ struct mem_cgroup_per_node {
> 
>         /* Fields which get updated often at the end. */
>         struct lruvec           lruvec;
> +       CACHELINE_PADDING(_pad2_);
>         unsigned long           lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
>         struct mem_cgroup_reclaim_iter  iter;
>  };
> 
> 

I suspect we need padding in the struct mem_cgroup instead of in struct
mem_cgroup_per_node. I am planning to run some experiments and will
report back once I have some convincing numbers.

