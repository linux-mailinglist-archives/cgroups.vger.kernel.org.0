Return-Path: <cgroups+bounces-118-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CAD7DBB35
	for <lists+cgroups@lfdr.de>; Mon, 30 Oct 2023 14:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489821C20AC1
	for <lists+cgroups@lfdr.de>; Mon, 30 Oct 2023 13:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D5A1772E;
	Mon, 30 Oct 2023 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g92dGtPo"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E19017726;
	Mon, 30 Oct 2023 13:59:10 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE312DB;
	Mon, 30 Oct 2023 06:59:08 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c3c8adb27so672198366b.1;
        Mon, 30 Oct 2023 06:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698674347; x=1699279147; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AF+Qe79yXub9UVn4xeznhJpuUhXUcwpDyMOziS7zLHY=;
        b=g92dGtPolUnM5lI+L+xZA6+LYIgo6y3zTfTFLVYWx1KcLf/KOFqEMc2XkRulOa018k
         Od6/93JhW61N27RpiyBN+GxTEk1qPi1D9vE5fIF0YokJcdmaieVZPBXkuzjfBHI//lfw
         ojnXdRkRr+W89xm+q3ZOZ7NUWUODpP+0s9URxh27hBRw81soPWOW+QmUXQvUE9Tg1fSl
         hKtjfzRBMZ8j1twQxnFefUK95GWSqw3iOhP+8CESK6MQO0JJVoVQX7uOSjO/XzIMTXEO
         Fwb7ZJERjMlNC1RCXUpIxD5snvVSGg6FZP7qCG8h1jXYV/cMlg/C/vtb4cI4YmQardOK
         j6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698674347; x=1699279147;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AF+Qe79yXub9UVn4xeznhJpuUhXUcwpDyMOziS7zLHY=;
        b=O9Gb+KuY7VJGkYUtuTVaiXOoQGqeEEEmS1uBk3zIn03KeCZz4UjfWnVNySeddigy8f
         qXJFjqE6S+7+DjL9y77zA4yvp94P0cOHj/4Ybo/sFGVGXv1RNIlQ2wC0Z9kut46mx/GQ
         Rk+ecPrzyc36K5JZIB+9F0gfXeDu9Vu0DGBLPQhsBYQROboCPiDfGGWSNZ7TXUsZLY5y
         cahvMe0L/ZPb82lLI0mmigp4/LIVFUrqOz7dggegJ7JAOh6veATOb71QpT+cdpxIO9Hq
         zqWHxgFDxal4bbJX3gEnfsZuNFZJKct2DKuqCNkD1iHnst8teGKItt9DSu+po1EHyk3Z
         Goqw==
X-Gm-Message-State: AOJu0Yzr/puRLGoyKSrO3rpvCSDreZBAQzEY5NgB0idRAs5g8MfVm/Zt
	xXMlHIwyIqsGfCIETfSLqZI=
X-Google-Smtp-Source: AGHT+IF52rJEeWB2QkfJjXhiLxdBWtzGh7OFagouDGoCkuuCFiNumER0ehrXUXG7LnwA69TA0Iqwxw==
X-Received: by 2002:a17:906:ee8a:b0:9ba:a38:531e with SMTP id wt10-20020a170906ee8a00b009ba0a38531emr9000368ejb.52.1698674346955;
        Mon, 30 Oct 2023 06:59:06 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id r9-20020a1709060d4900b0099d804da2e9sm6075563ejh.225.2023.10.30.06.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 06:59:06 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 30 Oct 2023 14:59:04 +0100
To: Yafang Shao <laoar.shao@gmail.com>,
	Dave Marchevsky <davemarchevsky@fb.com>
Cc: kernel test robot <lkp@intel.com>, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, tj@kernel.org,
	lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
	mkoutny@suse.com, sinquersw@gmail.com, longman@redhat.com,
	oe-kbuild-all@lists.linux.dev, cgroups@vger.kernel.org,
	bpf@vger.kernel.org, oliver.sang@intel.com
Subject: Re: [PATCH v3 bpf-next 06/11] bpf: Add a new kfunc for cgroup1
 hierarchy
Message-ID: <ZT+2qCc/aXep0/Lf@krava>
References: <20231029061438.4215-7-laoar.shao@gmail.com>
 <202310301605.CGFI0aSW-lkp@intel.com>
 <CALOAHbA51eCYFsfaUVBxRrfKt=z1=77bPO1CPKEyGeph5PztOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbA51eCYFsfaUVBxRrfKt=z1=77bPO1CPKEyGeph5PztOQ@mail.gmail.com>

On Mon, Oct 30, 2023 at 07:35:25PM +0800, Yafang Shao wrote:
> On Mon, Oct 30, 2023 at 5:01 PM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Yafang,
> >
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on bpf-next/master]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/cgroup-Remove-unnecessary-list_empty/20231029-143457
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> > patch link:    https://lore.kernel.org/r/20231029061438.4215-7-laoar.shao%40gmail.com
> > patch subject: [PATCH v3 bpf-next 06/11] bpf: Add a new kfunc for cgroup1 hierarchy
> > config: i386-randconfig-013-20231030 (https://download.01.org/0day-ci/archive/20231030/202310301605.CGFI0aSW-lkp@intel.com/config)
> > compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231030/202310301605.CGFI0aSW-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202310301605.CGFI0aSW-lkp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> >    kernel/bpf/helpers.c:1893:19: warning: no previous declaration for 'bpf_obj_new_impl' [-Wmissing-declarations]
> 
> -Wmissing-declarations is a known issue and somebody is working on it, right?

there's this post [1] from Dave, but seems it never landed

jirka

[1] https://lore.kernel.org/bpf/20230816150634.1162838-1-void@manifault.com/

