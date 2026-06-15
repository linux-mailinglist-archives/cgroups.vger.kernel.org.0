Return-Path: <cgroups+bounces-16937-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DElnAkCQL2pGCgUAu9opvQ
	(envelope-from <cgroups+bounces-16937-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 07:40:16 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5929E6838BB
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 07:40:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=XzJLuflZ;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16937-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16937-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5C203014113
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 05:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A30036AB7C;
	Mon, 15 Jun 2026 05:39:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC7037880B
	for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 05:38:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781501939; cv=pass; b=o8LOyeC06JWVc8IavsWgeriq4Efe4g6M6qQCzqmwfVwBNLoe02vklPrbcJE4eh/M+j8BGFtzzc3sCSFp4XT+A0JelTwMDkWJOF0GGQe16OGXVcfqrsksoBeWQHJV4sgWbq7Ysq36/erYNoD3LWEBKH5ui0tpU8jgtIgtiHB1tw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781501939; c=relaxed/simple;
	bh=1R8kc2wueoidF8V5TzS6mLiXl5zYKx0KeZfLbbzUC8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e2tGNBoKetzYCcOd9MsxjIoI1Vby7wMqNIudDPCzZ0kFRsq6VYyDo8tkSxgvUNfSCDp6YHFjUtHX+6v4jO0VaWCZL/L2J84W60/V4ekwICdkAjXRMxtJyRVud6S5cn2CYFbVgSPuXenxi5h9S1aqmP/Wza2Xwv0gTwaOfuCTBkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XzJLuflZ; arc=pass smtp.client-ip=209.85.160.175
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5177d1ff061so744321cf.1
        for <cgroups@vger.kernel.org>; Sun, 14 Jun 2026 22:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781501935; cv=none;
        d=google.com; s=arc-20240605;
        b=U/xnTyheVAVPKBphhZ6Yywj3OBBxOSyrwM//ph2kNpbs97EJKtM9wkmac7zsupA7cw
         p/mBymhKiN4tRXJcoLcLwDReC3MMGKK+kgogSByWAnCB6VI5onTLV2v3evJ9mwGabEDZ
         qtyZ1+Y/+UQZ2Z3VnCka3PiSGuKjsg50jlu5Yx9QOAY+UAJz5+CMw/JRoC3w6hXvHB8r
         8AoeFo/iKfJYnmz/86hzaQFfEI82k7oi/b2gt5WMENPeUzpazTgTpmlcpKy2vue0ta9j
         Pdonihz0pVxE65A/cwBNsoqQxPskKR7rdzluWVGWCXZjqI3jQjqyVvql+rFTgKHAmUzl
         VG0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z4bnIeDaNSPPrqMDBXyAFUZle3FRm0a9rX7dbKOylDo=;
        fh=0ChNqxIDLLD3FOG6Du4KsPqvJ+IGcSEg7xadR/y5Oek=;
        b=JKKFlX+2ERniLQhqFs8vcaJdKr+UoTiTxzg2ylq+5RGZUYt65dn+ogsMmPrjW97oXG
         W+0k0f25E1YGtOb4STCUZ0URJbYYKvmDbz9GSYqHzsyFElgCZNnvs+hVNZ8vuNSJo4HS
         ywHEEPWVLf4B+tgPiz3J8Mu0bQI7TIPit4k++EbaVWWzWu8qv167CKdVDhQYN/1ZFOX2
         KGuUOjB2Ced8q2ydLm8Txp6RgqfzKiIEVjZoun45Ms8A4tDuzAvrcWNNy20e1aW9ZCi9
         GQFc8WgICceOKvwFuNvLvGvUdQltUhBQqmNGJuM+cto4jUYCQwyRQm96oDKDtKT3OWtE
         xtGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781501935; x=1782106735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4bnIeDaNSPPrqMDBXyAFUZle3FRm0a9rX7dbKOylDo=;
        b=XzJLuflZBWIj3yT+77HdT6pz6412eknEWWj56PQUo6CztRSTEg+C3VxQ76AeJb93io
         D1mtrQ+3uwmQK8WHgLpTmVpSWItosw3TPkNRP5YMJ6pHYlepJhM3J4SMNq4XTWg5qkON
         BYFwdE66vAqePLnufsMw96V32/LP1jKQhnBVHPfWkk+zkvGwH0JDGXJY+yNXChDGT/At
         9eZB+/etJLIZ46Fvc70fMtlK1g3eGqNX9ahG+7/7PpokPOieOWSQowbeXBbpplJ6bHFs
         LrzYp91CpiqbkD1wZfVh071m2tZz2bHTtSult40xQ2RVZTpJG8qFt+auVrUdPEEfCb97
         VNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781501935; x=1782106735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z4bnIeDaNSPPrqMDBXyAFUZle3FRm0a9rX7dbKOylDo=;
        b=RwoJn5cqb6Sex0F61QLFZZq64xtaJAuEbcZyugGSSlXujukKmz116wsnFFAFNQW9FX
         KqHr0/VyLmFMmQ4pdBNqJGnokBhsV/A2umVD/eiqPNSOM/w7fntzFh+ZzJN0kSMOTxG9
         Q0p2Orz0juUSedOnS7pZ0rhZJi0dA4aUlAg0E61bvSHWrEouV5zJfQLQ/LcuZPOdpR66
         ipHp4og5APcXyWWEBjwSCQgSOeHqSxhq13N7wwYivlDeyFlvdRv7s5kbIzc6U9FJlG7Z
         x/XdlDEnBOj5u0he/4LfjQ9BHdCIqJv+9Ie90HM4UIoZtann0ApQfD3VrVhSTUhcGvta
         SfDA==
X-Forwarded-Encrypted: i=1; AFNElJ/GXpyVXiaRaoVDC71U0+1X3GpNAHRudDVGh72x9S7zLtXiHL6gXVbg1+y6iZdukJsYNBUHfHMi@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkz+c5v6kcWa6+VtYMM+5u1zHB8xdLzrOS66sScO26eN77q9Pv
	5krFpA7paD5otzOKtTWFxTAitLV8qpAZ2H3y59/HjRwRM8jBdPbukgeYPhHiKWibwldmdpzok5n
	m20GnNwoSkH7H340epiE1ncZkIw6zCPSd2wCAi6eY
X-Gm-Gg: Acq92OFlcS0xLFWuOv1gLZ5h8kgMqDFegkVElVmjh3qscTECQPozi0L+VTduWAl1mAB
	PgD7EIQlMV1kop490Sk58B0LNIYLlLMLyj6mkMIHPoQAZDt9DsHLjYvUYw+tfXAfzDmo8vFWDPg
	7HISGZlThp7GayB8wmwfGPZRQx/3OGrPE3HOqNWqB8BQyw6L6a6+I/MRlsA3lxNFrRnl/nlYVzI
	KmoKU9P1J4026Afs3SIldfvEpkB+9ySq491nBaYVmdG6YH55wP3a07z3h5rjBw6VHi39a1wTDvZ
	y/jAME/8EcL35gs8
X-Received: by 2002:a05:622a:164d:b0:516:4f62:85e6 with SMTP id
 d75a77b69052e-51955eb53cdmr13355061cf.17.1781501934662; Sun, 14 Jun 2026
 22:38:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-15-7190909db118@kernel.org> <aiurbPx1SISBarBy@fedora>
 <49f1bf1e-fcaf-48fa-a7b1-f8ee78b19762@kernel.org> <aivpob0Zgnbc4AG4@fedora>
In-Reply-To: <aivpob0Zgnbc4AG4@fedora>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 14 Jun 2026 22:38:43 -0700
X-Gm-Features: AVVi8Cdhr2RooHXSlNvj28OLPacEXOJK306RRvpVNfECIcIuVo5lz4eM6C6SxwQ
Message-ID: <CAJuCfpFNftMYw0XoHyN1QAWfm7NYmeuY1T_NGbYy8boGO48MOg@mail.gmail.com>
Subject: Re: [PATCH v2 15/16] mm/slab: remove __GFP_NO_OBJ_EXT usage from alloc_slab_obj_exts()
To: Hao Li <hao.li@linux.dev>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Hao Ge <hao.ge@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hao.li@linux.dev,m:vbabka@kernel.org,m:harry@kernel.org,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:hao.ge@linux.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[surenb@google.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-16937-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[surenb@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5929E6838BB

On Fri, Jun 12, 2026 at 4:30=E2=80=AFAM Hao Li <hao.li@linux.dev> wrote:
>
> On Fri, Jun 12, 2026 at 12:17:45PM +0200, Vlastimil Babka (SUSE) wrote:
> > On 6/12/26 08:54, Hao Li wrote:
> > > On Wed, Jun 10, 2026 at 05:40:17PM +0200, Vlastimil Babka (SUSE) wrot=
e:
> > >> __GFP_NO_OBJ_EXT has limited scope within the slab allocator itself =
and
> > >> gfp flags are a scarce resource, unlike slab's alloc_flags.
> > >>
> > >> Introduce SLAB_ALLOC_NO_RECURSE alloc flag that has the same intent =
as
> > >> __GFP_NO_OBJ_EXT but a more generic name, meaning that a kmalloc()
> > >> family function should not recurse into another kmalloc*() for the
> > >> purposes of allocating auxiliary structures (obj_ext arrays or sheav=
es).
> > >>
> > >> First, replace the __GFP_NO_OBJ_EXT for allocating obj_ext arrays in
> > >> alloc_slab_obj_exts(). Make use of the newly added kmalloc_flags()
> > >> function, where we can pass alloc_flags with SLAB_ALLOC_NO_RECURSE
> > >> added. This will also pass through SLAB_ALLOC_TRYLOCK so we don't ne=
ed
> > >> to special case kmalloc_nolock() anymore.
> > >>
> > >> Note that until now the kmalloc_nolock() ignored the incoming gfp fl=
ags
> > >> and hardcoded __GFP_ZERO | __GFP_NO_OBJ_EXT. But it's correct to pas=
s on
> > >> the incoming gfp flags (only augmented with __GFP_ZERO), because if
> > >> alloc_flags contain SLAB_ALLOC_TRYLOCK, the incoming gfp flags have =
to
> > >> be also compatible with it.
> > >>
> > >> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> > >> ---
> > >>  mm/slab.h |  1 +
> > >>  mm/slub.c | 13 +++++--------
> > >>  2 files changed, 6 insertions(+), 8 deletions(-)
> > >>
> > >> diff --git a/mm/slab.h b/mm/slab.h
> > >> index 45bfcfb35a9c..509f330654b8 100644
> > >> --- a/mm/slab.h
> > >> +++ b/mm/slab.h
> > >> @@ -21,6 +21,7 @@
> > >>  #define SLAB_ALLOC_DEFAULT        0x00 /* no flags */
> > >>  #define SLAB_ALLOC_TRYLOCK        0x01 /* a kmalloc_nolock() alloca=
tion */
> > >>  #define SLAB_ALLOC_NEW_SLAB       0x02 /* a flag for alloc_slab_obj=
_exts() */
> > >> +#define SLAB_ALLOC_NO_RECURSE     0x04 /* prevent kmalloc() recursi=
on */
> > >>
> > >>  static inline bool alloc_flags_allow_spinning(const unsigned int al=
loc_flags)
> > >>  {
> > >> diff --git a/mm/slub.c b/mm/slub.c
> > >> index cbb38bd01e46..7dfbd0251aa2 100644
> > >> --- a/mm/slub.c
> > >> +++ b/mm/slub.c
> > >> @@ -2167,15 +2167,12 @@ int alloc_slab_obj_exts(struct slab *slab, s=
truct kmem_cache *s,
> > >>
> > >>    gfp &=3D ~OBJCGS_CLEAR_MASK;
> > >>    /* Prevent recursive extension vector allocation */
> > >> -  gfp |=3D __GFP_NO_OBJ_EXT;
> > >> +  alloc_flags |=3D SLAB_ALLOC_NO_RECURSE;
> > >>
> > >>    sz =3D obj_exts_alloc_size(s, slab, gfp);
> > >>
> > >
> > > For the original calls to kmalloc_nolock and kmalloc_node, I notice a=
 difference:
> > >
> > >> -  if (unlikely(!allow_spin))
> > >> -          vec =3D kmalloc_nolock(sz, __GFP_ZERO | __GFP_NO_OBJ_EXT,
> > >> -                               slab_nid(slab));
> > >
> > > kmalloc_nolock completely discarded `gfp` flags.
> > >
> > >> -  else
> > >> -          vec =3D kmalloc_node(sz, gfp | __GFP_ZERO, slab_nid(slab)=
);
> > >
> > > while kmalloc_node preserved and passed it along.
> > >
> > >> +  /* This will use kmalloc_nolock() if alloc_flags say so */
> > >> +  vec =3D kmalloc_flags(sz, gfp | __GFP_ZERO, alloc_flags, slab_nid=
(slab));
> > >
> > > Now both paths are merged into kmalloc_flags, the gfp flags are
> > > unconditionally carried through. It seems this might carry some unwan=
ted flags.
> > >
> > > I traced the call path and found that ___slab_alloc sets the __GFP_TH=
ISNODE
> > > for trynode_flags. If this flag propagates all the way into
> > > kmalloc_flags->...->__kmalloc_nolock_noprof, it will trigger the
> > > VM_WARN_ON_ONCE warning. Maybe we need to strip the original gfp if
> > > `!allow_spin`.
> >
> > Thanks. This should do the job in a more generic way I hope?
> >
>
> Yeah, this is more elegant.
>
> > diff --git a/mm/slub.c b/mm/slub.c
> > index f9b8dc56bb57..0bf53f70c9be 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2047,12 +2047,15 @@ static inline void dec_slabs_node(struct kmem_c=
ache *s, int node,
> >  #endif /* CONFIG_SLUB_DEBUG */
> >
> >  /*
> > - * The allocated objcg pointers array is not accounted directly.
> > + * The allocated objcg pointers array or sheaf is not accounted direct=
ly.
> >   * Moreover, it should not come from DMA buffer and is not readily
> > - * reclaimable. So those GFP bits should be masked off.
> > + * reclaimable. Node restriction for the parent allocation also should
> > + * not apply to the slab's internal objects.
> > + * So those GFP bits should be masked off.
> >   */
> >  #define OBJCGS_CLEAR_MASK      (__GFP_DMA | __GFP_RECLAIMABLE | \
> > -                               __GFP_ACCOUNT | __GFP_NOFAIL)
> > +                               __GFP_ACCOUNT | __GFP_NOFAIL |
> > +                               __GFP_THISNODE )
>
> Good idea! Both code and comments make sense to me.

Makes sense. I see
https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=3Dsl=
ab/for-next
already implementing this and also keeping __GFP_NO_OBJ_EXT and
SLAB_ALLOC_NO_RECURSE both used. That version looks good to me, so
I'll wait for v3.

At the end of this series, we end up with no users of __GFP_NO_OBJ_EXT
but we still keep it defined. I'm guessing you leave it because of the
new patch [1] which aliases __GFP_NO_OBJ_EXT? I will have to make that
mechanism work without a GFP flag, possibly using a similar approach.
CC'ing Hao Ge to be in the loop of these changes. I'll work with him
on aliminating that __GFP_NO_OBJ_EXT alias.

[1] https://lore.kernel.org/all/20260604024008.46592-1-hao.ge@linux.dev/

>
> >
> >  #ifdef CONFIG_SLAB_OBJ_EXT
> >
> >
>
> --
> Thanks,
> Hao

