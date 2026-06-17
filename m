Return-Path: <cgroups+bounces-17046-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HlsUMS+yMmrk3gUAu9opvQ
	(envelope-from <cgroups+bounces-17046-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 16:41:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C0F69A9E4
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 16:41:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=MQc9M1xA;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17046-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17046-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 988773106E42
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 14:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA46A44B675;
	Wed, 17 Jun 2026 14:40:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFF23DB960
	for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 14:40:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707251; cv=pass; b=d3SqE3+1SLPbya2cKogG8H1X6tuWNmFwl+O+teo5vdRFqA7viTxvLC/Aj5YUH3/3RdHggGOufsCkqLdQ4Qa5njYh/FBgvK4P/a4BYwwRo2RIgJs/ASgFAlBevJBl96G6xjMp3DgZBpEmv3Shh7vwD5rtpnGINn+r28YU7EJbVy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707251; c=relaxed/simple;
	bh=cRydp4W2/TDAsDWKlh+whwfZMy/N3DJe7on4E0pF0sU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rdh71ofsQwgBlA3TIbGNHFsRCWwvfPapvgchz4adeG2OV9Kexa8iK6r7zzV/FZhnDmj65XoAm96qvBEVqJQkAiKJu7AfdRGQr2l7rZhDBM6+dcPLfYCszHwUUMGeLUrwfh67h8GBbs+JnMxZa0Y8NC2hal/97rU9BVKDWdcD+MY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MQc9M1xA; arc=pass smtp.client-ip=209.85.160.173
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5177d1ff061so265081cf.1
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 07:40:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781707249; cv=none;
        d=google.com; s=arc-20240605;
        b=UROuhBnXSiOa+oDOrN4QsdngnuhKIoQmhk8YoWey99AS1kPBNc3xAglQzik2c4pNkz
         WokxTUUNbjuO6J9ANtQKqPcHv/hoh88zuqoIzfXfkQRqMrCK7pzkuFh+se17282YGD2P
         H+d6yVX1q0ijv2rfwGE9Bfsw0NofF2j3t70Fp7OlqWTrNajwnHSbYnamwQrfwKP8aA4y
         ZujQcDJkkSa6Hd6nP1yKsV8xLgI9HnT0T2Vg3GX77aCDYeRTkx9tYh4cV/YqK52Qw9i3
         JqHI8EUBE1/8EB0CNCEcz1tE1/DWsncQNkYEL2WZXp1TPQI7wKrq9X2M8UBxFPZSyF+m
         KfYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fLldEnRgCoRrO2LVnpcdrMsXlvj2tRLQs6man+PstFw=;
        fh=2+eirvbLAQ+wv3WkhEpiJs4gJAmud+75Mbn2PfhRR1I=;
        b=VAtcaStSnhKtqmfwhIWfdUGiD6aeLHVb/N1AjTNq2mxtyZx9i4gXCRKvyJ/s9UEGQC
         n+ZEBaZINHVRZ/lQJelBzbOcZdHAES60TzqAITE5yMH2V8//1yQTH+joiskRmGr4veM/
         +knEKVLH7wskic2/E4F052bZxMSTmp9b8AatcaXXrdkrFKAsbPg+ZT6CRa6EHTd8GvK/
         mMxbGO3k5kIvB9Y+4FtPVs6ltXxli4PTiuuMHr2lFQH6dFetPuGUMIpPdcOiwvDcyfgH
         DaXLzgYEimjsUMUUyuG3owMrZJ9tV5ZnjINqWRwLI/p9ReZvnz49YrQRaCpbpvbs4H58
         6aMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781707249; x=1782312049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLldEnRgCoRrO2LVnpcdrMsXlvj2tRLQs6man+PstFw=;
        b=MQc9M1xAZc3VegHmCAFF3L0R6vJVGkYMR3yBO/m8mcgxdTjfqKVzmd3xXzMl+EcPwi
         dA4U/Tn+/q9CdQ6v4DFP2D3UuerbzyPH7ucgMonw6XzVBihPWajYkbL+jQjAxv0SkJgs
         OD4D2qUjELqYBXgMg6EP7H1HlrSndgjJx0Tvuqjc/Mz7Y39n1SozySC4b60xsB94hVDR
         v0ZeTVlgjVpeFAR6W8QAsTGD9GD09t9GbWBwTtY0p70BUzcLpsixJ/7LCBtmW+zHZPY7
         o4CNa3sOflYTkCYR18mc0emHulcqEJVAfQrvyyrUVxayb1Bd+TS4O0BECLItza0DQ1Tb
         YoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781707249; x=1782312049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fLldEnRgCoRrO2LVnpcdrMsXlvj2tRLQs6man+PstFw=;
        b=IOx7C4sB5cEKL6x3PSMeuOGdqmHasiaWANMGhz/YihvPd7Dz6FheesKZTgSMAkT9c9
         M7aZzmKVaFrWe/mn2MOV90Ch+Tkz/Nw8Tfah8+t3dBDuG7C++n03wuF8mJ6X1FnQ8crp
         odSCiqcm4GBAJQKnMojDp1+zeH2x5i8VUCtg2Vt/w6hXgBI0FiLi/vzCfVi3i0dTkisF
         4mmE21Ca3OVao+0uv4ohpOb0L5ZDhq/XtFJJ8TRm6g8vtiVbx+ejDcn8k1J60BRdu6PT
         dYLRNI9KjfoqDKXikBgtADQRbfjc7pD52NaNPi4gRuEX30gncM69u95KV+Ta5qf4U4ov
         GyUg==
X-Forwarded-Encrypted: i=1; AFNElJ+oP+bCJaSixHx03XVIreOm7+jPgPaZ68f68ZC9kwOloUz0YXzu1lFgf5AG13BTkdA/j53+nrDS@vger.kernel.org
X-Gm-Message-State: AOJu0YwuviJ5ls7nM9YevlFnM5CBOstGnqIgOz8ZtrON5R/BGXUYJD/z
	ZDrd+ow0TnwbHkZANLVXLRvjWe7HNCJmkIvNQoVogUk2mjmYTGqIgp+3HRQGtaHa9N+yOfh/6gY
	gd3V+V0hGL2dZ7Lv1gfxGeYr/cTJ7md+XNRr+zJFq
X-Gm-Gg: Acq92OFidCD6edOrtZoFFWXQTbFAOFKZucl0584jz443P9XmNhxHPcNdybRjX4BayvO
	HbqKbklRQ5UhtDGU4JrxQwOl5kqCmOfuz/QLEZtXy3Y/leSYTUdENpGIFqLGht3r9DqSkfxMAjU
	uV6EfHfIiCF6Ly/OXxfT8M5eZozCvMxdVEZTidFIcli8VvlyLRetCwq6yX59nn7JrMV6BGuToyX
	oDvD4y1eQA1My9LC6qmtx6JRHQwkZCHi9ROlCxg6GULNAEBlbh2mt7lFNtWKMaxVu3yUY2Fr/CG
	EmLV0Ok2DdWBS6/bGRl6cPVYTvc=
X-Received: by 2002:a05:622a:4a06:b0:50e:595d:164 with SMTP id
 d75a77b69052e-519aa968720mr10392311cf.8.1781707248570; Wed, 17 Jun 2026
 07:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615-slab_alloc_flags-v3-0-ce1146d140fb@kernel.org> <20260615-slab_alloc_flags-v3-6-ce1146d140fb@kernel.org>
In-Reply-To: <20260615-slab_alloc_flags-v3-6-ce1146d140fb@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 17 Jun 2026 07:40:36 -0700
X-Gm-Features: AVVi8CczXRRxBrbANo6lmOZl2uVP8dSZqTCSvZ0PGtq9Y6RVmxiC-ZjFk4f-2SI
Message-ID: <CAJuCfpEcRj46xRjRXBLeJ_ZOk5COUprNvqRrgiBiQwGTPLhXtA@mail.gmail.com>
Subject: Re: [PATCH v3 06/15] mm/slab: add alloc_flags to slab_alloc_context
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:harry@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[surenb@google.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-17046-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:email,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 29C0F69A9E4

On Mon, Jun 15, 2026 at 4:55=E2=80=AFAM Vlastimil Babka (SUSE)
<vbabka@kernel.org> wrote:
>
> Add alloc_flags as a new field to the slab_alloc_context helper struct,
> so we can pass it to more functions in the slab implementation without
> adding another function parameter.
>
> Start checking them via alloc_flags_allow_spinning() in
> alloc_single_from_new_slab() (where we can drop the allow_spin
> parameter), ___slab_alloc(), get_from_partial_node() and
> get_from_any_partial(). This further reduces false-positive
> spinning-not-allowed from allocations that are not kmalloc_nolock() but
> lack __GFP_RECLAIM flags.
>
> _kmalloc_nolock_noprof() initializes ac.alloc_flags using its flags that
> are SLAB_ALLOC_NOLOCK. slab_alloc_node() and __kmem_cache_alloc_bulk()
> are not reachable from kmalloc_nolock() and all their callers expect
> spinning to be allowed, so they can use SLAB_ALLOC_DEFAULT. This is
> temporary as the scope of slab_alloc_context will further move to the
> callers, making the alloc_flags usage more obvious.
>
> Also change how trynode_flags are constructed in ___slab_alloc() to
> achieve the same "do not upgrade to GFP_NOWAIT" by using masking instead
> of checking allow_spin. We need to do that because we now determine
> allow_spin from alloc_flags, and would otherwise start to upgrade e.g.
> kmalloc() allocations without __GFP_KSWAPD_RECLAIM (that however do
> allow spinning) to GFP_NOWAIT, thus including __GFP_KSWAPD_RECLAIM.
>
> During the masking keep also existing __GFP_NOMEMALLOC (pointed out by
> Sashiko) and __GFP_ACCOUNT. Previously the hardcoded GFP_NOWAIT would
> eliminate them, but it's not a big problem that would need a separate
> fix.
>
> Link: https://patch.msgid.link/20260610-slab_alloc_flags-v2-6-7190909db11=
8@kernel.org
> Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
> Reviewed-by: Hao Li <hao.li@linux.dev>
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  mm/slub.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 6f6c15d796e1..3a34907b881b 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -217,6 +217,7 @@ static DEFINE_STATIC_KEY_FALSE(strict_numa);
>  struct slab_alloc_context {
>         unsigned long caller_addr;
>         size_t orig_size;
> +       unsigned int alloc_flags;
>  };
>
>  /* Structure holding parameters for get_partial_node_bulk() */
> @@ -3687,9 +3688,9 @@ static inline void init_slab_obj_iter(struct kmem_c=
ache *s, struct slab *slab,
>   * and put the slab to the partial (or full) list.
>   */
>  static void *alloc_single_from_new_slab(struct kmem_cache *s, struct sla=
b *slab,
> -                                       const struct slab_alloc_context *=
ac,
> -                                       bool allow_spin)
> +                                       const struct slab_alloc_context *=
ac)
>  {
> +       bool allow_spin =3D alloc_flags_allow_spinning(ac->alloc_flags);
>         struct kmem_cache_node *n;
>         struct slab_obj_iter iter;
>         bool needs_add_partial;
> @@ -3835,7 +3836,7 @@ static void *get_from_partial_node(struct kmem_cach=
e *s,
>         if (!n || !n->nr_partial)
>                 return NULL;
>
> -       if (gfpflags_allow_spinning(gfp_flags))
> +       if (alloc_flags_allow_spinning(ac->alloc_flags))
>                 spin_lock_irqsave(&n->list_lock, flags);
>         else if (!spin_trylock_irqsave(&n->list_lock, flags))
>                 return NULL;
> @@ -3891,7 +3892,7 @@ static void *get_from_any_partial(struct kmem_cache=
 *s, gfp_t gfp_flags,
>         struct zone *zone;
>         enum zone_type highest_zoneidx =3D gfp_zone(gfp_flags);
>         unsigned int cpuset_mems_cookie;
> -       bool allow_spin =3D gfpflags_allow_spinning(gfp_flags);
> +       bool allow_spin =3D alloc_flags_allow_spinning(ac->alloc_flags);
>
>         /*
>          * The defrag ratio allows a configuration of the tradeoffs betwe=
en
> @@ -4449,7 +4450,7 @@ static unsigned int alloc_from_new_slab(struct kmem=
_cache *s, struct slab *slab,
>  static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int nod=
e,
>                            const struct slab_alloc_context *ac)
>  {
> -       bool allow_spin =3D gfpflags_allow_spinning(gfpflags);
> +       bool allow_spin =3D alloc_flags_allow_spinning(ac->alloc_flags);
>         gfp_t trynode_flags;
>         void *object;
>         struct slab *slab;
> @@ -4466,18 +4467,15 @@ static void *___slab_alloc(struct kmem_cache *s, =
gfp_t gfpflags, int node,
>          * 1) try to get a partial slab from target node only by having
>          *    __GFP_THISNODE in trynode_flags for get_from_partial()
>          * 2) if 1) failed, try to allocate a new slab from target node w=
ith
> -        *    GPF_NOWAIT | __GFP_THISNODE opportunistically
> +        *    (at most) GFP_NOWAIT | __GFP_THISNODE opportunistically
>          * 3) if 2) failed, retry with original gfpflags which will allow
>          *    get_from_partial() try partial lists of other nodes before
>          *    potentially allocating new page from other nodes
>          */
>         if (unlikely(node !=3D NUMA_NO_NODE && !(gfpflags & __GFP_THISNOD=
E)
>                      && try_thisnode)) {
> -               if (unlikely(!allow_spin))
> -                       /* Do not upgrade gfp to NOWAIT from more restric=
tive mode */
> -                       trynode_flags =3D gfpflags | __GFP_THISNODE;
> -               else
> -                       trynode_flags =3D GFP_NOWAIT | __GFP_THISNODE;
> +               trynode_flags &=3D GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_=
ACCOUNT;
> +               trynode_flags |=3D __GFP_NOWARN | __GFP_THISNODE;
>         }
>
>         object =3D get_from_partial(s, node, trynode_flags, ac);
> @@ -4499,7 +4497,7 @@ static void *___slab_alloc(struct kmem_cache *s, gf=
p_t gfpflags, int node,
>         stat(s, ALLOC_SLAB);
>
>         if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
> -               object =3D alloc_single_from_new_slab(s, slab, ac, allow_=
spin);
> +               object =3D alloc_single_from_new_slab(s, slab, ac);
>
>                 if (likely(object))
>                         goto success;
> @@ -4918,6 +4916,7 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache =
*s, gfp_t gfp, size_t size,
>  static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, str=
uct list_lru *lru,
>                 gfp_t gfpflags, int node, unsigned long addr, size_t orig=
_size)
>  {
> +       const unsigned int alloc_flags =3D SLAB_ALLOC_DEFAULT;
>         void *object;
>
>         s =3D slab_pre_alloc_hook(s, gfpflags);
> @@ -4928,12 +4927,13 @@ static __fastpath_inline void *slab_alloc_node(st=
ruct kmem_cache *s, struct list
>         if (unlikely(object))
>                 goto out;
>
> -       object =3D alloc_from_pcs(s, gfpflags, SLAB_ALLOC_DEFAULT, node);
> +       object =3D alloc_from_pcs(s, gfpflags, alloc_flags, node);
>
>         if (unlikely(!object)) {
>                 const struct slab_alloc_context ac =3D {
>                         .caller_addr =3D addr,
>                         .orig_size =3D orig_size,
> +                       .alloc_flags =3D alloc_flags,
>                 };
>                 object =3D __slab_alloc_node(s, gfpflags, node, &ac);
>         }
> @@ -5366,6 +5366,7 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size=
, token), gfp_t gfp_flags, in
>         const struct slab_alloc_context ac =3D {
>                 .caller_addr =3D _RET_IP_,
>                 .orig_size =3D orig_size,
> +               .alloc_flags =3D alloc_flags,
>         };
>
>         VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO |
> @@ -7254,6 +7255,7 @@ static bool __kmem_cache_alloc_bulk(struct kmem_cac=
he *s, gfp_t flags,
>                 const struct slab_alloc_context ac =3D {
>                         .caller_addr =3D _RET_IP_,
>                         .orig_size =3D s->object_size,
> +                       .alloc_flags =3D SLAB_ALLOC_DEFAULT,
>                 };
>                 for (i =3D 0; i < size; i++) {
>
>
> --
> 2.54.0
>

