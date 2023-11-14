Return-Path: <cgroups+bounces-411-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1335D7EB587
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 18:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00F68B20B9C
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 17:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B15D4412;
	Tue, 14 Nov 2023 17:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vJGGfk/r"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E702C180
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 17:29:17 +0000 (UTC)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB074CB
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 09:29:16 -0800 (PST)
Date: Tue, 14 Nov 2023 09:29:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699982954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ySI9j0LkhlNiSU7jNvFKoWPS1ihC2MUZj7Oi2BBGEM=;
	b=vJGGfk/rm28tLfjQ+0Xx+A1CYI3f9aFGDPlKuclzXIeejsdioY2hLOZJVB7QIIMb64CKT3
	4ZJhLmkIXDaDirMYrsFpYRPZVTP8+Eps2hXBXsm2gm5kJLrM8evkcNqvngGwhqTp30yA13
	dgh83jGgQ4/hPPq8Z2vuWX0RonrPkWw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Lameter <cl@linux.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: Re: cgroups: warning for metadata allocation with GFP_NOFAIL (was
 Re: folio_alloc_buffers() doing allocations > order 1 with GFP_NOFAIL)
Message-ID: <ZVOuXOaPn_eCxaLY@P9FQF9L96D.corp.robot.car>
References: <6b42243e-f197-600a-5d22-56bd728a5ad8@gentwo.org>
 <ZUIHk+PzpOLIKJZN@casper.infradead.org>
 <8f6d3d89-3632-01a8-80b8-6a788a4ba7a8@linux.com>
 <ZUqO2O9BXMo2/fA5@casper.infradead.org>
 <ZU4yUoiiJYzml0rS@casper.infradead.org>
 <4f48d681-376e-100d-01fa-b22d15e8a534@linux.com>
 <ZVKnx2eCsOqLipG0@casper.infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVKnx2eCsOqLipG0@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Nov 13, 2023 at 10:48:39PM +0000, Matthew Wilcox wrote:
> On Mon, Nov 13, 2023 at 11:48:57AM -0800, Christoph Lameter wrote:
> > On Fri, 10 Nov 2023, Matthew Wilcox wrote:
> > 
> > > > Maybe Christoph is playing with min_slab_order or something, so we're
> > > > getting 8 pages per slab.  That's still only 2496 bytes.  Why are we
> > > > calling into the large kmalloc path?  What's really going on here?
> > > 
> > > Christoph?
> > 
> > Sorry I thought I already answered that.
> > 
> > This was a boot with slub_min_order=5 that was inadvertently left in from a
> > performance test.
> 
> Ah.  So do you think we need to fix this?

I'd leave the fix, so that we don't have to look into this "problem" next time.
But I'm not inclined to work on a proper fix: fixing the slab accounting
for this non-trivial setup. Maybe we should add a note into a doc saying that
raising slub_min_order might affect the slab accounting precision?

