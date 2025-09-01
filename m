Return-Path: <cgroups+bounces-9522-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B215B3D6BD
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 04:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35FE33B5253
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 02:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF2D212545;
	Mon,  1 Sep 2025 02:40:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E4C1F473A;
	Mon,  1 Sep 2025 02:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756694459; cv=none; b=d0BBo3Pf/OfrDZr7Cvi4CZhESGuFK4TdH46sQ8VRYH6o0OsUTFFX4YX3aSVl8t9zYpziZv0ZsyJu+8fg7KyYRiD5LorOsf20LLbaYQZszvejprU6CPsVpVm1ZqsHACwaW//HK/LiuKACabkgLJmdchNL/GlE0u9397pIFVfekBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756694459; c=relaxed/simple;
	bh=BXWqjzqFfb808DiXpxTG1EzGF8XFU+4nXLPwseoxB+E=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ifYVN1CyMHcVwu05Mm9WoKaQSJTohRttFiTqq5mXgHJkvYqboecg9lbm8vsUuf8jowI27BNYMpRiECwBI2ir/T9S51HGwATyTYOVY4tWKn0M/oUpIorY2ZaoGZneMyzrVz5ATFhPqLu7vTrLngnSQVrNP4J2qqSY3+Dz84Bq6Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cFY5f4KRkzYQv1H;
	Mon,  1 Sep 2025 10:40:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 187911A08F8;
	Mon,  1 Sep 2025 10:40:53 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAncY2yB7VoD6DwAw--.55423S3;
	Mon, 01 Sep 2025 10:40:52 +0800 (CST)
Subject: Re: [PATCH RFC v2 09/10] block: fix disordered IO in the case
 recursive split
To: Yu Kuai <hailan@yukuai.org.cn>, Damien Le Moal <dlemoal@kernel.org>,
 Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, tj@kernel.org,
 josef@toxicpanda.com, song@kernel.org, neil@brown.name,
 akpm@linux-foundation.org, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, tieren@fnnas.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250828065733.556341-1-yukuai1@huaweicloud.com>
 <20250828065733.556341-10-yukuai1@huaweicloud.com>
 <23872034-2b36-4a71-91b9-e599976902b6@kernel.org>
 <79aae55c-a2fe-465c-9204-44dce9a80256@yukuai.org.cn>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <5417dfdd-f558-2d5e-43b1-043c6bd30041@huaweicloud.com>
Date: Mon, 1 Sep 2025 10:40:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <79aae55c-a2fe-465c-9204-44dce9a80256@yukuai.org.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncY2yB7VoD6DwAw--.55423S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tw18JrW8Jry8Zry7Gr17KFg_yoW8WF4UpF
	WkJFWUtry5Gr4fKrn7XF1UWFy0krZrXw4kJrn8Ga48ArWjyr4aqa1UWry0gFyUCr48W34U
	Xrn5trnxuFyDAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

在 2025/08/30 12:28, Yu Kuai 写道:
>>> @@ -745,12 +745,16 @@ void submit_bio_noacct_nocheck(struct bio *bio)
>>>        * to collect a list of requests submited by a ->submit_bio 
>>> method while
>>>        * it is active, and then process them after it returned.
>>>        */
>>> -    if (current->bio_list)
>>> -        bio_list_add(&current->bio_list[0], bio);
>>> -    else if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO))
>>> +    if (current->bio_list) {
>>> +        if (split)
>>> +            bio_list_add_head(&current->bio_list[0], bio);
>>> +        else
>>> +            bio_list_add(&current->bio_list[0], bio);
>> This really needs a comment clarifying why we do an add at tail 
>> instead of
>> keeping the original order with a add at head. I am also scared that 
>> this may
>> break sequential write ordering for zoned devices.
> 
> I think add at head is exactly what we do here to keep the orginal order 
> for
> the case bio split. Other than split, if caller do generate multiple 
> sequential
> bios, we should keep the order by add at tail.
> 
> Not sure about zoned devices for now, I'll have a look in details.

For zoned devices, can we somehow trigger this recursive split? I
suspect bio disordered will apear in this case but I don't know for
now and I can't find a way to reporduce it.

Perhaps I can bypass zoned devices for now, and if we really met the
recursive split case and there is a problem, we can fix it later:

if (split && !bdev_is_zoned(bio->bi_bdev))
	bio_list_add_head()

Thanks,
Kuai


