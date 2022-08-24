Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B139159F0C1
	for <lists+cgroups@lfdr.de>; Wed, 24 Aug 2022 03:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbiHXBTz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Aug 2022 21:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiHXBTz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Aug 2022 21:19:55 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D751D4BD28;
        Tue, 23 Aug 2022 18:19:53 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MC7Wt13MXz6S2XJ;
        Wed, 24 Aug 2022 09:18:18 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgAH8r23fAVjzNAPAw--.10560S3;
        Wed, 24 Aug 2022 09:19:52 +0800 (CST)
Subject: Re: [PATCH 4/4] blk-throttle: cleanup throtl_dequeue_tg()
To:     Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20220823013810.406075-1-yukuai1@huaweicloud.com>
 <20220823013810.406075-5-yukuai1@huaweicloud.com>
 <YwUdouGld9Z7K8r1@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <dd9b7a59-a16a-74f5-011c-664ca91e8ada@huaweicloud.com>
Date:   Wed, 24 Aug 2022 09:19:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YwUdouGld9Z7K8r1@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAH8r23fAVjzNAPAw--.10560S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4DXr1kWw13Ww45Ar1fJFb_yoW8AFyrpF
        y5A3WrCF42qr4qkr1Yq3ZrXFWSvws7JF4rAws7J3WSyr42vry3KFn7ZFyrXaykZFZ7XrWr
        ZF4Dtwn5A3WUZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF9a9DU
        UUU
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

ÔÚ 2022/08/24 2:34, Tejun Heo Ð´µÀ:
> On Tue, Aug 23, 2022 at 09:38:10AM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Now that throtl_dequeue_tg() is called when the last bio is dispatched,
>> there is no need to check the flag THROTL_TG_PENDING, since it's ensured
>> to be set when bio is throttled.
>>
>> There are no functional changes.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/blk-throttle.c | 11 ++++-------
>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>> index 47142a1dd102..e47506a8ef47 100644
>> --- a/block/blk-throttle.c
>> +++ b/block/blk-throttle.c
>> @@ -570,14 +570,11 @@ static void throtl_enqueue_tg(struct throtl_grp *tg)
>>   
>>   static void throtl_dequeue_tg(struct throtl_grp *tg)
>>   {
>> -	if (tg->flags & THROTL_TG_PENDING) {
>> -		struct throtl_service_queue *parent_sq =
>> -			tg->service_queue.parent_sq;
>> +	struct throtl_service_queue *parent_sq = tg->service_queue.parent_sq;
>>   
>> -		throtl_rb_erase(&tg->rb_node, parent_sq);
>> -		--parent_sq->nr_pending;
>> -		tg->flags &= ~THROTL_TG_PENDING;
>> -	}
>> +	throtl_rb_erase(&tg->rb_node, parent_sq);
>> +	--parent_sq->nr_pending;
>> +	tg->flags &= ~THROTL_TG_PENDING;
> 
> Yeah, I don't know about this one. This breaks the symmetry with
> throtl_enqueue_tg() and it's a bit odd that we aren't at least
> WARN_ON_ONCE() on the flag given what the flag tracks. If you want to do
> this, I think the prev approach of just removing the flag is better as that
> was symmetric at least.

Yes, you are right, thanks for the advice. Since now it's a bit
ambivalent, we might as well just remove this patch?

Thanks,
Kuai
> 
> Thanks.
> 

