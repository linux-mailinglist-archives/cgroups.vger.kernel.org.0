Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05D963E793
	for <lists+cgroups@lfdr.de>; Thu,  1 Dec 2022 03:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiLACP6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 21:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLACP5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 21:15:57 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686E3862F8;
        Wed, 30 Nov 2022 18:15:56 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NN06b2QfPz4f3s98;
        Thu,  1 Dec 2022 10:15:51 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgCHeqlZDohjb7h1BQ--.48410S3;
        Thu, 01 Dec 2022 10:15:53 +0800 (CST)
Subject: Re: [PATCH -next v2 2/9] blk-iocost: improve hanlder of match_u64()
To:     Tejun Heo <tj@kernel.org>, Li Nan <linan122@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20221130132156.2836184-1-linan122@huawei.com>
 <20221130132156.2836184-3-linan122@huawei.com>
 <Y4e90zFnhhq764lP@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7e4f1cea-2691-9b81-35f6-0dd236149f56@huaweicloud.com>
Date:   Thu, 1 Dec 2022 10:15:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y4e90zFnhhq764lP@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCHeqlZDohjb7h1BQ--.48410S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5R7kC6x804xWl14x267AKxVW8JVW5JwAF
        c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQzVbUUU
        UU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

ÔÚ 2022/12/01 4:32, Tejun Heo Ð´µÀ:
> On Wed, Nov 30, 2022 at 09:21:49PM +0800, Li Nan wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> 1) There are one place that return value of match_u64() is not checked.
>> 2) If match_u64() failed, return value is set to -EINVAL despite that
>>     there are other possible errnos.
> 
> Ditto. Does this matter?
> 

It's not a big deal, but I think at least return value of match_u64()
should be checked, we don't want to continue with invalid input, right?

By the way, match_u64() can return -ERANGE, which can provide more
specific error messge to user.

Thanks,
Kuai

