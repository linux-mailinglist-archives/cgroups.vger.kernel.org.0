Return-Path: <cgroups+bounces-9610-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B19B3F79B
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 10:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2FA486F9D
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 08:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D386A2E8E0C;
	Tue,  2 Sep 2025 08:04:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46C52DE71A;
	Tue,  2 Sep 2025 08:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800288; cv=none; b=laE0RxYtZO3HjdurO91bhXzP/kWkCdeZZXQ9K7ObVJqH9ek2HSZF8BJCNOjoqZF7/jV6n7C7KzN4wrpLKN/P/PnCr7O+VBczPzM2GHEbOlJD/ghM+BlMLLn65FXC9r+8qpjglY+d9BAN0RlisOc/k+pDywQ6+OXEiMcKO4m1n5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800288; c=relaxed/simple;
	bh=wCihueiHq46VMEhL5Fdlw2AptC9RUHDLHvDISy19KY8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=O4e9DDazMmZfUPyByGoKAiXmb+6fjXX2PpFexS+sByCe/OexRk1/vmrMOuXDarHIiBU0d7HWO8/PxBZ+SzbCsyCaTEbRl/R0YNEpOZ1hcY9jiHui238XURisVmVYlu5r3Qox0TxwBjogK8b9fIkFUTmMp82hyoWO2idO9r7Hchs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cGJDn6bGlzKHNQL;
	Tue,  2 Sep 2025 16:04:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BD2CB1A1552;
	Tue,  2 Sep 2025 16:04:41 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgB3wY0VpbZomRx9BA--.23736S3;
	Tue, 02 Sep 2025 16:04:40 +0800 (CST)
Subject: Re: [PATCH RFC v3 00/15] block: fix disordered IO in the case
 recursive split
To: Yu Kuai <yukuai1@huaweicloud.com>, Bart Van Assche <bvanassche@acm.org>,
 hch@infradead.org, colyli@kernel.org, hare@suse.de, dlemoal@kernel.org,
 tieren@fnnas.com, axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
 song@kernel.org, kmo@daterainc.com, satyat@google.com, ebiggers@google.com,
 neil@brown.name, akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <5b3a5bed-939f-4402-aafd-f7381cd46975@acm.org>
 <130482e9-8363-6051-5fc6-549cf9aad57b@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <850263b4-fbc7-379e-2b9f-80f602ee0e72@huaweicloud.com>
Date: Tue, 2 Sep 2025 16:04:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <130482e9-8363-6051-5fc6-549cf9aad57b@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3wY0VpbZomRx9BA--.23736S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw1ktw4fXrW8Zr1rtFWDArb_yoWxXw1rp3
	y5Wa17ZF4DXa42qF929r43XF9IkFnFkw4UA3WrGr18JFW0yF42934kZr1qqrs2y347Jws0
	vw4kKr9akFZ3CFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRHUDLUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/02 9:50, Yu Kuai 写道:
> Hi,
> 
> 在 2025/09/01 22:09, Bart Van Assche 写道:
>> On 8/31/25 8:32 PM, Yu Kuai wrote:
>>> This set is just test for raid5 for now, see details in patch 9;
>>
>> Does this mean that this patch series doesn't fix reordering caused by
>> recursive splitting for zoned block devices? A test case that triggers
>> an I/O error is available here:
>> https://lore.kernel.org/linux-block/a8a714c7-de3d-4cc9-8c23-38b8dc06f5bb@acm.org/ 
>>
> I'll try this test.
> 

This test can't run directly in my VM, then I debug a bit and modify the
test a bit, following is the result by the block trace event of
block_io_start:

Before this set:

           dd-3014    [000] .N...  1918.939253: block_io_start: 252,2 WS 
524288 () 0 + 1024 be,0,4 [dd]
     kworker/0:1H-37      [000] .....  1918.952434: block_io_start: 
252,2 WS 524288 () 1024 + 1024 be,0,4 [kworker/0:1H]
               dd-3014    [000] .....  1918.973499: block_io_start: 
252,2 WS 524288 () 8192 + 1024 be,0,4 [dd]
     kworker/0:1H-37      [000] .....  1918.984805: block_io_start: 
252,2 WS 524288 () 9216 + 1024 be,0,4 [kworker/0:1H]
               dd-3014    [000] .N...  1919.010224: block_io_start: 
252,2 WS 524288 () 16384 + 1024 be,0,4 [dd]
     kworker/0:1H-37      [000] .....  1919.021667: block_io_start: 
252,2 WS 524288 () 17408 + 1024 be,0,4 [kworker/0:1H]
               dd-3014    [000] .....  1919.053072: block_io_start: 
252,2 WS 524288 () 24576 + 1024 be,0,4 [dd]
     kworker/0:1H-37      [000] .....  1919.064781: block_io_start: 
252,2 WS 524288 () 25600 + 1024 be,0,4 [kworker/0:1H]
               dd-3014    [000] .N...  1919.100657: block_io_start: 
252,2 WS 524288 () 32768 + 1024 be,0,4 [dd]
     kworker/0:1H-37      [000] .....  1919.112999: block_io_start: 
252,2 WS 524288 () 33792 + 1024 be,0,4 [kworker/0:1H]
               dd-3014    [000] .....  1919.145032: block_io_start: 
252,2 WS 524288 () 40960 + 1024 be,0,4 [dd]
     kworker/0:1H-37      [000] .....  1919.156677: block_io_start: 
252,2 WS 524288 () 41984 + 1024 be,0,4 [kworker/0:1H]
               dd-3014    [000] .N...  1919.188287: block_io_start: 
252,2 WS 524288 () 49152 + 1024 be,0,4 [dd]
     kworker/0:1H-37      [000] .....  1919.199869: block_io_start: 
252,2 WS 524288 () 50176 + 1024 be,0,4 [kworker/0:1H]
               dd-3014    [000] .N...  1919.233467: block_io_start: 
252,2 WS 524288 () 57344 + 1024 be,0,4 [dd]
     kworker/0:1H-37      [000] .....  1919.245487: block_io_start: 
252,2 WS 524288 () 58368 + 1024 be,0,4 [kworker/0:1H]
               dd-3014    [000] .N...  1919.281146: block_io_start: 
252,2 WS 524288 () 65536 + 1024 be,0,4 [dd]
     kworker/0:1H-37      [000] .....  1919.292812: block_io_start: 
252,2 WS 524288 () 66560 + 1024 be,0,4 [kworker/0:1H]
               dd-3014    [000] .N...  1919.326543: block_io_start: 
252,2 WS 524288 () 73728 + 1024 be,0,4 [dd]
     kworker/0:1H-37      [000] .....  1919.338412: block_io_start: 
252,2 WS 524288 () 74752 + 1024 be,0,4 [kworker/0:1H]
               dd-3014    [000] .N...  1919.374312: block_io_start: 
252,2 WS 524288 () 81920 + 1024 be,0,4 [dd]
     kworker/0:1H-37      [000] .....  1919.386481: block_io_start: 
252,2 WS 524288 () 82944 + 1024 be,0,4 [kworker/0:1H]
               dd-3014    [000] .....  1919.419795: block_io_start: 
252,2 WS 524288 () 90112 + 1024 be,0,4 [dd]
     kworker/0:1H-37      [000] .....  1919.431454: block_io_start: 
252,2 WS 524288 () 91136 + 1024 be,0,4 [kworker/0:1H]
               dd-3014    [000] .N...  1919.466208: block_io_start: 
252,2 WS 524288 () 98304 + 1024 be,0,4 [dd]

We can see block_io_start is not sequential, and test will report out of
space failure.

With this set and zone device checking removed:

diff:
diff --git a/block/blk-core.c b/block/blk-core.c
index 6ca3c45f421c..37b5dd396e22 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -746,7 +746,7 @@ void submit_bio_noacct_nocheck(struct bio *bio, bool 
split)
          * it is active, and then process them after it returned.
          */
         if (current->bio_list) {
-               if (split && !bdev_is_zoned(bio->bi_bdev))
+               if (split)
                         bio_list_add_head(&current->bio_list[0], bio);
                 else
                         bio_list_add(&current->bio_list[0], bio);

result:
              dd-612     [000] .N...    52.856395: block_io_start: 252,2 
WS 524288 () 0 + 1024 be,0,4 [dd]
     kworker/0:1H-37      [000] .....    52.869947: block_io_start: 
252,2 WS 524288 () 1024 + 1024 be,0,4 [kworker/0:1H]
     kworker/0:1H-37      [000] .....    52.880295: block_io_start: 
252,2 WS 524288 () 2048 + 1024 be,0,4 [kworker/0:1H]
     kworker/0:1H-37      [000] .....    52.890541: block_io_start: 
252,2 WS 524288 () 3072 + 1024 be,0,4 [kworker/0:1H]
     kworker/0:1H-37      [000] .....    52.900951: block_io_start: 
252,2 WS 524288 () 4096 + 1024 be,0,4 [kworker/0:1H]
     kworker/0:1H-37      [000] .....    52.911370: block_io_start: 
252,2 WS 524288 () 5120 + 1024 be,0,4 [kworker/0:1H]
     kworker/0:1H-37      [000] .....    52.922160: block_io_start: 
252,2 WS 524288 () 6144 + 1024 be,0,4 [kworker/0:1H]
     kworker/0:1H-37      [000] .....    52.932823: block_io_start: 
252,2 WS 524288 () 7168 + 1024 be,0,4 [kworker/0:1H]
               dd-612     [000] .N...    52.968469: block_io_start: 
252,2 WS 524288 () 8192 + 1024 be,0,4 [dd]
     kworker/0:1H-37      [000] .....    52.980892: block_io_start: 
252,2 WS 524288 () 9216 + 1024 be,0,4 [kworker/0:1H]
     kworker/0:1H-37      [000] .....    52.991500: block_io_start: 
252,2 WS 524288 () 10240 + 1024 be,0,4 [kworker/0:1H]
     kworker/0:1H-37      [000] .....    53.002088: block_io_start: 
252,2 WS 524288 () 11264 + 1024 be,0,4 [kworker/0:1H]
     kworker/0:1H-37      [000] .....    53.012879: block_io_start: 
252,2 WS 524288 () 12288 + 1024 be,0,4 [kworker/0:1H]
     kworker/0:1H-37      [000] .....    53.023518: block_io_start: 
252,2 WS 524288 () 13312 + 1024 be,0,4 [kworker/0:1H]
     kworker/0:1H-37      [000] .....    53.034365: block_io_start: 
252,2 WS 524288 () 14336 + 1024 be,0,4 [kworker/0:1H]
     kworker/0:1H-37      [000] .....    53.045077: block_io_start: 
252,2 WS 524288 () 15360 + 1024 be,0,4 [kworker/0:1H]
               dd-612     [000] .N...    53.082148: block_io_start: 
252,2 WS 524288 () 16384 + 1024 be,0,4 [dd]

We can see that block_io_start is sequential now.

Thanks,
Kuai

> zoned block device is bypassed in patch 14 by:
> 
> +        if (split && !bdev_is_zoned(bio->bi_bdev))
> +            bio_list_add_head(&current->bio_list[0], bio);
> 
> If I can find a reporducer for zoned block, and verify that recursive
> split can be fixed as well, I can remove the checking for zoned devices
> in the next verison.
> 
> Thanks,
> Kuai
> 
>>
>> I have not yet had the time to review this patch series but plan to take
>> a look soon.
>>
>> Thanks,
>>
>> Bart.
>> .
>>
> 
> .
> 


