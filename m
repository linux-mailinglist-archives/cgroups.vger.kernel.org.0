Return-Path: <cgroups+bounces-9380-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24611B33D6D
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 13:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 174EE4E2FFF
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 11:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAEA2DFA38;
	Mon, 25 Aug 2025 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eDp1pgCR"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920212DF718;
	Mon, 25 Aug 2025 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756119595; cv=none; b=pTVyIyJuL1MTMnLX7I6ji3Cvm3SxCPowX8bQsJ97n8ldjoOuoBQWJflkZm07x4qX2LddqQOGCh0nSM/+6vWQiZYH1QH+taDQGqB6CTojojrSApe+zyGasOvaXLRFrypJ8pZlAvDCpkCEZkeeqkbKBSFWwTrWVmhY29bVlDjNTg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756119595; c=relaxed/simple;
	bh=NE/oUt4FZhoEw/ocfq6nV21k7MAbQEkQbUn1L5iwBuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sht1A/WwvM+oS5zgUq9UgqKQGA9yjUW7QLVOuN+IONrqOiVZhUN1pc5qr0nCFII1GqOwRsZ5YVEapkB2zD8RxR+Obv8O6thOqOcs/ES4Ixm1Y0tesbMQ6hpfRcfFN4MwJPxJIsVgYswdD3oPyksMNgbgoz2wxMv23MU25fGSxMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eDp1pgCR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Accbi8BLq0wS/3o1r+zPX83Yx0uWqpLSpVevxniwzLY=; b=eDp1pgCRWuX5vZ9LZRdRPZlL9q
	tIAKWkemLXAHTi6v8o2cJiMa6h+GtUvuffntcxKgwqVkLGh1hNBnhtKeqbbiiXOADXB2l+p0fKvVX
	KnpTeBn/flJ/6IiVtCUZJacixKYolYsTDKUtEM8Txuv+uQn2Hv9XxJv4U1P0olIsZvYTzp3Xy3Qxg
	NTP4ien2jOm192bfMr3SHq4A1ByWEwq4cgYFx5Gwa6cWKho/CoTloqoIEVzye+cFxaZX7gQgg7fN2
	t6CE+KNw4rGMgjQzDwMiC2zenXxTgQldyAQvHt1SzLUW6rWe9nDhy2CTG7+etSX/6kdtn8wi68zGd
	u1YVp0Uw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqUvV-00000007hL4-0eB4;
	Mon, 25 Aug 2025 10:59:49 +0000
Date: Mon, 25 Aug 2025 03:59:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@infradead.org, colyli@kernel.org, hare@suse.de, tieren@fnnas.com,
	axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
	song@kernel.org, yukuai3@huawei.com, akpm@linux-foundation.org,
	neil@brown.name, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH RFC 4/7] md/raid10: convert read/write to use
 bio_submit_split()
Message-ID: <aKxCJT6ul_WC94-x@infradead.org>
References: <20250825093700.3731633-1-yukuai1@huaweicloud.com>
 <20250825093700.3731633-5-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825093700.3731633-5-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

>  		allow_barrier(conf);
> +		bio = bio_submit_split(bio, max_sectors, &conf->bio_split);
>  		wait_barrier(conf, false);
> +
> +		if (!bio) {
> +			set_bit(R10BIO_Returned, &r10_bio->state);
> +			goto err_handle;
> +		}

The NULL return should only happen for REQ_NOWAIT here, so maybe
give R10BIO_Returned a more descriptive name?  Also please document
the flag in the header.

Any maybe yhe code wants a splitting helper instead of open coding
setting this flag in multiple places?

