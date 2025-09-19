Return-Path: <cgroups+bounces-10290-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC534B88C6F
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 12:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5E324E17DE
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 10:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0722F2F90C9;
	Fri, 19 Sep 2025 10:12:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AD72F83D4;
	Fri, 19 Sep 2025 10:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758276775; cv=none; b=oXdxofxNaXSXZ1CIMyK25u7H6B6YArHjxjJoT46p1RnrUPInsJezybcYoQVUHr9hnzz3tISrbZVh7/sO6PxaGjU/K9kdtZABaWptbfivUISQS1EhvdA1vI/8X0oiAYbzeqLNi66dV7vcf4a1vQKmrq+6DNf9letfmG1cKtHeNss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758276775; c=relaxed/simple;
	bh=DpVf1E3TlPIgbPaFmqA3BKJ1WR4N7v+UZAJNZWpRinE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qXXmIyTdYYAxQ39sxpXLJC56GBsYbXliyr0FkJFZ204jkCgC1jLPoYLsGm+vaaXG0vVR5kM36q9FUCNOISmZgDh1sVAeGnPW1jiry0LDoVQTzQp2QA88gQyts29sVZtrGPR3yemEz0WKp3a8AOeGB/325vNdMUzTcN8CdCUhNQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cSpGp53fQzKHN5s;
	Fri, 19 Sep 2025 18:12:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 90D0D1A197B;
	Fri, 19 Sep 2025 18:12:51 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgBHDGSiLM1oJgZqAA--.21459S2;
	Fri, 19 Sep 2025 18:12:51 +0800 (CST)
Message-ID: <eefa4f64-a2b2-47f4-8eb6-940f90eca850@huaweicloud.com>
Date: Fri, 19 Sep 2025 18:12:49 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH cgroup/for-next] cpuset: fix missing error return in
 update_cpumask
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250917060454.2885698-9-chenridong@huaweicloud.com>
 <20250919094903.3060470-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250919094903.3060470-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHDGSiLM1oJgZqAA--.21459S2
X-Coremail-Antispam: 1UD129KBjvJXoWrtw1kuw1DKr4fJr4kKw4Durg_yoW8JrWkpF
	Wkua4UAay5Gryjk39xZ39rZFWUK3WUZw48tFn3X3WxC34IgFnFkF1DX3sxJFy3ZF1fCr4x
	Xan0vrsFvrWjy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/9/19 17:49, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The commit c6366739804f ("cpuset: refactor cpus_allowed_validate_change")
> inadvertently removed the error return when cpus_allowed_validate_change()
> fails. This patch restores the proper error handling by returning retval
> when the validation check fails.
> 
> Fixes: c6366739804f ("cpuset: refactor cpus_allowed_validate_change")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  kernel/cgroup/cpuset.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 506a7178f0b3..20dface3c3e0 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2515,7 +2515,8 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>  	compute_trialcs_excpus(trialcs, cs);
>  	trialcs->prs_err = PERR_NONE;
>  
> -	if (cpus_allowed_validate_change(cs, trialcs, &tmp) < 0)
> +	retval = cpus_allowed_validate_change(cs, trialcs, &tmp);
> +	if (retval < 0)
>  		goto out_free;
>  
>  	/*

Hi Longman, TJ,

Sorry about the bug introduced in patch 8. Could you please apply this patch to fix the issue?

-- 
Best regards,
Ridong


