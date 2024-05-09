Return-Path: <cgroups+bounces-2830-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DB08C0A05
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2024 05:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3C41C215E0
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2024 03:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7302713C3F9;
	Thu,  9 May 2024 03:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a9i7tfdE"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CD98593F;
	Thu,  9 May 2024 03:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715224548; cv=none; b=kao8Kmjb9bgBK2ha5Ooc0AZEhLpF3PWD9YiaFG3fhXXnH0mvwUxTR0C+BS024G2bpf9ytSmshti8+4dvxKU53awErWEeGM1k5HKG66cw9F0HVnMriY6CULKKK4eUOEf5e0fKcT7LKojqHQW7bBVB2ICt5m6BzCrqyvMv29ZNHPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715224548; c=relaxed/simple;
	bh=CGIq7jyOB8znUivjHG+vO6j8CqP28PE4BYFYgt3YL6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCuqiHD2uxAogvWRSEP5FEPjT9SNoTD9U0L5wlp7gGFM6UI6Gzpfy6ct0YqBT37cNAIoAXFANuAIeFbx8UK5uzPqfSrJ0TGlvwnh9GZMNGW/guOlNRN6atyPpP96SmNp0N233EqmITSg6P1hTSNfYsFmG2B0EZJcFCIFuHm/Cs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a9i7tfdE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/wu4YXBKwfk99ZTZ+xV3JcQCiIw42eOgTlfbES8hZQw=; b=a9i7tfdEdRkT7XmPd9BnxJ8hzM
	ONnvBogV90YxNQ6vnro/R048i09qg+UAV4VNCHpXAI7nW2kaYPOXPHLD+SA8/oHPU4pmXZ0/hEJ08
	zm9frcbKsJieQbMCGoipP8IknzFc4rCR8muf0yCbcjqTmy4MJjJsYQa/sAkYCd/RiCb2ZXFMmhlF4
	RDVOE0t7v+8L3t0jYiNuodUxRRE40kgZgfVFDMZj5Xg2LtZ+GKpm98bkDuuDD6fa+ED3P5x/ivHTH
	9peCi8ZhzjwwH1KbapJfwjPdbBR6E4ay0oS+AWcqI679kBivAazPbe295afDCciiBN+6nOt8yJAzY
	3b7K/3pA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4uFl-0000000H6iy-2Cag;
	Thu, 09 May 2024 03:15:29 +0000
Date: Thu, 9 May 2024 04:15:29 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, Zhaoyang Huang <huangzhaoyang@gmail.com>,
	steve.kang@unisoc.com
Subject: Re: [RFC PATCH 2/2] mm: introduce budgt control in readahead
Message-ID: <Zjw_0UPKvGkPfKFO@casper.infradead.org>
References: <20240509023937.1090421-1-zhaoyang.huang@unisoc.com>
 <20240509023937.1090421-3-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509023937.1090421-3-zhaoyang.huang@unisoc.com>

On Thu, May 09, 2024 at 10:39:37AM +0800, zhaoyang.huang wrote:
> -static unsigned long get_next_ra_size(struct file_ra_state *ra,
> +static unsigned long get_next_ra_size(struct readahead_control *ractl,
>  				      unsigned long max)
>  {
> -	unsigned long cur = ra->size;
> +	unsigned long cur = ractl->ra->size;
> +	struct inode *inode = ractl->mapping->host;
> +	unsigned long budgt = inode->i_sb->s_bdev ?
> +			blk_throttle_budgt(inode->i_sb->s_bdev) : 0;

You can't do this.  There's no guarantee that the IO is going to
mapping->host->i_sb->s_bdev.  You'd have to figure out how to ask the
filesystem to get the bdev for the particular range (eg the fs might
implement RAID internally).


