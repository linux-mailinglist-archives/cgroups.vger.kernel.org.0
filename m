Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F154C597AE2
	for <lists+cgroups@lfdr.de>; Thu, 18 Aug 2022 03:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239713AbiHRBQf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Aug 2022 21:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiHRBQf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Aug 2022 21:16:35 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EDA91D30;
        Wed, 17 Aug 2022 18:16:32 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4M7Rks366zz6R9dc;
        Thu, 18 Aug 2022 09:15:01 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgBXXOnskv1ixcflAQ--.22050S3;
        Thu, 18 Aug 2022 09:16:30 +0800 (CST)
Subject: Re: [PATCH v7 4/9] blk-throttle: fix io hung due to configuration
 updates
To:     Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     mkoutny@suse.com, axboe@kernel.dk, ming.lei@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai3@huawei.com >> yukuai (C)" <yukuai3@huawei.com>
References: <20220802140415.2960284-1-yukuai1@huaweicloud.com>
 <20220802140415.2960284-5-yukuai1@huaweicloud.com>
 <Yvv3jcycOguuEbA3@slm.duckdns.org>
 <215b4842-c09f-d622-7127-c8b1d9ce3aa9@huaweicloud.com>
 <Yv0q7T5Eg6MzOIuU@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d82305ef-1672-a648-f0b6-882bef1659f1@huaweicloud.com>
Date:   Thu, 18 Aug 2022 09:16:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Yv0q7T5Eg6MzOIuU@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBXXOnskv1ixcflAQ--.22050S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1kWFWfJw47KF45CFyxuFg_yoW8XrW8pr
        48tF4kta1DX3srA3ZFv3W2qwnYyr48WFW5Jr98G3Wrt3Z8WryIgrs2kr4rCFy09r48Jay0
        v34Sq3s5Ars5AFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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

Hi, Tejun!

ÔÚ 2022/08/18 1:52, Tejun Heo Ð´µÀ:
> On Wed, Aug 17, 2022 at 09:30:30AM +0800, Yu Kuai wrote:
>>> Would it be easier if the fields were signed? It's fragile and odd to
>>> explain "these are unsigned but if they underflow they behave just like
>>> signed when added" when they can just be signed. Also, I have a hard time
>>> understand what "preempt" means above.
>>
>> I think preempt shound never happen based on current FIFO
>> implementation, perhaps
> 
> Can you elaborate what "preempt" is?

Here preempt means that the bio that is throttled later somehow get
dispatched earlier, Michal thinks it's better to comment that the code
still works fine in this particular scenario.

> 
>>>> +	if (bps_limit != U64_MAX)
>>>> +		tg->bytes_skipped[rw] +=
>>>> +			calculate_bytes_allowed(bps_limit, jiffy_elapsed) -
>>>> +			tg->bytes_disp[rw];
>>>> +	if (iops_limit != UINT_MAX)
>>>> +		tg->io_skipped[rw] +=
>>>> +			calculate_io_allowed(iops_limit, jiffy_elapsed) -
>>>> +			tg->io_disp[rw];
>>>
>>> So, this is calculating the budgets to carry over. Can we name them
>>> accordingly? I don't know what "skipped" means.
>>
>> Yeah, thanks for you advice, art of naming is a little hard for me...
>> How do you think about these name: extended_bytes/io_budget?
> 
> How about carryover_{ios|bytes}?

Yes, that sounds good.

By the way, should I use 'ios' here instead of 'io'? I was confused
because there are many places that is using 'io' currently.

Thanks,
Kuai
> 
> Thanks.
> 

