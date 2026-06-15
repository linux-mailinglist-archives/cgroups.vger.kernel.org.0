Return-Path: <cgroups+bounces-16931-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HQ5gJ3KBL2qJBgUAu9opvQ
	(envelope-from <cgroups+bounces-16931-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 06:37:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 077A16834D3
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 06:37:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="FJkkqq/Y";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16931-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16931-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9A95301C8A4
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 04:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96842246782;
	Mon, 15 Jun 2026 04:35:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D15305680
	for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 04:35:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781498143; cv=pass; b=mKSft4zvAk8yDRHACt0/n22ZNmOSps/UNTwXpquETqLuCwE8CCDumRGeJZcZssfD1uIm7oYXVEsU2Ly4y/CYAMpFx3sZ6UDhFeqwx+XAjYt3EozZSMWtNspl71lkC7GwbZFal99fN2vP9mlhVzuYI+AjFvzkHm+dFS/Mh7JkZzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781498143; c=relaxed/simple;
	bh=aKZmsfAyWtlIFt8RUrLh61nOQU7NkoLCYfFIfil4BFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LU2OgOHus0XtWCn0CDuIoTA/TySRgQw4af3P44z6zAwKc7ziWjng3mZH+DeSqsNU/EF0zJMCTDlFcXrnFRds7a6FwcFZU93V3+iNtM9+eESU1mxC8Kg2R7hn+lx/atruwxjvu70cuNPPxykx2NnglzkPm58GMT4XHVwzsMU8tY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FJkkqq/Y; arc=pass smtp.client-ip=209.85.160.173
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51765531803so853431cf.0
        for <cgroups@vger.kernel.org>; Sun, 14 Jun 2026 21:35:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781498140; cv=none;
        d=google.com; s=arc-20240605;
        b=SKMd6I98UXmuOnT7KFfpuQff6JF5x6/Y5j0Gw2JOmuZ1YGBVrxbc19+RpBLW+pHb2/
         KPRYH9lcASB3IcGF07QjJdfQRyrShjgoZYDvPvpo0+s2Oh02TknDT4n6CHEirHo7bVP3
         fj1iuvomrztiYGel1IOG7jn/J1jzPRC6aNoCBSioZige4Xhl15fZP4O2lq/eSGVZr57r
         qEEu9qOalUGw6vA9v6+/9ZKUSHQg90RNpvsxIEqZfJOS/pc3Rq4AK1gEJ6BMYiux+PYl
         dYfV2KXfI/Imv9n/GsLvwmlac+a+JG1J8KX/o/mapPMeoZe180HD6wtrDpNnqys3nksl
         LtvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bom2krBAQT6Qlap90R6BFlutbauj16k/dhPk3OXzZdQ=;
        fh=zahCyjqJl05JrZLwDhSNPu6Il5G1/P1gp+1T8KlDRXM=;
        b=he0OniaPa/BlKK0aIK6DdPZI879uY+H0QPDNEA0wYhghObzr/fkGSLnq07HsDhzEpS
         vh6mqvOefYbMALuReCd0AX/HvZoyvRa43CayFbJOqzU0gnUPx31CCR3wGALsoDdMTB1+
         Zc8wc2m4pKW56EHeuhtxYWgOSbuQ2S+1zaFgoeTwbwJ0r7ydaIoGAq0OOQ+Dhgc9FDlQ
         EtRB5g/lnr7vnMbnp85sjJLNcCOjuthpwwMvaS8PbEQHTTWsBJxFC5ALvNCmJefhSWSO
         D9X4725VYy0/Y5yL/k97K248QBDhNuVihcllV2N4yDxADI+5LXqm99vfqpCJtM/yG2Yg
         w1sQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781498140; x=1782102940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bom2krBAQT6Qlap90R6BFlutbauj16k/dhPk3OXzZdQ=;
        b=FJkkqq/YT77c1lz8Ychj/uhDgz0zH/MUYPROr0QoAS8478Kd/pusqYi578GiBnFHDY
         K6/PKxpmMQYOocF7Z0WZjOGkMfaAj3oyWgCKSUOlOf9QKZO6e6yDTwDbGvZy9Jb/tblQ
         2iLjtCNJSXiQlol01V1831wmVwfH6iR/EyWZtdSAhbuBAljmfGMdpZkysQKefXR9WSZu
         1077+5Oz+xOU8vIyXHX7pB4AF/trHhmL82YtUoVGOWEOgvctUEPUjpC6gqh8/pGFwfM3
         78hopqDSfYSSlclqtC1MWySL1ReURkOPgjQvSaxHQe44QUSsQ5flDaxpef/BbWJ0c7fK
         uI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781498140; x=1782102940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bom2krBAQT6Qlap90R6BFlutbauj16k/dhPk3OXzZdQ=;
        b=gxIhWb8I56MqianwZ5NtGZNgNtp56n1mnKRhs7r8qp8k+7qZjvLBh64e/RlAGMvxI/
         ADxQR2Cd7Kh6ISoU+Q2qzhyJRQFPLbtqcl7Zz8Uk+O2n4DPWnNmeGcSC+Jh1DYOV6zIU
         JZfblKt0QIhfc0iU4MsfMXJNZA5EPkIAJ/QOcLXZiI9xmuFsNeMDI4Pm0hI/pQfKGw2f
         0vHbIewRCWXq00+Ty2aZ3Eg4PzcKfaPzSxCAa7pdsRV8p7w1GSpDZ8lAuJKbKwZkZknY
         3LbXKQ+A1IN5K+cIWjxJlT5uxfQUmF8Kq+BVnVqcgj2bRaPnwRoodwQsxbq27iuZqgFZ
         2blw==
X-Forwarded-Encrypted: i=1; AFNElJ9m94IrpTxiIUPN8bB56JTqs/hVffmiXjGT+TIsPvdmPzwHwEeLeAFoP7+VD7sgW5tXU+U4W7uG@vger.kernel.org
X-Gm-Message-State: AOJu0YwCEE8f4z5n3/3ScVkZWVgqyB8hX9991qAqKqGNxN5EagTaD9br
	thCmY6VXtA2Ya3grPVzvXN2gc4hmigT5QA9MgdQyWkfIK7DKXlboZIANLoeQym7VJaZrrf6bWRc
	br803KrKY6o7KEPc14zR50opkNfUW7CdrBvaC/jrH
X-Gm-Gg: Acq92OEPN+NB51rDvanOnrXudnTrPMT4h4YriZzc+4N1o5vhcuRrWIATWdhO9wEQQcM
	H4vJislg+7ZAdQukeemhp2F7r4FmnM6xOTkZQ5mHVwzsADRJxDG4QGuguwO7P5S/GAGqO3FSyqK
	w1hsm5Q/O9q+Snti7BFzNc+tPISTYBQYkzaPAq5y3xbtJ6l34Bgu0x9fu8hSXfF+xqU7WabcBEk
	6jJhxAq+j4iyEuzl5eOx7ir8pQoIFJDA+q95MoTcjwKI1AWE8q/rbMIG0DXcTGmJKvo7bDinCYn
	b7Go0w==
X-Received: by 2002:ac8:598a:0:b0:50e:38f0:ccb2 with SMTP id
 d75a77b69052e-51955eb4b1bmr11873931cf.15.1781498139606; Sun, 14 Jun 2026
 21:35:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org> <20260610-slab_alloc_flags-v2-9-7190909db118@kernel.org>
In-Reply-To: <20260610-slab_alloc_flags-v2-9-7190909db118@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 14 Jun 2026 21:35:26 -0700
X-Gm-Features: AVVi8CdSf5bHsSxRYmIPo23FazBd7NlQv_pUkyRlcofBL7XF0ClZnOPI_i_k6A0
Message-ID: <CAJuCfpF0mcV3TUCNi981YO=uT=5p_7OOY1S6zdgwm5PMMV3w8g@mail.gmail.com>
Subject: Re: [PATCH v2 09/16] mm/slab: pass alloc_flags through
 slab_post_alloc_hook() chain
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
	TAGGED_FROM(0.00)[bounces-16931-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 077A16834D3

On Wed, Jun 10, 2026 at 8:41=E2=80=AFAM Vlastimil Babka (SUSE)
<vbabka@kernel.org> wrote:
>
> Convert the whole following call stack to pass either slab_alloc_context
> (thus including alloc_flags) or just alloc_flags as necessary:
>
> slab_post_alloc_hook()
>   alloc_tagging_slab_alloc_hook()
>     __alloc_tagging_slab_alloc_hook()
>       prepare_slab_obj_exts_hook()
>         alloc_slab_obj_exts()
>   memcg_slab_post_alloc_hook()
>     __memcg_slab_post_alloc_hook()
>       alloc_slab_obj_exts()
>
> Converting all these at once avoids unnecessary churn and is mostly
> mechanical.
>
> This ultimately allows to decide if spinning is allowed using
> alloc_flags in alloc_slab_obj_exts(), as well as slab_post_alloc_hook().
> Aside from alloc_from_pcs_bulk() (to be handled next) there is nothing
> else in slab itself relying on gfpflags_allow_spinning() which can
> be false even if not called from kmalloc_nolock().
>
> A followup change will also use the alloc_flags availability in the call
> stack above to remove the __GFP_NO_OBJ_EXT flag.
>
> For alloc_slab_obj_exts(), also replace the suboptimal "bool new_slab"
> parameter with a SLAB_ALLOC_NEW_SLAB flag with identical functionality.
>
> To further reduce the number of parameters of slab_post_alloc_hook(),
> also make 'struct list_lru *lru' (which is NULL for most callers) a new
> field of slab_alloc_context.
>
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---
>  mm/memcontrol.c |  5 +--
>  mm/slab.h       |  6 ++--
>  mm/slub.c       | 94 +++++++++++++++++++++++++++++++++------------------=
------
>  3 files changed, 62 insertions(+), 43 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c03d4787d466..29390ba13baa 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3424,7 +3424,8 @@ static inline size_t obj_full_size(struct kmem_cach=
e *s)
>  }
>
>  bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru =
*lru,
> -                                 gfp_t flags, size_t size, void **p)
> +                                 gfp_t flags, unsigned int slab_alloc_fl=
ags,
> +                                 size_t size, void **p)
>  {
>         size_t obj_size =3D obj_full_size(s);
>         struct obj_cgroup *objcg;
> @@ -3472,7 +3473,7 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache=
 *s, struct list_lru *lru,
>                 slab =3D virt_to_slab(p[i]);
>
>                 if (!slab_obj_exts(slab) &&
> -                   alloc_slab_obj_exts(slab, s, flags, false)) {
> +                   alloc_slab_obj_exts(slab, s, flags, slab_alloc_flags)=
) {
>                         continue;
>                 }
>
> diff --git a/mm/slab.h b/mm/slab.h
> index 96f65b625600..4db6d8aa0ee3 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -19,6 +19,7 @@
>  /* slab's alloc_flags definitions */
>  #define SLAB_ALLOC_DEFAULT     0x00 /* no flags */
>  #define SLAB_ALLOC_TRYLOCK     0x01 /* a kmalloc_nolock() allocation */
> +#define SLAB_ALLOC_NEW_SLAB    0x02 /* a flag for alloc_slab_obj_exts() =
*/
>
>  static inline bool alloc_flags_allow_spinning(const unsigned int alloc_f=
lags)
>  {
> @@ -612,7 +613,7 @@ static inline struct slabobj_ext *slab_obj_ext(struct=
 slab *slab,
>  }
>
>  int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> -                        gfp_t gfp, bool new_slab);
> +                       gfp_t gfp, unsigned int alloc_flags);
>
>  #else /* CONFIG_SLAB_OBJ_EXT */
>
> @@ -642,7 +643,8 @@ static inline enum node_stat_item cache_vmstat_idx(st=
ruct kmem_cache *s)
>
>  #ifdef CONFIG_MEMCG
>  bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru =
*lru,
> -                                 gfp_t flags, size_t size, void **p);
> +                                 gfp_t flags, unsigned int slab_alloc_fl=
ags,
> +                                 size_t size, void **p);
>  void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
>                             void **p, int objects, unsigned long obj_exts=
);
>  #endif
> diff --git a/mm/slub.c b/mm/slub.c
> index 8f6ca3d5fdfa..e634137b67fa 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -218,6 +218,7 @@ struct slab_alloc_context {
>         unsigned long caller_addr;
>         unsigned long orig_size;
>         unsigned int alloc_flags;
> +       struct list_lru *lru;
>  };
>
>  /* Structure holding parameters for get_partial_node_bulk() */
> @@ -2155,9 +2156,9 @@ static inline size_t obj_exts_alloc_size(struct kme=
m_cache *s,
>  }
>
>  int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> -                       gfp_t gfp, bool new_slab)
> +                       gfp_t gfp, unsigned int alloc_flags)
>  {
> -       bool allow_spin =3D gfpflags_allow_spinning(gfp);
> +       const bool allow_spin =3D alloc_flags_allow_spinning(alloc_flags)=
;
>         unsigned int objects =3D objs_per_slab(s, slab);
>         unsigned long new_exts;
>         unsigned long old_exts;
> @@ -2206,7 +2207,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct k=
mem_cache *s,
>         old_exts =3D READ_ONCE(slab->obj_exts);
>         handle_failed_objexts_alloc(old_exts, vec, objects);
>
> -       if (new_slab) {
> +       if (alloc_flags & SLAB_ALLOC_NEW_SLAB) {
>                 /*
>                  * If the slab is brand new and nobody can yet access its
>                  * obj_exts, no synchronization is required and obj_exts =
can
> @@ -2331,7 +2332,7 @@ static inline void init_slab_obj_exts(struct slab *=
slab)
>  }
>
>  static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> -                              gfp_t gfp, bool new_slab)
> +                              gfp_t gfp, unsigned int alloc_flags)
>  {
>         return 0;
>  }
> @@ -2351,10 +2352,10 @@ static inline void alloc_slab_obj_exts_early(stru=
ct kmem_cache *s,
>
>  static inline unsigned long
>  prepare_slab_obj_exts_hook(struct kmem_cache *s, struct slab *slab,
> -                          gfp_t flags, void *p)
> +                          gfp_t flags, unsigned int alloc_flags, void *p=
)
>  {
>         if (!slab_obj_exts(slab) &&
> -           alloc_slab_obj_exts(slab, s, flags, false)) {
> +           alloc_slab_obj_exts(slab, s, flags, alloc_flags)) {
>                 pr_warn_once("%s, %s: Failed to create slab extension vec=
tor!\n",
>                              __func__, s->name);
>                 return 0;
> @@ -2366,7 +2367,8 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, st=
ruct slab *slab,
>
>  /* Should be called only if mem_alloc_profiling_enabled() */
>  static noinline void
> -__alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_=
t flags)
> +__alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_=
t flags,
> +                               unsigned int alloc_flags)
>  {
>         unsigned long obj_exts;
>         struct slabobj_ext *obj_ext;
> @@ -2382,7 +2384,7 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *=
s, void *object, gfp_t flags)
>                 return;
>
>         slab =3D virt_to_slab(object);
> -       obj_exts =3D prepare_slab_obj_exts_hook(s, slab, flags, object);
> +       obj_exts =3D prepare_slab_obj_exts_hook(s, slab, flags, alloc_fla=
gs, object);
>         /*
>          * Currently obj_exts is used only for allocation profiling.
>          * If other users appear then mem_alloc_profiling_enabled()
> @@ -2401,10 +2403,11 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache=
 *s, void *object, gfp_t flags)
>  }
>
>  static inline void
> -alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t =
flags)
> +alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t =
flags,
> +                             unsigned int alloc_flags)
>  {
>         if (mem_alloc_profiling_enabled())
> -               __alloc_tagging_slab_alloc_hook(s, object, flags);
> +               __alloc_tagging_slab_alloc_hook(s, object, flags, alloc_f=
lags);
>  }
>
>  /* Should be called only if mem_alloc_profiling_enabled() */
> @@ -2443,7 +2446,8 @@ alloc_tagging_slab_free_hook(struct kmem_cache *s, =
struct slab *slab, void **p,
>  #else /* CONFIG_MEM_ALLOC_PROFILING */
>
>  static inline void
> -alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t =
flags)
> +alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t =
flags,
> +                             unsigned int alloc_flags)
>  {
>  }
>
> @@ -2461,8 +2465,9 @@ alloc_tagging_slab_free_hook(struct kmem_cache *s, =
struct slab *slab, void **p,
>  static void memcg_alloc_abort_single(struct kmem_cache *s, void *object)=
;
>
>  static __fastpath_inline
> -bool memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *l=
ru,
> -                               gfp_t flags, size_t size, void **p)
> +bool memcg_slab_post_alloc_hook(struct kmem_cache *s, gfp_t flags,
> +                               size_t size, void **p,
> +                               struct slab_alloc_context *ac)
>  {
>         if (likely(!memcg_kmem_online()))
>                 return true;
> @@ -2470,7 +2475,8 @@ bool memcg_slab_post_alloc_hook(struct kmem_cache *=
s, struct list_lru *lru,
>         if (likely(!(flags & __GFP_ACCOUNT) && !(s->flags & SLAB_ACCOUNT)=
))
>                 return true;
>
> -       if (likely(__memcg_slab_post_alloc_hook(s, lru, flags, size, p)))
> +       if (likely(__memcg_slab_post_alloc_hook(s, ac->lru, flags,
> +                                               ac->alloc_flags, size, p)=
))
>                 return true;
>
>         if (likely(size =3D=3D 1)) {
> @@ -2558,14 +2564,15 @@ bool memcg_slab_post_charge(void *p, gfp_t flags)
>                 put_slab_obj_exts(obj_exts);
>         }
>
> -       return __memcg_slab_post_alloc_hook(s, NULL, flags, 1, &p);
> +       return __memcg_slab_post_alloc_hook(s, NULL, flags, SLAB_ALLOC_DE=
FAULT,
> +                                           1, &p);
>  }
>
>  #else /* CONFIG_MEMCG */
>  static inline bool memcg_slab_post_alloc_hook(struct kmem_cache *s,
> -                                             struct list_lru *lru,
> -                                             gfp_t flags, size_t size,
> -                                             void **p)
> +                                             gfp_t flags,
> +                                             size_t size, void **p,
> +                                             struct slab_alloc_context *=
ac)
>  {
>         return true;
>  }
> @@ -3352,12 +3359,14 @@ static inline void init_freelist_randomization(vo=
id) { }
>  #endif /* CONFIG_SLAB_FREELIST_RANDOM */
>
>  static __always_inline void account_slab(struct slab *slab, int order,
> -                                        struct kmem_cache *s, gfp_t gfp)
> +                                        struct kmem_cache *s, gfp_t gfp,
> +                                        unsigned int alloc_flags)
>  {
>         if (memcg_kmem_online() &&
>                         (s->flags & SLAB_ACCOUNT) &&
>                         !slab_obj_exts(slab))
> -               alloc_slab_obj_exts(slab, s, gfp, true);
> +               alloc_slab_obj_exts(slab, s, gfp,
> +                                   alloc_flags | SLAB_ALLOC_NEW_SLAB);
>
>         mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
>                             PAGE_SIZE << order);
> @@ -3434,7 +3443,7 @@ static struct slab *allocate_slab(struct kmem_cache=
 *s, gfp_t flags,
>          * to prevent the array from being overwritten.
>          */
>         alloc_slab_obj_exts_early(s, slab);
> -       account_slab(slab, oo_order(oo), s, flags);
> +       account_slab(slab, oo_order(oo), s, flags, alloc_flags);
>
>         return slab;
>  }
> @@ -4568,9 +4577,8 @@ struct kmem_cache *slab_pre_alloc_hook(struct kmem_=
cache *s, gfp_t flags)
>  }
>
>  static __fastpath_inline
> -bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
> -                         gfp_t flags, size_t size, void **p,
> -                         unsigned int orig_size)
> +bool slab_post_alloc_hook(struct kmem_cache *s, gfp_t flags, size_t size=
,
> +                         void **p, struct slab_alloc_context *ac)

Would if be possible to make this last parameter a ""const struct
slab_alloc_context*" (here and in other functions accepting it)? I
think these functions accept it as an input parameter only and are not
supposed to change it, right? Makes it easy to veriy that
slab_alloc_context is not changed between consequitive calls reusing
it, for example inside slab_alloc_node().

>  {
>         bool init =3D slab_want_init_on_alloc(flags, s);
>         unsigned int zero_size =3D s->object_size;
> @@ -4590,7 +4598,7 @@ bool slab_post_alloc_hook(struct kmem_cache *s, str=
uct list_lru *lru,
>          * orig_size if we track it.
>          */
>         if (slub_debug_orig_size(s))
> -               zero_size =3D orig_size;
> +               zero_size =3D ac->orig_size;
>
>         /*
>          * When slab_debug is enabled, avoid memory initialization integr=
ated
> @@ -4616,14 +4624,14 @@ bool slab_post_alloc_hook(struct kmem_cache *s, s=
truct list_lru *lru,
>                                      !kasan_has_integrated_init())
>                                  && !is_kfence_address(p[i]))
>                         memset(p[i], 0, zero_size);
> -               if (gfpflags_allow_spinning(flags))
> +               if (alloc_flags_allow_spinning(ac->alloc_flags))
>                         kmemleak_alloc_recursive(p[i], s->object_size, 1,
>                                                  s->flags, init_flags);
>                 kmsan_slab_alloc(s, p[i], init_flags);
> -               alloc_tagging_slab_alloc_hook(s, p[i], flags);
> +               alloc_tagging_slab_alloc_hook(s, p[i], flags, ac->alloc_f=
lags);
>         }
>
> -       return memcg_slab_post_alloc_hook(s, lru, flags, size, p);
> +       return memcg_slab_post_alloc_hook(s, flags, size, p, ac);
>  }
>
>  /*
> @@ -4918,6 +4926,12 @@ static __fastpath_inline void *slab_alloc_node(str=
uct kmem_cache *s, struct list
>  {
>         const unsigned int alloc_flags =3D SLAB_ALLOC_DEFAULT;
>         void *object;
> +       struct slab_alloc_context ac =3D {
> +               .caller_addr =3D addr,
> +               .orig_size =3D orig_size,
> +               .alloc_flags =3D alloc_flags,
> +               .lru =3D lru,
> +       };
>
>         s =3D slab_pre_alloc_hook(s, gfpflags);
>         if (unlikely(!s))
> @@ -4929,14 +4943,8 @@ static __fastpath_inline void *slab_alloc_node(str=
uct kmem_cache *s, struct list
>
>         object =3D alloc_from_pcs(s, gfpflags, alloc_flags, node);
>
> -       if (unlikely(!object)) {
> -               struct slab_alloc_context ac =3D {
> -                       .caller_addr =3D addr,
> -                       .orig_size =3D orig_size,
> -                       .alloc_flags =3D alloc_flags,
> -               };
> +       if (!object)

Any reason "unlikely" is removed?

>                 object =3D __slab_alloc_node(s, gfpflags, node, &ac);
> -       }
>
>         maybe_wipe_obj_freeptr(s, object);
>
> @@ -4945,7 +4953,7 @@ static __fastpath_inline void *slab_alloc_node(stru=
ct kmem_cache *s, struct list
>          * In case this fails due to memcg_slab_post_alloc_hook(),
>          * object is set to NULL
>          */
> -       slab_post_alloc_hook(s, lru, gfpflags, 1, &object, orig_size);
> +       slab_post_alloc_hook(s, gfpflags, 1, &object, &ac);
>
>         return object;
>  }
> @@ -5240,6 +5248,10 @@ kmem_cache_alloc_from_sheaf_noprof(struct kmem_cac=
he *s, gfp_t gfp,
>                                    struct slab_sheaf *sheaf)
>  {
>         void *ret =3D NULL;
> +       struct slab_alloc_context ac =3D {
> +               .orig_size =3D s->object_size,
> +               .alloc_flags =3D SLAB_ALLOC_DEFAULT,
> +       };
>
>         if (sheaf->size =3D=3D 0)
>                 goto out;
> @@ -5250,7 +5262,7 @@ kmem_cache_alloc_from_sheaf_noprof(struct kmem_cach=
e *s, gfp_t gfp,
>                 ret =3D sheaf->objects[--sheaf->size];
>
>         /* add __GFP_NOFAIL to force successful memcg charging */
> -       slab_post_alloc_hook(s, NULL, gfp | __GFP_NOFAIL, 1, &ret, s->obj=
ect_size);
> +       slab_post_alloc_hook(s, gfp | __GFP_NOFAIL, 1, &ret, &ac);
>  out:
>         trace_kmem_cache_alloc(_RET_IP_, ret, s, gfp, NUMA_NO_NODE);
>
> @@ -5437,7 +5449,7 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size=
, token), gfp_t gfp_flags, in
>
>  success:
>         maybe_wipe_obj_freeptr(s, ret);
> -       slab_post_alloc_hook(s, NULL, alloc_gfp, 1, &ret, orig_size);
> +       slab_post_alloc_hook(s, alloc_gfp, 1, &ret, &ac);
>
>         ret =3D kasan_kmalloc(s, ret, orig_size, alloc_gfp);
>         return ret;
> @@ -7303,6 +7315,10 @@ bool kmem_cache_alloc_bulk_noprof(struct kmem_cach=
e *s, gfp_t flags,
>  {
>         unsigned int i =3D 0;
>         void *kfence_obj;
> +       struct slab_alloc_context ac =3D {
> +               .orig_size =3D s->object_size,
> +               .alloc_flags =3D SLAB_ALLOC_DEFAULT,
> +       };
>
>         if (!size)
>                 return false;
> @@ -7353,7 +7369,7 @@ bool kmem_cache_alloc_bulk_noprof(struct kmem_cache=
 *s, gfp_t flags,
>
>  out:
>         /* memcg and kmem_cache debug support and memory initialization *=
/
> -       return likely(slab_post_alloc_hook(s, NULL, flags, size, p, s->ob=
ject_size));
> +       return likely(slab_post_alloc_hook(s, flags, size, p, &ac));
>  }
>  EXPORT_SYMBOL(kmem_cache_alloc_bulk_noprof);
>
>
> --
> 2.54.0
>

