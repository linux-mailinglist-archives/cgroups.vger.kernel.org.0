Return-Path: <cgroups+bounces-9493-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C01B3C654
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 02:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BC3A7B6BF5
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 00:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEA41A9F93;
	Sat, 30 Aug 2025 00:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSxG71Tt"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8285C13C8E8;
	Sat, 30 Aug 2025 00:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756514258; cv=none; b=O8i9JPKqoBOeowrL2g18wfSVhXeNQ2u2nxPrT+IOmRtLZPgZ5rD6ZJOOhmBDt+yRTKhqmG4xepQmADn6XGMh2dTm3fqiYsw+qYSaSs0bnEXImf+AvDeSz8HHFkH9ZL6Z+iIsbLRQ9wu7S2yWJh90uwlKHKU0pWlzOBBUlxwAuuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756514258; c=relaxed/simple;
	bh=HMCOQtzivHiTO3zCuyHVTmWCo/Ogwr//9Ur73b26dG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RV2+Cep5aL1nzRGZWUcNMRmElwwpuhPq1iZUAJxI21JcHcDxzL4qoc/kyJfkvBGpFhOZ8ClNAfnAp7ML6JuZI3z15iqgt4+KTc54jYEc+WcRAKTBRbmGIZqCzWtAE7Ng9g/Z0ufdTUyZVRVhA1OlxCoFBRQ93Nz4LAP27GGsFB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSxG71Tt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49349C4CEF0;
	Sat, 30 Aug 2025 00:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756514258;
	bh=HMCOQtzivHiTO3zCuyHVTmWCo/Ogwr//9Ur73b26dG4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BSxG71Tt2X926rt5kXac1VAcECWix/2D8gUhC4pS5CUSSsUzl+L5s+McIBGjpQfOa
	 W4ESX9v7oYunpR1DPDGxBntRdBgu6vhSlswWkfnzNb0yyyx3Od70qAsSlsu9GYRKvN
	 MAQ2kEdR9N8V1xiYVx2OZ/4ktThVjGSeBPeTyOvkkxeZNvIpIJF0AyXYlsGXqYDqbj
	 dbZ2vEdklIZ+j1hjuH37kTwon4wTBrEt+JBiwOuTR+sAusnOOFjY3A/BhsSGFDQFQT
	 vnseaMW1MpuVXOYh/OABeA/39iuV/owaoOT0Wi/WH1D0OG7FVlgLRjYXYqp5PwUG6A
	 MOXNjNcTgbLlA==
Message-ID: <7f3c9c65-2386-4198-ae38-5b9444319ec2@kernel.org>
Date: Sat, 30 Aug 2025 09:37:33 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 01/10] block: factor out a helper
 bio_submit_split_bioset()
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, tj@kernel.org,
 josef@toxicpanda.com, song@kernel.org, neil@brown.name,
 akpm@linux-foundation.org, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, tieren@fnnas.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250828065733.556341-1-yukuai1@huaweicloud.com>
 <20250828065733.556341-2-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250828065733.556341-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/25 15:57, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> No functional changes are intended, some drivers like mdraid will split
> bio by internal processing, prepare to unify bio split codes.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good to me. A few nits below.

> ---
>  block/blk-merge.c      | 63 ++++++++++++++++++++++++++++--------------
>  include/linux/blkdev.h |  2 ++
>  2 files changed, 44 insertions(+), 21 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 70d704615be5..3d6dc9cc4f61 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -104,34 +104,55 @@ static unsigned int bio_allowed_max_sectors(const struct queue_limits *lim)
>  	return round_down(UINT_MAX, lim->logical_block_size) >> SECTOR_SHIFT;
>  }
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
> +struct bio *bio_submit_split_bioset(struct bio *bio, int split_sectors,
> +				    struct bio_set *bs)

While at it, it would be nice to have split_sectors be unsigned. That would
avoid the check in bio_submit_split().

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
>  static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
>  {
> -	if (unlikely(split_sectors < 0))
> -		goto error;
> +	if (unlikely(split_sectors < 0)) {
> +		bio->bi_status = errno_to_blk_status(split_sectors);
> +		bio_endio(bio);
> +		return NULL;
> +	}

See above.

>  
>  	if (split_sectors) {
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

I think that setting REQ_NOMERGE should be done in bio_submit_split_bioset().

>  	}
>  
>  	return bio;
> -error:
> -	bio->bi_status = errno_to_blk_status(split_sectors);
> -	bio_endio(bio);
> -	return NULL;
>  }
>  
>  struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index fe1797bbec42..be4b3adf3989 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -999,6 +999,8 @@ extern int blk_register_queue(struct gendisk *disk);
>  extern void blk_unregister_queue(struct gendisk *disk);
>  void submit_bio_noacct(struct bio *bio);
>  struct bio *bio_split_to_limits(struct bio *bio);
> +struct bio *bio_submit_split_bioset(struct bio *bio, int split_sectors,
> +				    struct bio_set *bs);
>  
>  extern int blk_lld_busy(struct request_queue *q);
>  extern int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags);


-- 
Damien Le Moal
Western Digital Research

