Return-Path: <cgroups+bounces-8544-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C3EADB97A
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 21:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C89E23B48CF
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 19:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7B428A1E4;
	Mon, 16 Jun 2025 19:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pw6lUFpi"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9575628A1CF
	for <cgroups@vger.kernel.org>; Mon, 16 Jun 2025 19:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750101642; cv=none; b=soxJr9JrZJLWhxffuJhfH20KTUOoTv4UQwwD0X8qG5Uj7Gw8dDpoJvAK432qxDAUf06b51Ckysms6gcnl4aB/oZSjYop+YyCUwdXKfBWDeUg/f1RVaVB8w5pHpJg23vaSd1KooVGrtt6Kw+M58ptjWPwp5unNLnINtxKD8/4Vzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750101642; c=relaxed/simple;
	bh=HumAqwnOsGSWMa46buCT1W25Zg7tuj/RQxmzzbSfJWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBwWCKFVzlErTyx6G7RbIw2WrCTJneAdIxSIsOxtlsOs+K0IXNHKi9QbwBP+l5O4dChTDEmdkvsNBjktl5ScbFYR3EgGa/XSdRQbVV10mc6Si2xUWgRY4LXwleiKh6ijmnE4OnhhhFii2H2Ti89cGIJALm96lEIeOTk0mc5WYu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pw6lUFpi; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 16 Jun 2025 12:20:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750101637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KCx8G8iB4GFG7YkzRAgMeNEZrvPEgTU8KFH3idAR55g=;
	b=pw6lUFpivOAs6oOemvC5IEw3UOHeLHr5jtTonYoczi8z44yrYDdW+ohDx3uEyy8CzH1j9E
	XKAil2+qZoqJzqkJx80vOoEcpxA62QGV8Me2Vy+G6Bb98Dpmj5xjuo9rIpd/+uiIMShywt
	Wk7SwFw9gmHVHqzSDuAgjqgyApK6Tr0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	JP Kobryn <inwardvessel@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Harry Yoo <harry.yoo@oracle.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v2 0/4] cgroup: nmi safe css_rstat_updated
Message-ID: <qtudjvrdvbsz6rrygb5bt32dzps6ocwefhr5hyfgtam65jowdo@colgnna6ogqm>
References: <20250611221532.2513772-1-shakeel.butt@linux.dev>
 <aFBfNRVAyE1FU9aQ@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFBfNRVAyE1FU9aQ@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 16, 2025 at 08:15:17AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Jun 11, 2025 at 03:15:28PM -0700, Shakeel Butt wrote:
> > Shakeel Butt (4):
> >   cgroup: support to enable nmi-safe css_rstat_updated
> >   cgroup: make css_rstat_updated nmi safe
> >   cgroup: remove per-cpu per-subsystem locks
> >   memcg: cgroup: call css_rstat_updated irrespective of in_nmi()
> 
> The patches look good to me. How should it be routed? Should I take all
> four, just the first three or would it better to route all through -mm?
> 

I would like all four to be together and since most of the code is in
cgroup, cgroup tree makes more sense unless Andrew has different
opinion.

thanks,
Shakeel

