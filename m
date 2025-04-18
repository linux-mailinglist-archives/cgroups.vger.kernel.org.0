Return-Path: <cgroups+bounces-7645-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E8FA93FB6
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 00:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C86557B26CA
	for <lists+cgroups@lfdr.de>; Fri, 18 Apr 2025 22:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA51223311;
	Fri, 18 Apr 2025 22:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AuJTszNT"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3912AD0C
	for <cgroups@vger.kernel.org>; Fri, 18 Apr 2025 22:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745014062; cv=none; b=k/YnFSbPRX3VBQUEk2ixfhdbHQdK0aV6pAc38y3ZLgy5mB2OsJB/mBY6Vl92AeIQzqYFJ7IwdTBsrnkechnSB0NDj/L2qgDTBKtMl+CIrJk+ggrVwCCo2l5guCmjK+cusHFbP5yD9ZGLoch6KAOy8sDXZi6kNRy/Hj6gho4BtuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745014062; c=relaxed/simple;
	bh=NxPvTmirX4aKPKmfSwK10xv3coyVSxPtsPMriZMEjzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ee609Mhn446CTtmSt2D7cEWsLdDDpxGB9rNWXJPoqnKYXTQwJtIWs04V0xon/GBSYPIflXNcSerWjA0ICngIJtt5vBVBZ1d8RC99v2CS9EUnjPqmMES9JgUO6covdIKMmYXzbsZrqDrZ4D1nuRqGoHNkkQxqv67lT8KocryBQz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AuJTszNT; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 18 Apr 2025 22:07:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745014055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EHEzgdreTGKUMgd9RXTTlyD9jFkQ9z28zVdbJUd2dQE=;
	b=AuJTszNT23cDGu2206/Cfxh1goMTdF6tAkCsWWricd5ATNGlEj1+GbmZ5Ftk/bpGgnmqKm
	PUPMX68RFrqwegvdZsaMCWHqo57j12QSUhRb3xec/EyuI5eQD5akYEDLaQjCQWOe4cXvJt
	3t6PrWwSmw+EPFAjhrRZfNgUASuXwCE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Greg Thelen <gthelen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, Tejun Heo <tj@kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: introduce non-blocking limit setting interfaces
Message-ID: <aALNIVa3zxl9HFK5@google.com>
References: <20250418195956.64824-1-shakeel.butt@linux.dev>
 <CAHH2K0as=b+EhxG=8yS9T9oP40U2dEtU0NA=wCJSb6ii9_DGaw@mail.gmail.com>
 <ohrgrdyy36us7q3ytjm3pewsnkh3xwrtz4xdixxxa6hbzsj2ki@sn275kch6zkh>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ohrgrdyy36us7q3ytjm3pewsnkh3xwrtz4xdixxxa6hbzsj2ki@sn275kch6zkh>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 18, 2025 at 01:30:03PM -0700, Shakeel Butt wrote:
> On Fri, Apr 18, 2025 at 01:18:53PM -0700, Greg Thelen wrote:
> > On Fri, Apr 18, 2025 at 1:00 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > >
> > > Setting the max and high limits can trigger synchronous reclaim and/or
> > > oom-kill if the usage is higher than the given limit. This behavior is
> > > fine for newly created cgroups but it can cause issues for the node
> > > controller while setting limits for existing cgroups.
> > >
> > > In our production multi-tenant and overcommitted environment, we are
> > > seeing priority inversion when the node controller dynamically adjusts
> > > the limits of running jobs of different priorities. Based on the system
> > > situation, the node controller may reduce the limits of lower priority
> > > jobs and increase the limits of higher priority jobs. However we are
> > > seeing node controller getting stuck for long period of time while
> > > reclaiming from lower priority jobs while setting their limits and also
> > > spends a lot of its own CPU.
> > >
> > > One of the workaround we are trying is to fork a new process which sets
> > > the limit of the lower priority job along with setting an alarm to get
> > > itself killed if it get stuck in the reclaim for lower priority job.
> > > However we are finding it very unreliable and costly. Either we need a
> > > good enough time buffer for the alarm to be delivered after setting
> > > limit and potentialy spend a lot of CPU in the reclaim or be unreliable
> > > in setting the limit for much shorter but cheaper (less reclaim) alarms.
> > >
> > > Let's introduce new limit setting interfaces which does not trigger
> > > reclaim and/or oom-kill and let the processes in the target cgroup to
> > > trigger reclaim and/or throttling and/or oom-kill in their next charge
> > > request. This will make the node controller on multi-tenant
> > > overcommitted environment much more reliable.
> > 
> > Would opening the typical synchronous files (e.g. memory.max) with
> > O_NONBLOCK be a more general way to tell the kernel that the user
> > space controller doesn't want to wait? It's not quite consistent with
> > traditional use of O_NONBLOCK, which would make operations to
> > fully succeed or fail, rather than altering the operation being requested.
> > But O_NONBLOCK would allow for a semantics of non-blocking
> > reclaim, if that's fast enough for your controller.

+1

> > 
> 
> We actually thought about O_NONBLOCK but the challenge with that is how
> would the node controller knows if the underlying kernel has O_NONBLOCK
> implying no-reclaim/no-oom-kill feature. I don't think opening
> memory.max with O_NONBLOCK will fail today, so the node controller would
> still need to implement the complicated fork+set-limit+alarm logic
> until the whole fleet has moved away from older kernel. Also I have
> checked with systemd folks and they are not happy to implement that
> complicated fork+set-limit+alarm logic.

/sys/kernel/cgroup/features ?

