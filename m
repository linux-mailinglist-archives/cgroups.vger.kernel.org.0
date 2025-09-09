Return-Path: <cgroups+bounces-9825-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A366FB4A4DA
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 10:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92E104E2511
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 08:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29882248166;
	Tue,  9 Sep 2025 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ARVn+LWC"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DA223ABBD;
	Tue,  9 Sep 2025 08:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405711; cv=none; b=lycZcjMbKkYVCnxzftXJdMs+NOkBvre+0EHDWeH2+jOfrIoDPnnvYgsw8ouVjiSRU5sur0vLKTx6jPRp8enX5bnL6NN4sl7SbiZX+/f7EtXZw1aTmHFWv1AF8J5Y45Y4Q/MrcQAvAy7amALB6AFu36SM5UlYIz/c0JrbrUP5G2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405711; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Icrs+k1lvpxrsXBETu7NbX/bnI3fSDGaeCyh8uIpL27FK6gcrjvcU7m9Xz16qgGrltfggCFCfFXlKSUpwiZow7V3NqOGZBIWqSnEuVqpRsZtAPBvRnpq2xO/M4m8I2cQhkrRMSQ9HxLO9JouaFaD3O3jkwYkzn2+2TJIJOY+RWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ARVn+LWC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ARVn+LWCoh3xjkC+yepABxSIKp
	up76FzXFahSR+zQJt2f5qbpK2ZxXTvHveZR3mFEkZLhlUH9ivtcNpC8G7SWlhL5Ubpota5U7hB+OL
	Qw8rVLMLJxTd4LIP+uTSkum5Ht7P5JTxU+mm7COPQD/h1MAg5U2PF7FMGUEPjWTBuK5+Vc3SN9Co9
	TXYrZ72lTuG5/uv2eeAxI0xH0UHRrh95wedmJrkjb+SefuyTaf3DItu70M61BMeEodoPTlZTc5Uve
	aNA+aY+UWWryTQwsBCUWVqpxNvm5LNVVHw8fK0W08wCTSF4//S8fqTqIVpXvdHM7MEPUJH2axeVqa
	x/wPxrtQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvtVK-00000005V1K-0rOH;
	Tue, 09 Sep 2025 08:15:06 +0000
Date: Tue, 9 Sep 2025 01:15:06 -0700
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
Subject: Re: [PATCH for-6.18/block 12/16] md/md-linear: convert to use
 bio_submit_split_bioset()
Message-ID: <aL_iCt9afCtmtwJb@infradead.org>
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
 <20250905070643.2533483-13-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905070643.2533483-13-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


