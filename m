Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530614ACFEC
	for <lists+cgroups@lfdr.de>; Tue,  8 Feb 2022 04:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346571AbiBHDy1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Feb 2022 22:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346495AbiBHDy0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Feb 2022 22:54:26 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DC6C0401DC;
        Mon,  7 Feb 2022 19:54:25 -0800 (PST)
Received: from kwepemi500001.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jt8Hm2XxRzcclR;
        Tue,  8 Feb 2022 11:53:24 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500001.china.huawei.com (7.221.188.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 11:54:24 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 11:54:23 +0800
Subject: Re: [PATCH v7 1/2] blk-throtl: introduce a new flag
 THROTL_TG_CANCELING
To:     Ming Lei <ming.lei@redhat.com>
CC:     <tj@kernel.org>, <axboe@kernel.dk>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220128084522.3169961-1-yukuai3@huawei.com>
 <20220128084522.3169961-2-yukuai3@huawei.com> <YgDVCjkjJe1CSVxv@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <6167d87a-bb4a-5323-9918-8ff46126ed13@huawei.com>
Date:   Tue, 8 Feb 2022 11:54:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YgDVCjkjJe1CSVxv@T590>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

ÔÚ 2022/02/07 16:15, Ming Lei Ð´µÀ:
> On Fri, Jan 28, 2022 at 04:45:21PM +0800, Yu Kuai wrote:
>> If the new flag is set, then the throtl_grp will stop throttling bios.
>> Prepare to canceling all throttled bios if the disk is gone.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/blk-throttle.c | 17 +++++++++++++----
>>   1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>> index 7c462c006b26..abc5e506c72d 100644
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
> 
> The above change and the following one in tg_update_disptime() isn't
> needed actually.
> 
> Also I'd suggest to fold the two into one patch.

Ok, I'll fold the two in next version.

Thanks,
Kuai
> 
> 
> Thanks,
> Ming
> 
> .
> 
