Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789FA566A05
	for <lists+cgroups@lfdr.de>; Tue,  5 Jul 2022 13:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiGELmu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Jul 2022 07:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiGELmt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Jul 2022 07:42:49 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4AB1704C;
        Tue,  5 Jul 2022 04:42:47 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4LcgkS6gdlz6R4gT;
        Tue,  5 Jul 2022 19:41:52 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgDn79O0I8RiTYCaAQ--.21417S3;
        Tue, 05 Jul 2022 19:42:45 +0800 (CST)
Subject: Re: [PATCH -next v5 4/8] blk-throttle: fix io hung due to config
 updates
To:     Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>, tj@kernel.org
Cc:     ming.lei@redhat.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20220528064330.3471000-1-yukuai3@huawei.com>
 <20220528064330.3471000-5-yukuai3@huawei.com>
 <20220622172621.GA28246@blackbody.suse.cz>
 <f5165488-2461-8946-593f-14154e404850@huawei.com>
 <20220623162620.GB16004@blackbody.suse.cz>
 <75b3cdcc-1aa3-7259-4900-f09a2a081716@huawei.com>
 <7e14a11b-225e-13c4-35ff-762eafd20b70@kernel.dk>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <2b3d9f87-a5e2-75e0-b6bc-b8588ffec8cd@huaweicloud.com>
Date:   Tue, 5 Jul 2022 19:42:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7e14a11b-225e-13c4-35ff-762eafd20b70@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDn79O0I8RiTYCaAQ--.21417S3
X-Coremail-Antispam: 1UD129KBjvJXoW7trW3KFyUur15WF18CrW7urg_yoW8XrWxpr
        W8Kay29anrJw1xJwsaqw1Iqw1Fqr12qrn8Wr1rtw1fZrn8Kr1Y9r40ga1ruF97Zr4rCan7
        AwsYvrZ3Xr9Yy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
        xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWU
        JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUot
        CzDUUUU
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

在 2022/06/26 0:41, Jens Axboe 写道:
> On 6/25/22 2:36 AM, Yu Kuai wrote:
>> ? 2022/06/24 0:26, Michal Koutn? ??:
>>> On Thu, Jun 23, 2022 at 08:27:11PM +0800, Yu Kuai <yukuai3@huawei.com> wrote:
>>>>> Here we may allow to dispatch a bio above current slice's
>>>>> calculate_bytes_allowed() if bytes_skipped is already >0.
>>>>
>>>> Hi, I don't expect that to happen. For example, if a bio is still
>>>> throttled, then old slice is keeped with proper 'bytes_skipped',
>>>> then new wait time is caculated based on (bio_size - bytes_skipped).
>>>>
>>>> After the bio is dispatched(I assum that other bios can't preempt),
>>>
>>> With this assumptions it adds up as you write. I believe we're in
>>> agreement.
>>>
>>> It's the same assumption I made below (FIFO everywhere, i.e. no
>>> reordering). So the discussed difference shouldn't really be negative
>>> (and if the assumption didn't hold, so the modular arithmetic yields
>>> corerct bytes_skipped value).
>> Yes, nice that we're in aggreement.
>>
>> I'll wait to see if Tejun has any suggestions.
> 
> I flushed more emails from spam again. Please stop using the buggy
> huawei address until this gets resolved, your patches are getting lost
> left and right and I don't have time to go hunting for emails.
> 

Hi, Jens

Can you please take a look if this patchset is ok?

https://lore.kernel.org/all/20220701093441.885741-1-yukuai1@huaweicloud.com/

This is sent by huaweicloud.com（DMARC record is empty).

Thanks,
Kuai

