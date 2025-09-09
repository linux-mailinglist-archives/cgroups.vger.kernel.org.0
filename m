Return-Path: <cgroups+bounces-9817-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1D5B4A4B2
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 10:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2AA94E6FB9
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 08:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D3C246762;
	Tue,  9 Sep 2025 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SljpdQUT"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A8F24467E;
	Tue,  9 Sep 2025 08:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405557; cv=none; b=ANch3ULzIWDc28IVosjoL7JMn/RnVW4XyZoCSb9N7IxyP63AnepH1Qyj5br6e75H+g6pvpHG8q2nzD5De45hXZnL6UyBhAIR0JWhVLSpnILSNZhLciDAz10RhKL52DxpY34hkY1uz2Np2qWMoOCNujybFXNh4j6fCdDFByjB0Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405557; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iglSeZqDNN/2LkiRBegyjmuFjd8vlLpNfsLjmcYw/rYIVnAkFtIaHnPtSo98Ks0jC/iBAa9ZxvmgjkVOO+35BxTn7OqPt/nb4/Xsh7MaNBIdaPLwZVtowRqCGAfiDHzrtHRAiWdleBNNBA1fNFVgdR7P5aMEgd6tl6wMnCJJWmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SljpdQUT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=SljpdQUT4F7S/a1kCIX5er5SN6
	12Y9NoIAy3BQESN2snLB5YKmdb8d/rbEcZFx/1LD9UAS9QsodJJlKCkfWKD11AqTxf11Ya27a8d3Z
	tHxO294djQM/lhcryUiWMtPoRv5YzKje5SsYE3EFFk1dq3R0CawsCOw1ruWPyYp+uVcLdwA3GLyym
	FieYhrzDGaT67/Qxgx1DFhLDI6bJn/bdbpLh7ZkBYHccbFpuUjF6o6+w599Jc95ENZ8HLNp9b9Yfn
	UofgecGE/29jzZJ1wtP/iq+D9+kri6kn4LSAX6ndan/UofAQkFbSJZKX8G3axCNx+V63mR4kywf4l
	tQD6AbKg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvtSn-00000005TuN-1YKD;
	Tue, 09 Sep 2025 08:12:29 +0000
Date: Tue, 9 Sep 2025 01:12:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@infradead.org, colyli@kernel.org, hare@suse.de, dlemoal@kernel.org,
	tieren@fnnas.com, bvanassche@acm.org, axboe@kernel.dk,
	tj@kernel.org, josef@toxicpanda.com, song@kernel.org,
	yukuai3@huawei.com, satyat@google.com, ebiggers@google.com,
	kmo@daterainc.com, akpm@linux-foundation.org, neil@brown.name,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-raid@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH for-6.18/block 03/16] blk-mq: add
 QUEUE_FLAG_BIO_ISSUE_TIME
Message-ID: <aL_hbWgyStTgomZJ@infradead.org>
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
 <20250905070643.2533483-4-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905070643.2533483-4-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


