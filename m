Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3962F52B255
	for <lists+cgroups@lfdr.de>; Wed, 18 May 2022 08:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiERGaR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 May 2022 02:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiERGaQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 May 2022 02:30:16 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7ADE275C;
        Tue, 17 May 2022 23:30:11 -0700 (PDT)
Received: from kwepemi100002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L333N0GzHz1JCJy;
        Wed, 18 May 2022 14:28:48 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100002.china.huawei.com (7.221.188.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 14:30:09 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 14:30:08 +0800
Subject: Re: [PATCH -next] blk-throttle: delay the setting of 'BIO_THROTTLED'
 to when throttle is done
To:     Ming Lei <ming.lei@redhat.com>
CC:     <tj@kernel.org>, <axboe@kernel.dk>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220517134909.2910251-1-yukuai3@huawei.com>
 <YoRw8J1Y/bzxVsSR@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <73e8bdef-0f80-d255-e4f2-170813a12f5f@huawei.com>
Date:   Wed, 18 May 2022 14:30:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YoRw8J1Y/bzxVsSR@T590>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ÔÚ 2022/05/18 12:07, Ming Lei Ð´µÀ:
> On Tue, May 17, 2022 at 09:49:09PM +0800, Yu Kuai wrote:
>> commit 9f5ede3c01f9 ("block: throttle split bio in case of iops limit")
>> introduce a new problem, for example:
>>
>> [root@localhost ~]# echo "8:0 1024" > /sys/fs/cgroup/blkio/blkio.throttle.write_bps_device
>> [root@localhost ~]# echo $$ > /sys/fs/cgroup/blkio/cgroup.procs
>> [root@localhost ~]# dd if=/dev/zero of=/dev/sda bs=10k count=1 oflag=direct &
>> [1] 620
>> [root@localhost ~]# dd if=/dev/zero of=/dev/sda bs=10k count=1 oflag=direct &
>> [2] 626
>> [root@localhost ~]# 1+0 records in
>> 1+0 records out
>> 10240 bytes (10 kB, 10 KiB) copied, 10.0038 s, 1.0 kB/s1+0 records in
>> 1+0 records out
>>
>> 10240 bytes (10 kB, 10 KiB) copied, 9.23076 s, 1.1 kB/s
>> -> the second bio is issued after 10s instead of 20s.
>>
>> This is because if some bios are already queued, current bio is queued
>> directly and the flag 'BIO_THROTTLED' is set. And later, when former
>> bios are dispatched, this bio will be dispatched without waiting at all,
>> this is due to tg_with_in_bps_limit() will return 0 if the flag is set.
>>
>> Instead of setting the flag when bio starts throttle, delay to when
>> throttle is done to fix the problem.
>>
>> Fixes: 9f5ede3c01f9 ("block: throttle split bio in case of iops limit")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/blk-throttle.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>> index 447e1b8722f7..f952f2d942ff 100644
>> --- a/block/blk-throttle.c
>> +++ b/block/blk-throttle.c
>> @@ -811,7 +811,7 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
>>   	unsigned int bio_size = throtl_bio_data_size(bio);
>>   
>>   	/* no need to throttle if this bio's bytes have been accounted */
>> -	if (bps_limit == U64_MAX || bio_flagged(bio, BIO_THROTTLED)) {
>> +	if (bps_limit == U64_MAX) {
> 
> This way may double account bio size for re-entered split bio.
Hi, Ming

Yes, you are right, I forgot that...
> 
> 
>>   		if (wait)
>>   			*wait = 0;
>>   		return true;
>> @@ -1226,8 +1226,10 @@ static void blk_throtl_dispatch_work_fn(struct work_struct *work)
>>   
>>   	spin_lock_irq(&q->queue_lock);
>>   	for (rw = READ; rw <= WRITE; rw++)
>> -		while ((bio = throtl_pop_queued(&td_sq->queued[rw], NULL)))
>> +		while ((bio = throtl_pop_queued(&td_sq->queued[rw], NULL))) {
>> +			bio_set_flag(bio, BIO_THROTTLED);
>>   			bio_list_add(&bio_list_on_stack, bio);
>> +		}
>>   	spin_unlock_irq(&q->queue_lock);
>>   
>>   	if (!bio_list_empty(&bio_list_on_stack)) {
>> @@ -2134,7 +2136,8 @@ bool __blk_throtl_bio(struct bio *bio)
>>   			}
>>   			break;
>>   		}
>> -
>> +		/* this bio will be issued directly */
>> +		bio_set_flag(bio, BIO_THROTTLED);
>>   		/* within limits, let's charge and dispatch directly */
>>   		throtl_charge_bio(tg, bio);
> 
> Marking BIO_THROTTLED before throtle_charge_bio() causes the bio
> bytes not be charged.
Yes, thanks for spotting this.
> 
> Another simple way is to compensate for previous extra bytes accounting,
> something like the following patch:
> 
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 139b2d7a99e2..44773d2ba257 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -810,8 +810,7 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
>   	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
>   	unsigned int bio_size = throtl_bio_data_size(bio);
>   
> -	/* no need to throttle if this bio's bytes have been accounted */
> -	if (bps_limit == U64_MAX || bio_flagged(bio, BIO_THROTTLED)) {
> +	if (bps_limit == U64_MAX) {
>   		if (wait)
>   			*wait = 0;
>   		return true;
> @@ -921,10 +920,8 @@ static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
>   	unsigned int bio_size = throtl_bio_data_size(bio);
>   
>   	/* Charge the bio to the group */
> -	if (!bio_flagged(bio, BIO_THROTTLED)) {
> -		tg->bytes_disp[rw] += bio_size;
> -		tg->last_bytes_disp[rw] += bio_size;
> -	}
> +	tg->bytes_disp[rw] += bio_size;
> +	tg->last_bytes_disp[rw] += bio_size;
>   
>   	tg->io_disp[rw]++;
>   	tg->last_io_disp[rw]++;
> @@ -2125,6 +2122,20 @@ bool __blk_throtl_bio(struct bio *bio)
>   		if (sq->nr_queued[rw])
>   			break;
>   
> +		/*
> +		 * re-entered bio has accounted bytes already, so try to
> +		 * compensate previous over-accounting. However, if new
> +		 * slice is started, just forget it
> +		 */
> +		if (bio_flagged(bio, BIO_THROTTLED)) {
> +			unsigned int bio_size = throtl_bio_data_size(bio);
> +
> +			if (tg->bytes_disp[rw] >= bio_size)
> +				tg->bytes_disp[rw] -= bio_size;
> +			if (tg->last_bytes_disp[rw] - bio_size)
> +				tg->last_bytes_disp[rw] -= bio_size;
> +		}
> +
If new slice is not started, then this should fix the problem.
 From what I can see, other than tg_conf_updated, new silce can start if
there are still bio throttled:

tg_may_dispatch
  if (!(tg->service_queue.nr_queued[rw]))
   throtl_start_new_slice

Thus I think the change is ok. For the case in tg_conf_updated, I'll
remove the throtl_start_new_slice() to fix a hung problem. I'll add this
patch with this one in next version.

Thanks,
Kuai

>   		/* if above limits, break to queue */
>   		if (!tg_may_dispatch(tg, bio, NULL)) {
>   			tg->last_low_overflow_time[rw] = jiffies;
> 
> Thanks,
> Ming
> 
> .
> 
