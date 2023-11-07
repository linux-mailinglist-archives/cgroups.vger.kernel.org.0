Return-Path: <cgroups+bounces-219-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40097E4AC6
	for <lists+cgroups@lfdr.de>; Tue,  7 Nov 2023 22:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 903CA2814AD
	for <lists+cgroups@lfdr.de>; Tue,  7 Nov 2023 21:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA6E2A1D2;
	Tue,  7 Nov 2023 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rg7+BIxF"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400522A1D7
	for <cgroups@vger.kernel.org>; Tue,  7 Nov 2023 21:37:27 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B43B10E9
	for <cgroups@vger.kernel.org>; Tue,  7 Nov 2023 13:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VZKUcrpeKgdBxyuhSqTuuXcGg2taSZU47KZRc+Dw/ow=; b=rg7+BIxFt5omB6LPXtqz7QwIdV
	dVQ5SZBNQU/dRXHPQqz4bqUfbyJJEaGdhx++NgCtHDQ0tqOfAyZWTjMzbXTn7LqBLK/W+VoSSdR4M
	Nz/dnyKOu9Y84MK0RKcxjK1AziewW0cG3R5UEOeZE31cmWfImzywREEZFsN72F+OmiGtVHOAk0OBM
	xeFY0rjkC1qTFTXX61AUWg/Nd9cZ+6fOK2nD8kSJ2QPTfjhWCPyecw0RyvER7yhEFB6QpmviQ6QjM
	ayKiTqW+Km+jkI9VFQ04XIPjTcBxHbtAu08/ZR8/OAtRJBkuh1kQ6NT3RH17pH6P7mL4XgaICHcMW
	PqhVlqig==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r0Tl7-00Egjh-MS; Tue, 07 Nov 2023 21:37:17 +0000
Date: Tue, 7 Nov 2023 21:37:17 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Christoph Lameter <cl@linux.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: Re: cgroups: warning for metadata allocation with GFP_NOFAIL (was
 Re: folio_alloc_buffers() doing allocations > order 1 with GFP_NOFAIL)
Message-ID: <ZUquDRPx+bUuGI15@casper.infradead.org>
References: <6b42243e-f197-600a-5d22-56bd728a5ad8@gentwo.org>
 <ZUIHk+PzpOLIKJZN@casper.infradead.org>
 <8f6d3d89-3632-01a8-80b8-6a788a4ba7a8@linux.com>
 <ZUqO2O9BXMo2/fA5@casper.infradead.org>
 <ZUqtNQPuOj-s6Ix1@P9FQF9L96D.corp.robot.car>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUqtNQPuOj-s6Ix1@P9FQF9L96D.corp.robot.car>

On Tue, Nov 07, 2023 at 01:33:41PM -0800, Roman Gushchin wrote:
> On Tue, Nov 07, 2023 at 07:24:08PM +0000, Matthew Wilcox wrote:
> > On Mon, Nov 06, 2023 at 06:57:05PM -0800, Christoph Lameter wrote:
> > > Right.. Well lets add the cgoup folks to this.
> > > 
> > > The code that simply uses the GFP_NOFAIL to allocate cgroup metadata using
> > > an order > 1:
> > > 
> > > int memcg_alloc_slab_cgroups(struct slab *slab, struct kmem_cache *s,
> > > 				 gfp_t gfp, bool new_slab)
> > > {
> > > 	unsigned int objects = objs_per_slab(s, slab);
> > > 	unsigned long memcg_data;
> > > 	void *vec;
> > > 
> > > 	gfp &= ~OBJCGS_CLEAR_MASK;
> > > 	vec = kcalloc_node(objects, sizeof(struct obj_cgroup *), gfp,
> > > 			   slab_nid(slab));
> > 
> > But, but but, why does this incur an allocation larger than PAGE_SIZE?
> > 
> > sizeof(void *) is 8.  We have N objects allocated from the slab.  I
> > happen to know this is used for buffer_head, so:
> > 
> > buffer_head         1369   1560    104   39    1 : tunables    0    0    0 : slabdata     40     40      0
> > 
> > we get 39 objects per slab.  and we're only allocating one page per slab.
> > 39 * 8 is only 312.
> > 
> > Maybe Christoph is playing with min_slab_order or something, so we're
> > getting 8 pages per slab.  That's still only 2496 bytes.  Why are we
> > calling into the large kmalloc path?  What's really going on here?
> 
> Good question and I *guess* it's something related to Christoph's hardware
> (64k pages or something like this) - otherwise we would see it sooner.

I was wondering about that, and obviously it'd make N scale up.  But then,
we'd be able to fit more pointers in a page too.  At the ed of the day,
8 < 104.  Even if we go to order-3, 64 < 104.  If Christoph is playing
with min_slab_order=4, we'd see it ... but that's a really big change,
and I don't think it would justify this patch, let alone cc'ing stable.

