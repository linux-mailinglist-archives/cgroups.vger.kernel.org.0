Return-Path: <cgroups+bounces-12883-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D3DCEF2C6
	for <lists+cgroups@lfdr.de>; Fri, 02 Jan 2026 19:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5818C3001BEB
	for <lists+cgroups@lfdr.de>; Fri,  2 Jan 2026 18:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1775A3B2A0;
	Fri,  2 Jan 2026 18:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iK8VVwTl"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCA2155C87
	for <cgroups@vger.kernel.org>; Fri,  2 Jan 2026 18:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767378084; cv=none; b=sMuM6TCRywjHvpKCp0bRQbEumzTvOri+X40cGXcUAAaS2OXn5Wnq5A9INgU7xICAKV0eqQMeO/D6IabzbJGW5L2SqAeCrBR/rewOCw5FXMr2RapCU3j0ev0U//T9WM/TLVKKSNS7oGtPVda42XDff1Kr5rDUeT2//FSgfHQk/p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767378084; c=relaxed/simple;
	bh=no2/LRPbLpI270LdSIsPE1BXVR77qFgi/sQv34d9PBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmFalnaNv1TnGUX8Cp0YvzSBaSzwHLD9MVvam1h2HupeQb7gPlaWrkF1ax0BRyTZo63lLlSRcbGX5909ofFB+TFkNXhf+Tp7SSvy6g1kmL/ckSDP5x8lmyyq7fZYEqZMltKlNwJVbce6OQjKZG1kdUEDcOT7jsW9gCFIomKR3tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iK8VVwTl; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 2 Jan 2026 18:21:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767378069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7HbQAOnXEOXuo4VPboQfFJ1oE7ZW8cXxVzCFf9i5LVE=;
	b=iK8VVwTlkX2pNH6Nkz7FyutiDaJsPCGY+EPeGBfLJ+CW0CWyjitl5drLDamwF4ECWu2FBE
	74mpR8FM67plEauq++o7cM9dfpN89zqnhqPYOtOu4iUjIh82wOm4jN9iL013DAPv86AvEB
	ruC5wnPi88v70fEYDO40hwRpRFDdIOg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com, 
	harry.yoo@oracle.com, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	chenridong@huaweicloud.com, akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, 
	apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
Message-ID: <ebdhvcwygvnfejai5azhg3sjudsjorwmlcvmzadpkhexoeq3tb@5gj5y2exdhpn>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <5dsb6q2r4xsi24kk5gcnckljuvgvvp6nwifwvc4wuho5hsifeg@5ukg2dq6ini5>
 <vsr4khfsp4unk73a75ky7i35nzdjqsbodyeeuxipu3arormfjr@awi2srdwawfu>
 <utl6esq7jz5e4f7kwgrpwdjc2rm3yi33ljb6xkm5nxzufa4o7s@hblq2piu3vnz>
 <7enyz6xhyjjp5djpj7jnvqiymqfpmb2gmhmmj7r5rkzjyix7o7@mpxpa566abyd>
 <llwoiz4k5l44z2dyo6oubcflfarhep654cr5tvcrnkltbw4eni@kxywzukbgyha>
 <wvj4w7ifmrifnh5bvftdziudsj52fdnwlhbt2oifwmxmi4eore@ob3mrfahhnm5>
 <63c958ae-9db2-4da8-935b-a596cc8535d3@linux.dev>
 <xlvmvjieqfltqtf5y6y37elcwstrhs6sp7qco2npgucdd4ggus@icfvpgxrwljl>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xlvmvjieqfltqtf5y6y37elcwstrhs6sp7qco2npgucdd4ggus@icfvpgxrwljl>
X-Migadu-Flow: FLOW_OUT

On Mon, Dec 29, 2025 at 11:52:52AM +0100, Michal Koutný wrote:
> On Tue, Dec 23, 2025 at 04:36:18PM -0800, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> ...
> > The core stats update functions are mod_memcg_state() and
> > mod_memcg_lruvec_state(). If for v1 only, we add additional check for
> > CSS_DYING and go to parent if CSS_DYING is set then shouldn't we avoid
> > this issue?
> 
> ...and go to first !CSS_DYING ancestor :-/ (as the whole chain of memcgs
> can be offlined)
> 
> IIUC thanks to the reparenting charging (modifying state) to an offlined
> memcg should be an exception...
> 
> 
> On Mon, Dec 29, 2025 at 05:42:43PM +0800, Qi Zheng <qi.zheng@linux.dev> wrote:
> 
> > > We do reparenting in css_offline() callback and cgroup offlining
> > > happen somewhat like this:
> > > 
> > > 1. Set CSS_DYING
> > > 2. Trigger percpu ref kill
> > > 3. Kernel makes sure css ref killed is seen by all CPUs and then trigger
> > >     css_offline callback.
> > 
> > it seems that we can add the following to
> > mem_cgroup_css_free():
> > 
> > parent->vmstats->state_local += child->vmstats->state_local;
> > 
> > Right? I will continue to take a closer look.
> 
> ...and the time between offlining and free'ing a memcg should not be
> arbitrarily long anymore (right?, the crux of the series).
> So only transferring local stats in mem_cgroup_css_free should yield a
> correct result after limited time range (with possible underflows
> between) with no special precaution for CSS_DYING on charging side.

I don't think this works, unfortunately. Even with refs from folios to
memcgs dropped at offlining, there could still be long-living refs (e.g.
from swapped out entries). So we cannot wait until the memcg is released
or freed to do the reparenting of the stats.

I think the right thing to do is, as discussed with Shakeel, move the
stats at the time of offlining after reparenting the LRUs, and forward
further updates to the first non-dying parent.

We'll need to be careful with synchronization. We'll probably need an
RCU sync after reparenting the LRUs before moving the stats to the
parent, and we'll need to make sure stat updaters get the memcg and
update the stats within the same RCU section. Ideally with guards
against breaking this in the future.

> 
> 0.02€,
> Michal



