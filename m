Return-Path: <cgroups+bounces-245-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598AB7E5372
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 11:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F70CB20DFF
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 10:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D478D26F;
	Wed,  8 Nov 2023 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VRI/frVL"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03FB12E47
	for <cgroups@vger.kernel.org>; Wed,  8 Nov 2023 10:33:08 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350DC10D5
	for <cgroups@vger.kernel.org>; Wed,  8 Nov 2023 02:33:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C0E6E21961;
	Wed,  8 Nov 2023 10:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1699439586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hFiAcviVraABnczS1H4QUx4zyBJCX/dllj1tUj43EaM=;
	b=VRI/frVL4f+SKT0AVB4Pn17hcROGjrr/+ZShJ4WUA8vYk+1aL4Go82MAd5xxulXjT78kpc
	wDSp9gSAx3i0wbkx++PiITKFVHxyDBnUvYd41V0yb3s4f/XXA6Cj466rwFi3Ocnjgyulyx
	KyOTknSnpLJyF6AQg/ENNFFXJREMBPI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 999A4133F5;
	Wed,  8 Nov 2023 10:33:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id jLZxIuJjS2UecQAAMHmgww
	(envelope-from <mhocko@suse.com>); Wed, 08 Nov 2023 10:33:06 +0000
Date: Wed, 8 Nov 2023 11:33:05 +0100
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Christoph Lameter <cl@linux.com>, Matthew Wilcox <willy@infradead.org>, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Subject: Re: cgroups: warning for metadata allocation with GFP_NOFAIL (was
 Re: folio_alloc_buffers() doing allocations > order 1 with GFP_NOFAIL)
Message-ID: <t4vlvq3f5owdqr76ut3f5yk35jwyy76pvq4ji7zze5aimgh3uu@c2b5mmr4eytv>
References: <6b42243e-f197-600a-5d22-56bd728a5ad8@gentwo.org>
 <ZUIHk+PzpOLIKJZN@casper.infradead.org>
 <8f6d3d89-3632-01a8-80b8-6a788a4ba7a8@linux.com>
 <ZUp8ZFGxwmCx4ZFr@P9FQF9L96D.corp.robot.car>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUp8ZFGxwmCx4ZFr@P9FQF9L96D.corp.robot.car>

On Tue 07-11-23 10:05:24, Roman Gushchin wrote:
> On Mon, Nov 06, 2023 at 06:57:05PM -0800, Christoph Lameter wrote:
> > Right.. Well lets add the cgoup folks to this.
> 
> Hello!
> 
> I think it's the best thing we can do now. Thoughts?
> 
> >From 5ed3e88f4f052b6ce8dbec0545dfc80eb7534a1a Mon Sep 17 00:00:00 2001
> From: Roman Gushchin <roman.gushchin@linux.dev>
> Date: Tue, 7 Nov 2023 09:18:02 -0800
> Subject: [PATCH] mm: kmem: drop __GFP_NOFAIL when allocating objcg vectors
> 
> Objcg vectors attached to slab pages to store slab object ownership
> information are allocated using gfp flags for the original slab
> allocation. Depending on slab page order and the size of slab objects,
> objcg vector can take several pages.
> 
> If the original allocation was done with the __GFP_NOFAIL flag, it
> triggered a warning in the page allocation code. Indeed, order > 1
> pages should not been allocated with the __GFP_NOFAIL flag.
> 
> Fix this by simple dropping the __GFP_NOFAIL flag when allocating
> the objcg vector. It effectively allows to skip the accounting of a
> single slab object under a heavy memory pressure.

It would be really good to describe what happens if the memcg metadata
allocation fails. AFAICS both callers of memcg_alloc_slab_cgroups -
memcg_slab_post_alloc_hook and account_slab will simply skip the
accounting which is rather curious but probably tolerable (does this
allow to runaway from memcg limits). If that is intended then it should
be documented so that new users do not get it wrong. We do not want to
error ever propagate down to the allocator caller which doesn't expect
it.

Btw. if the large allocation is really necessary, which hasn't been
explained so far AFAIK, would vmalloc fallback be an option?
 
> An alternative would be to implement the mechanism to fallback to
> order-0 allocations for accounting metadata, which is also not perfect
> because it will increase performance penalty and memory footprint
> of the kernel memory accounting under memory pressure.
> 
> Reported-by: Christoph Lameter <cl@linux.com>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Matthew Wilcox <willy@infradead.org>
> ---
>  mm/memcontrol.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 774bd6e21e27..1c1061df9cd1 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2936,7 +2936,8 @@ void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *memcg)
>   * Moreover, it should not come from DMA buffer and is not readily
>   * reclaimable. So those GFP bits should be masked off.
>   */
> -#define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT)
> +#define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | \
> +				 __GFP_ACCOUNT | __GFP_NOFAIL)
>  
>  /*
>   * mod_objcg_mlstate() may be called with irq enabled, so
> -- 
> 2.42.0

-- 
Michal Hocko
SUSE Labs

