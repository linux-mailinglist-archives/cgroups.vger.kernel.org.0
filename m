Return-Path: <cgroups+bounces-4990-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CFD98AB0B
	for <lists+cgroups@lfdr.de>; Mon, 30 Sep 2024 19:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34842864E3
	for <lists+cgroups@lfdr.de>; Mon, 30 Sep 2024 17:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC05194C6A;
	Mon, 30 Sep 2024 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q2Go8nM9"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6640B286A1
	for <cgroups@vger.kernel.org>; Mon, 30 Sep 2024 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727717005; cv=none; b=gfAzwXppsun+Z5YWt7QKOso/jyzCfpd/cTLMZ93UsictYL/viingI+zlIx3q+r1PrXHQTlcJaS/LtSD2zc7+qZCdcPO03Bnq2oAQ+XgVCgzZy9eKnECcOn+ddaXFCiuPHBOQIVWHBXv4T7wa6KcguazZwdzFNGWI1fVHvG6Wm4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727717005; c=relaxed/simple;
	bh=OIxfCBEGAvWEkdSEtEwxbO9TFJmwSb35nLFageeYab0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HN4N/2pD440vE05MI3fZpHX7zamUxC1I1Sr6XiMYtTtgkzJb4EaOzxPgCXc8D6G8qKeEA5tPsxQ+0J+8lTaUl2TAM6LvtNtd9wPF+ij39HggtnTMKK2ylz2bnBqe1zbyR5oFsZWWoqCPeEMjaieEYnbRVz0+cgAaQBaVGPOsbXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q2Go8nM9; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 30 Sep 2024 10:23:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727717001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dzSxpLu+y25AB6WLpgOaZVb8gZEJ5dE5xNKaC6UmINQ=;
	b=q2Go8nM9wbpL5b7RA1YB0iCsFwTZ6CAce/9vNZNG6Mk4ZjD6S0aLPFsVivVvC8y305Pbbe
	wvIutYhV5fkHgYPMQ9wZVqb/oqnO4ugBFrAkOSB2qHnOmMM4EaC+9p2AfG/2L+jkhxGzp0
	TUuHTiDXya7wNMce9rhp1+sYhAhUZxw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>, 
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: Re: [PATCH] btrfs: root memcgroup for metadata filemap_add_folio()
Message-ID: <iwjlzsphxhqdpml5gn3t3qt5zhizgcmizel5vug7g7bwlkzeob@g2jlar2nynqb>
References: <b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com>
X-Migadu-Flow: FLOW_OUT

Hi Qu,

On Sat, Sep 28, 2024 at 02:15:56PM GMT, Qu Wenruo wrote:
> [BACKGROUND]
> The function filemap_add_folio() charges the memory cgroup,
> as we assume all page caches are accessible by user space progresses
> thus needs the cgroup accounting.
> 
> However btrfs is a special case, it has a very large metadata thanks to
> its support of data csum (by default it's 4 bytes per 4K data, and can
> be as large as 32 bytes per 4K data).
> This means btrfs has to go page cache for its metadata pages, to take
> advantage of both cache and reclaim ability of filemap.
> 
> This has a tiny problem, that all btrfs metadata pages have to go through
> the memcgroup charge, even all those metadata pages are not
> accessible by the user space, and doing the charging can introduce some
> latency if there is a memory limits set.
> 
> Btrfs currently uses __GFP_NOFAIL flag as a workaround for this cgroup
> charge situation so that metadata pages won't really be limited by
> memcgroup.
> 
> [ENHANCEMENT]
> Instead of relying on __GFP_NOFAIL to avoid charge failure, use root
> memory cgroup to attach metadata pages.
> 
> Although this needs to export the symbol mem_root_cgroup for
> CONFIG_MEMCG, or define mem_root_cgroup as NULL for !CONFIG_MEMCG.
> 
> With root memory cgroup, we directly skip the charging part, and only
> rely on __GFP_NOFAIL for the real memory allocation part.
> 

I have a couple of questions:

1. Were you using __GFP_NOFAIL just to avoid ENOMEMs? Are you ok with
oom-kills?

2. What the normal overhead of these metadata in real world production
environment? I see 4 to 32 bytes per 4k but what's the most used one and
does it depend on the data of 4k or something else?

3. Most probably multiple metadata values are colocated on a single 4k
page of the btrfs page cache even though the corresponding page cache
might be charged to different cgroups. Is that correct?

4. What is stopping us to use reclaimable slab cache for this metadata?

thanks,
Shakeel

