Return-Path: <cgroups+bounces-8481-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC982AD46AA
	for <lists+cgroups@lfdr.de>; Wed, 11 Jun 2025 01:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644E717815F
	for <lists+cgroups@lfdr.de>; Tue, 10 Jun 2025 23:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A66284B39;
	Tue, 10 Jun 2025 23:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RfMwful8"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B346260593
	for <cgroups@vger.kernel.org>; Tue, 10 Jun 2025 23:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749598123; cv=none; b=ezY4s2a4MQC3aSwJjjEMVNW3X9ya03r6WQDDKWWfEend2Sv8y9OJaYSFgWE9Q1SOXArMnWTTp9OeUSlio8Lzn+LYFOxsu5D5WdFH2chlOuJieRcGAZZBWmKXf8k9JDqUHYCYUgwd3QKo2qV3vtBO7t71ddkhB2o015eMcBwhf/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749598123; c=relaxed/simple;
	bh=bq/1yugEyImqQF2OmGun7RE4JLg4QnkOliWZgSX1DhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6nEJcxTPz/S1renDw2OZqFXNE0dIv9tDzueZsWNyv/6V7CoEQeC4cFd9JgGsVIZfLRw/wn5y6BrmZIlieInbxmFx/V/5FZ0Aa79EIfwBj8gfNE/zxgcVeboBxaTqVAwYLVUNXhQuxbhvMaC4q9T6K/Mtd4zBnCs3eNMPXRKwqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RfMwful8; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 10 Jun 2025 16:28:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749598109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EqVyj4QmrQUHnNz4aolJa1B8A00baXtmiLbQJA7wgSY=;
	b=RfMwful8cDyssomCxR8rs9ARmx4/O++2QaXVOwIeiQHtYXhwJ332yE+ueeGB0JfFjar4ts
	NEIHwXfrGliMnasA2I1p59YCoi5mh/wF+BXG95/FNGlSsMGY5YxjLWqFCzqWwj5CwLO0lq
	cLL7ZhnqmgyAgoTK38UDesZD7cbkmu0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Alexei Starovoitov <ast@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 2/3] cgroup: make css_rstat_updated nmi safe
Message-ID: <lmjsy6fp25bhno62mg3hz7z2ysggg4z66yhhpd6mxpzksthsbz@55hjcvz2jymh>
References: <20250609225611.3967338-1-shakeel.butt@linux.dev>
 <20250609225611.3967338-3-shakeel.butt@linux.dev>
 <aEijC1iHehAxdsfi@slm.duckdns.org>
 <35ppn2muk4bsyosca4nxnbv5l6qv4ov2cxg5ksypst5ldf5zc4@vwrpziws4wjy>
 <aEi0FplA6eZUHF01@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEi0FplA6eZUHF01@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 10, 2025 at 12:39:18PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, Jun 10, 2025 at 03:31:03PM -0700, Shakeel Butt wrote:
> ...
> > Couple of lines above I have llist_on_list(&rstatc->lnode) check which
> > should be as cheap as data_race(css_rstat_cpu(css, cpu)->updated_next). 
> 
> Ah, I missed that.
> 
> > So, I can add lnode for nmi and non-nmi contexts (with irqs disabled)
> > but I think that is not needed. Actually I ran the netperf benchmark (36
> > parallel instances) and I see no significant differences with and
> > without the patch.
> 
> Yeah, as long as the hot path doesn't hit the extra cmpxchg, I think it
> should be fine. Can you fortify the comments a bit that the synchronization
> is against the stacking contexts on the same CPU. The use of cmpxchg for
> something like this is a bit unusual and it'd be nice to have explanation on
> why it's done this way and why the overhead doesn't matter.

I was actually thinking of using this_cpu_cmpxchg but then I need to
also check for CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS. However if you
prefer that, I can try this_cpu_cmpxchg in the next version.

I will also fix the comment with additional information about stacking
context.

