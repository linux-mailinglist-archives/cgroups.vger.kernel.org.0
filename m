Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BA863E71F
	for <lists+cgroups@lfdr.de>; Thu,  1 Dec 2022 02:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiLABgN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 20:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiLABgN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 20:36:13 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9085C58004;
        Wed, 30 Nov 2022 17:36:10 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NMzDh6wR4z4f3nq7;
        Thu,  1 Dec 2022 09:36:04 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP1 (Coremail) with SMTP id cCh0CgCHe6oHBYhj6y50BQ--.9700S2;
        Thu, 01 Dec 2022 09:36:07 +0800 (CST)
Subject: Re: [PATCH v2 10/10] blk-throttle: avoid dead code in
 throtl_hierarchy_can_upgrade
To:     Tejun Heo <tj@kernel.org>, Kemeng Shi <shikemeng@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221129030147.27400-1-shikemeng@huawei.com>
 <20221129030147.27400-11-shikemeng@huawei.com>
 <Y4fMyEo0dxPl/Kt1@slm.duckdns.org>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <7a72b0b5-f534-f7aa-85c0-f1b97646f81c@huaweicloud.com>
Date:   Thu, 1 Dec 2022 09:36:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <Y4fMyEo0dxPl/Kt1@slm.duckdns.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgCHe6oHBYhj6y50BQ--.9700S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JryDKrW8GF1DAFyrAFW5ZFb_yoW3KrX_Wr
        W5WayDJw48GanrGF1DKrW5Xr90gFn5Ka45tF97t347GFy3tr98ZFyFvrsYv393Ca9Yyrsx
        CFy5X34jvry7ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb78YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_JFC_Wr1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IUbPEf5UUUUU==
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


Hi, Tejun
on 12/1/2022 5:36 AM, Tejun Heo wrote:
> On Tue, Nov 29, 2022 at 11:01:47AM +0800, Kemeng Shi wrote:
>> Function throtl_hierarchy_can_upgrade will always return from while loop,
>> so the return outside while loop is never reached. Break the loop when
>> we traverse to root as throtl_hierarchy_can_downgrade do to avoid dead
>> code.
> 
> I don't know why this is an improvement.
> 
I just found that the "return false" outside of the while loop is never
executed which may be not reached by code coverage test. Of course,
we can simply remove this "return false", but I found a similar function
throtl_hierarchy_can_upgrade which has no such problem. So I avoid
unreachable code as throtl_hierarchy_can_upgrade do.
Is this make sense to you? If not, I will remove this patch in next
version.

Thanks.
-- 
Best wishes
Kemeng Shi

