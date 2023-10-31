Return-Path: <cgroups+bounces-134-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A9A7DC495
	for <lists+cgroups@lfdr.de>; Tue, 31 Oct 2023 03:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668EC1C20BB8
	for <lists+cgroups@lfdr.de>; Tue, 31 Oct 2023 02:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5C1EC6;
	Tue, 31 Oct 2023 02:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqz2zrjT"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0329120EE;
	Tue, 31 Oct 2023 02:40:43 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83392B7;
	Mon, 30 Oct 2023 19:40:42 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-41b406523fcso37881331cf.2;
        Mon, 30 Oct 2023 19:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698720041; x=1699324841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYex50A7FBcXD2meAWg35ACHejXfOv2CiBqw/CUBfCw=;
        b=kqz2zrjTXZTQkHLbW3k+lnb6SLrmcK5eU5sxErmL79Dp2xNdgQ44P5jOTvuUWA0iat
         NPqKx8ErYtXPjURerCukzoQ2dVwKZPebH9/rcqzUfH2hDChr9tc/vcV4EvaA91DnoVpg
         HyNidjZXxGULyelYTBuMk5jZ0zh92MfnHeIuHEbCh4czgj8IFXf3Q+/sfmBJgCZwaYO3
         qjr8QF+KcDdp6UDMwlck2BepS9N8VVi0EEnN80AKyPtLzZy+AqSVd0QVd8tU9fQXVPsm
         c0PtKq5fohJr42JOw0ySK7MluePJtOICLB8wXrvXnwZOqoID0eUi9GqYHvlLxxNaq4yu
         PL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698720041; x=1699324841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYex50A7FBcXD2meAWg35ACHejXfOv2CiBqw/CUBfCw=;
        b=R3Bqv4xohKvecnhMBKt2RkFfUhu5KXn5eluXR/e3aEWHD0Clts0Z1pvEH1WcmbIIK+
         VOmG1//LNn0F/OEohW9syyUM/JqeIrRlJ8z/UgmZGro7PrNndDVVweFYTtsjJ3oAyNHD
         FE2+fSDMUzQC76w8qlgKygXpvh5s+1/UZEzIbRI/8orW0l+lbEv5MawXw2nswo9yGk3i
         g/Gsfq5dvHngWvXMVDNO5eeNReCQqtsYaginifeOL0pSvVFdFKzv2wgbTknZHPoSVcvV
         7FN8gvzprx4aKyzyGG2lEN6mFi85ca7xO6ztpQK/1PGlNV/NIi/D9xvjCSLWFumUMZaD
         hd9A==
X-Gm-Message-State: AOJu0YyQKpPpUeyTaLDo0MIZM4mmzJJ6XLl9Ty+y6m96f0GLnOYmezbS
	g4u8eG6OXI01RRTldbZl1JHjti0gfXT/6bs775E=
X-Google-Smtp-Source: AGHT+IE2iAHSfKIv7UqntN/E861eJeyO2EeR843zIKzsKoCqz0ZB6BpASojNCuvtwuCBzy48YyDD+Y1jbXQuKCsiGo4=
X-Received: by 2002:ad4:5f0f:0:b0:66f:bc0c:a9e5 with SMTP id
 fo15-20020ad45f0f000000b0066fbc0ca9e5mr13479014qvb.25.1698720041193; Mon, 30
 Oct 2023 19:40:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231029061438.4215-7-laoar.shao@gmail.com> <202310301605.CGFI0aSW-lkp@intel.com>
 <CALOAHbA51eCYFsfaUVBxRrfKt=z1=77bPO1CPKEyGeph5PztOQ@mail.gmail.com> <ZT+2qCc/aXep0/Lf@krava>
In-Reply-To: <ZT+2qCc/aXep0/Lf@krava>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 31 Oct 2023 10:40:03 +0800
Message-ID: <CALOAHbAFqH1xBVh55yq7Wj+RaSUKKxw9WWQa6FhO1FZw-S1RUQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 06/11] bpf: Add a new kfunc for cgroup1 hierarchy
To: Jiri Olsa <olsajiri@gmail.com>, David Vernet <void@manifault.com>
Cc: Dave Marchevsky <davemarchevsky@fb.com>, kernel test robot <lkp@intel.com>, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, tj@kernel.org, 
	lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com, 
	mkoutny@suse.com, sinquersw@gmail.com, longman@redhat.com, 
	oe-kbuild-all@lists.linux.dev, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
	oliver.sang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 9:59=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Oct 30, 2023 at 07:35:25PM +0800, Yafang Shao wrote:
> > On Mon, Oct 30, 2023 at 5:01=E2=80=AFPM kernel test robot <lkp@intel.co=
m> wrote:
> > >
> > > Hi Yafang,
> > >
> > > kernel test robot noticed the following build warnings:
> > >
> > > [auto build test WARNING on bpf-next/master]
> > >
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/cg=
roup-Remove-unnecessary-list_empty/20231029-143457
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.=
git master
> > > patch link:    https://lore.kernel.org/r/20231029061438.4215-7-laoar.=
shao%40gmail.com
> > > patch subject: [PATCH v3 bpf-next 06/11] bpf: Add a new kfunc for cgr=
oup1 hierarchy
> > > config: i386-randconfig-013-20231030 (https://download.01.org/0day-ci=
/archive/20231030/202310301605.CGFI0aSW-lkp@intel.com/config)
> > > compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> > > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/a=
rchive/20231030/202310301605.CGFI0aSW-lkp@intel.com/reproduce)
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202310301605.CGFI0aSW=
-lkp@intel.com/
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > >    kernel/bpf/helpers.c:1893:19: warning: no previous declaration for=
 'bpf_obj_new_impl' [-Wmissing-declarations]
> >
> > -Wmissing-declarations is a known issue and somebody is working on it, =
right?
>
> there's this post [1] from Dave, but seems it never landed
>
> jirka
>
> [1] https://lore.kernel.org/bpf/20230816150634.1162838-1-void@manifault.c=
om/

Thanks for your information.

David, I'd appreciate it if you could share an update on its current status

--=20
Regards
Yafang

