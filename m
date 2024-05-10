Return-Path: <cgroups+bounces-2850-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AEF8C1D5B
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2024 06:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677791C2105A
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2024 04:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE98D149DF0;
	Fri, 10 May 2024 04:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q0KGq4l5"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BE6148FF2;
	Fri, 10 May 2024 04:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715314469; cv=none; b=pKokbRWpOrdKbr8bPoQRTpwqfP6sFEMipnki5ZkOTqk59Td90VsrI7kxpskNssC3NV8KxVR1mgjBGLKECTisrbuHaDkX85ncW/ELvQDI/QPyUqT+UScDaYfZ9X75mE8obglAC9tb+FFt79uWJXUJJEjaQn1uHuWs+qQqW8jU5+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715314469; c=relaxed/simple;
	bh=POEVGQkIDGey8i2b8b6rAWZfkiTdHx0do0eQTTK1dsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgyG5KQKSvAKgeBEZn76oNwEYUi7Jb014jJU6SbiNDPiWwa0Bl2KwcbROUKpC0kSGX2V9f8kM6iELwK3vXVYPBqoiVkV+60f4+i3eV1EIB369Tf/oocK9MvsxtrhGHaDwdmeLFkxvKS4CH3aDUTjg3zYZtXm8I1EIgF3FyUsRoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q0KGq4l5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=qmAXbJMEtBWvZ+lBO/0Abu9PwbNNUeRaerpScRMSK8k=; b=Q0KGq4l5svbfb8bV1B8v1oX3fN
	z8hLxrvefMZU5s0PK9znUQTBe/rylZSu2vbN9Zu+8J1TqMDBEjbe2xGv1o0B51Hwn5t63CsxIkdOm
	UFpuolw9Axa2f2tiHBZXaCJvLCsehr8B14yD3v08aDj9nNRdJQ2AB2TcnB6qI7E7P8OMmIEILOgve
	4kkn3FOhteQongeGQes35W64tRtCxq4wZFiLvPhr2TxRLO49BUus5Y4bNlmiJfM+5AacdBYDFTJVd
	uIdRo15ikOh8CvHJml64znveMysZiE9mjmNPkM2+qz+iZa+Ac2eLnzDLTCoCoq37ym4B1mq/d8iOD
	FCoAXokA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5He6-00000002Dzz-0hY4;
	Fri, 10 May 2024 04:14:10 +0000
Date: Fri, 10 May 2024 05:14:10 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	"zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, steve.kang@unisoc.com
Subject: Re: [RFC PATCH 2/2] mm: introduce budgt control in readahead
Message-ID: <Zj2fEo_YiW7NeDT8@casper.infradead.org>
References: <20240509023937.1090421-1-zhaoyang.huang@unisoc.com>
 <20240509023937.1090421-3-zhaoyang.huang@unisoc.com>
 <ZjzEH5fFGHgnqbLj@infradead.org>
 <CAGWkznG4xodugVdbKZCn99UiQT5Z3oHYLhTsvOCoe_VNxUVvnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGWkznG4xodugVdbKZCn99UiQT5Z3oHYLhTsvOCoe_VNxUVvnw@mail.gmail.com>

On Fri, May 10, 2024 at 11:06:14AM +0800, Zhaoyang Huang wrote:
> On Thu, May 9, 2024 at 8:40 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > > +     unsigned long budgt = inode->i_sb->s_bdev ?
> > > +                     blk_throttle_budgt(inode->i_sb->s_bdev) : 0;
> >
> > The readahead code is used for all file systems, you can't just call
> > into block layer code here.
> >
> ok. I would like to know any suggestions on introducing throttle
> budget control into readahead which actually works as a negative
> feedback path. IMO, negative feedback is a good methodology which has
> been used in scheduler(EAS) and thermal control(IPA) and
> memory(MGLRU). I would like to suggest to have a try on have it work
> cross the boundary of memory and block layer.
> 
> vfs_read / page fault
> |
> readahead  <---------|
> |                               |
> aops->readpages    |
> |                               |
> block_layer------------

what you could do is have blk-throttle fail bios that are tagged as
readahead if we've hit the threshold?

