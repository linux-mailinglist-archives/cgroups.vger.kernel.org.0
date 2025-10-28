Return-Path: <cgroups+bounces-11286-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97013C16171
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 18:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD291881C08
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 17:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5831345CB1;
	Tue, 28 Oct 2025 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lflIthSq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331DA3491FC
	for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671597; cv=none; b=IouSuI46YA2f4Jg9XvRxOr2WzY43+7+PAq81nX33zyiilTMxzQHdNqlEcrZurCVFlKGN7HnC/v6hOl1zLgmueUtQ1XBANP8gwNGbq69BJ6RaEXLKhrXDQj+f/zo2IAXYMXda55XHTIggBSHIzNOhfeiNC1yl+GV3XKlZesFqQCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671597; c=relaxed/simple;
	bh=LmoN/2Lb9XP/SiTAkIUVaIFPO2+kSTqE3sLIkvS7l1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TGd3hhwtrtEvQMjmNGhCRhqCAvS3dCOZpGAoJ64ZCKVXGGgnTkHYlOFxVKHZDCUUpuxlBtikC61vlReV7ODrA2V0+7NKzTfkk+iqhV84ZZNpY0Kl0cv7yeyL9QtkiAg8VJTL7ffBKeRWWlvCzpiJGPcf7W//QwkhPTAjANMevSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lflIthSq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-475db4ad7e4so16778815e9.3
        for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 10:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761671593; x=1762276393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIJa6yW1wPduR4RBE7Uk88NTTDYku8mns/k2aKumBjg=;
        b=lflIthSqxuCLIEx+QHqiB11Kk1u9lb/fHdJ3TVUHU1zdPafIwivglAGxPqS5s2j4+A
         g5ooaAFTBAEC4qsmXhRY4Xwbt6RW6dpIcOTBB8UAKmlsOpyhUGDxSVZZPtAkxtzxXtir
         rE0lAfpl2MUrxA0DzEzNoxqPG38Wl0NTXgwPNrIba00VYk61pu30Xky5WDxOYMAYcokH
         IklNAoCm69CTvJ4PZjDKt42R/tgcN97pLQcVfv7qOaNXcDIixBL2HIJ7aP6zq+M+RcRJ
         IkV/MWy/V6pKPY67zza+Rb5MDDFKKz+mFN1l+rHR6stx7+iX+Vf0hRlA1Ol8R6xaOQwX
         KfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761671593; x=1762276393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIJa6yW1wPduR4RBE7Uk88NTTDYku8mns/k2aKumBjg=;
        b=Ati7nTJQM6doAe53WRJeFT+BA5n58U7g7YnqT1HV54FU0aHFg6cfLj1EaLRAwSJ4RG
         Q64SIWDw4Nva2jolV5jHDNoy7ZVDcGqwcJb8iD9lqZmKN3Y+/KjddFHCu1W/WbuHzDvi
         MQgTdWRDiuRZJbea52PAqTPzS+xtQBI7izo/xs75R6Alf3cJ8rA79nL9n2KkJMx5k1dv
         tNzE0dVrG+S7zY2z5dM3S4d3ZsuS7/rv2P+F4RJtXKFu+eGEdgk8d+tWevGerzJ1ilZs
         49KFOdpg/nkKQpHVoOxnHlcB7LpvG/KeMJp4DA6+Haxp60W79tHIzIK3M99Wxk8kdDKd
         gNUg==
X-Forwarded-Encrypted: i=1; AJvYcCV3jNnYwTHAGscbgJJCKFUvWM2V8hRdsIIuCLdsStZGZj2q2NRVCin7AMgR9pn5I0/DPwLV9y2b@vger.kernel.org
X-Gm-Message-State: AOJu0Yw72t19WKvvFLEjB43iNuLbruY+/pIhn3YAV4pFCCvbnBcGOHzp
	gcFt5eW3Wu0X9+FQhj/3fDoOrKMrq9fqbWdZpyVnU2FlINwCEJA9D74mmg3XzLyMXkBMgShTuR/
	TVX9TtpCrPbsU8tzyON0bvbkLwLxc5LM=
X-Gm-Gg: ASbGncvfqjUhnAg1vreGjb4Ot3lpzt1jErHGX1eHhULf630PiQqJn0S+3CRVHZ6Wsov
	01ujxj+jnvlYFU2nMUivt0XDvl238n+xVdhaoH0AZGdvBAJwREzM6sbVWZV/dkDLtYwGPieOOlD
	hLCVotznv+WWt2sl43iRI3HN5m7KRzNHjUF3gUcOXnpI00R9/BNxO1AUEMOfDX7E/glFFYKyFsK
	YKfh+2Oq3BSjWUFEgoZKKA4SRiTxqcBrYNAMuHD5JNTv7jHItNWJND/HbcJbB2FhoJTWrGVNeR5
X-Google-Smtp-Source: AGHT+IFP3tNBApkgdl3FcTzbs5OTt0/UxHdByUlbNMa7M18QIw/9VxiLJBuO5yL98zcmhZv7CtkpzCaqV05ZKsJfr2g=
X-Received: by 2002:a05:600c:198f:b0:46e:32dd:1b1a with SMTP id
 5b1f17b1804b1-4771e165903mr2438615e9.7.1761671592922; Tue, 28 Oct 2025
 10:13:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-9-roman.gushchin@linux.dev>
 <2c91977fcab04be6305bf4be57e825f7e84005d16667adcdfad0585be506537c@mail.kernel.org>
 <87ldkv57nc.fsf@linux.dev>
In-Reply-To: <87ldkv57nc.fsf@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 28 Oct 2025 10:12:59 -0700
X-Gm-Features: AWmQ_bkyeYs1B4vFl1Z_bGgU5JQLQ4pVv-Ayp-pwPQhhznGsEdhTH5wiCYvJjLE
Message-ID: <CAADnVQLkza5_95qc0vGYBLUu-4FN_cZEcVywTs5XemTE9O-ZtQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/23] mm: introduce BPF kfuncs to deal with memcg pointers
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bot+bpf-ci@kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, inwardvessel <inwardvessel@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Song Liu <song@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 9:11=E2=80=AFAM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> bot+bpf-ci@kernel.org writes:
>
> > ```
> > commit ec8e2e1769704b4f69261f36e6aaf035d47c5f0f
> > Author: Roman Gushchin <roman.gushchin@linux.dev>
> >
> > mm: introduce BPF kfuncs to deal with memcg pointers
> >
> > This commit introduces two new BPF kfuncs for converting css pointers
> > to memcg pointers with proper reference counting: bpf_get_mem_cgroup()
> > and bpf_put_mem_cgroup().
> >
> >> diff --git a/mm/Makefile b/mm/Makefile
> >> index 051e88c69..2d8f9beb3 100644
> >> --- a/mm/Makefile
> >> +++ b/mm/Makefile
> >> @@ -107,6 +107,7 @@ obj-$(CONFIG_MEMCG) +=3D swap_cgroup.o
> >>  endif
> >>  ifdef CONFIG_BPF_SYSCALL
> >>  obj-y +=3D bpf_oom.o
> >> +obj-$(CONFIG_MEMCG) +=3D bpf_memcontrol.o
> >>  endif
> >>  obj-$(CONFIG_CGROUP_HUGETLB) +=3D hugetlb_cgroup.o
> >>  obj-$(CONFIG_GUP_TEST) +=3D gup_test.o
> >> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> >> new file mode 100644
> >> index 000000000..1e4609774
> >> --- /dev/null
> >> +++ b/mm/bpf_memcontrol.c
> >> @@ -0,0 +1,88 @@
> >> +// SPDX-License-Identifier: GPL-2.0-or-later
> >> +/*
> >> + * Memory Controller-related BPF kfuncs and auxiliary code
> >> + *
> >> + * Author: Roman Gushchin <roman.gushchin@linux.dev>
> >> + */
> >> +
> >> +#include <linux/memcontrol.h>
> >> +#include <linux/bpf.h>
> >> +
> >> +__bpf_kfunc_start_defs();
> >> +
> >> +/**
> >> + * bpf_get_mem_cgroup - Get a reference to a memory cgroup
> >> + * @css: pointer to the css structure
> >> + *
> >> + * Returns a pointer to a mem_cgroup structure after bumping
> >> + * the corresponding css's reference counter.
> >> + *
> >> + * It's fine to pass a css which belongs to any cgroup controller,
> >> + * e.g. unified hierarchy's main css.
> >> + *
> >> + * Implements KF_ACQUIRE semantics.
> >> + */
> >> +__bpf_kfunc struct mem_cgroup *
> >> +bpf_get_mem_cgroup(struct cgroup_subsys_state *css)
> >> +{
> >> +    struct mem_cgroup *memcg =3D NULL;
> >> +    bool rcu_unlock =3D false;
> >> +
> >> +    if (!root_mem_cgroup)
> >> +            return NULL;
> >> +
> >> +    if (root_mem_cgroup->css.ss !=3D css->ss) {
> >                                             ^^^^^^^
> >
> > Can this dereference a NULL css pointer?  The function checks css for
> > NULL at line 42 with "if (css && css_tryget(css))", which suggests css
> > can be NULL.  If a BPF program calls this function with a NULL css,
> > wouldn't it crash here before reaching that check?
>
> Here css passed as an argument to bpf_get_mem_cgroup() can't be NULL,
> because the BPF verifier guarantees that it's a valid css pointer.
>
> However the result of rcu_dereference_raw(cgroup->subsys[ssid]) can be
> NULL, this is why the "if (css && css_tryget(css))" check is required
> down below.

Yeah. Not sure how feasible it is to teach AI about KF_RCU semantics.

