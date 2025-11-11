Return-Path: <cgroups+bounces-11832-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B49FC4F9D4
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 20:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A5D94E241F
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 19:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FBC328B6C;
	Tue, 11 Nov 2025 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HSM8/b04"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97F0328B55
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 19:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762889664; cv=none; b=B4mqM8Wp5oKx6q0e+aolEeRou7ENBhvZjuSY22keWcYVWlO8IQ8KEibAm8iYzIth17MrVHnxb4SSeF5v4R1VqS/brTW+nSoM1Voq1NWh05J2yjqnwSxTD72knUn4Nuc4Sf2LvaUBqewdJsN2HfYlcAOLV3oLixTMZLOWqgoSntM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762889664; c=relaxed/simple;
	bh=KssuIzn0oVtRjHR/Q6bWgh+b049osJMeDnfLAZ+GUCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciBmD6S/x7AAeWTEzFL1cbnWPWoFlrgVx3Wh/LKMgYCS0Qw7tc+vIyK/0oi9b3JpTqBeaLKRR//aZw7+iWf+45iqAb9GobUw/JwBMsjDOETwLQWXcGLXgwj7r1gyaL5jmKZdzZ0VGK5zJpvFTIQAkXYKKJrlBIHJ/2bEd9K0/nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HSM8/b04; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 11 Nov 2025 11:34:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762889657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u+/QIYglm3+7rhOS6L7Kr9NAKmdN6FeBGXByzeklErs=;
	b=HSM8/b04crKD15cHPSnLQx4Hhg2/3Us8iUQB645UpiF+QFOEmAw+UOT0+SyUrYVCQWmUDz
	tZsE/VL6fS1cWO+eXr2Ms/1rLGv/BLb659T1jvAiYYrHlcmDOEWF/nQvfPODuNJBS9ALRE
	0a1L69FWHj4U6P9pxJywFzDkIgZrQug=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 0/4] memcg: cleanup the memcg stats interfaces
Message-ID: <djh4sirs2cgmdhso5fwcx7s6yrkocxbqshcosgrqetfykte2bz@opfihf4wun4v>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
 <87pl9oqtpg.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pl9oqtpg.fsf@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, Nov 11, 2025 at 11:01:47AM -0800, Roman Gushchin wrote:
> Shakeel Butt <shakeel.butt@linux.dev> writes:
> 
> > The memcg stats are safe against irq (and nmi) context and thus does not
> > require disabling irqs. However for some stats which are also maintained
> > at node level, it is using irq unsafe interface and thus requiring the
> > users to still disables irqs or use interfaces which explicitly disables
> > irqs. Let's move memcg code to use irq safe node level stats function
> > which is already optimized for architectures with HAVE_CMPXCHG_LOCAL
> > (all major ones), so there will not be any performance penalty for its
> > usage.
> 
> Do you have any production data for this or it's theory-based?

At the moment it is theory-based or more specifically based on the
comments on HAVE_CMPXCHG_LOCAL variants of stats update functions.

> 
> In general I feel we need a benchmark focused on memcg stats:
> there was a number of performance improvements and regressions in this
> code over last years, so a dedicated benchmark can help with measuring
> them.

Yeah it makes sense to have a benchmark. Let me see which benchmark
trigger this code paths a lot. At the high level, these interfaces are
used in reclaim and migration which are not really that performance
critical. I will try benchmarks with a lot of allocs/frees.

> 
> Nice cleanup btw, thanks!

Thanks.

