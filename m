Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86DC63F1F1
	for <lists+cgroups@lfdr.de>; Thu,  1 Dec 2022 14:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiLANro (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Dec 2022 08:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLANrn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Dec 2022 08:47:43 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED85DFDD;
        Thu,  1 Dec 2022 05:47:39 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NNHSk1jxsz4f3jHR;
        Thu,  1 Dec 2022 21:47:34 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgB3jrl4sIhjHtzRBQ--.20446S3;
        Thu, 01 Dec 2022 21:47:36 +0800 (CST)
Subject: Re: [PATCH -next v2 2/9] blk-iocost: improve hanlder of match_u64()
To:     Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Li Nan <linan122@huawei.com>, josef@toxicpanda.com,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20221130132156.2836184-1-linan122@huawei.com>
 <20221130132156.2836184-3-linan122@huawei.com>
 <Y4e90zFnhhq764lP@slm.duckdns.org>
 <7e4f1cea-2691-9b81-35f6-0dd236149f56@huaweicloud.com>
 <Y4h9MEd3q4LXDGQq@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <46bd7f33-6f24-a7a0-6359-3dc9aad98e6f@huaweicloud.com>
Date:   Thu, 1 Dec 2022 21:47:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y4h9MEd3q4LXDGQq@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgB3jrl4sIhjHtzRBQ--.20446S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WFW5GF1UCFW7ZrW7Ary7Wrg_yoW8Wr4DpF
        W3tas7Ar18Cr1Sk3W2y3y7XayYyr4xJr1YvFy5K348Zr1a9rW2yr17tw1Y93WUA397Kr1j
        qF4YvasxXw1DZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
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
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

在 2022/12/01 18:08, Tejun Heo 写道:
> On Thu, Dec 01, 2022 at 10:15:53AM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2022/12/01 4:32, Tejun Heo 写道:
>>> On Wed, Nov 30, 2022 at 09:21:49PM +0800, Li Nan wrote:
>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> 1) There are one place that return value of match_u64() is not checked.
>>>> 2) If match_u64() failed, return value is set to -EINVAL despite that
>>>>      there are other possible errnos.
>>>
>>> Ditto. Does this matter?
>>>
>>
>> It's not a big deal, but I think at least return value of match_u64()
>> should be checked, we don't want to continue with invalid input, right?
> 
> Yeah, sure.
> 
>> By the way, match_u64() can return -ERANGE, which can provide more
>> specific error messge to user.
> 
> I'm really not convinced going over 64bit range would be all that difficult
> to spot whether the error code is -EINVAL or -ERANGE. There isn't anything
> wrong with returning -ERANGE but the fact that that particular function
> returns an error code doesn't necessarily mean that it *must* be forwarded.
> 
> Imagine that we used sscanf(buf, "%llu", &value) to parse the number
> instead. We'd only know whether the parsing would have succeeded or not and
> would probably return -EINVAL on failure and the behavior would be just
> fine. This does not matter *at all*.
> 
> So, idk, I'm not necessarily against it but changing -EINVAL to -ERANGE is
> pure churn. Nothing material is being improved by that change.

Thanks for the review and explanation, I'll just keep the addition of
return value  checking of the former 2 patches.

Thanks,
Kuai

