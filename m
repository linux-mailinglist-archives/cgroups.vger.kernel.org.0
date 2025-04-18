Return-Path: <cgroups+bounces-7633-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 207C7A93004
	for <lists+cgroups@lfdr.de>; Fri, 18 Apr 2025 04:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3D6447F7B
	for <lists+cgroups@lfdr.de>; Fri, 18 Apr 2025 02:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FE01C84A0;
	Fri, 18 Apr 2025 02:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aaTqAWJ4"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DED24B26
	for <cgroups@vger.kernel.org>; Fri, 18 Apr 2025 02:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744943782; cv=none; b=stOCjcR6XPfb7RvkyWRTmrTDNDVLEfsDvdfnVWdeowYM4L3QTt25U6Dyvn+Ae856iU+GlUd53OEri1qEy2R1thlKAO1OgTUY1cUtSjYyDlmx1T93YkSR+3DwdDPIOPjjCFMUW2lwJBUylulgqGDngKHO5jWS+PSe1EmtmdNB7Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744943782; c=relaxed/simple;
	bh=FTl7Q5XRnGG/z7yA2jnIcdaCMVMzFKXY7SOCzfxworo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=saPwrJbCQBTX4SHfATsrU35nXS86f5XuMNewz6ZsXJFMpS5pm9BwGBwJv1W+mvpRqTl4EZYlQDymVbsjbE/xnpyJD3QeWUftQyKBnG2wvblx5x9Uc+edduJ8NLeNTSEWlinDwE7l17nYOgRwmh9ekzbhoVSVuPsVet/jWiKJFZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aaTqAWJ4; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cf8e2dba-83dd-4ad3-b98d-2e463ea569d9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744943775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pbE8PCxj37IlfzeB23r98u0SEU9TacNSUq2UwVU1+Ag=;
	b=aaTqAWJ4vWMSW3JKJLdxB+V6toZe5COJtDrFrTe3YygJoTCx+cj8cFUMAZxFSQa0VdkWaG
	mOGyXLvF1+F/KnTGW10tDstqV04gRCIoK76cl2pcDZmw6SOQkrAKqbchj65/FIr6YdDkMN
	gZl4IdXmdFc2lbgbELuxvI/JHf414V0=
Date: Fri, 18 Apr 2025 10:36:03 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 21/28] mm: zswap: prevent lruvec release in
 zswap_folio_swapin()
To: Muchun Song <songmuchun@bytedance.com>, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, akpm@linux-foundation.org, david@fromorbit.com,
 zhengqi.arch@bytedance.com, yosry.ahmed@linux.dev, nphamcs@gmail.com
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-mm@kvack.org, hamzamahfooz@linux.microsoft.com,
 apais@linux.microsoft.com
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <20250415024532.26632-22-songmuchun@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20250415024532.26632-22-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/4/15 10:45, Muchun Song wrote:
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. So an lruvec returned by folio_lruvec() could be
> released without the rcu read lock or a reference to its memory
> cgroup.
> 
> In the current patch, the rcu read lock is employed to safeguard
> against the release of the lruvec in zswap_folio_swapin().
> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

It should be rare to race with folio reparenting process, so
it seems ok not to "reparent" this counter "nr_disk_swapins".

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks.

> ---
>   mm/zswap.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 204fb59da33c..4a41c2371f3d 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -752,8 +752,10 @@ void zswap_folio_swapin(struct folio *folio)
>   	struct lruvec *lruvec;
>   
>   	if (folio) {
> +		rcu_read_lock();
>   		lruvec = folio_lruvec(folio);
>   		atomic_long_inc(&lruvec->zswap_lruvec_state.nr_disk_swapins);
> +		rcu_read_unlock();
>   	}
>   }
>   

