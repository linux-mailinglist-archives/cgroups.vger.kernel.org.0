Return-Path: <cgroups+bounces-16922-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wydsA0xYL2rF+gQAu9opvQ
	(envelope-from <cgroups+bounces-16922-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 03:41:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3B8682C70
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 03:41:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=TE2zMI3W;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16922-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16922-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 352113004F63
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 01:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9CC225403;
	Mon, 15 Jun 2026 01:41:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58FD1F4C96
	for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 01:41:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781487682; cv=pass; b=YQzCZMhuUmFcxX18W4ogs5iWFsXanb/+ErA8xSKkte55DkzA/lMWyC44WMicCzms2yprnGFvzTBAewNv5rgvyU/llp5S3KJwHvBoY3oMdSuc1FKya1WD5FgaDT/nZBpnv1NXwu/LsYDTMIPOvzcjchOacpuFD4v2LCFGoZGERME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781487682; c=relaxed/simple;
	bh=Oq6M/QJ1/mLGp2H4+TWTFwrixKOZESsascUFFTzl1kQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hWFs95KhEltj1BOlskbbGpJ7n1RbgKwlHtRfqnsB3chs9zGz0lK39pmc9ZqWKq4JoxbNkcR7EEgm5UGCdLNgCwsuHUR/08XerpByItRAfx6YdA0uVAnKqdM2fOLPk9O62AjpyrUFQJ1amnVvzBB+tO3r8qyrMXMmd5Rx+Acmy5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TE2zMI3W; arc=pass smtp.client-ip=209.85.160.177
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5175d339e8bso763861cf.0
        for <cgroups@vger.kernel.org>; Sun, 14 Jun 2026 18:41:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781487680; cv=none;
        d=google.com; s=arc-20240605;
        b=jNTzahYfdVT+yXFwldhosHVUS3qTf5d/OiQFnYMIiX81i04F3FmHt7d6UJtFYfjVhj
         E2xWAGGdbLAt/TA95foV6+l6OjALVfAt0GA+1DwR3EAcM1E3TkrEezE3sVmHblQh/ivf
         pS7dbzSV2koSalXvXEnpMrubi1Xev5PKU78dq+IgEXLLNEX0TSYwVlIuW1iFj0C4g/k4
         V7AGvF73z3eT3GqPttd66SWOF70rWvuZvB5Th+7dhxtqFw07SbCJTIrzMOD+zH+6prMc
         nDDRMSqMB9C7YgHUousdz2cHNnaVzORZF+zd/yi8r0J3Yx+AQIP/Xm59ImgTcOj0N/9M
         pJNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Oba1y/fwWge1CAjHu+ViThvQtCh/uetPo3IoC3QoR4s=;
        fh=nL72vEG6Nhjz/Mi4XwQi4908D5Q1umW/n/bgGFQ6Iz4=;
        b=Vttrq/8ghvwF4mV3YCO9L5795EqkuDmKBsqKKaTHNyZgUCx6brB/sPP6Fk+l96ZnmW
         xPhpqwQsbI05jfk/O2MvC7hWGqmyfDlu5Vzdwx1crusHoK9Lpapt9I/mkQg6fwTflblW
         FO6ungZo9DAI70VPgj3mwjj2rnnUo5Hk5yOSbgTCIH1CmpjPA4NlHR6uPaUefzzPsknF
         KLkc5aiC+RJw1Qc8A0OywYY1p/qyLkmFTN/tZan5zwdoma+6+xe2Jc8GKkXfBc4vfLBu
         32EIc/U/vFcvJsOc6Ubzd5XRO+dPqb3aNUAk8tbxx6f94myu6j3ba9UMuVDYnMP6EMNe
         ka1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781487680; x=1782092480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oba1y/fwWge1CAjHu+ViThvQtCh/uetPo3IoC3QoR4s=;
        b=TE2zMI3WBwIhoD2eMyJ93UhcM2RiwZZpWldqI8h83BM/ZYhLomr++YuTEvKxazdM+U
         u29lgwftelYWk0s1MvgB4si4cFNyO135VAuStGVjMUG/foKK/PAkbpsVdnh2rKgNeKyk
         vEFSn75Ui8HJhEMGoo1ivQC664SwTkUlyFaxpcnLq21uAwHywb28YJ3zy5zYjQcsJy74
         2nwCS9y05GNi2+EjApR0Yn0AC7GKSetbUrh/0WWyvqYAMA6wV6JaygI9YekHEU/IC6wg
         PINC0QggziE6kXws66efRZd/a9cL0rSsQdCC4wGwdKv+39EEqZw1eM971i4pfIj/4eWR
         lrxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781487680; x=1782092480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oba1y/fwWge1CAjHu+ViThvQtCh/uetPo3IoC3QoR4s=;
        b=lKTppMZLBrKiZNJzjLB4N0l5itvDmD2TNzEL5ydrRdpr0PGh05npG5p1PcVo0H9axF
         QE+gMNAZ3xqOVQ7gm2aYOXEXTWRGwMH33yfpfX99OQYOrli8H1agssngIm/M34+wXMH1
         0PnQKCPhull1reokswAUk+W0EDjwWqz7bnJmr5XQFCmx0fipRQKBxyr0t9Aq2M0jAvbT
         +tzflrE7hoL6GRuMArgKgRuuHDG3emhaEj+pJxRQHQYM10aa6ZSwnDIWfAtvxmMO5s6n
         /7RCsopN5QxkOyMmRadNNrN50Gng5qXmByAG9O/GIURWj05Y3jvPPiLnZ88/wXI8eHG0
         YlaA==
X-Forwarded-Encrypted: i=1; AFNElJ/5uADpMUYka07IC/FRIj3REJPe5Gveyxdksc0PFC1SmDHWOYf7D+tDeGabo+jlE0cG4nNO2rUZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm9lebXza9xyfZ2SkM20Hsev0WfGhrrccu914E5V1pLclFFeHu
	5Rx6DtV8xzZTx+e2xASr+ETwIebGy4qTUodCXmHFKpsKnMG9SNlWhKUz81d0jX0ADmqZNsk1g+c
	RqC2kXK6v3ruIrEJIO1w6KRI/SChHWCdWhU5HjAZd
X-Gm-Gg: Acq92OEwKlV/EmPgM9QbM9IeO+0AFrAX52nYPAvNPkHe2ajtrTwcFlDRydfLLkHTn2E
	0PScuyw89OZSteeraL/w4SdH5fzVdLLdmHOZfryDTlLPGQ7CuOj0PMd4nfSZFXZxkEBevcGnKiW
	ruz9npy/aVmLvjSiJcxNT82UjAxUwP7UTFvetog7bt+kmdD0jLZ1AgOKyDYWjXVMaGSH9hLOcoU
	OBpp7LF1DPLkfWeujFTCRjHRlftPSgdebWhBvs6wryibITGPAvjnwMtFPjCsT6FBV4PP/eZXv3Q
	ufywPw==
X-Received: by 2002:a05:622a:a06:b0:4f3:5475:6b10 with SMTP id
 d75a77b69052e-519549c5dc0mr13818591cf.8.1781487679161; Sun, 14 Jun 2026
 18:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-4-7190909db118@kernel.org> <ait21B7kqfT9XhOs@fedora>
 <3914c31f-c97e-4943-9f4f-630b05785014@kernel.org>
In-Reply-To: <3914c31f-c97e-4943-9f4f-630b05785014@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 14 Jun 2026 18:41:07 -0700
X-Gm-Features: AVVi8CfTaoMTbApaagpN1JA0gtF2Zr84PB2r_GpXkAamhbBg2Y1SCtUHhyR3a4M
Message-ID: <CAJuCfpE4Xxn73CaUqHF21RpqoS2N_3R37JKQgeHVV5A9omSW1g@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] mm/slab: introduce slab_alloc_context
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Hao Li <hao.li@linux.dev>, Harry Yoo <harry@kernel.org>, 
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
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:hao.li@linux.dev,m:harry@kernel.org,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[surenb@google.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-16922-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D3B8682C70

On Fri, Jun 12, 2026 at 2:51=E2=80=AFAM Vlastimil Babka (SUSE)
<vbabka@kernel.org> wrote:
>
> On 6/12/26 05:10, Hao Li wrote:
> > On Wed, Jun 10, 2026 at 05:40:06PM +0200, Vlastimil Babka (SUSE) wrote:
> >> @@ -5389,13 +5401,18 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS=
(size, token), gfp_t gfp_flags, in
> >>      if (ret)
> >>              goto success;
> >>
> >> +    struct slab_alloc_context ac =3D {
> >> +            .caller_addr =3D _RET_IP_,
> >> +            .orig_size =3D orig_size,
> >> +    };
> >
> > It might be better to move this to the beginning of the function, to av=
oid
> > patch09 jump to `success` before ac is initialized.
>
> Hm right, didn't compilers actually complain about goto skipping over
> declarations? But neither gcc nor clang do for me, hm. Will move, thanks.

I see it's moved in
https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=3Dsl=
ab/for-next,
so

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> >> +
> >>      /*
> >>       * Do not call slab_alloc_node(), since trylock mode isn't
> >>       * compatible with slab_pre_alloc_hook/should_failslab and
> >>       * kfence_alloc. Hence call __slab_alloc_node() (at most twice)
> >>       * and slab_post_alloc_hook() directly.
> >>       */
> >> -    ret =3D __slab_alloc_node(s, alloc_gfp, node, _RET_IP_, orig_size=
);
> >> +    ret =3D __slab_alloc_node(s, alloc_gfp, node, &ac);
> >>
> >>      /*
> >>       * It's possible we failed due to trylock as we preempted someone=
 with
> >> @@ -7237,10 +7254,13 @@ static bool __kmem_cache_alloc_bulk(struct kme=
m_cache *s, gfp_t flags,
> >>      int i;
> >>
> >>      if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
> >> +            struct slab_alloc_context ac =3D {
> >> +                    .caller_addr =3D _RET_IP_,
> >> +                    .orig_size =3D s->object_size,
> >> +            };
> >>              for (i =3D 0; i < size; i++) {
> >>
> >> -                    p[i] =3D ___slab_alloc(s, flags, NUMA_NO_NODE, _R=
ET_IP_,
> >> -                                         s->object_size);
> >> +                    p[i] =3D ___slab_alloc(s, flags, NUMA_NO_NODE, &a=
c);
> >>                      if (unlikely(!p[i]))
> >>                              goto error;
> >>
> >>
> >> --
> >> 2.54.0
> >>
>

