Return-Path: <cgroups+bounces-3647-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EABB692F50F
	for <lists+cgroups@lfdr.de>; Fri, 12 Jul 2024 07:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F71E1F21947
	for <lists+cgroups@lfdr.de>; Fri, 12 Jul 2024 05:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC24918039;
	Fri, 12 Jul 2024 05:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YBAguu1d"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC7F17BCE;
	Fri, 12 Jul 2024 05:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720761754; cv=none; b=Gum1xdk2KBMwinQndG4wvEE9HmzUqqEUcXMB0f2KOavAUZcyIFbrGLzp03Upqn9X15/S1HIdhMKqrw1fYLLbCU//hh7B9JOUe2Bb84PaoXUZsQ17ZSLznuH0ftuh51S3/z4VfITHSI6ECVjTdaCvzki1LZJJyi2PdtW/zDVUjuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720761754; c=relaxed/simple;
	bh=yYhkpWKuNyOfelB/DoE6wEZxyjXupvKjhO+ljCTAlT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbCiTUrEL1DT1K9JIiv1IaaI8jfahMJ1U2BupNiuVBykK/ZljtoCIPv68Nj7j02nctw7FGSPo3Anpnj6pZG+6Da070gil9sZhahmduxef1LOpEO3r9ZBUVRPWcOtNYC6T2/efMLylR9Ewe+gBGaJBTgtnQK8Mu91lgvLclIAOB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YBAguu1d; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r8ds7ED84zDbQqXZ9HWPwxGYHxYypOI8tFg8jRYWVIs=; b=YBAguu1d+NcuhO+fk33IKgKsJQ
	3VqO/ebXIhVuA1gQB9hzG0yl/7wIfcdj/zg0xT6TodIuZrJpu1ERzUwMQ5fQrkNMYn1cys6IJCHOl
	VDh73BhzQ6lH+xpSMtt7aMv0layrnZXFx9H60sa9cN3S55q6e6HRXMSuVUPvfEJ9p7K7pzNEDTZ3S
	weu0h2wPwcbRHt9KcJkoRaQ+izG6QNsOfX+Sl30fKdwMDJoj3Az0JEAlqMe7Ik9NZLe8YzcFoOfWz
	2gz1uDHxblmq60x+/rg0fwuzFJQbCj2d3EbjB41ejlnWSvRSclJhdOVtqyFXeBUmfdrVVsCkyHn9h
	rn7TAr/w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sS8jl-0000000GVF4-2cQ9;
	Fri, 12 Jul 2024 05:22:29 +0000
Date: Thu, 11 Jul 2024 22:22:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Bart Van Assche <bvanassche@acm.org>, tj@kernel.org,
	josef@toxicpanda.com, jack@suse.cz, axboe@kernel.dk,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 2/2] blk-ioprio: remove per-disk structure
Message-ID: <ZpC9le_FsIO0FCJQ@infradead.org>
References: <20240711090059.3998565-1-yukuai1@huaweicloud.com>
 <20240711090059.3998565-3-yukuai1@huaweicloud.com>
 <4c8f1e4e-1b15-4afa-b1e2-084e0c4caeec@acm.org>
 <520b9c10-c152-77f3-bd5a-b86a1f5ac8ea@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <520b9c10-c152-77f3-bd5a-b86a1f5ac8ea@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jul 12, 2024 at 09:10:30AM +0800, Yu Kuai wrote:
> > As one can see in the output of git grep -nHEB1 '>pd_(alloc|free)_fn\(',
> > none of the pd_alloc_fn / pd_free_fn callers checks whether or not these
> > pointers are NULL. Hence my question why this patch does not trigger any
> > NULL pointer dereferences?
> 
> Because the blkcg_deactivate_policy() is removed as well, there are no
> callers now... blkcg_policy_register() is still called to make sure
> cpd_(alloc|free)_fn will still be called.

Can you throw in a patch documenting this?  Any maybe add a check
that pd_alloc_fn / pd_free_fn exist in blkcg_activate_policy and
WARN and return an error otherwise?


