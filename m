Return-Path: <cgroups+bounces-11227-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 506DCC1217E
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 00:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0386242561A
	for <lists+cgroups@lfdr.de>; Mon, 27 Oct 2025 23:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A6C30F95F;
	Mon, 27 Oct 2025 23:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ks2vehgv"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0CA2F616A;
	Mon, 27 Oct 2025 23:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761608891; cv=none; b=arM+U3kewhsrJ+d+KvXuFQT+p40Kk6y/tTa2uaLji/K4XKkpcagdqkomEXFKCSSQ2iNyvSqfcX6DsF8Ght6MazDm+w5xuROBRAmE0lWhavAniGoE2R1rU+EwbvRGUZD8jG7IIlEoYKWWeV7hjBEyLjdD/l9JWFvlWKFU0z3hSGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761608891; c=relaxed/simple;
	bh=mokQ459eH608y3YAxdf7XicrEDOCujpMlCAdC1dG4dE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=h8myhfDLSbWSxxjmF1s/jOSr730mFDumiXS2KROCbRKjEMEu2d4Q37gaU2DalGWjHOoOxpMu7hmmxvZ4ILpSf2KJEfnkN1hxTxiM+/TFJkBy6qV/Ojx/DftEeXZ0CgJWfbgMUD1b6bxALGlptneqfjcHQBnq7pn2L36Wr08rvA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ks2vehgv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9E1C4CEF1;
	Mon, 27 Oct 2025 23:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761608889;
	bh=mokQ459eH608y3YAxdf7XicrEDOCujpMlCAdC1dG4dE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Ks2vehgvD+K331IgMpd34Fj/yzi7Px2UQNNzLRN9tGjZdamoYzPL+4uNqaRDPGMCs
	 Oca4pwYxqbSp2o9sIenB4x9Y5SkrSp/JTqDjCBjBkR8x7S+x79GtVMByn2AwcsyzX1
	 ag9bLXYgIeu5cDFY0NTsMKNUPv/5gvxvWzpJT9AuJZ52qZ4Z4jJpW/Ve5tYoKPjJPh
	 joUnF8BgVQlznUBrfU/m5pu4LOlPKS8B+nt0A0VvrzCGAVbPjtd3cVng33pjME0gEK
	 OzLATd0saTLE4jssY6XaWMCDvGNuw7y31SaR7tsKahBjzCXqut4fR8Fj27X1EA/eZq
	 TYVyLPpK+KgLg==
Content-Type: multipart/mixed; boundary="===============0101190093044867176=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0bb955784824863853d84e4b2fa96c81e3a0dd034b1705bbbbc452f8e4dd27b2@mail.kernel.org>
In-Reply-To: <20251027232206.473085-10-roman.gushchin@linux.dev>
References: <20251027232206.473085-10-roman.gushchin@linux.dev>
Subject: Re: [PATCH v2 20/23] sched: psi: implement bpf_psi struct ops
From: bot+bpf-ci@kernel.org
To: roman.gushchin@linux.dev,akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,ast@kernel.org,surenb@google.com,mhocko@kernel.org,shakeel.butt@linux.dev,hannes@cmpxchg.org,andrii@kernel.org,inwardvessel@gmail.com,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,martin.lau@kernel.org,song@kernel.org,memxor@gmail.com,tj@kernel.org,roman.gushchin@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 27 Oct 2025 23:48:07 +0000 (UTC)

--===============0101190093044867176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit 264db34cd79e7c07b4b1e58e2efae3d632df9cb2
Author: Roman Gushchin <roman.gushchin@linux.dev>

sched: psi: implement bpf_psi struct ops

This patch implements a BPF struct ops-based mechanism to create PSI
triggers, attach them to cgroups or system wide and handle PSI events
in BPF.

> diff --git a/kernel/sched/bpf_psi.c b/kernel/sched/bpf_psi.c
> new file mode 100644
> index 000000000..c383a2011
> --- /dev/null
> +++ b/kernel/sched/bpf_psi.c

[ ... ]

> +void bpf_psi_cgroup_offline(struct cgroup *cgroup)
> +{
> +	struct psi_group *group = cgroup->psi;
> +	u64 cgrp_id = cgroup_id(cgroup);
> +	struct psi_trigger *t, *p;
> +	struct bpf_psi *bpf_psi;
> +	LIST_HEAD(to_destroy);
> +	int idx;
> +
> +	if (!group)
> +		return;
> +
> +	spin_lock(&group->bpf_triggers_lock);
> +	list_for_each_entry_safe(t, p, &group->bpf_triggers, bpf_group_node) {
> +		if (!t->pinned) {
> +			t->pinned = true;
> +			list_move(&t->bpf_group_node, &to_destroy);
> +		}
> +	}
> +	spin_unlock(&group->bpf_triggers_lock);
> +
> +	list_for_each_entry_safe(t, p, &to_destroy, bpf_group_node) {
> +		bpf_psi = READ_ONCE(t->bpf_psi);
> +
> +		idx = srcu_read_lock(&bpf_psi->srcu);
> +		if (bpf_psi->ops->handle_cgroup_offline)
> +			bpf_psi->ops->handle_cgroup_offline(bpf_psi, cgrp_id);
> +		srcu_read_unlock(&bpf_psi->srcu, idx);
> +
> +		spin_lock(&bpf_psi->lock);
> +		list_del(&t->bpf_psi_node);
> +		spin_unlock(&bpf_psi->lock);
> +
> +		WRITE_ONCE(t->bpf_psi, NULL);
> +		flush_workqueue(bpf_psi_wq);
> +		synchronize_srcu(&bpf_psi->srcu);
> +		psi_trigger_destroy(t);
> +	}
> +}

Can bpf_psi_cgroup_offline() race with bpf_psi_ops_unreg() and access
freed memory?

Consider this sequence:

Thread A (bpf_psi_cgroup_offline):
  - Pins triggers under group->bpf_triggers_lock
  - Reads bpf_psi = READ_ONCE(t->bpf_psi) outside any lock

Thread B (bpf_psi_ops_unreg):
  - Iterates bpf_psi->triggers, skips pinned triggers
  - Calls synchronize_srcu(&bpf_psi->srcu)
  - Calls kfree(bpf_psi)

Thread A:
  - Tries srcu_read_lock(&bpf_psi->srcu) on freed memory

The pinning mechanism prevents Thread B from NULLing t->bpf_psi when
Thread A has pinned the trigger. However, Thread B unconditionally
frees the bpf_psi object itself even when it didn't process any
triggers because they were all pinned by Thread A.

After Thread A pins all triggers and releases group->bpf_triggers_lock,
Thread B can complete bpf_psi_ops_unreg(), call synchronize_srcu() (no
readers yet), and free bpf_psi. Then Thread A accesses the freed
bpf_psi via srcu_read_lock() and spin_lock().

> +static void bpf_psi_ops_unreg(void *kdata, struct bpf_link *link)
> +{
> +	struct bpf_psi_ops *ops = kdata;
> +	struct bpf_psi *bpf_psi = ops->bpf_psi;
> +	struct psi_trigger *t, *p;
> +	LIST_HEAD(to_destroy);
> +
> +	spin_lock(&bpf_psi->lock);
> +	list_for_each_entry_safe(t, p, &bpf_psi->triggers, bpf_psi_node) {
> +		spin_lock(&t->group->bpf_triggers_lock);
> +		if (!t->pinned) {
> +			t->pinned = true;
> +			list_move(&t->bpf_group_node, &to_destroy);
> +			list_del(&t->bpf_psi_node);
> +
> +			WRITE_ONCE(t->bpf_psi, NULL);
> +		}
> +		spin_unlock(&t->group->bpf_triggers_lock);
> +	}
> +	spin_unlock(&bpf_psi->lock);
> +
> +	flush_workqueue(bpf_psi_wq);
> +	synchronize_srcu(&bpf_psi->srcu);
> +
> +	list_for_each_entry_safe(t, p, &to_destroy, bpf_group_node)
> +		psi_trigger_destroy(t);
> +
> +	if (!list_empty(&bpf_psi->node)) {
> +		mutex_lock(&bpf_psi_lock);
> +		list_del(&bpf_psi->node);
> +		mutex_unlock(&bpf_psi_lock);
> +		static_branch_dec(&bpf_psi_notify_key);
> +	}
> +
> +	cleanup_srcu_struct(&bpf_psi->srcu);
> +	kfree(bpf_psi);
> +}

When bpf_psi_ops_unreg() skips all triggers because they're pinned
(by bpf_psi_cgroup_offline()), does it still free bpf_psi too early?

The to_destroy list will be empty if all triggers were pinned, but
the function still proceeds to cleanup_srcu_struct() and kfree(bpf_psi)
while bpf_psi_cgroup_offline() may be using that bpf_psi pointer.


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `sched: psi: implement bpf_psi struct ops`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18859027430

--===============0101190093044867176==--

