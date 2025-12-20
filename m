Return-Path: <cgroups+bounces-12542-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA6DCD24D9
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 02:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C96673002150
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 01:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C060258EC2;
	Sat, 20 Dec 2025 01:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dtns4nj1"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1DB849C
	for <cgroups@vger.kernel.org>; Sat, 20 Dec 2025 01:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766193262; cv=none; b=F/oItFUgMp+tct7H6PECEUuJlVI45IrmoLV04jFh1i4jiuo0c1CP9ilqHr5ZBK6m4Y0Zo2g9JwlTZwvm72LBFTMbzrqL5syJWHGa7aFV0VTY2PY5H0HvpxVJQexgYP6NtI38zUcgs1+vVJatzHcG8X3HRErzJ1b0asQjKhsVLyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766193262; c=relaxed/simple;
	bh=6k5HxmzwSuNZtGH7jynF4XgO9V1PpMZvutFTBCgv0Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uu3+EtQa8o66d2Pctp/PYlniyIRRDahI7yNDAqPyfip8/tNoC6ta7NLWQNzNpoqbHMmhgQ53+sAp5KnGA1lMNno9LCEQ8CO623pbBeQvyTXajsX0i0UKl2VPJEGHAUnd7la3PUfrj0P+86d9843o65fRZBVnBezEtes+6cgUKkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dtns4nj1; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Dec 2025 17:14:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766193253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vxC8T+rn7zYzk/KOZEqUCOjZ+il++GuXxMtPIMNg9q0=;
	b=Dtns4nj1gZMu9QJEiFoWliG7yIBsL+CqKfiT+cqL34Id9Dly3jB4FPjmyxw1MEORyPLanI
	W9bYbDaHiMz9rupETo8XGpT6B46d8o7DrEp72sLTfvWU2vOiPOzuggZzOs0xdUFzWtz6ST
	z962FdLULtNcJR+maixHtF3+WfX2u2U=
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
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 18/28] mm: zswap: prevent memory cgroup release in
 zswap_compress()
Message-ID: <yyuvjavtoiszb4ykd6xafyo6nf3gvqk6wsgpmtid2goiqj3vi5@vryj77fitb4l>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <cbd77b6cb5273b75fb2d853f368bcb099f52869e.1765956026.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbd77b6cb5273b75fb2d853f368bcb099f52869e.1765956026.git.zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 17, 2025 at 03:27:42PM +0800, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding memory
> cgroup. To ensure safety, it will only be appropriate to hold the rcu read
> lock or acquire a reference to the memory cgroup returned by
> folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the rcu read lock is employed to safeguard against
> the release of the memory cgroup in zswap_compress().
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

