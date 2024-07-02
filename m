Return-Path: <cgroups+bounces-3479-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA7791EC0E
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 02:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53719B214BF
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 00:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670796FCB;
	Tue,  2 Jul 2024 00:56:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F317A8489;
	Tue,  2 Jul 2024 00:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719881769; cv=none; b=i/MMyLHA1MQr8nIFjcQyx2I9R/1Iu3GUEWXk5UyL9AhIECY/5fLNcHGPpY4Jj7+g+xJGWH3+moobfOcsXaxbtlwDmanceVtvbO5/sB419L1jsBpcwirJENd+qqw8X65IF0ENU6u2Wtj2CPk0UKDk0JDs1xiAs6OHqBNjg9dcXMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719881769; c=relaxed/simple;
	bh=XkgX5lxEHXnFt3gb4fSXx2x+XrRrziD/N4QGblQpoSg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=NCfbBZVxGPYM03hJTCDKCSG/9vlUw/dVwNjenlaa/pUOKWUfWm2TcTSW1BpDTAbUcUIFKYOjOBwNKP4CJiFMmKTfnpOhJitSMBzPBkVHsTBQj7XD4O3+6iOSEgWXF/EeMQ/UYV6seGzGA1PBknwiX8KpGFRBc0k2mSgy8K9blaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WCkvP1zqpz5sZl;
	Tue,  2 Jul 2024 08:54:25 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id C035B18006C;
	Tue,  2 Jul 2024 08:56:01 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 08:56:01 +0800
Message-ID: <2f586040-73f2-df74-6ae2-a26afddd7263@huawei.com>
Date: Tue, 2 Jul 2024 08:56:01 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 -next] cgroup/misc: Introduce misc.peak
Content-Language: en-US
From: xiujianfeng <xiujianfeng@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<corbet@lwn.net>, <kamalesh.babulal@oracle.com>,
	<haitao.huang@linux.intel.com>
CC: <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240702004108.2645587-1-xiujianfeng@huawei.com>
In-Reply-To: <20240702004108.2645587-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500023.china.huawei.com (7.185.36.114)



On 2024/7/2 8:41, Xiu Jianfeng wrote:
> Introduce misc.peak to record the historical maximum usage of the
> resource, as in some scenarios the value of misc.max could be
> adjusted based on the peak usage of the resource.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> ---
> v2: use cmpxchg to update the watermark
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  9 ++++++
>  include/linux/misc_cgroup.h             |  2 ++
>  kernel/cgroup/misc.c                    | 39 +++++++++++++++++++++++++
>  3 files changed, 50 insertions(+)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index ae0fdb6fc618..468a95379009 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -2646,6 +2646,15 @@ Miscellaneous controller provides 3 interface files. If two misc resources (res_
>  	  res_a 3
>  	  res_b 0
>  
> +  misc.peak
> +        A read-only flat-keyed file shown in all cgroups.  It shows the
> +        historical maximum usage of the resources in the cgroup and its
> +        children.::
> +
> +	  $ cat misc.peak
> +	  res_a 10
> +	  res_b 8
> +
>    misc.max
>          A read-write flat-keyed file shown in the non root cgroups. Allowed
>          maximum usage of the resources in the cgroup and its children.::
> diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
> index e799b1f8d05b..faf72a537596 100644
> --- a/include/linux/misc_cgroup.h
> +++ b/include/linux/misc_cgroup.h
> @@ -30,11 +30,13 @@ struct misc_cg;
>  /**
>   * struct misc_res: Per cgroup per misc type resource
>   * @max: Maximum limit on the resource.
> + * @watermark: Historical maximum usage of the resource.
>   * @usage: Current usage of the resource.
>   * @events: Number of times, the resource limit exceeded.
>   */
>  struct misc_res {
>  	u64 max;
> +	u64 watermark;
>  	atomic64_t usage;
>  	atomic64_t events;
>  };
> diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
> index 79a3717a5803..42642a96f4dc 100644
> --- a/kernel/cgroup/misc.c
> +++ b/kernel/cgroup/misc.c
> @@ -121,6 +121,17 @@ static void misc_cg_cancel_charge(enum misc_res_type type, struct misc_cg *cg,
>  		  misc_res_name[type]);
>  }
>  
> +static void misc_cg_update_watermark(struct misc_res *res, u64 new_usage)
> +{
> +	u64 old;
> +
> +	do {
> +		old = READ_ONCE(res->watermark);
> +		if (cmpxchg(&res->watermark, old, new_usage) == old)
> +			break;
> +	} while (0);

oops! should be while (1) here.


> +}
> +
>  /**
>   * misc_cg_try_charge() - Try charging the misc cgroup.
>   * @type: Misc res type to charge.
> @@ -159,6 +170,7 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg, u64 amount)
>  			ret = -EBUSY;
>  			goto err_charge;
>  		}
> +		misc_cg_update_watermark(res, new_usage);
>  	}
>  	return 0;
>  
> @@ -307,6 +319,29 @@ static int misc_cg_current_show(struct seq_file *sf, void *v)
>  	return 0;
>  }
>  
> +/**
> + * misc_cg_peak_show() - Show the peak usage of the misc cgroup.
> + * @sf: Interface file
> + * @v: Arguments passed
> + *
> + * Context: Any context.
> + * Return: 0 to denote successful print.
> + */
> +static int misc_cg_peak_show(struct seq_file *sf, void *v)
> +{
> +	int i;
> +	u64 watermark;
> +	struct misc_cg *cg = css_misc(seq_css(sf));
> +
> +	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
> +		watermark = READ_ONCE(cg->res[i].watermark);
> +		if (READ_ONCE(misc_res_capacity[i]) || watermark)
> +			seq_printf(sf, "%s %llu\n", misc_res_name[i], watermark);
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * misc_cg_capacity_show() - Show the total capacity of misc res on the host.
>   * @sf: Interface file
> @@ -357,6 +392,10 @@ static struct cftype misc_cg_files[] = {
>  		.name = "current",
>  		.seq_show = misc_cg_current_show,
>  	},
> +	{
> +		.name = "peak",
> +		.seq_show = misc_cg_peak_show,
> +	},
>  	{
>  		.name = "capacity",
>  		.seq_show = misc_cg_capacity_show,

