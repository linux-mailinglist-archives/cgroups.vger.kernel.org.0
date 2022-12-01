Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8A263E7BF
	for <lists+cgroups@lfdr.de>; Thu,  1 Dec 2022 03:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiLACVX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 21:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiLACVC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 21:21:02 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9BDA057D;
        Wed, 30 Nov 2022 18:20:34 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NN0Cx51fWz4f3s9r;
        Thu,  1 Dec 2022 10:20:29 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgAnS9huD4hjToLJBQ--.36736S2;
        Thu, 01 Dec 2022 10:20:32 +0800 (CST)
Subject: Re: [PATCH v2 0/5] A few cleanup and bugfix patches for blk-iocost
To:     Jens Axboe <axboe@kernel.dk>, tj@kernel.org, josef@toxicpanda.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221018121932.10792-1-shikemeng@huawei.com>
 <93f9093b-abec-db7e-a945-263cd9355c08@huaweicloud.com>
 <bd008582-1509-69f3-1812-2b9caa390c05@kernel.dk>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <8d9c98e5-0433-e025-ccec-4144102e91c5@huaweicloud.com>
Date:   Thu, 1 Dec 2022 10:20:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <bd008582-1509-69f3-1812-2b9caa390c05@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgAnS9huD4hjToLJBQ--.36736S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1Dtr13XF1xKw4xuw48WFg_yoW8Wr4xpF
        Z5u3WSvFyDJw4Skr1xKw42qr4Fyay8Wry8X3ZFq345Zwn8t34Sg3s2qF18ur1DXrsxA3ya
        vFW2qa45C34DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



on 12/1/2022 9:46 AM, Jens Axboe wrote:
> On 11/30/22 6:45?PM, Kemeng Shi wrote:
>>
>> Hi jens,
>> on 10/18/2022 8:19 PM, Kemeng Shi wrote:
>>> This series contain a few patch to correct comment, correct trace of
>>> vtime_rate and so on. More detail can be found in the respective
>>> changelogs.
>>>
>>> ---
>>> v2:
>>>  Thanks Tejun for review and comment!
>>>  Add Acked-by tag from Tejun.
>>>  Correct description in patch 3/5 and 4/5.
>>>  Drop "blk-iocost: Avoid to call current_hweight_max if iocg->inuse
>>> == iocg->active"
>>>  Drop "blk-iocost: Remove redundant initialization of struct ioc_gq"
>>>  Drop "blk-iocost: Get ioc_now inside weight_updated"
>>> ---
>>>
>>> Kemeng Shi (5):
>>>   blk-iocost: Fix typo in comment
>>>   blk-iocost: Reset vtime_base_rate in ioc_refresh_params
>>>   blk-iocost: Trace vtime_base_rate instead of vtime_rate
>>>   blk-iocost: Remove vrate member in struct ioc_now
>>>   blk-iocost: Correct comment in blk_iocost_init
>>>
>>>  block/blk-iocost.c            | 16 +++++++++-------
>>>  include/trace/events/iocost.h |  4 ++--
>>>  2 files changed, 11 insertions(+), 9 deletions(-)
>> Could you apply this patchset?
>> By the way, my apply for an cloud variant of email was just passed
>> a few days ago. Is this mail still in spam?
> 
> This one wasn't, but I've seen the huaweicloud.com emails fail
> the same origination checks in the past.
I'm not sure if was there any fix to huaweicloud.com email. I will
use this huaweicloud emails to minimize the trouble before any
better solution is found. Sorry for the inconvenience.

-- 
Best wishes
Kemeng Shi

