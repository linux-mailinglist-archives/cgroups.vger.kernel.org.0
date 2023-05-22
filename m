Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9917370BCD0
	for <lists+cgroups@lfdr.de>; Mon, 22 May 2023 14:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbjEVMBQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 May 2023 08:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbjEVMBL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 May 2023 08:01:11 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A22EFE;
        Mon, 22 May 2023 05:00:59 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q14Dc-0005RG-Cr; Mon, 22 May 2023 14:00:52 +0200
Message-ID: <5d53e634-33c2-e040-3c34-6c36e32eed81@leemhuis.info>
Date:   Mon, 22 May 2023 14:00:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH -next v2 0/6] blk-wbt: minor fix and cleanup
Content-Language: en-US, de-DE
To:     Jens Axboe <axboe@kernel.dk>, Yu Kuai <yukuai1@huaweicloud.com>,
        hch@lst.de, tj@kernel.org, josef@toxicpanda.com, yukuai3@huawei.com
Cc:     lukas.bulwahn@gmail.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230512093554.911753-1-yukuai1@huaweicloud.com>
 <2b18e6ed-bce0-44f5-5ec4-8903f3c85cfe@kernel.dk>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <2b18e6ed-bce0-44f5-5ec4-8903f3c85cfe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1684756859;d76d1fee;
X-HE-SMSGID: 1q14Dc-0005RG-Cr
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12.05.23 16:58, Jens Axboe wrote:
> On 5/12/23 3:35 AM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Changes in v2:
>>  - make the code more readable for patch 1
>>  - add a new attr_group that is only visible for rq based device
>>  - explain in detail for patch 4
>>  - add review tag for patch 2,3,5
>>
>> Yu Kuai (6):
>>   blk-wbt: fix that wbt can't be disabled by default
>>   blk-wbt: don't create wbt sysfs entry if CONFIG_BLK_WBT is disabled
>>   blk-wbt: remove dead code to handle wbt enable/disable with io
>>     inflight
>>   blk-wbt: cleanup rwb_enabled() and wbt_disabled()
>>   blk-iocost: move wbt_enable/disable_default() out of spinlock
>>   blk-sysfs: add a new attr_group for blk_mq
>>
>>  block/blk-iocost.c |   7 +-
>>  block/blk-sysfs.c  | 181 ++++++++++++++++++++++++++-------------------
>>  block/blk-wbt.c    |  33 +++------
>>  block/blk-wbt.h    |  19 -----
>>  4 files changed, 117 insertions(+), 123 deletions(-)
> 
> We need a 6.4 version of the fix to get rid of the regression. If you
> want to do cleanups on top of that, then that's fine and that can go into
> 6.5. But don't mix them up.

Hmm, it seems nothing has happened here since ten days to fix this
regression that likely is still present in 6.3. Yu Kuai, did it fall
through the cracks, or is what Jens asked for more complicated than it
sounds?

Or was progress made and I just missed it?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke
