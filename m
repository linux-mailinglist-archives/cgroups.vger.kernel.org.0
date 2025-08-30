Return-Path: <cgroups+bounces-9510-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCEBB3C7D8
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 06:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B40A07423
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 04:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A0D274B2A;
	Sat, 30 Aug 2025 04:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b="UteHdY2i"
X-Original-To: cgroups@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE1635961;
	Sat, 30 Aug 2025 04:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756527567; cv=pass; b=iohTiandJ0FD3N/orr8C8X260VGyd+z9b20ERg48Z8wpHtgaY8TryL1hfXF7dPkyKCFbYe+23oTbhRJB+8KPIuW1oKB5o9Umgupm9b0flreHGRlCS3ZX0SRtgSMETiUHVEYMXoUPEsowYPT+bVS51F1zRQu/xWRK3BTnbxlpEuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756527567; c=relaxed/simple;
	bh=TCkGINzbqH7a9l65OUWEhx0+JtKu+BvkOJnExjAXLqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kxljyFiidgQCGBdggSHA/qmd8k38WgjOyTSnWsflAwOvjIPEkZXuO/BkdVdaA4ADM403AXIzGGiAhajIKvrfXVM5mEiHQPEZN975Hl4FAjZprR4nQ9UNkym09lLDGqUHuWhu4vZ+E9EAQeZsb9jsZGbleYaGqRWEKNiJe8PmJGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yukuai.org.cn; spf=pass smtp.mailfrom=yukuai.org.cn; dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b=UteHdY2i; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yukuai.org.cn
ARC-Seal: i=1; a=rsa-sha256; t=1756527531; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=T2fN5dGVywPLGs6e8BEg2uO4U3oraWirh90S3WBS0uVLieFgTZ9yl0BG1/mwL++Ot3UZ4TRSKGgSbrPcWRdZH/m8bqh5GIeuB18YwphxAfs0xi7R61fVZWgCAL5zW7FjZ77FU8EsYx/OQee29xJ0LZQM45+Jebn28OwF7u1Ezq0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756527531; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yd3pcSTgWKwPvhTPloCS8SmKJun8c9SkXc2ED7Yn070=; 
	b=WfMGPxjC4CQhHNEqycQwwXvdkykqKSeb+LMyVRpXfrFP2gp/cacMbtWWg79eJ/USJP2Ih8pFYTsuVdts7nrPVx41bE+fnz2DJqQl6lC9Rvq0zi3CTGQC6oEiwDkjaEhnUUezwj68NGLGFHqwW3sWycztlbz599GdIBPnI/xALsE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yukuai.org.cn;
	spf=pass  smtp.mailfrom=hailan@yukuai.org.cn;
	dmarc=pass header.from=<hailan@yukuai.org.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756527531;
	s=zmail; d=yukuai.org.cn; i=hailan@yukuai.org.cn;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=yd3pcSTgWKwPvhTPloCS8SmKJun8c9SkXc2ED7Yn070=;
	b=UteHdY2iHNOz2wPnhckO9LEipJhFURu82mfV7tSW14wNCrRrIIhSnvLah4kvKup2
	7eVmE9Ie7fvU88wRaEr9OysCCkWIcka2egTBeX/yolAxlUSWSLMs+00u30+s8VDEtVj
	HztuMPBIpUWlZZ/pv7BPMLYVK/Si+E/2Z5bhygI0=
Received: by mx.zohomail.com with SMTPS id 17565275299460.340323630791886;
	Fri, 29 Aug 2025 21:18:49 -0700 (PDT)
Message-ID: <ce806a1a-2101-4bd4-a78c-5027aea9aa13@yukuai.org.cn>
Date: Sat, 30 Aug 2025 12:18:40 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 04/10] md/raid10: convert read/write to use
 bio_submit_split_bioset()
To: Damien Le Moal <dlemoal@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com, song@kernel.org,
 neil@brown.name, akpm@linux-foundation.org, hch@infradead.org,
 colyli@kernel.org, hare@suse.de, tieren@fnnas.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250828065733.556341-1-yukuai1@huaweicloud.com>
 <20250828065733.556341-5-yukuai1@huaweicloud.com>
 <79a8e41e-c228-44e9-8286-1b2d7b3687a4@kernel.org>
From: Yu Kuai <hailan@yukuai.org.cn>
In-Reply-To: <79a8e41e-c228-44e9-8286-1b2d7b3687a4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,


在 2025/8/30 8:48, Damien Le Moal 写道:
> On 8/28/25 15:57, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> On the one hand unify bio split code, prepare to fix disordered split
>> IO; On the other hand fix missing blkcg_bio_issue_init() and
>> trace_block_split() for split IO.
>>
>> Noted discard is not handled, because discard is only splited for
> s/splited/split
>
>> unaligned head and tail, and this can be considered slow path, the
>> disorder here does not matter much.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/raid10.c | 51 +++++++++++++++++++--------------------------
>>   drivers/md/raid10.h |  2 ++
>>   2 files changed, 23 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
>> index b60c30bfb6c7..0e7d2a67fca6 100644
>> --- a/drivers/md/raid10.c
>> +++ b/drivers/md/raid10.c
>> @@ -322,10 +322,12 @@ static void raid_end_bio_io(struct r10bio *r10_bio)
>>   	struct bio *bio = r10_bio->master_bio;
>>   	struct r10conf *conf = r10_bio->mddev->private;
>>   
>> -	if (!test_bit(R10BIO_Uptodate, &r10_bio->state))
>> -		bio->bi_status = BLK_STS_IOERR;
>> +	if (!test_and_set_bit(R10BIO_Returned, &r10_bio->state)) {
>> +		if (!test_bit(R10BIO_Uptodate, &r10_bio->state))
>> +			bio->bi_status = BLK_STS_IOERR;
>> +		bio_endio(bio);
>> +	}
> This change / the R10BIO_Returned flag is not mentioned in the commit message.
> Please explain why it is needed to add for switching to using
> bio_submit_split_bioset(), which in itself should not introduce functional
> changes. Looks like this needs to be split into different patches...
>
Ok, this is actually refered from raid1 flag, I can make this flag a seperate
patch :)

Thanks,
Kuai


