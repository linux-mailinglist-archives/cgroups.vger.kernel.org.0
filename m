Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F44163E730
	for <lists+cgroups@lfdr.de>; Thu,  1 Dec 2022 02:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLABpT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 20:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiLABpR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 20:45:17 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459004B773;
        Wed, 30 Nov 2022 17:45:16 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NMzRB726Xz4f3nqG;
        Thu,  1 Dec 2022 09:45:10 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgBXydYoB4hjbAzIBQ--.62131S2;
        Thu, 01 Dec 2022 09:45:13 +0800 (CST)
Subject: Re: [PATCH v2 0/5] A few cleanup and bugfix patches for blk-iocost
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221018121932.10792-1-shikemeng@huawei.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <93f9093b-abec-db7e-a945-263cd9355c08@huaweicloud.com>
Date:   Thu, 1 Dec 2022 09:45:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20221018121932.10792-1-shikemeng@huawei.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgBXydYoB4hjbAzIBQ--.62131S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF4xGFW5JrW8tw48GF13XFb_yoWkAwc_C3
        yftayUXr1UKa97AFWxKan8JrWUCr4rCw4Ut3Z0qry7tr1DtFs0vanxZw47Jr1rW347Was8
        uFsxZryIq3Wa9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_JFC_Wr1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
        k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcUUUUU=
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


Hi jens,
on 10/18/2022 8:19 PM, Kemeng Shi wrote:
> This series contain a few patch to correct comment, correct trace of
> vtime_rate and so on. More detail can be found in the respective
> changelogs.
> 
> ---
> v2:
>  Thanks Tejun for review and comment!
>  Add Acked-by tag from Tejun.
>  Correct description in patch 3/5 and 4/5.
>  Drop "blk-iocost: Avoid to call current_hweight_max if iocg->inuse
> == iocg->active"
>  Drop "blk-iocost: Remove redundant initialization of struct ioc_gq"
>  Drop "blk-iocost: Get ioc_now inside weight_updated"
> ---
> 
> Kemeng Shi (5):
>   blk-iocost: Fix typo in comment
>   blk-iocost: Reset vtime_base_rate in ioc_refresh_params
>   blk-iocost: Trace vtime_base_rate instead of vtime_rate
>   blk-iocost: Remove vrate member in struct ioc_now
>   blk-iocost: Correct comment in blk_iocost_init
> 
>  block/blk-iocost.c            | 16 +++++++++-------
>  include/trace/events/iocost.h |  4 ++--
>  2 files changed, 11 insertions(+), 9 deletions(-)
Could you apply this patchset?
By the way, my apply for an cloud variant of email was just passed
a few days ago. Is this mail still in spam?

Thanks.
-- 
Best wishes
Kemeng Shi

