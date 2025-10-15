Return-Path: <cgroups+bounces-10768-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A42BDDE10
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 11:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B7DA35211A
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 09:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB1731B133;
	Wed, 15 Oct 2025 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OS+9h61n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UmzdK07H";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OS+9h61n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UmzdK07H"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0604531B12D
	for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760522062; cv=none; b=gpEVBlU6IZwEuBfS63k0RVGf6tqztxls3my9C0jdrUDfLD3hM3c/dx09iyHAS9r/f/zh/Hx1F1qTI7KgoHWwX0XSgwS2cOivRZAlIHzyUzRpQXQlVC6GEDyt1e33ko3x1MCr8EQWfZbvMq3zhGYPGQ7PPeDaKyJjnhBrisQZQek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760522062; c=relaxed/simple;
	bh=HAgJwYsYwj74Z3sOI4Y3FSgl0TcDyoqmJs81su0ANYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3FQaZSNHg3Knf5K9SG+3J67WH6qd4FXxPV67naG7hcovkCoZO9V6kyeTNjW1mfrbmXLHzmopE1LZhYloqGWTj+s8q+RotPHs3yGi5NYlSQF2efrj/DjaaOCBWEQS+Ap0iN8TjzzrNE5vuTesPyPddOuIngPWwGnbP38nD8fQRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OS+9h61n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UmzdK07H; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OS+9h61n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UmzdK07H; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2356A22A49;
	Wed, 15 Oct 2025 09:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760522059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Vt/jwQJIqk4TwKms5vsSdlLSoJHfVELSvvVKFBDVPE0=;
	b=OS+9h61ne/3vTkJUa2tFZEPet65UCbtb3rXEvCGXJ7j/F13ARH0oRVo+4SrwIZzLCXo8Po
	O80W8TEUyOM3ldmZEId1WEIWnhatHYY0PuRhZkBWyyIueOJKLFULG8YdQh+1O36yTc0HWl
	BbmuYmeXsDZPWsKQEwyfUk+w8ks/Mrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760522059;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Vt/jwQJIqk4TwKms5vsSdlLSoJHfVELSvvVKFBDVPE0=;
	b=UmzdK07HNGSDMW4KYQtUa8sCM6tCxRhcJkuAnmhkF3PKpefF8oYMv3QF3k+JBbnNBq0w/P
	j4GsjXI7qSkd47Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OS+9h61n;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UmzdK07H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760522059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Vt/jwQJIqk4TwKms5vsSdlLSoJHfVELSvvVKFBDVPE0=;
	b=OS+9h61ne/3vTkJUa2tFZEPet65UCbtb3rXEvCGXJ7j/F13ARH0oRVo+4SrwIZzLCXo8Po
	O80W8TEUyOM3ldmZEId1WEIWnhatHYY0PuRhZkBWyyIueOJKLFULG8YdQh+1O36yTc0HWl
	BbmuYmeXsDZPWsKQEwyfUk+w8ks/Mrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760522059;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Vt/jwQJIqk4TwKms5vsSdlLSoJHfVELSvvVKFBDVPE0=;
	b=UmzdK07HNGSDMW4KYQtUa8sCM6tCxRhcJkuAnmhkF3PKpefF8oYMv3QF3k+JBbnNBq0w/P
	j4GsjXI7qSkd47Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED79713A42;
	Wed, 15 Oct 2025 09:54:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gwWnOUpv72g1cgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 15 Oct 2025 09:54:18 +0000
Message-ID: <c07838ca-4e6e-4837-b99f-09fd44c7801c@suse.cz>
Date: Wed, 15 Oct 2025 11:54:18 +0200
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
To: Harry Yoo <harry.yoo@oracle.com>, Suren Baghdasaryan <surenb@google.com>
Cc: Hao Ge <hao.ge@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
References: <20251014152751.499376-1-hao.ge@linux.dev>
 <CAJuCfpGBxUmvWoe2xv2-bsF+TY4fK-m1-Z_E3OcyTiSYz5KeAA@mail.gmail.com>
 <aO9okBEZiA4pCNku@hyeyoo>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <aO9okBEZiA4pCNku@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 2356A22A49
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.51

On 10/15/25 11:25, Harry Yoo wrote:
> On Tue, Oct 14, 2025 at 09:12:43AM -0700, Suren Baghdasaryan wrote:
>> On Tue, Oct 14, 2025 at 8:28 AM Hao Ge <hao.ge@linux.dev> wrote:
>> >
>> > From: Hao Ge <gehao@kylinos.cn>
>> >
>> > Since OBJEXTS_ALLOC_FAIL and MEMCG_DATA_OBJEXTS currently share
>> > the same bit position, we cannot determine whether memcg_data still
>> > points to the slabobj_ext vector simply by checking
>> > folio->memcg_data & MEMCG_DATA_OBJEXTS.
>> >
>> > If obj_exts allocation failed, slab->obj_exts is set to OBJEXTS_ALLOC_FAIL,
>> > and during the release of the associated folio, the BUG check is triggered
>> > because it was mistakenly assumed that a valid folio->memcg_data
>> > was not cleared before freeing the folio.
> 
> nit: yesterday I was confused that this is sanity checks in buddy complaining
> folio->memcg_data not being cleared, but it's actually folio_memcg_kmem()
> complaining that MEMCG_OBJEXTS_DATA flag is set on non-slab folios (in
> free_pages_prepare(), if PageMemcgKmem(page) -> __memcg_kmem_uncharge_page()))
> So the paragraph above should be updated?
> 
> And as a side question, we clear slab->obj_exts when freeing obj_ext array,
> but don't clear OBJEXTS_ALLOC_FAIL when freeing a slab? That's not good.

Hm great point. We should rather make sure it's cleared always, instead of
adjusting the debugging check, which shouldn't be then necessary, right?

>> > So let's check for memcg_data != OBJEXTS_ALLOC_FAIL in folio_memcg_kmem.
>> >
>> > Fixes: 7612833192d5 ("slab: Reuse first bit for OBJEXTS_ALLOC_FAIL")
>> > Suggested-by: Harry Yoo <harry.yoo@oracle.com>
>> > Signed-off-by: Hao Ge <gehao@kylinos.cn>
>> 
>> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>>
>> nit: I think it would be helpful if the changelog explained why we
>> need the additional check. We can have the same bit set in two
>> different situations:
>> 1. object extension vector allocation failure;
>> 2. memcg_data pointing to a valid mem_cgroup.
>> To distinguish between them, we need to check not only the bit itself
>> but also the rest of this field. If the rest is NULL, we have case 1,
>> otherwise case 2.
> 
> Agreed.
> 
> In general LGTM,
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> 
> By the way, maybe it'd be nice to introduce a new helper function that
> properly checks MEMCG_DATA_OBJEXTS flag.

I thought so too at first...

>> ~/slab (slab/for-next-fixes)> git grep -n MEMCG_DATA_OBJEXTS
>> include/linux/memcontrol.h:337:	MEMCG_DATA_OBJEXTS = (1UL << 0),
>> include/linux/memcontrol.h:344:#define __OBJEXTS_ALLOC_FAIL	MEMCG_DATA_OBJEXTS
>> include/linux/memcontrol.h:358:	 * MEMCG_DATA_OBJEXTS.
> 
>> include/linux/memcontrol.h:400:	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);
>> include/linux/memcontrol.h:421:	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);
> 
> these two,
> 
>> include/linux/memcontrol.h:492:	if (memcg_data & MEMCG_DATA_OBJEXTS)
> 
> this,
> 
>> include/linux/memcontrol.h:538:			(folio->memcg_data & MEMCG_DATA_OBJEXTS),
>> include/linux/memcontrol.h:1491: * if MEMCG_DATA_OBJEXTS is set.
>> mm/kfence/core.c:624:				 MEMCG_DATA_OBJEXTS;
> 
>> mm/page_owner.c:513:	if (memcg_data & MEMCG_DATA_OBJEXTS)
> 
> this,
> 
>> mm/slab.h:541:	 * MEMCG_DATA_OBJEXTS bit set or be equal to OBJEXTS_ALLOC_FAIL.
>> mm/slab.h:543:	VM_BUG_ON_PAGE(obj_exts && !(obj_exts & MEMCG_DATA_OBJEXTS) &&
>> mm/slub.c:2137:	new_exts |= MEMCG_DATA_OBJEXTS;
>> tools/mm/show_page_info.py:55:        MEMCG_DATA_OBJEXTS = prog.constant("MEMCG_DATA_OBJEXTS").value_()
> 
>> tools/mm/show_page_info.py:59:        if memcg_data & MEMCG_DATA_OBJEXTS:
> 
> and this do not look good.
> 
> I mean technically they are fine since OBJEXTS_ALLOC_FAIL is set on
> slabs only, but that's just a coincidence.

And checked the the other debugging checks too. But then thought it's better
that if these are not expected to see slabs, then they should not be
adjusted. I don't see it as a coincidence but as intention to keep it slab
specific. It will be also more future proof for the upcoming separation of
struct slab from struct page.

>> > ---
>> > v3: Simplify the solution, per Harry's suggestion in the v1 comments
>> >     Add Suggested-by: Harry Yoo <harry.yoo@oracle.com>
>> > ---
>> >  include/linux/memcontrol.h | 4 +++-
>> >  1 file changed, 3 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> > index 873e510d6f8d..7ed15f858dc4 100644
>> > --- a/include/linux/memcontrol.h
>> > +++ b/include/linux/memcontrol.h
>> > @@ -534,7 +534,9 @@ static inline struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *ob
>> >  static inline bool folio_memcg_kmem(struct folio *folio)
>> >  {
>> >         VM_BUG_ON_PGFLAGS(PageTail(&folio->page), &folio->page);
>> > -       VM_BUG_ON_FOLIO(folio->memcg_data & MEMCG_DATA_OBJEXTS, folio);
>> > +       VM_BUG_ON_FOLIO((folio->memcg_data != OBJEXTS_ALLOC_FAIL) &&
>> > +                       (folio->memcg_data & MEMCG_DATA_OBJEXTS),
>> > +                       folio);
>> >         return folio->memcg_data & MEMCG_DATA_KMEM;
>> >  }
>> >
>> > --
>> > 2.25.1
> 


