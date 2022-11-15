Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EA1628F0B
	for <lists+cgroups@lfdr.de>; Tue, 15 Nov 2022 02:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiKOBRC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Nov 2022 20:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiKOBRA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Nov 2022 20:17:00 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932A512ADC;
        Mon, 14 Nov 2022 17:16:57 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NB7Yv3Jjlz4f3m6v;
        Tue, 15 Nov 2022 09:16:51 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgC329iE6HJjpFosAg--.10568S3;
        Tue, 15 Nov 2022 09:16:54 +0800 (CST)
Subject: Re: [PATCH v2 4/5] blk-iocost: fix sleeping in atomic context
 warnning
To:     Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221104023938.2346986-1-yukuai1@huaweicloud.com>
 <20221104023938.2346986-5-yukuai1@huaweicloud.com>
 <Y3K8MSFWw8eTnxtm@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1644d8fd-a0b4-a6fd-63a2-6309db1bfa11@huaweicloud.com>
Date:   Tue, 15 Nov 2022 09:16:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y3K8MSFWw8eTnxtm@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC329iE6HJjpFosAg--.10568S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KF13ur48JFWrCry3uw1kGrg_yoW8WrWrpF
        yag3Wqyw4jqFnF9wsFyw1SvF1Skw109w4rA3s7Gasayr9rWrn3KFn5trWF9r10vry3XrWj
        vF4FqrW5Zr1UA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

ÔÚ 2022/11/15 6:07, Tejun Heo Ð´µÀ:
> On Fri, Nov 04, 2022 at 10:39:37AM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> match_u64() is called inside ioc->lock, which causes smatch static
>> checker warnings:
>>
>> block/blk-iocost.c:3211 ioc_qos_write() warn: sleeping in atomic context
>> block/blk-iocost.c:3240 ioc_qos_write() warn: sleeping in atomic context
>> block/blk-iocost.c:3407 ioc_cost_model_write() warn: sleeping in atomic
>> context
>>
>> Fix the problem by introducing a mutex and using it while prasing input
>> params.
> 
> It bothers me that parsing an u64 string requires a GFP_KERNEL memory
> allocation.
> 
>> @@ -2801,9 +2806,11 @@ static void ioc_rqos_queue_depth_changed(struct rq_qos *rqos)
>>   {
>>   	struct ioc *ioc = rqos_to_ioc(rqos);
>>   
>> +	mutex_lock(&ioc->params_mutex);
>>   	spin_lock_irq(&ioc->lock);
>>   	ioc_refresh_params(ioc, false);
>>   	spin_unlock_irq(&ioc->lock);
>> +	mutex_unlock(&ioc->params_mutex);
>>   }
> 
> Aren't the params still protected by ioc->lock? Why do we need to grab both?

Yes, the params is updated inside ioc->lock, but they can be read
without the lock before updating them, which is protected by mutex
instead.

> 
> Any chance I can persuade you into updating match_NUMBER() helpers to not
> use match_strdup()? They can easily disable irq/preemption and use percpu
> buffers and we won't need most of this patchset.

Do you mean preallocated percpu buffer? Is there any example I can
learn? Anyway, replace match_strdup() to avoid memory allocation sounds
good.

Thanks,
Kuai
> 
> Thanks.
> 

