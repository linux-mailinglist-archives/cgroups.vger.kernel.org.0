Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173B6446D21
	for <lists+cgroups@lfdr.de>; Sat,  6 Nov 2021 10:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbhKFJPq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 6 Nov 2021 05:15:46 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15365 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbhKFJPn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 6 Nov 2021 05:15:43 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HmWqc0llKz90Jk;
        Sat,  6 Nov 2021 17:12:44 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Sat, 6 Nov 2021 17:12:55 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Sat, 6 Nov 2021 17:12:54 +0800
Subject: Re: [PATCH] blk-cgroup: fix missing put device in error path from
 blkg_conf_pref()
To:     <tj@kernel.org>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20211102020705.2321858-1-yukuai3@huawei.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <1677130b-ca7c-00ce-a47e-86adf90d8229@huawei.com>
Date:   Sat, 6 Nov 2021 17:12:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20211102020705.2321858-1-yukuai3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021/11/02 10:07, Yu Kuai wrote:
friendly ping...
> If blk_queue_enter() failed due to queue is dying, the
> blkdev_put_no_open() is needed because blkcg_conf_open_bdev() succeeded.
> 
> Fixes: 0c9d338c8443 ("blk-cgroup: synchronize blkg creation against policy deactivation")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   block/blk-cgroup.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 88b1fce90520..663aabfeba18 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -640,7 +640,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
>   	 */
>   	ret = blk_queue_enter(q, 0);
>   	if (ret)
> -		return ret;
> +		goto fail;
>   
>   	rcu_read_lock();
>   	spin_lock_irq(&q->queue_lock);
> @@ -676,13 +676,13 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
>   		new_blkg = blkg_alloc(pos, q, GFP_KERNEL);
>   		if (unlikely(!new_blkg)) {
>   			ret = -ENOMEM;
> -			goto fail;
> +			goto fail_exit_queue;
>   		}
>   
>   		if (radix_tree_preload(GFP_KERNEL)) {
>   			blkg_free(new_blkg);
>   			ret = -ENOMEM;
> -			goto fail;
> +			goto fail_exit_queue;
>   		}
>   
>   		rcu_read_lock();
> @@ -722,9 +722,10 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
>   fail_unlock:
>   	spin_unlock_irq(&q->queue_lock);
>   	rcu_read_unlock();
> +fail_exit_queue:
> +	blk_queue_exit(q);
>   fail:
>   	blkdev_put_no_open(bdev);
> -	blk_queue_exit(q);
>   	/*
>   	 * If queue was bypassing, we should retry.  Do so after a
>   	 * short msleep().  It isn't strictly necessary but queue
> 
