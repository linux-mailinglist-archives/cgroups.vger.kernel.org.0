Return-Path: <cgroups+bounces-583-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 921A77FAC6D
	for <lists+cgroups@lfdr.de>; Mon, 27 Nov 2023 22:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF75AB2131D
	for <lists+cgroups@lfdr.de>; Mon, 27 Nov 2023 21:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F6545C0B;
	Mon, 27 Nov 2023 21:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dHSIUL4r"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2A81A2
	for <cgroups@vger.kernel.org>; Mon, 27 Nov 2023 13:14:22 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a00a9c6f1e9so678275166b.3
        for <cgroups@vger.kernel.org>; Mon, 27 Nov 2023 13:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701119661; x=1701724461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHlTCHe4/wBQkktFnIHXqkfvwqIEOSM2fmKEpfUC8HU=;
        b=dHSIUL4rRZ6f19icYJRQNs51qpzdk3wy2c0iYfBTxg66Ap7w0M6ZYosnXJ4NnN0I9O
         /7MP54+NYoFkBapHyc4rY+1w1NT37A0tYLG8lDV8K4VuDVREbPyPghhUKgFpJNMhiQn0
         wFpcJ6JyZ10aQ9tQbcigTBLljk8bSn7joHW+E124pxPeldsjV4whny2kqiE4Pk8Abr/o
         gXvHb8Dg70kHD4n7cNjlBE6mxiOUym51CYQnYvs/ei3qCTvmBJYvyyd5OPM+WWN46AgG
         T/UcxPhscFL745cjEW3iI2LEAnI67K70VQSu5q54h5RNyrXaC+TCX7bT5JPF/3pbRbxD
         vYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701119661; x=1701724461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHlTCHe4/wBQkktFnIHXqkfvwqIEOSM2fmKEpfUC8HU=;
        b=RzRZaRWISksiZ7lIsNRBdNLrmUwlGQlPIVYaupqj2UOFgXWdkYnY2VafH6Wr8xMQ8W
         l3U8v0ZJY6DUuUpQH6aQ81p9COA1LsUcqL1IUh79htckWAuXhrimDXNT9he8I+nEfO+9
         ROXzIWaCnQwDHsD8Be7XxKHIqjU+qip4WDmgaTN35rviYBE15YoW0mNNGqP0Z/sJ+Siu
         aYq2ixLhVfMGDaBSSfIm4PqD/2aqDNkUmrwN3VHQOajVU1f9OBp9u+FGJ7UtMOGKVCbs
         AcOlKWxPT3ZfE0rhVhNXnQ6i7QLXyikbT5hVfdvfy9m/Vbf6aKOtEIKlVlwmTaK5Lajh
         ntRw==
X-Gm-Message-State: AOJu0YwgWUK3YbOA84+4vFVJHdT9YaJqLgXGVe2SDf308B4T09kaeLpc
	kC/xH2XCnk+PO+zXDqsZUGhjWKoplofJEfS3RL8ndw==
X-Google-Smtp-Source: AGHT+IGYi8xwqFfFpe0niiToCpHsvm1q+RbChDCT3xccMv3sRc/JIp2SCfG7mrEYNfGO5KtCN7bAv2jFI4lPCGF/kbg=
X-Received: by 2002:a17:906:2088:b0:a12:72eb:8f64 with SMTP id
 8-20020a170906208800b00a1272eb8f64mr544654ejq.30.1701119660661; Mon, 27 Nov
 2023 13:14:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116022411.2250072-4-yosryahmed@google.com> <202311221542.973f16ad-oliver.sang@intel.com>
In-Reply-To: <202311221542.973f16ad-oliver.sang@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 27 Nov 2023 13:13:44 -0800
Message-ID: <CAJD7tkYnn6CxSJdo0QJ1hc6cFY_qWLuJ0=S6g_Pm=GBV+Ss-jw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] mm: memcg: make stats flushing threshold per-memcg
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Johannes Weiner <hannes@cmpxchg.org>, Domenico Cerasuolo <cerasuolodomenico@gmail.com>, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com, 
	Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com, 
	Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 5:54=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed a -30.2% regression of will-it-scale.per_thread=
_ops on:
>
>
> commit: c7fbfc7b4e089c4a9b292b1973a42a5761c1342f ("[PATCH v3 3/5] mm: mem=
cg: make stats flushing threshold per-memcg")
> url: https://github.com/intel-lab-lkp/linux/commits/Yosry-Ahmed/mm-memcg-=
change-flush_next_time-to-flush_last_time/20231116-103300
> base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everyth=
ing
> patch link: https://lore.kernel.org/all/20231116022411.2250072-4-yosryahm=
ed@google.com/
> patch subject: [PATCH v3 3/5] mm: memcg: make stats flushing threshold pe=
r-memcg
>
> testcase: will-it-scale
> test machine: 104 threads 2 sockets (Skylake) with 192G memory
> parameters:
>
>         nr_task: 50%
>         mode: thread
>         test: fallocate2
>         cpufreq_governor: performance
>
>

This regression was also reported in v2, and I explicitly mention it
in the cover letter here:
https://lore.kernel.org/lkml/20231116022411.2250072-1-yosryahmed@google.com=
/

In a nutshell, I think this microbenchmark regression does not
represent real workloads. On the other hand, there are demonstrated
benefits on real workloads from this series in terms of stats reading
time.

