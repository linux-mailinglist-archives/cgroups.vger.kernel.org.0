Return-Path: <cgroups+bounces-175-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6557E133C
	for <lists+cgroups@lfdr.de>; Sun,  5 Nov 2023 12:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98EE21C2099E
	for <lists+cgroups@lfdr.de>; Sun,  5 Nov 2023 11:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE53CBA22;
	Sun,  5 Nov 2023 11:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APsUK/Em"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E114AD55;
	Sun,  5 Nov 2023 11:55:18 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700E890;
	Sun,  5 Nov 2023 03:55:15 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-67089696545so22807076d6.0;
        Sun, 05 Nov 2023 03:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699185314; x=1699790114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9FgC82VB9DuohSkiRg/tKOnJgJe/c9z30+wZ2VpWJA=;
        b=APsUK/Em4z3++yzqTYpuYHxC6MhF8tq90loFdgE5mA/Yxrrb9ZhGC+FctnOQF6n6sY
         yVJLz02/t/onOoiMIYxovRBkNSnVrZK64wO5zvY8IaTpSuk32PRAEsfGbNcHQ0NMo7yw
         mii1Xm9oqr7GIX9oR4V8YD9l4bBhG/eelAXdRbnse/GUTS4CE2rjR+Wvs2MRYfojafpV
         EXHIGnx6WXkC3Tp7dFfhX6/M8EGotAE58ThDTEYOK2ykrZPxM+T4my6xatcifNMH0S7T
         L9e3D59zfetSEr+VYySusDfCjera12g6hh0wbObx+PieqkIJevwGvvbOGsXKYFvd25mS
         k19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699185314; x=1699790114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9FgC82VB9DuohSkiRg/tKOnJgJe/c9z30+wZ2VpWJA=;
        b=kNpr8D2Hmf+PhomNqpTad/+gLnULdnDPWr1H13RhmIcnVhlzlRAm+QC5sQ6gUeJgQ6
         3uE25NW4Ies4DVfRgEA/0/H264JsFA3aikeYBwrTs1sOIz4vdbuSGj0QACg90p9qzF8p
         sEUHDd+LgyhDWhXK4mTue7oZ1Szfz2jWu+20bTBFqD2BI7iM3/9bUo5reaeRWlF5rKEl
         gY135hxnvCcADgm25Oun64XjN3+u7vuFqn/Y8ti6rxdzjGBY9syNqUBFjYYhtVoXwX98
         NQA95QoG8Tqdqlnfwb1u8RXvuqHFxM9dSWpr6P65lGxLpk/PfgM+t7T6tXlZ4xRyzO51
         tfVA==
X-Gm-Message-State: AOJu0Yz6Ve9f7Rq4K+s45Jab8AGt1wbfUk1G9B3Bx6fKgMJ+5a/SrTIm
	Rk7Iukz8C5r0+2fntkdDVljZ/pu7c4API1nzEuw=
X-Google-Smtp-Source: AGHT+IGd1lnDxRpp/KbVcQtLGmzSqHZ68PFrwbXEnpEbYEqxmKxJQ1ZDaypxQDXXvE7RVZqLQgHlIpwzuKSxSJ3URBQ=
X-Received: by 2002:ad4:5bc4:0:b0:671:567d:b134 with SMTP id
 t4-20020ad45bc4000000b00671567db134mr24775335qvt.56.1699185314493; Sun, 05
 Nov 2023 03:55:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202311031651.A7crZEur-lkp@intel.com> <20231105062227.4190-1-laoar.shao@gmail.com>
 <4f5a8c67-74be-41a1-8a0c-acac40da8902@app.fastmail.com>
In-Reply-To: <4f5a8c67-74be-41a1-8a0c-acac40da8902@app.fastmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 5 Nov 2023 19:54:38 +0800
Message-ID: <CALOAHbCt4-kDGoW=4R0EarPNV2yNcwy3exkVrn6Tz5Ng8M8gvg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] compiler-gcc: Ignore -Wmissing-prototypes
 warning for older GCC
To: Arnd Bergmann <arnd@arndb.de>
Cc: kernel test robot <lkp@intel.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, cgroups@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Johannes Weiner <hannes@cmpxchg.org>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, lizefan.x@bytedance.com, 
	Waiman Long <longman@redhat.com>, Martin KaFai Lau <martin.lau@linux.dev>, mkoutny@suse.com, 
	oe-kbuild-all@lists.linux.dev, kernel test robot <oliver.sang@intel.com>, 
	Stanislav Fomichev <sdf@google.com>, sinquersw@gmail.com, Song Liu <song@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, yosryahmed@google.com, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 5, 2023 at 4:24=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sun, Nov 5, 2023, at 07:22, Yafang Shao wrote:
> > The kernel supports a minimum GCC version of 5.1.0 for building. Howeve=
r,
> > the "__diag_ignore_all" directive only suppresses the
> > "-Wmissing-prototypes" warning for GCC versions >=3D 8.0.0. As a result=
, when
> > building the kernel with older GCC versions, warnings may be triggered.=
 The
> > example below illustrates the warnings reported by the kernel test robo=
t
> > using GCC 7.5.0:
> >
> >   compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> >   All warnings (new ones prefixed by >>):
> >
> >    kernel/bpf/helpers.c:1893:19: warning: no previous prototype for
> > 'bpf_obj_new_impl' [-Wmissing-prototypes]
> >     __bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void
> > *meta__ign)
> >                       ^~~~~~~~~~~~~~~~
> >    kernel/bpf/helpers.c:1907:19: warning: no previous prototype for
> > 'bpf_percpu_obj_new_impl' [-Wmissing-prototypes]
> >     __bpf_kfunc void *bpf_percpu_obj_new_impl(u64 local_type_id__k,
> > void *meta__ign)
> >    [...]
> >
> > To address this, we should also suppress the "-Wmissing-prototypes" war=
ning
> > for older GCC versions. Since "#pragma GCC diagnostic push" is supporte=
d as
> > of GCC 4.6, it is acceptable to ignore these warnings for GCC >=3D 5.1.=
0.
>
> Not sure why these need to be suppressed like this at all,
> can't you just add the prototype somewhere?

BPF kfuncs are intended for use within BPF programs, and they should
not be called from other parts of the kernel. Consequently, it is not
appropriate to include their prototypes in a kernel header file.

>
> > @@ -131,14 +131,14 @@
> >  #define __diag_str(s)                __diag_str1(s)
> >  #define __diag(s)            _Pragma(__diag_str(GCC diagnostic s))
> >
> > -#if GCC_VERSION >=3D 80000
> > -#define __diag_GCC_8(s)              __diag(s)
> > +#if GCC_VERSION >=3D 50100
> > +#define __diag_GCC_5(s)              __diag(s)
> >  #else
> > -#define __diag_GCC_8(s)
> > +#define __diag_GCC_5(s)
> >  #endif
> >
>
> This breaks all uses of __diag_ignore that specify
> version 8 directly. Just add the macros for each version
> from 5 to 14 here.

It seems that __diag_GCC_8() or __diag_GCC() are not directly used
anywhere in the kernel, right?
Therefore it won't break anything if we just replace __diag_GCC_8()
with __diag_GCC_5().
It may be cumbersome to add the macrocs for every GCC version if they
aren't actively used.

--
Regards
Yafang

