Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D763A56CC71
	for <lists+cgroups@lfdr.de>; Sun, 10 Jul 2022 04:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiGJCjq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 9 Jul 2022 22:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiGJCjp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 9 Jul 2022 22:39:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CB612764;
        Sat,  9 Jul 2022 19:39:43 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LgWPf57vszhYsn;
        Sun, 10 Jul 2022 10:37:10 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 10 Jul 2022 10:39:38 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 10 Jul 2022 10:39:37 +0800
Subject: Re: [PATCH RESEND v6 0/8] bugfix and cleanup for blk-throttle
To:     Yu Kuai <yukuai1@huaweicloud.com>, <tj@kernel.org>,
        <mkoutny@suse.com>, <axboe@kernel.dk>, <ming.lei@redhat.com>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220701093441.885741-1-yukuai1@huaweicloud.com>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <a146b8ff-4287-44b7-00b2-74681963ac49@huawei.com>
Date:   Sun, 10 Jul 2022 10:39:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220701093441.885741-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi!

ÔÚ 2022/07/01 17:34, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Resend v5 by a new mail address(huaweicloud.com) because old
> address(huawei.com)has some problem that emails can end up in spam.
> Please let me know if anyone still see this patchset end up in spam.
> 
> Changes in v6:
>   - rename parameter in patch 3
>   - add comments and reviewed tag for patch 4
> Changes in v5:
>   - add comments in patch 4
>   - clear bytes/io_skipped in throtl_start_new_slice_with_credit() in
>   patch 4
>   - and cleanup patches 5-8
> Changes in v4:
>   - add reviewed-by tag for patch 1
>   - add patch 2,3
>   - use a different way to fix io hung in patch 4
> Changes in v3:
>   - fix a check in patch 1
>   - fix link err in patch 2 on 32-bit platform
>   - handle overflow in patch 2
> Changes in v2:
>   - use a new solution suggested by Ming
>   - change the title of patch 1
>   - add patch 2
> 
> Patch 1 fix that blk-throttle can't work if multiple bios are throttle,
> Patch 2 fix overflow while calculating wait time
> Patch 3,4 fix io hung due to configuration updates.
> Patch 5-8 are cleanup patches, there are no functional changes, just
> some places that I think can be optimized during code review.

Jens and Michal,

Can you receive this patchset normally(not end up in spam)?

If so, Tejun, can you take a look? This patchset do fix some problems in
blk-throttle.

BTW, Michal and Ming, it'll be great if you can take a look at other
patches as well.

Thansk,
Kuai
> 
> Previous version:
> v1: https://lore.kernel.org/all/20220517134909.2910251-1-yukuai3@huawei.com/
> v2: https://lore.kernel.org/all/20220518072751.1188163-1-yukuai3@huawei.com/
> v3: https://lore.kernel.org/all/20220519085811.879097-1-yukuai3@huawei.com/
> v4: https://lore.kernel.org/all/20220523082633.2324980-1-yukuai3@huawei.com/
> v5: https://lore.kernel.org/all/20220528064330.3471000-1-yukuai3@huawei.com/
> 
> Yu Kuai (8):
>    blk-throttle: fix that io throttle can only work for single bio
>    blk-throttle: prevent overflow while calculating wait time
>    blk-throttle: factor out code to calculate ios/bytes_allowed
>    blk-throttle: fix io hung due to config updates
>    blk-throttle: use 'READ/WRITE' instead of '0/1'
>    blk-throttle: calling throtl_dequeue/enqueue_tg in pairs
>    blk-throttle: cleanup tg_update_disptime()
>    blk-throttle: clean up flag 'THROTL_TG_PENDING'
> 
>   block/blk-throttle.c | 168 +++++++++++++++++++++++++++++--------------
>   block/blk-throttle.h |  16 +++--
>   2 files changed, 128 insertions(+), 56 deletions(-)
> 
