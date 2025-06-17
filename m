Return-Path: <cgroups+bounces-8567-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 176D5ADDC00
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 21:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B5F4A1812
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 19:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF97A28C00E;
	Tue, 17 Jun 2025 19:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckxOpqbe"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6295F277C86;
	Tue, 17 Jun 2025 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750187163; cv=none; b=dO6VkekVaLF6EznMn7DdZZgPtAmOcsPjPPxOaxn+tUTd21y5IBYDRCSJZN30IBmxCS0rDqil51ZMNLCq2iSjHnMpm6cdkWcuUlLiK6gimRdXDB7xox8CkVy5YtCgQE7MV8hERAzu6OuacWjDnRlv+sw+ZDqiRzfAMU91ejm/Zis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750187163; c=relaxed/simple;
	bh=1P8H001I4NcApk8NZd9sZWJ/AuyDiCxxMbY8Tze/VL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p01tcCnEBlccoG4R2oZgNXupjFvaZYxF+wxSxlZ+kQPAQJsDtscRUmdfWiUB6e9AyldtYmq/WgG11mOIy0wm8D0EfaoYnJVnC2lf0ITa1ryw9vUzwRStkQ1NqLOD3oRAnOWVhFpz1V4fSEZ2q20VhZEwQVpDS8hpuIZUXIQmA7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckxOpqbe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1664C4CEE3;
	Tue, 17 Jun 2025 19:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750187162;
	bh=1P8H001I4NcApk8NZd9sZWJ/AuyDiCxxMbY8Tze/VL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ckxOpqbeewl7B1vnPJ7SqgcFWh5XVMm7aTnbvc2jnHHxXeXU+qncsrzpYoUrB28BD
	 7z6MSCdNwvSDHAOy8yhQsulnn5L22NI9uAPga9hGo5qMref1e1um8xxUgKar/rYQpP
	 SF3R1g/e+nyA8Hwfgz01oCnKykN2lhB5eM0tSMtYjM8iLum4llMLVskIT2QGXllxqU
	 ovMKdsQdpQ8DJ7bzMP+kzdiV5PrikoPZ7MCD2skR4U4M1abPdn2dw0VHJNNk6B4MDl
	 KlgHNA+bRis5OTmbdLXpydx7cZWJjC+uwJ4/5YCo3mikFS1jn5UwxpRbt8iZhibAf/
	 I/O+rE8ih6u9g==
Date: Tue, 17 Jun 2025 09:06:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, bpf@vger.kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v2 0/4] cgroup: nmi safe css_rstat_updated
Message-ID: <aFG8mZOOwl9s5ySm@slm.duckdns.org>
References: <20250611221532.2513772-1-shakeel.butt@linux.dev>
 <aFBfNRVAyE1FU9aQ@slm.duckdns.org>
 <qtudjvrdvbsz6rrygb5bt32dzps6ocwefhr5hyfgtam65jowdo@colgnna6ogqm>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qtudjvrdvbsz6rrygb5bt32dzps6ocwefhr5hyfgtam65jowdo@colgnna6ogqm>

On Mon, Jun 16, 2025 at 12:20:28PM -0700, Shakeel Butt wrote:
> On Mon, Jun 16, 2025 at 08:15:17AM -1000, Tejun Heo wrote:
> > Hello,
> > 
> > On Wed, Jun 11, 2025 at 03:15:28PM -0700, Shakeel Butt wrote:
> > > Shakeel Butt (4):
> > >   cgroup: support to enable nmi-safe css_rstat_updated
> > >   cgroup: make css_rstat_updated nmi safe
> > >   cgroup: remove per-cpu per-subsystem locks
> > >   memcg: cgroup: call css_rstat_updated irrespective of in_nmi()
> > 
> > The patches look good to me. How should it be routed? Should I take all
> > four, just the first three or would it better to route all through -mm?
> > 
> 
> I would like all four to be together and since most of the code is in
> cgroup, cgroup tree makes more sense unless Andrew has different
> opinion.

Okay, I'll route them through cgroup. The patches don't apply cleanly on
cgroup/for-6.17. Can you please send a refreshed set?

Thanks.

-- 
tejun

