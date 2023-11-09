Return-Path: <cgroups+bounces-287-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F587E7155
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 19:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC54281130
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 18:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9069936AE6;
	Thu,  9 Nov 2023 18:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="na1sQEYo"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F68347A2;
	Thu,  9 Nov 2023 18:23:27 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D673C01;
	Thu,  9 Nov 2023 10:23:25 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32da7ac5c4fso690306f8f.1;
        Thu, 09 Nov 2023 10:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699554204; x=1700159004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BPQXHQI7/Rfc9RZRbQPwTxFbuzF5RhqmSjIsZvq5GE=;
        b=na1sQEYof6JFNPfmH1wHX0PMX9YN01njY9ceEju3L01ZF+hwyWI5k5CL02L/6hT0eQ
         6xwWDRa3v7s+wGOTv3dztrkhglu2w7JuOLTdIxZXbXdGXkYMbErcGi3dpALfIzBmuQDG
         gegISp5LZHStFtDwbuD2q6PP2aXaKXstVIE7+ZcABBAyODXOaMj/CvMniJj3VD6I2mXJ
         lJm0tatgOBocu4e1dgSo9V7cc/Uz5sqvPVmXApb2rYH0H2fZh4W9MGTUJQqS2qOBvpx7
         CfhsUgPU+26ATxX4Hkpu5caBX043E+CyiUMXKSr93p6P9/yPLE7rB13nvQmiTVDiDFqe
         Sn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699554204; x=1700159004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BPQXHQI7/Rfc9RZRbQPwTxFbuzF5RhqmSjIsZvq5GE=;
        b=VEJhQx023Xesa9KZTTZFyL3Wm6xn8WaPFadcamo4UXehcVUR/406zFNcqzP0/E8FfU
         FYrAjVgcbWIR2NtO+6EsnYjHEMGmm5fwii2iYXUR2ypMAMKZcw1ntg3CJnzl/U030cE3
         q/2nhydbfFIxmYM1Ung8itVL4crZY/Ll/l/cuC2wpWjmtmIk1TpcgDUJprwZoB2UaUTK
         0aaFXtnfedmlgXhMg5IFNo1nWhBCZoDCvjH/0MU2qSnUUhH0820D9Bb58BVPbrKTcBwh
         46LVZKzy2AA0npCJtjbnqOIV6n1ROUJOpH10SDlGleNLSu8BbjAgTMT8Vi9MojJSDUKl
         46Lw==
X-Gm-Message-State: AOJu0Yx/tsQjX9nWtMlAo5qqse4naq5s1Rqqq0G77vwTL4FUGCjkTlU7
	oHfQH0MsAsq3APRRlvRs+izzENkYmoQP9/bc8so=
X-Google-Smtp-Source: AGHT+IEBqvPwO8v1AiU9zIjTCU0qLIf0TRpz/VucjkyThOBub813+sYMjLsV3t5K5c6jm+caQ2D5k4mgDRWugQ2PPWQ=
X-Received: by 2002:adf:ebc3:0:b0:32d:96dd:704d with SMTP id
 v3-20020adfebc3000000b0032d96dd704dmr4279394wrn.18.1699554203414; Thu, 09 Nov
 2023 10:23:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202311031651.A7crZEur-lkp@intel.com> <20231106031802.4188-1-laoar.shao@gmail.com>
In-Reply-To: <20231106031802.4188-1-laoar.shao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Nov 2023 10:23:11 -0800
Message-ID: <CAADnVQLDOEPmDyipHOH0E6QSg4aJtcHcfghoAQmQtROAMd=imQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] compiler-gcc: Suppress -Wmissing-prototypes
 warning for all supported GCC
To: Yafang Shao <laoar.shao@gmail.com>
Cc: kbuild test robot <lkp@intel.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Johannes Weiner <hannes@cmpxchg.org>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Waiman Long <longman@redhat.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	oe-kbuild-all@lists.linux.dev, kernel test robot <oliver.sang@intel.com>, 
	Stanislav Fomichev <sdf@google.com>, Kui-Feng Lee <sinquersw@gmail.com>, Song Liu <song@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Yosry Ahmed <yosryahmed@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 5, 2023 at 7:18=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> The kernel supports a minimum GCC version of 5.1.0 for building. However,
> the "__diag_ignore_all" directive only suppresses the
> "-Wmissing-prototypes" warning for GCC versions >=3D 8.0.0. As a result, =
when
> building the kernel with older GCC versions, warnings may be triggered. T=
he
> example below illustrates the warnings reported by the kernel test robot
> using GCC 7.5.0:
>
>   compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
>   All warnings (new ones prefixed by >>):
>
>    kernel/bpf/helpers.c:1893:19: warning: no previous prototype for 'bpf_=
obj_new_impl' [-Wmissing-prototypes]
>     __bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__=
ign)
>                       ^~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:1907:19: warning: no previous prototype for 'bpf_=
percpu_obj_new_impl' [-Wmissing-prototypes]
>     __bpf_kfunc void *bpf_percpu_obj_new_impl(u64 local_type_id__k, void =
*meta__ign)
>    [...]
>
> To address this, we should also suppress the "-Wmissing-prototypes" warni=
ng
> for older GCC versions. "#pragma GCC diagnostic push" is supported as
> of GCC 4.6, and both "-Wmissing-prototypes" and "-Wmissing-declarations"
> are supported for all the GCC versions that we currently support.
> Therefore, it is reasonable to suppress these warnings for all supported
> GCC versions.
>
> With this adjustment, it's important to note that after implementing
> "__diag_ignore_all", it will effectively suppress warnings for all the
> supported GCC versions.
>
> In the future, if you wish to suppress warnings that are only supported o=
n
> higher GCC versions, it is advisable to explicitly use "__diag_ignore" to
> specify the GCC version you are targeting.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311031651.A7crZEur-lkp@i=
ntel.com/
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/compiler-gcc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 7af9e34..80918bd 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -138,7 +138,7 @@
>  #endif
>
>  #define __diag_ignore_all(option, comment) \
> -       __diag_GCC(8, ignore, option)
> +       __diag(__diag_GCC_ignore option)

Arnd,
does this look good to you?

If so, pls ack.

