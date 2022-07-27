Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBC558262C
	for <lists+cgroups@lfdr.de>; Wed, 27 Jul 2022 14:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbiG0MMb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Jul 2022 08:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiG0MM3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Jul 2022 08:12:29 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A894B0C9;
        Wed, 27 Jul 2022 05:12:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4LtCLQ43hkzl8gY;
        Wed, 27 Jul 2022 20:11:26 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgD3_9OpK+Fip4oBBQ--.23248S3;
        Wed, 27 Jul 2022 20:12:25 +0800 (CST)
Subject: Re: [PATCH RESEND v6 0/8] bugfix and cleanup for blk-throttle
To:     Yu Kuai <yukuai1@huaweicloud.com>, tj@kernel.org, mkoutny@suse.com,
        axboe@kernel.dk, ming.lei@redhat.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20220701093441.885741-1-yukuai1@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <42a138ec-4144-5329-00ae-c094fe13137b@huaweicloud.com>
Date:   Wed, 27 Jul 2022 20:12:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220701093441.885741-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgD3_9OpK+Fip4oBBQ--.23248S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWDWr4kZrWxXrW8Wr1rZwb_yoW8KrWDpF
        Waqr45Cr4UJrnrCw43Gw43ZFW5Gws7Jwn8X3sxtw1fu3WqyryUtr1v9a1ruFyIyFZ7KrWI
        qF1jqFn2ka4UZ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1U
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x0JUZa9-UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Tejun

Are you still interested in this patchset?

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

