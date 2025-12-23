Return-Path: <cgroups+bounces-12619-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F5CCDAD44
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 00:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6962A300DB89
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 23:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EE92D9ED1;
	Tue, 23 Dec 2025 23:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CMjc0KoH"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3111F289378
	for <cgroups@vger.kernel.org>; Tue, 23 Dec 2025 23:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766532071; cv=none; b=EJuo2duCw5yx3gtm9HutGLZbpf0rNwqLgjfsAMHPeLiodIReavMeiOKkWSuMY4b+6e+l3zvuEfNpSZG7RlYW44tJeTLOio5sxRyJrju7VMkhgGI4XgRzv+tye+Ed0An1hq7sca/wOFpW9Nj3GrKMwcKgt4dDcEeMzf2pj0liql4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766532071; c=relaxed/simple;
	bh=YwIDZIhU8dapb322LbprouFfE40bkump7zfMguSL/dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiNQJhyGnXVyaLPwX0g3qPG81B9QypaFjheBgQAuEEvS3gCEQd7Yna7sEEceQoahZ8mLGuXWGn7k5F2YDvxh9+diH4d7b1rhmZlHaIfEMl8xH+ymaCMo2Tc4i5kaV/kO+hBNUNl3pWsaSIxUReRYSI7OGc+VTV6caJfqXHOaD5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CMjc0KoH; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 23 Dec 2025 15:20:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766532054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W/Zjblw4vDP1sJ8bKC4Gyh93B2H/argQe0LsM3CQG9A=;
	b=CMjc0KoHfI06EwO7RnCzuv4OjMj2kPeXra5QwjJ3hvLUOZQCHA9rKdhFK1wvt2MWk3DdGI
	1TMJdVwSItsdJWW/IYv08XCttBViaz3lrkp9mWUmcd1n5Gfid/4DEGfevMQfdWkIjc9Jmo
	zxRR7xkm0WUkRQIqwQ+HMj5kvG5IpBw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com, 
	mhocko@suse.com, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, 
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com, 
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, 
	lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
Message-ID: <vsr4khfsp4unk73a75ky7i35nzdjqsbodyeeuxipu3arormfjr@awi2srdwawfu>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <5dsb6q2r4xsi24kk5gcnckljuvgvvp6nwifwvc4wuho5hsifeg@5ukg2dq6ini5>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dsb6q2r4xsi24kk5gcnckljuvgvvp6nwifwvc4wuho5hsifeg@5ukg2dq6ini5>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 23, 2025 at 08:04:50PM +0000, Yosry Ahmed wrote:
[...]
> 
> I think there might be a problem with non-hierarchical stats on cgroup
> v1, I brought it up previously [*]. I am not sure if this was addressed
> but I couldn't immediately find anything.

Sigh, the curse of memcg-v1. Let's see what we can do to not break v1.

> 
> In short, if memory is charged to a dying cgroup 

Not sure why stats updates for dying cgroup is related. Isn't it simply
stat increase at the child memcg and then stat decrease at the parent
memcg would possibly show negative stat_local of the parent.

> at the time of
> reparenting, when the memory gets uncharged the stats updates will occur
> at the parent. This will update both hierarchical and non-hierarchical
> stats of the parent, which would corrupt the parent's non-hierarchical
> stats (because those counters were never incremented when the memory was
> charged).
> 
> I didn't track down which stats are affected by this, but off the top of
> my head I think all stats tracking anon, file, etc.

Let's start with what specific stats might be effected. First the stats
which are monotonically increasing should be fine, like
WORKINGSET_REFAULT_[ANON|FILE], PGPG[IN|OUT], PG[MAJ]FAULT.

So, the following ones are the interesting ones:

NR_FILE_PAGES, NR_ANON_MAPPED, NR_ANON_THPS, NR_SHMEM, NR_FILE_MAPPED,
NR_FILE_DIRTY, NR_WRITEBACK, MEMCG_SWAP, NR_SWAPCACHE.

> 
> The obvious solution is to flush and reparent the stats of a dying memcg
> during reparenting,

Again not sure how flushing will help here and what do you mean by
'reparent the stats'? Do you mean something like:

parent->vmstats->state_local += child->vmstats->state_local;

Hmm this seems fine and I think it should work.

> but I don't think this entirely fixes the problem
> because the dying memcg stats can still be updated after its reparenting
> (e.g. if a ref to the memcg has been held since before reparenting).

How can dying memcg stats can still be updated after reparenting? The
stats which we care about are the anon & file memory and this series is
reparenting them, so dying memcg will not see stats updates unless there
is a concurrent update happening and I think it is very easy to avoid
such situation by putting a grace period between reparenting the
file/anon folios and reparenting dying chils'd stats_local. Am I missing
something?


