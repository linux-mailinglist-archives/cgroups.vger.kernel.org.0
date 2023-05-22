Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDE770BD2C
	for <lists+cgroups@lfdr.de>; Mon, 22 May 2023 14:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbjEVMOc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 May 2023 08:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjEVMNb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 May 2023 08:13:31 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8403FE4C;
        Mon, 22 May 2023 05:12:58 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QPxD62VW2z4f3mWB;
        Mon, 22 May 2023 20:12:54 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCH77JCXGtk9jnlJw--.19223S3;
        Mon, 22 May 2023 20:12:52 +0800 (CST)
Subject: Re: [PATCH -next v2 0/6] blk-wbt: minor fix and cleanup
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Jens Axboe <axboe@kernel.dk>,
        Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, tj@kernel.org,
        josef@toxicpanda.com
Cc:     lukas.bulwahn@gmail.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230512093554.911753-1-yukuai1@huaweicloud.com>
 <2b18e6ed-bce0-44f5-5ec4-8903f3c85cfe@kernel.dk>
 <5d53e634-33c2-e040-3c34-6c36e32eed81@leemhuis.info>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <957c8c91-3d7b-0227-f172-7208558b101f@huaweicloud.com>
Date:   Mon, 22 May 2023 20:12:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5d53e634-33c2-e040-3c34-6c36e32eed81@leemhuis.info>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH77JCXGtk9jnlJw--.19223S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KFykuFy5WFW3Xw4rJr17trb_yoW8Zr43p3
        yay3Wakw4qvr1fKrs3A3W2q34fAws5WryrArW7Kr1rJa4Yvr1Sqr4xKr109FykZrWIkw4a
        gr1qqrn5Cw1DA3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

在 2023/05/22 20:00, Linux regression tracking (Thorsten Leemhuis) 写道:
> On 12.05.23 16:58, Jens Axboe wrote:
>> On 5/12/23 3:35 AM, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Changes in v2:
>>>   - make the code more readable for patch 1
>>>   - add a new attr_group that is only visible for rq based device
>>>   - explain in detail for patch 4
>>>   - add review tag for patch 2,3,5
>>>
>>> Yu Kuai (6):
>>>    blk-wbt: fix that wbt can't be disabled by default
>>>    blk-wbt: don't create wbt sysfs entry if CONFIG_BLK_WBT is disabled
>>>    blk-wbt: remove dead code to handle wbt enable/disable with io
>>>      inflight
>>>    blk-wbt: cleanup rwb_enabled() and wbt_disabled()
>>>    blk-iocost: move wbt_enable/disable_default() out of spinlock
>>>    blk-sysfs: add a new attr_group for blk_mq
>>>
>>>   block/blk-iocost.c |   7 +-
>>>   block/blk-sysfs.c  | 181 ++++++++++++++++++++++++++-------------------
>>>   block/blk-wbt.c    |  33 +++------
>>>   block/blk-wbt.h    |  19 -----
>>>   4 files changed, 117 insertions(+), 123 deletions(-)
>>
>> We need a 6.4 version of the fix to get rid of the regression. If you
>> want to do cleanups on top of that, then that's fine and that can go into
>> 6.5. But don't mix them up.
> 
> Hmm, it seems nothing has happened here since ten days to fix this
> regression that likely is still present in 6.3. Yu Kuai, did it fall
> through the cracks, or is what Jens asked for more complicated than it
> sounds?

Sorry for the delay, I was waiting for the last patch to be reviewed.
But the regression is only related to the first patch, I'll send it
seperately.

Thanks,
Kuai
> 
> Or was progress made and I just missed it?
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> #regzbot poke
> 
> .
> 

