Return-Path: <cgroups+bounces-9626-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAED6B40BBE
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 19:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4211B63D84
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 17:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09DD341AAD;
	Tue,  2 Sep 2025 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="kHCEQrgc"
X-Original-To: cgroups@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AF52DF125;
	Tue,  2 Sep 2025 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833175; cv=none; b=XT2O76bT3vjr5s7Ds+IkRAfZQ8TEZfrSj5nXl2YRMLxL4HFnasPUDX6AWJLXv3brNQx2ZaQAlGCtnHBmi+kFSRTK0tselaHJV7UnS67ad8rgoQP5xuRmfPo+ckcT/JNVCTYHJK4dZwyVuDJjvv6I7WXGNCyTheWHnQoYBv8aIAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833175; c=relaxed/simple;
	bh=zzJ4wekw121HV+1LGlw+VZ9r4A+FYjx7cuGLxI/OQ4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7ePue024oN1hD5sEG313rFrJK2wA6IPtH0oc3Ta4NiJ3CE/tk3UEyw40mqTUn3Mrr5rODAKVdYoFTfJirH2C+UHQbMl+mndXBR03XmEKDK0OKMC13NEyhslE1YEsQf/8QlG8hwA5xhrmE+5MhAYWBb0xBf59ViddMXWT6eovOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=kHCEQrgc; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cGXPJ3h1MzlgqTx;
	Tue,  2 Sep 2025 17:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1756833161; x=1759425162; bh=XFMXx0YMZT0qYrjNa38S/JfC
	/6Gh0XKHLMBx0IhJc3w=; b=kHCEQrgcHOP0cXGScxkRefH4RWBnvO1Pvl8WUZXa
	EedK6qCuboEYrf/8uUzztnYX+aucyimV66B5cSmmONgJKjRVKUaoNnRyIF3D56qZ
	MfOoJJiKtlPg3TadG6AUP2P/hId/imbpiSeecP0Aei82dy1T5appjOOtcMdNEaYo
	maAylj64nfzIStGXoaT7ZxYnZfUBUekQ2VxLbciit6s2aZ9xi1s1jBsVC3xPTHbm
	DRJXDuXHVyC0B/lSfVugKbXDJIri5daEa/x1aQ60hnTG3LMZJiNO86ZfGOOWpFCJ
	5N0IJuzG0+Dkej1PvIAFM3fwiVkbHbG9IzsYOWCQFE8rdQ==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id mhqwayppvs84; Tue,  2 Sep 2025 17:12:41 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cGXNn2JDCzlgqTq;
	Tue,  2 Sep 2025 17:12:24 +0000 (UTC)
Message-ID: <4f54d81a-d330-44b2-b667-3b13d516c576@acm.org>
Date: Tue, 2 Sep 2025 10:12:23 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 05/15] block: factor out a helper
 bio_submit_split_bioset()
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, dlemoal@kernel.org, tieren@fnnas.com, axboe@kernel.dk,
 tj@kernel.org, josef@toxicpanda.com, song@kernel.org, kmo@daterainc.com,
 satyat@google.com, ebiggers@google.com, neil@brown.name,
 akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-6-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250901033220.42982-6-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/31/25 8:32 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> No functional changes are intended, some drivers like mdraid will split
> bio by internal processing, prepare to unify bio split codes.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   block/blk-merge.c      | 63 ++++++++++++++++++++++++++++--------------
>   include/linux/blkdev.h |  2 ++
>   2 files changed, 44 insertions(+), 21 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 70d704615be5..e1afb07040c0 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -104,34 +104,55 @@ static unsigned int bio_allowed_max_sectors(const struct queue_limits *lim)
>   	return round_down(UINT_MAX, lim->logical_block_size) >> SECTOR_SHIFT;
>   }
>   
> +/**
> + * bio_submit_split_bioset - Submit a bio, splitting it at a designated sector
> + * @bio:		the original bio to be submitted and split
> + * @split_sectors:	the sector count at which to split
> + * @bs:			the bio set used for allocating the new split bio
> + *
> + * The original bio is modified to contain the remaining sectors and submitted.
> + * The caller is responsible for submitting the returned bio.
> + *
> + * If succeed, the newly allocated bio representing the initial part will be
> + * returned, on failure NULL will be returned and original bio will fail.
> + */
> +struct bio *bio_submit_split_bioset(struct bio *bio, unsigned int split_sectors,
> +				    struct bio_set *bs)
> +{
> +	struct bio *split = bio_split(bio, split_sectors, GFP_NOIO, bs);
> +
> +	if (IS_ERR(split)) {
> +		bio->bi_status = errno_to_blk_status(PTR_ERR(split));
> +		bio_endio(bio);
> +		return NULL;
> +	}
> +
> +	blkcg_bio_issue_init(split);
> +	bio_chain(split, bio);
> +	trace_block_split(split, bio->bi_iter.bi_sector);
> +	WARN_ON_ONCE(bio_zone_write_plugging(bio));
> +	submit_bio_noacct(bio);
> +
> +	return split;
> +}
> +EXPORT_SYMBOL_GPL(bio_submit_split_bioset);
> +
>   static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
>   {
> -	if (unlikely(split_sectors < 0))
> -		goto error;
> +	if (unlikely(split_sectors < 0)) {
> +		bio->bi_status = errno_to_blk_status(split_sectors);
> +		bio_endio(bio);
> +		return NULL;
> +	}
>   
>   	if (split_sectors) {
> -		struct bio *split;
> -
> -		split = bio_split(bio, split_sectors, GFP_NOIO,
> -				&bio->bi_bdev->bd_disk->bio_split);
> -		if (IS_ERR(split)) {
> -			split_sectors = PTR_ERR(split);
> -			goto error;
> -		}
> -		split->bi_opf |= REQ_NOMERGE;
> -		blkcg_bio_issue_init(split);
> -		bio_chain(split, bio);
> -		trace_block_split(split, bio->bi_iter.bi_sector);
> -		WARN_ON_ONCE(bio_zone_write_plugging(bio));
> -		submit_bio_noacct(bio);
> -		return split;
> +		bio = bio_submit_split_bioset(bio, split_sectors,
> +					 &bio->bi_bdev->bd_disk->bio_split);
> +		if (bio)
> +			bio->bi_opf |= REQ_NOMERGE;
>   	}

This is a good opportunity to reduce the indentation level in this
function by adding something like this above the
bio_submit_split_bioset() call:

if (unlikely(split_sectors == 0))
	return bio;

Otherwise this patch looks good to me. Hence:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>




