Return-Path: <cgroups+bounces-16934-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k/cYGnmGL2qFBwUAu9opvQ
	(envelope-from <cgroups+bounces-16934-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 06:58:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 710E56835AA
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 06:58:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=WkwnxmIf;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16934-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16934-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A29103002B47
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 04:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2118305698;
	Mon, 15 Jun 2026 04:58:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5386627A462
	for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 04:58:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781499508; cv=pass; b=nmNv6pohhKLeULK18KcHQZmQbiAuwnR0mJStYZ3yjQGcXIDaRwU/8WSSyGgDkYrPD9EMsNkWAoBzVF8nhqJ8+VWl/maLxN9IIHLzEGm6tgSGw/gFNRM2AAWdLVVxiDpYupZ7aBC8vbQWasX5LY9xYFzbSojpVr3KDgF7rCMzZTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781499508; c=relaxed/simple;
	bh=M9T86kAZw+Xcti2goIF4O29CshmQ+JkLZvC2czwBOfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fcN8Hwdq2nNOoxMXuUitmK9/TfNABOWjB3RdcxGu/j3CefeQm5zmKUjYF70uyHGOKGpr6u0Lx740giKoP2gAB46kx7bMNcoMtUJvtAUswMTRJpDQkaaZ+tSLzlYyj6mkBu1KKFGL8gaVQoDuK75u1BOe+46wMh/VmVCSxMsXo28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WkwnxmIf; arc=pass smtp.client-ip=209.85.160.173
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51765331535so761601cf.1
        for <cgroups@vger.kernel.org>; Sun, 14 Jun 2026 21:58:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781499505; cv=none;
        d=google.com; s=arc-20240605;
        b=TWKcKlhO9s446bnqdlF/RVNwkYyhaShMMg6+zA86lLqPPpql6PsSnPR17Iom4SL4gd
         JaDqN9Wo36vmnPErAkzSWZJh4DifecK65rFVYneJSzgIS4emFozJL8xRTezufRQq0sol
         buUsk3sYPLVmm7HJVPWoHb2gq+0VFOT368TlvNt4rDvyoEWDtjUycrNMSLztSLDLF1v8
         AAmdV2iErb08FPWuRfEkHQCLJWftIFup5MAXfEOFnypntfP1vT0BXZigucclVaO2c3gm
         q1Th3/TfxMtWJVh6IQcgZdllReCTM78jb0HiV7WL2FfIFnkPQxqMaMCdT8LvXGiMLQ1m
         pj/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zZMSnIuAEoqNdnHgvV7SmrbMOmKklwpldD7yQBXnGp4=;
        fh=7ml+gB28RI8hGcKWsRGil7wcySQyBV53kWlYvKQM4Ok=;
        b=MSZKwwyIM7NdnZIGa5sS5VMLCzei/IHgXziPmdsU+oA83bxo/n0DtAV7MOOXWTguth
         IyKHR3llMWFGVvDrcRwR1uVQZHR2LYG/lr4YzCMGTuX0BPqFvIseg3DJdOWJT9xWrb4E
         VxlKIs7ELhYr/f7txvEeGNIbg8IxTadwgU1GRbNqJey9BRmesd4DQGCPfRsyCYkWQPQe
         qbfItlgj9i+arKeelmv9CpAr8NW9Zb+iTIDSIFrVRoG4C8AVNiPpGXi2drh0CVFoZV3b
         yeYl/4Y8Ae9mlTokZhvB31E9b3L6hweUPnoFjwC/4Lx9WVKolNfMrmUMoogEeR6i8HaM
         UswA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781499505; x=1782104305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZMSnIuAEoqNdnHgvV7SmrbMOmKklwpldD7yQBXnGp4=;
        b=WkwnxmIfIdUiaOLQ2nNA59wsUe04xWNvAXVcUN9r9IYTXgsV/keePJpi/aMSbmgwBo
         sYGzFURbtDNQuZlgfYrGMUB1eCM0aanarjiEjWs5NKjR78zMRYSQAUWihr5QoX0Ekz+f
         BF039XV7I7WJyQuAZ6C1rpi9dyBi6nhCTGYTm6og0ZqeL5iSCXsG4sIk6bh/zj6OYKY5
         Zo4HgFw/Q99r8T10eQCRji7+KUXX7W/jWGElhjfp6mFIyeXC4kZuukQilil9jw8gGyck
         FuxsOzUnPY9YVdF99OUQjezAWdcTQnx0RXsRZRV/S/yObKGuCRZNixxnTE9f+10U3e+m
         oBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781499505; x=1782104305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zZMSnIuAEoqNdnHgvV7SmrbMOmKklwpldD7yQBXnGp4=;
        b=RKlAFBIIspwiOMWu28qpmqY++uZlJU2ix0pXiLOs1tR7QOgFDXc20jr75m891onUpy
         N4M8fpKqI+DeWactUJNg+xX62jsz2z6B1Qs3A85ufa1b/ZYaH4ZpEylpA2+49T0k6ipf
         vrrtT9KrD1adnWLb3ZBGH8r2p2ldvD2L66lq3Z+2E3kt0NManX2940YIUArfk4rfmkAi
         mvkH1wD6zTgS18l+8ONeoJybgx+aVWJgebWJD99zTnCONkrGbjwuc3YCyVz9bd0hJM5O
         JqhKTqnIuao6Mzi2qM8NZ7wr6EQhQOJG/Lttc61ppgA+IDPfJVUK+DozrPbDU325rkls
         0shg==
X-Forwarded-Encrypted: i=1; AFNElJ8ikpIqR/jk8IvV9ZZX60Oe7fZ2uqg414LIXMvJx4zQEIDkzKPgYz3WOjC0Og8JSgjgGdddfJM7@vger.kernel.org
X-Gm-Message-State: AOJu0Yze5QFr5TPsBluI699Gv0+PVBejwJNu/HlwhbhYZD5t6smutk3w
	z7wA60VzRJbb1C4mtVmQDARAjUBnIutqvI2crwq4NM292FVa6X59OkuOhPwkLH5MSsdTaH9JTcS
	UrnLwGweFP+IUdrKoM6YwraTf84VlQ66fW6CJ6JqU
X-Gm-Gg: Acq92OH6dZ1XYqJk9/G0QOdd4WA1kLp/7gIr2Zn6Comb5wTWQAYUCW/zYWV7zR+JlPT
	QuWtl43bjX9ebgZNnuKkazz1boQKj2GRfcy6OvIwqCeYZzKdYfrBuPLYnKcljCiNUT4VPwcW1Iv
	HEBuAGUH1835MdySx9YnaUIh6OVZQ5ts7IRrWhyMH/q9JyLRXQV2HOmVVq7x00FAfVpiIR0agVD
	bwB4xgxqGTRLyqRKnJpszNNygCjbkKgiPAQDdP4zLh/xWFJdsC4YP9u+niy5gsTu71vY24Q5JT8
	ozt8Kw==
X-Received: by 2002:a05:622a:1195:b0:517:99ea:ab7d with SMTP id
 d75a77b69052e-51955ec344bmr12452951cf.23.1781499504513; Sun, 14 Jun 2026
 21:58:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org> <20260610-slab_alloc_flags-v2-12-7190909db118@kernel.org>
In-Reply-To: <20260610-slab_alloc_flags-v2-12-7190909db118@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 14 Jun 2026 21:58:12 -0700
X-Gm-Features: AVVi8CezM2Z8h-1vndfvlUnEXMPBWx1_QWpDaN8TO9wK0rWQ--byif7hloIBM0k
Message-ID: <CAJuCfpHOXkZFq8UKiSqXzG-RBFNw5gO-JR0bBCn9uRc3Oc5ZbA@mail.gmail.com>
Subject: Re: [PATCH v2 12/16] mm/slab: pass slab_alloc_context to __do_kmalloc_node()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:harry@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[surenb@google.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-16934-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 710E56835AA

On Wed, Jun 10, 2026 at 8:41=E2=80=AFAM Vlastimil Babka (SUSE)
<vbabka@kernel.org> wrote:
>
> With alloc_flags usage in slab, we can replace __GFP_NO_OBJ_EXT with an
> alloc flag that prevents kmalloc recursion. For that we need a version
> of kmalloc() that takes alloc_flags and use it in places that perform
> these potentially recursive kmalloc allocations (of sheaves or obj_ext
> arrays).
>
> As a preparatory step, make __do_kmalloc_node() take a pointer to
> slab_alloc_context. This replaces the 'caller' parameter and includes
> alloc_flags which we'll make use of.

I think you could also eliminate __do_kmalloc_node() function's "size"
parameter as it's always the same as ac->orig_size.

>
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---
>  mm/slub.c | 47 ++++++++++++++++++++++++++++++++---------------
>  1 file changed, 32 insertions(+), 15 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index ef457e07db83..6845e15c148a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5338,19 +5338,14 @@ EXPORT_SYMBOL(__kmalloc_large_node_noprof);
>
>  static __always_inline
>  void *__do_kmalloc_node(size_t size, kmem_buckets *b, gfp_t flags, int n=
ode,
> -                       unsigned long caller, kmalloc_token_t token)
> +                       kmalloc_token_t token, struct slab_alloc_context =
*ac)
>  {
>         struct kmem_cache *s;
>         void *ret;
> -       struct slab_alloc_context ac =3D {
> -               .caller_addr =3D caller,
> -               .orig_size =3D size,
> -               .alloc_flags =3D SLAB_ALLOC_DEFAULT,
> -       };
>
>         if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
>                 ret =3D __kmalloc_large_node_noprof(size, flags, node);
> -               trace_kmalloc(caller, ret, size,
> +               trace_kmalloc(ac->caller_addr, ret, size,
>                               PAGE_SIZE << get_order(size), flags, node);
>                 return ret;
>         }
> @@ -5360,22 +5355,34 @@ void *__do_kmalloc_node(size_t size, kmem_buckets=
 *b, gfp_t flags, int node,
>
>         s =3D kmalloc_slab(size, b, flags, token);
>
> -       ret =3D slab_alloc_node(s, flags, node, &ac);
> +       ret =3D slab_alloc_node(s, flags, node, ac);
>         ret =3D kasan_kmalloc(s, ret, size, flags);
> -       trace_kmalloc(caller, ret, size, s->size, flags, node);
> +       trace_kmalloc(ac->caller_addr, ret, size, s->size, flags, node);
>         return ret;
>  }
>  void *__kmalloc_node_noprof(DECL_KMALLOC_PARAMS(size, b, token), gfp_t f=
lags, int node)
>  {
> +       struct slab_alloc_context ac =3D {
> +               .caller_addr =3D _RET_IP_,
> +               .orig_size =3D size,
> +               .alloc_flags =3D SLAB_ALLOC_DEFAULT,
> +       };
> +
>         return __do_kmalloc_node(size, PASS_BUCKET_PARAM(b), flags, node,
> -                                _RET_IP_, PASS_TOKEN_PARAM(token));
> +                                PASS_TOKEN_PARAM(token), &ac);
>  }
>  EXPORT_SYMBOL(__kmalloc_node_noprof);
>
>  void *__kmalloc_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t flags)
>  {
> -       return __do_kmalloc_node(size, NULL, flags,  NUMA_NO_NODE, _RET_I=
P_,
> -                                PASS_TOKEN_PARAM(token));
> +       struct slab_alloc_context ac =3D {
> +               .caller_addr =3D _RET_IP_,
> +               .orig_size =3D size,
> +               .alloc_flags =3D SLAB_ALLOC_DEFAULT,
> +       };
> +
> +       return __do_kmalloc_node(size, NULL, flags,  NUMA_NO_NODE,
> +                                PASS_TOKEN_PARAM(token), &ac);
>  }
>  EXPORT_SYMBOL(__kmalloc_noprof);
>
> @@ -5471,9 +5478,14 @@ EXPORT_SYMBOL_GPL(_kmalloc_nolock_noprof);
>  void *__kmalloc_node_track_caller_noprof(DECL_KMALLOC_PARAMS(size, b, to=
ken), gfp_t flags,
>                                          int node, unsigned long caller)
>  {
> -       return __do_kmalloc_node(size, PASS_BUCKET_PARAM(b), flags, node,
> -                                caller, PASS_TOKEN_PARAM(token));
> +       struct slab_alloc_context ac =3D {
> +               .caller_addr =3D caller,
> +               .orig_size =3D size,
> +               .alloc_flags =3D SLAB_ALLOC_DEFAULT,
> +       };
>
> +       return __do_kmalloc_node(size, PASS_BUCKET_PARAM(b), flags, node,
> +                                PASS_TOKEN_PARAM(token), &ac);
>  }
>  EXPORT_SYMBOL(__kmalloc_node_track_caller_noprof);
>
> @@ -6874,6 +6886,11 @@ void *__kvmalloc_node_noprof(DECL_KMALLOC_PARAMS(s=
ize, b, token), unsigned long
>  {
>         bool allow_block;
>         void *ret;
> +       struct slab_alloc_context ac =3D {
> +               .caller_addr =3D _RET_IP_,
> +               .orig_size =3D size,
> +               .alloc_flags =3D SLAB_ALLOC_DEFAULT,
> +       };
>
>         /*
>          * It doesn't really make sense to fallback to vmalloc for sub pa=
ge
> @@ -6881,7 +6898,7 @@ void *__kvmalloc_node_noprof(DECL_KMALLOC_PARAMS(si=
ze, b, token), unsigned long
>          */
>         ret =3D __do_kmalloc_node(size, PASS_BUCKET_PARAM(b),
>                                 kmalloc_gfp_adjust(flags, size),
> -                               node, _RET_IP_, PASS_TOKEN_PARAM(token));
> +                               node, PASS_TOKEN_PARAM(token), &ac);
>         if (ret || size <=3D PAGE_SIZE)
>                 return ret;
>
>
> --
> 2.54.0
>

