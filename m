Return-Path: <cgroups+bounces-9821-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3D3B4A4C5
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 10:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E4E54133C
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 08:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2817A24634F;
	Tue,  9 Sep 2025 08:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hbECnV5x"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05A527453;
	Tue,  9 Sep 2025 08:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405642; cv=none; b=XTC5Mrb6CK8YUvcu4lHGzSO2Ko82t7eB/LYuju/PZT4jeXDXl4FlMWN3pzrPoosRHZHZj1/H0xuP5xjtUrhrYEx/vrbsZn6EdhR5kj+oCI4Endxz7mrUo8fk2xq2g7joBVHHQYjROUX32TNvhRkgC0BngC2iguEOXZBt0x5bomE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405642; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTiJ5YJz5wMGC/eZnsFFLrS7mHNKGiuUxA+ikOGYhv/jyJmcg79r08pWk5Cwdgy9lLAbWpdydsYvDGlvWNUpP5zuachEGtc/aLUj1hfnxMffNTp1o+vFDGoTeSCMewzfw6B5mGiAMIGfUFgzUaGJMriNAvPmhmqyuo8D+DGF8i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hbECnV5x; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=hbECnV5xf0VBg3OyHYVbIg5pV2
	SMyMxcofWfqA9FJOMo0K7O8o91cMiFiZoyGoc4B2/hb+4D/8/srcpm4PnAMHe85QtidY/gN1tAAS7
	HgM2IyLuLlBajKknsEYQ4OCZTsduLfTXmbWO8TZIlqnDKPj103QUxC2UUPez0j9o3ZZ5yh5h489Ca
	qEKi8yehU4SYyyWvtLJzvW1uWbjHy6pjss82IH9bNdQy0fJr8QbpQf0EBkLvaep0LYx4Qi3lObs2Q
	SgR4aT8eqMHdJ4Jl1Nv4h+pR3oqdLfKEykIxBeUPebByJT9JpsbvmcGmUbBov1FF+uhZ4tDH+GH6h
	78BjmNZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvtUC-00000005USi-0WOA;
	Tue, 09 Sep 2025 08:13:56 +0000
Date: Tue, 9 Sep 2025 01:13:56 -0700
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
Subject: Re: [PATCH for-6.18/block 08/16] md/raid1: convert to use
 bio_submit_split_bioset()
Message-ID: <aL_hxAJrCXv47WFD@infradead.org>
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
 <20250905070643.2533483-9-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905070643.2533483-9-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


