Return-Path: <cgroups+bounces-7970-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C1FAA660F
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 00:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1821BC65B1
	for <lists+cgroups@lfdr.de>; Thu,  1 May 2025 22:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2403B262FEA;
	Thu,  1 May 2025 22:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VlvLn8k/"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FD021ABB6
	for <cgroups@vger.kernel.org>; Thu,  1 May 2025 22:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746137439; cv=none; b=mCZ6zShqADuvvfGGEjFOYPCCmQbS4PPJkiu6VXalTFEq1L3o5g/SfJ/6Pi7hmXacao8gyWVt9PWzdHVZn/bQz5oTerSs6j+988yicB9gFFck3yAg/xnjXgLzHwwYE+JM+wpDVk8tYRhqA8AKnkikHU1mIbduQJyVbX1Z7+bWzVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746137439; c=relaxed/simple;
	bh=mepdlPBGZNYZGwYzPCMYwzzQe9rNn+dnMwYfJnj0L3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNmBTrmHRkvncTC82Wo4jOVv18sD1e6+PO618Dna0Nubj+QrLiH4L916FaCovQnkOGe+BrTbhaLk8BqCJnUq/8Tq2l/zffzYpdnEhgdtgpSuAMD+7U9oAItrVznFW9jYLLx2+adOwWBJLp0JMDxaBAjqCOnByBhg7ClW4KGXJt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VlvLn8k/; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 1 May 2025 15:10:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746137426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T9+4ZPe0UgZes1pnp++1tI2QtV+cxnxhaX2/c7tDBlY=;
	b=VlvLn8k/VaizfjSHHuJKoe+FM8bCo0MUjVMM8xxJLHmqJ1I7vmcUaHZ1r8GfG4IoTyTCWu
	/l8qVCGbrkVRVkI6R5rmzHhuHbp4t+z+eYtOXOmBY5Bmdw/CvDQnJANONlovANVeac4xB2
	X2VFpEXA8+16X/J09cmx94HZ00eRU20=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexei Starovoitov <ast@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	JP Kobryn <inwardvessel@gmail.com>, bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 3/3] cgroup: make css_rstat_updated nmi safe
Message-ID: <6u7ccequ5ye3e4iqblcdeqsigindo3xjpsvkdb6hyaw7cpjddc@u2ujv7ymlxc6>
References: <20250429061211.1295443-1-shakeel.butt@linux.dev>
 <20250429061211.1295443-4-shakeel.butt@linux.dev>
 <aBIiNMXIl6vyaNQ6@Asmaa.>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBIiNMXIl6vyaNQ6@Asmaa.>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 30, 2025 at 06:14:28AM -0700, Yosry Ahmed wrote:
[...]
> > +
> > +	if (!_css_rstat_cpu_trylock(css, cpu, &flags)) {
> 
> 
> IIUC this trylock will only fail if a BPF program runs in NMI context
> and tries to update cgroup stats, interrupting a context that is already
> holding the lock (i.e. updating or flushing stats).
> 

Correct (though note that flushing side can be on a different CPU).

> How often does this happen in practice tho? Is it worth the complexity?

This is about correctness, so even a chance of occurance need the
solution.

> 
> I wonder if it's better if we make css_rstat_updated() inherently
> lockless instead.
> 
> What if css_rstat_updated() always just adds to a lockless tree,

Here I assume you meant lockless list instead of tree.

> and we
> defer constructing the proper tree to the flushing side? This should
> make updates generally faster and avoids locking or disabling interrupts
> in the fast path. We essentially push more work to the flushing side.
> 
> We may be able to consolidate some of the code too if all the logic
> manipulating the tree is on the flushing side.
> 
> WDYT? Am I missing something here?
> 

Yes this can be done but I don't think we need to tie that to current
series. I think we can start with lockless in the nmi context and then
iteratively make css_rstat_updated() lockless for all contexts.


