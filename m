Return-Path: <cgroups+bounces-9511-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CABB3C7DC
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 06:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443222079BF
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 04:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF612773DC;
	Sat, 30 Aug 2025 04:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b="JJna2SZX"
X-Original-To: cgroups@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05415C2EF;
	Sat, 30 Aug 2025 04:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756527783; cv=pass; b=Dj+dsUsvHA1obTuZ3093oNAiuwNg4uF5igBOTFPSYpCdYttNOzmpH/ZP3hlN/3rVoagQAr319uFqV0whgn3dd7sl9OcNy+Me8GV/BZRcBnZ6WL8SBLyUZIi0yOPCKlEPJYfkzUrldTqQKUpSELHsILpimHEiUo9amx7PAjChTgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756527783; c=relaxed/simple;
	bh=pNoaqYiRXS09sTFR6VLZWSv6EFwggIryNS80bM+0WP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUJkEGG45nbG/qYHe+S74gdjDn6pG7EsTUXCbFnLQ7E2wsoH6p5Y5KcOrI8/5PfKGicgOFkODp56hm4dQvARbOfdlpRtuxVPL0zFmHaHpsX+3Ii88I5u64A5b4FVXz71v2Eo7FtY995XySWvniC9pSfvYJgLp+2XYDOnLi8D3Lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn; spf=pass smtp.mailfrom=yukuai.org.cn; dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b=JJna2SZX; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yukuai.org.cn
ARC-Seal: i=1; a=rsa-sha256; t=1756527750; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VvGK/74gJpW8Z95oe+6hbs0Y6Sce9wRGf9/MwUKIHcaz1Xqy1KrGigY3pkGQ81FtauUtu9lzssE+bb4gLs3n8Ur7qpQwJrMGoGDjDOZ/DU+stvphQsbrH8fntXmioT6RH17ePjIMcGjRpxWdeYDWt+wPpBZ5c+io3EbDxtw+Pw0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756527750; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bXMmvNR/qyKndal1E5zlSHRI8TqRszxo4YWSPHm8uFA=; 
	b=fzkTsH3j03GcUt9uHPF3AHB4przkiqwhLi4WlGmYWKiNEf0wZGtilOnJ5xqEa6ux+w3yjxkTHwLYzQGFzL/7IHYjZz/E43kD0Tuk+8Ags7zitBdiLLjl2WaCdGbWDOml8ZU3blddaFSGHWNZF4qW/4dA60twYKmQyFjSUQDOtiw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yukuai.org.cn;
	spf=pass  smtp.mailfrom=hailan@yukuai.org.cn;
	dmarc=pass header.from=<hailan@yukuai.org.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756527750;
	s=zmail; d=yukuai.org.cn; i=hailan@yukuai.org.cn;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=bXMmvNR/qyKndal1E5zlSHRI8TqRszxo4YWSPHm8uFA=;
	b=JJna2SZXPKBRJFqmoKo3oYIMYhVNY5Mafa3FN9ZJMmFIg3HQnKWJDDT9tO5i52pL
	M0QJqR/9+Rtj2hD8SaMdqnMtPT6jyUNU04ofNBaZMtVfijobI5CIU+int2WT5psDGVo
	8gwct40T/eMLJhZIvZ9N8jFRReGRlFSDu4ad88h0=
Received: by mx.zohomail.com with SMTPS id 1756527748847108.16554078770969;
	Fri, 29 Aug 2025 21:22:28 -0700 (PDT)
Message-ID: <69df5d1e-0fce-41ae-a0e8-ee2da7c109c6@yukuai.org.cn>
Date: Sat, 30 Aug 2025 12:22:20 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 08/10] block: skip unnecessary checks for split bio
To: Damien Le Moal <dlemoal@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com, song@kernel.org,
 neil@brown.name, akpm@linux-foundation.org, hch@infradead.org,
 colyli@kernel.org, hare@suse.de, tieren@fnnas.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250828065733.556341-1-yukuai1@huaweicloud.com>
 <20250828065733.556341-9-yukuai1@huaweicloud.com>
 <e116c5c4-55ae-4b8c-98ff-664115d70862@kernel.org>
From: Yu Kuai <hailan@yukuai.org.cn>
In-Reply-To: <e116c5c4-55ae-4b8c-98ff-664115d70862@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

在 2025/8/30 8:58, Damien Le Moal 写道:
> On 8/28/25 15:57, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Lots of checks are already done while submitting this bio the first
>> time, and there is no need to check them again when this bio is
>> resubmitted after split.
>>
>> Hence factor out a helper submit_split_bio_noacct() for resubmitting
>> bio after splitting, only should_fail_bio() and blk_throtl_bio() are
>> keeped.
> s/keeped/kept
>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/blk-core.c  | 15 +++++++++++++++
>>   block/blk-merge.c |  2 +-
>>   block/blk.h       |  1 +
>>   3 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 4201504158a1..37836446f365 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -765,6 +765,21 @@ static blk_status_t blk_validate_atomic_write_op_size(struct request_queue *q,
>>   	return BLK_STS_OK;
>>   }
>>   
>> +void submit_split_bio_noacct(struct bio *bio)
>> +{
>> +	might_sleep();
>> +
>> +	if (should_fail_bio(bio)) {
>> +		bio_io_error(bio);
>> +		return;
>> +	}
>> +
>> +	if (blk_throtl_bio(bio))
>> +		return;
>> +
>> +	submit_bio_noacct_nocheck(bio);
>> +}
>> +
>>   /**
>>    * submit_bio_noacct - re-submit a bio to the block device layer for I/O
>>    * @bio:  The bio describing the location in memory and on the device.
>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>> index 3d6dc9cc4f61..fa2c3d98b277 100644
>> --- a/block/blk-merge.c
>> +++ b/block/blk-merge.c
>> @@ -131,7 +131,7 @@ struct bio *bio_submit_split_bioset(struct bio *bio, int split_sectors,
>>   	bio_chain(split, bio);
>>   	trace_block_split(split, bio->bi_iter.bi_sector);
>>   	WARN_ON_ONCE(bio_zone_write_plugging(bio));
>> -	submit_bio_noacct(bio);
>> +	submit_split_bio_noacct(bio);
> If this helper is used only here, I would just open-code it here as otherwise it
> is confusing: its name has "split" in it but nothing of its code checks that the
> BIO was actually split.

I agree and I actually tried this first, the problem I met is that should_fail_bio()
is defined internal at blk-core.c, perhaps I'll add comment about this function?

Thanks,
Kuai

>>   
>>   	return split;
>>   }
>> diff --git a/block/blk.h b/block/blk.h
>> index 46f566f9b126..80375374ef55 100644
>> --- a/block/blk.h
>> +++ b/block/blk.h
>> @@ -54,6 +54,7 @@ bool blk_queue_start_drain(struct request_queue *q);
>>   bool __blk_freeze_queue_start(struct request_queue *q,
>>   			      struct task_struct *owner);
>>   int __bio_queue_enter(struct request_queue *q, struct bio *bio);
>> +void submit_split_bio_noacct(struct bio *bio);
>>   void submit_bio_noacct_nocheck(struct bio *bio);
>>   void bio_await_chain(struct bio *bio);
>>   
>

