Return-Path: <cgroups+bounces-211-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED377E335D
	for <lists+cgroups@lfdr.de>; Tue,  7 Nov 2023 03:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B591280E56
	for <lists+cgroups@lfdr.de>; Tue,  7 Nov 2023 02:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B138A17D3;
	Tue,  7 Nov 2023 02:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC71FA49
	for <cgroups@vger.kernel.org>; Tue,  7 Nov 2023 02:57:09 +0000 (UTC)
Received: from gentwo.org (gentwo.org [IPv6:2a02:4780:10:3cd9::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40882184
	for <cgroups@vger.kernel.org>; Mon,  6 Nov 2023 18:57:08 -0800 (PST)
Received: by gentwo.org (Postfix, from userid 1003)
	id 3828548F4B; Mon,  6 Nov 2023 18:57:05 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 346D448F40;
	Mon,  6 Nov 2023 18:57:05 -0800 (PST)
Date: Mon, 6 Nov 2023 18:57:05 -0800 (PST)
From: Christoph Lameter <cl@linux.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
    cgroups@vger.kernel.org
Subject: cgroups: warning for metadata allocation with GFP_NOFAIL (was Re:
 folio_alloc_buffers() doing allocations > order 1 with GFP_NOFAIL)
In-Reply-To: <ZUIHk+PzpOLIKJZN@casper.infradead.org>
Message-ID: <8f6d3d89-3632-01a8-80b8-6a788a4ba7a8@linux.com>
References: <6b42243e-f197-600a-5d22-56bd728a5ad8@gentwo.org> <ZUIHk+PzpOLIKJZN@casper.infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Right.. Well lets add the cgoup folks to this.

The code that simply uses the GFP_NOFAIL to allocate cgroup metadata 
using an order > 1:

int memcg_alloc_slab_cgroups(struct slab *slab, struct kmem_cache *s,
 				 gfp_t gfp, bool new_slab)
{
 	unsigned int objects = objs_per_slab(s, slab);
 	unsigned long memcg_data;
 	void *vec;

 	gfp &= ~OBJCGS_CLEAR_MASK;
 	vec = kcalloc_node(objects, sizeof(struct obj_cgroup *), gfp,
 			   slab_nid(slab));




On Wed, 1 Nov 2023, Matthew Wilcox wrote:

> On Tue, Oct 31, 2023 at 05:13:57PM -0700, Christoph Lameter (Ampere) wrote:
>> Hi Matthew,
>>
>> There is a strange warning on bootup related to folios. Seen it a couple of
>> times before. Why does this occur?
>
> Filesystems generally can't cope with failing to allocate a bufferhead.
> So the buffer head code sets __GFP_NOFAIL.  That's better than trying
> to implement __GFP_NOFAIL semantics in the fs code, right?
>
>> [   20.878110] Call trace:
>> [   20.878111]  get_page_from_freelist+0x214/0x17f8
>> [   20.878116]  __alloc_pages+0x17c/0xe08
>> [   20.878120]  __kmalloc_large_node+0xa0/0x170
>> [   20.878123]  __kmalloc_node+0x120/0x1d0
>> [   20.878125]  memcg_alloc_slab_cgroups+0x48/0xc0
>
> Oho.  It's not buffer's fault, specifically.  memcg is allocating
> its own metadata for the slab.  I decree this Not My Fault.
>
>> [   20.878128]  memcg_slab_post_alloc_hook+0xa8/0x1c8
>> [   20.878132]  kmem_cache_alloc+0x18c/0x338
>> [   20.878135]  alloc_buffer_head+0x28/0xa0
>> [   20.878138]  folio_alloc_buffers+0xe8/0x1c0
>> [   20.878141]  folio_create_empty_buffers+0x2c/0x1e8
>> [   20.878143]  folio_create_buffers+0x58/0x80
>> [   20.878145]  block_read_full_folio+0x80/0x450
>> [   20.878148]  blkdev_read_folio+0x24/0x38
>> [   20.956921]  filemap_read_folio+0x60/0x138
>> [   20.956925]  do_read_cache_folio+0x180/0x298
>> [   20.965270]  read_cache_page+0x24/0x90
>> [   20.965273]  __arm64_sys_swapon+0x2e0/0x1208
>> [   20.965277]  invoke_syscall+0x78/0x108
>> [   20.965282]  el0_svc_common.constprop.0+0x48/0xf0
>> [   20.981702]  do_el0_svc+0x24/0x38
>> [   20.993773]  el0t_64_sync_handler+0x100/0x130
>> [   20.993776]  el0t_64_sync+0x190/0x198
>> [   20.993779] ---[ end trace 0000000000000000 ]---
>> [   20.999972] Adding 999420k swap on /dev/mapper/eng07sys--r113--vg-swap_1.
>> Priority:-2 extents:1 across:999420k SS
>>
>> This is due to
>>
>>
>>
>> folio_alloc_buffers() setting GFP_NOFAIL:
>>
>>
>> struct buffer_head *folio_alloc_buffers(struct folio *folio, unsigned long
>> size,
>>                                         bool retry)
>> {
>>         struct buffer_head *bh, *head;
>>         gfp_t gfp = GFP_NOFS | __GFP_ACCOUNT;
>>         long offset;
>>         struct mem_cgroup *memcg, *old_memcg;
>>
>>         if (retry)
>>                 gfp |= __GFP_NOFAIL;
>
> This isn't new.  It was introduced by 640ab98fb362 in 2017.
> It seems reasonable to be able to kmalloc(512, GFP_NOFAIL).  It's the
> memcg code which is having problems here.
>

