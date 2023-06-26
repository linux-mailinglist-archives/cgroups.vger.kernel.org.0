Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1FA73D603
	for <lists+cgroups@lfdr.de>; Mon, 26 Jun 2023 04:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjFZCqX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 25 Jun 2023 22:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjFZCqX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 25 Jun 2023 22:46:23 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7336EFD;
        Sun, 25 Jun 2023 19:46:18 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QqC062MMfz4f3jZD;
        Mon, 26 Jun 2023 10:46:14 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBH_rH2+5hkkGAyMg--.42822S3;
        Mon, 26 Jun 2023 10:46:15 +0800 (CST)
Subject: Re: [PATCH -next v3 0/5] blk-wbt: minor fix and cleanup
To:     Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230527010644.647900-1-yukuai1@huaweicloud.com>
 <e33b856f-1874-030f-1b45-3b036e9b17b6@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <00cc4aa8-b725-e7ac-dec9-ccd03dd2fe21@huaweicloud.com>
Date:   Mon, 26 Jun 2023 10:46:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e33b856f-1874-030f-1b45-3b036e9b17b6@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH_rH2+5hkkGAyMg--.42822S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CF43Ar17WF1ftrW3AF13urg_yoW8Gr47pr
        Z3tasIkr4q9r92gr4fJF12qryfJw40qFykJry3tryruw1j9r1Utr48Wr4rur95ZrWxWF47
        W3WDtrZ5Cr1kZr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Jens

在 2023/06/08 10:36, Yu Kuai 写道:
> Hi, Jens
> 
> Can you apply this patchset?

The only fix from this patchset is applied separately, so this patchset
is just simple cleanups now, can you please consider this for the next
merge window?

Thanks,
Kuai
> 
> Thanks,
> Kuai
> 
> 在 2023/05/27 9:06, Yu Kuai 写道:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Changes in v3:
>>   - patch 1 from v2 is sent separately, and it's removd from this series.
>>   - add review tag for all the patches.
>>
>> Changes in v2:
>>   - make the code more readable for patch 1
>>   - add a new attr_group that is only visible for rq based device
>>   - explain in detail for patch 4
>>   - add review tag for patch 2,3,5
>>
>> Yu Kuai (5):
>>    blk-wbt: don't create wbt sysfs entry if CONFIG_BLK_WBT is disabled
>>    blk-wbt: remove dead code to handle wbt enable/disable with io
>>      inflight
>>    blk-wbt: cleanup rwb_enabled() and wbt_disabled()
>>    blk-iocost: move wbt_enable/disable_default() out of spinlock
>>    blk-sysfs: add a new attr_group for blk_mq
>>
>>   block/blk-iocost.c |   7 +-
>>   block/blk-sysfs.c  | 181 ++++++++++++++++++++++++++-------------------
>>   block/blk-wbt.c    |  21 +-----
>>   block/blk-wbt.h    |  19 -----
>>   4 files changed, 110 insertions(+), 118 deletions(-)
>>
> 
> .
> 

