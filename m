Return-Path: <cgroups+bounces-8319-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 296ECAC14FB
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 21:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1EF717989A
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 19:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CE929AAE5;
	Thu, 22 May 2025 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EODVfA5c"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8574E1F5846
	for <cgroups@vger.kernel.org>; Thu, 22 May 2025 19:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747943472; cv=none; b=FtHjrwQqMZcBYzTe9/KGpcuQ+i6RD+4ZSTcoUWI/c6m77RJnYg2kDkTzXuiUfjwgqoHKUv6MSwb3cl9q0cUbCM/CdqAh8wlWiuotswToXTTNz64nHmdiGS+cpC3wsKndZeLLhk5pNUur1y1QkfPW77HaK8RQY1QAQzAwCAvYrVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747943472; c=relaxed/simple;
	bh=DFUCJtl+L58Pj5bTViEhxoTPuRVbbHuWRPjzQaORv1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYADp15IeVdWQVM8YjAqthSggj7aKY3bIOzS/T7i+jwMdPcciJJHkooaJnuwhR9Twt5Kev1yHHXWoJ/d9rVyN3+xjw0G9DqHD+9Ba8/onFkuSI6MSs5T0pBqXDf7H/TGinJTF5JBwmgI2O8Nt/94zK5/zXgL55Wd7vEBt8hSxwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EODVfA5c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7763FC4CEE4;
	Thu, 22 May 2025 19:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747943471;
	bh=DFUCJtl+L58Pj5bTViEhxoTPuRVbbHuWRPjzQaORv1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EODVfA5cjMTS33Uwal4E9GFZbFhGr1i450nJ++XjjSqQs+EiL9tYMdNvztifWtPsW
	 Wo90bOgrqtIZtEcCCSOLRIuDQZX+p98Oh4ucQdMz+KyS889c1+bWPNAXLPIprOoCbO
	 1oNy78Y5mehLpWpxcYwfdX5Klhdjhlv9HHHz+BCXbhClCkA7QLUN+nvDlvlaT8IyNp
	 j1YElZUWm89PHmz6b4i6DALedFYJc6KGfvSij5Aj9RR5vlfdFV1eAuSMnxvHueQ7OM
	 OJORIbykFGJMXweofo+11WjqZRVTOX7xzvB6XN+EiGDQp9w4HdDnknhWIhzYfpFHbe
	 6TEHUJ8/bD6Zw==
Date: Thu, 22 May 2025 09:51:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Dave Airlie <airlied@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	Waiman Long <longman@redhat.com>, simona@ffwll.ch
Subject: Re: [rfc] drm/ttm/memcg: simplest initial memcg/ttm integration (v2)
Message-ID: <aC-ALtcs8RF1yZ1y@slm.duckdns.org>
References: <CAPM=9txLcFNt-5hfHtmW5C=zhaC4pGukQJ=aOi1zq_bTCHq4zg@mail.gmail.com>
 <b0953201-8d04-49f3-a116-8ae1936c581c@amd.com>
 <20250515160842.GA720744@cmpxchg.org>
 <bba93237-9266-4e25-a543-e309eb7bb4ec@amd.com>
 <20250516145318.GB720744@cmpxchg.org>
 <5000d284-162c-4e63-9883-7e6957209b95@amd.com>
 <20250516164150.GD720744@cmpxchg.org>
 <eff07695-3de2-49b7-8cde-19a1a6cf3161@amd.com>
 <20250516200423.GE720744@cmpxchg.org>
 <CAPM=9txLaTjfjgC_h9PLR4H-LKpC9_Fet7=HYBpyeoCL6yAQJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9txLaTjfjgC_h9PLR4H-LKpC9_Fet7=HYBpyeoCL6yAQJg@mail.gmail.com>

Hello,

On Sat, May 17, 2025 at 06:25:02AM +1000, Dave Airlie wrote:
> I think this is where we have 2 options:
> (a) moving this stuff into core mm and out of shrinker context
> (b) fix our shrinker to be cgroup aware and solve that first.
> 
> The main question I have for Christian, is can you give me a list of
> use cases that this will seriously negatively effect if we proceed
> with (b).

This thread seems to have gone a bit haywire and we may be losing some
context. I'm not sure not doing (b) is an option for acceptable isolation. I
think Johannes already raised the issue but please consider the following
scenario:

- There's a GPU workload which uses a sizable amount of system memory for
  the pool being discussed in this thread. This GPU workload is very
  important, so we want to make sure that other activities in the system
  don't bother it. We give it plenty of isolated CPUs and protect its memory
  with high enough memory.low.

- Because most CPUs are largely idling while GPU is busy, there are plenty
  of CPU cycles which can be used without impacting the GPU workload, so we
  decide to do some data preprocessing which involves scanning large data
  set creating memory usage which is mostly streaming but still has enough
  look backs to promote them in the LRU lists.

IIUC, in the shared pool model, the GPU memory which isn't currently being
used would sit outside the cgroup, and thus outside the protection of
memory.low. Again, IIUC, you want to make this pool priority reclaimed
because reclaiming is nearly free and you don't want to create undue
pressure on other reclaimable resources.

However, what would happen in the above scenario under such implementation
is that the GPU workload would keep losing its memory pool to the background
memory pressure created by the streaming memory usage. It's also easy to
expand on scenarios like this with other GPU workloads with differing
priorities and memory allotments and so on.

There may be some basic misunderstanding here. If a resource is worth
caching, that usually indicates that there's some significant cost
associated with un-caching the resource. It doesn't matter whether that cost
is on the creation or destruction path. Here, the alloc path is expensive
and free path is nearly free. However, this doesn't mean that we can get
free isolation while bunching them together for immediate reclaim as others
would be able to force you into alloc operations that you wouldn't need
otherwise. If someone else can make you pay for something that you otherwise
wouldn't, that resource is not isolated.

Thanks.

-- 
tejun

