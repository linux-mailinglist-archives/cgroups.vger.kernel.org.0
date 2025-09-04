Return-Path: <cgroups+bounces-9696-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF83CB4317F
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 07:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812DB1C2229A
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 05:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3969229B2E;
	Thu,  4 Sep 2025 05:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v2nhIvAH"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C3D33E7;
	Thu,  4 Sep 2025 05:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756962605; cv=none; b=OJ5Qa8V/unoXrPUo+SVez5NOdApZth5O0wlIkez+7J9Dias06IL4aGQhAYpJsdgaq4qCjEjaoad+Y4WAu3p1lY3apHYdLKYCvpHPt35sHZ6yBTGRWkEfbRm2sOPRkX2KvLpSfX0WqhJn1dT+O4ecpLrus1RkuVSUxozYIsiA+ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756962605; c=relaxed/simple;
	bh=ydFs6i7keCMfBbD9quYtCVIwH9y+8boTcTxEbezuoqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAxvlDnh0ixw/8kBK6MMSp5rPI1PP8hUx2ZiPoyZrgzGl17RV4jzWqpXPnqm+EjINQBcN+DiwxSx3XKHSUxrfYCkJ+eZFy5EiqXpq7iGU2vyr8Cb33O1jXkiK0XfXuXKVTsKk/hgpX3EQMEyWUZeM1jGWkeeQDo/pMMaqTSyc8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=v2nhIvAH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ydFs6i7keCMfBbD9quYtCVIwH9y+8boTcTxEbezuoqI=; b=v2nhIvAHa8n7akzk3SUERXmaHo
	YvNeXa5K0jwkINpKuRz0S5VtIcpV710I+gAMavCPxiHGRUIRKK/UoZk7idl1zok3c0L86qWILmnyr
	9eHA8+oT5R9Ho2y2JNUDI86b1HTqGj28rmQYVXMz6WcrzQeKG+ojLdutPKj85v62fh8oRYC/FfuGB
	6iYOUIURK6e64WDJkkkSPooaRQfbglSijM/sO9oYgDiZQgl3zbfb6ioUXvfiifvrHipr/+QhcmuvU
	xkDWaE//NvdBrotQ1jIeSGblxfklYqFb6Xh5x+W9vY1iod5cBOnxCIb1ckRapLbxFpwEmrM2YVeVM
	JuTlcZ1w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu2EH-00000009A1O-0i6e;
	Thu, 04 Sep 2025 05:09:49 +0000
Date: Wed, 3 Sep 2025 22:09:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Yu Kuai <hailan@yukuai.org.cn>, Christoph Hellwig <hch@infradead.org>,
	colyli@kernel.org, hare@suse.de, dlemoal@kernel.org,
	tieren@fnnas.com, axboe@kernel.dk, tj@kernel.org,
	josef@toxicpanda.com, song@kernel.org, kmo@daterainc.com,
	satyat@google.com, ebiggers@google.com, neil@brown.name,
	akpm@linux-foundation.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH RFC v3 02/15] block: add QUEUE_FLAG_BIO_ISSUE
Message-ID: <aLkfHW2KuNvrcYyN@infradead.org>
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-3-yukuai1@huaweicloud.com>
 <aLhBqTrbUWVK4OKy@infradead.org>
 <5378349f-4d00-4d3e-9834-f3ddf2e514cc@yukuai.org.cn>
 <dbbfce94-22d8-5c34-ba70-c6de2b902659@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbbfce94-22d8-5c34-ba70-c6de2b902659@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Sep 04, 2025 at 10:44:32AM +0800, Yu Kuai wrote:
> - it's only used by iolatency, which can only be enabled for rq-based
> disks;
> - For bio that is submitted the first time, blk_cgroup_bio_start() is
> called from submit_bio_no_acct_nocheck(), where q_usage_counter is not
> grabbed yet, hence it's not safe to enable that flag while enabling
> iolatency.

Yes, keeping more things in blk-mq is always good.

> -void blk_mq_submit_bio(struct bio *bio)
> +void b k_mq_submit_bio(struct bio *bio)

This got mangled somehow.

