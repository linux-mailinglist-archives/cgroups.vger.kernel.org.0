Return-Path: <cgroups+bounces-3467-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8010B91E326
	for <lists+cgroups@lfdr.de>; Mon,  1 Jul 2024 17:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26551C220C4
	for <lists+cgroups@lfdr.de>; Mon,  1 Jul 2024 15:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3CB16C849;
	Mon,  1 Jul 2024 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l7Ed4EuO"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC1C16B739;
	Mon,  1 Jul 2024 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846130; cv=none; b=n6sWp57tyTvtK/Ej06dbR9qV8tAGa3LjkAx7h3hc1in373KY6AD8+dNY7apR9vi0klD753EnkldoYv+Iw1jX6RNUkn82pQTSJeuSTLmjFrKsN+evf4vLR79p3qlvzQDXdW++NFyVZIjxD31R6P9PJcq/NY2kPOStmiZsagAWNQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846130; c=relaxed/simple;
	bh=sfrTo7hyYfbzhRNUPumhmPzam6O6qfhQMqEfifc7xkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/+CZXMIN3e3wU/qry9mQMmWX7ry7fepvlN549+FNKyKb+xz71d+yQuR3P/sAXEGcRqyVKFAOsj3UKvMLGjizCnoxr8lMM8IRWDkPqg6xtQRr3xAkWwNRuXSfsGcJE5OHmSc04HyzM+5PCb5LEyQKQKBtcjTH7loui0VL7SvnVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l7Ed4EuO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=QewlYFdkXVk4y5FaBk6eYx20wWM+U6iYtyuvzVLFNAg=; b=l7Ed4EuOOarcvuAxcQtXJqO9hk
	2i8hO3/kBgNa2My0ptHeiIB3ru4xpKAw1w/QIM6WyVgVs95DVUZnfCUD+SZ3LBtYLDaufsfEw0gZU
	meJ64K6Ume5c6V5UhisntVi/KJGuNbmosaIZd7UzahkWE5dtgvJFEWDJmLUVDLM52tBhTfj1gxS1e
	1+N9FNlkcPzM8CiwKepLw5Ds1+DO3JbiYaONzPeBVSAGk7iShHT6UfrY6cYfGk+SzMN30RGRrjYhg
	bSbZFKrptV63SFAaWKMUwOF7iP1vjMv6J7YyjfEV56moU8dLF8KxqapMpI2WRqFOoNd/JCN2oyH8g
	2rPbLaog==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOIXX-00000003qAO-1wcY;
	Mon, 01 Jul 2024 15:01:59 +0000
Message-ID: <047579c5-582a-46ac-8967-e9ca9a90cea7@infradead.org>
Date: Mon, 1 Jul 2024 08:01:58 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup/misc: Introduce misc.peak
To: Xiu Jianfeng <xiujianfeng@huawei.com>, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net,
 kamalesh.babulal@oracle.com, haitao.huang@linux.intel.com
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240701125259.2611466-1-xiujianfeng@huawei.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240701125259.2611466-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 7/1/24 5:52 AM, Xiu Jianfeng wrote:
> Introduce misc.peak to record the historical maximum usage of the
> resource, as in some scenarios the value of misc.max could be
> adjusted based on the peak usage of the resource.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  9 ++++++++
>  include/linux/misc_cgroup.h             |  2 ++
>  kernel/cgroup/misc.c                    | 29 +++++++++++++++++++++++++
>  3 files changed, 40 insertions(+)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index ae0fdb6fc618..48ae30f2d9ab 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -2646,6 +2646,15 @@ Miscellaneous controller provides 3 interface files. If two misc resources (res_
>  	  res_a 3
>  	  res_b 0
>  
> +  misc.peak
> +        A read-only flat-keyed file shown in the all cgroups.  It shows

	                               shown in all cgroups. It shows

> +        the historical maximum usage of the resources in the cgroup and
> +        its children.::
> +
> +	  $ cat misc.peak
> +	  res_a 10
> +	  res_b 8
> +
>    misc.max
>          A read-write flat-keyed file shown in the non root cgroups. Allowed
>          maximum usage of the resources in the cgroup and its children.::
> diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
> index e799b1f8d05b..8aa69818291e 100644
> --- a/include/linux/misc_cgroup.h
> +++ b/include/linux/misc_cgroup.h
> @@ -30,11 +30,13 @@ struct misc_cg;
>  /**
>   * struct misc_res: Per cgroup per misc type resource
>   * @max: Maximum limit on the resource.
> + * $watermark: Historical maximum usage of the resource.

      @watermark:

>   * @usage: Current usage of the resource.
>   * @events: Number of times, the resource limit exceeded.
>   */
>  struct misc_res {
>  	u64 max;
> +	u64 watermark;
>  	atomic64_t usage;
>  	atomic64_t events;
>  };


-- 
~Randy

