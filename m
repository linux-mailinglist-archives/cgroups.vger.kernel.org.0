Return-Path: <cgroups+bounces-16281-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WH8jKEsRFWr/SQcAu9opvQ
	(envelope-from <cgroups+bounces-16281-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 05:19:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F625D04CC
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 05:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90CAE301904E
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 03:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9453B27C8;
	Tue, 26 May 2026 03:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frFLxUh8"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D87C212F89;
	Tue, 26 May 2026 03:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779765572; cv=none; b=B1Juzfur3re3UwFPAL5Ij0557cJj9KWa4TZp0LHnT3k/mDZVRY4uU1EW3kTtMj+66/WEhSAYPTBji7hnwS60IqnTuQOFfsHSaogvhl20CcqdsEgAaCrlWec6Y/iDJWP8iWLd7V1TYgwYEZxczAHC+3aqDynsHKQR7rPQ8BHyIvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779765572; c=relaxed/simple;
	bh=V/tb5JgA/bpBVVMSYRwve2w8VAz7UopJuczhrszjC9s=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=sBijqwuhGxFJryWK+rmYkJCIK0QlnfE3nGYF+MyGo6DNX7EL/Qt9/Gh2cCnRHgjjBnezUDGpjNzqJLNl6kxYjCoJi8ZllzbHO9wpOCC9iRJhiXlubT4565UHqngkkS2OrM3Y05v7Yjn+2o261mK+ZuMOILepu2XPFB320KU6yfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frFLxUh8 reason="signature verification failed"; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D4A1F000E9;
	Tue, 26 May 2026 03:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779765570;
	bh=6nbBC8vyj2Y+oXRjDt4yU5hJnRR2glUHyIArPgLoD08=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=frFLxUh8yMsVt23Y3d60siTdXO4DsUns5PhQ5LTsLBHJ/I/xpfQ2g3I2bh8fOHugA
	 6JYUHl9S0cwQB9tk5dhTS0mS+wUQxz0tYz6t/uTbffgV1o+km1cwpZJeUOpr0znWiS
	 tvanztLgtZc4PdlEVNHqiwvNRSLOvYcy/Kdw0PSK/0D5p9Xw+RSVglDpFaShcK7qbC
	 QsfoFUlj84vYpb5ifwY3RFZiclwUR1yESOzL/Z8C/C+MjdFYhC0WUdApmr1hLfZJJC
	 MqiNDfPDu/KeKcM65s0tj83BnVlEzctCv3LKoBGZO2DDX/b5u6Ha4oS68R2zmO0MsP
	 z9L6Lcal0wQdA==
Content-Type: multipart/mixed; boundary="===============4389585652716092272=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a8c67f28d82471f8f6ee6d7d1d8a1385b1a2546d0ef60986ff80a0ea9b436d09@mail.kernel.org>
In-Reply-To: <9e081d01a0708dcdd101af7f7bede07cf43ca21d.1779760876.git.zhuhui@kylinos.cn>
References: <9e081d01a0708dcdd101af7f7bede07cf43ca21d.1779760876.git.zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH bpf-next v7 06/11] mm: memcontrol: Add BPF struct_ops for memory controller
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, jolsa@kernel.org, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, inwardvessel@gmail.com,
	akpm@linux-foundation.org, shuah@kernel.org, davem@davemloft.net,
	kuba@kernel.org, hawk@kernel.org, sdf@fomichev.me,
	kpsingh@kernel.org, chen.dylane@linux.dev, yatsenko@meta.com,
	leon.hwang@linux.dev, a.s.protopopov@gmail.com, ameryhung@gmail.com,
	tklauser@distanz.ch, eyal.birger@gmail.com, rongtao@cestc.cn,
	haoluo@google.com, peterz@infradead.org, ojeda@kernel.org,
	nathan@kernel.org, kees@kernel.org, tj@kernel.org,
	jeffxu@chromium.org, mkoutny@suse.com, kernel@jfarr.cc,
	brauner@kernel.org, rdunlap@infradead.org, brgerst@gmail.com,
	masahiroy@kernel.org, willemb@google.com, kerneljasonxing@gmail.com,
	paul.chaignon@gmail.com, chenridong@huaweicloud.com,
	lance.yang@linux.dev, jiayu@web.codeaurora.org, an.chen@linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: geliang@kernel.org,baohua@kernel.org,zhuhui@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 26 May 2026 03:19:29 +0000 (UTC)
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,kylinos.cn,iogearbox.net,gmail.com,linux.dev,meta.com];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20260515];
	TAGGED_FROM(0.00)[bounces-16281-lists,cgroups=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_TO(0.00)[linux.dev,kernel.org,iogearbox.net,gmail.com,cmpxchg.org,linux-foundation.org,davemloft.net,fomichev.me,meta.com,distanz.ch,cestc.cn,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,huaweicloud.com,web.codeaurora.org,vger.kernel.org,kvack.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:-];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+];
	RCPT_COUNT_GT_50(0.00)[69];
	NEURAL_HAM(-0.00)[-0.781];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.kernel.org:mid]
X-Rspamd-Queue-Id: 46F625D04CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============4389585652716092272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 716df49d7647..1f726a7b22e3 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c

[ ... ]

> +/* Unregister the struct ops instance */
> +static void bpf_memcg_ops_unreg(void *kdata, struct bpf_link *link)
> +{
> +	struct bpf_struct_ops_link *ops_link;
> +	struct memcg_bpf_ops *ops = kdata;
> +	struct cgroup_subsys_state *css;
> +	struct mem_cgroup *memcg;
> +	struct mem_cgroup *iter;
> +	struct memcg_bpf_ops *parent_bpf_ops = NULL;
> +	u32 parent_bpf_ops_flags = 0;
> +
> +	if (!link)
> +		return;
> +	ops_link = container_of(link, struct bpf_struct_ops_link, link);
> +	if (!ops_link->cgroup)
> +		return;

Can this early return skip a required synchronize_srcu(&memcg_bpf_srcu)?

When a cgroup that owns a memcg_bpf_ops link is destroyed,
cgroup_bpf_release() takes cgroup_mutex, splices the struct_ops_links,
sets st_link->cgroup = NULL, drops cgroup_mutex, and then calls
link->ops->detach() outside the mutex.  detach()
(bpf_struct_ops_map_link_detach) invokes unreg() with link->cgroup
already NULL, which hits this early return:

	if (!ops_link->cgroup)
		return;

At that point descendants of the destroyed cgroup still hold
memcg->bpf_ops pointing at the registered ops (kdata).  Memcgs in that
subtree are not freed immediately because folios pin them via
folio->memcg_data after offline, and uncharge paths
(memcg_uncharge() -> bpf_memcg_uncharged()) keep dereferencing those
memcgs.

bpf_memcg_uncharged()/bpf_memcg_charged() use the BPF_MEMCG_CALL macros,
which take srcu_read_lock(&memcg_bpf_srcu), READ_ONCE(memcg->bpf_ops),
and then dereference __ops->op.  After unreg() returns, the
bpf_struct_ops infrastructure eventually frees kdata via
bpf_struct_ops_map_free(), which calls
synchronize_rcu_mult(call_rcu, call_rcu_tasks) and waits only for
classic RCU and RCU-tasks grace periods, not SRCU.

If the unreg() path returns without calling
synchronize_srcu(&memcg_bpf_srcu), can an SRCU reader holding a pointer
into the about-to-be-freed kdata observe a use-after-free when invoking
__ops->op()?

Would moving the synchronize_srcu(&memcg_bpf_srcu) call so it runs on
both early-return paths (or unconditionally before returning) be
appropriate here?  The other early return (link == NULL) looks benign
because reg() returns -EOPNOTSUPP for link == NULL and never writes any
memcg->bpf_ops, so no synchronize is required on that path.

> +	cgroup_lock();
> +
> +	css = cgroup_e_css(ops_link->cgroup, &memory_cgrp_subsys);
> +	if (!css)
> +		goto unlock_out;
> +	memcg = mem_cgroup_from_css(css);
> +
> +	/* Get the parent bpf_ops and bpf_ops_flags */
> +	iter = parent_mem_cgroup(memcg);
> +	if (iter) {
> +		parent_bpf_ops = READ_ONCE(iter->bpf_ops);
> +		parent_bpf_ops_flags = iter->bpf_ops_flags;
> +	}
> +
> +	iter = NULL;
> +	while ((iter = mem_cgroup_iter(memcg, iter, NULL))) {
> +		if (READ_ONCE(iter->bpf_ops) == ops) {
> +			WRITE_ONCE(iter->bpf_ops, parent_bpf_ops);
> +			iter->bpf_ops_flags = parent_bpf_ops_flags;
> +		}
> +	}
> +
> +unlock_out:
> +	cgroup_unlock();
> +	synchronize_srcu(&memcg_bpf_srcu);
> +}

[ ... ]

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 749c128b4fad..3494f36d792d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c

[ ... ]

> @@ -2516,11 +2522,15 @@ void __mem_cgroup_handle_over_high(gfp_t gfp_mask)
>  	 * memory.high is breached and reclaim is unable to keep up. Throttle
>  	 * allocators proactively to slow down excessive growth.
>  	 */
> -	penalty_jiffies = calculate_high_delay(memcg, nr_pages,
> -					       mem_find_max_overage(memcg));
> +	if (nr_pages) {
> +		penalty_jiffies = calculate_high_delay(
> +			memcg, nr_pages, mem_find_max_overage(memcg));
>
> -	penalty_jiffies += calculate_high_delay(memcg, nr_pages,
> -						swap_find_max_overage(memcg));
> +		penalty_jiffies += calculate_high_delay(
> +			memcg, nr_pages, swap_find_max_overage(memcg));
> +	} else
> +		penalty_jiffies = 0;
> +	penalty_jiffies = max(penalty_jiffies, bpf_high_delay);

This isn't a bug, but the if/else here mixes braced and unbraced
branches.  Documentation/process/coding-style.rst (Placing Braces and
Spaces) asks that when one arm of an if/else uses braces, the other arm
use them too.  Would something like the following be preferable, and
quiet checkpatch.pl?

	if (nr_pages) {
		penalty_jiffies = calculate_high_delay(
			memcg, nr_pages, mem_find_max_overage(memcg));

		penalty_jiffies += calculate_high_delay(
			memcg, nr_pages, swap_find_max_overage(memcg));
	} else {
		penalty_jiffies = 0;
	}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26429228214
--===============4389585652716092272==--

