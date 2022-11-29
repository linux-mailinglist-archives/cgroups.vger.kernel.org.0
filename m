Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110A363B6ED
	for <lists+cgroups@lfdr.de>; Tue, 29 Nov 2022 02:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbiK2BPG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Nov 2022 20:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbiK2BPF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Nov 2022 20:15:05 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163B721E2F;
        Mon, 28 Nov 2022 17:15:03 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NLksF1fwYz4f3nTp;
        Tue, 29 Nov 2022 09:14:57 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgDHcK8SXYVjVeUGBQ--.44020S3;
        Tue, 29 Nov 2022 09:15:00 +0800 (CST)
Subject: Re: [PATCH v2] blk-iocost: fix shift-out-of-bounds in
 iocg_hick_delay()
To:     Tejun Heo <tj@kernel.org>, Li Jinlin <lijinlin3@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        liuzhiqiang26@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20221128030413.882998-1-lijinlin3@huawei.com>
 <Y4US2vFmR4pnw08Z@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <bbc5e21f-9e77-41bb-5763-36bd905b52a0@huaweicloud.com>
Date:   Tue, 29 Nov 2022 09:14:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y4US2vFmR4pnw08Z@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDHcK8SXYVjVeUGBQ--.44020S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr18Ww18Jry3urWUtw1xGrg_yoWkAFb_Wr
        yFga1DCr15tF4fCayDCr43JFZIqF1UXw1xWrZrtayDWr4rJFykCrWUGr17urWxG34jyFWU
        ArykAw4FgFs8CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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

ÔÚ 2022/11/29 3:58, Tejun Heo Ð´µÀ:
> On Mon, Nov 28, 2022 at 11:04:13AM +0800, Li Jinlin wrote:
>>   	/* calculate the current delay in effect - 1/2 every second */
>>   	tdelta = now->now - iocg->delay_at;
>>   	if (iocg->delay)
>> -		delay = iocg->delay >> div64_u64(tdelta, USEC_PER_SEC);
>> +		delay = iocg->delay >>
>> +			min_t(u64, div64_u64(tdelta, USEC_PER_SEC), 63);
> 
> I replied earlier but the right thing to do here is setting delay to 0 if
> the shift is >= 64.

Perhaps following change will make more sense?

@@ -1322,18 +1323,19 @@ static bool iocg_kick_delay(struct ioc_gq *iocg, 
struct ioc_now *now)
  {
         struct ioc *ioc = iocg->ioc;
         struct blkcg_gq *blkg = iocg_to_blkg(iocg);
-       u64 tdelta, delay, new_delay;
+       u64 delay = 0;
+       u64 new_delay;
         s64 vover, vover_pct;
         u32 hwa;

         lockdep_assert_held(&iocg->waitq.lock);

         /* calculate the current delay in effect - 1/2 every second */
-       tdelta = now->now - iocg->delay_at;
-       if (iocg->delay)
+       if (iocg->delay && now->now > iocg->delay_at) {
+               u64 tdelta = now->now - iocg->delay_at;
+
                 delay = iocg->delay >> div64_u64(tdelta, USEC_PER_SEC);
-       else
-               delay = 0;
+       }

> 
> Thanks.
> 

