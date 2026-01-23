Return-Path: <cgroups+bounces-13400-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFofIitAc2m0twAAu9opvQ
	(envelope-from <cgroups+bounces-13400-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 10:32:27 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCF17368A
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 10:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C43DC3065E74
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 09:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9F036AB53;
	Fri, 23 Jan 2026 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4nwAcHu"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3369935CBA7;
	Fri, 23 Jan 2026 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769160585; cv=none; b=LHiJSD3Gob+r5JX9zETb/awZSr2ea/ZK2ZEDUS1ksZ+hzzmKUC2X5URcw5IfGlIHpTq/tDu4rbQllC7mVM+I6Y7LANrojWQ3kcqMu5OjjcSHYAI9i1PRW04zmy6RVDtjG8CgrBBJHkP5V5Fex/vy7Rl2L0ebm48tSBAYOfqxTEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769160585; c=relaxed/simple;
	bh=UyNyhPZNlArXXC7DbgAjDuFCRG6qfF3Bxd1E4/+otZQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Dh523JGo0n+bew7FNcysg2vc1aZDalWamyBmQM94M5BkypMKgUTzfY5mDa36DRxj0nbyW9z6EoC1N2Kj9GMr7tK2PK5yHOhMoWUDfav9DyMhggsN0r0Rs8CCw1fhyY8rnFqqhsf2NK/2sHsQwY9apJkZP0kc6tKXg7A9Rf2NFHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4nwAcHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B97AC116D0;
	Fri, 23 Jan 2026 09:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769160584;
	bh=UyNyhPZNlArXXC7DbgAjDuFCRG6qfF3Bxd1E4/+otZQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=F4nwAcHuuogXfFilu9ZLMVOGjf65Q6kn1NjG9xHyDQjxcKw8mechHmV/2UoKNz9eX
	 yJdAhjb8zATwBjMJEYORx1exA7ugxyGbFhiybcChfKths7LymkhEC8uUfdVAqQ+Cnk
	 /o1gx/rRVWYfwSVJFVNyAAXiwr1O1zLo//uJpXLFBwn0PcbFklSM0Rpv0xAMtPn4j2
	 8YndREmYbf+pnDgoHlMqu3Gq3NgBZT0dv6A66E1CQjJOxJ8Zib3HFLfoE1BkDFnBx4
	 NoGBDqusxbltNqeA4KQjr/pVHZpn9vRTit7GBPlVxmcI/2vSzgNvZoaVTOpUcKsHcM
	 nAuh2eNSimJrg==
Content-Type: multipart/mixed; boundary="===============7572374899106477181=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d2161f4252546f252dd0a84c461ba5dbb3b63e22d4826771edd8f1f30df050bc@mail.kernel.org>
In-Reply-To: <9f072e53f79ceaea43e3730476494517e453530a.1769157382.git.zhuhui@kylinos.cn>
References: <9f072e53f79ceaea43e3730476494517e453530a.1769157382.git.zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH bpf-next v3 10/12] mm/bpf: Add BPF_F_ALLOW_OVERRIDE support for  memcg_bpf_ops
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,akpm@linux-foundation.org,hannes@cmpxchg.org,mhocko@kernel.org,roman.gushchin@linux.dev,shakeel.butt@linux.dev,muchun.song@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,peterz@infradead.org,ojeda@kernel.org,nathan@kernel.org,kees@kernel.org,tj@kernel.org,jeffxu@chromium.org,mkoutny@suse.com,kernel@jfarr.cc,brauner@kernel.org,rdunlap@infradead.org,brgerst@gmail.com,masahiroy@kernel.org,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,inwardvessel@gmail.com,willemb@google.com,kerneljasonxing@gmail.com,paul.chaignon@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,chenridong@huaweicloud.com,lance.yang@linux.dev,jiayuan.chen@linux.dev,linux-kernel@vger.kernel.org,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,linu
 x-kselftest@vger.kernel.org
Cc: zhuhui@kylinos.cn,geliang@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 23 Jan 2026 09:29:42 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,cgroups@vger.kernel.org];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	TAGGED_FROM(0.00)[bounces-13400-lists,cgroups=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kylinos.cn,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	FREEMAIL_TO(0.00)[linux.dev,linux-foundation.org,cmpxchg.org,kernel.org,iogearbox.net,gmail.com,fomichev.me,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,davemloft.net,huaweicloud.com,vger.kernel.org,kvack.org];
	NEURAL_SPAM(0.00)[0.871];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	RCPT_COUNT_GT_50(0.00)[60];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Queue-Id: 2FCF17368A
X-Rspamd-Action: no action

--===============7572374899106477181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 415e3c59b6a6..0ded1fdd0de8 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c

[ ... ]

> static int bpf_memcg_ops_reg(void *kdata, struct bpf_link *link)
> {
> 	struct bpf_struct_ops_link *ops_link
> 		= container_of(link, struct bpf_struct_ops_link, link);
> 	struct memcg_bpf_ops *ops = kdata;
> 	struct mem_cgroup *memcg, *iter = NULL;
> 	int err = 0;
>
> +	if (ops_link->flags & ~BPF_F_ALLOW_OVERRIDE) {
> +		pr_err("attach only support BPF_F_ALLOW_OVERRIDE\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> 	memcg = mem_cgroup_get_from_ino(ops_link->cgroup_id);
> 	if (IS_ERR_OR_NULL(memcg))
> 		return PTR_ERR(memcg);
>
> 	cgroup_lock();
> +
> +	if (READ_ONCE(memcg->bpf_ops)) {
> +		/* Check if bpf_ops of the parent is BPF_F_ALLOW_OVERRIDE. */
> +		if (memcg->bpf_ops_flags & BPF_F_ALLOW_OVERRIDE) {
> +			iter = parent_mem_cgroup(memcg);
> +
> +			if (!iter)
> +				goto busy_out;
> +			if (READ_ONCE(iter->bpf_ops) !=
> +			    READ_ONCE(memcg->bpf_ops))
> +				goto busy_out;
> +		} else {
> +busy_out:
> +			err = -EBUSY;
> +			goto unlock_out;
> +		}
> +	}
> +
> 	while ((iter = mem_cgroup_iter(memcg, iter, NULL))) {
                                      ^^^^

When the override check passes (all conditions at lines 363-377 are met),
iter is set to parent_mem_cgroup(memcg) but is never reset to NULL before
this loop. Should iter be reset to NULL here?

The mem_cgroup_iter() function expects prev (iter) to be either NULL or a
previous result from iterating within memcg's descendants. When iter points
to memcg's parent, the iteration will not correctly traverse memcg's
subtree since parent is outside that subtree.

For comparison, bpf_memcg_ops_unreg() correctly resets iter to NULL before
its loop:

> +	iter = NULL;
> +	while ((iter = mem_cgroup_iter(memcg, iter, NULL))) {

> 		if (READ_ONCE(iter->bpf_ops)) {
> -			mem_cgroup_iter_break(memcg, iter);
> -			err = -EBUSY;
> -			break;
> +			/* cannot override existing bpf_ops of sub-cgroup. */
> +			continue;
> 		}
> 		WRITE_ONCE(iter->bpf_ops, ops);
> +		iter->bpf_ops_flags = ops_link->flags;
> 	}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21280790825

--===============7572374899106477181==--

