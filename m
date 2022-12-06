Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73F7643AA4
	for <lists+cgroups@lfdr.de>; Tue,  6 Dec 2022 02:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbiLFBSH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Dec 2022 20:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiLFBSE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Dec 2022 20:18:04 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3FD62D1;
        Mon,  5 Dec 2022 17:18:03 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NR2bT2YXGz4f3k5m;
        Tue,  6 Dec 2022 09:17:57 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP1 (Coremail) with SMTP id cCh0CgDHu6pGmI5juMOGBg--.57619S2;
        Tue, 06 Dec 2022 09:18:00 +0800 (CST)
Subject: Re: [PATCH v3 1/9] blk-throttle: correct stale comment in
 throtl_pd_init
To:     Jens Axboe <axboe@kernel.dk>, tj@kernel.org, josef@toxicpanda.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, shikemeng@huawei.com,
        linfeilong@huawei.com, liuzhiqiang26@huawei.com
References: <20221205115709.251489-1-shikemeng@huaweicloud.com>
 <20221205115709.251489-2-shikemeng@huaweicloud.com>
 <be8563d8-1992-f9bc-928f-e9e5f3227c1c@kernel.dk>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <dbec0c06-c1e0-5ee7-3b57-24a1d239026f@huaweicloud.com>
Date:   Tue, 6 Dec 2022 09:17:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <be8563d8-1992-f9bc-928f-e9e5f3227c1c@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgDHu6pGmI5juMOGBg--.57619S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF4DCryfJFWkKFWrWFyxuFg_yoWfAFg_Zw
        4F9rn3Aa4F9rn7Ga1YvFWavr4DGw48JF13GryftryUCF10qrW8AF1DGrZ0y3W5JFWDJrsF
        kasavr4Yqr1UKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



on 12/6/2022 4:43 AM, Jens Axboe wrote:
> On 12/5/22 4:57?AM, Kemeng Shi wrote:
>> From: Kemeng Shi <shikemeng@huawei.com>
>>
>> On the default hierarchy (cgroup2), the throttle interface files don't
>> exist in the root cgroup, so the ablity to limit the whole system
>> by configuring root group is not existing anymore. In general, cgroup
>> doesn't wanna be in the business of restricting resources at the
>> system level, so correct the stale comment that we can limit whole
>> system to we can only limit subtree.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
>> Acked-by: Tejun Heo <tj@kernel.org>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> 
> Which one should be used? You have duplicate SOBs in each of the
> commits. It's marked as being from Kemeng Shi <shikemeng@huawei.com> so
> that is what I'll use.

Either one is great, thanks.

-- 
Best wishes
Kemeng Shi

