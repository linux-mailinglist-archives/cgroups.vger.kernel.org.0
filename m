Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497CD5966C2
	for <lists+cgroups@lfdr.de>; Wed, 17 Aug 2022 03:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238154AbiHQBah (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 21:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237854AbiHQBag (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 21:30:36 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC17283BCF;
        Tue, 16 Aug 2022 18:30:34 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4M6r5n0SQBzlgNc;
        Wed, 17 Aug 2022 09:29:17 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAXHfq2RPxid8jIAQ--.45080S3;
        Wed, 17 Aug 2022 09:30:32 +0800 (CST)
Subject: Re: [PATCH v7 4/9] blk-throttle: fix io hung due to configuration
 updates
To:     Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     mkoutny@suse.com, axboe@kernel.dk, ming.lei@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20220802140415.2960284-1-yukuai1@huaweicloud.com>
 <20220802140415.2960284-5-yukuai1@huaweicloud.com>
 <Yvv3jcycOguuEbA3@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <215b4842-c09f-d622-7127-c8b1d9ce3aa9@huaweicloud.com>
Date:   Wed, 17 Aug 2022 09:30:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Yvv3jcycOguuEbA3@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXHfq2RPxid8jIAQ--.45080S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCFW5Ww1fJw4Duw1rXr1rtFb_yoW5Xr1Upa
        yft3W8Ja1Ut3W3Aa1qvw1ftF4fW3ykWFy3JrW5G3Wxtrs8ur1IgFn3CrWFka4S9r97XFy0
        vw1aqF97Cr4qvFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Tejun!

ÔÚ 2022/08/17 4:01, Tejun Heo Ð´µÀ:
> On Tue, Aug 02, 2022 at 10:04:10PM +0800, Yu Kuai wrote:
> ...
>> +static void __tg_update_skipped(struct throtl_grp *tg, bool rw)
>> +{
>> +	unsigned long jiffy_elapsed = jiffies - tg->slice_start[rw];
>> +	u64 bps_limit = tg_bps_limit(tg, rw);
>> +	u32 iops_limit = tg_iops_limit(tg, rw);
>> +
>> +	/*
>> +	 * If config is updated while bios are still throttled, calculate and
>> +	 * accumulate how many bytes/io are waited across changes. And
>> +	 * bytes/io_skipped will be used to calculate new wait time under new
>> +	 * configuration.
>> +	 *
>> +	 * Following calculation won't overflow as long as bios that are
>> +	 * dispatched later won't preempt already throttled bios. Even if such
>> +	 * overflow do happen, there should be no problem because unsigned is
>> +	 * used here, and bytes_skipped/io_skipped will be updated correctly.
>> +	 */
> 
> Would it be easier if the fields were signed? It's fragile and odd to
> explain "these are unsigned but if they underflow they behave just like
> signed when added" when they can just be signed. Also, I have a hard time
> understand what "preempt" means above.

I think preempt shound never happen based on current FIFO
implementation, perhaps
> 
>> +	if (bps_limit != U64_MAX)
>> +		tg->bytes_skipped[rw] +=
>> +			calculate_bytes_allowed(bps_limit, jiffy_elapsed) -
>> +			tg->bytes_disp[rw];
>> +	if (iops_limit != UINT_MAX)
>> +		tg->io_skipped[rw] +=
>> +			calculate_io_allowed(iops_limit, jiffy_elapsed) -
>> +			tg->io_disp[rw];
> 
> So, this is calculating the budgets to carry over. Can we name them
> accordingly? I don't know what "skipped" means.

Yeah, thanks for you advice, art of naming is a little hard for me...
How do you think about these name: extended_bytes/io_budget?
> 
>> @@ -115,6 +115,17 @@ struct throtl_grp {
>>   	uint64_t bytes_disp[2];
>>   	/* Number of bio's dispatched in current slice */
>>   	unsigned int io_disp[2];
>> +	/*
>> +	 * The following two fields are updated when new configuration is
>> +	 * submitted while some bios are still throttled, they record how many
>> +	 * bytes/io are waited already in previous configuration, and they will
>> +	 * be used to calculate wait time under new configuration.
>> +	 *
>> +	 * Number of bytes will be skipped in current slice
>> +	 */
>> +	uint64_t bytes_skipped[2];
>> +	/* Number of bio will be skipped in current slice */
>> +	unsigned int io_skipped[2];
> 
> So, the code seems to make sense but the field names and comments don't
> really, at least to me. I can't find an intuitive understanding of what's
> being skipped. Can you please take another stab at making this more
> understandable?
> 
> Thanks.
> 

