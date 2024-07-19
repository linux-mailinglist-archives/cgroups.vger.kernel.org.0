Return-Path: <cgroups+bounces-3789-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E05937340
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 07:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA6C282868
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 05:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553F43D556;
	Fri, 19 Jul 2024 05:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t0e+IOZY"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7823D3B2BB;
	Fri, 19 Jul 2024 05:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721367012; cv=none; b=Dg5c8C+bbBlpmsIK643GYIzyG0BGzZzAFnt4UKmCO5t8XL7dGq0LBVWwb9j8Bw0wRP+90F4x+1abAGrCcGa2monO0sSBmFHHcCQ3YCSYV+NofczccL4NvqPre1LfBJTgbarThvR5raWheELVC4kTRJP+D12RPtfvFmDI3B/PzpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721367012; c=relaxed/simple;
	bh=SxbgklmrZ19aCcL/gEJ9uSFdFPoVHHFGisNPEcy+iow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0DLiVpGLc8nCCgkGbB92epHQaCYRt6Sv+DiR+iDpc2sZTaSOrNxSxDRe/6YrpaohdM8Z71+lmWCT/2yZudNGkrD6gQCoUD1KFlyLok4kkNeFFEoThETIcANj+Vtvn56BNqVO6NU0Lm1uGrVd09srrERB0gdDtfr55NPhxh2MoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t0e+IOZY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/11wDjA1QdM7Ho6aoI43I5AAS9ZLVtqv9q62TK6FpsU=; b=t0e+IOZYOuIj3Z3BU9kbKabqgE
	o4zDFroaI3xzlvgJT+dx65G5TClwVVoI36dkBGNBNYks/rBoHC6K0kFZ7qwY3d0FggJCQi3zX5MHg
	dUbt4HKc3fGZnk/yuszkYNhRVG9r7L39xuII3RarcTBMSvskd5kWpsqsiul+ZwPBMANexyBwO9sDj
	5i+HS8bjr+s75KkRwy6wPFNT+FzmUvWb49EinYRqzFJ2qtPUbzcEbuvdIaM2NB+ncB2e45kvDyBAU
	EzT7J3tAd7asq5aNZWND488mFvuFoy57qR0alTwgLViLphNi59c9MKSIemxqEa+QR9P5VyCeq1ZIn
	oARScVMA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUgBi-00000001dqz-43Af;
	Fri, 19 Jul 2024 05:29:50 +0000
Date: Thu, 18 Jul 2024 22:29:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: bvanassche@acm.org, jack@suse.cz, hch@infradead.org, tj@kernel.org,
	josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 1/3] blk-cgroup: check for pd_(alloc|free)_fn in
 blkcg_activate_policy()
Message-ID: <Zpn5zvcC4TbDxeKU@infradead.org>
References: <20240719023431.3800647-1-yukuai1@huaweicloud.com>
 <20240719023431.3800647-2-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719023431.3800647-2-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jul 19, 2024 at 10:34:29AM +0800, Yu Kuai wrote:
> +	/*
> +	 * Make sure cpd/pd_alloc_fn and cpd/pd_free_fn in pairs, and policy
> +	 * without pd_alloc_fn/pd_free_fn can't be activated.
> +	 */
>  	if ((!pol->cpd_alloc_fn ^ !pol->cpd_free_fn) ||
>  		(!pol->pd_alloc_fn ^ !pol->pd_free_fn))
>  		goto err_unlock;
> -- 

I know this is existing code, but can you fix up the incorrect
indentation while you touch this:

 	if ((!pol->cpd_alloc_fn ^ !pol->cpd_free_fn) ||
 	    (!pol->pd_alloc_fn ^ !pol->pd_free_fn))

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

