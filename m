Return-Path: <cgroups+bounces-11234-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 502F1C121A7
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 00:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762B71A247F7
	for <lists+cgroups@lfdr.de>; Mon, 27 Oct 2025 23:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25E7334683;
	Mon, 27 Oct 2025 23:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPRqOgu4"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D7233031F;
	Mon, 27 Oct 2025 23:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761608914; cv=none; b=nF/24G9CDWyVualKT4X+edX+PgyTq5wS/3NDrXMX1LFh48Ni9T6NnP0g4ecr4nnPnoodSp3XfylZzQo3RQ9mPLDyHXrMqe+W4mPbY8M+tyEG6MOQ0RZe6tUeYu3bTPiuewmiQPDQl87TpvpD+j74R7eH5dBD241l25tbsO52KjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761608914; c=relaxed/simple;
	bh=MiWeawgOpWW6lFOdqjirFo9YOvPI6E0zLgwWGg50DDU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=W1ow9T/eeWZ53RmptiiaoxupmzsS1rvNxv/OXVICg5XtUf2nqwt8QjE9grVdS8b+0timQvINSB8uiNTB6X4+1mL6wqdg7AGsfY8FnqRBpK8tj4i0XWlEk+7u/PRmSZdRINa0knzkC4Z4npz1YrPeRjqTJrowShhRvzW1eerNr0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPRqOgu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9EDC4CEFB;
	Mon, 27 Oct 2025 23:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761608913;
	bh=MiWeawgOpWW6lFOdqjirFo9YOvPI6E0zLgwWGg50DDU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=tPRqOgu4RIvS+PCuXstq77PKbJCcZTI5NDGeUb2Ri6lQh9+Zg3OhtXbV36KT4GCDC
	 ZNXIX9KzTgnDmyCGDDRkhZR+HYPVAESYhT3w6XI6XJYTe/V5rmNE/9NV3z7nmICRaQ
	 hd0GVprCC4Jqh2NlnYyueau1DcA9bs5cyaY1JQbrFTBz/AYYlF9vqVue2TxqAG0wSr
	 ahmjwEfUtuwg+BPY+Z78MJJ+DvmKtM1HFGuCVj3whDLBfzvOrk6GGAA/L3EA0s5Ut4
	 +gzR9uDjRpC/PYPl8QhE73UxPDRgzvXLpNP2C1Zvqu3BRF6b3A9N6UgrSMybY/wvpP
	 BToA8bGIghCjg==
Content-Type: multipart/mixed; boundary="===============5262190113094449615=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <634e7371353c8466b3d0fa0dd7ceeaf17c8c4d7b274f4f7369d3094d22872cd6@mail.kernel.org>
In-Reply-To: <20251027232206.473085-4-roman.gushchin@linux.dev>
References: <20251027232206.473085-4-roman.gushchin@linux.dev>
Subject: Re: [PATCH v2 14/23] mm: allow specifying custom oom constraint for BPF triggers
From: bot+bpf-ci@kernel.org
To: roman.gushchin@linux.dev,akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,ast@kernel.org,surenb@google.com,mhocko@kernel.org,shakeel.butt@linux.dev,hannes@cmpxchg.org,andrii@kernel.org,inwardvessel@gmail.com,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,martin.lau@kernel.org,song@kernel.org,memxor@gmail.com,tj@kernel.org,roman.gushchin@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 27 Oct 2025 23:48:32 +0000 (UTC)

--===============5262190113094449615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit 5cd8d912032d2c2105c04660338cf4ad47d24697
Author: Roman Gushchin <roman.gushchin@linux.dev>

mm: allow specifying custom oom constraint for BPF triggers

This patch adds a new OOM constraint type CONSTRAINT_BPF and allows
BPF programs to specify a custom constraint name when calling
bpf_out_of_memory().

> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index 3cbdcd013..704fc0e78 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -19,6 +19,7 @@ enum oom_constraint {
>  	CONSTRAINT_CPUSET,
>  	CONSTRAINT_MEMORY_POLICY,
>  	CONSTRAINT_MEMCG,
> +	CONSTRAINT_BPF,
>  };
>
>  enum bpf_oom_flags {

[ ... ]

> @@ -63,6 +64,9 @@ struct oom_control {
>
>  	/* Policy name */
>  	const char *bpf_policy_name;
> +
> +	/* BPF-specific constraint name */
> +	const char *bpf_constraint;
>  #endif
>  };

[ ... ]

> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index d7fca4bf5..72a346261 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c

[ ... ]

> @@ -267,6 +281,9 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
>  	bool cpuset_limited = false;
>  	int nid;
>
> +	if (oc->constraint == CONSTRAINT_BPF)
> +		return CONSTRAINT_BPF;
> +
>  	if (is_memcg_oom(oc)) {
>  		oc->totalpages = mem_cgroup_get_max(oc->memcg) ?: 1;
>  		return CONSTRAINT_MEMCG;

[ ... ]

> @@ -1350,11 +1367,14 @@ __bpf_kfunc int bpf_oom_kill_process(struct oom_control *oc,
>   * Returns a negative value if an error occurred.
>   */
>  __bpf_kfunc int bpf_out_of_memory(struct mem_cgroup *memcg__nullable,
> -				  int order, u64 flags)
> +				  int order, u64 flags,
> +				  const char *constraint_text__nullable)
>  {
>  	struct oom_control oc = {
>  		.memcg = memcg__nullable,
>  		.order = order,
> +		.constraint = CONSTRAINT_BPF,
> +		.bpf_constraint = constraint_text__nullable,
>  	};
>  	int ret;

When CONSTRAINT_BPF is set in bpf_out_of_memory(), the early return in
constrained_alloc() prevents oc->totalpages from being initialized.  This
leaves totalpages at zero (from the designated initializer).

Later in the call chain out_of_memory()->select_bad_process()->
oom_evaluate_task()->oom_badness(), the code performs division by
totalpages at line 237:

    adj *= totalpages / 1000;

Can this cause a division by zero?  The path is reachable when a BPF
program calls bpf_out_of_memory() and either no BPF OOM handler is
registered or the handler fails to free memory, causing execution to fall
through to select_bad_process().


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `mm: allow specifying custom oom constraint for BPF triggers`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18859027430

--===============5262190113094449615==--

