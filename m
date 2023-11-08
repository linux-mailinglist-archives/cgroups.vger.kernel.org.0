Return-Path: <cgroups+bounces-255-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C20127E60E5
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 00:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F34001C20B15
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 23:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B10137173;
	Wed,  8 Nov 2023 23:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhEUATI6"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1933716C
	for <cgroups@vger.kernel.org>; Wed,  8 Nov 2023 23:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84511C433B9
	for <cgroups@vger.kernel.org>; Wed,  8 Nov 2023 23:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699485176;
	bh=XVBBiYvFcflt3RBN3rGd9qpfbzxVloqDfLv4DULg6ok=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GhEUATI6mZs1fF6smM1OF1+SECjnJXs8PTbY8lZlXnwUzfrIaMjVcZrna4tyfEssS
	 MvGlJnycjYJACcUMvu25sl5LhY0BU6ev9+T2BDMC2URKAOJMBfb7nsl3dq4dFrDqaY
	 X/HaXRuMCbaH4+k6CzGCidmqxStSSbTkgY54qUJ9GS/aq4bQe50tzUSp/SzQ2govLx
	 pDgv0xsqdjqqQkJ4t9vx7+31QS9SI3mT6XwaztXOr2IJCO/29AvnjwYogapTP0s0Nq
	 Ok2g9gBp2XnLp3GlK5mFynSBAbjX0JkPLH6IwcRVIfujHgnpbPDDnEbFsm3ibR4FJU
	 hnJJ39niADs1w==
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28023eadc70so176259a91.2
        for <cgroups@vger.kernel.org>; Wed, 08 Nov 2023 15:12:56 -0800 (PST)
X-Gm-Message-State: AOJu0YwJMck8rhvqvOpwM7pdF0rKczh2Lg3LWb7MGR9fCYc3TZpqtwzu
	kkUxzpOuwfpRtNG9Tx1+0YhjHJfkhm7OMtqGIiydSQ==
X-Google-Smtp-Source: AGHT+IG7AbhTVdHwxHa1Gbw/9I7xiut+l21ol4va4G64SojHtO9SqVeRdBniOkqWY5kzkdi8uhNp/WPljLmSit11Y9w=
X-Received: by 2002:a17:90b:350b:b0:27d:20ca:1156 with SMTP id
 ls11-20020a17090b350b00b0027d20ca1156mr2355pjb.34.1699485175679; Wed, 08 Nov
 2023 15:12:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106183159.3562879-1-nphamcs@gmail.com> <CAF8kJuMsXUm9=kiL8qPNVfYPzfyq-JWYSH3KraZadjF+myW-2A@mail.gmail.com>
 <CAKEwX=MNKY0UHbxi6Zfwf0KkepYavFaZo8F6LGe5GyyE3U35Jg@mail.gmail.com>
In-Reply-To: <CAKEwX=MNKY0UHbxi6Zfwf0KkepYavFaZo8F6LGe5GyyE3U35Jg@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 8 Nov 2023 15:12:44 -0800
X-Gmail-Original-Message-ID: <CAF8kJuMx4KT9z2RPy8z+snhM6YUtK=kZ1+BdHjKua2jhwFo-XQ@mail.gmail.com>
Message-ID: <CAF8kJuMx4KT9z2RPy8z+snhM6YUtK=kZ1+BdHjKua2jhwFo-XQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] workload-specific and memory pressure-driven zswap writeback
To: Nhat Pham <nphamcs@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>, 
	Vitaly Wool <vitaly.wool@konsulko.com>, mhocko@kernel.org, roman.gushchin@linux.dev, 
	Shakeel Butt <shakeelb@google.com>, muchun.song@linux.dev, linux-mm <linux-mm@kvack.org>, 
	kernel-team@meta.com, LKML <linux-kernel@vger.kernel.org>, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nhat,

On Wed, Nov 8, 2023 at 1:15=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> Ah that was meant to be a fixlet - so that on top of the original
> "zswap: make shrinking memcg-aware" patch. The intention was
> to eventually squash it...
>
> But this is getting a bit annoyingly confusing, I admit. I just rebased t=
o
> mm-unstable + squashed it all again, then sent one single replacement
> patch:
>
> [PATCH v5 3/6 REPLACE] zswap: make shrinking memcg-aware

Thank you for the quick response.

Yes, I am able to download your replacement version of patch 3.
Just FYI, I am using "git mailsplit" to split up the mbox into 6
separate patch files.
On mm-unstable, I am able to apply your replacement patch 3 cleanly.
I also need some help on the patch 0005, it does not apply cleanly either.

$ git mailsplit -ozswap-pool-lru
v5_20231106_nphamcs_workload_specific_and_memory_pressure_driven_zswap_writ=
eback.mbx
$ git am patches/zswap-pool-lru/0001
Applying: list_lru: allows explicit memcg and NUMA node selection
$ git am patches/zswap-pool-lru/0002
Applying: memcontrol: allows mem_cgroup_iter() to check for onlineness
$ git am patches/zswap-pool-lru/3.replace
Applying: zswap: make shrinking memcg-aware
$ git am patches/zswap-pool-lru/0004
Applying: mm: memcg: add per-memcg zswap writeback stat
$ git am patches/zswap-pool-lru/0005
Applying: selftests: cgroup: update per-memcg zswap writeback selftest
error: patch failed: tools/testing/selftests/cgroup/test_zswap.c:50
error: tools/testing/selftests/cgroup/test_zswap.c: patch does not apply
Patch failed at 0001 selftests: cgroup: update per-memcg zswap
writeback selftest
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

>
> Let me know if this still fails to apply. If not, I'll send the whole thi=
ng
> again as v6! My sincerest apologies for the troubles and confusion :(

No problem at all. Thanks for your help on patch 3.

Chris

