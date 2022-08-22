Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FDD59B7DD
	for <lists+cgroups@lfdr.de>; Mon, 22 Aug 2022 05:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbiHVDGw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 21 Aug 2022 23:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiHVDGu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 21 Aug 2022 23:06:50 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D1A18373;
        Sun, 21 Aug 2022 20:06:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4M9y0B1mMxz6V2TB;
        Mon, 22 Aug 2022 11:05:14 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgCn3rrF8gJjlLq4Ag--.54125S3;
        Mon, 22 Aug 2022 11:06:46 +0800 (CST)
Subject: Re: [PATCH v7 1/9] blk-throttle: fix that io throttle can only work
 for single bio
To:     Yu Kuai <yukuai1@huaweicloud.com>, Tejun Heo <tj@kernel.org>
Cc:     mkoutny@suse.com, axboe@kernel.dk, ming.lei@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20220802140415.2960284-1-yukuai1@huaweicloud.com>
 <20220802140415.2960284-2-yukuai1@huaweicloud.com>
 <Yvvx+/d2+OMROUOe@slm.duckdns.org>
 <712e0f29-94ba-d3d3-ce21-cba4d6092008@huaweicloud.com>
 <Yv0qbDR+cxKeZ3nD@slm.duckdns.org>
 <83c8b253-2ebb-5af6-8ce1-6dc3b84cf182@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b1791e41-4945-a0d8-8067-3841ce10fddd@huaweicloud.com>
Date:   Mon, 22 Aug 2022 11:06:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <83c8b253-2ebb-5af6-8ce1-6dc3b84cf182@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgCn3rrF8gJjlLq4Ag--.54125S3
X-Coremail-Antispam: 1UD129KBjvJXoW7trWUKry3Xw48Aw48GrWrAFb_yoW8tF45pF
        WIva1vkFWqyrn29F4xtr1Y9Fnayr4rZr45Zry5Jry7Z3s8Cr1SkrWIqr1Ykrnrur4kC3Wj
        vF4kt3s3GrW5ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hi,

在 2022/08/18 9:23, Yu Kuai 写道:
> Hi, Tejun!
> 
> 在 2022/08/18 1:50, Tejun Heo 写道:
>> Hello,
>>
>> On Wed, Aug 17, 2022 at 09:13:38AM +0800, Yu Kuai wrote:
>>>> So, as a fix for the immediate problem, I guess this might do but 
>>>> this feels
>>>> really fragile. How can we be certain that re-entering only happens 
>>>> because
>>>> of splitting? What if future core development changes that? It seems 
>>>> to be
>>>> solving the problem in the wrong place. Shouldn't we flag the bio 
>>>> indicating
>>>> that it's split when we're splitting the bio so that we only limit 
>>>> them for
>>>> iops in the first place?
>>>
>>> Splited bio is tracked in __bio_clone:
>>
>> As the word is used in commit messages and comments, the past perfect 
>> form
>> of the verb "split" is "split". It looks like "splitted" is used in rare
>> cases but dictionary says it's an archaic form.
> 
> Ok, thanks for pointing it out, I'll change that in next iteration.
>>
>>> if (bio_flagged(bio_src, BIO_THROTTLED))
>>>     bio_set_flag(bio, BIO_THROTTLED);

While implementing the new method, I found that there seems to be a
misunderstanding here, the code seems to try to add flag to split bio
so that it won't be throttled again for bps limit, however:

1) for blk throttle, split bio is issued directly and will never be
throttled again, while orignal bio will go through throttle path again.
2) if cloned bio is directed to a new disk, the flag is cleared anyway.
>>>
>>> And currenty, the iops limit and bps limit are treated differently,
>>> however there are only one flag 'BIO_THROTTLED' and they can't be
>>> distinguished.
>>>
>>> Perhaps I can use two flags, for example BIO_IOPS_THROTTLED and
>>> BIO_BPS_THROTTLED, this way only iops limit can be handled and bps
>>> limit can be skipped for splited bio.
>>>
>>> What do you think?
>>
>> I think the code would be a lot more intuitive and less fragile if we 
>> used
>> two flags but the bits in the bi_flags field are a scarce resource
>> unfortunately. Even then, I think the right thing to do here is using two
>> flags.
> 
> Yes, the field 'bio->bi_flags' is unsigned short, and there are only two
> bits left. I'll use the new sulution which will acquire a new bit.
> 
> Thanks,
> Kuai
>>
>> Thanks.
>>
> 
> .
> 

