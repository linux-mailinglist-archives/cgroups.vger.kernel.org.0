Return-Path: <cgroups+bounces-9829-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22782B4A4F2
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 10:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D278C166C19
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 08:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D363323D7EC;
	Tue,  9 Sep 2025 08:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pNg0bIVB"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5432F181CFA;
	Tue,  9 Sep 2025 08:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405877; cv=none; b=IfFust+z3N47uR/xle0F3JZnTJDq1CL5E2pmDLYUCjvPm0lyIuSCgTDSjSmeXM64mFOz60uDlcXVN6/7fh7L74uiqrKB6tqZdOYUt4mxxC1m2zp8OowPZ57tUAf0m+Z31C4/zfBPZin5s6XNGWchiC9YAVpjvcr4X9S+RWdg7Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405877; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fy4UJQMwlGr1HVWZcdNnlCx/ViS0Rs59QFhRidgc7iwsBTgyHnBBPCV7zPmApAiONKrwl9qsmDJTb1pJCdElRVdrq9n4aFG8sPZOqbLASMRYqL92EaKb6H/BOyo4rfN+mgVe06nxtEf3tUYuXUuR3NlE/DcR/5A1IFN/tp0onug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pNg0bIVB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=pNg0bIVByphpIqYmlYDFnDnh8T
	hi+Zq/y//jdh8HmwLnSVh9ACwqwDqvIzjbyRkJVbDdU1lPnnDXfB9CY/3d2safPVXcxjgsXzLyesC
	kLZepgXzpCliGpM9STyMntIxbqsQvSOnMsioRyvcoEKmE3jK7h4Rr2ee8pMFqCdOOW1U6J8WEW5j3
	MoBv1y94BmJv004BoAJR8Hyji7D2089VPW17a1S//gdkXuhsp3kyOYCOo1n5aaHLCCWIXhWCD5jPj
	nIYgZYBUyxuwRjUZbjp3u3JEwTiaPzg60hbq1fFoEmA91Ml0PCZTYkpky1bW1Ns653PlR+Fmu1a75
	xONdzQaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvtXy-00000005Vxp-2Lrx;
	Tue, 09 Sep 2025 08:17:50 +0000
Date: Tue, 9 Sep 2025 01:17:50 -0700
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
Subject: Re: [PATCH for-6.18/block 16/16] md/raid0: convert
 raid0_make_request() to use bio_submit_split_bioset()
Message-ID: <aL_irmKcXR8tEkTX@infradead.org>
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
 <20250905070643.2533483-17-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905070643.2533483-17-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


