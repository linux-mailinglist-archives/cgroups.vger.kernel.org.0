Return-Path: <cgroups+bounces-12623-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B03F5CDB02D
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 01:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23B343008886
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 00:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E788834;
	Wed, 24 Dec 2025 00:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EJPLAitW"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EF920DE3
	for <cgroups@vger.kernel.org>; Wed, 24 Dec 2025 00:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766537901; cv=none; b=m/SQav78ONwln7WgKm//1OGIoUdHAaBxPG1bWJGuBsZVjo4wnLQ3UNH1eyE/YdbTCEN5Z5NB3jpSPKdjCVsinbrJw7H97qKzvo9RE+faQqvk8mYjae0Yo577svC5eVFj6qdVjC6jvFE5ITcR59rOJesqpK2rhMkGW6QnYD/pGXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766537901; c=relaxed/simple;
	bh=hpFa3dRskvDrahlSLpivoXEKiTs0RfAi+i/8mQRl+Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndGN7P4SM4vo1M1up+5kWLE7pR6j49+mpsIzxsx8u0rkUEUYVRDtRyFpeMtFs/orQLkoOMqeOweziLotPwhpRrEJOTfvoI1sfgC4WmuucwFyjClSmN0izkFs0W6OE1zUgnHI8/pD6FPLe0wgQmLexJW54K8IyIrbQxNfoYmYkh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EJPLAitW; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 23 Dec 2025 16:58:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766537896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nMWD7UiGq4+nKnU4Z5jjdenRiWuzNHLLrtk/SYoaKkY=;
	b=EJPLAitWCuidgw7MtCISWSK6vFEbH/3fbEMzVSM45A0kSaL147SH1Ar/mBr7f5CW15JMW0
	RLT6PNCvY5dMy/tJdwxdPQziwCZ19S7/ZCzBxoUd6rNB3tzJrQmQDXebfUBksXV3Vg+H2P
	tpcoEKT8jP3bAotwqYs5PnqKtc3LeEg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com, 
	mhocko@suse.com, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, 
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com, 
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, 
	lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
Message-ID: <wvj4w7ifmrifnh5bvftdziudsj52fdnwlhbt2oifwmxmi4eore@ob3mrfahhnm5>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <5dsb6q2r4xsi24kk5gcnckljuvgvvp6nwifwvc4wuho5hsifeg@5ukg2dq6ini5>
 <vsr4khfsp4unk73a75ky7i35nzdjqsbodyeeuxipu3arormfjr@awi2srdwawfu>
 <utl6esq7jz5e4f7kwgrpwdjc2rm3yi33ljb6xkm5nxzufa4o7s@hblq2piu3vnz>
 <7enyz6xhyjjp5djpj7jnvqiymqfpmb2gmhmmj7r5rkzjyix7o7@mpxpa566abyd>
 <llwoiz4k5l44z2dyo6oubcflfarhep654cr5tvcrnkltbw4eni@kxywzukbgyha>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <llwoiz4k5l44z2dyo6oubcflfarhep654cr5tvcrnkltbw4eni@kxywzukbgyha>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 24, 2025 at 12:43:00AM +0000, Yosry Ahmed wrote:
[...]
> > 
> > I think you meant child's memcg here.
> 
> Yes, sorry.
> 
> > 
> > > before
> > > reparenting, and using it to update the stats after reparenting? A grace
> > > period only works if the entire scope of using the memcg is within the
> > > RCU critical section.
> > 
> > Yeah this is an issue.
> > 
> > > 
> > > For example, __mem_cgroup_try_charge_swap() currently does this when
> > > incrementing MEMCG_SWAP. While this specific example isn't problematic
> > > because the reference won't be dropped until MEMCG_SWAP is decremented
> > > again, the pattern of grabbing a ref to the memcg then updating a stat
> > > could generally cause the problem.
> > > 
> > > Most stats are updated using lruvec_stat_mod_folio(), which updates the
> > > stats in the same RCU critical section as obtaining the memcg pointer
> > > from the folio, so it can be fixed with a grace period. However, I think
> > > it can be easily missed in the future if other code paths update memcg
> > > stats in a different way. We should try to enforce that stat updates
> > > cannot only happen from the same RCU critical section where the memcg
> > > pointer is acquired.
> > 
> > The core stats update functions are mod_memcg_state() and
> > mod_memcg_lruvec_state(). If for v1 only, we add additional check for
> > CSS_DYING and go to parent if CSS_DYING is set then shouldn't we avoid
> > this issue?
> 
> But this is still racy, right? The cgroup could become dying right after
> we check CSS_DYING, no?

We do reparenting in css_offline() callback and cgroup offlining
happen somewhat like this:

1. Set CSS_DYING
2. Trigger percpu ref kill
3. Kernel makes sure css ref killed is seen by all CPUs and then trigger
   css_offline callback.

So, if in the stats update function we check CSS_DYING flag and the
actual stats update within rcu, I think we are good.

