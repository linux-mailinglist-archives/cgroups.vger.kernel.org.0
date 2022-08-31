Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF265A7C33
	for <lists+cgroups@lfdr.de>; Wed, 31 Aug 2022 13:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiHaLcN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 31 Aug 2022 07:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiHaLcM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 31 Aug 2022 07:32:12 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED21DBD290;
        Wed, 31 Aug 2022 04:32:07 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MHhn96GbpzlBss;
        Wed, 31 Aug 2022 19:30:37 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgDnbDCuRg9jozSvAA--.12774S3;
        Wed, 31 Aug 2022 19:31:59 +0800 (CST)
Subject: Re: [PATCH v9 0/4] blk-throttle bugfix
To:     Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, tj@kernel.org,
        mkoutny@suse.com, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20220829022240.3348319-1-yukuai1@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <eb7246b4-2cfe-a110-1e45-39f970e5441e@huaweicloud.com>
Date:   Wed, 31 Aug 2022 19:31:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220829022240.3348319-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDnbDCuRg9jozSvAA--.12774S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1kJr17WrWDZF1rJr4DXFb_yoW5GF4rpF
        Z3Zr45Cw17Crn7C3y3Cw13ZFWrKw4kJr1UWr13tw1ru3WDZr1UCrn29w4Y9F92vrZ7K34I
        qr1DtFn2kryUZ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
        3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIda
        VFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Jens!

在 2022/08/29 10:22, Yu Kuai 写道:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Changes in v9:
>   - renaming the flag BIO_THROTTLED to BIO_BPS_THROTTLED, and always
>   apply iops limit in path 1;
>   - add tag for patch 4
> Changes in v8:
>   - use a new solution in patch 1
>   - move cleanups to a separate patchset
>   - rename bytes/io_skipped to carryover_bytes/ios in patch 4
> Changes in v7:
>   - add patch 5 to improve handling of re-entered bio for bps limit
>   - as suggested by Tejun, add some comments
>   - sdd some Acked tag by Tejun
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
> Patch 1 fix that blk-throttle can't work if multiple bios are throttle.
> Patch 2 fix overflow while calculating wait time.
> Patch 3,4 fix io hung due to configuration updates.
> 
> Previous version:
> v1: https://lore.kernel.org/all/20220517134909.2910251-1-yukuai3@huawei.com/
> v2: https://lore.kernel.org/all/20220518072751.1188163-1-yukuai3@huawei.com/
> v3: https://lore.kernel.org/all/20220519085811.879097-1-yukuai3@huawei.com/
> v4: https://lore.kernel.org/all/20220523082633.2324980-1-yukuai3@huawei.com/
> v5: https://lore.kernel.org/all/20220528064330.3471000-1-yukuai3@huawei.com/
> v6: https://lore.kernel.org/all/20220701093441.885741-1-yukuai1@huaweicloud.com/
> v7: https://lore.kernel.org/all/20220802140415.2960284-1-yukuai1@huaweicloud.com/
> v8: https://lore.kernel.org/all/20220823033130.874230-1-yukuai1@huaweicloud.com/
> 
> Yu Kuai (4):
>    blk-throttle: fix that io throttle can only work for single bio
>    blk-throttle: prevent overflow while calculating wait time
>    blk-throttle: factor out code to calculate ios/bytes_allowed
>    blk-throttle: fix io hung due to configuration updates

Can you apply this patchset now?

Thanks,
Kuai
> 
>   block/bio.c               |   2 -
>   block/blk-throttle.c      | 137 +++++++++++++++++++++++++-------------
>   block/blk-throttle.h      |  11 ++-
>   include/linux/bio.h       |   2 +-
>   include/linux/blk_types.h |   2 +-
>   5 files changed, 104 insertions(+), 50 deletions(-)
> 

