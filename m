Return-Path: <cgroups+bounces-2160-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7056188BAE9
	for <lists+cgroups@lfdr.de>; Tue, 26 Mar 2024 08:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C6BF2E064E
	for <lists+cgroups@lfdr.de>; Tue, 26 Mar 2024 07:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3972129E99;
	Tue, 26 Mar 2024 07:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="prY4l82T"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B84874BEB;
	Tue, 26 Mar 2024 07:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711436601; cv=none; b=DO0AhfLZkI7fETKNHiUDbMuMmqDKq1xkepuVaxksK5fB1kLXJrjb+4IWVKQzxQW7FpykqXbprFE/31uNHRLiM7/D3fgSxi4SS7MvtAfGsfyoOA7TNBgTH6EsIWzM+t8ssuQ/2dlm6PTzsmWDwLftmPXz77d/GoTODPyjIxbID14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711436601; c=relaxed/simple;
	bh=VGr3FDo/oYXSp1d6WH2kvnzXbMf8dssaiyFWAFBM1RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uePT9IJAQls8woFsIRJNMRaJkvbsVD9Ctipg/9ahq2U9EvoyEsd6OkdR4lSMid1Ep+v7oy6PYr6yP0ldpjNUT09yDOk3upAVJR02U7zLkkFPWGfokyob8knRV4oT1EVYTjQlbtZGBqgVaeQZFeAIrGnYnRzdDjINALwQzgF05dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=prY4l82T; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VGr3FDo/oYXSp1d6WH2kvnzXbMf8dssaiyFWAFBM1RA=; b=prY4l82TLRac5Rr1M9sNv3AFdx
	Eo77z0FVY6/ivknfk+7Mmg/Pjp3fIUz/Qyxj6K9/QyiLQwMy/ZrAL6d6LkKp/C7vrbadH0vwj0gwy
	qLIBQfgYYtXP1HRt92mQqiqtMAWnj34HEW0SScQymAKHE4hjUKFYLMxRLmFs20znuLN8+0aiCKiis
	kNRDtOYAoECFxAHJiAIBXNYAEL2Gu4KIs3rD5CAwhIgB6sT5gR+q1n6vkvW+yE+g/KxEc+TYmjBKn
	z7GAjyu6bV1AFI1WVLDi2MkX1RlqtKjxheOUQI4EpuHQJJb2zcmh3dYM+hz3xLhZs17yHKpJ5Clfc
	jnKshCJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp0q6-00000003N85-1ki6;
	Tue, 26 Mar 2024 07:03:18 +0000
Date: Tue, 26 Mar 2024 00:03:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: tj@kernel.org, axboe@kernel.dk, josef@toxicpanda.com, shli@fb.com,
	linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] blk-throttle: Fix W=1 build issue in tg_prfill_limit()
Message-ID: <ZgJzNvN4nQqKnhk5@infradead.org>
References: <20240325121905.2869271-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325121905.2869271-1-john.g.garry@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 25, 2024 at 12:19:05PM +0000, John Garry wrote:
> For when using gcc 8 and above, the following warnings can be seen when
> compiling blk-throttle.c with W=1:

Why is this function even using these local buffers vs a sequence
of separate seq_printf calls that would get rid of these pointless
on-stack buffers?

