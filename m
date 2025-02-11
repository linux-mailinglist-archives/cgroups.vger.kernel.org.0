Return-Path: <cgroups+bounces-6495-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B523FA302A0
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2025 05:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A39F165F89
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2025 04:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47641D86ED;
	Tue, 11 Feb 2025 04:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d2Tme3vf"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851762F5E
	for <cgroups@vger.kernel.org>; Tue, 11 Feb 2025 04:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739249754; cv=none; b=psMA/tPFDBfGC/DQPrIwCJJVkzu9Ljrz5VhPrTXLt0XarczUnfdx1voNcekTXsMlpyYHU5/qdMkiJy2TVmbk8NS/SZg+tUGxt++qZWkC67Y5juZMFz4kyiBBXo7u5LCLr+35luxIMrk7l2J48nk3aezqXwoNmadqmqSlvPQYMtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739249754; c=relaxed/simple;
	bh=cLtgGtKvPbFDEQDs/LpZUgRuq6+tRZHziHlcJWA47PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAhd8GWLdlAuVMsQFCEqTbyEOAMtakv6GmyADWVbqovbJDq6GnIQOlxcZ63zYV/1iBE52QjvW7H4mAflRHkvpHkCtlWlYIunrYA3pUQoaSc4nrMQy8l7CgUT9ojTCGS2Ota2G5wrrbSMSQj3l0sLRNvb0FA2MtxsKooWBB9x4iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d2Tme3vf; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 11 Feb 2025 04:55:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739249740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GbFheEIJWIPlRA0WvVrzoCQgek7LQL12pV6Kk2aGtLI=;
	b=d2Tme3vfjKZx5BN1uMvyC2RJnV4sSCx4QGgXr2Kbv9tdc9y9ItQa9/KW8tcD2OZiffMoNH
	iwxyWbt2bewidWowUCUVcbPykBmuC2eGaWNyhIQq0gv+fvWqjR5MZlb6ogx0tFLxpPgRfu
	JNpegVJZl1wwTmvliwB3v0+XsF6LU3E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"T.J. Mercier" <tjmercier@google.com>, Tejun Heo <tj@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: add hierarchical effective limits for v2
Message-ID: <Z6rYReNBVNyYq-Sg@google.com>
References: <20250205222029.2979048-1-shakeel.butt@linux.dev>
 <mshcu3puv5zjsnendao73nxnvb2yiprml7aqgndc37d7k4f2em@vqq2l6dj7pxh>
 <ctuqkowzqhxvpgij762dcuf24i57exuhjjhuh243qhngxi5ymg@lazsczjvy4yd>
 <5jwdklebrnbym6c7ynd5y53t3wq453lg2iup6rj4yux5i72own@ay52cqthg3hy>
 <20250210225234.GB2484@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250210225234.GB2484@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 10, 2025 at 05:52:34PM -0500, Johannes Weiner wrote:
> On Mon, Feb 10, 2025 at 05:24:17PM +0100, Michal Koutný wrote:
> > Hello.
> > 
> > On Thu, Feb 06, 2025 at 11:09:05AM -0800, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > Oh I totally forgot about your series. In my use-case, it is not about
> > > dynamically knowning how much they can expand and adjust themselves but
> > > rather knowing statically upfront what resources they have been given.
> > 
> > From the memcg PoV, the effective value doesn't tell how much they were
> > given (because of sharing).
> 
> It's definitely true that if you have an ancestral limit for several
> otherwise unlimited siblings, then interpreting this number as "this
> is how much memory I have available" will be completely misleading.
> 
> I would also say that sharing a limit with several siblings requires a
> certain degree of awareness and cooperation between them. From that
> POV, IMO it would be fine to provide a metric with contextual caveats.
> 
> The problem is, what do we do with canned, unaware, maybe untrusted
> applications? And they don't necessarily know which they are.
> 
> It depends heavily on the judgement of the administrator of any given
> deployment. Some workloads might be completely untrusted and hard
> limited. Another deployment might consider the same workload
> reasonably predictable that it's configured only with a failsafe max
> limit that is much higher than where the workload is *expected* to
> operate. The allotment might happen altogether with min/low
> protections and no max limit. Or there could be a combination of
> protection slightly below and a limit slightly above the expected
> workload size.
> 
> It seems basically impossible to write portable code against this
> without knowing the intent of the person setting it up.
> 
> But how do we communicate intent down to the container? The two broad
> options are implicitly or explicitly:
> 
> a) Provide a cgroup file that automatically derives intended target
>    size from how min/low/high/max are set up.
> 
>    Right now those can be set up super loosely depending on what the
>    administrator thinks about the application. In order for this to
>    work, we'd likely have to define an idiomatic way of configuring
>    the controller. E.g. if you set max by itself, we assume this is
>    the target size. If you set low, with or without max, then low is
>    the target size. Or if you set both, target is in between.
> 
>    I'm not completely convinced this is workable.

This sounds like memory.available.

It's hard to implement well, especially taking into account things like
numa, memory sharing, estimating how much can be reclaimed, etc.

But at the same time there is a value in providing such metric.
There is a clear use case. And it's even harder to implement this
in userspace.

> b) Provide a cgroup file that is freely configurable by the
>    administrator with the target size of the container.
> 
>    This has obvious drawbacks as well. What's the default value? Also,
>    a lot of setups are dead simple: set a hard limit and expect the
>    workload to adhere to that, period. Nobody is going to reliably set
>    another cgroup file that a workload may or may not consume.

Yeah, this is a weird option.

> 
> The third option is to wash our hands of all of this, provide the
> static hierarchy settings to the leaves (like this patch, plus do it
> for the other knobs as well) and let userspace figure it out.

Idk, I see a very little value in it. I'm not necessarily opposing this patchset,
just not seeing a lot of value.

Maybe I'm missing something, but somehow it wasn't a problem for many years.
Nothing really changed here.

So maybe someone can come up with a better explanation of a specific problem
we're trying to solve here?

Thanks!

