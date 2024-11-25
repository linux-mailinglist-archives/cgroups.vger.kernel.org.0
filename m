Return-Path: <cgroups+bounces-5678-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F839D83CD
	for <lists+cgroups@lfdr.de>; Mon, 25 Nov 2024 11:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0310D168B4B
	for <lists+cgroups@lfdr.de>; Mon, 25 Nov 2024 10:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570C91953B0;
	Mon, 25 Nov 2024 10:50:44 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03921940B3;
	Mon, 25 Nov 2024 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531844; cv=none; b=jCScvSjiwHwdd42OriygoVg//hzx+MEbBfSTYe9up3W6LOj27Mb52Flf2GOHzRpa0LFCd5vLpmQAd26fnhgfaIeCxogdpk7o4c0/LFE/LgtsA01uuX0lDgj2txHu+jqcJNM0CAwoEE2eY9aLtIb7HAKzkc6bY9roVKevEds8lfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531844; c=relaxed/simple;
	bh=9hXOVBNdgVCWJqpNWpCcCp/Lejcixifw+eGIIr0WdSA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=n7jBh8BM/34jO6ZC24NXeC2b2cebAxa0sesGb2pUZT7BLydH1PPVkB+X69c95LOm0xdBeNIEtPtjw5GA6C+RIlUs2/v1MyZ1WxR5EhmCqkRTczY2wRdoFtIaIGlq3se0R2lDYmXCYLmKQxuWRmduF80/b71lXOxzao3xmEcF9q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XxjCT0KHrz4f3jXK;
	Mon, 25 Nov 2024 18:50:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B6D8F1A0197;
	Mon, 25 Nov 2024 18:50:31 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCngYV1VkRnOnwnCw--.39352S3;
	Mon, 25 Nov 2024 18:50:31 +0800 (CST)
Subject: Re: [PATCH] block: iocost: ensure hweight_inuse is at least 1
To: =?UTF-8?B?5oi05Z2k5rW3IFRvbnkgRGFp?= <daikunhai@didiglobal.com>,
 Yu Kuai <yukuai1@huaweicloud.com>, "tj@kernel.org" <tj@kernel.org>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <3B8BC663-3B34-454D-AE79-4FCE50001D6E@didiglobal.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <3e69ac2d-aa3b-2065-2bb6-d3888fddfe5a@huaweicloud.com>
Date: Mon, 25 Nov 2024 18:50:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3B8BC663-3B34-454D-AE79-4FCE50001D6E@didiglobal.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCngYV1VkRnOnwnCw--.39352S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4rKFy7tr18Jr1DCw4kJFb_yoW5JryDpr
	WrW3WYyFZrGF4I93WrKr129wn0vws3WF4xKrn3Z3yxCr48Gr9Ikr1xKF4DW34rXrsaqr4I
	vw17KFyrG3y7Cr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi

在 2024/11/24 21:44, 戴坤海 Tony Dai 写道:
> In fact, we did encounter such a special situation where the kernel printed out `iocg: invalid donation weights in /a/b/c: active=1 donating=1 after=0`, and then it immediately panic. I analyzed the code but could not figure out how this happened; it might be a concurrency issue or some other hidden bug.

Do you have a reporducer for this? I'd like to take a look at the
WARN first.

Thanks,
Kuai

> 
> Our kernel is not the latest, but it includes the patch edaa26334c117a584add6053f48d63a988d25a6e (iocost: Fix divide-by-zero on donation from low hweight cgroup).
> 
> ﻿在 2024/11/22 16:16，“Yu Kuai”<yukuai1@huaweicloud.com <mailto:yukuai1@huaweicloud.com>> 写入:
> 
> 
> Hi,
> 
> 
> 在 2024/11/22 15:26, Kunhai Dai 写道:
>> The hweight_inuse calculation in transfer_surpluses() could potentially
>> result in a value of 0, which would lead to division by zero errors in
>> subsequent calculations that use this value as a divisor.
>>
>> Signed-off-by: Kunhai Dai <daikunhai@didiglobal.com <mailto:daikunhai@didiglobal.com>>
>> ---
>> block/blk-iocost.c | 7 ++++---
>> 1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
>> index 384aa15e8260..65cdb55d30cc 100644
>> --- a/block/blk-iocost.c
>> +++ b/block/blk-iocost.c
>> @@ -1999,9 +1999,10 @@ static void transfer_surpluses(struct list_head *surpluses, struct ioc_now *now)
>> parent = iocg->ancestors[iocg->level - 1];
>>
>> /* b' = gamma * b_f + b_t' */
>> - iocg->hweight_inuse = DIV64_U64_ROUND_UP(
>> - (u64)gamma * (iocg->hweight_active - iocg->hweight_donating),
>> - WEIGHT_ONE) + iocg->hweight_after_donation;
>> + iocg->hweight_inuse = max_t(u64, 1,
>> + DIV64_U64_ROUND_UP(
>> + (u64)gamma * (iocg->hweight_active - iocg->hweight_donating),
>> + WEIGHT_ONE) + iocg->hweight_after_donation);
> 
> 
> I'm confused, how could DIV64_U64_Round_UP() end up less than 1?
> 
> 
> #define DIV64_U64_ROUND_UP(ll, d) \
> ({ u64 _tmp = (d); div64_u64((ll) + _tmp - 1, _tmp); })
> 
> 
> AFAIK, the only case that could happen is that
> iocg->hweight_active - iocg->hweight_donating is 0, then I don't
> get it now how cound active iocg donate all the hweight, if this
> really happend perhaps the better solution is to avoid such case.
> 
> 
> Thanks,
> Kuai
> 
> 
>>
>> /* w' = s' * b' / b'_p */
>> inuse = DIV64_U64_ROUND_UP(
>>
> 
> 
> 
> 
> 


