Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AED6567D3
	for <lists+cgroups@lfdr.de>; Tue, 27 Dec 2022 08:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiL0H0n (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Dec 2022 02:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiL0H0m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Dec 2022 02:26:42 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A46C4D;
        Mon, 26 Dec 2022 23:26:40 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Nh5n627T1z4f3p0x;
        Tue, 27 Dec 2022 15:26:34 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP3 (Coremail) with SMTP id _Ch0CgDnkyErnqpjTmUvAg--.29535S2;
        Tue, 27 Dec 2022 15:26:37 +0800 (CST)
Subject: Re: [PATCH v2 00/10] A few bugfix and cleancode patch for bfq
To:     jack@suse.cz, paolo.valente@linaro.org, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221216111230.3638832-1-shikemeng@huaweicloud.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <9bd43295-95f1-f3e0-8703-3cf4d0e46dbd@huaweicloud.com>
Date:   Tue, 27 Dec 2022 15:26:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20221216111230.3638832-1-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _Ch0CgDnkyErnqpjTmUvAg--.29535S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr4rCrW8AFy8tFyDuF1rZwb_yoWkAFX_WF
        WrGFyfGrWUWa45AFyjk3W5Ja90qrWDtF15KF9Yqr45XrnxtFn3ZwnrKr4kZF4DZan7Zay5
        Zrs0v348JrWDujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Friendly ping...

on 12/16/2022 7:12 PM, Kemeng Shi wrote:
> Hi, this series contain two patches to fix bug in request injection
> mechanism and some random cleancode patches.
> Thanks!
> 
> ---
> v2:
>  -improve git log.
> ---
> 
> Kemeng Shi (10):
>   block, bfq: correctly raise inject limit in
>     bfq_choose_bfqq_for_injection
>   block, bfq: remove unsed parameter reason in bfq_bfqq_is_slow
>   block, bfq: initialize bfqq->decrease_time_jif correctly
>   block, bfq: use helper macro RQ_BFQQ to get bfqq of request
>   block, bfq: remove unnecessary dereference to get async_bfqq
>   block, bfq: remove redundant bfqd->rq_in_driver > 0 check in
>     bfq_add_request
>   block, bfq: remove redundant check in bfq_put_cooperator
>   block, bfq: remove unnecessary goto tag in bfq_dispatch_rq_from_bfqq
>   block, bfq: remove unused bfq_wr_max_time in struct bfq_data
>   block, bfq: remove check of bfq_wr_max_softrt_rate which is always
>     greater than 0
> 
>  block/bfq-iosched.c | 49 +++++++++++++++++----------------------------
>  block/bfq-iosched.h |  2 --
>  2 files changed, 18 insertions(+), 33 deletions(-)
> 

-- 
Best wishes
Kemeng Shi

