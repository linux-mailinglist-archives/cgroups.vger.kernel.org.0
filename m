Return-Path: <cgroups+bounces-12001-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F4EC60A5F
	for <lists+cgroups@lfdr.de>; Sat, 15 Nov 2025 20:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D52F93AED51
	for <lists+cgroups@lfdr.de>; Sat, 15 Nov 2025 19:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB533093C4;
	Sat, 15 Nov 2025 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UW4346lT"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8923090F5
	for <cgroups@vger.kernel.org>; Sat, 15 Nov 2025 19:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763234841; cv=none; b=fsG9vQzHu+24cWpiU+YCAF4u3ciAcpKYGG3ymIb88K4E0+2nXCicTHeOa9kec+a9InpxRHDqSZSZEAM3uRraPsrvk1omnjHC1MLlykkAGN9ZxKpX3ut7/MyifXHQsc8WkGyz26QIAL6clcpjYYvjYa6efPQA9kbVaMjQi9+/ao4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763234841; c=relaxed/simple;
	bh=59LAVmPytdb1i8qrZeU2pnNsVPGtk3yjF3eA1gmh8Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPUEcewKM2nGbY/sRInb9KlwvMZhn/plxry/iyFi3bd69W4K/oEJqkIuh3yw5gf9g+3ezTqwPwfHSJxWiYsM2z7chrJa6nhl57Yw/34tuq5flDJzSuy6MvMznuzmyTSSSktOjfGCoQWqJEc5isj64CtXhV5JQ27oE2rhbCFNjkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UW4346lT; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 15 Nov 2025 11:27:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763234827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tL1st+LPzSORFHxjjvUUas/B2xSYAdjy0OmiDtjidDo=;
	b=UW4346lTXgp48lzzmTtizHyxMFKJBsoH9YYSsoWJEV7pbt/sEdsu+NAlTnXmgfqLpf9CTZ
	S3PRTMjrzHV5FkpFeeTWlcSYuYwa0czrbgw8sFmvGnFFQ6e2myg26QzqXK3VHElOV+zs02
	0C2T/2uFylsPFUYbJyVUUJCQx94d5Gk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <qi.zheng@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 0/4] memcg: cleanup the memcg stats interfaces
Message-ID: <wwuzmneum26ddbf43kquy6u5rynbtwsphkp7xlp4ktnznxmn54@dmxb54xxhgah>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110232008.1352063-1-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

Hi Andrew, can you please pick this series as it is ready for wider
testing.

thanks,
Shakeel

On Mon, Nov 10, 2025 at 03:20:04PM -0800, Shakeel Butt wrote:
> The memcg stats are safe against irq (and nmi) context and thus does not
> require disabling irqs. However for some stats which are also maintained
> at node level, it is using irq unsafe interface and thus requiring the
> users to still disables irqs or use interfaces which explicitly disables
> irqs. Let's move memcg code to use irq safe node level stats function
> which is already optimized for architectures with HAVE_CMPXCHG_LOCAL
> (all major ones), so there will not be any performance penalty for its
> usage.
> 
> Shakeel Butt (4):
>   memcg: use mod_node_page_state to update stats
>   memcg: remove __mod_lruvec_kmem_state
>   memcg: remove __mod_lruvec_state
>   memcg: remove __lruvec_stat_mod_folio
> 
>  include/linux/memcontrol.h | 28 ++++------------------
>  include/linux/mm_inline.h  |  2 +-
>  include/linux/vmstat.h     | 48 ++------------------------------------
>  mm/filemap.c               | 20 ++++++++--------
>  mm/huge_memory.c           |  4 ++--
>  mm/khugepaged.c            |  8 +++----
>  mm/memcontrol.c            | 20 ++++++++--------
>  mm/migrate.c               | 20 ++++++++--------
>  mm/page-writeback.c        |  2 +-
>  mm/rmap.c                  |  4 ++--
>  mm/shmem.c                 |  6 ++---
>  mm/vmscan.c                |  4 ++--
>  mm/workingset.c            |  2 +-
>  13 files changed, 53 insertions(+), 115 deletions(-)
> 
> -- 
> 2.47.3
> 

