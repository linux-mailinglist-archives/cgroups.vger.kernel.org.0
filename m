Return-Path: <cgroups+bounces-16947-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bOJyEvPdL2qYIAUAu9opvQ
	(envelope-from <cgroups+bounces-16947-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 13:11:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E302C6859BD
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 13:11:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dJvU2YxL;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16947-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-16947-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0707D30090A9
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 11:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2C73E316D;
	Mon, 15 Jun 2026 11:11:44 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698A71C695;
	Mon, 15 Jun 2026 11:11:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781521904; cv=none; b=AbRnLnvnWFG/6FRAcZ2xZ6HqONEfef3dVi9MrEk+P5kZ59fHUfbJzt9IgP3TeUxNQ5aJo4VysKDgjHL2EDBwPrCWskXOI6w0/yKifkND5xJOTTuZWRqis3iZOBrmUm5FNDjOr4nQrshiHjCdVvgZ9Y2PyB6uAiF+2n56UdfFz9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781521904; c=relaxed/simple;
	bh=LD0MXBXNpdwrnJPHK4MHA6bj9zE8bW2M19io8tth7+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bB16vgSduUFTApvXZDEgdG0FfX9my/mtlC8WLX9cRX71QVqEn+hHVxO+JtnCqAyQxagJxEIShvK2ZEe8ms8JE5eG+uate2roV8DWcgU9fCI5fQK/ff2+KOUJOQRz8dFJms8aCrBJwg/oZGhGziwCS+waIqG1H7tqSGkLrZ/Jx6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJvU2YxL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD8B1F000E9;
	Mon, 15 Jun 2026 11:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781521903;
	bh=C3XmSWBwxX07T7EjBP+Cm499OZVt/4ndfxyt/cAc+yY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dJvU2YxLmYXK/jl2u71imBIY4cLgK8q4YeB6PZOa48MXe9mzkP57bFHOVIwKbf5Ok
	 Tc0CklWbTCnsIWPXoiP5U7rSWvUhf6TOfrN5ioOLPCTfjFfILsUUKaPQiBRapJJuG+
	 Q2uXLFPxjR5C3nmyZ/+NI4DqtT91KKd4YYRRnlUSmu6Nqp0wWUNmYF0IoY1vvYyiL/
	 OsJe8e35TU1xZGvitLtGggiEWNkyVQ9fKSVKC+yDIYxQkrdDjcwPQ6gJAGehnUCwF2
	 LHXy/9d0VGUGzmpKLYm0XU/m86qu+F9/TTHVpT+9dFHfSEIl3jJ2d3ORRxDcBmksCr
	 FMEupNOtrQlFQ==
Message-ID: <e17e628e-0633-4c5e-a9f9-ea68a4ca09df@kernel.org>
Date: Mon, 15 Jun 2026 13:11:37 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/16] mm/slab: remove __GFP_NO_OBJ_EXT usage from
 alloc_slab_obj_exts()
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, Hao Li <hao.li@linux.dev>
Cc: Harry Yoo <harry@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Hao Ge <hao.ge@linux.dev>
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-15-7190909db118@kernel.org>
 <aiurbPx1SISBarBy@fedora> <49f1bf1e-fcaf-48fa-a7b1-f8ee78b19762@kernel.org>
 <aivpob0Zgnbc4AG4@fedora>
 <CAJuCfpFNftMYw0XoHyN1QAWfm7NYmeuY1T_NGbYy8boGO48MOg@mail.gmail.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <CAJuCfpFNftMYw0XoHyN1QAWfm7NYmeuY1T_NGbYy8boGO48MOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:surenb@google.com,m:hao.li@linux.dev,m:harry@kernel.org,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:hao.ge@linux.dev,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-16947-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E302C6859BD

On 6/15/26 07:38, Suren Baghdasaryan wrote:
> On Fri, Jun 12, 2026 at 4:30 AM Hao Li <hao.li@linux.dev> wrote:
>>
>> On Fri, Jun 12, 2026 at 12:17:45PM +0200, Vlastimil Babka (SUSE) wrote:
>> > On 6/12/26 08:54, Hao Li wrote:
>> > > On Wed, Jun 10, 2026 at 05:40:17PM +0200, Vlastimil Babka (SUSE) wrote:
>> > >> __GFP_NO_OBJ_EXT has limited scope within the slab allocator itself and
>> > >> gfp flags are a scarce resource, unlike slab's alloc_flags.
>> > >>
>> > >> Introduce SLAB_ALLOC_NO_RECURSE alloc flag that has the same intent as
>> > >> __GFP_NO_OBJ_EXT but a more generic name, meaning that a kmalloc()
>> > >> family function should not recurse into another kmalloc*() for the
>> > >> purposes of allocating auxiliary structures (obj_ext arrays or sheaves).
>> > >>
>> > >> First, replace the __GFP_NO_OBJ_EXT for allocating obj_ext arrays in
>> > >> alloc_slab_obj_exts(). Make use of the newly added kmalloc_flags()
>> > >> function, where we can pass alloc_flags with SLAB_ALLOC_NO_RECURSE
>> > >> added. This will also pass through SLAB_ALLOC_TRYLOCK so we don't need
>> > >> to special case kmalloc_nolock() anymore.
>> > >>
>> > >> Note that until now the kmalloc_nolock() ignored the incoming gfp flags
>> > >> and hardcoded __GFP_ZERO | __GFP_NO_OBJ_EXT. But it's correct to pass on
>> > >> the incoming gfp flags (only augmented with __GFP_ZERO), because if
>> > >> alloc_flags contain SLAB_ALLOC_TRYLOCK, the incoming gfp flags have to
>> > >> be also compatible with it.
>> > >>
>> > >> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>> > >> ---
>> > >>  mm/slab.h |  1 +
>> > >>  mm/slub.c | 13 +++++--------
>> > >>  2 files changed, 6 insertions(+), 8 deletions(-)
>> > >>
>> > >> diff --git a/mm/slab.h b/mm/slab.h
>> > >> index 45bfcfb35a9c..509f330654b8 100644
>> > >> --- a/mm/slab.h
>> > >> +++ b/mm/slab.h
>> > >> @@ -21,6 +21,7 @@
>> > >>  #define SLAB_ALLOC_DEFAULT        0x00 /* no flags */
>> > >>  #define SLAB_ALLOC_TRYLOCK        0x01 /* a kmalloc_nolock() allocation */
>> > >>  #define SLAB_ALLOC_NEW_SLAB       0x02 /* a flag for alloc_slab_obj_exts() */
>> > >> +#define SLAB_ALLOC_NO_RECURSE     0x04 /* prevent kmalloc() recursion */
>> > >>
>> > >>  static inline bool alloc_flags_allow_spinning(const unsigned int alloc_flags)
>> > >>  {
>> > >> diff --git a/mm/slub.c b/mm/slub.c
>> > >> index cbb38bd01e46..7dfbd0251aa2 100644
>> > >> --- a/mm/slub.c
>> > >> +++ b/mm/slub.c
>> > >> @@ -2167,15 +2167,12 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>> > >>
>> > >>    gfp &= ~OBJCGS_CLEAR_MASK;
>> > >>    /* Prevent recursive extension vector allocation */
>> > >> -  gfp |= __GFP_NO_OBJ_EXT;
>> > >> +  alloc_flags |= SLAB_ALLOC_NO_RECURSE;
>> > >>
>> > >>    sz = obj_exts_alloc_size(s, slab, gfp);
>> > >>
>> > >
>> > > For the original calls to kmalloc_nolock and kmalloc_node, I notice a difference:
>> > >
>> > >> -  if (unlikely(!allow_spin))
>> > >> -          vec = kmalloc_nolock(sz, __GFP_ZERO | __GFP_NO_OBJ_EXT,
>> > >> -                               slab_nid(slab));
>> > >
>> > > kmalloc_nolock completely discarded `gfp` flags.
>> > >
>> > >> -  else
>> > >> -          vec = kmalloc_node(sz, gfp | __GFP_ZERO, slab_nid(slab));
>> > >
>> > > while kmalloc_node preserved and passed it along.
>> > >
>> > >> +  /* This will use kmalloc_nolock() if alloc_flags say so */
>> > >> +  vec = kmalloc_flags(sz, gfp | __GFP_ZERO, alloc_flags, slab_nid(slab));
>> > >
>> > > Now both paths are merged into kmalloc_flags, the gfp flags are
>> > > unconditionally carried through. It seems this might carry some unwanted flags.
>> > >
>> > > I traced the call path and found that ___slab_alloc sets the __GFP_THISNODE
>> > > for trynode_flags. If this flag propagates all the way into
>> > > kmalloc_flags->...->__kmalloc_nolock_noprof, it will trigger the
>> > > VM_WARN_ON_ONCE warning. Maybe we need to strip the original gfp if
>> > > `!allow_spin`.
>> >
>> > Thanks. This should do the job in a more generic way I hope?
>> >
>>
>> Yeah, this is more elegant.
>>
>> > diff --git a/mm/slub.c b/mm/slub.c
>> > index f9b8dc56bb57..0bf53f70c9be 100644
>> > --- a/mm/slub.c
>> > +++ b/mm/slub.c
>> > @@ -2047,12 +2047,15 @@ static inline void dec_slabs_node(struct kmem_cache *s, int node,
>> >  #endif /* CONFIG_SLUB_DEBUG */
>> >
>> >  /*
>> > - * The allocated objcg pointers array is not accounted directly.
>> > + * The allocated objcg pointers array or sheaf is not accounted directly.
>> >   * Moreover, it should not come from DMA buffer and is not readily
>> > - * reclaimable. So those GFP bits should be masked off.
>> > + * reclaimable. Node restriction for the parent allocation also should
>> > + * not apply to the slab's internal objects.
>> > + * So those GFP bits should be masked off.
>> >   */
>> >  #define OBJCGS_CLEAR_MASK      (__GFP_DMA | __GFP_RECLAIMABLE | \
>> > -                               __GFP_ACCOUNT | __GFP_NOFAIL)
>> > +                               __GFP_ACCOUNT | __GFP_NOFAIL |
>> > +                               __GFP_THISNODE )
>>
>> Good idea! Both code and comments make sense to me.
> 
> Makes sense. I see
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=slab/for-next
> already implementing this and also keeping __GFP_NO_OBJ_EXT and
> SLAB_ALLOC_NO_RECURSE both used. That version looks good to me, so
> I'll wait for v3.

OK.

> At the end of this series, we end up with no users of __GFP_NO_OBJ_EXT
> but we still keep it defined. I'm guessing you leave it because of the
> new patch [1] which aliases __GFP_NO_OBJ_EXT? I will have to make that

Yeah.

> mechanism work without a GFP flag, possibly using a similar approach.
> CC'ing Hao Ge to be in the loop of these changes. I'll work with him
> on aliminating that __GFP_NO_OBJ_EXT alias.

Good, then we can remove the flag completely.

> [1] https://lore.kernel.org/all/20260604024008.46592-1-hao.ge@linux.dev/
> 
>>
>> >
>> >  #ifdef CONFIG_SLAB_OBJ_EXT
>> >
>> >
>>
>> --
>> Thanks,
>> Hao


