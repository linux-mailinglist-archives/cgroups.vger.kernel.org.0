Return-Path: <cgroups+bounces-217-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 538E77E4926
	for <lists+cgroups@lfdr.de>; Tue,  7 Nov 2023 20:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD8928132E
	for <lists+cgroups@lfdr.de>; Tue,  7 Nov 2023 19:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C16736AEC;
	Tue,  7 Nov 2023 19:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F2HmsipP"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25E836AEA
	for <cgroups@vger.kernel.org>; Tue,  7 Nov 2023 19:24:21 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F39B8F
	for <cgroups@vger.kernel.org>; Tue,  7 Nov 2023 11:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=opjEIOO1JtV8yJtGuc5p2oYazK/CNCamWHwO2FoBiX8=; b=F2HmsipPR+qrkejgPJnJv/+tDm
	cGr6EdIgTJi6fR1jetdoXowD0R9/jTkAtEd28Kjzt5L3SxxmREbMRFLLRA8a1x82O7tFtn1P7pp+1
	AKcsNPri9tmUDRN12LNnOCS0uruErxp/c/Qt+cvX0Su/TJpCasgIM6ode9Mf3LcbQc3dtYsqeebOP
	efMdLtR0wOChZwz925qTnLvWE8t4MibqT81yadQxCYLWoECLGb8yd0UN3KaLHZaq9SJ1/TH1AJRXw
	vONOiTqvfxahfkZ97qA583yRdLT+8B/iWiXZQT+kkp8whPkNbRy3nCuJWA5GsqKFNsnYB3gsmzFa5
	CJcJTK+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r0RgG-00E6ld-Qe; Tue, 07 Nov 2023 19:24:08 +0000
Date: Tue, 7 Nov 2023 19:24:08 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Lameter <cl@linux.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: Re: cgroups: warning for metadata allocation with GFP_NOFAIL (was
 Re: folio_alloc_buffers() doing allocations > order 1 with GFP_NOFAIL)
Message-ID: <ZUqO2O9BXMo2/fA5@casper.infradead.org>
References: <6b42243e-f197-600a-5d22-56bd728a5ad8@gentwo.org>
 <ZUIHk+PzpOLIKJZN@casper.infradead.org>
 <8f6d3d89-3632-01a8-80b8-6a788a4ba7a8@linux.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f6d3d89-3632-01a8-80b8-6a788a4ba7a8@linux.com>

On Mon, Nov 06, 2023 at 06:57:05PM -0800, Christoph Lameter wrote:
> Right.. Well lets add the cgoup folks to this.
> 
> The code that simply uses the GFP_NOFAIL to allocate cgroup metadata using
> an order > 1:
> 
> int memcg_alloc_slab_cgroups(struct slab *slab, struct kmem_cache *s,
> 				 gfp_t gfp, bool new_slab)
> {
> 	unsigned int objects = objs_per_slab(s, slab);
> 	unsigned long memcg_data;
> 	void *vec;
> 
> 	gfp &= ~OBJCGS_CLEAR_MASK;
> 	vec = kcalloc_node(objects, sizeof(struct obj_cgroup *), gfp,
> 			   slab_nid(slab));

But, but but, why does this incur an allocation larger than PAGE_SIZE?

sizeof(void *) is 8.  We have N objects allocated from the slab.  I
happen to know this is used for buffer_head, so:

buffer_head         1369   1560    104   39    1 : tunables    0    0    0 : slabdata     40     40      0

we get 39 objects per slab.  and we're only allocating one page per slab.
39 * 8 is only 312.

Maybe Christoph is playing with min_slab_order or something, so we're
getting 8 pages per slab.  That's still only 2496 bytes.  Why are we
calling into the large kmalloc path?  What's really going on here?

