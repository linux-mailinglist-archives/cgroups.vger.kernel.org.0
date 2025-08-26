Return-Path: <cgroups+bounces-9415-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0713B35865
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 11:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182377C1F1B
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 09:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E034730274D;
	Tue, 26 Aug 2025 09:11:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C58279DC5;
	Tue, 26 Aug 2025 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199487; cv=none; b=Xn45d1U1jvUWnE+plGx40LFDGgqYZmCsB1KSP3B0uL5RKag95prsQ9pHNbD83FNml+K6yFhsfNWowUg2yJyFSoVRNVgulqXuk9P/SAaosljUDpoUtk7v1tymfqu48wZE/jUzGOwxR0i6TG+rDEqRpnbwgaK7eamAeVgWGmVnuVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199487; c=relaxed/simple;
	bh=zeSUYqpCyQktVExq8yTiXlqOX3wp9QK+YqIwke6RiJ8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CuRjeBQydBIZ7UCAZ4EZTaE384kJPqzG2OjL/uloLVcd7W1gMuGAXPL8LTPmUcBcnUToOJdTvF37CcGyCWRZVUS3LzlXDDlsq2RppUaGsYlr067xhYq9T9v+oo/lmJ9sg244nxsOVZ3T4hs2cy+8p2KTzu+zNGaqr/V1V5NfnDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cB22z05cXzYQvHK;
	Tue, 26 Aug 2025 17:11:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 85CB41A1945;
	Tue, 26 Aug 2025 17:11:21 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAncY03eq1otrxhAQ--.25926S3;
	Tue, 26 Aug 2025 17:11:21 +0800 (CST)
Subject: Re: [PATCH RFC 2/7] md/raid0: convert raid0_handle_discard() to use
 bio_submit_split()
To: Christoph Hellwig <hch@infradead.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: colyli@kernel.org, hare@suse.de, tieren@fnnas.com, axboe@kernel.dk,
 tj@kernel.org, josef@toxicpanda.com, song@kernel.org,
 akpm@linux-foundation.org, neil@brown.name, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250825093700.3731633-1-yukuai1@huaweicloud.com>
 <20250825093700.3731633-3-yukuai1@huaweicloud.com>
 <aKxBgNQXphpa1BNt@infradead.org>
 <2984b719-f555-7588-fa2a-1f78d2691e8a@huaweicloud.com>
 <aK1oLSppbXNELKCX@infradead.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8f33c7b8-81bb-f167-b7a1-2783c20ede6f@huaweicloud.com>
Date: Tue, 26 Aug 2025 17:11:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aK1oLSppbXNELKCX@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncY03eq1otrxhAQ--.25926S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AF18uF4DGr1DtFykAr48tFb_yoW8Wrykp3
	y5Way8tr4DJrsFkw1vqw1UtFn5tw15Xry5ZryfXrWIyFn8KF1ayr1fKr1Fkry3KryDG3WY
	q340vFWrGry5C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBa14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
	CY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRx-BiUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/08/26 15:54, Christoph Hellwig 写道:
> On Tue, Aug 26, 2025 at 09:08:33AM +0800, Yu Kuai wrote:
>> 在 2025/08/25 18:57, Christoph Hellwig 写道:
>>> On Mon, Aug 25, 2025 at 05:36:55PM +0800, Yu Kuai wrote:
>>>> +		bio = bio_submit_split(bio,
>>>> +				zone->zone_end - bio->bi_iter.bi_sector,
>>>> +				&mddev->bio_set);
>>>
>>> Do you know why raid0 and linear use mddev->bio_set for splitting
>>> instead of their own split bio_sets like raid1/10/5?  Is this safe?
>>>
>>
>> I think it's not safe, as mddev->bio_split pool size is just 2, reuse
>> this pool to split multiple times before submitting will need greate
>> pool size to make this work.
>>
>> By the way, do you think it's better to increate disk->bio_split pool
>> size to 4 and convert all mdraid internal split to use disk->bio_split
>> directly?
> 
> I don't really know where that magic number 4 or even the current number
> comes from, but I think Jens might be amenable to a small increase with a
> good explanation.

I was thinking we have to make sure issuing the allocated split bio
before allocating new bio, and that number is the safe limit that we can
allocated before issuing.

In case of recursive split, we can hold multiple split bio in
curent->bio_list, and with this set to handle split bio first, we can
gurantee we'll at most hold 3 split bios from mdraid:
  - bio_split_to_limits(), for example, by max_sectors
  - bio_split() by internal chunksize
  - bio_split() by badblocks

That's why I said 4 should be safe :) If genddisk->bio_split can be
expanded to 4, all internal bio_split can be removed now.

Thanks,
Kuai

> 
> .
> 


