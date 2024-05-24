Return-Path: <cgroups+bounces-2993-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DFB8CE38D
	for <lists+cgroups@lfdr.de>; Fri, 24 May 2024 11:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76CF2B20E14
	for <lists+cgroups@lfdr.de>; Fri, 24 May 2024 09:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD4D85277;
	Fri, 24 May 2024 09:34:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797AD84DEB;
	Fri, 24 May 2024 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716543270; cv=none; b=GyuiRPtXK0JWbZDCLMygQ2KpsjGMK3xo+PuRNDdinDVpjOfnPiwS0Wu2hQ5mPQvgDQKDIJTPRF7Mu52yYTBFmRO4WPcoWDLoCGbp8XoucA74ikyRaSeqkvDPrE8TV4tfUap5pTTO7vr7J0UVmvwCKbZRqWhUHtWBKblpw2CRNSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716543270; c=relaxed/simple;
	bh=TFJHvdM4FlR8aIwPk/1yrjPqD09QYCBjVxerKE0oB5o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=qG5wXi8U8sLFRfzuCIj3oIaaNrkK/L4dPo178Tw0+EuUa6GziZu6f6m21HDzNTzTbOT1HaZIsX4V6VPg2o//JpuF59t7MXRRTtIU8O4uOFFsvVcXhX0j4xaDk2Yq/iLE1O3FZlU3mTVzK++L8GC/TUGli8qKAgBd/Sfb29LZLJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Vm0CK6tBFz1S5c8;
	Fri, 24 May 2024 17:30:53 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 070F91A0188;
	Fri, 24 May 2024 17:34:25 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 24 May 2024 17:34:24 +0800
Message-ID: <462f95c8-514d-6ba2-73ff-c5ae752114a2@huawei.com>
Date: Fri, 24 May 2024 17:34:24 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next] cgroup/pids: replace can_attach and cancel_attach
 with attach hook
Content-Language: en-US
From: xiujianfeng <xiujianfeng@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240524091851.1539589-1-xiujianfeng@huawei.com>
In-Reply-To: <20240524091851.1539589-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)

Sorry, it's a mistake, please ignore this patch :(

On 2024/5/24 17:18, Xiu Jianfeng wrote:
> Currently pids_can_attach() always returns 0 and never fails, so the
> can_attach() and cancel_attach() hooks can be replaced by attach(),
> since attach() is guaranteed to succeed and don't need to fallback.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  kernel/cgroup/pids.c | 25 ++-----------------------
>  1 file changed, 2 insertions(+), 23 deletions(-)
> 
> diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
> index 0e5ec7d59b4d..86d06f709957 100644
> --- a/kernel/cgroup/pids.c
> +++ b/kernel/cgroup/pids.c
> @@ -186,7 +186,7 @@ static int pids_try_charge(struct pids_cgroup *pids, int num)
>  	return -EAGAIN;
>  }
>  
> -static int pids_can_attach(struct cgroup_taskset *tset)
> +static void pids_attach(struct cgroup_taskset *tset)
>  {
>  	struct task_struct *task;
>  	struct cgroup_subsys_state *dst_css;
> @@ -207,26 +207,6 @@ static int pids_can_attach(struct cgroup_taskset *tset)
>  		pids_charge(pids, 1);
>  		pids_uncharge(old_pids, 1);
>  	}
> -
> -	return 0;
> -}
> -
> -static void pids_cancel_attach(struct cgroup_taskset *tset)
> -{
> -	struct task_struct *task;
> -	struct cgroup_subsys_state *dst_css;
> -
> -	cgroup_taskset_for_each(task, dst_css, tset) {
> -		struct pids_cgroup *pids = css_pids(dst_css);
> -		struct cgroup_subsys_state *old_css;
> -		struct pids_cgroup *old_pids;
> -
> -		old_css = task_css(task, pids_cgrp_id);
> -		old_pids = css_pids(old_css);
> -
> -		pids_charge(old_pids, 1);
> -		pids_uncharge(pids, 1);
> -	}
>  }
>  
>  /*
> @@ -374,8 +354,7 @@ static struct cftype pids_files[] = {
>  struct cgroup_subsys pids_cgrp_subsys = {
>  	.css_alloc	= pids_css_alloc,
>  	.css_free	= pids_css_free,
> -	.can_attach 	= pids_can_attach,
> -	.cancel_attach 	= pids_cancel_attach,
> +	.attach		= pids_attach,
>  	.can_fork	= pids_can_fork,
>  	.cancel_fork	= pids_cancel_fork,
>  	.release	= pids_release,

