Return-Path: <cgroups+bounces-3226-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2E690C472
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 09:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1AB283748
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 07:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DBF139584;
	Tue, 18 Jun 2024 07:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VPdACAh2"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576CB78685;
	Tue, 18 Jun 2024 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718694863; cv=none; b=sKq0TSJ/YI66EWZxM1eqxL08srhfdzb6Q379lYvRGMxuY8uhCThUDwPuN4FUOYdY2GJ4idd4cn4jNyaA+TYycwJ1+bEo7cTun7GLsAg0755liDnkSb0KmsZTvORYjWnwokWT6NanDPuh/wlDepgVHtHsLpWrrrty7iW2Bn8IT/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718694863; c=relaxed/simple;
	bh=wowTK5TYToslKW5XGholQeFgdh+7aoc4XItg7czlNDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwuqcxnmyQAQRMiwXpjy+blelLvtQNTYaNtRHFqeoZ4Fwa74Hf4ohKUGOyHYamf/HXYqqdcCyUB4mVSZYqX0rdrCf+S2+Lx80O7XP+JZqBEhzW5X3+j6bo1wZQQ+TU2Nyh5e0f+Mo1AVHCZiF38hscc8IdSBXJKy6Q1fHZ4DG/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VPdACAh2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f5X5UKrMFaaMGdpeomrAuXRRk/Mpc59vJz2yey6mys8=; b=VPdACAh2UixWVDsuISGGQP0Nhb
	Os90zluy+hybYIynlqgAkn4I+WUhvFEfEIF6eLaNsH1mt0+7LRp5MVP+UBb/Hc9XfXsBSR/ZlM48C
	C9OFMCHx4O2nZrdrerFxqGKh9p7vFxPOW88AvZm4lzK5LneJ1q2H6ibLos+yg19ykYMUXsGit9rV7
	EdpIdzCJA2/rY9EuMyaUQK5co2Dq3hRzkOsLNyc/krZjM6e0fi4OgpxRFrR9liQ284+mlW8MDXL2z
	XJyW6TmhLsr2BJCK1Lh1zVaIYGm1uGBOoIbWJ6ge2fFwzehMFW8Iw7d8mthEXPYtZDRoEuPk027gN
	K5X7KqOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJT2m-0000000DvGq-4056;
	Tue, 18 Jun 2024 07:14:16 +0000
Date: Tue, 18 Jun 2024 00:14:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, tj@kernel.org, gregkh@linuxfoundation.org,
	bvanassche@acm.org, hch@infradead.org, josef@toxicpanda.com,
	lizefan.x@bytedance.com, hannes@cmpxchg.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: Re: [PATCH RFC v2 3/7] block: export some API
Message-ID: <ZnEzyJW9WAX0Rjsx@infradead.org>
References: <20240618031751.3470464-1-yukuai1@huaweicloud.com>
 <20240618031751.3470464-4-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618031751.3470464-4-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 18, 2024 at 11:17:47AM +0800, Yu Kuai wrote:
>  bool blkcg_debug_stats = false;
> +EXPORT_SYMBOL_GPL(blkcg_debug_stats);

exporting variables is lways a bad idea.a

>  
>  static DEFINE_RAW_SPINLOCK(blkg_stat_lock);
>  
> @@ -688,6 +689,7 @@ const char *blkg_dev_name(struct blkcg_gq *blkg)
>  		return NULL;
>  	return bdi_dev_name(blkg->q->disk->bdi);
>  }
> +EXPORT_SYMBOL_GPL(blkg_dev_name);

And this helper is just horribly to be honest.  The bdi_dev_name
should not be used anywhere in block code, and something like this
certainly should not be exported even if we have to keep it for
legacy reasons.

>  /**
>   * blkcg_print_blkgs - helper for printing per-blkg data
> @@ -815,6 +817,7 @@ int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
>  	ctx->bdev = bdev;
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(blkg_conf_open_bdev);

This again is a horrible function papeing over blk-cgroup design
mistakes.  I absolutely should not be exported.


