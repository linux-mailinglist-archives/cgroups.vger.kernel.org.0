Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FD07BC39E
	for <lists+cgroups@lfdr.de>; Sat,  7 Oct 2023 03:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbjJGBYG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Oct 2023 21:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbjJGBYF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Oct 2023 21:24:05 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA62BD;
        Fri,  6 Oct 2023 18:24:03 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4S2SHf4zZmz4f3kKc;
        Sat,  7 Oct 2023 09:23:58 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3gtIusyBlHcNKCQ--.16277S3;
        Sat, 07 Oct 2023 09:23:59 +0800 (CST)
Subject: Re: [PATCH] blk-throttle: Calculate allowed value only when the
 throttle is enabled
To:     Oleg Nesterov <oleg@redhat.com>, Li Nan <linan666@huaweicloud.com>
Cc:     Khazhy Kumykov <khazhy@chromium.org>, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230928015858.1809934-1-linan666@huaweicloud.com>
 <CACGdZY+JV+PdiC_cspQiScm=SJ0kijdufeTrc8wkrQC3ZJx3qQ@mail.gmail.com>
 <4ace01e8-6815-29d0-70ce-4632818ca701@huaweicloud.com>
 <20231005162417.GA32420@redhat.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <0a8f34aa-ced9-e613-3e5f-b5e53a3ef3d9@huaweicloud.com>
Date:   Sat, 7 Oct 2023 09:23:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20231005162417.GA32420@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3gtIusyBlHcNKCQ--.16277S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uF18ur43ZF13ur43ZF4kXrb_yoW8Krykpr
        WayFnFkr1UXF97JFs7JF12qF15Zry7JrZ5trZ8G39xC3Z3u3W7GFnIkFWIkaykXryS9a1j
        qF47tryUAry2v3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

ÔÚ 2023/10/06 0:24, Oleg Nesterov Ð´µÀ:
> Hi Li,
> 
> On 10/05, Li Nan wrote:
>>
>>> I don't think this change is sufficient to prevent kernel crash, as a
>>> "clever" user could still set the bps_limit to U64_MAX - 1 (or another
>>> large value), which probably would still result in the same crash. The
>>> comment in mul_u64_u64_div_u64 suggests there's something we can do to
>>> better handle the overflow case, but I'm not sure what it's referring
>>> to. ("Will generate an #DE when the result doesn't fit u64, could fix
>>> with an __ex_table[] entry when it becomes an issue.") Otherwise, we
>>
>> When (a * mul) overflows, a divide 0 error occurs in
>> mul_u64_u64_div_u64(). Commit 3dc167ba5729 ("sched/cputime: Improve
>> cputime_adjust()") changed func and said: "Will generate an #DE when the
>> result doesn't fit u64, could fix with an __ex_table[] entry when it
>> becomes an issue." But we are unsure of how to fix it. Could you please
>> explain how to fix this issue.
> 
> Not sure I understand the question...
> 
> OK, we can change mul_u64_u64_div_u64() to trap the exception, say,
> 
> 	static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
> 	{
> 		u64 q;
> 
> 		asm ("mulq %2; 1: divq %3; 2:\n"
> 		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_DEFAULT|EX_FLAG_CLEAR_AX)
> 					: "=a" (q)
> 					: "a" (a), "rm" (mul), "rm" (div)
> 					: "rdx");
> 
> 		return q;
> 	}
> 
> should (iiuc) return 0 if the result doesn't fit u64 or div == 0.
> 
> But even if we forget that this is x86-specific, how can this help?
> What should calculate_bytes_allowed() do/return in this case?

I believe, U64_MAX should be returned if result doesn't fit u64;
> 
>>> probably need to remove the mul_u64_u64_div_u64 and check for
>>> overflow/potential overflow ourselves?
> 
> probably yes...

How about this?

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 1101fb6f6cc8..5482c316a103 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -723,6 +723,10 @@ static unsigned int calculate_io_allowed(u32 
iops_limit,

  static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long 
jiffy_elapsed)
  {
+       if (jiffy_elapsed > HZ &&
+           bps_limit > mul_u64_u64_div_u64(U64_MAX, (u64)HZ, 
(u64)jiffy_elapsed);
+               return U64_MAX;
+
         return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64)HZ);
  }

> 
> Oleg.
> 
> .
> 

