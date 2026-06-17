Return-Path: <cgroups+bounces-17047-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oAF3AtezMmpF3wUAu9opvQ
	(envelope-from <cgroups+bounces-17047-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 16:48:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 847E569AA84
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 16:48:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="f0io/wIk";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17047-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17047-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15C9230D2C2F
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 14:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739933D8105;
	Wed, 17 Jun 2026 14:48:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09C321A459
	for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 14:48:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707711; cv=pass; b=PEM2RBji3T1XUtOvoa34taMAoGq26lUuz4DByui3kclQFGd854QAPyHwvvJPmviRR/YpJGa0joQAFjM3ylCgLw0+Y5UAMNkHaF8fVKDIJuppMoxc2xArmoUVT/pLsptXEeKLoDDxeOz7VLdz0dnv8GKhu+rhsBGyEUOSJLMbJiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707711; c=relaxed/simple;
	bh=y/GIZuRipV1xA0bKjpP28k4ZVR/VO4ai2RsA6wOxDdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cA509ClZMGJ73JmxtaN+EubEs0iqbiKZkmcbJj5KoCGqYhWv4MKznPS87A/TKPnYz5ZAqZQB5WTnjVugIfE6hBJh3bRxfyPJ5OwjAOQtQg0EvyOMz3HV3UGq5evt/4KjmVVuhStvqXL3Fcmft+iwH+YJcU5X94Ho8b+vIkjhkXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f0io/wIk; arc=pass smtp.client-ip=209.85.160.182
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5177d1ff061so267861cf.1
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 07:48:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781707709; cv=none;
        d=google.com; s=arc-20240605;
        b=OhHrO2M8PMFCyV+ilXSInmV62HxGFM6NhXFYSzlqsvXkTnyXhMdrkxfIE3KjudP0iV
         WqWGc4hVdUp+xxTPsAvlkDoDP3L2LGGlkKKLHQ0SYnsHF299z6LK+baFDPt5potglUss
         D+yx1X/yqY5goRYZAgsMZRYrBLlvRv3KzAMnSsq9u265G3WaYDzTgzt565N0vhkCv0tD
         OclufV15gWHOQNQs1wzdhBDW2pOiGApgQE6TlpycgiCXFS7YxAPU2A9ugsQrQutI5HVH
         43LUGyuYGkwhgql1njdoZRBuPhuSwh2hGZgos7/9YaasP5uWq5ljw3PIXJU8LmXRaFmg
         cFaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XhQaVfAQOt3padp74Km2bFuDFtNkF12cIPOSV2s4BpU=;
        fh=Q8qaXGFP7DEArs/DQQUiRfKe0Szt217//6pNzVlmB6Y=;
        b=N4ubWoPC98leHXjs6iFJyHYX6L8GVXB3SHwEAirrMyv9Sq9oY1GLtTxpgRVBT/3IMw
         QfTriEFclYw0VTKDu1g5GWuLhiEljSCNDWG9+rNK+IR071mM+I0buCn53m6bWZkdlRE1
         Nln4MYx8RiY1k0D0otQyt+cAUE/LpntS2o57s4o20+npLD+RQes1MZbHvSCN+FklsO8/
         +8zerCPjVC6QNuEUNSYBOgzv9+8vdCE3RSf7275bY2DxIV0ZthG8y76M0o3TP5EEi6SZ
         nYgjtIRHq1cNiCpYBZgAsNj+BZPAqF5EizuOhGXJ8KMwTKxLz8OswgR+yO0rDU11w4Xx
         EAKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781707709; x=1782312509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhQaVfAQOt3padp74Km2bFuDFtNkF12cIPOSV2s4BpU=;
        b=f0io/wIkegrRK/C2FkD1d6otn2IwX8RfwCK7PYINSS6ott3rkoM8dqjIdXMGFVyZbE
         wKeWJFKnMpHRkcxMHRYdvJHr+p9Uq/1BWdKYceUiCPgHmsFd9EHvV/bdH99AsMkCCFUk
         pglA3v9Z7TDfFaQuM/ZluoXKrNyPR/em4gOlha+dC0dXKRtk8qI9TiRppBjw5u1+R+1K
         +wvyAiXA2B7IceZYKePlH4vf2dlEMMc5mfI+iY/9mBiyJGgP0UokYMmsFJNvmoMDNBPy
         c6MDsOPrv9U6YRz3acpeHsHapKB+9Gsk6bsZOOuW4/R5KuU4r9aw/vFWA7XyZuz+pzRV
         OR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781707709; x=1782312509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XhQaVfAQOt3padp74Km2bFuDFtNkF12cIPOSV2s4BpU=;
        b=FnP/Qs/FYwkZbKMNJ7fD0euhpqnt+9r+kpYen54GFTgh7g1Hy9f3lHYpcW5ZVJa2bk
         S82mrXp5Jvik1Ewu+CJFYvFNAhd/paFdE0WK2zXvf9TfQLGyVnBE2kU0AVp1qzsBsQ1q
         61WvL64yoy+DbCqWAcRqd0VoO/tY0l5vRD20gsnBNGYmVuVr1eYRZIFcyKpH4oXpsMka
         DkNAQzqAciirPGkrDSisNaOKmNWiuxotL8ZPfM1oiw5M3cQDmfc9i0X+oDLV0izJas8e
         V8L+5fygVT4/hCbQqbqVw43qPhhe9AEb5dJaklC01TROmuHCb+67uP7syisS8rrV+RYi
         KnEA==
X-Forwarded-Encrypted: i=1; AFNElJ/7gqFM2b6XjDXrOVVn9r+PsYWoVQPTOnUHodJArNHqY1pKhylE+/HvoBs9r0o/SvsRhVyVlMCT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9KdJHQoicoZi/wzlJ5K4nlWODX0GgzY0XsvqKyMSKeelumwrN
	xp+niVWIJteR7+/8vZ/VZjb0j8O/gEvUSWY6U6FWXg3PCv3c1pXbHpatKdCPczmgsraKllHNzn7
	qdVZbLGB2kffSvbXMHISQytwtLXOg/lkQrrLcE+1P
X-Gm-Gg: Acq92OGirDgWoy6BYec/dfau+vQ2EStAupKPBuCZvxZc3kJ5q5Nxd9ruFumECPdaykY
	ZCYVKWyry4UwtAuydZF+7zTy/iVkXe6lKctjBfvOpglL3KMSMczwrbi5z5F2SJ1ivbhbcG5yPBt
	weVT8q+rstOth8eSmSlgxoYTeu5mPm2I1ZgIDGqtWom8Mf7MJKJkk/LcJezGmglF4mAPH6n0SCI
	zxx6DdAgFGU3hc1n4eNNv9VLJAm2vRooPZTEUus2Zf00KfLZa9B7pcmEIM14DxbwjiWZkF2R3CL
	0pQBCkhMBNpYtP+tuq+lEgZ19dM=
X-Received: by 2002:a05:622a:2589:b0:517:99ea:ab77 with SMTP id
 d75a77b69052e-519adac7249mr8262361cf.23.1781707708059; Wed, 17 Jun 2026
 07:48:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615-slab_alloc_flags-v3-0-ce1146d140fb@kernel.org>
 <20260615-slab_alloc_flags-v3-8-ce1146d140fb@kernel.org> <e9beb94a-6508-4bd0-b641-41e718990f7b@kernel.org>
In-Reply-To: <e9beb94a-6508-4bd0-b641-41e718990f7b@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 17 Jun 2026 07:48:15 -0700
X-Gm-Features: AVVi8Cfwx7Hy97TQzo9j3Ib9iva_orAIE7OvChCK-GCxierIP-7yyp4HmbiYDGw
Message-ID: <CAJuCfpEMf=n5UL7FCfptLqDm9PiE5b0BSLUfraew4dcpiZv-6A@mail.gmail.com>
Subject: Re: [PATCH v3 08/15] mm/slab: pass alloc_flags through
 slab_post_alloc_hook() chain
To: Harry Yoo <harry@kernel.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Hao Li <hao.li@linux.dev>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:vbabka@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[surenb@google.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-17047-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 847E569AA84

On Tue, Jun 16, 2026 at 12:37=E2=80=AFAM Harry Yoo <harry@kernel.org> wrote=
:
>
>
>
> On 6/15/26 8:54 PM, Vlastimil Babka (SUSE) wrote:
> > Convert the whole following call stack to pass either slab_alloc_contex=
t
> > (thus including alloc_flags) or just alloc_flags as necessary:
> >
> > slab_post_alloc_hook()
> >   alloc_tagging_slab_alloc_hook()
> >     __alloc_tagging_slab_alloc_hook()
> >       prepare_slab_obj_exts_hook()
> >         alloc_slab_obj_exts()
> >   memcg_slab_post_alloc_hook()
> >     __memcg_slab_post_alloc_hook()
> >       alloc_slab_obj_exts()
> >
> > Converting all these at once avoids unnecessary churn and is mostly
> > mechanical.
> >
> > This ultimately allows to decide if spinning is allowed using
> > alloc_flags in alloc_slab_obj_exts(), as well as slab_post_alloc_hook()=
.
> > Aside from alloc_from_pcs_bulk() (to be handled next) there is nothing
> > else in slab itself relying on gfpflags_allow_spinning() which can
> > be false even if not called from kmalloc_nolock().
> >
> > A followup change will also use the alloc_flags availability in the cal=
l
> > stack above to remove the __GFP_NO_OBJ_EXT flag.
> >
> > For alloc_slab_obj_exts(), also replace the suboptimal "bool new_slab"
> > parameter with a SLAB_ALLOC_NEW_SLAB flag with identical functionality.
> >
> > To further reduce the number of parameters of slab_post_alloc_hook(),
> > also make 'struct list_lru *lru' (which is NULL for most callers) a new
> > field of slab_alloc_context.
> >
> > Link: https://patch.msgid.link/20260610-slab_alloc_flags-v2-9-7190909db=
118@kernel.org
> > Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> > ---
>
> Looks good to me,
> Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


>
> --
> Cheers,
> Harry / Hyeonggon

