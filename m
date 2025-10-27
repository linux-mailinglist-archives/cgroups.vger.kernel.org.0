Return-Path: <cgroups+bounces-11235-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C72C121D5
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 00:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C3EB4F39B5
	for <lists+cgroups@lfdr.de>; Mon, 27 Oct 2025 23:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F56930F95F;
	Mon, 27 Oct 2025 23:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="el+rZW6Y"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29932E7F29;
	Mon, 27 Oct 2025 23:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761609439; cv=none; b=W81ngmX5/ahf/DfQDiI6VEOBXxfUzcKqJkTq71z4qas2XzbEOMVc+BLK0q1cGdI742Xz10vYpplE5fyVdYPDdHKMeCKK0AWacROhMwgduyvyKEvKoOm5Elq13hq66jtCQv7C76ZyOmAcKFYsvr9SSSwagVTuybYQjkpMO/I/nyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761609439; c=relaxed/simple;
	bh=hHcSm05XIBBgOwCK09Y1TkRueDxudZm+Q2Tyf5+OBPs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Fw5kLV26ycCTeTZYnKbg3voD3zubI/cCA1jJ36/nKAr/n3Qtm7qKoogMCenz+/3OyB+Jv4+1lhvNTV0/nCOLF8lwVQdOQmnVn+oDvOM9bwa+cA6kpm+4PVuiKEMLh1ZO9onG9cCVBdC9HzT6Qk/0MzvBv91mSFN0phHUGtQUEIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=el+rZW6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD325C4CEF1;
	Mon, 27 Oct 2025 23:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761609439;
	bh=hHcSm05XIBBgOwCK09Y1TkRueDxudZm+Q2Tyf5+OBPs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=el+rZW6YqdjguTckqMm+T3D5I6sRSJ8xSvE0a+JkE+h/lOLW6oWVRVnLsS7RtSsnm
	 pgXzeawehSw76pOhKlUKPjIQyqaw8DYGm9rv+r+3/1OytvT23lHy5GnTLPHh0nr/wV
	 /Oz2t4eG4ujYjfVPTyHllGTs+dGVdTe90QznEkEp6TxttLKf82VjA3A7+oPmOi7qKv
	 ASU7WmwBtdF3fQvraeecaEkD5fTaz1Xtwso6lyOcb4x+JQF31Ic2WAtQmvr7G7DjV5
	 hnKWQIpQUmLHM8yLvJ1fLJBI76a9GoZhX39bwNlBcVnj8YOkwd15Tzp+n6c/h8InHJ
	 d3Chi/NEyYjLA==
Content-Type: multipart/mixed; boundary="===============5183752388224874090=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <29c2837ee641cb1cb0ce3bbdd3a597d9488c04eb838ffe19902c9461a4d282a2@mail.kernel.org>
In-Reply-To: <20251027231727.472628-7-roman.gushchin@linux.dev>
References: <20251027231727.472628-7-roman.gushchin@linux.dev>
Subject: Re: [PATCH v2 06/23] mm: introduce BPF struct ops for OOM handling
From: bot+bpf-ci@kernel.org
To: roman.gushchin@linux.dev,akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,ast@kernel.org,surenb@google.com,mhocko@kernel.org,shakeel.butt@linux.dev,hannes@cmpxchg.org,andrii@kernel.org,inwardvessel@gmail.com,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,martin.lau@kernel.org,song@kernel.org,memxor@gmail.com,tj@kernel.org,roman.gushchin@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 27 Oct 2025 23:57:17 +0000 (UTC)

--===============5183752388224874090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit 16c40fd36bbe32c63f44388b5613db55c6b27557
Author: Roman Gushchin <roman.gushchin@linux.dev>

mm: introduce BPF struct ops for OOM handling

This patch introduces a BPF struct ops mechanism for custom OOM handling
policies. It allows attaching bpf_oom_ops system-wide or per-memcg, with
handlers executed before the kernel OOM killer.

> diff --git a/mm/bpf_oom.c b/mm/bpf_oom.c
> new file mode 100644
> index 000000000..c4d09ed9d
> --- /dev/null
> +++ b/mm/bpf_oom.c

[ ... ]

> @@ -0,0 +1,272 @@

[ ... ]

> +static void bpf_oom_ops_unreg(void *kdata, struct bpf_link *link)
> +{
> +	struct bpf_struct_ops_link *ops_link = container_of(link, struct bpf_struct_ops_link, link);
> +	struct bpf_oom_ops **bpf_oom_ops_ptr = NULL;
> +	struct bpf_oom_ops *bpf_oom_ops = kdata;
> +	struct mem_cgroup *memcg = NULL;
> +
> +	if (IS_ENABLED(CONFIG_MEMCG) && ops_link->cgroup_id) {
> +		/* Detach from a memory cgroup? */
> +		memcg = mem_cgroup_get_from_ino(ops_link->cgroup_id);
> +		if (IS_ERR_OR_NULL(memcg))
> +			goto exit;
> +		bpf_oom_ops_ptr = bpf_oom_memcg_ops_ptr(memcg);
> +	} else {
> +		/* System-wide OOM handler */
> +		bpf_oom_ops_ptr = &system_bpf_oom;
> +	}
> +
> +	/* Hide bpf_oom_ops from new callers */
> +	if (!WARN_ON(READ_ONCE(*bpf_oom_ops_ptr) != bpf_oom_ops))
> +		WRITE_ONCE(*bpf_oom_ops_ptr, NULL);
> +
> +	mem_cgroup_put(memcg);
> +
> +exit:
> +	/* Release bpf_oom_ops after a srcu grace period */
> +	synchronize_srcu(&bpf_oom_srcu);
> +}
> +
> +#ifdef CONFIG_MEMCG
> +void bpf_oom_memcg_offline(struct mem_cgroup *memcg)
> +{
> +	struct bpf_oom_ops *bpf_oom_ops;
> +	struct bpf_oom_ctx exec_ctx;
> +	u64 cgrp_id;
> +	int idx;
> +
> +	/* All bpf_oom_ops structures are protected using bpf_oom_srcu */
> +	idx = srcu_read_lock(&bpf_oom_srcu);
> +
> +	bpf_oom_ops = READ_ONCE(memcg->bpf_oom);
> +	WRITE_ONCE(memcg->bpf_oom, NULL);

Can bpf_oom_ops_unreg() race with bpf_oom_memcg_offline()? If userspace
closes the BPF struct ops link FD while or after the cgroup is being
deleted, both functions could run concurrently on the same memcg:

  Thread 1 (unreg):                Thread 2 (offline):
  mem_cgroup_get_from_ino()
  [succeeds, cgroup exists]
                                   srcu_read_lock()
                                   READ_ONCE(memcg->bpf_oom) [gets ops]
                                   WRITE_ONCE(memcg->bpf_oom, NULL)
  READ_ONCE(*bpf_oom_ops_ptr)
  [sees NULL]
  WARN_ON() triggers

The WARN_ON in bpf_oom_ops_unreg() assumes *bpf_oom_ops_ptr matches
bpf_oom_ops, but bpf_oom_memcg_offline() can clear it first during
concurrent execution.

> +
> +	if (bpf_oom_ops && bpf_oom_ops->handle_cgroup_offline) {
> +		cgrp_id = cgroup_id(memcg->css.cgroup);
> +		exec_ctx.cgroup_id = cgrp_id;
> +		bpf_oom_ops->handle_cgroup_offline(&exec_ctx, cgrp_id);
> +	}
> +
> +	srcu_read_unlock(&bpf_oom_srcu, idx);
> +}
> +#endif /* CONFIG_MEMCG */

[ ... ]


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `mm: introduce BPF struct ops for OOM handling`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18859027430

--===============5183752388224874090==--

