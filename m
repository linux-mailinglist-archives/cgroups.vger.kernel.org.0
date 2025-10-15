Return-Path: <cgroups+bounces-10773-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C98F7BDE0A8
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 12:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E461886CAC
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 10:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88149311C36;
	Wed, 15 Oct 2025 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MMjwsQZ4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kmWsXVhg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MMjwsQZ4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kmWsXVhg"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7957F2EA464
	for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524638; cv=none; b=rwzTQHfm/J5AHM6PWMxVPwvs7iZhjKcHPGqTz8hdpaUU+JMnMas3Ft/xI4maIHY2ZYF1RMXRl5gL9aWTfAxF9h0T1eMGEMw5bpjiBH5yVqTOopOC/wx0wOIWUn3rh9PADq4r8GA6mGc0qTJcNdcgf2llMjU8Bixrf4bVuJfCib4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524638; c=relaxed/simple;
	bh=r9u8zd/jXx3UDg62IxPDc1C3CJ10UatMhGkxyEXIvNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BGXz9t39pMrsuuB0wRuipJpSlwrGkRegkg3RHuKWjGyZyRtKbFA6YL8NZZtUcpfS92JPC6LiVx7QJjcCW3j5hLsFGPJUaeapkXvSqJ7oqBhi+YVUvFk5cFd1qj1+CRgLKEH2+ueRebfym8jZ5bj79BOnlAqxpvbkUmOL3s6MOmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MMjwsQZ4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kmWsXVhg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MMjwsQZ4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kmWsXVhg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9383133856;
	Wed, 15 Oct 2025 10:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760524634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ch8Txd3Go5tUrNpujwfVCPB6V90KtdNakLBwiq7WOPc=;
	b=MMjwsQZ4KE/nscd/YIHEYI+aLquW+tOE/yF7EF95Kb9Q6z/ZOFJXsz/87T+jLv1XzVN1aH
	3Vbg/o9OgsQx1hazAejb7UOyQwHlGEo8s4B3VV5R4/COWX0cJdOxw7ZffYy1tFp9BolojM
	WJnqEeRUblRTso5I3+MkSrwMkv93R/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760524634;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ch8Txd3Go5tUrNpujwfVCPB6V90KtdNakLBwiq7WOPc=;
	b=kmWsXVhg7qvQHQQ8zL9EGCoyIcw+R5ppekmtANLqCecRU58mwBHDfvp/hnMMgZnnZFAbCQ
	WcKelaB7ZKcjTSDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760524634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ch8Txd3Go5tUrNpujwfVCPB6V90KtdNakLBwiq7WOPc=;
	b=MMjwsQZ4KE/nscd/YIHEYI+aLquW+tOE/yF7EF95Kb9Q6z/ZOFJXsz/87T+jLv1XzVN1aH
	3Vbg/o9OgsQx1hazAejb7UOyQwHlGEo8s4B3VV5R4/COWX0cJdOxw7ZffYy1tFp9BolojM
	WJnqEeRUblRTso5I3+MkSrwMkv93R/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760524634;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ch8Txd3Go5tUrNpujwfVCPB6V90KtdNakLBwiq7WOPc=;
	b=kmWsXVhg7qvQHQQ8zL9EGCoyIcw+R5ppekmtANLqCecRU58mwBHDfvp/hnMMgZnnZFAbCQ
	WcKelaB7ZKcjTSDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7483313A29;
	Wed, 15 Oct 2025 10:37:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r0ogHFp572jVHgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 15 Oct 2025 10:37:14 +0000
Message-ID: <6194b6ab-6b43-468d-ba78-a95594c48798@suse.cz>
Date: Wed, 15 Oct 2025 12:37:14 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] slab: Add check for memcg_data != OBJEXTS_ALLOC_FAIL
 in folio_memcg_kmem
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
References: <20251014152751.499376-1-hao.ge@linux.dev>
 <CAJuCfpGBxUmvWoe2xv2-bsF+TY4fK-m1-Z_E3OcyTiSYz5KeAA@mail.gmail.com>
 <aO9okBEZiA4pCNku@hyeyoo> <c07838ca-4e6e-4837-b99f-09fd44c7801c@suse.cz>
 <aO93GHNR_32-Pmom@hyeyoo>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <aO93GHNR_32-Pmom@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MID_RHS_MATCH_FROM(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 10/15/25 12:27, Harry Yoo wrote:
> On Wed, Oct 15, 2025 at 11:54:18AM +0200, Vlastimil Babka wrote:
>> On 10/15/25 11:25, Harry Yoo wrote:
>> > On Tue, Oct 14, 2025 at 09:12:43AM -0700, Suren Baghdasaryan wrote:
>> >> On Tue, Oct 14, 2025 at 8:28 AM Hao Ge <hao.ge@linux.dev> wrote:
>> >> >
>> >> > From: Hao Ge <gehao@kylinos.cn>
>> >> >
>> >> > Since OBJEXTS_ALLOC_FAIL and MEMCG_DATA_OBJEXTS currently share
>> >> > the same bit position, we cannot determine whether memcg_data still
>> >> > points to the slabobj_ext vector simply by checking
>> >> > folio->memcg_data & MEMCG_DATA_OBJEXTS.
>> >> >
>> >> > If obj_exts allocation failed, slab->obj_exts is set to OBJEXTS_ALLOC_FAIL,
>> >> > and during the release of the associated folio, the BUG check is triggered
>> >> > because it was mistakenly assumed that a valid folio->memcg_data
>> >> > was not cleared before freeing the folio.
>> > 
>> > nit: yesterday I was confused that this is sanity checks in buddy complaining
>> > folio->memcg_data not being cleared, but it's actually folio_memcg_kmem()
>> > complaining that MEMCG_OBJEXTS_DATA flag is set on non-slab folios (in
>> > free_pages_prepare(), if PageMemcgKmem(page) -> __memcg_kmem_uncharge_page()))
>> > So the paragraph above should be updated?
>> > 
>> > And as a side question, we clear slab->obj_exts when freeing obj_ext array,
>> > but don't clear OBJEXTS_ALLOC_FAIL when freeing a slab? That's not good.
>> 
>> Hm great point. We should rather make sure it's cleared always, instead of
>> adjusting the debugging check, which shouldn't be then necessary, right?
> 
> Yeah folio_memcg_kmem() isn't supposed to be called on slabs anyway
> (it's not a slab at the time we free it to buddy), so we don't have to
> adjust the debug check.

Great. Hao Ge, can you please send v4 that instead of adjusting the
VM_BUG_ON modifies free_slab_obj_exts() to always clear slab->obj_exts? Thanks!

>> >> > So let's check for memcg_data != OBJEXTS_ALLOC_FAIL in folio_memcg_kmem.
>> >> >
>> >> > Fixes: 7612833192d5 ("slab: Reuse first bit for OBJEXTS_ALLOC_FAIL")
>> >> > Suggested-by: Harry Yoo <harry.yoo@oracle.com>
>> >> > Signed-off-by: Hao Ge <gehao@kylinos.cn>
>> >> 
>> >> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>> >>
>> >> nit: I think it would be helpful if the changelog explained why we
>> >> need the additional check. We can have the same bit set in two
>> >> different situations:
>> >> 1. object extension vector allocation failure;
>> >> 2. memcg_data pointing to a valid mem_cgroup.
>> >> To distinguish between them, we need to check not only the bit itself
>> >> but also the rest of this field. If the rest is NULL, we have case 1,
>> >> otherwise case 2.
>> > 
>> > Agreed.
>> > 
>> > In general LGTM,
>> > Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>> > 
>> > By the way, maybe it'd be nice to introduce a new helper function that
>> > properly checks MEMCG_DATA_OBJEXTS flag.
>> 
>> I thought so too at first...
>> 
>> >> ~/slab (slab/for-next-fixes)> git grep -n MEMCG_DATA_OBJEXTS
>> >> include/linux/memcontrol.h:337:	MEMCG_DATA_OBJEXTS = (1UL << 0),
>> >> include/linux/memcontrol.h:344:#define __OBJEXTS_ALLOC_FAIL	MEMCG_DATA_OBJEXTS
>> >> include/linux/memcontrol.h:358:	 * MEMCG_DATA_OBJEXTS.
>> > 
>> >> include/linux/memcontrol.h:400:	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);
>> >> include/linux/memcontrol.h:421:	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);
>> > 
>> > these two,
>> > 
>> >> include/linux/memcontrol.h:492:	if (memcg_data & MEMCG_DATA_OBJEXTS)
>> > 
>> > this,
>> > 
>> >> include/linux/memcontrol.h:538:			(folio->memcg_data & MEMCG_DATA_OBJEXTS),
>> >> include/linux/memcontrol.h:1491: * if MEMCG_DATA_OBJEXTS is set.
>> >> mm/kfence/core.c:624:				 MEMCG_DATA_OBJEXTS;
>> > 
>> >> mm/page_owner.c:513:	if (memcg_data & MEMCG_DATA_OBJEXTS)
>> > 
>> > this,
>> > 
>> >> mm/slab.h:541:	 * MEMCG_DATA_OBJEXTS bit set or be equal to OBJEXTS_ALLOC_FAIL.
>> >> mm/slab.h:543:	VM_BUG_ON_PAGE(obj_exts && !(obj_exts & MEMCG_DATA_OBJEXTS) &&
>> >> mm/slub.c:2137:	new_exts |= MEMCG_DATA_OBJEXTS;
>> >> tools/mm/show_page_info.py:55:        MEMCG_DATA_OBJEXTS = prog.constant("MEMCG_DATA_OBJEXTS").value_()
>> > 
>> >> tools/mm/show_page_info.py:59:        if memcg_data & MEMCG_DATA_OBJEXTS:
>> > 
>> > and this do not look good.
>> > 
>> > I mean technically they are fine since OBJEXTS_ALLOC_FAIL is set on
>> > slabs only, but that's just a coincidence.
>> 
>> And checked the the other debugging checks too. But then thought it's better
>> that if these are not expected to see slabs, then they should not be
>> adjusted. I don't see it as a coincidence but as intention to keep it slab
>> specific. It will be also more future proof for the upcoming separation of
>> struct slab from struct page.
> 
> Then we're intentionally using (folio->memcg_data & MEMCG_DATA_OBJEXTS) check
> as a way to determine whether the folio is a slab (either slabobj_ext array
> allocation succeeded or failed).
> 
> That makes sense to me!
> 
>> >> > ---
>> >> > v3: Simplify the solution, per Harry's suggestion in the v1 comments
>> >> >     Add Suggested-by: Harry Yoo <harry.yoo@oracle.com>
>> >> > ---
>> >> >  include/linux/memcontrol.h | 4 +++-
>> >> >  1 file changed, 3 insertions(+), 1 deletion(-)
>> >> >
>> >> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> >> > index 873e510d6f8d..7ed15f858dc4 100644
>> >> > --- a/include/linux/memcontrol.h
>> >> > +++ b/include/linux/memcontrol.h
>> >> > @@ -534,7 +534,9 @@ static inline struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *ob
>> >> >  static inline bool folio_memcg_kmem(struct folio *folio)
>> >> >  {
>> >> >         VM_BUG_ON_PGFLAGS(PageTail(&folio->page), &folio->page);
>> >> > -       VM_BUG_ON_FOLIO(folio->memcg_data & MEMCG_DATA_OBJEXTS, folio);
>> >> > +       VM_BUG_ON_FOLIO((folio->memcg_data != OBJEXTS_ALLOC_FAIL) &&
>> >> > +                       (folio->memcg_data & MEMCG_DATA_OBJEXTS),
>> >> > +                       folio);
>> >> >         return folio->memcg_data & MEMCG_DATA_KMEM;
>> >> >  }
>> >> >
>> >> > --
>> >> > 2.25.1
>> > 
>> 
> 


