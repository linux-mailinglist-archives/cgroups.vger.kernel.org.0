Return-Path: <cgroups+bounces-2835-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7598C0FB9
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2024 14:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 071D1B22CAF
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2024 12:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1042D13BC04;
	Thu,  9 May 2024 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ee/2otxe"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F25513B2BB;
	Thu,  9 May 2024 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715258409; cv=none; b=rMF8CZatXp46Vkf1Gniy7fih2RCbFo1vnSwGDTnPwzcv96gKkiPSvG6YwAkHGiK5MfQ3Z2YGZ769mE8F1DLlBw+f2VMuhFltFY1ndhaUpTgyeQ5sk/y4WyVzBPVl5f7kYOYshGC9vFDKokCZyvYHpNEJWznnAgk91PFfqGDBQeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715258409; c=relaxed/simple;
	bh=o4EJzw5BUXuBgoy2uU4zb1qMLA37I4KNAPe8azdAsNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdxdhDeNnXWjmQGNtV4e7YlWadJAOU+vZg0hYOTC4Ip/kBGHZhePfbn0K3Nh1T+0VTprg9EZZWYCuCKr3Yuw8sCujWm2tDUlD1CvsraJkWsuDhM7Xqu3ovDZ+d/tEjkUzQRQFJsdhWelrX9osv2joFyhy7dGRJbC1y5mAI5coCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ee/2otxe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P/Yh6fmWOx0S3hHFDnR/3XNxSMU0c5O7DQ9VhEI3qZ4=; b=Ee/2otxepDaoDyWBcWwFyiIctq
	nqoj0uR7R7rKU2RVLehLlBSEbFOIzg3Ei49vP9t0eZfHXbnK7Clo4ViqVb2Eja8jvDoFoOTO7KzS2
	mx0+KGb840gHS36HB/TO+kOV3kAi9xSNAap53ofcOVYJn54tWWpd/4UJL62TiOyvKVqCS9AMgY1H1
	E8R41KbrN0wd6lmELud0Aer8PlF9GNud2sqoOAkxfMREoWS8Fpdn+2hR+mRQyF706nSm7HCCNFC7P
	sKuzRooBCw5ovFR3K20jpikuGw2ivt218HNx5m6JJwCgrgrc3OArj4I8OPVW2Pp+0bUA1SLr+L/1P
	3czW+isA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5343-00000001STi-2Jqg;
	Thu, 09 May 2024 12:39:59 +0000
Date: Thu, 9 May 2024 05:39:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, Zhaoyang Huang <huangzhaoyang@gmail.com>,
	steve.kang@unisoc.com
Subject: Re: [RFC PATCH 2/2] mm: introduce budgt control in readahead
Message-ID: <ZjzEH5fFGHgnqbLj@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +	unsigned long budgt = inode->i_sb->s_bdev ?
> +			blk_throttle_budgt(inode->i_sb->s_bdev) : 0;

The readahead code is used for all file systems, you can't just call
into block layer code here.


