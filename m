Return-Path: <cgroups+bounces-9547-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 044A9B3DA2C
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 08:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1AE16F2A7
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 06:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D4D2472BC;
	Mon,  1 Sep 2025 06:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfa3FHBd"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3470C212556;
	Mon,  1 Sep 2025 06:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756709166; cv=none; b=AvP0Tv5gkuoFoGRELLE+CWyj9HrjMacR0iC/HCOeG+gCfYIx8wJ/GlFVvRvoCL6rYBbchdsynqMBja5AfguUwva/QKqM8p4z2fK2xJ5BHPvF0IPbv+erkZqQ920w55Ldc9gV26MbpUFHrBY7iNMALKPf4Rw507qpcb2oBWYcjqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756709166; c=relaxed/simple;
	bh=X2GCkYyQOfwSHl/aSR0IV35FfoaQULmEkq2Kt26dOSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i3fRbJQ9Fuomx5KImc1jrOoJn2Cec+5Nj/w85MDTl6GgaHcXee7WtQwu6BCz9wpJ4M9jrPxSsnaF1XtIGo7tP7TfbRBKBB9UIxhR90BLegaCUsHsyD+jgLz3lXI6vfaGVFKKTrowH2wy0XzKHqKMfigQhfco25wJ8FTwLO5rTJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfa3FHBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40841C4CEF0;
	Mon,  1 Sep 2025 06:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756709165;
	bh=X2GCkYyQOfwSHl/aSR0IV35FfoaQULmEkq2Kt26dOSs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tfa3FHBdEk3nw/gaelP270KbUvclYJGWxo5WfWjJn8vITFt+6gdYzTnqRfAMQihdm
	 juSzVw5zanTh8J6DeP2EwlSYa4BX6ucc16TBT49B13nrBsJPvosIZ+MnrRck+fTSP7
	 0i4dp5oYPwk2qQXKUosesEztD2n4qXma0QkJUMbSUv29SQPvHnaS76WvCyqhgWO/5A
	 q/o1Xor5bKmBKk8la0A0VOKn1xNTG8jLjkbKYGe9LJuTJFOJP9W7ttqI+BDJwYYL1H
	 tMYXb2NVlWkX61Am7YjObnl21R2ct7pVNLxPGxO3PCNt/blSI5PkuGE56Naze4FP4n
	 5hmLscojRiFCw==
Message-ID: <9b9b78cd-06aa-407d-a224-a5903752599f@kernel.org>
Date: Mon, 1 Sep 2025 15:43:09 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 07/15] md/raid1: convert to use
 bio_submit_split_bioset()
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, tieren@fnnas.com, axboe@kernel.dk, tj@kernel.org,
 josef@toxicpanda.com, song@kernel.org, kmo@daterainc.com, satyat@google.com,
 ebiggers@google.com, neil@brown.name, akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-8-yukuai1@huaweicloud.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250901033220.42982-8-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 12:32 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Unify bio split code, and prepare to fix disordered split IO.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

[...]

> @@ -1586,18 +1577,13 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
>  		max_sectors = min_t(int, max_sectors,
>  				    BIO_MAX_VECS * (PAGE_SIZE >> 9));
>  	if (max_sectors < bio_sectors(bio)) {
> -		struct bio *split = bio_split(bio, max_sectors,
> -					      GFP_NOIO, &conf->bio_split);
> -
> -		if (IS_ERR(split)) {
> -			error = PTR_ERR(split);
> +		bio = bio_submit_split_bioset(bio, max_sectors,
> +					      &conf->bio_split);
> +		if (!bio) {
> +			set_bit(R1BIO_Returned, &r1_bio->state);

Before it was "set_bit(R1BIO_Uptodate, &r1_bio->state);" that was done. Now it
is R1BIO_Returned that is set. The commit message does not mention this change
at all. Is this a bug fix ? If yes, that should be in a pre patch before the
conversion to using bio_submit_split_bioset().

>  			goto err_handle;
>  		}
>  
> -		bio_chain(split, bio);
> -		trace_block_split(split, bio->bi_iter.bi_sector);
> -		submit_bio_noacct(bio);
> -		bio = split;
>  		r1_bio->master_bio = bio;
>  		r1_bio->sectors = max_sectors;
>  	}
> @@ -1687,8 +1673,6 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
>  		}
>  	}
>  
> -	bio->bi_status = errno_to_blk_status(error);
> -	set_bit(R1BIO_Uptodate, &r1_bio->state);
>  	raid_end_bio_io(r1_bio);
>  }


-- 
Damien Le Moal
Western Digital Research

