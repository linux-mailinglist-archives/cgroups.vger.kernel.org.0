Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C69E72750A
	for <lists+cgroups@lfdr.de>; Thu,  8 Jun 2023 04:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbjFHCg7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Jun 2023 22:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjFHCg6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Jun 2023 22:36:58 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A2713D;
        Wed,  7 Jun 2023 19:36:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Qc7db0bdSz4f3nwW;
        Thu,  8 Jun 2023 10:36:51 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCX_7LDPoFkAt_GLA--.34208S3;
        Thu, 08 Jun 2023 10:36:52 +0800 (CST)
Subject: Re: [PATCH -next v3 0/5] blk-wbt: minor fix and cleanup
To:     Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230527010644.647900-1-yukuai1@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <e33b856f-1874-030f-1b45-3b036e9b17b6@huaweicloud.com>
Date:   Thu, 8 Jun 2023 10:36:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230527010644.647900-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCX_7LDPoFkAt_GLA--.34208S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XryfJrWfuFyfXr4rtF17Awb_yoWDXFb_Wa
        4qyayDK3Z8A3Z5CFW2yFyDXFWjkr4rXr4UWFn5J3yftr13Jr1DKw4ktrW3Z3y3ua1ku3Wr
        Aw1DXrWxJw4SyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxv
        r21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUU
        U==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Jens

Can you apply this patchset?

Thanks,
Kuai

ÔÚ 2023/05/27 9:06, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Changes in v3:
>   - patch 1 from v2 is sent separately, and it's removd from this series.
>   - add review tag for all the patches.
> 
> Changes in v2:
>   - make the code more readable for patch 1
>   - add a new attr_group that is only visible for rq based device
>   - explain in detail for patch 4
>   - add review tag for patch 2,3,5
> 
> Yu Kuai (5):
>    blk-wbt: don't create wbt sysfs entry if CONFIG_BLK_WBT is disabled
>    blk-wbt: remove dead code to handle wbt enable/disable with io
>      inflight
>    blk-wbt: cleanup rwb_enabled() and wbt_disabled()
>    blk-iocost: move wbt_enable/disable_default() out of spinlock
>    blk-sysfs: add a new attr_group for blk_mq
> 
>   block/blk-iocost.c |   7 +-
>   block/blk-sysfs.c  | 181 ++++++++++++++++++++++++++-------------------
>   block/blk-wbt.c    |  21 +-----
>   block/blk-wbt.h    |  19 -----
>   4 files changed, 110 insertions(+), 118 deletions(-)
> 

