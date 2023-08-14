Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE39D77AF5B
	for <lists+cgroups@lfdr.de>; Mon, 14 Aug 2023 04:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjHNCCC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 13 Aug 2023 22:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjHNCBl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 13 Aug 2023 22:01:41 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FC810D1;
        Sun, 13 Aug 2023 19:01:27 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RPHgh6fkCz4f3kFt;
        Mon, 14 Aug 2023 10:01:20 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAH5Kbyitlkc4GkAg--.41869S3;
        Mon, 14 Aug 2023 10:01:23 +0800 (CST)
Subject: Re: [PATCH 1/1] blk-throttle: fix throttle configuring not effective
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        zhuxiaohui <zhuxiaohui400@gmail.com>, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, zhuxiaohui <zhuxiaohui.400@bytedance.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230812072116.42321-1-zhuxiaohui.400@bytedance.com>
 <5ba76f5e-9b02-13c8-c2a3-b15fe016261d@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d69f850a-ecfc-61dc-a970-64f57fff806f@huaweicloud.com>
Date:   Mon, 14 Aug 2023 10:01:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5ba76f5e-9b02-13c8-c2a3-b15fe016261d@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAH5Kbyitlkc4GkAg--.41869S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWfJry3try7Gry8Jw1DJrb_yoWrJF1rpF
        y8trs8GrWYqFn3G3W3J3W5Ja45Xw48J348JrWIqFy5AF17Cr90gryUXrnY9348Ars7GF48
        tw1jqr9rZF47urDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

+CC Michal.

在 2023/08/12 15:53, Yu Kuai 写道:
> Hi,
> 
> 在 2023/08/12 15:21, zhuxiaohui 写道:
>> when updating block throttle limit with persistence and stable io
>> pressure, especially a relative high io pressure, fio test e.g.,
>> there may never be a change to start a new slice, and carryover_ios &
>> carryover_bytes will not be cleared.
>>
>> As a result, when reconfiguring block throttle limit, we can notice that
>> the actual iops and throughput is a random value far away from what is
>> set
>>
>> So we need to update carryover value when dispatching bio
> 
> I don't understand, not clear carryover_bytes/ios is what expected, and
> how can they affect actual bandwith/iops.
> 
> Can you give a example how you tested and why current calculation is not
> correct?

I can reporduce this, but this patch is obviously wrong. You must
explaim how the calculation is not correct.

After a quick loock, I found that carryover_bytes/ios is not updated in
throtl_trim_slice(), while tg->io/bytes_disp[] can be cleared. This is
definitly a problem.

Thanks,
Kuai

> 
> Thanks,
> Kuai
> 
>>
>> Signed-off-by: zhuxiaohui <zhuxiaohui.400@bytedance.com>
>> ---
>>   block/blk-throttle.c | 26 ++++++++++++++++++++++++++
>>   block/blk-throttle.h |  4 ++--
>>   2 files changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>> index 7397ff199d66..13c9d87a7201 100644
>> --- a/block/blk-throttle.c
>> +++ b/block/blk-throttle.c
>> @@ -821,6 +821,30 @@ static void tg_update_carryover(struct throtl_grp 
>> *tg)
>>              tg->carryover_ios[READ], tg->carryover_ios[WRITE]);
>>   }
>> +static void tg_charge_carryover(struct throtl_grp *tg, struct bio *bio)
>> +{
>> +    bool rw = bio_data_dir(bio);
>> +
>> +    if (unlikely(tg->carryover_bytes[rw])) {
>> +        unsigned int bio_size = throtl_bio_data_size(bio);
>> +        unsigned int carryout_size = abs(tg->carryover_bytes[rw]);
>> +
>> +        carryout_size = min(carryout_size, bio_size);
>> +
>> +        if (tg->carryover_bytes[rw] < 0)
>> +            tg->carryover_bytes[rw] += carryout_size;
>> +        else
>> +            tg->carryover_bytes[rw] -= carryout_size;
>> +    }
>> +
>> +    if (unlikely(tg->carryover_ios[rw])) {
>> +        if (tg->carryover_ios[rw] < 0)
>> +            tg->carryover_ios[rw] += 1;
>> +        else
>> +            tg->carryover_ios[rw] -= 1;
>> +    }
>> +}
>> +
>>   static unsigned long tg_within_iops_limit(struct throtl_grp *tg, 
>> struct bio *bio,
>>                    u32 iops_limit)
>>   {
>> @@ -965,6 +989,8 @@ static void throtl_charge_bio(struct throtl_grp 
>> *tg, struct bio *bio)
>>       tg->io_disp[rw]++;
>>       tg->last_io_disp[rw]++;
>> +
>> +    tg_charge_carryover(tg, bio);
>>   }
>>   /**
>> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
>> index d1ccbfe9f797..8f1642becb23 100644
>> --- a/block/blk-throttle.h
>> +++ b/block/blk-throttle.h
>> @@ -127,8 +127,8 @@ struct throtl_grp {
>>        * bytes/ios are waited already in previous configuration, and 
>> they will
>>        * be used to calculate wait time under new configuration.
>>        */
>> -    uint64_t carryover_bytes[2];
>> -    unsigned int carryover_ios[2];
>> +    int64_t carryover_bytes[2];
>> +    int carryover_ios[2];
>>       unsigned long last_check_time;
>>
> 
> .
> 

