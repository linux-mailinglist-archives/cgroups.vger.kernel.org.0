Return-Path: <cgroups+bounces-11229-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DFAC1219C
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 00:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06BDB465FC0
	for <lists+cgroups@lfdr.de>; Mon, 27 Oct 2025 23:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4C72E7F29;
	Mon, 27 Oct 2025 23:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCY9C8dt"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84263330B37;
	Mon, 27 Oct 2025 23:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761608896; cv=none; b=eEY4IXtiggFIAWfMgP5kS9SrRFBbLGePuXGsStWxNxUGd0hprFxTPIxzjAPPguh3Yur8HzF56Smj7kxd2WdPWmeDW+g5YsFQHKdnBYFL/za7B7MhFqq/l+MH6pGy8rIdNuqhhC1uhmOYt4DjE+8A6SWJlQLUpZe2g0Ajsv2p+LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761608896; c=relaxed/simple;
	bh=v0Afzzp0700/IjRTUynv8g5JufTRMVUbnyZY3s2z8vU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=g8wqYNrtoXB0F8CFQbG+c34dlqJAC2t8gFPPUNuyWRaO2hRUuAkfR6VG4+RNku031tgIYNeILlfWZlYbKbTjXV9xVsOggoLuArFB0pmGv6Raomoq0ocwmoZB5mlmne9QjXzpKn6Ms4/CLcyloytps20uBIcFQTvOvXAAkH4RU6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCY9C8dt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3774AC116B1;
	Mon, 27 Oct 2025 23:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761608896;
	bh=v0Afzzp0700/IjRTUynv8g5JufTRMVUbnyZY3s2z8vU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=vCY9C8dt540K8vmYo7odHS4QKxuyLr1FxOMp1bgGYYl1z641c7M+KDsvgTU8VuzYN
	 0vUvEhm0EcWPix1RKYtdLlhC9kC7RzxNAbUdmLpuQVfqccXZFi45Mw1hgTIiEeP9Ua
	 wXDtLN97hepJZn3owJSm9gmsAREe8RKv5d5JAgKmEvbtVzJUIkmo5hdWobzLKWmdHS
	 250aqXzPPKoYx8YaC9IL0JO13y3eJL4E3S5U3jmBmeWExKczW7UNOiaxmaX+H1X/kn
	 zaifLKQPy03sG29dKdowCGKYQwXIlP6vqCel/peFS4+wSLzsctch3ANCx10/IaRYtX
	 84nIPWGC/3pKQ==
Content-Type: multipart/mixed; boundary="===============4920457427699144756=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <45ee5e2e857a2e4022eb380f854d2a7cf27f3ec97d75a0200b46be95ae921d3b@mail.kernel.org>
In-Reply-To: <20251027231727.472628-11-roman.gushchin@linux.dev>
References: <20251027231727.472628-11-roman.gushchin@linux.dev>
Subject: Re: [PATCH v2 10/23] mm: introduce BPF kfuncs to access memcg statistics and events
From: bot+bpf-ci@kernel.org
To: roman.gushchin@linux.dev,akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,ast@kernel.org,surenb@google.com,mhocko@kernel.org,shakeel.butt@linux.dev,hannes@cmpxchg.org,andrii@kernel.org,inwardvessel@gmail.com,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,martin.lau@kernel.org,song@kernel.org,memxor@gmail.com,tj@kernel.org,roman.gushchin@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 27 Oct 2025 23:48:14 +0000 (UTC)

--===============4920457427699144756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit 96abfe0549713749f00e32bff919a759db284a58
Author: Roman Gushchin <roman.gushchin@linux.dev>

mm: introduce BPF kfuncs to access memcg statistics and events

This patch adds four new BPF kfuncs for accessing memory cgroup statistics
and events, making them available to all BPF program types for implementing
OOM policies and accelerating memcg data access.

> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 39a6c7c87..b9e08dddd 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h

[ ... ]

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 76c342318..387255b8a 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c

[ ... ]

> @@ -75,6 +75,56 @@ __bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
>  	css_put(&memcg->css);
>  }
>
> +/**
> + * bpf_mem_cgroup_vm_events - Read memory cgroup's vm event counter
> + * @memcg: memory cgroup
> + * @event: event id
> + *
> + * Allows to read memory cgroup event counters.
> + */
> +__bpf_kfunc unsigned long bpf_mem_cgroup_vm_events(struct mem_cgroup *memcg,
> +						enum vm_event_item event)
> +{
> +	return memcg_events(memcg, event);
> +}
> +
> +/**
> + * bpf_mem_cgroup_usage - Read memory cgroup's usage
> + * @memcg: memory cgroup
> + *
> + * Returns current memory cgroup size in bytes.
> + */
> +__bpf_kfunc unsigned long bpf_mem_cgroup_usage(struct mem_cgroup *memcg)
> +{
> +	return page_counter_read(&memcg->memory);
> +}
     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The documentation says this returns bytes, but page_counter_read() returns
pages. In mm/memcontrol-v1.c, the existing mem_cgroup_usage() function's
return value is multiplied by PAGE_SIZE to convert to bytes:

    return (u64)mem_cgroup_usage(memcg, false) * PAGE_SIZE;

Should this function multiply the result by PAGE_SIZE to match its
documentation, or should the documentation be updated to say it returns
pages?

> +
> +/**
> + * bpf_mem_cgroup_page_state - Read memory cgroup's page state counter
> + * @memcg: memory cgroup
> + * @idx: counter idx
> + *
> + * Allows to read memory cgroup statistics. The output is in bytes.
> + */
> +__bpf_kfunc unsigned long bpf_mem_cgroup_page_state(struct mem_cgroup *memcg, int idx)
> +{
> +	if (idx < 0 || idx >= MEMCG_NR_STAT)
> +		return (unsigned long)-1;
> +
> +	return memcg_page_state_output(memcg, idx);
> +}

[ ... ]


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `mm: introduce BPF kfuncs to access memcg statistics and events`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18859027430

--===============4920457427699144756==--

