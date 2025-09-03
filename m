Return-Path: <cgroups+bounces-9648-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCD0B42183
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 15:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03353BE38F
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 13:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269A0305051;
	Wed,  3 Sep 2025 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aczt94Os"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC462FB63C;
	Wed,  3 Sep 2025 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906094; cv=none; b=hWocX98+5oqDARGyeaPLDIQfmIAPUMWhal8u5hNS1IMQTdSHNE6HSyIv/qKj+TsOLgL45lPJw7jQ+XU3dZevls3PP6FGq9O9/jSzaKR6uJh5vHDFTj90QlXrQB3xhQtEdtB8KLmnusjiGC/5rdbvPIUazbxO9kMme0WdO1oWQ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906094; c=relaxed/simple;
	bh=RBK2lbKDfAWbVbDolbg9YMtcwelhYZra3i9LJAFg2pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zsk65rfvh4UN8fTLAxnMRLpkEZcT1EIGidKUNuz5k9qbdUBaOzebvFRM0WcNe0d/8gGOpFvWeGAUA3VpTs+xfn+3333jeQtaboPiNMSPqh2sizXUfaQxzsxGSSINEo6b7xFwhcAikh0pdW3s4s9wKSXN9zKzZOC5MpHs/g1TEqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aczt94Os; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XduuBtwRZyd6KyykVg7ZdLjFnZ4Ef5ygHTAhg0h2OSQ=; b=aczt94OsPd1gIOeQbZp36PgKNH
	lf4lg9DOl8f04M0MaXXZ+m6ENQUcVD17ZmmNIk02M9RtZEFwSKbJTly8lpNCgCpOjtESQE4dkYfOJ
	p8sFyHmWCxP2XD60fYsARjpR0VokwjWq8P4ySJhmZ4sRXAR6AJlHseMQcNmBM2MZ53K7F1byGfNB/
	mqoLXQm+UXu4MteT8AImlm1clzb/gVg86gaahvC9/fJqTRIxBgvX4IJmZmpBN5NSnqHWkjxlnwR0e
	PYun6EDZBwGmNzwAwyjCbiSjvquI+PJrrGGVCyeA806goDZTxbfwUG1n5HPGaZphdfDjUoLxsCz+F
	O1h4B+og==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utnWy-00000006awC-2m0H;
	Wed, 03 Sep 2025 13:28:08 +0000
Date: Wed, 3 Sep 2025 06:28:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, hch@infradead.org, colyli@kernel.org,
	hare@suse.de, dlemoal@kernel.org, tieren@fnnas.com, axboe@kernel.dk,
	tj@kernel.org, josef@toxicpanda.com, song@kernel.org,
	kmo@daterainc.com, satyat@google.com, ebiggers@google.com,
	neil@brown.name, akpm@linux-foundation.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-raid@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: Re: [PATCH RFC v3 05/15] block: factor out a helper
 bio_submit_split_bioset()
Message-ID: <aLhCaMTsQ5uuLB4m@infradead.org>
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-6-yukuai1@huaweicloud.com>
 <4f54d81a-d330-44b2-b667-3b13d516c576@acm.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f54d81a-d330-44b2-b667-3b13d516c576@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Sep 02, 2025 at 10:12:23AM -0700, Bart Van Assche wrote:
> This is a good opportunity to reduce the indentation level in this
> function by adding something like this above the
> bio_submit_split_bioset() call:
> 
> if (unlikely(split_sectors == 0))
> 	return bio;

I asked Kuan not to mix functionality changes and reformatting for
the initial version.  With the new helper it doesn't matter too
much, but to be honest I also think the current flow is more readable
with the new helper anyway and it's not like there is a lot of
indentation.

