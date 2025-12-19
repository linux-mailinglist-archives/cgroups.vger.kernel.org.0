Return-Path: <cgroups+bounces-12528-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E40ACCE452
	for <lists+cgroups@lfdr.de>; Fri, 19 Dec 2025 03:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF15130125C1
	for <lists+cgroups@lfdr.de>; Fri, 19 Dec 2025 02:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8B71DB375;
	Fri, 19 Dec 2025 02:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oXLgjGWS"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61B221A453
	for <cgroups@vger.kernel.org>; Fri, 19 Dec 2025 02:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766111444; cv=none; b=KbC0TNJC+UWAm92V+sguIY3sldtm08LAx276ETQyVVvsCvIg1f+4pQgBHcEytSiByXStjMTvdRqzL+VOZZN7zl/nSb9zyAkGOLxmBp1RzecR+Ot7vSmh/yjN+odUHfJcOsjNUVMEL2vtIHfvH8v3Cfo6/1iuCIlk26PzCoUVkAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766111444; c=relaxed/simple;
	bh=g2I3YWbMjzS0/ov0GMCrmCJLS04Dow9+GMmGFhdjSbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogZU2kmEoaiTSIqH9xb5rRZyBbUb5Cn6TcxC9XANDDf5f81otFcu0/48g0e/NLmxBTihZQfu7ZfDQq4gNOn/YOqGaGDtaloKYiJ3zb142VgLRqXWZC/QJpDXjrVMEEyX2nbMhVU1+GHxzxapo4K4kqsSPvXHJlYS3hxGVqEoxME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oXLgjGWS; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 18 Dec 2025 18:30:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766111423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DkCvPZ82H60vrdm1+8FcykuYy724Kwg4Ti1zfuNLOq4=;
	b=oXLgjGWS0J6lAiQm1PnCBtu8DyNQVQ4Dxf5Iej/sGjV64gVaBVuVet/j6ZvnO8SeytflJ/
	C5tj6NWhJDOTyC9Je7ErR5bXdqGeoZKP9WCiHRCYRjpfCDvuPwC2txtz1OvWC+NMbcI+YS
	lTRKhj8C5SLqEPGbtokCHJlsbjnohEI=
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
Subject: Re: [PATCH v2 10/28] writeback: prevent memory cgroup release in
 writeback module
Message-ID: <5e2l35gcurnfclqtyqycylpcferjsitwjoa6ixbp5u6fng4b52@gfdmi4elp75m>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <d2863fabba49a16572a84163e42cbce64aee27c9.1765956025.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2863fabba49a16572a84163e42cbce64aee27c9.1765956025.git.zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 17, 2025 at 03:27:34PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. To ensure safety, it will only be appropriate to
> hold the rcu read lock or acquire a reference to the memory cgroup
> returned by folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the function get_mem_cgroup_css_from_folio()
> and the rcu read lock are employed to safeguard against the release
> of the memory cgroup.
> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> ---

[...]

> @@ -1549,9 +1549,14 @@ static inline void mem_cgroup_track_foreign_dirty(struct folio *folio,
>  	if (mem_cgroup_disabled())
>  		return;
>  
> +	if (!folio_memcg_charged(folio))
> +		return;
> +
> +	rcu_read_lock();
>  	memcg = folio_memcg(folio);
> -	if (unlikely(memcg && &memcg->css != wb->memcg_css))
> +	if (unlikely(&memcg->css != wb->memcg_css))
>  		mem_cgroup_track_foreign_dirty_slowpath(folio, wb);

The slowpath in the name gave me a pause but it seems like it is safe to
be called within rcu lock.

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

