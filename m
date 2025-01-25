Return-Path: <cgroups+bounces-6315-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72492A1C04D
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 02:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4CBF167374
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 01:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E1E1F1505;
	Sat, 25 Jan 2025 01:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kq2Svp4S"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055AA1EEA54
	for <cgroups@vger.kernel.org>; Sat, 25 Jan 2025 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737768866; cv=none; b=VLaWyz9CQuiKEecbDEkSZmitG92y4cL3VFliNstNQ0L6zj5Wam0oT3z7llL3tMvL0wF5zNjeVK1QP2GLnUUACvNqP2o+CLzpJUaHRcZ8QIiFMRxShvafGnCNSRgRW7cN1oBtyip2xUIESWcRDElcFhH7AOie6HMUrNQgAIO51r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737768866; c=relaxed/simple;
	bh=bP0Q2dS9tivPEmjHzIEOLA2Mp9mZoZHP+HuOCRSB14I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrjEvX5t5nTpO0mqEPtLF4k4I4bkPeVlE6euuF3f7/Bb8ldz7vfFqAqdMgPyVCG5UzW9OlFSHJcXJZiVKCoWJGYT4XjVGcxi8Q3PXU3ny3rnqpu+axhAzj04tOvCzgrqivcVpBlb1PziUrSPnfoD8YEFZZ8HJ7ybvjKgqT2v2W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kq2Svp4S; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 25 Jan 2025 01:34:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737768856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HnQSr0YFLguPEep0vRgiXOdtVoxbHdXDfcgj+omvXAA=;
	b=Kq2Svp4SkXjzU8DBW9FfS+o5j337+HvmCJvLUt8Ig7jzZhHD3AFxQ7UKte/t/7q2We0n3h
	QAhzicrFEusP/bGsqWYLGB6TU/FSzYVTwMELawCnkKFcelp6ABXTgsA1GZoOxTbJBU65zu
	E19W21tYYij1pUUyWrMBUdHDEJxqFlc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org,
	yosryahmed@google.com, shakeel.butt@linux.dev,
	muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz,
	mkoutny@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: Re: [PATCH -v4 next 1/4] memcg: use OFP_PEAK_UNSET instead of -1
Message-ID: <Z5Q_k4650ODFhytu@google.com>
References: <20250124073514.2375622-1-chenridong@huaweicloud.com>
 <20250124073514.2375622-2-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250124073514.2375622-2-chenridong@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 24, 2025 at 07:35:11AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The 'OFP_PEAK_UNSET' has been defined, use it instead of '-1'.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> Reviewed-by: Michal Koutný <mkoutny@suse.com>
> Acked-by: David Finkel <davidf@vimeo.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

I think I acked it previously?

Anyway,

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 46f8b372d212..05a32c860554 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4004,7 +4004,7 @@ static ssize_t peak_write(struct kernfs_open_file *of, char *buf, size_t nbytes,
>  			WRITE_ONCE(peer_ctx->value, usage);
>  
>  	/* initial write, register watcher */
> -	if (ofp->value == -1)
> +	if (ofp->value == OFP_PEAK_UNSET)
>  		list_add(&ofp->list, watchers);
>  
>  	WRITE_ONCE(ofp->value, usage);
> -- 
> 2.34.1
> 

