Return-Path: <cgroups+bounces-3791-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 149EC937347
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 07:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1471F22751
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 05:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236FB3EA6C;
	Fri, 19 Jul 2024 05:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xWnZvH4F"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA44239FCF;
	Fri, 19 Jul 2024 05:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721367032; cv=none; b=KSQAMT2rjmkMF4Z7s4UrSo9GGW0jXbPBAAnOnhR+KxZDfmYD9dFP3OPDOikP1LtwCeowLY+IZIncSVaxS+c9sTD0YEMyIg+K6k+Iw7MJuBKVLKDmuxCu9v+5nXuft333tBhpuJj44cJde8+xKsLiPWpYm6zw5JkLZUjVHTQntks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721367032; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tehdeRZlFsc9SryoPA9+a2fnjS5m+y7RRKfJDemy/V2uRxb0uSXvnsnyYbOu7ngHjFbJZJiHyfXfICvjQOCS3AKDGEO57cAbEnwVH0RBHAp8ShvmW/lKKQ4btxW2qSJ5LecmqBDAitQTp9xXkYGKYedtfGf3lIYCoQF+TOl5URA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xWnZvH4F; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=xWnZvH4F0dX99gWjLxETStz7u6
	8QS8GYs0tF71QMPpsniHP9RChNBYfyZe3lsjZgtZiqNPSd+xzuptmFi9TqwHFPF0mIdYUajKj+IU/
	FG0IiahEx460HrAiy6paucdrnPKtkGzp1vcbu6Ss/1wu1IUm+2LXz+U0BR7HggpWNeMAj/VMr6tWR
	I2ztKfS/uchOjv3TXfMxdLszBVPVynd3ufHwis7Xj5PHtHWFbFKlKwV9p81cVGzb84rW8wwlhSZc6
	Z1NtIsrDG1ZaGY59DYljfmcY6UbGmgN14HSDw+LGmTv3kNrfwoN2/lbvarAyr1FP7aUkJXwLRCeGX
	GYOoa/Ew==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUgCK-00000001dxE-30wz;
	Fri, 19 Jul 2024 05:30:28 +0000
Date: Thu, 18 Jul 2024 22:30:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: bvanassche@acm.org, jack@suse.cz, hch@infradead.org, tj@kernel.org,
	josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 3/3] blk-ioprio: remove per-disk structure
Message-ID: <Zpn59HJReVZimOGj@infradead.org>
References: <20240719023431.3800647-1-yukuai1@huaweicloud.com>
 <20240719023431.3800647-4-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719023431.3800647-4-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


