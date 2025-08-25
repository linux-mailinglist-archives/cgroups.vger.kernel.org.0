Return-Path: <cgroups+bounces-9377-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61049B33D3E
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 12:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2204D483FF9
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 10:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5CE2DC355;
	Mon, 25 Aug 2025 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0gqOi4ZW"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE4F2DAFDA;
	Mon, 25 Aug 2025 10:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756119214; cv=none; b=Ool3I920kaRY8foN1oEL1zbVFlAz7B3MaBBe1/BYfWSFjN/cosGR2BXWa0rUtlcct4tPAciJ+jl1iH5w1rT/EWFhq1eoZlToyLX3iv3nX6GoHw4JdaZJB4A91F5HXsu3F/1LxySXBEaNooLA+OOGlODpgFc6vs+3YcxheHpyv7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756119214; c=relaxed/simple;
	bh=9i23GRRPAeysHMcSzhzEMBkwiF4+rOhXgj7ZsUmqrnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GB8qKGJLa9mcr744yqYRLWv4VnXeahuXlBIBjqLvZbBr5koBFn5/T7+CwysC9NOKK1OCuu5SBA0rsZb+mRFmzaAsD1wF9rGDH6l7ScOryQ1NtQonDg0I+L2zioM/+pu1eeoBG6sQNqtbkOx3Cny95nFxrOgYFgJ2AX+yZJG4/lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0gqOi4ZW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6XFPlhRGrLMbqZYr/NESjliKO8yOhmaJETTR2cZFYRc=; b=0gqOi4ZWPzv3qDc2urheKfPrP8
	NgJHLMvH9YtxWytJQ7Yj2Qiujhk6E8e0TKVNUeQbe2zZFOIIEk4xRjMaiMCDDq1uWvcMlYxtmritE
	pdh4sqylWH9juncEihbHIlDFxBrpezxPV4ZhcLYGqTqk4V0ARUPjgNWyvNACu3NQ3f6Y223zaALW3
	vPo2MxIFtsyPkRBvl1l8viYFWyNVZ2DG6bAX0faPVEVsijxlfNl16S7ZRtrQuE5Pkat9fsIfmXuCe
	OZdpSn0d9sYrh2qX/HNQfv+VBuT5N5Um0vjwR5eQhIwJ0hbaWytOYB3CImmZwBfWYd21c4k6lTpkx
	suF8tXbg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqUpK-00000007gNK-1g1J;
	Mon, 25 Aug 2025 10:53:26 +0000
Date: Mon, 25 Aug 2025 03:53:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@infradead.org, colyli@kernel.org, hare@suse.de, tieren@fnnas.com,
	axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
	song@kernel.org, yukuai3@huawei.com, akpm@linux-foundation.org,
	neil@brown.name, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH RFC 1/7] block: export helper bio_submit_split()
Message-ID: <aKxApo1u8j-ZNOaI@infradead.org>
References: <20250825093700.3731633-1-yukuai1@huaweicloud.com>
 <20250825093700.3731633-2-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825093700.3731633-2-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 25, 2025 at 05:36:54PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> No functional changes are intended, some drivers like mdraid will split
> bio by internal processing, prepare to unify bio split codes.

Maybe name the exported helper bio_submit_split_bioset and keep
bio_submit_split() as a wrapper that passes the default split
bioset to keep the code a bit tidyer in blk-merge.c?

> +struct bio *bio_submit_split(struct bio *bio, int split_sectors,
> +			     struct bio_set *bs)
>  {
> +	struct bio *split;
> +
>  	if (unlikely(split_sectors < 0))
>  		goto error;
>  
> -	if (split_sectors) {
> -		struct bio *split;
> +	if (!split_sectors)
> +		return bio;
>  
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

Maybe skip the reformatting which makes this much harder to read?
If you think it is useful it can be done in a separate patch.


