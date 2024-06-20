Return-Path: <cgroups+bounces-3242-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF77190FCFA
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 08:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82B51C20DAA
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 06:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A673C6AC;
	Thu, 20 Jun 2024 06:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="01ffPyud"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF26F38F82;
	Thu, 20 Jun 2024 06:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718866111; cv=none; b=YZj5eTFeS3LKkuqVXQ2byKAGN0gQhry0M7lNfXWI9nwlGgDmcVjlQwQoIMQNLzSo2V8Udo3EG5kXV9ibq93x2TRt3B71MfdKGe6/jytDgARjDOYB2HF/ss8jWTEHg8eGhQp5dElDTbN+d+zRofiQw8B/hc8b84siaJH1Dyz7qWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718866111; c=relaxed/simple;
	bh=EURGL1Rs3BdktP3BB0xtvce8eQsfhKCbDz44BOfgB4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zeziuefi+OKyBjD7Dz1huDjMmaDP+UdNMCA6eUCOjyIcdqsm8wMOwq3t6CK90LMBNLnesSYjx4/UmSn5iuzdyX3X87InLOFP6dteHuZC9RKPxmozm0HzoK+tCjqDquWHvKO18USjIJjR1M4olDoJTk53GAR69bShezcaB7TTRIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=01ffPyud; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5jgpDICmScrWTrO4VPVId37Kbw6KdjAcTNIFFr+6Bgw=; b=01ffPyudzC/VgkyjmjQOPwou+s
	1QzmQmXLrPXKUMSKu6oGIznZeINtfeyUrZZ2yxj9ICX9sRmgJ5ZA1HQ4I2JegSqZVxKv3Bi8nQtun
	67dMzxaYV8MdzA65jPyT4mpdSVwpwmk7wnsvE5XCHCMhYkkCkls3ai/yU/hobR0FM3A6uqD4Cm/Sw
	Q19MzuDWeSroLcv4b47sWjTrro4U0rR2rkEkiagMWy4+86GhPlAnB/9UuyP7Q8RFYZX4eErktfVwT
	WmbItLm0kxVmjX4cuHu3W9diD3d13pVIOkMNi6mwNm7DzaE/jsq94oncOR4xfIg+HTkJafazdmZH9
	dr4nDkCQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKBam-00000003r8E-17Bl;
	Thu, 20 Jun 2024 06:48:20 +0000
Date: Wed, 19 Jun 2024 23:48:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk, tj@kernel.org,
	gregkh@linuxfoundation.org, bvanassche@acm.org,
	josef@toxicpanda.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH RFC v2 3/7] block: export some API
Message-ID: <ZnPQtJE8VqgPjaLA@infradead.org>
References: <20240618031751.3470464-1-yukuai1@huaweicloud.com>
 <20240618031751.3470464-4-yukuai1@huaweicloud.com>
 <ZnEzyJW9WAX0Rjsx@infradead.org>
 <25110963-cc9e-7c9f-09b3-d57e4ce6109b@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25110963-cc9e-7c9f-09b3-d57e4ce6109b@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 18, 2024 at 03:58:54PM +0800, Yu Kuai wrote:
> There is already bigger helper blkg_conf_prep() exported, as used by bfq
> for a long time already, and this helper is introduced for code
> optimization, as iocost configuration doesn't need to access the blkg.
> 
> Perhaps this should be another discussion about "design mistakes",
> however, I'm not sure why. :( Do you have previous discussions?

blkg_conf_prep at least has some level of abstraction.

But at least my conclusion is:  don't make blk-iocost modular.  It's
far too messy to split out, and not really worth it.


