Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1C57BCB8F
	for <lists+cgroups@lfdr.de>; Sun,  8 Oct 2023 03:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbjJHB0c (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Oct 2023 21:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjJHB0c (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Oct 2023 21:26:32 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2267F92;
        Sat,  7 Oct 2023 18:26:31 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4S34J16QzKz4f3jJL;
        Sun,  8 Oct 2023 09:26:25 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCHHt5BBSJl_IqfCQ--.51241S3;
        Sun, 08 Oct 2023 09:26:27 +0800 (CST)
Subject: Re: [PATCH] blk-throttle: Calculate allowed value only when the
 throttle is enabled
To:     Oleg Nesterov <oleg@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Li Nan <linan666@huaweicloud.com>,
        Khazhy Kumykov <khazhy@chromium.org>, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230928015858.1809934-1-linan666@huaweicloud.com>
 <CACGdZY+JV+PdiC_cspQiScm=SJ0kijdufeTrc8wkrQC3ZJx3qQ@mail.gmail.com>
 <4ace01e8-6815-29d0-70ce-4632818ca701@huaweicloud.com>
 <20231005162417.GA32420@redhat.com>
 <0a8f34aa-ced9-e613-3e5f-b5e53a3ef3d9@huaweicloud.com>
 <20231007151607.GA24726@redhat.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <21843836-7265-f903-a7d5-e77b07dd5a71@huaweicloud.com>
Date:   Sun, 8 Oct 2023 09:26:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20231007151607.GA24726@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCHHt5BBSJl_IqfCQ--.51241S3
X-Coremail-Antispam: 1UD129KBjvdXoWruryUWFWrXr1rJF18JFWxXrb_yoWkJrg_XF
        4DAas7Crn0qF48ZFWDKFnxCrsxuw1UXrWvga48Wr17Zwnaqa1kAa47G3y8Gr45XFWfCrsx
        Cr1DAF15XFsI9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
        3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

ÔÚ 2023/10/07 23:16, Oleg Nesterov Ð´µÀ:
> On 10/07, Yu Kuai wrote:
>>
>>>>> probably need to remove the mul_u64_u64_div_u64 and check for
>>>>> overflow/potential overflow ourselves?
>>>
>>> probably yes...
>>
>> How about this?
>>
>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>> index 1101fb6f6cc8..5482c316a103 100644
>> --- a/block/blk-throttle.c
>> +++ b/block/blk-throttle.c
>> @@ -723,6 +723,10 @@ static unsigned int calculate_io_allowed(u32
>> iops_limit,
>>
>>   static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long
>> jiffy_elapsed)
>>   {
>> +       if (jiffy_elapsed > HZ &&
>> +           bps_limit > mul_u64_u64_div_u64(U64_MAX, (u64)HZ,
>> (u64)jiffy_elapsed);
>> +               return U64_MAX;
>> +
> 
> I can't suggest anything better...
> 
> but I do not know if it is possible that HZ > jiffy_elapsed. If yes, then
> mul_u64_u64_div_u64() above is not safe too.

Well, 'jiffy_elapsed > HZ' is judged before mul_u64_u64_div_u64().

Overflow can only happen if the above 2 conditions passed, and U64_MAX
is returned.

Thanks,
Kuai

> 
> Oleg.
> 
> .
> 

