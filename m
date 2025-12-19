Return-Path: <cgroups+bounces-12522-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F1ACCE061
	for <lists+cgroups@lfdr.de>; Fri, 19 Dec 2025 01:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB431301E150
	for <lists+cgroups@lfdr.de>; Fri, 19 Dec 2025 00:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EF721348;
	Fri, 19 Dec 2025 00:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="moTIZwTz"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E766290F
	for <cgroups@vger.kernel.org>; Fri, 19 Dec 2025 00:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766102713; cv=none; b=Crrs+e6ZLV+nnIk5AsIMV2M9F4pNfNx0B4Su5bNJlr8psvny8BLrFtjuZn8a5TE7/EcyyfjjvQ4XLvpRSDz4GoA+BvPkMwRsAL5o5BMbzxvlS98u6OhdjUKTrmCAGqVvYhDi4Kvw6cwTX9yAEOVBUclH9uKkhLVq8xL6K6q+24U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766102713; c=relaxed/simple;
	bh=y5f0/QJGaH0nhZgYLZJO4sTp3AAHPH9RTGs1XblnxDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzrcamqGbw5Z7AXe4Qiw+Kox3IFGfn732cF5JN9wkTx8jsTmPXWdk6s3lnozvMkVQeRJKto3CxkNX4azfHb9m1LoxQE1fWhoytb37xg1d/9jCcGyQwtnEWnFQUeRiyJqolarK1oKiJKEWq1TO8SvBYj4st19ABYXF08ryae+/O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=moTIZwTz; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 18 Dec 2025 16:04:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766102695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Jwlmy1SAVfkkaQh6QwvtSm4Bu3pmworf1DAnFfYKr4=;
	b=moTIZwTz5ct4IM1pJ0e6HSkvLU0nEMjKL59Va44sjCRiGzlnuVzZl+uL8fAr+J8t00RZ2i
	/bxq7AhbigKsXJxRaZzpIIcaKLPV0wvNsw73dthXd5bZPxqbK/IevCPmxXPzr4rCXUS+gJ
	g4vdCdJHuJBFYznZabIC8ttbBlGqwnQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, imran.f.khan@oracle.com, 
	kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org, 
	hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, lance.yang@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Muchun Song <songmuchun@bytedance.com>, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 05/28] mm: vmscan: refactor move_folios_to_lru()
Message-ID: <hhrgup42tntpjj5vomztn7lztwqveu25n2vcq4h255dnipadrc@gelesqdlk5c6>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <0140f3b290fd259d58e11f86f1f04f732e8096f1.1765956025.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0140f3b290fd259d58e11f86f1f04f732e8096f1.1765956025.git.zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 17, 2025 at 03:27:29PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In a subsequent patch, we'll reparent the LRU folios. The folios that are
> moved to the appropriate LRU list can undergo reparenting during the
> move_folios_to_lru() process. Hence, it's incorrect for the caller to hold
> a lruvec lock. Instead, we should utilize the more general interface of
> folio_lruvec_relock_irq() to obtain the correct lruvec lock.
> 
> This patch involves only code refactoring and doesn't introduce any
> functional changes.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---

[...]
> +	spin_lock_irq(&lruvec->lru_lock);
>  	lru_note_cost_unlock_irq(lruvec, file, stat.nr_pageout,
>  					nr_scanned - nr_reclaimed);

I know that this patch is not changing any functionality but it is
undoing the optimization done by the commit 3865301dc58ae ("mm: optimize
lru_note_cost() by adding lru_note_cost_unlock_irq()"). I think it is
fine as a transient state and I haven't checked the final state of the
code after this series but I think we should do something to restore the
optimization after the series.

Anyways, it's a nit and if no one comes to it, I will take a stab at
restoring the optimization.

For now, LGTM.

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>


