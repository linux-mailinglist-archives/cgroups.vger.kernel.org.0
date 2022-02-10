Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01B84B0C6C
	for <lists+cgroups@lfdr.de>; Thu, 10 Feb 2022 12:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239612AbiBJLdq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Feb 2022 06:33:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbiBJLdo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Feb 2022 06:33:44 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9101001;
        Thu, 10 Feb 2022 03:33:42 -0800 (PST)
Received: from kwepemi100003.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JvZLB4dS2z5HpD;
        Thu, 10 Feb 2022 19:30:26 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100003.china.huawei.com (7.221.188.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 19:33:39 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 19:33:38 +0800
Subject: Re: [PATCH v8] block: cancel all throttled bios in del_gendisk()
To:     Ming Lei <ming.lei@redhat.com>
CC:     <tj@kernel.org>, <axboe@kernel.dk>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220208113808.1401601-1-yukuai3@huawei.com>
 <YgMbaqTD+ycFPAtM@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <148a020b-5609-1a3c-cfd9-d02abd26ff67@huawei.com>
Date:   Thu, 10 Feb 2022 19:33:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YgMbaqTD+ycFPAtM@T590>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ÔÚ 2022/02/09 9:39, Ming Lei Ð´µÀ:
> On Tue, Feb 08, 2022 at 07:38:08PM +0800, Yu Kuai wrote:
>> Throttled bios can't be issued after del_gendisk() is done, thus
>> it's better to cancel them immediately rather than waiting for
>> throttle is done.
>>
>> For example, if user thread is throttled with low bps while it's
>> issuing large io, and the device is deleted. The user thread will
>> wait for a long time for io to return.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>> Changes in v8:
>>   - fold two patches into one
>> Changes in v7:
>>   - use the new solution as suggested by Ming.
>>
>>   block/blk-throttle.c | 49 ++++++++++++++++++++++++++++++++++++++++----
>>   block/blk-throttle.h |  2 ++
>>   block/genhd.c        |  2 ++
>>   3 files changed, 49 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>> index 7c462c006b26..557d20796157 100644
>> --- a/block/blk-throttle.c
>> +++ b/block/blk-throttle.c
>> @@ -43,8 +43,12 @@
>>   static struct workqueue_struct *kthrotld_workqueue;
>>   
>>   enum tg_state_flags {
>> -	THROTL_TG_PENDING	= 1 << 0,	/* on parent's pending tree */
>> -	THROTL_TG_WAS_EMPTY	= 1 << 1,	/* bio_lists[] became non-empty */
>> +	/* on parent's pending tree */
>> +	THROTL_TG_PENDING	= 1 << 0,
>> +	/* bio_lists[] became non-empty */
>> +	THROTL_TG_WAS_EMPTY	= 1 << 1,
>> +	/* starts to cancel all bios, will be set if the disk is deleted */
>> +	THROTL_TG_CANCELING	= 1 << 2,
>>   };
>>   
>>   #define rb_entry_tg(node)	rb_entry((node), struct throtl_grp, rb_node)
>> @@ -871,7 +875,8 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
>>   	       bio != throtl_peek_queued(&tg->service_queue.queued[rw]));
>>   
>>   	/* If tg->bps = -1, then BW is unlimited */
>> -	if (bps_limit == U64_MAX && iops_limit == UINT_MAX) {
>> +	if ((bps_limit == U64_MAX && iops_limit == UINT_MAX) ||
>> +	    tg->flags & THROTL_TG_CANCELING) {
>>   		if (wait)
>>   			*wait = 0;
>>   		return true;
>> @@ -974,6 +979,9 @@ static void tg_update_disptime(struct throtl_grp *tg)
>>   	unsigned long read_wait = -1, write_wait = -1, min_wait = -1, disptime;
>>   	struct bio *bio;
>>   
>> +	if (tg->flags & THROTL_TG_CANCELING)
>> +		goto update;
>> +
>>   	bio = throtl_peek_queued(&sq->queued[READ]);
>>   	if (bio)
>>   		tg_may_dispatch(tg, bio, &read_wait);
>> @@ -983,9 +991,10 @@ static void tg_update_disptime(struct throtl_grp *tg)
>>   		tg_may_dispatch(tg, bio, &write_wait);
>>   
>>   	min_wait = min(read_wait, write_wait);
>> -	disptime = jiffies + min_wait;
>>   
>> +update:
>>   	/* Update dispatch time */
>> +	disptime = jiffies + min_wait;
> 
> As I mentioned on V7, the change in tg_update_disptime() isn't needed, please
> drop it.

Hi,
After dropping it, disptime will set to jiffies instead of
jiffies -1, this is fine since time_before() won't pass in
throtl_select_dispatch(). I'll drop it in v9...
> 
>>   	throtl_dequeue_tg(tg);
>>   	tg->disptime = disptime;
>>   	throtl_enqueue_tg(tg);
>> @@ -1763,6 +1772,38 @@ static bool throtl_hierarchy_can_upgrade(struct throtl_grp *tg)
>>   	return false;
>>   }
>>   
>> +void blk_throtl_cancel_bios(struct request_queue *q)
>> +{
>> +	struct cgroup_subsys_state *pos_css;
>> +	struct blkcg_gq *blkg;
>> +
>> +	spin_lock_irq(&q->queue_lock);
>> +	/*
>> +	 * queue_lock is held, rcu lock is not needed here technically.
>> +	 * However, rcu lock is still held to emphasize that following
>> +	 * path need RCU protection and to prevent warning from lockdep.
>> +	 */
>> +	rcu_read_lock();
>> +	blkg_for_each_descendant_post(blkg, pos_css, q->root_blkg) {
>> +		struct throtl_grp *tg = blkg_to_tg(blkg);
>> +		struct throtl_service_queue *sq = &tg->service_queue;
>> +
>> +		/*
>> +		 * Set disptime in the past to make sure
>> +		 * throtl_select_dispatch() won't exit without dispatching.
>> +		 */
>> +		tg->disptime = jiffies - 1;
> 
> It might be better to replace the above line with tg_update_disptime().

Ok, I'll replace it and setting the flag first.

Thanks,
Kuai
> 
> Otherwise, the patch looks good.
> 
> Thanks,
> Ming
> 
> .
> 
