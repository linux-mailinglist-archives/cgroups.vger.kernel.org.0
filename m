Return-Path: <cgroups+bounces-3533-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674F9926CFA
	for <lists+cgroups@lfdr.de>; Thu,  4 Jul 2024 03:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981431C2156F
	for <lists+cgroups@lfdr.de>; Thu,  4 Jul 2024 01:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF75BC125;
	Thu,  4 Jul 2024 01:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fVqzWQAk"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258B4DDA8
	for <cgroups@vger.kernel.org>; Thu,  4 Jul 2024 01:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720055694; cv=none; b=qab5rF78Ow0uzD5IJxDYU1xUdYOyEHn+hkla7cY+4zSei3w9G0rIJzQE6SA+Vy3EUa4zHxxi0SQxBRC4Fw98t0M8Y8To0iOT+gsdDuXKEgaVX55LhyS7HS76IH6/0FGQ95KrMMIOautFPXI3YKKafFsC643in7hay96JwRMJbSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720055694; c=relaxed/simple;
	bh=B23C3TKWnVzvDysg3RcVZDOhd0lm/LDvBPga9YohyDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZfQODUdkrMcBR3Qzr6rvA4XYJAFIsqztu1YxTLF/oZqVRb1+TbegaAG8+UlXuEEkfjtYiYuegFRA/j+Ighukr+BGBPHzXS0NqWeLXVf7gtvCzQ58RGqyNauL492yxbU/yY2NRkNf+e7uqQgiMJ+03BEpbgbw/LLCtzokZPOc2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fVqzWQAk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720055691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/8RMfWJwFDkET+gxtH7rr9d29nRTeO240HVdwdgkVS0=;
	b=fVqzWQAkhPdfBiOMEgDgh858LbC+FTCTyQbH43BoZpQmHNxx2oRxK9tUO65LmHfow6a173
	m/u1DoigZ7an5Ryb0z8UerMcgO7oBuLOQa3AkSqN+70ENUvDcq1lwdhF1d0O94IXkoNWDL
	qSsTbqVbRZIaVXVvN4JlG71D8PrAcRY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-gNgNiRW-Numj8cs-3h_jYg-1; Wed,
 03 Jul 2024 21:14:47 -0400
X-MC-Unique: gNgNiRW-Numj8cs-3h_jYg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D465A1956077;
	Thu,  4 Jul 2024 01:14:45 +0000 (UTC)
Received: from [10.22.16.16] (unknown [10.22.16.16])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 525661954B0D;
	Thu,  4 Jul 2024 01:14:43 +0000 (UTC)
Message-ID: <55c508cf-9bc0-49a5-a286-8a9f3ff55220@redhat.com>
Date: Wed, 3 Jul 2024 21:14:43 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 -next] cgroup/rstat: add force idle show helper
To: Chen Ridong <chenridong@huawei.com>, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240704005007.1400414-1-chenridong@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240704005007.1400414-1-chenridong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


On 7/3/24 20:50, Chen Ridong wrote:
> In the function cgroup_base_stat_cputime_show, there are five
> instances of #ifdef, which makes the code not concise.
> To address this, add the function cgroup_force_idle_show
> to make the code more succinct.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/rstat.c | 36 ++++++++++++++++--------------------
>   1 file changed, 16 insertions(+), 20 deletions(-)
>
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index fb8b49437573..1568558e36e5 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -594,49 +594,45 @@ static void root_cgroup_cputime(struct cgroup_base_stat *bstat)
>   	}
>   }
>   
> +
> +static void cgroup_force_idle_show(struct seq_file *seq, struct cgroup_base_stat *bstat)
> +{
> +#ifdef CONFIG_SCHED_CORE
> +	u64 forceidle_time = bstat->forceidle_sum;
> +
> +	do_div(forceidle_time, NSEC_PER_USEC);
> +	seq_printf(seq, "core_sched.force_idle_usec %llu\n", forceidle_time);
> +#endif
> +}
> +
>   void cgroup_base_stat_cputime_show(struct seq_file *seq)
>   {
>   	struct cgroup *cgrp = seq_css(seq)->cgroup;
>   	u64 usage, utime, stime;
> -	struct cgroup_base_stat bstat;
> -#ifdef CONFIG_SCHED_CORE
> -	u64 forceidle_time;
> -#endif
>   
>   	if (cgroup_parent(cgrp)) {
>   		cgroup_rstat_flush_hold(cgrp);
>   		usage = cgrp->bstat.cputime.sum_exec_runtime;
>   		cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
>   			       &utime, &stime);
> -#ifdef CONFIG_SCHED_CORE
> -		forceidle_time = cgrp->bstat.forceidle_sum;
> -#endif
>   		cgroup_rstat_flush_release(cgrp);
>   	} else {
> -		root_cgroup_cputime(&bstat);
> -		usage = bstat.cputime.sum_exec_runtime;
> -		utime = bstat.cputime.utime;
> -		stime = bstat.cputime.stime;
> -#ifdef CONFIG_SCHED_CORE
> -		forceidle_time = bstat.forceidle_sum;
> -#endif
> +		root_cgroup_cputime(&cgrp->bstat);
> +		usage = cgrp->bstat.cputime.sum_exec_runtime;
> +		utime = cgrp->bstat.cputime.utime;
> +		stime = cgrp->bstat.cputime.stime;

Just a simple comment saying that you are reusing the root cgroup bstat 
which is otherwise not being used will help readability.

Other than that, the change LGTM.

Cheers,
Longman

>   	}
>   
>   	do_div(usage, NSEC_PER_USEC);
>   	do_div(utime, NSEC_PER_USEC);
>   	do_div(stime, NSEC_PER_USEC);
> -#ifdef CONFIG_SCHED_CORE
> -	do_div(forceidle_time, NSEC_PER_USEC);
> -#endif
>   
>   	seq_printf(seq, "usage_usec %llu\n"
>   		   "user_usec %llu\n"
>   		   "system_usec %llu\n",
>   		   usage, utime, stime);
>   
> -#ifdef CONFIG_SCHED_CORE
> -	seq_printf(seq, "core_sched.force_idle_usec %llu\n", forceidle_time);
> -#endif
> +	cgroup_force_idle_show(seq, &cgrp->bstat);
>   }
>   
>   /* Add bpf kfuncs for cgroup_rstat_updated() and cgroup_rstat_flush() */


