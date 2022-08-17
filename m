Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE4059668C
	for <lists+cgroups@lfdr.de>; Wed, 17 Aug 2022 03:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236922AbiHQBNp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 21:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiHQBNo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 21:13:44 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D47D2B604;
        Tue, 16 Aug 2022 18:13:42 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4M6qk41Nnxz6TDPS;
        Wed, 17 Aug 2022 09:12:12 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgB3fOnCQPxi9Iy7AQ--.34571S3;
        Wed, 17 Aug 2022 09:13:40 +0800 (CST)
Subject: Re: [PATCH v7 1/9] blk-throttle: fix that io throttle can only work
 for single bio
To:     Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     mkoutny@suse.com, axboe@kernel.dk, ming.lei@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20220802140415.2960284-1-yukuai1@huaweicloud.com>
 <20220802140415.2960284-2-yukuai1@huaweicloud.com>
 <Yvvx+/d2+OMROUOe@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <712e0f29-94ba-d3d3-ce21-cba4d6092008@huaweicloud.com>
Date:   Wed, 17 Aug 2022 09:13:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Yvvx+/d2+OMROUOe@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgB3fOnCQPxi9Iy7AQ--.34571S3
X-Coremail-Antispam: 1UD129KBjvJXoWxury3GFyrCry5WFy7Kw47CFg_yoWrXFW3pF
        yxWF95Gr4vqrn7KrnxJ3WaqF9avrWrAr98GFy5G3W5Arn8KrnIqr17ur4F9ayfuF95Cw40
        vr1vqF97Ca1UJFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCT
        nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Tejun

ÔÚ 2022/08/17 3:37, Tejun Heo Ð´µÀ:
> On Tue, Aug 02, 2022 at 10:04:07PM +0800, Yu Kuai wrote:
> ...
>> commit 9f5ede3c01f9 ("block: throttle split bio in case of iops limit")
>> support to count splited bios for iops limit, thus it adds flaged bio
>                                                               ^
>                                                               flagged
> 
>> checking in tg_with_in_bps_limit() so that splited bios will only count
>                                               ^
>                                               split
> 
>> once for bps limit, however, it introduce a new problem that io throttle
>> won't work if multiple bios are throttled.
>>
>> In order to fix the problem, at first, don't skip flaged bio in
>> tg_with_in_bps_limit(), however, this will break that splited bios should
>> only count once for bps limit. And this patch tries to avoid
>> over-accounting by decrementing it first in __blk_throtl_bio(), and
>> then counting it again while dispatching it.
>>
>> Fixes: 9f5ede3c01f9 ("block: throttle split bio in case of iops limit")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> 
> Please cc stable w/ version tag.
> 
>> ---
>>   block/blk-throttle.c | 26 ++++++++++++++++++++------
>>   1 file changed, 20 insertions(+), 6 deletions(-)
>>
>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>> index 9f5fe62afff9..2957e2c643f4 100644
>> --- a/block/blk-throttle.c
>> +++ b/block/blk-throttle.c
>> @@ -811,7 +811,7 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
>>   	unsigned int bio_size = throtl_bio_data_size(bio);
>>   
>>   	/* no need to throttle if this bio's bytes have been accounted */
>> -	if (bps_limit == U64_MAX || bio_flagged(bio, BIO_THROTTLED)) {
>> +	if (bps_limit == U64_MAX) {
>>   		if (wait)
>>   			*wait = 0;
>>   		return true;
>> @@ -921,11 +921,8 @@ static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
>>   	unsigned int bio_size = throtl_bio_data_size(bio);
>>   
>>   	/* Charge the bio to the group */
>> -	if (!bio_flagged(bio, BIO_THROTTLED)) {
>> -		tg->bytes_disp[rw] += bio_size;
>> -		tg->last_bytes_disp[rw] += bio_size;
>> -	}
>> -
>> +	tg->bytes_disp[rw] += bio_size;
>> +	tg->last_bytes_disp[rw] += bio_size;
>>   	tg->io_disp[rw]++;
>>   	tg->last_io_disp[rw]++;
>>   
>> @@ -2121,6 +2118,23 @@ bool __blk_throtl_bio(struct bio *bio)
>>   			tg->last_low_overflow_time[rw] = jiffies;
>>   		throtl_downgrade_check(tg);
>>   		throtl_upgrade_check(tg);
>> +
>> +		/*
>> +		 * Splited bios can be re-entered because iops limit should be
>                     ^                ^^^^^^^^^^^^^
>                     Split            re-enter
> 
>> +		 * counted again, however, bps limit should not. Since bps limit
>> +		 * will be counted again while dispatching it, compensate the
>> +		 * over-accounting here. Noted that compensation can fail if
>> +		 * new slice is started.
> 
> I can't really follow the comment. Please improve the explanation.
> 
>> +		 */
>> +		if (bio_flagged(bio, BIO_THROTTLED)) {
>> +			unsigned int bio_size = throtl_bio_data_size(bio);
>> +
>> +			if (tg->bytes_disp[rw] >= bio_size)
>> +				tg->bytes_disp[rw] -= bio_size;
>> +			if (tg->last_bytes_disp[rw] >= bio_size)
>> +				tg->last_bytes_disp[rw] -= bio_size;
>> +		}
> 
> So, as a fix for the immediate problem, I guess this might do but this feels
> really fragile. How can we be certain that re-entering only happens because
> of splitting? What if future core development changes that? It seems to be
> solving the problem in the wrong place. Shouldn't we flag the bio indicating
> that it's split when we're splitting the bio so that we only limit them for
> iops in the first place?
> 
Splited bio is tracked in __bio_clone:

if (bio_flagged(bio_src, BIO_THROTTLED))
	bio_set_flag(bio, BIO_THROTTLED);

And currenty, the iops limit and bps limit are treated differently,
however there are only one flag 'BIO_THROTTLED' and they can't be
distinguished.

Perhaps I can use two flags, for example BIO_IOPS_THROTTLED and
BIO_BPS_THROTTLED, this way only iops limit can be handled and bps
limit can be skipped for splited bio.

What do you think?

Thanks,
Kuai
> Thanks.
> 

