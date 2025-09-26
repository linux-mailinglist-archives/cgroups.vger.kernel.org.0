Return-Path: <cgroups+bounces-10469-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D6ABA469C
	for <lists+cgroups@lfdr.de>; Fri, 26 Sep 2025 17:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5B03B3DD4
	for <lists+cgroups@lfdr.de>; Fri, 26 Sep 2025 15:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54E22D05D;
	Fri, 26 Sep 2025 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7j7hfNv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F0A1D7E4A
	for <cgroups@vger.kernel.org>; Fri, 26 Sep 2025 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758900643; cv=none; b=XKqXgaPV0HUA9l9l9QLpHGDW/vwL/qiiZjvZDXGb4ZoOz8j249ujvm2ZTMFlLvjwA4Cjjgq+kpO2Kz6zi0ClWQlvVhEES8WMvx7fYQ1SQKeu5GItEGw1QdZWb537lTMhURXhM1aY7eBOczEDN9xxcQ0A7CxfHr/DFK4Zq0PuDsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758900643; c=relaxed/simple;
	bh=AS45b9EbyToJk2Diz4z80PWCjaqcT0Ws7VVscCNXRkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zg2K4p7rWQ/chuX3iVOpkfUbk+9+6C7TZAS7yarmgCKMQNZKMWegc0p9g0HwOlsrULv4oTFIINPkBoFfA5shGCxDRLcehIAiHwTbrPFu0AbnqiZTyJe8xFmyhV6IQytLB2MDTl6ZYrQaxdES9ayR/gX5z++BFG0NOxYmcyJ6UOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7j7hfNv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e3ea0445fso4201955e9.1
        for <cgroups@vger.kernel.org>; Fri, 26 Sep 2025 08:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758900640; x=1759505440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hw0PkEDAgZJmZX4JQxCB6B2llrhkqMZatxLmc7xYfO8=;
        b=R7j7hfNv0axO9GoeYBEVskzdYe9V2UIUlkiWNXur11Svj4CNEC6R/QmLQwR0OaJPMZ
         Nc2mlKXdp5yWSbnWiW44MTQdPHFRkq89WxWIeSgp/CtQgK9Fy4wsF43pCfJkGFNLeeuY
         exDaS1DtjktPfailzKvs8n4lz0lFA+v2D4eSQAddRrn0JNW68Vv61NA5IkQYIf8P8nxy
         2q8ZDJFVP1ASs21ucvTKIbN++8ixGOMYrY61DM9ReiG1wrz4MKby/2VUnKbCdDgNX88U
         tgpWSSOFdhM3GrGQpUua/C7n+pCmdKNxMQToQnj+/l///XHIM0cTI4+PFQVZbhZgapV/
         WkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758900640; x=1759505440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hw0PkEDAgZJmZX4JQxCB6B2llrhkqMZatxLmc7xYfO8=;
        b=tZmd5y2BMxxv0mh48gEuzaGkXoZArB0lrxEkT+pS9SPbPcKEFImV5OweBW66IvDrIZ
         OgW5XNTtSkF/5ZEl+wURBIL8WJWYiPiDB8wWYH57PR/EG8SINXYsnEJUoNFJH20SQd4/
         do/joM2pC3Zoi6u99Vd1YaFV22KNoZzlQn2VBofdmUabWb3b52x8ETg1qotBHRh/Zs4q
         7woKK5fjTRvdGHtSdClqCMmNli/jNsOMaH+KVApN+qAZU1Upn7gbxw2Jl8x008+oQIXK
         2JYuhvfCDJp1jprC9xPUbe8n77sIpSyoOnPuYNKdIHbTd1QBrmuYeRNUZx0JHpi/cVGx
         zt/w==
X-Forwarded-Encrypted: i=1; AJvYcCVjMwwA9ifoPbstM0nbg9hXi+9rfomv62adQ75aodVj3jx+stPYebawK+UbW+oh4/uuGKOoov8+@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv+k12w2RF16tV/aml6Z4GM3eZRkfNmhGqifK4TrMJ9WhCZigw
	wHaMK3VwHXWcGasNJYnkydKgRKoKvviVy5g7jFCoLAsAcssuO6SZg/5G5+PT/siK2IAtyTVeEGI
	8QvkBr2mKm7+gH9owHb7phI0HbSyKMho=
X-Gm-Gg: ASbGnctQK8iDVgN+jVMaRq4ATcYKRaengzDrnthH8ZQrBC/PLM/13wbGeNPGU6n/h4v
	k0wAwBNy9Rwgt73DL0ssVJ2/laf50Rs63Xg4OMy+JGbxd4z8mAyyZBOO6eR3/qgLijn5mqDOY+5
	TypzpFhJ2KPp6uJWD5bv5+1WDAPngF0jBhnKPd5IKhLi7LWj/W+cD1JXwwOf5Iq5M+ue+dmWD/L
	awOIdlqQD1iw87zNczr
X-Google-Smtp-Source: AGHT+IHPcobe0pabmtv3LTAUxvYUa9I/tUExRRvv4KQMIFR1FB2bTWAabu9dOrWdANVnlud2d72ux6aywV+LbMiMy+I=
X-Received: by 2002:a05:600c:1553:b0:46e:39e4:1721 with SMTP id
 5b1f17b1804b1-46e39e41ae1mr38372785e9.12.1758900639846; Fri, 26 Sep 2025
 08:30:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202509171214.912d5ac-lkp@intel.com> <b7d4cf85-5c81-41e0-9b22-baa9a7e5a0c4@suse.cz>
 <ead41e07-c476-4769-aeb6-5a9950737b98@suse.cz> <CAADnVQJYn9=GBZifobKzME-bJgrvbn=OtQJLbU+9xoyO69L8OA@mail.gmail.com>
 <ce3be467-4ff3-4165-a024-d6a3ed33ad0e@suse.cz> <CAJuCfpGLhJtO02V-Y+qmvzOqO2tH5+u7EzrCOA1K-57vPXhb+g@mail.gmail.com>
 <CAADnVQLPq=puz04wNCnUeSUeF2s1SwTUoQvzMWsHCVhjFcyBeg@mail.gmail.com>
 <CAJuCfpGA_YKuzHu0TM718LFHr92PyyKdD27yJVbtvfF=ZzNOfQ@mail.gmail.com>
 <CAADnVQKt5YVKiVHmoB7fZsuMuD=1+bMYvCNcO0+P3+5rq9JXVw@mail.gmail.com> <7a3406c6-93da-42ee-a215-96ac0213fd4a@suse.cz>
In-Reply-To: <7a3406c6-93da-42ee-a215-96ac0213fd4a@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 26 Sep 2025 16:30:28 +0100
X-Gm-Features: AS18NWDPulJjeGNZJBavOvdAFs79dpLiwntGES88AId5C9cShcZs5_ox3eb1K2Y
Message-ID: <CAADnVQKrLbOxav0+H5LsESa_d_c8yBGfPdRDJzkz6yjeQf9WdA@mail.gmail.com>
Subject: Re: [linux-next:master] [slab] db93cdd664: BUG:kernel_NULL_pointer_dereference,address
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, kernel test robot <oliver.sang@intel.com>, 
	Alexei Starovoitov <ast@kernel.org>, Harry Yoo <harry.yoo@oracle.com>, oe-lkp@lists.linux.dev, 
	kbuild test robot <lkp@intel.com>, kasan-dev <kasan-dev@googlegroups.com>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 1:25=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 9/19/25 20:31, Alexei Starovoitov wrote:
> > On Fri, Sep 19, 2025 at 8:01=E2=80=AFAM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> >>
> >> >
> >> > I would not. I think adding 'boot or not' logic to these two
> >> > will muddy the waters and will make the whole slab/page_alloc/memcg
> >> > logic and dependencies between them much harder to follow.
> >> > I'd either add a comment to alloc_slab_obj_exts() explaining
> >> > what may happen or add 'boot or not' check only there.
> >> > imo this is a niche, rare and special.
> >>
> >> Ok, comment it is then.
> >> Will you be sending a new version or Vlastimil will be including that
> >> in his fixup?
> >
> > Whichever way. I can, but so far Vlastimil phrasing of comments
> > were much better than mine :) So I think he can fold what he prefers.
>
> I'm adding this. Hopefully we'll be able to make sheaves the only percpu
> caching layer in SLUB in the (near) future, and then requirement for
> cmpxchg16b for allocations will be gone.
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 9f1054f0b9ca..f9f7f3942074 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2089,6 +2089,13 @@ int alloc_slab_obj_exts(struct slab *slab, struct =
kmem_cache *s,
>         gfp &=3D ~OBJCGS_CLEAR_MASK;
>         /* Prevent recursive extension vector allocation */
>         gfp |=3D __GFP_NO_OBJ_EXT;
> +
> +       /*
> +        * Note that allow_spin may be false during early boot and its
> +        * restricted GFP_BOOT_MASK. Due to kmalloc_nolock() only support=
ing
> +        * architectures with cmpxchg16b, early obj_exts will be missing =
for
> +        * very early allocations on those.
> +        */

lgtm. Maybe add a sentence about future sheaves plan, so it's clear
that there is a path forward and above won't stay forever.

