Return-Path: <cgroups+bounces-9496-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE71B3C6C0
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 02:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D028616A876
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 00:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5FF1D514B;
	Sat, 30 Aug 2025 00:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwQYf4vi"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A752AE84;
	Sat, 30 Aug 2025 00:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756514890; cv=none; b=nnPxDzOYSusyrfQCEdoG9vjfcHx9OkRkfIki3DnwC15XnPjRD+TVI1CFgl813vP5+phANTR9+gyocYUXLzhqYlVu8XbfdvOQZAXIoxCAi+w3sv04KLKpyU/H5pZz/NraVYpV+tp3DH2c121PbX/XVkd/F03AMkA6SDSechVJDsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756514890; c=relaxed/simple;
	bh=SAHs12AkD+bfcgVL/vhmtYv3cPO6zdFftMLJ/bIJzaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Njl6kyB9hJ8iZmi62yjS58qdmNFIiGoZKpp3uiNrDHUPcKTNYvCOAWN6lKLdy1bCtxxS3mxOAMt8mP3djb1o7V9DuZo9FouibxZpjPuM6BdzooINIoYxAsmvNE27T3j4Ue80oavDDZmoQf2OX5EQJffu0T7LfP0OWOlpXoQ7eXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwQYf4vi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E41C4CEF6;
	Sat, 30 Aug 2025 00:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756514889;
	bh=SAHs12AkD+bfcgVL/vhmtYv3cPO6zdFftMLJ/bIJzaw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MwQYf4vi7F1sjZOvcuD5HfZA8pqu5sZtm5kFTBcV4XKXj3ZE/vUQwHAch5jNHiyjn
	 pK/6TfJqjDG/uvHX6uB1DcUXTsJmjxbqnHHgA6M1s+qn3OiH781YQFS3Y7MIxPfT77
	 izdXHlAezQKFJ5S8Ygi44lx0fjm8ozCv51dudE53Vpk+3xcDamoci4uR5EhkzSg16Q
	 jWxdNsjo+MpNCPVjCJ7PjeZ/uiLr9E3Lt3BPwMQRXc8AY3TaxXlrFPcyb0GTs+tPOt
	 3za3AdmiZFC5gtcLmO96L+fpJqHCjuLR3IPXOMW3gGs1VAXCRrIl0vm6ZDwlvDflBq
	 T9mHVjdjII/wg==
Message-ID: <79a8e41e-c228-44e9-8286-1b2d7b3687a4@kernel.org>
Date: Sat, 30 Aug 2025 09:48:05 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 04/10] md/raid10: convert read/write to use
 bio_submit_split_bioset()
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, tj@kernel.org,
 josef@toxicpanda.com, song@kernel.org, neil@brown.name,
 akpm@linux-foundation.org, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, tieren@fnnas.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250828065733.556341-1-yukuai1@huaweicloud.com>
 <20250828065733.556341-5-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250828065733.556341-5-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/25 15:57, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> On the one hand unify bio split code, prepare to fix disordered split
> IO; On the other hand fix missing blkcg_bio_issue_init() and
> trace_block_split() for split IO.
> 
> Noted discard is not handled, because discard is only splited for

s/splited/split

> unaligned head and tail, and this can be considered slow path, the
> disorder here does not matter much.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/raid10.c | 51 +++++++++++++++++++--------------------------
>  drivers/md/raid10.h |  2 ++
>  2 files changed, 23 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index b60c30bfb6c7..0e7d2a67fca6 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -322,10 +322,12 @@ static void raid_end_bio_io(struct r10bio *r10_bio)
>  	struct bio *bio = r10_bio->master_bio;
>  	struct r10conf *conf = r10_bio->mddev->private;
>  
> -	if (!test_bit(R10BIO_Uptodate, &r10_bio->state))
> -		bio->bi_status = BLK_STS_IOERR;
> +	if (!test_and_set_bit(R10BIO_Returned, &r10_bio->state)) {
> +		if (!test_bit(R10BIO_Uptodate, &r10_bio->state))
> +			bio->bi_status = BLK_STS_IOERR;
> +		bio_endio(bio);
> +	}

This change / the R10BIO_Returned flag is not mentioned in the commit message.
Please explain why it is needed to add for switching to using
bio_submit_split_bioset(), which in itself should not introduce functional
changes. Looks like this needs to be split into different patches...


-- 
Damien Le Moal
Western Digital Research

