Return-Path: <cgroups+bounces-1069-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C74823AA9
	for <lists+cgroups@lfdr.de>; Thu,  4 Jan 2024 03:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BF281C24A87
	for <lists+cgroups@lfdr.de>; Thu,  4 Jan 2024 02:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0671FC1;
	Thu,  4 Jan 2024 02:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MN0hFII9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996F54C6F;
	Thu,  4 Jan 2024 02:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-680d2ec3459so492916d6.0;
        Wed, 03 Jan 2024 18:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704335457; x=1704940257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaX0io2OQun/Pp4EgdPG087ieZrRGz8lcO07PFjXakw=;
        b=MN0hFII9o0sBCTZ4Gl4LjzIwtW+nL+J8z3M3Upz7HT12z7PF38H8P778z+tPymMgv6
         pAIksk6/GkOI6DtNhw/kxP00zo6A4VXTwxY5i+yco0MrSjo8yeF6YsiF3qerD0YFapQH
         q+/PzDP9gl3FVMDU0VI3OjJzKhxsvEvxdLkhY++l54H0iJYIVYad2PfE3w1BQBKugO/Q
         /2bZJrR8PUIjE02q8axKFRBebBgd5eK1LwVjxyxA2BhVrfx8dp9SWlz+s2dVkBIYcI+0
         NXCivTZSWfRJhNl1AqHT3f7/hfOoPgGnRIQORdJPwcXEV58wSGlDpjYo4OrdkWWhGrLs
         XaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704335457; x=1704940257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zaX0io2OQun/Pp4EgdPG087ieZrRGz8lcO07PFjXakw=;
        b=AzX8A2FhdwpjNaxuy3C+1CUepQFP7k94aG26mfq/Iqg349vyFIBjB/H/zuIOR6Pkm0
         WQd8ddjSnUqeHw2QlP0I+AcZTYpXs4r7EvR7q+e20ya+caU9lyNwoi9eU7/Bo/NaWxoT
         Q+SGDo+9ACyHJM90ebPTeI+tr9L96+KS4OVOJath05eA6HQqdVgMFTwmrdOgAxZxcyH8
         4HrI8tAUuvBHOuqcocUdXQ4XojVAUHk9p7ddBM92bI5hbQIN3iC0V4sUyEAwPc5MFftK
         EmJ/eaJ5uPwyRp8bYcAeX6mMZTWlyKRPigvsUxE66AIE9wWgLA3FZrWFqujrqiVaFkxN
         asUA==
X-Gm-Message-State: AOJu0YwFkdiyFUnbrFyZPS8kePBTpJnh4F5ncC5CpdIS1fGRLYHeyq2k
	DuliiN78vzQ4lKtVh0vbaJEMRKyufgIdcF8be4Q=
X-Google-Smtp-Source: AGHT+IFuINDAv9mtDrWMP1tbzBMpslXmW8kaV0qcemoLgyF1ECbqaSPBkq0J0+mLj05/6f7Qwdq7yuoxULFlSvynzKw=
X-Received: by 2002:a05:6214:2b90:b0:680:d21c:c87b with SMTP id
 kr16-20020a0562142b9000b00680d21cc87bmr2362202qvb.8.1704335457476; Wed, 03
 Jan 2024 18:30:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222113102.4148-1-laoar.shao@gmail.com> <20231222113102.4148-3-laoar.shao@gmail.com>
 <CAEf4BzbvPFYx3JpUaKnpG=HaNheQkJbUfaTd=DW0GbYi4A-A7A@mail.gmail.com>
In-Reply-To: <CAEf4BzbvPFYx3JpUaKnpG=HaNheQkJbUfaTd=DW0GbYi4A-A7A@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 4 Jan 2024 10:30:21 +0800
Message-ID: <CALOAHbCU57P54Ocx=PH-afu26K5pJK6cPvSyF9KStWcFe+Ov7Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Add bpf_iter_cpumask kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, tj@kernel.org, lizefan.x@bytedance.com, 
	hannes@cmpxchg.org, bpf@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 6:13=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Dec 22, 2023 at 3:31=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > Add three new kfuncs for bpf_iter_cpumask.
> > - bpf_iter_cpumask_new
> > - bpf_iter_cpumask_next
> > - bpf_iter_cpumask_destroy
> >
> > These new kfuncs facilitate the iteration of percpu data, such as
> > runqueues, psi_cgroup_cpu, and more.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  kernel/bpf/cpumask.c | 48 ++++++++++++++++++++++++++++++++++++++++++++=
++++
> >  1 file changed, 48 insertions(+)
> >
> > diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
> > index 2e73533..4ae07a4 100644
> > --- a/kernel/bpf/cpumask.c
> > +++ b/kernel/bpf/cpumask.c
> > @@ -422,6 +422,51 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cp=
umask *cpumask)
> >         return cpumask_weight(cpumask);
> >  }
> >
> > +struct bpf_iter_cpumask {
> > +       __u64 __opaque[2];
> > +} __aligned(8);
> > +
> > +struct bpf_iter_cpumask_kern {
> > +       struct cpumask *mask;
> > +       int *cpu;
> > +} __aligned(8);
> > +
> > +__bpf_kfunc u32 bpf_iter_cpumask_new(struct bpf_iter_cpumask *it, stru=
ct cpumask *mask)
> > +{
> > +       struct bpf_iter_cpumask_kern *kit =3D (void *)it;
> > +
> > +       kit->cpu =3D bpf_mem_alloc(&bpf_global_ma, sizeof(*kit->cpu));
>
> why dynamic memory allocation of 4 bytes?... just have `int cpu;`
> field in bpf_iter_cpumask_kern?

Will do it. Thanks for your suggestion.

--=20
Regards
Yafang

