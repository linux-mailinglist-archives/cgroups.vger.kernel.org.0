Return-Path: <cgroups+bounces-3188-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A166290834D
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2024 07:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B72011C22166
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2024 05:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A22F146D6E;
	Fri, 14 Jun 2024 05:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EWtWXOa9"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171A2132103;
	Fri, 14 Jun 2024 05:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718342784; cv=none; b=oqNeIyfMXzK3DAvwAMbonWWEA3pCbg2L34ZCvveEytYRqtAoKISpcQeQj3nAkwGRUrxmiUbmTmsITVN2TJls3kfUsdj06NHNqcTP7ahqkDe3/RK+AAHoVt1Bcl+aPNzp4oXhb2w7hk89cXDLs+6AzHD6xaBSZ3EmCm83kH+y11s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718342784; c=relaxed/simple;
	bh=jr7Ap2IP3QYunItd2NlDGtEVWiPNSAmvpepfyuZkA9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oavYwQD7SpFf+3nYfC52UIwuLuQsYty6in9WHilWI6rEJjZjiVnMXSK2x9CGmDsnARIk6Vq9bGi8xHPH6R99wXf1DqYbG359g+f5i5CjwoMlAZLZMPpnAJJ12zL2oFsFn9bEpZiQxRP0mwEMfeylwsrglf/ZmtzmbPeIqnek0x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EWtWXOa9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=scQGN4oo9DV9/0Yr3EcBEalr/rggPy0NTj8kWFOcDvk=; b=EWtWXOa91hHymd7bkisEdPPxDn
	gj8Gfvk1HeBvlxvt6GK7Vhua6lVat6Fy3FPJuLoN1BGIKo56TXGEgBB7GiDOpzU7iwJhbXfdRwv+Y
	1rRJz5e/9qLGe1NXHJe0CgLmiHbw8bwftGr+zW3jWfmXQLW2vFc1w7ynFAOmkpZRgS5I6XFfcVE4+
	4SDSEoNRdk7HKMkCf45r4rIK4VW4vEfBHPGnvJ4HdR/jBuBY/Jre5WyZwFXHJsyDyrqsH+k3I+fmc
	0DLkfAN4vyFJ/LHgDOkgyBitv5k+0S86qunFg5s4b6UST4eH+QNeQr4/PuLgyVz8B447agj4pVf+S
	dcdciC4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHzS4-00000001VFj-2DOJ;
	Fri, 14 Jun 2024 05:26:16 +0000
Date: Thu, 13 Jun 2024 22:26:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
	gregkh@linuxfoundation.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH RFC -next 0/7] blk-iocost: support to build iocost as
 kernel module
Message-ID: <ZmvUeNI4jF3f_seK@infradead.org>
References: <20240613014937.1326020-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613014937.1326020-1-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This cover letter is a little, erm, sparse.

Please explain why you want iocost as a module.  This adds a whole
lot of infrastructure for no obvious reason.


