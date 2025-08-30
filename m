Return-Path: <cgroups+bounces-9494-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 286A3B3C662
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 02:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66BBE16D456
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 00:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308EB1CCEE0;
	Sat, 30 Aug 2025 00:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiKl4dYT"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF571BD035;
	Sat, 30 Aug 2025 00:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756514467; cv=none; b=SxSPPNDUgfhIpdTYsfYy5Y4rRLGpwT6swp/gHZV7LvIbuxuSBPU7TPpmusZfl2mCwJmRB5tzsWWt4qDmOiOiOCfXovZ7g0jf1i8g8p1C0IJA0nfIl1y4jU96VWmIjlxQylEulGaAmqqB61C/AdcBBEOPt4Mw9blC/tYrmC+bQZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756514467; c=relaxed/simple;
	bh=SoapryM2i6WZOdZwNx2XDnWMOFrJMfTD6XH6dinFwxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/OE0FpdTTzYN9nQgVBHSF2td0TkYtHIF9xbPJaHhAQiBnCNMTRQAsz0errdRF8Ei2KXj5qd0AX1W55dJixb8LwE/f+xIR+kxXENV7gP11j3miPCozgcR5DvrsvzHPkMN9NW8kyi66Qw6rnXmPyx9/ZXAFwqNFo10YfKosRYWcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiKl4dYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBE5C4CEF5;
	Sat, 30 Aug 2025 00:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756514466;
	bh=SoapryM2i6WZOdZwNx2XDnWMOFrJMfTD6XH6dinFwxQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iiKl4dYT/lqiRAuutpKEx0TZmylfa7VAZx5bg6dEjfbuPOTx+zFnhJOsxDaJFb34S
	 LIxsgk1DXqyKeDWQHSGbqkQA8WBkAyoPCYLmW1DSfdUqsI+Bpn6Cn+1wDCXpqKpZq0
	 Jhe8YNcO4BQvqR31sufjoAHZmS5lxHtdsw6E6Boh/lXgxgev/YlgqfTYcPcuysMWGk
	 /L5PYxZPKLdvISu3Jz1OK4KDpZBVi+QAdPDSKytuWO0xhgoffdaUee7Rrx+aC790YO
	 fQsE0OY8ZZb3BNJ4yL3PrYgJ6uNBIxS15BkvIzqGWstgQosExv4u8ZsaTumZ/T/Lfh
	 9g5OlbBRXk9Zw==
Message-ID: <858e0210-1bbb-466b-98c3-d1a3c834519d@kernel.org>
Date: Sat, 30 Aug 2025 09:41:02 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 02/10] md/raid0: convert raid0_handle_discard() to
 use bio_submit_split_bioset()
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, tj@kernel.org,
 josef@toxicpanda.com, song@kernel.org, neil@brown.name,
 akpm@linux-foundation.org, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, tieren@fnnas.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250828065733.556341-1-yukuai1@huaweicloud.com>
 <20250828065733.556341-3-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250828065733.556341-3-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/25 15:57, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> On the one hand unify bio split code, prepare to fix disordered split
> IO; On the other hand fix missing blkcg_bio_issue_init() and
> trace_block_split() for split IO.

Hmmm... Shouldn't that be a prep patch with a fixes tag for backport ?
Because that "fix" here is not done directly but is the result of calling
bio_submit_split_bioset().

> 
> Noted commit 319ff40a5427 ("md/raid0: Fix performance regression for large
> sequential writes") already fix disordered split IO by converting bio to
> underlying disks before submit_bio_noacct(), with the respect
> md_submit_bio() already split by sectors, and raid0_make_request() will
> split at most once for unaligned IO. This is a bit hacky and we'll convert
> this to solution in general later.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/raid0.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
> index f1d8811a542a..4dcc5133d679 100644
> --- a/drivers/md/raid0.c
> +++ b/drivers/md/raid0.c
> @@ -463,21 +463,16 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
>  	zone = find_zone(conf, &start);
>  
>  	if (bio_end_sector(bio) > zone->zone_end) {
> -		struct bio *split = bio_split(bio,
> -			zone->zone_end - bio->bi_iter.bi_sector, GFP_NOIO,
> -			&mddev->bio_set);
> -
> -		if (IS_ERR(split)) {
> -			bio->bi_status = errno_to_blk_status(PTR_ERR(split));
> -			bio_endio(bio);
> +		bio = bio_submit_split_bioset(bio,
> +				zone->zone_end - bio->bi_iter.bi_sector,

Can this ever be negative (of course not I think)? But if
bio_submit_split_bioset() is changed to have an unsigned int sectors count,
maybe add a sanity check before calling bio_submit_split_bioset() ?

> +				&mddev->bio_set);
> +		if (!bio)
>  			return;
> -		}
> -		bio_chain(split, bio);
> -		submit_bio_noacct(bio);
> -		bio = split;
> +
>  		end = zone->zone_end;
> -	} else
> +	} else {
>  		end = bio_end_sector(bio);
> +	}
>  
>  	orig_end = end;
>  	if (zone != conf->strip_zone)


-- 
Damien Le Moal
Western Digital Research

