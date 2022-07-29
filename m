Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA7A584BFE
	for <lists+cgroups@lfdr.de>; Fri, 29 Jul 2022 08:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbiG2Gd2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Jul 2022 02:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbiG2Gcw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Jul 2022 02:32:52 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8562A7FE5B;
        Thu, 28 Jul 2022 23:32:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4LvHj93xgPzKF21;
        Fri, 29 Jul 2022 14:31:25 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgAXemkEf+Nilj1HBQ--.43256S3;
        Fri, 29 Jul 2022 14:32:38 +0800 (CST)
Subject: Re: [PATCH RESEND v6 1/8] blk-throttle: fix that io throttle can only
 work for single bio
To:     Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     mkoutny@suse.com, axboe@kernel.dk, ming.lei@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20220701093441.885741-1-yukuai1@huaweicloud.com>
 <20220701093441.885741-2-yukuai1@huaweicloud.com>
 <YuGDjFkxDSsVrcRw@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7f01aba1-43ab-38ab-5755-7ac22d0a78d5@huaweicloud.com>
Date:   Fri, 29 Jul 2022 14:32:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YuGDjFkxDSsVrcRw@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgAXemkEf+Nilj1HBQ--.43256S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4rZw4rAFWfJr1xJrWxCrg_yoWrGr1rpF
        48CFZ3Kw4kXrs7tr1DX3WfXFyFqr4rAr98KrW3G3W5Aws8WrnYgrnrCrWF9a43urn5Cw1k
        ZrnxKwnrGF48GFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Tejun!

ÔÚ 2022/07/28 2:27, Tejun Heo Ð´µÀ:
> Sorry about the long delay.
> 
> So, the code looks nice but I have a difficult time following the logic.
> 
> On Fri, Jul 01, 2022 at 05:34:34PM +0800, Yu Kuai wrote:
>> @@ -811,7 +811,7 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
>>   	unsigned int bio_size = throtl_bio_data_size(bio);
>>   
>>   	/* no need to throttle if this bio's bytes have been accounted */
>> -	if (bps_limit == U64_MAX || bio_flagged(bio, BIO_THROTTLED)) {
>> +	if (bps_limit == U64_MAX) {
>>   		if (wait)
>>   			*wait = 0;
>>   		return true;
>> @@ -921,11 +921,8 @@ static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
>>   	unsigned int bio_size = throtl_bio_data_size(bio);
>>   
>>   	/* Charge the bio to the group */
>> -	if (!bio_flagged(bio, BIO_THROTTLED)) {
>> -		tg->bytes_disp[rw] += bio_size;
>> -		tg->last_bytes_disp[rw] += bio_size;
>> -	}
>> -
>> +	tg->bytes_disp[rw] += bio_size;
>> +	tg->last_bytes_disp[rw] += bio_size;
>>   	tg->io_disp[rw]++;
>>   	tg->last_io_disp[rw]++;
> 
> So, we're charging and controlling whether it has already been throttled or
> not.
> 
>> @@ -2121,6 +2118,21 @@ bool __blk_throtl_bio(struct bio *bio)
>>   			tg->last_low_overflow_time[rw] = jiffies;
>>   		throtl_downgrade_check(tg);
>>   		throtl_upgrade_check(tg);
>> +
>> +		/*
>> +		 * re-entered bio has accounted bytes already, so try to
>> +		 * compensate previous over-accounting. However, if new
>> +		 * slice is started, just forget it.
>> +		 */
>> +		if (bio_flagged(bio, BIO_THROTTLED)) {
>> +			unsigned int bio_size = throtl_bio_data_size(bio);
>> +
>> +			if (tg->bytes_disp[rw] >= bio_size)
>> +				tg->bytes_disp[rw] -= bio_size;
>> +			if (tg->last_bytes_disp[rw] >= bio_size)
>> +				tg->last_bytes_disp[rw] -= bio_size;
>> +		}
> 
> and trying to restore the overaccounting. However, it's not clear why this
> helps with the problem you're describing. The comment should be clearly
> spelling out why it's done this way and how this works.
> 
> Also, blk_throttl_bio() doesn't call into __blk_throtl_bio() at all if
> THROTTLED is set and HAS_IOPS_LIMIT is not, so if there are only bw limits,
> we end up accounting these IOs twice?
> 

We need to make sure following conditions is always hold:

1) If a bio is splited, iops limits should count multiple times, while
bps limits should only count once.
2) If a bio is issued while some bios are already throttled, bps limits
should not be ignored.

commit 9f5ede3c01f9 ("block: throttle split bio in case of iops limit")
fixes that 1) is not hold, while it breaks 2). Root cause is that such
bio will be flaged in __blk_throtl_bio(), and later
tg_with_in_bps_limit() will skip flaged bio.

In order to fix this problem, at first, I change that flaged bio won't
be skipped in tg_with_in_bps_limit():

-	if (!bio_flagged(bio, BIO_THROTTLED)) {
-		tg->bytes_disp[rw] += bio_size;
-		tg->last_bytes_disp[rw] += bio_size;
-	}
-
+	tg->bytes_disp[rw] += bio_size;
+	tg->last_bytes_disp[rw] += bio_size;

However, this will break that bps limits should only count once. Thus I
try to restore the overaccounting in __blk_throtl_bio() in such case:

+		if (bio_flagged(bio, BIO_THROTTLED)) {
+			unsigned int bio_size = throtl_bio_data_size(bio);
+
+			if (tg->bytes_disp[rw] >= bio_size)
+				tg->bytes_disp[rw] -= bio_size;
+			if (tg->last_bytes_disp[rw] >= bio_size)
+				tg->last_bytes_disp[rw] -= bio_size;
+		}

If new slice is not started, then the decrement should make sure this
bio won't be counted again. However, if new slice is started and the
condition 'bytes_disp >= bio_size' doesn't hold, this bio will end up
accounting twice.

Pleas let me know if you think this suituation is problematic, I'll try
to figure out a new way...

Thanks,
Kuai

