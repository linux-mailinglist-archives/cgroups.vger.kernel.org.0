Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB03306BCD
	for <lists+cgroups@lfdr.de>; Thu, 28 Jan 2021 05:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhA1EDl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Jan 2021 23:03:41 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:50150 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229591AbhA1EBd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Jan 2021 23:01:33 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UN5n-0H_1611805764;
Received: from 30.21.164.7(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UN5n-0H_1611805764)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 Jan 2021 11:49:24 +0800
Subject: Re: [PATCH v2] blk-cgroup: Use cond_resched() when destroy blkgs
To:     Jens Axboe <axboe@kernel.dk>, tj@kernel.org
Cc:     joseph.qi@linux.alibaba.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <8e8a0c4644d5eb01b7f79ec9b67c2b240f4a6434.1611798287.git.baolin.wang@linux.alibaba.com>
 <3f3c12de-b5fb-a9ad-9324-55f5bf9d7453@kernel.dk>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <f58ce890-d54c-e4a7-d379-ad4ad4ae20de@linux.alibaba.com>
Date:   Thu, 28 Jan 2021 11:49:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <3f3c12de-b5fb-a9ad-9324-55f5bf9d7453@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2021/1/28 11:41, Jens Axboe 写道:
> On 1/27/21 8:22 PM, Baolin Wang wrote:
>> On !PREEMPT kernel, we can get below softlockup when doing stress
>> testing with creating and destroying block cgroup repeatly. The
>> reason is it may take a long time to acquire the queue's lock in
>> the loop of blkcg_destroy_blkgs(), or the system can accumulate a
>> huge number of blkgs in pathological cases. We can add a need_resched()
>> check on each loop and release locks and do cond_resched() if true
>> to avoid this issue, since the blkcg_destroy_blkgs() is not called
>> from atomic contexts.
>>
>> [ 4757.010308] watchdog: BUG: soft lockup - CPU#11 stuck for 94s!
>> [ 4757.010698] Call trace:
>> [ 4757.010700]  blkcg_destroy_blkgs+0x68/0x150
>> [ 4757.010701]  cgwb_release_workfn+0x104/0x158
>> [ 4757.010702]  process_one_work+0x1bc/0x3f0
>> [ 4757.010704]  worker_thread+0x164/0x468
>> [ 4757.010705]  kthread+0x108/0x138
> 
> Kind of ugly with the two clauses for dropping the blkcg lock, one
> being a cpu_relax() and the other a resched. How about something
> like this:
> 
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 031114d454a6..4221a1539391 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1016,6 +1016,8 @@ static void blkcg_css_offline(struct cgroup_subsys_state *css)
>    */
>   void blkcg_destroy_blkgs(struct blkcg *blkcg)
>   {
> +	might_sleep();
> +
>   	spin_lock_irq(&blkcg->lock);
>   
>   	while (!hlist_empty(&blkcg->blkg_list)) {
> @@ -1023,14 +1025,20 @@ void blkcg_destroy_blkgs(struct blkcg *blkcg)
>   						struct blkcg_gq, blkcg_node);
>   		struct request_queue *q = blkg->q;
>   
> -		if (spin_trylock(&q->queue_lock)) {
> -			blkg_destroy(blkg);
> -			spin_unlock(&q->queue_lock);
> -		} else {
> +		if (need_resched() || !spin_trylock(&q->queue_lock)) {
> +			/*
> +			 * Given that the system can accumulate a huge number
> +			 * of blkgs in pathological cases, check to see if we
> +			 * need to rescheduling to avoid softlockup.
> +			 */
>   			spin_unlock_irq(&blkcg->lock);
> -			cpu_relax();
> +			cond_resched();
>   			spin_lock_irq(&blkcg->lock);
> +			continue;
>   		}
> +
> +		blkg_destroy(blkg);
> +		spin_unlock(&q->queue_lock);
>   	}
>   
>   	spin_unlock_irq(&blkcg->lock);
> 

Looks better to me. Do I need resend with your suggestion? Thanks.
