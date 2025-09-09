Return-Path: <cgroups+bounces-9816-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E34AB4A4AC
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 10:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B1D18903F2
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 08:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323A524467E;
	Tue,  9 Sep 2025 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v58coxXk"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B2727453;
	Tue,  9 Sep 2025 08:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405528; cv=none; b=tlS9JjV5fsTGdegWO+s3Hmpqn/eTZRUePMXp4X/cUCtxWBmi4EFh9ZWfozqrgYcqEVCoteIhy/vpBE27LSxQnmiL2ZT9dlLsvkrcmasr7hUmASrxzrLApP9x5PU9i8D+K5i+iMHBBGg9tUig8rw7vKpL9/oTBmcBkfgsA3gCb2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405528; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apE3Rf83JLgRXq7cbXJw22SmMGbqDHqr+J07nXh7w1UfK+FiJNmXt3ZGf/AbNSsam7QGNGA6izZImvjYfsT6Q5QQrjmRm7GQ6VUeMSESDbWb2Byb64ef7+MjuCcz7Oh2gMfv0pJZadX2nb+qmUnyUHa632r9TLoJhMLQI00oxSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=v58coxXk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=v58coxXkYgaEBoHivjjRT2+OQx
	Xf8KDsIK/Ft56pjHHeQJewm2wikQEOGlXWjAYkH00w+KMEDeI2H2BMvnItY3iJ0W18u+1r4sG3pEm
	bIM5+dYbshxz+J4XTkvRwXNpmKGotM5ytxYOPMIgJ7r0R6BF2HwU9KwmCn/hgaL3IvyuHNdoy5X4j
	fvjj2v9GoIHmP8iXetWIJm8Xhfto00RDItq9vCn9tpJIzTbx1XZfHV/sYWW8PLHjAhgky04Y+aO03
	y7wom7sjw/U4U0my6KuNhqSwFMlNBYf/8Wr0UrW+kIwGggoMgVWYtD7jBU6+Cf0WNSlf+7QVxMniF
	wUQoc1lg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvtSH-00000005Tmq-0j4b;
	Tue, 09 Sep 2025 08:11:57 +0000
Date: Tue, 9 Sep 2025 01:11:57 -0700
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
Subject: Re: [PATCH for-6.18/block 02/16] block: initialize bio issue time in
 blk_mq_submit_bio()
Message-ID: <aL_hTVPaYJ4CR3J-@infradead.org>
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
 <20250905070643.2533483-3-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905070643.2533483-3-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


