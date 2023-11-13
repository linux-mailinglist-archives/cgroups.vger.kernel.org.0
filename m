Return-Path: <cgroups+bounces-376-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64077EA624
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 23:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B3E1C20845
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 22:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CEB24A00;
	Mon, 13 Nov 2023 22:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KnMXqkgC"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA2C156C7
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 22:48:52 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCD3D57
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 14:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/PZtpc2ur+Sl7wDxycZ2d0T8dRROOFTBgBCfpZ4kvKU=; b=KnMXqkgCWTdNThLbGgbywuV28C
	W9aVs0r3pVU+3wyh5NIhsQjE9qd/brki08cmV4a8NBRPV91PIo6HzMETXFlhzSN2I57/bOFYryX62
	/AbbKL1DHk7Refu4wOrkbmOZW/5bCSYCGvpOSusZ8S0b6pYu+VvDB2yOx0SOQ822vw2risKapjqOl
	M9QHk4NpabqAD8LwVvuZSVMs9HNiHiURSUNEfyq7kHccZEdln3JtU4ngRD07OiPqeM5SCSFVZWZJU
	Ljmt0Xrrpo13zn2gEN6R9dTLURXUlga+OlHXT/q4H8PhPnHuN2qdzSU80+XF1uYGglaYw8zzhWmc8
	RUos9M+A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r2fjT-00072p-Cs; Mon, 13 Nov 2023 22:48:39 +0000
Date: Mon, 13 Nov 2023 22:48:39 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Lameter <cl@linux.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: Re: cgroups: warning for metadata allocation with GFP_NOFAIL (was
 Re: folio_alloc_buffers() doing allocations > order 1 with GFP_NOFAIL)
Message-ID: <ZVKnx2eCsOqLipG0@casper.infradead.org>
References: <6b42243e-f197-600a-5d22-56bd728a5ad8@gentwo.org>
 <ZUIHk+PzpOLIKJZN@casper.infradead.org>
 <8f6d3d89-3632-01a8-80b8-6a788a4ba7a8@linux.com>
 <ZUqO2O9BXMo2/fA5@casper.infradead.org>
 <ZU4yUoiiJYzml0rS@casper.infradead.org>
 <4f48d681-376e-100d-01fa-b22d15e8a534@linux.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f48d681-376e-100d-01fa-b22d15e8a534@linux.com>

On Mon, Nov 13, 2023 at 11:48:57AM -0800, Christoph Lameter wrote:
> On Fri, 10 Nov 2023, Matthew Wilcox wrote:
> 
> > > Maybe Christoph is playing with min_slab_order or something, so we're
> > > getting 8 pages per slab.  That's still only 2496 bytes.  Why are we
> > > calling into the large kmalloc path?  What's really going on here?
> > 
> > Christoph?
> 
> Sorry I thought I already answered that.
> 
> This was a boot with slub_min_order=5 that was inadvertently left in from a
> performance test.

Ah.  So do you think we need to fix this?

