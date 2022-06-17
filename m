Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735F954EEAA
	for <lists+cgroups@lfdr.de>; Fri, 17 Jun 2022 03:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378606AbiFQBPK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Jun 2022 21:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiFQBPK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Jun 2022 21:15:10 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2381661609;
        Thu, 16 Jun 2022 18:15:09 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LPLdH1KtLz1K9RV;
        Fri, 17 Jun 2022 09:13:07 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 09:15:07 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 09:15:06 +0800
Subject: Re: [PATCH -next v5 0/8] bugfix and cleanup for blk-throttle
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <mkoutny@suse.com>, <axboe@kernel.dk>,
        <ming.lei@redhat.com>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220528064330.3471000-1-yukuai3@huawei.com>
 <244865d4-e7e7-432f-8e9c-248ab900d283@huawei.com>
 <66910926-39e8-85df-bd13-2ca6b2b03cac@huawei.com>
Message-ID: <b0023f3b-e38c-70e5-4bed-4870424ea926@huawei.com>
Date:   Fri, 17 Jun 2022 09:15:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <66910926-39e8-85df-bd13-2ca6b2b03cac@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Tejun (and Ming, Michal)

Can you guys take a look at this patchset?

Thanks

在 2022/06/09 8:59, Yu Kuai 写道:
> 在 2022/06/02 19:14, Yu Kuai 写道:
>> 在 2022/05/28 14:43, Yu Kuai 写道:
>>> Changes in v5:
>>>   - add comments in patch 4
>>>   - clear bytes/io_skipped in throtl_start_new_slice_with_credit() in
>>>   patch 4
>>>   - and cleanup patches 5-8
>>> Changes in v4:
>>>   - add reviewed-by tag for patch 1
>>>   - add patch 2,3
>>>   - use a different way to fix io hung in patch 4
>>> Changes in v3:
>>>   - fix a check in patch 1
>>>   - fix link err in patch 2 on 32-bit platform
>>>   - handle overflow in patch 2
>>> Changes in v2:
>>>   - use a new solution suggested by Ming
>>>   - change the title of patch 1
>>>   - add patch 2
>>>
>>> Patch 1 fix that blk-throttle can't work if multiple bios are throttle,
>>> Patch 2 fix overflow while calculating wait time
>>> Patch 3,4 fix io hung due to configuration updates.
>>> Patch 5-8 are cleanup patches, there are no functional changes, just
>>> some places that I think can be optimized during code review.
>>
>> friendly ping ...
> 
> friendly ping ...
> 
> I'll resend this patchset soon if there are still no response.
> 
> Thanks,
> Kuai
>>>
>>> Previous version:
>>> v1: 
>>> https://lore.kernel.org/all/20220517134909.2910251-1-yukuai3@huawei.com/
>>> v2: 
>>> https://lore.kernel.org/all/20220518072751.1188163-1-yukuai3@huawei.com/
>>> v3: 
>>> https://lore.kernel.org/all/20220519085811.879097-1-yukuai3@huawei.com/
>>> v4: 
>>> https://lore.kernel.org/all/20220523082633.2324980-1-yukuai3@huawei.com/
>>>
>>> Yu Kuai (8):
>>>    blk-throttle: fix that io throttle can only work for single bio
>>>    blk-throttle: prevent overflow while calculating wait time
>>>    blk-throttle: factor out code to calculate ios/bytes_allowed
>>>    blk-throttle: fix io hung due to config updates
>>>    blk-throttle: use 'READ/WRITE' instead of '0/1'
>>>    blk-throttle: calling throtl_dequeue/enqueue_tg in pairs
>>>    blk-throttle: cleanup tg_update_disptime()
>>>    blk-throttle: clean up flag 'THROTL_TG_PENDING'
>>>
>>>   block/blk-throttle.c | 158 +++++++++++++++++++++++++++++--------------
>>>   block/blk-throttle.h |  16 +++--
>>>   2 files changed, 120 insertions(+), 54 deletions(-)
>>>
