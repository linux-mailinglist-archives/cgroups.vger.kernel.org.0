Return-Path: <cgroups+bounces-6394-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D87DA23269
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2025 18:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04BB1886815
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2025 17:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AC81EBFF5;
	Thu, 30 Jan 2025 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KY8LfgwG"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532DE2770C;
	Thu, 30 Jan 2025 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738256738; cv=none; b=g5WxlDicsrAVt8WCronGyayTjLTbBISQFvZfBAJ5y7Apz0ieYYKM6yS1mhGkG1QOfjKP6VHB1fQuMWLIe2YZv4wnBzQip5kwEJcfLzEYzZPYMnvt7qa1rsGEz+GoCnH2EJwQMQy1U9MA9i7MBu4Qy2ithecauVlfB9wwZHjNE10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738256738; c=relaxed/simple;
	bh=thIebkEPPygCuNesBzz3Xc0iFlCdhHjffCSZT4jHToY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMCLjEjtn8KAlXrdmb7knyiqwBEIJ97MfWtHdXvKgDwTQQoJ3FZwWAb0b7rx5fSb1jR4oP3eim0L0IjbruYxIN7V4wJKvmrVGn9Jkq/VR1bhspr8FXIUtl/uQIoEXL/rQGtl1BsEA9OEA3UvC2k/Tl90ReHesiS1iZzJ4lCqdHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KY8LfgwG; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 30 Jan 2025 17:05:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738256734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NnZwLBy82NCMVLhxeD5jG2Y+xA/NL2R/qYb3QRlxudk=;
	b=KY8LfgwGgRos8hY5KQjjcDTCNQ8DIBMn2BrfgTxm/ZIka2DguWWNT247PDYBfpCVJRYMvG
	Gmm6agodQx4XS55CzEP6E0i1uc7/E5fbr9SVjgSGD9+u6pbo40j2Nljj74kxxPKILVwSJU
	zbq94y6lt6n2rbcmWOGXC3dJ7xk7al8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Waiman Long <llong@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	Peter Hunt <pehunt@redhat.com>
Subject: Re: [RFC PATCH] mm, memcg: introduce memory.high.throttle
Message-ID: <Z5uxVzFf7Pk7yk9f@google.com>
References: <20250129191204.368199-1-longman@redhat.com>
 <Z5s1DG2YVH78RWpR@tiehlicka>
 <211b394b-3b9a-4872-8c07-b185386487d3@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <211b394b-3b9a-4872-8c07-b185386487d3@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 30, 2025 at 10:05:34AM -0500, Waiman Long wrote:
> On 1/30/25 3:15 AM, Michal Hocko wrote:
> > On Wed 29-01-25 14:12:04, Waiman Long wrote:
> > > Since commit 0e4b01df8659 ("mm, memcg: throttle allocators when failing
> > > reclaim over memory.high"), the amount of allocator throttling had
> > > increased substantially. As a result, it could be difficult for a
> > > misbehaving application that consumes increasing amount of memory from
> > > being OOM-killed if memory.high is set. Instead, the application may
> > > just be crawling along holding close to the allowed memory.high memory
> > > for the current memory cgroup for a very long time especially those
> > > that do a lot of memcg charging and uncharging operations.
> > > 
> > > This behavior makes the upstream Kubernetes community hesitate to
> > > use memory.high. Instead, they use only memory.max for memory control
> > > similar to what is being done for cgroup v1 [1].
> > Why is this a problem for them?
> My understanding is that a mishaving container will hold up memory.high
> amount of memory for a long time instead of getting OOM killed sooner and be
> more productively used elsewhere.
> > 
> > > To allow better control of the amount of throttling and hence the
> > > speed that a misbehving task can be OOM killed, a new single-value
> > > memory.high.throttle control file is now added. The allowable range
> > > is 0-32.  By default, it has a value of 0 which means maximum throttling
> > > like before. Any non-zero positive value represents the corresponding
> > > power of 2 reduction of throttling and makes OOM kills easier to happen.
> > I do not like the interface to be honest. It exposes an implementation
> > detail and casts it into a user API. If we ever need to change the way
> > how the throttling is implemented this will stand in the way because
> > there will be applications depending on a behavior they were carefuly
> > tuned to.
> > 
> > It is also not entirely sure how is this supposed to be used in
> > practice? How do people what kind of value they should use?
> Yes, I agree that a user may need to run some trial runs to find a proper
> value. Perhaps a simpler binary interface of "off" and "on" may be easier to
> understand and use.
> > 
> > > System administrators can now use this parameter to determine how easy
> > > they want OOM kills to happen for applications that tend to consume
> > > a lot of memory without the need to run a special userspace memory
> > > management tool to monitor memory consumption when memory.high is set.
> > Why cannot they achieve the same with the existing events/metrics we
> > already do provide? Most notably PSI which is properly accounted when
> > a task is throttled due to memory.high throttling.
> 
> That will require the use of a userspace management agent that looks for
> these stalling conditions and make the kill, if necessary. There are
> certainly users out there that want to get some benefit of using memory.high
> like early memory reclaim without the trouble of handling these kind of
> stalling conditions.

So you basically want to force the workload into some sort of a proactive
reclaim but without an artificial slow down?
It makes some sense to me, but
1) Idk if it deserves a new API, because it can be relatively easy implemented
  in userspace by a daemon which monitors cgroups usage and reclaims the memory
  if necessarily. No kernel changes are needed.
2) If new API is introduced, I think it's better to introduce a new limit,
  e.g. memory.target, keeping memory.high semantics intact.

Thanks!

