Return-Path: <cgroups+bounces-2899-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 461368C5C76
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 22:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0315F2828EE
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 20:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EB21EA80;
	Tue, 14 May 2024 20:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OGQpwThJ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A9D339A0
	for <cgroups@vger.kernel.org>; Tue, 14 May 2024 20:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715719741; cv=none; b=fyStcsHw/3DAwNPKiyYJONdqa2oEUHU+1pkAux/DJxNDNQjDTC7plY7oj6zPjlEydMpIlY7t6nHuaM2qxrvQYfamaGJwgbE8vAM7aGEx0d+W8pwmW6GIQM7aGznI5bxKZNfV3qkQLqDRNtcd1ZYLgf9EB0f8RNI9SYST+2WVKuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715719741; c=relaxed/simple;
	bh=+kC3x8SXXb0no0oRx22C1RCk9ERpR8hzu7TzSlw8wEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bei6XDjck1LhfmywWD/vzpzEj5Xxzbma2uulMg6ZI0hP+WMp9PVOcW3AeWwQeTT8eKrfAxsKz5ZS9m030xdN0BMqkBkwJNHjZqjTTIOfPaeStX+bCRBfn8A4GNnYsWUdqlyAV7O2j8DX/okOyVk6Z09NXmy6czFe2g28F+/6154=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OGQpwThJ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 14 May 2024 13:48:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715719737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vjO7VnrroqxxgnD3OiMZO9Nx30PMYAUaL1ENaC7gzp0=;
	b=OGQpwThJqbh+faErC9luLSfbckj35Wc0Ehw3+nSaXp9SeE7K4BbMHDB74xYP0iRy49c8iV
	0FPeMy9LX1E2pl9GAgAFJ4KQq6jO9kP2IghKENNjf3jOeLwUzPt5S7bt2ZGWSeumNApQDp
	KHHP+Ef5Nqvk58wjoPRIH+AgL9SKHUQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: vmscan: restore incremental cgroup iteration
Message-ID: <whvb6gkmciiogjoevep6pep6ibkjxoabgckeog6dejn4wjqxpj@przngnktv255>
References: <20240514202641.2821494-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514202641.2821494-1-hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Tue, May 14, 2024 at 04:26:41PM -0400, Johannes Weiner wrote:
> Currently, reclaim always walks the entire cgroup tree in order to
> ensure fairness between groups. While overreclaim is limited in
> shrink_lruvec(), many of our systems have a sizable number of active
> groups, and an even bigger number of idle cgroups with cache left
> behind by previous jobs; the mere act of walking all these cgroups can
> impose significant latency on direct reclaimers.
> 
> In the past, we've used a save-and-restore iterator that enabled
> incremental tree walks over multiple reclaim invocations. This ensured
> fairness, while keeping the work of individual reclaimers small.
> 
> However, in edge cases with a lot of reclaim concurrency, individual
> reclaimers would sometimes not see enough of the cgroup tree to make
> forward progress and (prematurely) declare OOM. Consequently we
> switched to comprehensive walks in 1ba6fc9af35b ("mm: vmscan: do not
> share cgroup iteration between reclaimers").
> 
> To address the latency problem without bringing back the premature OOM
> issue, reinstate the shared iteration, but with a restart condition to
> do the full walk in the OOM case - similar to what we do for
> memory.low enforcement and active page protection.
> 
> In the worst case, we do one more full tree walk before declaring
> OOM. But the vast majority of direct reclaim scans can then finish
> much quicker, while fairness across the tree is maintained:
> 
> - Before this patch, we observed that direct reclaim always takes more
>   than 100us and most direct reclaim time is spent in reclaim cycles
>   lasting between 1ms and 1 second. Almost 40% of direct reclaim time
>   was spent on reclaim cycles exceeding 100ms.
> 
> - With this patch, almost all page reclaim cycles last less than 10ms,
>   and a good amount of direct page reclaim finishes in under 100us. No
>   page reclaim cycles lasting over 100ms were observed anymore.
> 
> The shared iterator state is maintaned inside the target cgroup, so
> fair and incremental walks are performed during both global reclaim
> and cgroup limit reclaim of complex subtrees.
> 
> Reported-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Rik van Riel <riel@surriel.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

