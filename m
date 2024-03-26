Return-Path: <cgroups+bounces-2166-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86EB88C5BA
	for <lists+cgroups@lfdr.de>; Tue, 26 Mar 2024 15:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B06FB260ED
	for <lists+cgroups@lfdr.de>; Tue, 26 Mar 2024 14:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDA7ED9;
	Tue, 26 Mar 2024 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4RMjlMmG"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3432A13C676;
	Tue, 26 Mar 2024 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464573; cv=none; b=gt1smlJiqmaNwOWSDBzq4GeAKTbahGNSRUHv8d+P8hRFWsqZLTXI7ph2XLfdWIJF4q1BQz26EfousDlVdQ5DgEHVNlI3MAeC/AprNSla9XGxsmdyOag2bn1I11FwcGsIr3fa31nj3+YI+4wUv4wmPOM2k23KjuKPkLPBqOYPk+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464573; c=relaxed/simple;
	bh=GVGvmRJhymKmC0l2GbjNVQ644MTQSv4xnJfPdfhHeb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PF7e3BJ9Mr3hlzulOAd2xAtI+1wHmN6EiEMNmQsW2oYFcfP/aaKDKKY4hoiVRPUTYmwNNMUZSysvqPF9oMnSrqZS1535JWfU5zi/Ca3pcaR80xoX9hO7q0PPsxX6XZFpW1sTPQcCKfbaAdgVB6jWVvWpjqWfTH9fV+Do3SIIBpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4RMjlMmG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RmMUNinGi0pwqpldZMIlWpRQ7pU3yfyst3NQo0xdBJg=; b=4RMjlMmG/iGsVQ/k0CJn/gip4m
	U9NhvcpcyOtZG2RXOZDqXgkAwisEl+Nhq+/pjavaiWUnF3AJErERxmhA3vadEY4EuXoNCi3UwYWH9
	PxDPRIwA9q8UmOnu1HC+mvip7CJAgXYm+qbssIuSrSjsU30fz+shYEMjNnEZJvSCzFfEdfJd8DRDn
	WFuBP+duqVEnzo1qq7CFFHbhbryw/eCLDD0F8xCRA/3jBcEmtpK4CbKsqYujBX5+n4pGiQkrCel6t
	c1lyTZ+QZtfE769XeWZhDOCpKWjwK/G4HvX2m6lSCW+h1042WdudNvGx+t0H5n+UqFm1R6IgAc+pX
	R0cZwNRQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp87F-00000004zTQ-3aks;
	Tue, 26 Mar 2024 14:49:29 +0000
Date: Tue, 26 Mar 2024 07:49:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, tj@kernel.org, axboe@kernel.dk,
	josef@toxicpanda.com, shli@fb.com, linux-block@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH] blk-throttle: Fix W=1 build issue in tg_prfill_limit()
Message-ID: <ZgLgedPipnZuyHCA@infradead.org>
References: <20240325121905.2869271-1-john.g.garry@oracle.com>
 <ZgJzNvN4nQqKnhk5@infradead.org>
 <a4d8b56e-1814-4834-9d25-ef61ff6f1248@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4d8b56e-1814-4834-9d25-ef61ff6f1248@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 26, 2024 at 08:46:24AM +0000, John Garry wrote:
> On 26/03/2024 07:03, Christoph Hellwig wrote:
> > On Mon, Mar 25, 2024 at 12:19:05PM +0000, John Garry wrote:
> > > For when using gcc 8 and above, the following warnings can be seen when
> > > compiling blk-throttle.c with W=1:
> > 
> > Why is this function even using these local buffers vs a sequence
> > of separate seq_printf calls that would get rid of these pointless
> > on-stack buffers?
> 
> Currently a combo of snprintf and seq_printf is used, a strategy which seems
> to go as far back as 2ee867dcfa2ea (2015), when it was a much simpler print.
> All the other code in this area only uses seq_printf, so it seems that the
> author(s) prefer this way here.
> 
> Here's how the current code could look (using only seq_printf):

That looks much better, thanks.

