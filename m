Return-Path: <cgroups+bounces-11230-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCF7C121A6
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 00:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C17466B23
	for <lists+cgroups@lfdr.de>; Mon, 27 Oct 2025 23:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9174F331A46;
	Mon, 27 Oct 2025 23:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdfSt+qE"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B28330328;
	Mon, 27 Oct 2025 23:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761608899; cv=none; b=jcC7JkwS1uuOR9mFGUP++jjejlGdVx19nJlOJHUVQ2d12F9bhIyQz3ryBFdpf6uyF2i0VkODiBWuQ20acJL/UY/2Fr4HPFPdxcNxKjoM3d+blzhqgrEHfIQuwhf/wtSvOEzsyIgPAiBorvJzgRJZwLg0jrSxl0eWVCYe+DI8iBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761608899; c=relaxed/simple;
	bh=MLA2F7QqX/OHamOWtkCHp8EpAAyPqD+AKaVfDclzErY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NBk/BwqBWrTerfJtOOUd58TcAZ/JEqNPOvfZLsOdTz7TEa4X2BzQXiI7R/D8ETQYsVl+1wpJFQw8X+1Iay0kSD30y+CytmnZbERcWnyTWZlz+3aDOg33xd0IZN1sH/+rWMpAASw2XQaTOSZla+JU1VIXB8NpGF4m2AzT81dNM3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdfSt+qE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB21C116C6;
	Mon, 27 Oct 2025 23:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761608899;
	bh=MLA2F7QqX/OHamOWtkCHp8EpAAyPqD+AKaVfDclzErY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=LdfSt+qEFuOsqzkDcGpesXghVhkT08jYCM7RP9OwYjDu8goGtG28bHymsIza1f3BE
	 zl+bGqEumbTVhZbCz9Vm7LP0GMoDYhfhKHBm+8P3+/YSE03HJJgZ4xsYw/uLHkfd6r
	 IGoVQDSopFluJExhyOWO4BcEufV9V/kUvn8Orm5WLj5X4y3UYRfkBY7dGA8KvOgK7l
	 D1r5CIlh8U1OofwiyOLa1TW+FwjrHhXPqbQobUVJOd0PSigXtnlG8LdNN9mQVoCHT2
	 Iks6j5+9GVa3GXdk6fcuLA509k+mD5Z+oFUNBfWohSiCIukWUxyCx/NRMkXHUD2JYB
	 GLXAEufzn+/CA==
Content-Type: multipart/mixed; boundary="===============6631180569956951959=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9fd0fbd3d6e704d106423a333106d1296c916f288c3c3600ffde0539e8c266ec@mail.kernel.org>
In-Reply-To: <20251027231727.472628-3-roman.gushchin@linux.dev>
References: <20251027231727.472628-3-roman.gushchin@linux.dev>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops to cgroups
From: bot+bpf-ci@kernel.org
To: roman.gushchin@linux.dev,akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,ast@kernel.org,surenb@google.com,mhocko@kernel.org,shakeel.butt@linux.dev,hannes@cmpxchg.org,andrii@kernel.org,inwardvessel@gmail.com,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,martin.lau@kernel.org,song@kernel.org,memxor@gmail.com,tj@kernel.org,roman.gushchin@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 27 Oct 2025 23:48:17 +0000 (UTC)

--===============6631180569956951959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit 31d238f36a0a6a56efa48c847cb776e67ba2f079
Author: Roman Gushchin <roman.gushchin@linux.dev>

bpf: initial support for attaching struct ops to cgroups

When a struct ops is being attached and a bpf link is created, allow to
pass a cgroup fd using bpf attr, so that struct ops can be attached to a
cgroup instead of globally. Attached struct ops doesn't hold a reference
to the cgroup, only preserves cgroup id.

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index eae907218..7205b813e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1849,6 +1849,7 @@ struct bpf_struct_ops_link {
>  	struct bpf_link link;
>  	struct bpf_map __rcu *map;
>  	wait_queue_head_t wait_hup;
> +	u64 cgroup_id;
>  };
>
>  struct bpf_link_primer {
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 45cc5ee19..58664779a 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -13,6 +13,7 @@
>  #include <linux/btf_ids.h>
>  #include <linux/rcupdate_wait.h>
>  #include <linux/poll.h>
> +#include <linux/cgroup.h>
>
>  struct bpf_struct_ops_value {
>  	struct bpf_struct_ops_common_value common;

[ ... ]

> @@ -1359,6 +1360,18 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
>  	}
>  	bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_map_lops, NULL,
>  		      attr->link_create.attach_type);
> +#ifdef CONFIG_CGROUPS
> +	if (attr->link_create.cgroup.relative_fd) {
> +		struct cgroup *cgrp;
> +
> +		cgrp = cgroup_get_from_fd(attr->link_create.cgroup.relative_fd);
> +		if (IS_ERR(cgrp))
> +			return PTR_ERR(cgrp);
                        ^^^^^^^^^^^^^^^^^^^^^^

Can this leak the link and map? In bpf_struct_ops_link_create(), the link
is allocated with kzalloc(GFP_USER) and map is obtained with bpf_map_get()
before this point. If cgroup_get_from_fd() fails, the early return skips
the err_out label which does kfree(link) and bpf_map_put(map).

All other error paths in this function use "err = <error>; goto err_out;"
but this one returns directly.

> +
> +		link->cgroup_id = cgroup_id(cgrp);
> +		cgroup_put(cgrp);
> +	}
> +#endif /* CONFIG_CGROUPS */
> +
>  	err = bpf_link_prime(&link->link, &link_primer);
>  	if (err)
>  		goto err_out;


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `bpf: initial support for attaching struct ops to cgroups`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18859027430

--===============6631180569956951959==--

