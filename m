Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C548775923
	for <lists+cgroups@lfdr.de>; Wed,  9 Aug 2023 12:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjHIK6B (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Aug 2023 06:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbjHIK56 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Aug 2023 06:57:58 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B533213B;
        Wed,  9 Aug 2023 03:57:58 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RLRq55bwDz4f4719;
        Wed,  9 Aug 2023 18:57:53 +0800 (CST)
Received: from [10.174.179.155] (unknown [10.174.179.155])
        by APP4 (Coremail) with SMTP id gCh0CgAXp6kwcdNk9wkyAQ--.5865S3;
        Wed, 09 Aug 2023 18:57:54 +0800 (CST)
Message-ID: <c8b09f3b-b8c2-4973-255a-ab63bd6cf771@huaweicloud.com>
Date:   Wed, 9 Aug 2023 18:57:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH -next] block: remove init_mutex in blk_iolatency_try_init
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        yukuai3@huawei.com, linan122@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, lilingfeng3@huawei.com
References: <20230804113659.3816877-1-lilingfeng@huaweicloud.com>
 <o6nnp6jwzpchlqsiusbioqsyaml2fonxzmzi46yrycjgtq6hyb@ixqiysu6lmpe>
From:   Li Lingfeng <lilingfeng@huaweicloud.com>
In-Reply-To: <o6nnp6jwzpchlqsiusbioqsyaml2fonxzmzi46yrycjgtq6hyb@ixqiysu6lmpe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXp6kwcdNk9wkyAQ--.5865S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr4rurWfGrW5Zw4xGryfJFb_yoWfKFXE9r
        43GF9Ikw10g3W3Gws8tay7GrWYgrW8X347CFyxZrZrWwn3A395CF4fA3sxWFWSka4Ikas8
        Cr1Yqw47Jr4FvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU1zuWJUUUUU==
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Thanks for your advice, I will send a new patch soon.

在 2023/8/8 0:05, Michal Koutný 写道:
> Hello.
>
> On Fri, Aug 04, 2023 at 07:36:59PM +0800, Li Lingfeng <lilingfeng@huaweicloud.com> wrote:
>> From: Li Lingfeng <lilingfeng3@huawei.com>
>>
>> Commit a13696b83da4 ("blk-iolatency: Make initialization lazy") adds
>> a mutex named "init_mutex" in blk_iolatency_try_init for the race
>> condition of initializing RQ_QOS_LATENCY.
>> Now a new lock has been add to struct request_queue by commit a13bd91be223
>> ("block/rq_qos: protect rq_qos apis with a new lock"). And it has been
>> held in blkg_conf_open_bdev before calling blk_iolatency_init.
>> So it's not necessary to keep init_mutex in blk_iolatency_try_init, just
>> remove it.
> I'm looking at ioc_cost_model_write() or ioc_qos_write() where is
> a similar pattern.
> Could the check+init be open-coded back to iolatency_set_limit() to make
> code more regular?
>
> Michal

