Return-Path: <cgroups+bounces-177-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A65E27E13C4
	for <lists+cgroups@lfdr.de>; Sun,  5 Nov 2023 14:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8751C20985
	for <lists+cgroups@lfdr.de>; Sun,  5 Nov 2023 13:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30FACA41;
	Sun,  5 Nov 2023 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfNCRnoI"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1270617E9;
	Sun,  5 Nov 2023 13:51:07 +0000 (UTC)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84818CF;
	Sun,  5 Nov 2023 05:51:06 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-66d122e0c85so23521196d6.3;
        Sun, 05 Nov 2023 05:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699192265; x=1699797065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6/SlWm7axAxg9ZQNzBZyojMAHL0SVLzNpVyeJWY+qE=;
        b=bfNCRnoIzGAxpk55jApLG99FSMe8APPw7Y0bcuY7I25yfro8Oue45JXzVeRhi1RDrz
         Nq1BbY+3p4qMZvpKMYT9LB2Bbum95PgJPovW9dP8OSmcyeltgInEFfqilTho73lFk+Pr
         phHjAO6+gf70kjtb8zRNwWbM1WczUPGmRSpCbVqmIQS2WIywKvRwZ0YCK3y5ovRqBL9A
         7rlezFyt0RrZLqXZU7Yd0ETmxrT3Y3cQQ7Q5qzQ4fHwrFUNtc8bZ0k0GBjaz/5Cv1IUw
         pZIlY6D6U75Sml7atjfvLYZT6/THYyS938gfUBOLxOwWvv2n81rmv6anspssp//bQcOc
         XsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699192265; x=1699797065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6/SlWm7axAxg9ZQNzBZyojMAHL0SVLzNpVyeJWY+qE=;
        b=gA0EG4V6dDB3RVEjBUF4QPIDUIpjCQ0XlYBEp05nbNnZoPvpTDoHdiMeAM5cpVQPmb
         Odtdq6LZxhaKcA5PXtUTy+h5SJtGQoF7ixRVrGqw9I+CzYJMe7SB4q8es136TM0Fq0ye
         SUTr/09lnr/ibwqKuoiVPbyTgKTI/ZNV/smxTrPM+BEZn/PleEwJdE9351tUqr7p15j9
         8FPZVRsac+BUpOsud+xcDHpcAVByD5omsdxD3WU0UgJNLEKAXHdVjfK/qn686zb2oJcm
         aofmg86RJmi283KJ3IGZu37rkKayAAgd6S1k9J4kVWbRSukGuhwVsCtbAdIlTEkXBok8
         8DzQ==
X-Gm-Message-State: AOJu0YxmYtLxrFf/8lRgsvi9z4iW2mpiEtwpdbiLfk9jdz7RfNe0Bnv7
	kxxxM8lKzQleYJ3NKNCYAGj+LC/AGeRprqLkBeE=
X-Google-Smtp-Source: AGHT+IGNTz8xTtuXar5imrbM03au8p+fNcpA6jZPPcfNF8nKvBDi2FzQE8h3JhjoNWdYA54OLAo5n2bgxxVxFdil8tY=
X-Received: by 2002:ad4:5ca9:0:b0:658:23a5:e062 with SMTP id
 q9-20020ad45ca9000000b0065823a5e062mr36024400qvh.31.1699192265578; Sun, 05
 Nov 2023 05:51:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202311031651.A7crZEur-lkp@intel.com> <20231105062227.4190-1-laoar.shao@gmail.com>
 <4f5a8c67-74be-41a1-8a0c-acac40da8902@app.fastmail.com> <CALOAHbCt4-kDGoW=4R0EarPNV2yNcwy3exkVrn6Tz5Ng8M8gvg@mail.gmail.com>
 <d178b5b5-4171-4e76-a486-c20d5f081448@app.fastmail.com>
In-Reply-To: <d178b5b5-4171-4e76-a486-c20d5f081448@app.fastmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 5 Nov 2023 21:50:29 +0800
Message-ID: <CALOAHbDHBbcgg-p4cN7czcLsAx7-aB4pAX6jGUo6TmetH+RhcA@mail.gmail.com>
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

On Sun, Nov 5, 2023 at 9:01=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sun, Nov 5, 2023, at 12:54, Yafang Shao wrote:
> > On Sun, Nov 5, 2023 at 4:24=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wr=
ote:
> >> On Sun, Nov 5, 2023, at 07:22, Yafang Shao wrote:
> >> > To address this, we should also suppress the "-Wmissing-prototypes" =
warning
> >> > for older GCC versions. Since "#pragma GCC diagnostic push" is suppo=
rted as
> >> > of GCC 4.6, it is acceptable to ignore these warnings for GCC >=3D 5=
.1.0.
> >>
> >> Not sure why these need to be suppressed like this at all,
> >> can't you just add the prototype somewhere?
> >
> > BPF kfuncs are intended for use within BPF programs, and they should
> > not be called from other parts of the kernel. Consequently, it is not
> > appropriate to include their prototypes in a kernel header file.
>
> How does the caller in the BPF program get the prototype?

BPF programs will get the prototype directly from BTF, for example,
see also the prototypes declared using "__ksym"  in
tools/testing/selftests/bpf/progs/ for examples.

>
> >> > @@ -131,14 +131,14 @@
> >> >  #define __diag_str(s)                __diag_str1(s)
> >> >  #define __diag(s)            _Pragma(__diag_str(GCC diagnostic s))
> >> >
> >> > -#if GCC_VERSION >=3D 80000
> >> > -#define __diag_GCC_8(s)              __diag(s)
> >> > +#if GCC_VERSION >=3D 50100
> >> > +#define __diag_GCC_5(s)              __diag(s)
> >> >  #else
> >> > -#define __diag_GCC_8(s)
> >> > +#define __diag_GCC_5(s)
> >> >  #endif
> >> >
> >>
> >> This breaks all uses of __diag_ignore that specify
> >> version 8 directly. Just add the macros for each version
> >> from 5 to 14 here.
> >
> > It seems that __diag_GCC_8() or __diag_GCC() are not directly used
> > anywhere in the kernel, right?
>
> I see three instances:
>
> drivers/net/ethernet/renesas/sh_eth.c:__diag_ignore(GCC, 8, "-Woverride-i=
nit",
> include/linux/compat.h:     __diag_ignore(GCC, 8, "-Wattribute-alias",   =
                           include/linux/syscalls.h:   __diag_ignore(GCC, 8=
, "-Wattribute-alias",

Thanks for pointing them out.

>
> The override-init one should probably use version 5 as well,
> but I think the -Wattribute-alias ones require GCC 8 and otherwise
> cause a warning about an unknown warning option.

Right. -Wattribute-alias requires GCC 8.

>
> __diag_ignore_all() would also be wrong for the override-init
> because the option has a different name in clang
> (-Winitializer-overrides).
>
> > Therefore it won't break anything if we just replace __diag_GCC_8()
> > with __diag_GCC_5().
> > It may be cumbersome to add the macrocs for every GCC version if they
> > aren't actively used.
>
> For the _all variant, I would prefer to completely remove
> the version logic and just use __diag() directly. I think the
> entire point of this is that it is used on all supported
> versions.

Good suggestion.
will do it.

--=20
Regards
Yafang

