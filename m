Return-Path: <cgroups+bounces-8187-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F669AB71C4
	for <lists+cgroups@lfdr.de>; Wed, 14 May 2025 18:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6680A173846
	for <lists+cgroups@lfdr.de>; Wed, 14 May 2025 16:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F39C27A470;
	Wed, 14 May 2025 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VMWuD3Zf"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E394227FB2B
	for <cgroups@vger.kernel.org>; Wed, 14 May 2025 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747240770; cv=none; b=nhijoIBhWvVMG7cAGPDrb60I3ZaGGtEifj1kt1ygAZ0L9AJvKsjDYGHlCkPt773uiMH4lwBGUR7H6UptCMfvGq38fMsDWwoKD9ofqCcClIUkiSV5EiYP1QTm9N1Qg9Le24AOr7QoFzaF+NHHuwi2+qct34OsRKzm5+G1g+RSYkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747240770; c=relaxed/simple;
	bh=PFRZPFn4Tg43o1WBB6rYz5Q1cQoHHUPD8kep2QLS68k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEblblibXOhmXuM92baVpSZkfeKBY3WO61CZqGqhfgvQw98cQ2cf2NhGZUvjJTBbCXcUwiK5hTOtw4FCgXeRlXrBp4McmgBMnXSnvF/XONo+IbeQ69qyEUks98Iu1ASFOD+Sbfs4C1z4m4ZcizGzj9qZc4fU5gHv/3I6aozJSjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VMWuD3Zf; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 14 May 2025 09:39:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747240765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/xWysm/w4j0tfuTGmtdmeiPQvB/oeNRyr4xijzKsPPM=;
	b=VMWuD3ZfACb2Ls14tQJ6HXUOUKgV3OvLhyn/U/jHgtuxbvNJ/MMb5d1jb3KA9MSVrSj/24
	nVk2Bq5GmgzyQ23cNPg4ARmKuhrKo/divVMJijkDn7h/2EXKn+f6L5iKLYGJc3fSyOAkdy
	WCBR4ejOmuv6XRaKQ+1n5wR8zOctWJY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 1/7] memcg: memcg_rstat_updated re-entrant safe against
 irqs
Message-ID: <bnofgbnkkcgvybob7dt2bzti3bfsxwcaur5iobttyzxtfb7iue@oo6sj5pfjgud>
References: <20250514050813.2526843-1-shakeel.butt@linux.dev>
 <20250514050813.2526843-2-shakeel.butt@linux.dev>
 <cb50a1c8-1f94-4a49-b5b3-8d2008c9f272@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb50a1c8-1f94-4a49-b5b3-8d2008c9f272@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Wed, May 14, 2025 at 11:50:16AM +0200, Vlastimil Babka wrote:
> On 5/14/25 07:08, Shakeel Butt wrote:
> > The function memcg_rstat_updated() is used to track the memcg stats
> > updates for optimizing the flushes. At the moment, it is not re-entrant
> > safe and the callers disabled irqs before calling. However to achieve
> > the goal of updating memcg stats without irqs, memcg_rstat_updated()
> > needs to be re-entrant safe against irqs.
> > 
> > This patch makes memcg_rstat_updated() re-entrant safe using this_cpu_*
> > ops. On archs with CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS, this patch is
> > also making memcg_rstat_updated() nmi safe.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Some nits:
> 

Thanks Vlastimil. I will address your comments in v2 and Andrew asked me
to rebase over mm-new instead of next which I will do as well.

