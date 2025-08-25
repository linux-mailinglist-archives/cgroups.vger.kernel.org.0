Return-Path: <cgroups+bounces-9382-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B079FB33DA8
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 13:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695591A8284D
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 11:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F992E1EEA;
	Mon, 25 Aug 2025 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uw1vUFG2"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28BB2E11D5;
	Mon, 25 Aug 2025 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756120032; cv=none; b=M4NAtS0501wuuN6t9rDYx/5NQSg8LE9XNXTZG0dth5yMeeo3ypb7SoHNJBc/3di1olfm130nemoWrCagMyR66muZKE1yzdqDqSaS7LJaWdoBUYsHUc9YOLjXqy/8F8oerYmkrKnlgKxiOMxzRIKY0yzCU0VWb/jb6ys9U+8Wypc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756120032; c=relaxed/simple;
	bh=TABDPH/xAD0ULdz3KySbOMtsEFTpkYaa74uJoYqZFv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEg49AkJr3Ey0fowZkJy8RdQcZ23TfqdgZXS9OUfRusABGJVTLMzBn7m3wNkkVnq/GODXoGK0+6m2+h6Cw3JSVKJUkKExVWhhUsZRAdQjdhOQAHhpVoSwfcl6zVI5OCTQgoqaALRn28Vm7Y3twPbknku8/sp7CrZ7OsF0Q7CCCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uw1vUFG2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XVuK7LKGUP1i9t5CT9fQGjrmQmutWSdWy08Yrwl3CCM=; b=uw1vUFG20qgyoqz4ePm7x2GLub
	H/vejHraO0tYumTWsn8Qc0ckKjZELB9jZ8T3qs1cbbC6yz0s36NKWEnvIAW8rzye1Z84uW5bkgzIx
	OntbC9LZMhKze5cHPQ8gVUFkOVT1A1FqMdcmty1H9ZhHQ6c35c3U9aZyjsG4NZ0W8AN447Cpvqxfe
	d9MhiYmMqh4FNw4L7j+dY0bvHd6HS7nC8XpfWld9V5zSEAYHALpiRrI9deP1Iov2BIJ14sLnS3Q9z
	uVMZuHMXKSRAnUoxNbGzZdYlYw2aVYk6HUWd4yaEzZYcOraz83WxGBaX2U6U9jXGCZ68CSFpxIeEC
	/rIi2BZg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqV2Y-00000007i1V-2N5Q;
	Mon, 25 Aug 2025 11:07:06 +0000
Date: Mon, 25 Aug 2025 04:07:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@infradead.org, colyli@kernel.org, hare@suse.de, tieren@fnnas.com,
	axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
	song@kernel.org, yukuai3@huawei.com, akpm@linux-foundation.org,
	neil@brown.name, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH RFC 7/7] block: fix disordered IO in the case recursive
 split
Message-ID: <aKxD2hdsUpZrtqOy@infradead.org>
References: <20250825093700.3731633-1-yukuai1@huaweicloud.com>
 <20250825093700.3731633-8-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825093700.3731633-8-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 25, 2025 at 05:37:00PM +0800, Yu Kuai wrote:
> +void submit_bio_noacct(struct bio *bio)

Maybe just have version of submit_bio_noacct that takes the split
argument, and make submit_bio_noacct a tiny wrapper around it?  That
should create less churns than this version I think.  In fact I suspect
we can actually bypass submit_bio_noacct entirely, all the checks and
accounting in it were already done when submitting the origin bio, so
the bio split helper could just call into submit_bio_noacct_nocheck 
directly.


