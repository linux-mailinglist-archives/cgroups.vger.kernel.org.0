Return-Path: <cgroups+bounces-7644-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A175A93EEF
	for <lists+cgroups@lfdr.de>; Fri, 18 Apr 2025 22:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920B016BC5B
	for <lists+cgroups@lfdr.de>; Fri, 18 Apr 2025 20:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C2B1FBE87;
	Fri, 18 Apr 2025 20:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qBoDblmB"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F93723BCE4
	for <cgroups@vger.kernel.org>; Fri, 18 Apr 2025 20:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745008217; cv=none; b=QrM/KKCY45l0ntVDWIQDmGLmzRpmB36FlWu0rabD+sKEYLhTHSQMxAhOdMZte8YNFFrvV6fL/9LFzTkSab7T0jZc1WlnZ/pEhLtdSxBS0agoZRimdL6dYtFmwgBvFDeNktvHB/xAIgbKbHNgLMJc0/FFH7bu57ltounlkeJcbRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745008217; c=relaxed/simple;
	bh=6LcBo5+5vCAnKIqjyy97bLQmguQNwbTY+/Jdvwq1pDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsqsuTkYCjKFvOapiQpgeRm9dzkG+3ayC2eTtmcqvWinuLe79qMzVHvymSzK49U83nCRq1ii1tzr2hEAQSRk6/bqXw2fYcujVNe82uXUUJxXODn3OHkplx2kTBgZDjA+lbw1FzxGTIM8YoCK88xzLYzhdbuMgITwHOngjer0uBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qBoDblmB; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 18 Apr 2025 13:30:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745008211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4WmhYDIZ6fnmE1nZMjBHdeec4YLIkfuJIi+dcBY3/dw=;
	b=qBoDblmBrSQUhfhMjZb2eP/1R3TbszseqFKH92NRDM7XvtY8ANXVQQ5o/0g5M6Km/UnncF
	Ed3pIN4u71xCC78Md/Hrb4wueiiGUzAn7zdNMzpt/Lo068/JU3Rrh28EpSAQtNAgPFRpje
	1Eo0E1VqXSI5S1Qkis/grttdz9I6A9I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Greg Thelen <gthelen@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: introduce non-blocking limit setting interfaces
Message-ID: <ohrgrdyy36us7q3ytjm3pewsnkh3xwrtz4xdixxxa6hbzsj2ki@sn275kch6zkh>
References: <20250418195956.64824-1-shakeel.butt@linux.dev>
 <CAHH2K0as=b+EhxG=8yS9T9oP40U2dEtU0NA=wCJSb6ii9_DGaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHH2K0as=b+EhxG=8yS9T9oP40U2dEtU0NA=wCJSb6ii9_DGaw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 18, 2025 at 01:18:53PM -0700, Greg Thelen wrote:
> On Fri, Apr 18, 2025 at 1:00 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > Setting the max and high limits can trigger synchronous reclaim and/or
> > oom-kill if the usage is higher than the given limit. This behavior is
> > fine for newly created cgroups but it can cause issues for the node
> > controller while setting limits for existing cgroups.
> >
> > In our production multi-tenant and overcommitted environment, we are
> > seeing priority inversion when the node controller dynamically adjusts
> > the limits of running jobs of different priorities. Based on the system
> > situation, the node controller may reduce the limits of lower priority
> > jobs and increase the limits of higher priority jobs. However we are
> > seeing node controller getting stuck for long period of time while
> > reclaiming from lower priority jobs while setting their limits and also
> > spends a lot of its own CPU.
> >
> > One of the workaround we are trying is to fork a new process which sets
> > the limit of the lower priority job along with setting an alarm to get
> > itself killed if it get stuck in the reclaim for lower priority job.
> > However we are finding it very unreliable and costly. Either we need a
> > good enough time buffer for the alarm to be delivered after setting
> > limit and potentialy spend a lot of CPU in the reclaim or be unreliable
> > in setting the limit for much shorter but cheaper (less reclaim) alarms.
> >
> > Let's introduce new limit setting interfaces which does not trigger
> > reclaim and/or oom-kill and let the processes in the target cgroup to
> > trigger reclaim and/or throttling and/or oom-kill in their next charge
> > request. This will make the node controller on multi-tenant
> > overcommitted environment much more reliable.
> 
> Would opening the typical synchronous files (e.g. memory.max) with
> O_NONBLOCK be a more general way to tell the kernel that the user
> space controller doesn't want to wait? It's not quite consistent with
> traditional use of O_NONBLOCK, which would make operations to
> fully succeed or fail, rather than altering the operation being requested.
> But O_NONBLOCK would allow for a semantics of non-blocking
> reclaim, if that's fast enough for your controller.
> 

We actually thought about O_NONBLOCK but the challenge with that is how
would the node controller knows if the underlying kernel has O_NONBLOCK
implying no-reclaim/no-oom-kill feature. I don't think opening
memory.max with O_NONBLOCK will fail today, so the node controller would
still need to implement the complicated fork+set-limit+alarm logic
until the whole fleet has moved away from older kernel. Also I have
checked with systemd folks and they are not happy to implement that
complicated fork+set-limit+alarm logic.

