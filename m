Return-Path: <cgroups+bounces-5314-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F01C9B53A9
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2024 21:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C06371C22D12
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2024 20:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F24208994;
	Tue, 29 Oct 2024 20:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JIFVDjz8"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31FF207A2F
	for <cgroups@vger.kernel.org>; Tue, 29 Oct 2024 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233710; cv=none; b=HUDgsRNjzCD3YEXJBynhLxUMykWKM39W7Wp0wmFBkcGiSTOJlMllS0lG4ejLBzs4VjuCMcVo/VJROMKy/SyVY1KdXFtk2zSNqJpW4Sh9KAdILzFWJm3uCVQtybywYCKQ10ZfY+9zfiH0+WI9thvEzPzrXXxR8F10aXPmnJlT7E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233710; c=relaxed/simple;
	bh=pt7hEYK2NZ9lH45fSBbcYEZb+c9cXbVGNHdBq6llDUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/29agUV10cfD2UXDnly0YhIIDIE7fy70K+ODEtUybz7aAmkbFDKBOqh56diH3GLnjXbKJxeN6AckKSRLcZ2ZwqEGfM2KXy4AD5Xa9p7njBx9w8xDxrZuJHUL87gw2ABYGZUoHt5QoB3gfhSIj6xbwAku+V6XAp/TWudXb1y2tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JIFVDjz8; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 29 Oct 2024 20:28:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730233705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/krkHZhH3d22lI+5CXQ8I3yC4kmpYVhP1+xBMxmHYuk=;
	b=JIFVDjz8fe+/gYuEyC6SnDLSfvTYtWRcZ8/QdEI+SKyapV8MX/WCvOHeIU5r48y33O3LVn
	ppihBVH/TRprJdoXef8GvlTxLTGcANUNYgD19WtM+ivqQTZrTGCCeQ5EqAzqa8S2dc0cpg
	+sCH6R+kqvI9b1BUehaGRFzwUuSuyzU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, shakeel.butt@linux.dev,
	mhocko@kernel.org, muchun.song@linux.dev, tj@kernel.org,
	lizefan.x@bytedance.com, mkoutny@suse.com, corbet@lwn.net,
	lnyng@meta.com, akpm@linux-foundation.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 1/1] memcg/hugetlb: Adding hugeTLB counters to memcg
Message-ID: <ZyFFY65bGILq6GfQ@google.com>
References: <20241028210505.1950884-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028210505.1950884-1-joshua.hahnjy@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 28, 2024 at 02:05:05PM -0700, Joshua Hahn wrote:
> This patch introduces a new counter to memory.stat that tracks hugeTLB
> usage, only if hugeTLB accounting is done to memory.current. This
> feature is enabled the same way hugeTLB accounting is enabled, via
> the memory_hugetlb_accounting mount flag for cgroupsv2.
> 
> 1. Why is this patch necessary?
> Currently, memcg hugeTLB accounting is an opt-in feature [1] that adds
> hugeTLB usage to memory.current. However, the metric is not reported in
> memory.stat. Given that users often interpret memory.stat as a breakdown
> of the value reported in memory.current, the disparity between the two
> reports can be confusing. This patch solves this problem by including
> the metric in memory.stat as well, but only if it is also reported in
> memory.current (it would also be confusing if the value was reported in
> memory.stat, but not in memory.current)
> 
> Aside from the consistency between the two files, we also see benefits
> in observability. Userspace might be interested in the hugeTLB footprint
> of cgroups for many reasons. For instance, system admins might want to
> verify that hugeTLB usage is distributed as expected across tasks: i.e.
> memory-intensive tasks are using more hugeTLB pages than tasks that
> don't consume a lot of memory, or are seen to fault frequently. Note that
> this is separate from wanting to inspect the distribution for limiting
> purposes (in which case, hugeTLB controller makes more sense).
> 
> 2. We already have a hugeTLB controller. Why not use that?
> It is true that hugeTLB tracks the exact value that we want. In fact, by
> enabling the hugeTLB controller, we get all of the observability
> benefits that I mentioned above, and users can check the total hugeTLB
> usage, verify if it is distributed as expected, etc.
> 
> With this said, there are 2 problems:
> (a) They are still not reported in memory.stat, which means the
>     disparity between the memcg reports are still there.
> (b) We cannot reasonably expect users to enable the hugeTLB controller
>     just for the sake of hugeTLB usage reporting, especially since
>     they don't have any use for hugeTLB usage enforcing [2].
> 
> [1] https://lore.kernel.org/all/20231006184629.155543-1-nphamcs@gmail.com/
> [2] Of course, we can't make a new patch for every feature that can be
>     duplicated. However, since the existing solution of enabling the
>     hugeTLB controller is an imperfect solution that still leaves a
>     discrepancy between memory.stat and memory.curent, I think that it
>     is reasonable to isolate the feature in this case.
>  
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

