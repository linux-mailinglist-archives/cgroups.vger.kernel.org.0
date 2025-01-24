Return-Path: <cgroups+bounces-6252-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0C5A1AE48
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 02:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 201D7188D044
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 01:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078251D47AC;
	Fri, 24 Jan 2025 01:47:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2390660890;
	Fri, 24 Jan 2025 01:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737683239; cv=none; b=TIzg1vJ8C9/oFfv58BIV+T7BwXEXCP9tDRsIfInmKPdjxAZ6RvqJyGYGht/qkTZOA72/5Ycg4fyCFSENygwDUvvUwzwYEAdSJHEXdFz1oX9QO+lGy9izoNXj58an9K27E7IkJd9LvRjH6hJyc/4TCRitZsSErPAG3kg24+2vKPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737683239; c=relaxed/simple;
	bh=nHcBB0vP7NYkv2m7shS4TwSVQOvBZ5aWg1HWnuN5Eag=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZaWl1kpIJsF09RgcRa+0W+gSiWW5lqq34MtL2SSPOwQimBC2meEZv6JdhX0PJhyvd2XAEQA4lns8K0UWr46YIpwKjGHzZQoaxfyW4FUuFfz+y3JNav25Gdzynw3E/jZ67+gldzyAtlRF7B5KfjB5Pyo2f69LuL7+w0mU9EEtjIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4YfLKd14Sbz20pGC;
	Fri, 24 Jan 2025 09:47:33 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 6CE611A016C;
	Fri, 24 Jan 2025 09:47:07 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 24 Jan
 2025 09:47:06 +0800
Message-ID: <853d2669-e05b-435e-9ac1-86311ead56e5@huawei.com>
Date: Fri, 24 Jan 2025 09:47:05 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cgroup/rstat: Fix forceidle time in cpu.stat
To: Abel Wu <wuyun.abel@bytedance.com>, Tejun Heo <tj@kernel.org>, Johannes
 Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
	<mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Thomas Gleixner
	<tglx@linutronix.de>, Yury Norov <yury.norov@gmail.com>, Andrew Morton
	<akpm@linux-foundation.org>, Bitao Hu <yaoma@linux.alibaba.com>
CC: "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, "open
 list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
References: <20250123174713.25570-1-wuyun.abel@bytedance.com>
 <20250123174713.25570-2-wuyun.abel@bytedance.com>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <20250123174713.25570-2-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2025/1/24 1:47, Abel Wu wrote:
> The commit b824766504e4 ("cgroup/rstat: add force idle show helper")
> retrieves forceidle_time outside cgroup_rstat_lock for non-root cgroups
> which can be potentially inconsistent with other stats.
> 
> Rather than reverting that commit, fix it in a way that retains the
> effort of cleaning up the ifdef-messes.
> 
> Fixes: b824766504e4 ("cgroup/rstat: add force idle show helper")
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  kernel/cgroup/rstat.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index 5877974ece92..c2784c317cdd 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -613,36 +613,33 @@ static void cgroup_force_idle_show(struct seq_file *seq, struct cgroup_base_stat
>  void cgroup_base_stat_cputime_show(struct seq_file *seq)
>  {
>  	struct cgroup *cgrp = seq_css(seq)->cgroup;
> -	u64 usage, utime, stime, ntime;
> +	struct cgroup_base_stat bstat;
>  
>  	if (cgroup_parent(cgrp)) {
>  		cgroup_rstat_flush_hold(cgrp);
> -		usage = cgrp->bstat.cputime.sum_exec_runtime;
> +		bstat = cgrp->bstat;

Thank you for finding that.
In my version 2, I used to assign cgrp->bstat to bstat.
This is Tj's comment:
https://lore.kernel.org/linux-kernel/ZoQ2ti7nnz9EJSc3@slm.duckdns.org/

Best regards,
Ridong

>  		cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
> -			       &utime, &stime);
> -		ntime = cgrp->bstat.ntime;
> +			       &bstat.cputime.utime, &bstat.cputime.stime);
>  		cgroup_rstat_flush_release(cgrp);
>  	} else {
> -		/* cgrp->bstat of root is not actually used, reuse it */
> -		root_cgroup_cputime(&cgrp->bstat);
> -		usage = cgrp->bstat.cputime.sum_exec_runtime;
> -		utime = cgrp->bstat.cputime.utime;
> -		stime = cgrp->bstat.cputime.stime;
> -		ntime = cgrp->bstat.ntime;
> +		root_cgroup_cputime(&bstat);
>  	}
>  
> -	do_div(usage, NSEC_PER_USEC);
> -	do_div(utime, NSEC_PER_USEC);
> -	do_div(stime, NSEC_PER_USEC);
> -	do_div(ntime, NSEC_PER_USEC);
> +	do_div(bstat.cputime.sum_exec_runtime, NSEC_PER_USEC);
> +	do_div(bstat.cputime.utime, NSEC_PER_USEC);
> +	do_div(bstat.cputime.stime, NSEC_PER_USEC);
> +	do_div(bstat.ntime, NSEC_PER_USEC);
>  
>  	seq_printf(seq, "usage_usec %llu\n"
>  			"user_usec %llu\n"
>  			"system_usec %llu\n"
>  			"nice_usec %llu\n",
> -			usage, utime, stime, ntime);
> +			bstat.cputime.sum_exec_runtime,
> +			bstat.cputime.utime,
> +			bstat.cputime.stime,
> +			bstat.ntime);
>  
> -	cgroup_force_idle_show(seq, &cgrp->bstat);
> +	cgroup_force_idle_show(seq, &bstat);
>  }
>  
>  /* Add bpf kfuncs for cgroup_rstat_updated() and cgroup_rstat_flush() */

