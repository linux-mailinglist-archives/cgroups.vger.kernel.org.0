Return-Path: <cgroups+bounces-13401-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Ck6GIRAc2mWtwAAu9opvQ
	(envelope-from <cgroups+bounces-13401-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 10:33:56 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C711B736FC
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 10:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E9A0306EA06
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 09:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9E036EAAD;
	Fri, 23 Jan 2026 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+Da/JIQ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6CF34DCFD;
	Fri, 23 Jan 2026 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769160587; cv=none; b=Tgn+/pHPpsdUfASbZGDPr/S43re+vUOvY70iAVkkLnAzW6JL4HfrKTXnivMjlkNdsPV3R/+741aVNrsC1uY1IycByg4NDQxUk6dpNGxCL8g8IlsrjcvbmkAlFUH83RkKzB4SXXRqvq9UeYzEpIsSRtLxhq4xAyIBdn2s9x3sax0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769160587; c=relaxed/simple;
	bh=66bJXTJk22/mLio1RAI3vsCprk6nUWyXhsTyMDG/6mE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MiAFttJFAawC/GSuHY5aDyTWZn2Nwx/aOVH65tVPoA3o1pOElVzXh/OZgWecHuEhWuvwj/YWLvLNn2MCDXQnWssvRxocafgM8ovyFkD4Rekq+9NlEvgptgz7h+M55LsJbjAifaqNENVEdj0AIybfV7CgKH1iriaeMXNPgY/KtHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+Da/JIQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FCBC116D0;
	Fri, 23 Jan 2026 09:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769160586;
	bh=66bJXTJk22/mLio1RAI3vsCprk6nUWyXhsTyMDG/6mE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=P+Da/JIQVUBFdjvtmkdMKF6CSdvIICA7ZvyHGDVa0wEg3lX968hjg0HzrYc1dY9cA
	 82tsjt/LJncXYHEM2ytyit/TamThZnQoqQWOkSPiXqwMwEOd95l9wxc7pAMiFHADfW
	 IRvr+kW47fQvxH1kFQYIjm014r0sqN7WBVhN4uZkELWsf/oHqk20Y/N2OvivUjNqFW
	 qLXomYcSYWhPgCanwfxrYY8n+ltGd22kDDkB+GOg3v5314j4lfZ078NboWEMtZi0Z4
	 JIHHi+hqh0o0zsdkduLL6j+/y9vYhEchxkVHpomNftsBShx6bQ+Q4Fp+DHNRriZ28d
	 ruoT8dTtoWs2A==
Content-Type: multipart/mixed; boundary="===============7258097213843698012=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f02212613904023c5e4f900ee1efdb15e8266c3c4f7d0572db4f515da3a700e5@mail.kernel.org>
In-Reply-To: <863b91cb85097f137bc741e7cb686ff78d9bb95e.1769157382.git.zhuhui@kylinos.cn>
References: <863b91cb85097f137bc741e7cb686ff78d9bb95e.1769157382.git.zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH bpf-next v3 08/12] mm: memcontrol: Add BPF struct_ops for memory controller
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,akpm@linux-foundation.org,hannes@cmpxchg.org,mhocko@kernel.org,roman.gushchin@linux.dev,shakeel.butt@linux.dev,muchun.song@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,peterz@infradead.org,ojeda@kernel.org,nathan@kernel.org,kees@kernel.org,tj@kernel.org,jeffxu@chromium.org,mkoutny@suse.com,kernel@jfarr.cc,brauner@kernel.org,rdunlap@infradead.org,brgerst@gmail.com,masahiroy@kernel.org,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,inwardvessel@gmail.com,willemb@google.com,kerneljasonxing@gmail.com,paul.chaignon@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,chenridong@huaweicloud.com,lance.yang@linux.dev,jiayuan.chen@linux.dev,linux-kernel@vger.kernel.org,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,linu
 x-kselftest@vger.kernel.org
Cc: zhuhui@kylinos.cn,geliang@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 23 Jan 2026 09:29:45 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,cgroups@vger.kernel.org];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	TAGGED_FROM(0.00)[bounces-13401-lists,cgroups=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kylinos.cn,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	FREEMAIL_TO(0.00)[linux.dev,linux-foundation.org,cmpxchg.org,kernel.org,iogearbox.net,gmail.com,fomichev.me,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,davemloft.net,huaweicloud.com,vger.kernel.org,kvack.org];
	NEURAL_SPAM(0.00)[0.887];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	RCPT_COUNT_GT_50(0.00)[60];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C711B736FC
X-Rspamd-Action: no action

--===============7258097213843698012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index f3b8c71870d8..d71e86b85ba7 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h

[ ... ]

> +#else /* CONFIG_BPF_SYSCALL */
> +
> +static inline unsigned long
> +bpf_memcg_get_high_delay(struct mem_cgroup *memcg) { return 0 }
> +static inline bpf_memcg_below_low(struct mem_cgroup *memcg) { return false }
> +static inline bpf_memcg_below_min(struct mem_cgroup *memcg) { return false }
                 ^^^^^^^^^^^^^^^^^^^^

These stub functions appear to have syntax issues that would prevent
compilation when CONFIG_BPF_SYSCALL is disabled:

1. bpf_memcg_get_high_delay() is missing a semicolon after "return 0"
2. bpf_memcg_below_low() is missing the "bool" return type
3. bpf_memcg_below_min() is missing the "bool" return type

Should these be:

  static inline unsigned long
  bpf_memcg_get_high_delay(struct mem_cgroup *memcg) { return 0; }
  static inline bool bpf_memcg_below_low(struct mem_cgroup *memcg) { return false; }
  static inline bool bpf_memcg_below_min(struct mem_cgroup *memcg) { return false; }

> +static inline void memcontrol_bpf_online(struct mem_cgroup *memcg) { }
> +static inline void memcontrol_bpf_offline(struct mem_cgroup *memcg) { }
> +
> +#endif /* CONFIG_BPF_SYSCALL */

[ ... ]

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 716df49d7647..415e3c59b6a6 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c

[ ... ]

> +static void clean_memcg_bpf_ops(struct mem_cgroup *memcg,
> +				struct memcg_bpf_ops *ops)
> +{
> +	struct mem_cgroup *iter = NULL;
> +
> +	while ((iter = mem_cgroup_iter(memcg, iter, NULL))) {
> +		if (ops) {
> +			if (!WARN_ON(READ_ONCE(memcg->bpf_ops) != ops))
> +				WRITE_ONCE(memcg->bpf_ops, NULL);
                                         ^^^^^

When ops is non-NULL, this code checks and writes to memcg->bpf_ops, but
should it be using iter->bpf_ops instead? The else branch at the bottom
correctly uses iter. As written, when called from bpf_memcg_ops_unreg()
with a non-NULL ops argument, this only clears the root cgroup's bpf_ops
pointer while leaving all descendant cgroups with stale pointers to the
ops structure that will be freed after synchronize_srcu().

> +		} else
> +			WRITE_ONCE(iter->bpf_ops, NULL);
> +	}
> +}

[ ... ]

> +static int __init bpf_memcontrol_init(void)
> +{
> +	int err, err2;
> +
> +	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
> +					&bpf_memcontrol_kfunc_set);
> +	if (err)
> +		pr_warn("error while registering bpf memcontrol kfuncs: %d", err);
> +
> +	err2 = register_bpf_struct_ops(&bpf_memcg_bpf_ops, memcg_bpf_ops);
> +	if (err)
            ^^^

The condition here checks err but prints err2. Should this be "if (err2)"
to log when the struct_ops registration fails?

> +		pr_warn("error while registering memcontrol bpf ops: %d", err2);
> +
> +	return err ? err : err2;
> +}
> +late_initcall(bpf_memcontrol_init);

Note: The clean_memcg_bpf_ops() issue appears to be addressed in a later
commit in this series (90eaa9cd0346 "mm/bpf: Add BPF_F_ALLOW_OVERRIDE
support for memcg_bpf_ops") which removes and rewrites the function
entirely. However, the syntax errors in the stubs and the error check
typo in bpf_memcontrol_init() do not appear to be fixed in the series.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21280790825

--===============7258097213843698012==--

