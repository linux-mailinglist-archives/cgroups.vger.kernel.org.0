Return-Path: <cgroups+bounces-9509-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCF9B3C7CE
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 06:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B73920228E
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 04:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34F1277CA5;
	Sat, 30 Aug 2025 04:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b="BW+6GoB+"
X-Original-To: cgroups@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CA42773FF;
	Sat, 30 Aug 2025 04:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756527085; cv=pass; b=fYF7qwHTTgewIqvhK+vn0qZKolwPZ15ALPxgUqtDOG2R14+YK69/BO2c5aqZbdW3fQdlPE00TblVntQoIW029UY8H7GoVnzraHuM4PTgewTotD8X2u+bgMYW0Eo7ks1nfyjlu5IqPt4xwGboTQT9bUXvzgM1d/8LGFpbvDn6onI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756527085; c=relaxed/simple;
	bh=aMdVvHTKC5Q68BwZ1XJyYdMyozzseL304zpwN8fODaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AXYVZS2UkHb8edn1w3wni11rb8prli/wzPMcYFWCoIEqvucBygnkc0J3VUUyPBTPM+olUL56q99mZoJ9enAttIhqQrMOQB1qpSBgt0rF7CIbUQWSfvv9At7qig/W0LY7SzunmSWZjhWEp8YOrUXMrpno5D8FfL2OLcHIKTtoYUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yukuai.org.cn; spf=pass smtp.mailfrom=yukuai.org.cn; dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b=BW+6GoB+; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yukuai.org.cn
ARC-Seal: i=1; a=rsa-sha256; t=1756527047; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hXI6WbDiwQx3g+PFpykfE2RSDzbQvQ1kpok554K/GVdGbe7Wbl/BhnxWL2nUmlWr5Fy5rvMPCHLZHuWVdtYXbAwyQ6XTmbMMRsqHKY3GzsCP/ealdsp3uxNwk5BKzY/EOhMPSWUDuTjA8gdg6sS5sJMf+w1ckE2XygHJWNB6rEA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756527047; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AIqdQ1o+KDcxRP37mYqQKPe1hyWo6vnaOhhysa3wo9Q=; 
	b=U0lQ3juh+SwB9/IGQohoYnHAnQH1mO8AdLDqsUjOVO4Pe2spvGe5jZ7FdPS9NQX3NaZa02ML1sT6dFdje5y7CSA0wivmHRTyfKgXmo27LZ6njKPP+snimlyJN5bubrJhA0YO9aBK33S8dj4BUdD/7wfCU20shKt+k6AI7fyFhA0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yukuai.org.cn;
	spf=pass  smtp.mailfrom=hailan@yukuai.org.cn;
	dmarc=pass header.from=<hailan@yukuai.org.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756527047;
	s=zmail; d=yukuai.org.cn; i=hailan@yukuai.org.cn;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=AIqdQ1o+KDcxRP37mYqQKPe1hyWo6vnaOhhysa3wo9Q=;
	b=BW+6GoB+aRU9F98NtYy49EdqBxt2BZmNnnA+S4AqUpDx2wpxsMlDp2dqlNKNlM8F
	1FAe8AHl0Mqln2AqA/zsMEpPPfRaxp6my9Nv24tEc1zUXy3Imgp+1XGPThTtpCpoxan
	NWSD9phUwS4+raKjWAKVNtghlMIac+XYKgyzBXSs=
Received: by mx.zohomail.com with SMTPS id 1756527044122466.79767147184646;
	Fri, 29 Aug 2025 21:10:44 -0700 (PDT)
Message-ID: <e147e288-de38-4f2c-8068-53c5e37b2310@yukuai.org.cn>
Date: Sat, 30 Aug 2025 12:10:29 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 02/10] md/raid0: convert raid0_handle_discard() to
 use bio_submit_split_bioset()
To: Damien Le Moal <dlemoal@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com, song@kernel.org,
 neil@brown.name, akpm@linux-foundation.org, hch@infradead.org,
 colyli@kernel.org, hare@suse.de, tieren@fnnas.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250828065733.556341-1-yukuai1@huaweicloud.com>
 <20250828065733.556341-3-yukuai1@huaweicloud.com>
 <858e0210-1bbb-466b-98c3-d1a3c834519d@kernel.org>
From: Yu Kuai <hailan@yukuai.org.cn>
In-Reply-To: <858e0210-1bbb-466b-98c3-d1a3c834519d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

在 2025/8/30 8:41, Damien Le Moal 写道:
> On 8/28/25 15:57, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> On the one hand unify bio split code, prepare to fix disordered split
>> IO; On the other hand fix missing blkcg_bio_issue_init() and
>> trace_block_split() for split IO.
> Hmmm... Shouldn't that be a prep patch with a fixes tag for backport ?
> Because that "fix" here is not done directly but is the result of calling
> bio_submit_split_bioset().

I can add a fix tag as blkcg_bio_issue_init() and trace_block_split() is missed,
however, if we consider stable backport, should we fix this directly from caller
first? As this is better for backport. Later this patch can be just considered
cleanup.

>> Noted commit 319ff40a5427 ("md/raid0: Fix performance regression for large
>> sequential writes") already fix disordered split IO by converting bio to
>> underlying disks before submit_bio_noacct(), with the respect
>> md_submit_bio() already split by sectors, and raid0_make_request() will
>> split at most once for unaligned IO. This is a bit hacky and we'll convert
>> this to solution in general later.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/raid0.c | 19 +++++++------------
>>   1 file changed, 7 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
>> index f1d8811a542a..4dcc5133d679 100644
>> --- a/drivers/md/raid0.c
>> +++ b/drivers/md/raid0.c
>> @@ -463,21 +463,16 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
>>   	zone = find_zone(conf, &start);
>>   
>>   	if (bio_end_sector(bio) > zone->zone_end) {
>> -		struct bio *split = bio_split(bio,
>> -			zone->zone_end - bio->bi_iter.bi_sector, GFP_NOIO,
>> -			&mddev->bio_set);
>> -
>> -		if (IS_ERR(split)) {
>> -			bio->bi_status = errno_to_blk_status(PTR_ERR(split));
>> -			bio_endio(bio);
>> +		bio = bio_submit_split_bioset(bio,
>> +				zone->zone_end - bio->bi_iter.bi_sector,
> Can this ever be negative (of course not I think)? But if
> bio_submit_split_bioset() is changed to have an unsigned int sectors count,
> maybe add a sanity check before calling bio_submit_split_bioset() ?

Yes, this can never be negative.

Thanks,
Kuai

>
>> +				&mddev->bio_set);
>> +		if (!bio)
>>   			return;
>> -		}
>> -		bio_chain(split, bio);
>> -		submit_bio_noacct(bio);
>> -		bio = split;
>> +
>>   		end = zone->zone_end;
>> -	} else
>> +	} else {
>>   		end = bio_end_sector(bio);
>> +	}
>>   
>>   	orig_end = end;
>>   	if (zone != conf->strip_zone)
>

