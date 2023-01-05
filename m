Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC33965E283
	for <lists+cgroups@lfdr.de>; Thu,  5 Jan 2023 02:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjAEBfb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Jan 2023 20:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjAEBf3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Jan 2023 20:35:29 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1C02009;
        Wed,  4 Jan 2023 17:35:27 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NnTYk4Nc5z4f3jJ4;
        Thu,  5 Jan 2023 09:35:22 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgCHpjBaKbZjMF4wBA--.2841S3;
        Thu, 05 Jan 2023 09:35:23 +0800 (CST)
Subject: Re: [PATCH -next 3/4] block/rq_qos: use a global mutex to protect
 rq_qos apis
To:     Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230104085354.2343590-1-yukuai1@huaweicloud.com>
 <20230104085354.2343590-4-yukuai1@huaweicloud.com>
 <Y7XyIzGptuqO8EAt@slm.duckdns.org> <Y7YZnM/nqb0gxOei@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <df2f7a60-467f-08ce-2a3e-1dc7853424aa@huaweicloud.com>
Date:   Thu, 5 Jan 2023 09:35:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y7YZnM/nqb0gxOei@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCHpjBaKbZjMF4wBA--.2841S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWrtrWftry5Cr4fWr4kZwb_yoW8try5pF
        Z0g3Z8Kw4kGrsava17Z3yrXrySyrWkG3y3JrW8Gr4jk3s0kryqvr9avF47KFW5XFZ5Gr4j
        v3yrKF93GryUCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

ÔÚ 2023/01/05 8:28, Tejun Heo Ð´µÀ:
> Hello, again.
> 
> On Wed, Jan 04, 2023 at 11:39:47AM -1000, Tejun Heo wrote:
>>> 2) rq_qos_add() and blkcg_activate_policy() is not atomic, if
>>>     rq_qos_exit() is done before blkcg_activate_policy(),
>>>     null-ptr-deference can be triggered.
>>
>> I'm not sure this part does. I think it'd be better to guarantee that device
>> destruction is blocked while these configuration operations are in progress
>> which can be built into blkg_conf helpers.
> 
> A bit more explanation:
> 
> Usually, this would be handled in the core - when a device goes away, its
> sysfs files get shut down before stuff gets freed and the sysfs file removal
> waits for in-flight operations to finish and prevents new ones from
> starting, so we don't have to worry about in-flight config file operations
> racing against device removal.
> 
> Here, the problem isn't solved by that because the config files live on
> cgroupfs and their lifetimes are not coupled with the block devices'. So, we
> need to synchronize manually. And, given that, the right place to do is the
> blkg config helpers cuz they're the ones which establish the connection
> between cgroup and block layer.

Thanks for the explanation, I agree with that.
> 
> Can you please take a look at the following patchset I just posted:
> 
>    https://lkml.kernel.org/r/20230105002007.157497-1-tj@kernel.org
> 
> After that, all these configuration operations are wrapped between
> blkg_conf_init() and blkg_conf_exit() which probably are the right place to
> implement the synchronization.

I see that, blkg_conf_init() and blkg_conf_exit() is good, however there
are some details I want to confirm:

1) rq_qos_add() can be called from iocost/iolatency, where
blkg_conf_init() will be called first, while rq_qos_add() can also be
called from wbt, where there is no blkg_conf_init(). Hence it seems to
me we need two locks here, one to protect rq_qos apis; one to
synchronize policy configuration and device removal.

2) If you agree with 1), it seems better to use the other lock in device
level, consider that there is no need to synchronize confituration for
different devices.

Thanks,
Kuai
> 
> Thanks.
> 

