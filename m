Return-Path: <cgroups+bounces-218-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E12C57E4ABE
	for <lists+cgroups@lfdr.de>; Tue,  7 Nov 2023 22:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B65A281342
	for <lists+cgroups@lfdr.de>; Tue,  7 Nov 2023 21:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8152E2A1D6;
	Tue,  7 Nov 2023 21:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I7TnO4jv"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A91C2A1D2
	for <cgroups@vger.kernel.org>; Tue,  7 Nov 2023 21:33:57 +0000 (UTC)
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [IPv6:2001:41d0:203:375::ac])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E4610C9
	for <cgroups@vger.kernel.org>; Tue,  7 Nov 2023 13:33:57 -0800 (PST)
Date: Tue, 7 Nov 2023 13:33:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699392835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ch3BQ6OEJbabgew7Q5xC5Mec88IFXokbgGI8lZkyw+U=;
	b=I7TnO4jv6gac29hIoQQR9pXQLv3DKHI17eNZ6zqe6T5AvlcH08XgSGLd+v7WMIxXcY9m5x
	rnfur6jk93P6JvJU7wRIYBqAMRPQX7NEwlxpmPuOTDdNp5VhnRk1VbFWgtDz80DYRmKM08
	mBz2PwCZ7wlcR9TkJqCCz5vPMnznpXo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Lameter <cl@linux.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: Re: cgroups: warning for metadata allocation with GFP_NOFAIL (was
 Re: folio_alloc_buffers() doing allocations > order 1 with GFP_NOFAIL)
Message-ID: <ZUqtNQPuOj-s6Ix1@P9FQF9L96D.corp.robot.car>
References: <6b42243e-f197-600a-5d22-56bd728a5ad8@gentwo.org>
 <ZUIHk+PzpOLIKJZN@casper.infradead.org>
 <8f6d3d89-3632-01a8-80b8-6a788a4ba7a8@linux.com>
 <ZUqO2O9BXMo2/fA5@casper.infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUqO2O9BXMo2/fA5@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Nov 07, 2023 at 07:24:08PM +0000, Matthew Wilcox wrote:
> On Mon, Nov 06, 2023 at 06:57:05PM -0800, Christoph Lameter wrote:
> > Right.. Well lets add the cgoup folks to this.
> > 
> > The code that simply uses the GFP_NOFAIL to allocate cgroup metadata using
> > an order > 1:
> > 
> > int memcg_alloc_slab_cgroups(struct slab *slab, struct kmem_cache *s,
> > 				 gfp_t gfp, bool new_slab)
> > {
> > 	unsigned int objects = objs_per_slab(s, slab);
> > 	unsigned long memcg_data;
> > 	void *vec;
> > 
> > 	gfp &= ~OBJCGS_CLEAR_MASK;
> > 	vec = kcalloc_node(objects, sizeof(struct obj_cgroup *), gfp,
> > 			   slab_nid(slab));
> 
> But, but but, why does this incur an allocation larger than PAGE_SIZE?
> 
> sizeof(void *) is 8.  We have N objects allocated from the slab.  I
> happen to know this is used for buffer_head, so:
> 
> buffer_head         1369   1560    104   39    1 : tunables    0    0    0 : slabdata     40     40      0
> 
> we get 39 objects per slab.  and we're only allocating one page per slab.
> 39 * 8 is only 312.
> 
> Maybe Christoph is playing with min_slab_order or something, so we're
> getting 8 pages per slab.  That's still only 2496 bytes.  Why are we
> calling into the large kmalloc path?  What's really going on here?

Good question and I *guess* it's something related to Christoph's hardware
(64k pages or something like this) - otherwise we would see it sooner.

I'd like to have the answer too.

Thanks!

