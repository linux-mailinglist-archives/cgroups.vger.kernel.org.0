Return-Path: <cgroups+bounces-9686-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61620B42E6D
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 02:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B181BC42A8
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 00:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B51156236;
	Thu,  4 Sep 2025 00:50:33 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368E63BBF2;
	Thu,  4 Sep 2025 00:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756947032; cv=none; b=YsH6bB6x1Mc45SB3XFlMKYQB0rHiGHgExyydWNjdJShKDMOE9weJJi74MoZTKPFhEzHGHXl9k0aoTfa4LObd/Okwt+RGJP5ZxNGDbqQfPwZk3a5KndsVhilEfIFXDd7lK3HaXDVMS22yeokpyFz+khl7kXraHXAJGnpdgcrqkOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756947032; c=relaxed/simple;
	bh=WhL2lpXnpH/xQrI8S/IAldN9C5OZWpkHcqkvMEsCQBw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CkHspUjybXk/C06oYm9VA3ho97DBrIuyBBOVv5WRwWXm4hqKUS4Yc9VoaoSvbQ1dxgIK/wH4rb77vWhHj3AZV3ROcyBzDNoMrS1bxO7WgmpmTZHkEGY434rezg7PxRvAHmcxJtG0iQE8qOuDNQWSmps5GPSxDizopBMegVMYsrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cHLVp31kbzKHMrq;
	Thu,  4 Sep 2025 08:50:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5367C1A092F;
	Thu,  4 Sep 2025 08:50:26 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAncY1P4rho6Uc_BQ--.5353S3;
	Thu, 04 Sep 2025 08:50:25 +0800 (CST)
Subject: Re: [PATCH RFC v3 11/15] md/md-linear: convert to use
 bio_submit_split_bioset()
To: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 hch@infradead.org, colyli@kernel.org, hare@suse.de, dlemoal@kernel.org,
 tieren@fnnas.com, axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
 song@kernel.org, kmo@daterainc.com, satyat@google.com, ebiggers@google.com,
 neil@brown.name, akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-12-yukuai1@huaweicloud.com>
 <238625a0-c9ab-4354-a23e-d8a8bdd869ad@acm.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <5db345bd-fee5-8dce-3f61-1f8efb758f05@huaweicloud.com>
Date: Thu, 4 Sep 2025 08:50:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <238625a0-c9ab-4354-a23e-d8a8bdd869ad@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncY1P4rho6Uc_BQ--.5353S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AFW8XF4xCrWkXFW8uw4fuFg_yoW8CF4kpF
	WkGry5GrWUJr18Gw1UXryUta4rJr1UJ345JFW7J3W8JF1UGryq9r1UXr109r1DJrWrCr1j
	qr1UJr1UZF1UJrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRidbbtUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/04 1:43, Bart Van Assche 写道:
> On 8/31/25 8:32 PM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Unify bio split code, prepare to fix disordered split IO.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/md-linear.c | 12 ++----------
>>   1 file changed, 2 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
>> index 59d7963c7843..701e3aac0a21 100644
>> --- a/drivers/md/md-linear.c
>> +++ b/drivers/md/md-linear.c
>> @@ -256,19 +256,11 @@ static bool linear_make_request(struct mddev 
>> *mddev, struct bio *bio)
>>       if (unlikely(bio_end_sector(bio) > end_sector)) {
>>           /* This bio crosses a device boundary, so we have to split 
>> it */
>> -        struct bio *split = bio_split(bio, end_sector - bio_sector,
>> +        bio = bio_submit_split_bioset(bio, end_sector - bio_sector,
>>                             GFP_NOIO, &mddev->bio_set);
> 
> This patch cannot have been tested because it triggers the following
> build error:

Yes, sorry about that. As I said I only tested with raid5 with this
RFC version. I will at least run all the test cases in the next formal
version.

Thanks,
Kuai

> 
> drivers/md/md-linear.c: In function ‘linear_make_request’:
> ./include/linux/gfp_types.h:381:25: error: passing argument 3 of 
> ‘bio_submit_split_bioset’ makes pointer from integer without a cast 
> [-Wint-conversion]
>    381 | #define GFP_NOIO        (__GFP_RECLAIM)
>        |                         ^~~~~~~~~~~~~~~
>        |                         |
>        |                         unsigned int
> 
> Bart.
> .
> 


