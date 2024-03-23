Return-Path: <cgroups+bounces-2142-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 516AE88770A
	for <lists+cgroups@lfdr.de>; Sat, 23 Mar 2024 05:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43481F220AA
	for <lists+cgroups@lfdr.de>; Sat, 23 Mar 2024 04:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752E63212;
	Sat, 23 Mar 2024 04:10:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841101A38C9;
	Sat, 23 Mar 2024 04:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711167006; cv=none; b=kFfm4r4qrf65XpKoFBojEvxCHIiiGL4zQMK4UJ4mM+3hWd3/Z8dJev96DhngX/FbiDmPCo75xyMnC/LmtkTRLt52Er4Y6wKABp/ycAvaQk5Yua3ST+pksWUj6dGcTCjZJrQ4RiB5RPgKU4ddKn8llBLS2DSNszh5IV7vhTNCDUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711167006; c=relaxed/simple;
	bh=/s/4CkjZJs5Td7bDTyZ52hR+tKvru5vItbA30cuh/3I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=K6lKzUaiOfy1Fz/hah3Jtg7rQTYifbpu4XL2aS2OtyKcQ2xKTlqKhjJSPx0YmJhhXHzj0ztVLcDearkyBzmAYE22QNz1WMMJo55VH5oJOfmJLn2/4XWDCtgFfqoMzG8K7OjbWpUsphGPj9BOQhUlJAFQe2w5kyOobN2Uo2MKEVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V1m1Z60qZz4f3jdd;
	Sat, 23 Mar 2024 12:09:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E3C641A017A;
	Sat, 23 Mar 2024 12:10:00 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxAXVv5li2w2Hw--.29792S3;
	Sat, 23 Mar 2024 12:10:00 +0800 (CST)
Subject: Re: [PATCH -next RFC] blk-throttle: remove
 CONFIG_BLK_DEV_THROTTLING_LOW
To: Randy Dunlap <rdunlap@infradead.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 axboe@kernel.dk, tj@kernel.org, hch@lst.de, ming.lei@redhat.com,
 josef@toxicpanda.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240323025322.1310935-1-yukuai1@huaweicloud.com>
 <bf3715e1-bf44-44e6-8877-4bbcfe5f3f98@infradead.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <faa30b1d-7f0d-40cb-a911-f6214785d8ab@huaweicloud.com>
Date: Sat, 23 Mar 2024 12:09:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <bf3715e1-bf44-44e6-8877-4bbcfe5f3f98@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxAXVv5li2w2Hw--.29792S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1UCF43CF4fKw18Zr47Jwb_yoW8Xry3p3
	y3Ja1akr4qyrnrCF17Jw1aqFWrtayUJr4UAwn8ur1fAryjk343tr1vvw18ZFy0qFZ2g3y8
	uryUGrW5AF18A37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8Jw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWr
	Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUZa9-UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi !

在 2024/03/23 11:17, Randy Dunlap 写道:
> Hi--
> 
> On 3/22/24 19:53, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> One the one hand, it's marked EXPERIMENTAL since 2017, and looks like
>> there are no users since then, and no testers and no developers, it's
>> just not active at all.
>>
>> On the other hand, even if the config is disabled, there are still many
>> fields in throtl_grp and throtl_data and many functions that are only
>> used for throtl low.
>>
>> At last, currently blk-throtl is initialized during disk initialization,
>> and destroyed during disk removal, and it exposes many functions to be
>> called directly from block layer. Hence I'm planning to optimize
>> blk-throtl and finially support building it as kernel module. Remove
>> throtl low will make the work much easier.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/Kconfig        |  11 -
>>   block/bio.c          |   1 -
>>   block/blk-stat.c     |   3 -
>>   block/blk-sysfs.c    |   7 -
>>   block/blk-throttle.c | 901 ++-----------------------------------------
>>   block/blk-throttle.h |  26 +-
>>   block/blk.h          |  11 -
>>   7 files changed, 45 insertions(+), 915 deletions(-)
> 
> Here are 2 more places to patch:
> 
> Documentation/ABI/stable/sysfs-block:           CONFIG_BLK_DEV_THROTTLING_LOW is enabled.
> arch/loongarch/configs/loongson3_defconfig:CONFIG_BLK_DEV_THROTTLING_LOW=y

Thanks for the notice, I'll update the patch if people agree to remove
throttle low.

Thanks,
Kuai

> 
> 


