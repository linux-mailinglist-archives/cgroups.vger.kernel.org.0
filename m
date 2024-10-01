Return-Path: <cgroups+bounces-4996-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B0F98B1D4
	for <lists+cgroups@lfdr.de>; Tue,  1 Oct 2024 03:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF0861C212E6
	for <lists+cgroups@lfdr.de>; Tue,  1 Oct 2024 01:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B3210A12;
	Tue,  1 Oct 2024 01:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X5W4cZk2"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE58E33E7;
	Tue,  1 Oct 2024 01:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727746687; cv=none; b=gim7yMIOvGoR3aDVApySyCHEzHsHeWSt0AhPM8OozBnAurj58yMB6FRwDYg0cYRzbxcAQQXZMLmPKJvPREUXMT98c7G7v55WLAy+O0i7kXa9odd3YWrs5Y+3qrmlOqXW1cBAXWuUfelluSQ7qGt2VekYaCVPBp1+zgPKB0zSx98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727746687; c=relaxed/simple;
	bh=DBNAfXbqRnIOzZmJdC04pOKJmaZlJJYYlZkedEUnRZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Je8zoEzz5QJvzfKXskNtfEhg3c0NPyxl82DP/gMAanUakvTdLGlLxDwJWFdRA3CKHJ8JsrpZEMYLauF+nFQcNPNRPE6Y8qgzWMWBeFE399FrpCZ7AzxQ/Rc/Wjl6j3DiMmrUKgEaxW68M0D+KeQvs5uUjYKFS1vbz8rU3HrnNm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X5W4cZk2; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 30 Sep 2024 18:37:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727746679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RCnEfM1gKv8i5eSoLQHHCofUZ3jCStvIXN3C4XvHCy8=;
	b=X5W4cZk2bPY++TqQf3VFzmbhJUNsQRAA83yt3EMfG6aaaO+chTK71/tPHk1/MJH+c37542
	JyNzqRZ8HAxVer9w0vOgxQMFFIDzpQGPtu28HkLZn5N/ui5B1X58YeV+YEY3snQd9n6r9i
	MzyRXUbBtBgu68/s2CLwjZ1YSj+ECOM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>, 
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: Re: [PATCH] btrfs: root memcgroup for metadata filemap_add_folio()
Message-ID: <7jmtrebounxuu44qgmc2y52bqlqdyuko7zp53p6iz6rkzmzzqg@m2csfnfbmv6c>
References: <b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com>
 <iwjlzsphxhqdpml5gn3t3qt5zhizgcmizel5vug7g7bwlkzeob@g2jlar2nynqb>
 <08ccb40d-6261-4757-957d-537d295d2cf5@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08ccb40d-6261-4757-957d-537d295d2cf5@suse.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 01, 2024 at 07:30:38AM GMT, Qu Wenruo wrote:
> 
> 
> 在 2024/10/1 02:53, Shakeel Butt 写道:
> > Hi Qu,
> > 
> > On Sat, Sep 28, 2024 at 02:15:56PM GMT, Qu Wenruo wrote:
> > > [BACKGROUND]
> > > The function filemap_add_folio() charges the memory cgroup,
> > > as we assume all page caches are accessible by user space progresses
> > > thus needs the cgroup accounting.
> > > 
> > > However btrfs is a special case, it has a very large metadata thanks to
> > > its support of data csum (by default it's 4 bytes per 4K data, and can
> > > be as large as 32 bytes per 4K data).
> > > This means btrfs has to go page cache for its metadata pages, to take
> > > advantage of both cache and reclaim ability of filemap.
> > > 
> > > This has a tiny problem, that all btrfs metadata pages have to go through
> > > the memcgroup charge, even all those metadata pages are not
> > > accessible by the user space, and doing the charging can introduce some
> > > latency if there is a memory limits set.
> > > 
> > > Btrfs currently uses __GFP_NOFAIL flag as a workaround for this cgroup
> > > charge situation so that metadata pages won't really be limited by
> > > memcgroup.
> > > 
> > > [ENHANCEMENT]
> > > Instead of relying on __GFP_NOFAIL to avoid charge failure, use root
> > > memory cgroup to attach metadata pages.
> > > 
> > > Although this needs to export the symbol mem_root_cgroup for
> > > CONFIG_MEMCG, or define mem_root_cgroup as NULL for !CONFIG_MEMCG.
> > > 
> > > With root memory cgroup, we directly skip the charging part, and only
> > > rely on __GFP_NOFAIL for the real memory allocation part.
> > > 
> > 
> > I have a couple of questions:
> > 
> > 1. Were you using __GFP_NOFAIL just to avoid ENOMEMs? Are you ok with
> > oom-kills?
> 
> The NOFAIL flag is inherited from the memory allocation for metadata tree
> blocks.
> 
> Although btrfs has error handling already for all the possible ENOMEMs,
> hitting ENOMEMs for metadata may still be a big problem, thus all my
> previous attempt to remove NOFAIL flag all got rejected.

__GFP_NOFAIL for memcg charging is reasonable in many scenarios. Memcg
oom-killer is enabled for __GFP_NOFAIL and going over limit and getting
oom-killed is totally reasonable. Orthogonal to the discussion though.

> 
> > 
> > 2. What the normal overhead of these metadata in real world production
> > environment? I see 4 to 32 bytes per 4k but what's the most used one and
> > does it depend on the data of 4k or something else?
> 
> What did you mean by the "overhead" part? Did you mean the checksum?
> 

To me this metadata is overhead, so yes checksum is something not the
actual data stored on the storage.

> If so, there is none, because btrfs store metadata checksum inside the tree
> block (thus the page cache).
> The first 32 bytes of a tree block are always reserved for metadata
> checksum.
> 
> The tree block size depends on the mkfs time option nodesize, is 16K by
> default, and that's the most common value.

Sorry I am not very familiar with btrfs. What is tree block?

> 
> > 
> > 3. Most probably multiple metadata values are colocated on a single 4k
> > page of the btrfs page cache even though the corresponding page cache
> > might be charged to different cgroups. Is that correct?
> 
> Not always a single 4K page, it depends on the nodesize, which is 16K by
> default.
> 
> Otherwise yes, the metadata page cache can be charged to different cgroup,
> depending on the caller's context.
> And we do not want to charge the metadata page cache to the caller's cgroup,
> since it's really a shared resource and the caller has no way to directly
> accessing the page cache.
> 
> Not charging the metadata page cache will align btrfs more to the ext4/xfs,
> which all uses regular page allocation without attaching to a filemap.
> 

Can you point me to ext4/xfs code where they are allocating uncharged
memory for their metadata?

> > 
> > 4. What is stopping us to use reclaimable slab cache for this metadata?
> 
> Josef has tried this before, the attempt failed on the shrinker part, and
> partly due to the size.
> 
> Btrfs has very large metadata compared to all other fses, not only due to
> the COW nature and a larger tree block size (16K by default), but also the
> extra data checksum (4 bytes per 4K by default, 32 bytes per 4K maximum).
> 
> On a real world system, the metadata itself can easily go hundreds of GiBs,
> thus a shrinker is definitely needed.

This amount of uncharged memory is concerning which becomes part of
system overhead and may impact the schedulable memory for the datacenter
environment.

Overall the code seems fine and no pushback from me if btrfs maintainers
are ok with this. I think btrfs should move to slab+shrinker based
solution for this metadata unless there is deep technical reason not to.

thanks,
Shakeel

