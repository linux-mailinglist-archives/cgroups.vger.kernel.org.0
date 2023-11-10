Return-Path: <cgroups+bounces-314-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 311D37E79D9
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 08:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C8B2816C2
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 07:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392AD6FCF;
	Fri, 10 Nov 2023 07:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nT7U2WSn"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FB97475;
	Fri, 10 Nov 2023 07:48:45 +0000 (UTC)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510B686B5;
	Thu,  9 Nov 2023 23:48:44 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77784edc2edso111737385a.1;
        Thu, 09 Nov 2023 23:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699602523; x=1700207323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBs5XjzxU2sBS4BsqeDFs9m90FmLyMBVXgRR9cjPdGc=;
        b=nT7U2WSn2tzru0Wc5UyyOr0s3ff/5xnVDxhTNFDpYvNgZIJ7teX8NFVF01RoXZ/e7P
         6zMJHr5oVBmpZ+7WZ5rdgrSaTVTSGhuOE9TU5tM+DColzu7+AZ23Y1npUGRnUkYJUYT+
         Z7alvFKg4NtKtZuhk3d6GWKeMqpZU4fy7lQZ07aHJsLsnp8MIFUjB+g3299VpGo7phpI
         jqXfPlSiz/mvPNhmrp8Y2jFreN7T2NLbqRTvPuGMb5mN0+fnVRPBewSt0TtdqbW5VZQE
         o7kMv0vsxB5hvoXl+24oRA5FweB4n9cjjur4jj88TLhnQuEGBh22mB0LKLfu1pAGNfFG
         Hmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699602523; x=1700207323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBs5XjzxU2sBS4BsqeDFs9m90FmLyMBVXgRR9cjPdGc=;
        b=bfbUtbtIoS1caAnyTI1t8rsIiuQlViv/cFayVuzWDiBnudybSs8MFBY1jcdkxyQka3
         QQJXLNCgfbte/QZKs+/Wmw+OJS89nn+TOKBF6x+m0WPbG6PmTpRvrQTMHf9zpVTs2ATj
         GfwUbdkK9BcykUfu+VpnNunQf/lAe0wjVLln5vYald54e3/ut8+wdWKj2R7oQNqc9Hve
         c0gmeH6IUQ2crNIDCE1CrigtxOhtlV8S/g+TRjCQh8QFxRk6wnVq+4ftPW6FeDuEqTF1
         gQ+oNBNz0mzoaEZOczCYrvcyQciCbrzpp0dGkslFHR+6mLR1PQKoPNMNH7DrvwQFUte2
         6EmA==
X-Gm-Message-State: AOJu0YxWVaRqbQF5ty1keRyP04aUM7L8wHKGI7HHg1I2ZkXS++kDCICH
	cLxJMU1vMDIPX0hSIBsXbPBGsAhJ2D8TrWAc+vg=
X-Google-Smtp-Source: AGHT+IEOrSo4jUkkbutzn8ChlRAscLYR8uTnBFs2NBoHAKPKV/5D3Qijj4V/8zCCdxsQSMxSi6kq3sUkPjhdq2x9dGk=
X-Received: by 2002:a05:6214:d0d:b0:66f:b89e:71de with SMTP id
 13-20020a0562140d0d00b0066fb89e71demr7409106qvh.36.1699602523394; Thu, 09 Nov
 2023 23:48:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202311031651.A7crZEur-lkp@intel.com> <20231106031802.4188-1-laoar.shao@gmail.com>
 <CAADnVQLDOEPmDyipHOH0E6QSg4aJtcHcfghoAQmQtROAMd=imQ@mail.gmail.com> <98fe8917-9054-4a46-a777-613d8c640d36@app.fastmail.com>
In-Reply-To: <98fe8917-9054-4a46-a777-613d8c640d36@app.fastmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 10 Nov 2023 15:48:07 +0800
Message-ID: <CALOAHbBFE85shrceCtXDu_isOFNHfcP_2eoHVXct3RwOdfrVbA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] compiler-gcc: Suppress -Wmissing-prototypes
 warning for all supported GCC
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, kernel test robot <lkp@intel.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Johannes Weiner <hannes@cmpxchg.org>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Waiman Long <longman@redhat.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	oe-kbuild-all@lists.linux.dev, kernel test robot <oliver.sang@intel.com>, 
	Stanislav Fomichev <sdf@google.com>, Kui-Feng Lee <sinquersw@gmail.com>, Song Liu <song@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Yosry Ahmed <yosryahmed@google.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 2:35=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Thu, Nov 9, 2023, at 19:23, Alexei Starovoitov wrote:
> > On Sun, Nov 5, 2023 at 7:18=E2=80=AFPM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> >> In the future, if you wish to suppress warnings that are only supporte=
d on
> >> higher GCC versions, it is advisable to explicitly use "__diag_ignore"=
 to
> >> specify the GCC version you are targeting.
> >>
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Closes: https://lore.kernel.org/oe-kbuild-all/202311031651.A7crZEur-lk=
p@intel.com/
> >> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> >> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> >> Cc: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >>  include/linux/compiler-gcc.h | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc=
.h
> >> index 7af9e34..80918bd 100644
> >> --- a/include/linux/compiler-gcc.h
> >> +++ b/include/linux/compiler-gcc.h
> >> @@ -138,7 +138,7 @@
> >>  #endif
> >>
> >>  #define __diag_ignore_all(option, comment) \
> >> -       __diag_GCC(8, ignore, option)
> >> +       __diag(__diag_GCC_ignore option)
> >
> > Arnd,
> > does this look good to you?
>
> Yes, this is good. We could do the same thing for
> clang already, but it doesn't make a huge difference.

The Minimum Clang version is 11.0.0, so I think we don't have to
change compiler-clang.h.

>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your review.

--=20
Regards
Yafang

