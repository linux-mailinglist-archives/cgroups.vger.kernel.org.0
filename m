Return-Path: <cgroups+bounces-117-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 315867DB90A
	for <lists+cgroups@lfdr.de>; Mon, 30 Oct 2023 12:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90639281512
	for <lists+cgroups@lfdr.de>; Mon, 30 Oct 2023 11:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B243F13FE0;
	Mon, 30 Oct 2023 11:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhUHnyYc"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB31B12E53;
	Mon, 30 Oct 2023 11:36:04 +0000 (UTC)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3883BC4;
	Mon, 30 Oct 2023 04:36:03 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a7afd45199so40051397b3.0;
        Mon, 30 Oct 2023 04:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698665762; x=1699270562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qthidPTR+eTfkmkLWPFHs2FuiYW04uLS5zl0QtuY49M=;
        b=OhUHnyYc3WEzDMl6vZEphfiKGwcAiWiKfkVLyaC7OugqyfK88jprRXiJWB2EbqxIJ9
         CcoH1gF33tLHZTcTVBDI5saBg0Bq4fzg8q2S699a9EfBOIpWK53edMdM9kXd8lgg7bfO
         Yamflp3Fxt1H4s6z4xLhK0e/EF+fEQSfdy0XT9QP3NL+np7LVwd0Urj1yND0Qx/X6aqA
         lxV7/RM4XC76oFXF6ULLuLgQFt1miribavcDiKqA7gsec68LGBZzOfd/ew5bR9nc5Naw
         ekNW3ST+Wlv6WVm7+RkQ3dACFASmIKhJQFt9VRlMvivra3DP8qYr8z+q2rjsiHYchdg8
         OOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698665762; x=1699270562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qthidPTR+eTfkmkLWPFHs2FuiYW04uLS5zl0QtuY49M=;
        b=V4tyPJN5Q7GHKdxOmrCoH0NhzimTd5Ki8NzLCs2qLmrzPRsB+sskz2nIo0ayes10DO
         i02Pcj1LXfgJ8EFHpasXrGthmsc+1CHFiL0/pgGFZG46yYpbbyiN2uqil12FxCTQVZ3v
         7F5omdeQVZ958vTL2jj7z1YZaypEglrCyeSRBY21OzWaDkrAPb2AhjtBAeEwIeYeCQ+V
         2zMcb5tO7lWNovy5+tTR7fUEL4+X+CifVgETKWE+ShwqS59ASx25hvFRCE7eZQhA/Q0d
         SDdZGH0ENOKnPziraE1dILA+zDfjtTiGEBo2RUadNQbmQ7Fp9QjjUF2o4WTU1Hbx3uu5
         nfrQ==
X-Gm-Message-State: AOJu0Yz3nxbqIPFWLMqmaeNycyNL2b/U7zRozquOxCvs02GkP5jVu958
	GCbgCX6TuyEAzaD4ttKp1lP/1p/40hOQpUZLYGg=
X-Google-Smtp-Source: AGHT+IHH4fcCsA+tyWVbIyDc2dZAophSJFvc0q1YfFGl/DwDjxYIuoQMYDIwJERYp/Nhg53L7ynux94JiV+d7kNe0ds=
X-Received: by 2002:a81:450d:0:b0:5a7:bc38:fff2 with SMTP id
 s13-20020a81450d000000b005a7bc38fff2mr9469511ywa.15.1698665762297; Mon, 30
 Oct 2023 04:36:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231029061438.4215-7-laoar.shao@gmail.com> <202310301605.CGFI0aSW-lkp@intel.com>
In-Reply-To: <202310301605.CGFI0aSW-lkp@intel.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 30 Oct 2023 19:35:25 +0800
Message-ID: <CALOAHbA51eCYFsfaUVBxRrfKt=z1=77bPO1CPKEyGeph5PztOQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 06/11] bpf: Add a new kfunc for cgroup1 hierarchy
To: kernel test robot <lkp@intel.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, tj@kernel.org, lizefan.x@bytedance.com, 
	hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com, 
	sinquersw@gmail.com, longman@redhat.com, oe-kbuild-all@lists.linux.dev, 
	cgroups@vger.kernel.org, bpf@vger.kernel.org, oliver.sang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 5:01=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Yafang,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on bpf-next/master]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/cgroup=
-Remove-unnecessary-list_empty/20231029-143457
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git =
master
> patch link:    https://lore.kernel.org/r/20231029061438.4215-7-laoar.shao=
%40gmail.com
> patch subject: [PATCH v3 bpf-next 06/11] bpf: Add a new kfunc for cgroup1=
 hierarchy
> config: i386-randconfig-013-20231030 (https://download.01.org/0day-ci/arc=
hive/20231030/202310301605.CGFI0aSW-lkp@intel.com/config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20231030/202310301605.CGFI0aSW-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310301605.CGFI0aSW-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    kernel/bpf/helpers.c:1893:19: warning: no previous declaration for 'bp=
f_obj_new_impl' [-Wmissing-declarations]

-Wmissing-declarations is a known issue and somebody is working on it, righ=
t?

--=20
Regards
Yafang

