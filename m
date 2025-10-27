Return-Path: <cgroups+bounces-11231-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 616A7C12196
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 00:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 115CD4E1FA9
	for <lists+cgroups@lfdr.de>; Mon, 27 Oct 2025 23:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FE53328EA;
	Mon, 27 Oct 2025 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfIQEUEQ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5FE320CCE;
	Mon, 27 Oct 2025 23:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761608903; cv=none; b=AJW1ERUfvOhEuAwh7F/WCuF5ITLVHb26bycj497Yv2b/TrtW3N5kpk6/dPX10WhINbni0b+aSlrgcA4DersTuCdWdPM1Mfv4MDM8Qd/Sk0XXAj6TNgux1fSk9baV9YhaFXxZpiXGJgeulf5tzTFd2AZjnVYsOT/Za3xS9HH5P2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761608903; c=relaxed/simple;
	bh=AnKh9TnjGx6cTQHLhdWTDeeCl/DZJcm2y5DLoUM1VdQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SOWvRn3gmmdvrODcgSvWvr2JGG8pc/tU3fWBSMyU2YoIS3oI1kTQvLbCvBLoBFrSgtzopVUjQKFzTg6WNA8Yqc+ZGonufbVjMakSUOhgvg59rCynMDivETPA4oQWTrfYw6HS+Ku/xOBwuDB0YQXNtNznflhetbeJ57kMvkvEd7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfIQEUEQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11819C4CEF1;
	Mon, 27 Oct 2025 23:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761608902;
	bh=AnKh9TnjGx6cTQHLhdWTDeeCl/DZJcm2y5DLoUM1VdQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=gfIQEUEQEQi+CfwEFux9nzPvcCq3QrhwulrRz3IrdqsruHvUIgsPMK56xlLanv3zY
	 peCjFOLErcM8XS1tvtrG4GU+RtTgLDu19+0Y0EByMZ7MftGEW7mYNYkwnMLwp70Cs7
	 iLtvefYfCXDM1Edbuvmzg+SJteDVp//b3FDA6wM2dx1uowvn/OM6klNwml72HvDhIE
	 gfWNkzOPxRryVmkpj3rmhNKPTEq6FC+ksk5gMdm7EKO19FAipFoiy5qPnpYDJRrITb
	 A+JisPsY7cXjEB4fut3FGxq16Nb5pIj7O5+3Qtzn5nssYXobEmdl/FacvC3lNp9Kuk
	 +uS6QYXz1VU8Q==
Content-Type: multipart/mixed; boundary="===============4764234490748152666=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2c91977fcab04be6305bf4be57e825f7e84005d16667adcdfad0585be506537c@mail.kernel.org>
In-Reply-To: <20251027231727.472628-9-roman.gushchin@linux.dev>
References: <20251027231727.472628-9-roman.gushchin@linux.dev>
Subject: Re: [PATCH v2 08/23] mm: introduce BPF kfuncs to deal with memcg pointers
From: bot+bpf-ci@kernel.org
To: roman.gushchin@linux.dev,akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,ast@kernel.org,surenb@google.com,mhocko@kernel.org,shakeel.butt@linux.dev,hannes@cmpxchg.org,andrii@kernel.org,inwardvessel@gmail.com,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,martin.lau@kernel.org,song@kernel.org,memxor@gmail.com,tj@kernel.org,roman.gushchin@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 27 Oct 2025 23:48:21 +0000 (UTC)

--===============4764234490748152666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit ec8e2e1769704b4f69261f36e6aaf035d47c5f0f
Author: Roman Gushchin <roman.gushchin@linux.dev>

mm: introduce BPF kfuncs to deal with memcg pointers

This commit introduces two new BPF kfuncs for converting css pointers
to memcg pointers with proper reference counting: bpf_get_mem_cgroup()
and bpf_put_mem_cgroup().

> diff --git a/mm/Makefile b/mm/Makefile
> index 051e88c69..2d8f9beb3 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -107,6 +107,7 @@ obj-$(CONFIG_MEMCG) += swap_cgroup.o
>  endif
>  ifdef CONFIG_BPF_SYSCALL
>  obj-y += bpf_oom.o
> +obj-$(CONFIG_MEMCG) += bpf_memcontrol.o
>  endif
>  obj-$(CONFIG_CGROUP_HUGETLB) += hugetlb_cgroup.o
>  obj-$(CONFIG_GUP_TEST) += gup_test.o
> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> new file mode 100644
> index 000000000..1e4609774
> --- /dev/null
> +++ b/mm/bpf_memcontrol.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Memory Controller-related BPF kfuncs and auxiliary code
> + *
> + * Author: Roman Gushchin <roman.gushchin@linux.dev>
> + */
> +
> +#include <linux/memcontrol.h>
> +#include <linux/bpf.h>
> +
> +__bpf_kfunc_start_defs();
> +
> +/**
> + * bpf_get_mem_cgroup - Get a reference to a memory cgroup
> + * @css: pointer to the css structure
> + *
> + * Returns a pointer to a mem_cgroup structure after bumping
> + * the corresponding css's reference counter.
> + *
> + * It's fine to pass a css which belongs to any cgroup controller,
> + * e.g. unified hierarchy's main css.
> + *
> + * Implements KF_ACQUIRE semantics.
> + */
> +__bpf_kfunc struct mem_cgroup *
> +bpf_get_mem_cgroup(struct cgroup_subsys_state *css)
> +{
> +	struct mem_cgroup *memcg = NULL;
> +	bool rcu_unlock = false;
> +
> +	if (!root_mem_cgroup)
> +		return NULL;
> +
> +	if (root_mem_cgroup->css.ss != css->ss) {
                                            ^^^^^^^

Can this dereference a NULL css pointer?  The function checks css for
NULL at line 42 with "if (css && css_tryget(css))", which suggests css
can be NULL.  If a BPF program calls this function with a NULL css,
wouldn't it crash here before reaching that check?

> +		struct cgroup *cgroup = css->cgroup;
> +		int ssid = root_mem_cgroup->css.ss->id;
> +
> +		rcu_read_lock();
> +		rcu_unlock = true;
> +		css = rcu_dereference_raw(cgroup->subsys[ssid]);
> +	}
> +
> +	if (css && css_tryget(css))
> +		memcg = container_of(css, struct mem_cgroup, css);
> +
> +	if (rcu_unlock)
> +		rcu_read_unlock();
> +
> +	return memcg;
> +}

[ ... ]

> +__bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
> +BTF_ID_FLAGS(func, bpf_get_mem_cgroup, KF_ACQUIRE | KF_RET_NULL | KF_RCU)
> +BTF_ID_FLAGS(func, bpf_put_mem_cgroup, KF_RELEASE)
> +
> +BTF_KFUNCS_END(bpf_memcontrol_kfuncs)

[ ... ]


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `mm: introduce BPF kfuncs to deal with memcg pointers`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18859027430

--===============4764234490748152666==--

