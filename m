Return-Path: <cgroups+bounces-9500-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46511B3C6DB
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 02:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C9BF5A114E
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 00:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D521E21E08A;
	Sat, 30 Aug 2025 00:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpYukbS3"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B152033A;
	Sat, 30 Aug 2025 00:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756515496; cv=none; b=ZRXWPlaqjtVGUfP0QCIR1/+jPYxJcAq3NGDb9JMxHdo1GoijQa70/qv0cYwdWD3I+bqJ2H3daAmeeeZOE5/+8YQ1iTN6QS85nE/24oSR9t/RdIcqbcLBLbiiwGGuZ66dXw8P/q51Eu0ZKsNdXt4sB5bGEvmJJuLVkp3v9cOlsVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756515496; c=relaxed/simple;
	bh=SwFkmd3ne4fgMM2GZ+aPrgC53xia/azjZYFKdft10SE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XlUmX9selsXYsC6/BMGkSXRezkiF0c2AQVd61uQJ4QvL3uiTBp0ixJVCKGNNMlQMrVz0ZomYAogIUgtCzWXeeiwV/sgZ2mPPJ0R61/TwR0ejjoHpUc0DI9jmQWX4CY8YA8w/7XWUiuLLMwqMfh2eFxbwavFul/7MZDCaT9pckG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpYukbS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581F6C4CEF0;
	Sat, 30 Aug 2025 00:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756515496;
	bh=SwFkmd3ne4fgMM2GZ+aPrgC53xia/azjZYFKdft10SE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cpYukbS3FUxbDQHb6vMXvgEHbxI6FcVANQz6/3faguy3SRpuf5lW9hsBwv0qHYtwm
	 jwq0yqCt5EWNB2yRQqSW0JQ4QQgk2IpCuQdeOp0rUtFU6/1fgsgFqElg5tHYVW7jsI
	 C15VAXaR7cFN+JbA1RCR1TaSXoYqbkxkm2Bl/QgW25hx3l4jy/4St5Sn2zlunOmtYw
	 /53UsFHa8+uTfpzKUSSpjd6ZICtAZr8VzvO/HsvAHxY+DXIC/U0Xncc1x+3z9+Z580
	 SM1Jk1sMAzVBLcB2DUQjnxigvaWuehccv2KcTx7AqIIyKgc387B5KsB3aVUpUldZZy
	 MKO9QGEeFoU8g==
Message-ID: <e116c5c4-55ae-4b8c-98ff-664115d70862@kernel.org>
Date: Sat, 30 Aug 2025 09:58:12 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 08/10] block: skip unnecessary checks for split bio
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, tj@kernel.org,
 josef@toxicpanda.com, song@kernel.org, neil@brown.name,
 akpm@linux-foundation.org, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, tieren@fnnas.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250828065733.556341-1-yukuai1@huaweicloud.com>
 <20250828065733.556341-9-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250828065733.556341-9-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/25 15:57, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Lots of checks are already done while submitting this bio the first
> time, and there is no need to check them again when this bio is
> resubmitted after split.
> 
> Hence factor out a helper submit_split_bio_noacct() for resubmitting
> bio after splitting, only should_fail_bio() and blk_throtl_bio() are
> keeped.

s/keeped/kept

> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-core.c  | 15 +++++++++++++++
>  block/blk-merge.c |  2 +-
>  block/blk.h       |  1 +
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 4201504158a1..37836446f365 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -765,6 +765,21 @@ static blk_status_t blk_validate_atomic_write_op_size(struct request_queue *q,
>  	return BLK_STS_OK;
>  }
>  
> +void submit_split_bio_noacct(struct bio *bio)
> +{
> +	might_sleep();
> +
> +	if (should_fail_bio(bio)) {
> +		bio_io_error(bio);
> +		return;
> +	}
> +
> +	if (blk_throtl_bio(bio))
> +		return;
> +
> +	submit_bio_noacct_nocheck(bio);
> +}
> +
>  /**
>   * submit_bio_noacct - re-submit a bio to the block device layer for I/O
>   * @bio:  The bio describing the location in memory and on the device.
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 3d6dc9cc4f61..fa2c3d98b277 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -131,7 +131,7 @@ struct bio *bio_submit_split_bioset(struct bio *bio, int split_sectors,
>  	bio_chain(split, bio);
>  	trace_block_split(split, bio->bi_iter.bi_sector);
>  	WARN_ON_ONCE(bio_zone_write_plugging(bio));
> -	submit_bio_noacct(bio);
> +	submit_split_bio_noacct(bio);

If this helper is used only here, I would just open-code it here as otherwise it
is confusing: its name has "split" in it but nothing of its code checks that the
BIO was actually split.

>  
>  	return split;
>  }
> diff --git a/block/blk.h b/block/blk.h
> index 46f566f9b126..80375374ef55 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -54,6 +54,7 @@ bool blk_queue_start_drain(struct request_queue *q);
>  bool __blk_freeze_queue_start(struct request_queue *q,
>  			      struct task_struct *owner);
>  int __bio_queue_enter(struct request_queue *q, struct bio *bio);
> +void submit_split_bio_noacct(struct bio *bio);
>  void submit_bio_noacct_nocheck(struct bio *bio);
>  void bio_await_chain(struct bio *bio);
>  


-- 
Damien Le Moal
Western Digital Research

