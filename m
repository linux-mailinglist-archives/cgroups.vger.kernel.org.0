Return-Path: <cgroups+bounces-2081-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C795881998
	for <lists+cgroups@lfdr.de>; Wed, 20 Mar 2024 23:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E1A282FF0
	for <lists+cgroups@lfdr.de>; Wed, 20 Mar 2024 22:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961A8126F11;
	Wed, 20 Mar 2024 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="URTtPPLS"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B687D86ACC
	for <cgroups@vger.kernel.org>; Wed, 20 Mar 2024 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710974329; cv=none; b=JMMbBKKdT8mXaFleWQtI5TBAoUkb9eqaUjBgJg8uy7vsgbMc3YWMyM4+uYr52xcG7naADa4aMC4GTQB9LL32RM6gR8yjxBYWwV4nZq4mquix6JkZhC3CjkLTV+I7Ijp6J8axQ0UJI+mqzRqVJ/9inZeo4muEcxl/mxjyOUCXM6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710974329; c=relaxed/simple;
	bh=zN7xwFByqtX0SNgUDblzv18pthRpp6ItWXcAvRRTgtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uu8taR/ucSIl9BDYzYdJrpYxD4cCqHlV3FPZFCUYC5vGhGtDQ4mYEm4htq3se3L0rnZUqNa1sYo3BEuGzzd64OwYqg1pP4+SiXHtyr29FrcIcdTro/8T30TtrHj5F4rjbW/ySZcA5Pd7Xyy3BAUyPOBukFA9jymXb/rqr8kpAyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=URTtPPLS; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 Mar 2024 15:38:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710974325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fdASLFv2/fpQ2J/Ny9c7D56INI9+Df/mhIjRVwm3hrg=;
	b=URTtPPLSThfeQKeOGopVvqEwoBcfCWf55w/sMysnz0BWAaIWc23oX13AwEypZm92Jhv6U8
	RdRh2Y3lNzCR09xWufVKFdcBEH3AR2XAw+qwB91xNKpyCftCanX6cXA9QSqE64r5yO9Is4
	87gi9/lRigNTzlOM14FGLeK/GBcvZB0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vladimir Davydov <vdavydov.dev@gmail.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH] mm/memcontrol: stop resize loop if limit was changed
 again
Message-ID: <ZftlcFQMkQIcX8LP@P9FQF9L96D>
References: <20240320100556.463266-1-ptikhomirov@virtuozzo.com>
 <Zfq6XaACmN2JssTW@tiehlicka>
 <be8cfada-f4bd-4894-848d-1b7706b14035@virtuozzo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be8cfada-f4bd-4894-848d-1b7706b14035@virtuozzo.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 20, 2024 at 06:55:05PM +0800, Pavel Tikhomirov wrote:
> 
> 
> On 20/03/2024 18:28, Michal Hocko wrote:
> > On Wed 20-03-24 18:03:30, Pavel Tikhomirov wrote:
> > > In memory_max_write() we first set memcg->memory.max and only then
> > > try to enforce it in loop. What if while we are in loop someone else
> > > have changed memcg->memory.max but we are still trying to enforce
> > > the old value? I believe this can lead to nasty consequence like getting
> > > an oom on perfectly fine cgroup within it's limits or excess reclaim.
> > 
> > I would argue that uncoordinated hard limit configuration can cause
> > problems on their own.
> 
> Sorry, didn't know that.
> 
> > Beside how is this any different from changing
> > the high limit while we are inside the reclaim loop?
> 
> I believe reclaim loop rereads limits on each iteration, e.g. in
> reclaim_high(), so it should always be enforcing the right limit.
> 
> > 
> > > We also have exactly the same thing in memory_high_write().
> > > 
> > > So let's stop enforcing old limits if we already have a new ones.
> > 
> > I do see any reasons why this would be harmful I just do not see why
> > this is a real thing or why the new behavior is any better for racing
> > updaters as those are not deterministic anyway. If you have any actual
> > usecase then more details would really help to justify this change.
> > 
> > The existing behavior makes some sense as it enforces the given limit
> > deterministically.
> 
> I don't have any actual problem, usecase or reproduce at hand, I only see a
> potential problem:

If the problem is only potential and also not very severe (it's not a crash
or memory corruption or something like this), I'd say let's keep things as
they are.

Thanks!

