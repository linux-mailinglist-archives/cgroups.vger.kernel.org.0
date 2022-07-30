Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305125857B0
	for <lists+cgroups@lfdr.de>; Sat, 30 Jul 2022 03:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiG3BGp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Jul 2022 21:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiG3BGo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Jul 2022 21:06:44 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ABE3B979;
        Fri, 29 Jul 2022 18:06:42 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4LvmQZ32Qlz6S2WN;
        Sat, 30 Jul 2022 09:05:26 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgD3_9MehORi5+ZlBQ--.47816S3;
        Sat, 30 Jul 2022 09:06:39 +0800 (CST)
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
 <7f01aba1-43ab-38ab-5755-7ac22d0a78d5@huaweicloud.com>
 <YuQhOjo02RX7uZ0K@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f5691140-3343-176c-8d33-68ac58f8f16b@huaweicloud.com>
Date:   Sat, 30 Jul 2022 09:06:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YuQhOjo02RX7uZ0K@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgD3_9MehORi5+ZlBQ--.47816S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AryDXryrCF1xWFW3JF1UKFg_yoW5JFWxpF
        4UCF93Kr4kXFZrtrnrJ3WfXFyFvrWrCr98Gry5G3WUA3Z8GrnYgrnrCrWF9a43urn5Cw1q
        vwn3WF93CF4UGaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
        3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIda
        VFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2022/07/30 2:04, Tejun Heo Ð´µÀ:
> Hello,
> 
> On Fri, Jul 29, 2022 at 02:32:36PM +0800, Yu Kuai wrote:
>> We need to make sure following conditions is always hold:
>>
>> 1) If a bio is splited, iops limits should count multiple times, while
>> bps limits should only count once.
>> 2) If a bio is issued while some bios are already throttled, bps limits
>> should not be ignored.
>>
>> commit 9f5ede3c01f9 ("block: throttle split bio in case of iops limit")
>> fixes that 1) is not hold, while it breaks 2). Root cause is that such
>> bio will be flaged in __blk_throtl_bio(), and later
>> tg_with_in_bps_limit() will skip flaged bio.
>>
>> In order to fix this problem, at first, I change that flaged bio won't
>> be skipped in tg_with_in_bps_limit():
>>
>> -	if (!bio_flagged(bio, BIO_THROTTLED)) {
>> -		tg->bytes_disp[rw] += bio_size;
>> -		tg->last_bytes_disp[rw] += bio_size;
>> -	}
>> -
>> +	tg->bytes_disp[rw] += bio_size;
>> +	tg->last_bytes_disp[rw] += bio_size;
>>
>> However, this will break that bps limits should only count once. Thus I
>> try to restore the overaccounting in __blk_throtl_bio() in such case:
>>
>> +		if (bio_flagged(bio, BIO_THROTTLED)) {
>> +			unsigned int bio_size = throtl_bio_data_size(bio);
>> +
>> +			if (tg->bytes_disp[rw] >= bio_size)
>> +				tg->bytes_disp[rw] -= bio_size;
>> +			if (tg->last_bytes_disp[rw] >= bio_size)
>> +				tg->last_bytes_disp[rw] -= bio_size;
>> +		}
>>
>> If new slice is not started, then the decrement should make sure this
>> bio won't be counted again. However, if new slice is started and the
>> condition 'bytes_disp >= bio_size' doesn't hold, this bio will end up
>> accounting twice.
>>
>> Pleas let me know if you think this suituation is problematic, I'll try
>> to figure out a new way...
> 
> While a bit tricky, I think it's fine but please add comments in the code
> explaining what's going on and why. Also, can you please explain why
> __blk_throtl_bio() being skipped when iops limit is not set doesn't skew the
> result?

Because bps limit is already counted the first time __blk_throtl_bio()
is called for the orignal bio. When splited bio is reentered, we only
need to throttle it again if iops limit is set.

By the way, I found that this way is better after patch 4:

in __blk_throtl_bio():

if (bio_flagged(bio, BIO_THROTTLED)) {
	tg->bytes_skipped[rw] += bio_size;
	if (tg->last_bytes_disp[rw] >= bio_size)
		tg->last_bytes_disp[rw] -= bio_size;
}

The overaccounting can be restored even if new slice is started.

Thanks,
Kuai

