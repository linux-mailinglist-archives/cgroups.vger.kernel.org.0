Return-Path: <cgroups+bounces-6535-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2671EA33D77
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2025 12:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E25B161D5A
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2025 11:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420232144AF;
	Thu, 13 Feb 2025 11:08:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9492144A0;
	Thu, 13 Feb 2025 11:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444891; cv=none; b=mNaVQk6x/aCiwZimjDPxrFpT8oU+a4BAVQTBuNO2pHFpz0+qFNTL6Rac3TwT9SEhbJVliJ9bVDgWI7L4QH+aZnqYMhIFsBWtvQZfovql/jtlRgK3no25z3y83MOlotrFGP2/7zy0NU1v1VwHTASiBxjSpJ23wpIhIUxYlAdCTL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444891; c=relaxed/simple;
	bh=OG5B5PQ05uKmKSRdIZOTWyQ7mU/To8TRZjFZrsJMyPg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MFX7gFMb/7lLkBOy2Vumvy6R5luz2Oeewf0M4kw7c1f8LJwiKyHOVVAJ1oO7sHyTEY08U6F/9Ic7PKz7WsRwxzS91PuTBkAp3drb2Ku05fDcHT0Al+po2mYG5OHqR3fWtIuKsOLwRGyEicG9lPkQXoiY0ELUe+TOVFrg1HVHjw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ytspr0pwDz4f3jsy;
	Thu, 13 Feb 2025 19:07:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 31F321A092F;
	Thu, 13 Feb 2025 19:08:04 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCnCl+T0q1npo7oDg--.15155S3;
	Thu, 13 Feb 2025 19:08:04 +0800 (CST)
Subject: Re: [PATCH v2] blk-cgroup: improve policy registration error handling
To: Chen Linxuan <chenlinxuan@uniontech.com>, Tejun Heo <tj@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc: Wen Tao <wentao@uniontech.com>, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <D8F5396BD45124E9+20250213033545.993799-2-chenlinxuan@uniontech.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <89cadf52-236f-1e0b-cff8-dcff16296e62@huaweicloud.com>
Date: Thu, 13 Feb 2025 19:08:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <D8F5396BD45124E9+20250213033545.993799-2-chenlinxuan@uniontech.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnCl+T0q1npo7oDg--.15155S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1kXFW5JFW5tw45AF18Zrb_yoW5Jw4UpF
	W3K3sxCryktF1xuFsxK3WUtF1rJanYqw4UG345X3WSyr4IyrZ5Kw1jy3WkXFWxurn7JF45
	tFZ0qay0kF1Ut37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOB
	MKDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/02/13 11:35, Chen Linxuan Ð´µÀ:
> This patch improve the returned error code of blkcg_policy_register().
> 
> 1. Move the validation check for cpd/pd_alloc_fn and cpd/pd_free_fn
>     function pairs to the start of blkcg_policy_register(). This ensures
>     we immediately return -EINVAL if the function pairs are not correctly
>     provided, rather than returning -ENOSPC after locking and unlocking
>     mutexes unnecessarily.
> 
>     Those locks should not contention any problems, as error of policy
>     registration is a super cold path.
> 
> 2. Return -ENOMEM when cpd_alloc_fn() failed.
> 
> Co-authored-by: Wen Tao <wentao@uniontech.com>
> Signed-off-by: Wen Tao <wentao@uniontech.com>
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> ---
> 
> v1->v2: Also change the return value to -ENOMEM from error path err_free_cpds
> 
> ---
>   block/blk-cgroup.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
>
LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 9ed93d91d754..2609f7294427 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1727,27 +1727,27 @@ int blkcg_policy_register(struct blkcg_policy *pol)
>   	struct blkcg *blkcg;
>   	int i, ret;
>   
> +	/*
> +	 * Make sure cpd/pd_alloc_fn and cpd/pd_free_fn in pairs, and policy
> +	 * without pd_alloc_fn/pd_free_fn can't be activated.
> +	 */
> +	if ((!pol->cpd_alloc_fn ^ !pol->cpd_free_fn) ||
> +	    (!pol->pd_alloc_fn ^ !pol->pd_free_fn))
> +		return -EINVAL;
> +
>   	mutex_lock(&blkcg_pol_register_mutex);
>   	mutex_lock(&blkcg_pol_mutex);
>   
>   	/* find an empty slot */
> -	ret = -ENOSPC;
>   	for (i = 0; i < BLKCG_MAX_POLS; i++)
>   		if (!blkcg_policy[i])
>   			break;
>   	if (i >= BLKCG_MAX_POLS) {
>   		pr_warn("blkcg_policy_register: BLKCG_MAX_POLS too small\n");
> +		ret = -ENOSPC;
>   		goto err_unlock;
>   	}
>   
> -	/*
> -	 * Make sure cpd/pd_alloc_fn and cpd/pd_free_fn in pairs, and policy
> -	 * without pd_alloc_fn/pd_free_fn can't be activated.
> -	 */
> -	if ((!pol->cpd_alloc_fn ^ !pol->cpd_free_fn) ||
> -	    (!pol->pd_alloc_fn ^ !pol->pd_free_fn))
> -		goto err_unlock;
> -
>   	/* register @pol */
>   	pol->plid = i;
>   	blkcg_policy[pol->plid] = pol;
> @@ -1758,8 +1758,10 @@ int blkcg_policy_register(struct blkcg_policy *pol)
>   			struct blkcg_policy_data *cpd;
>   
>   			cpd = pol->cpd_alloc_fn(GFP_KERNEL);
> -			if (!cpd)
> +			if (!cpd) {
> +				ret = -ENOMEM;
>   				goto err_free_cpds;
> +			}
>   
>   			blkcg->cpd[pol->plid] = cpd;
>   			cpd->blkcg = blkcg;
> 


