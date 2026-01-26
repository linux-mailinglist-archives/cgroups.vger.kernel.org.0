Return-Path: <cgroups+bounces-13456-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHknLvQ0d2nhdAEAu9opvQ
	(envelope-from <cgroups+bounces-13456-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 26 Jan 2026 10:33:40 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A330860F4
	for <lists+cgroups@lfdr.de>; Mon, 26 Jan 2026 10:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 626293046E90
	for <lists+cgroups@lfdr.de>; Mon, 26 Jan 2026 09:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D8B32570A;
	Mon, 26 Jan 2026 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvfjaY8A"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65DA326940;
	Mon, 26 Jan 2026 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769419826; cv=none; b=dLGr8rI1fL2UQ3BgQz57Gh4MWUj1xb/1YoWJ2EYcn6XQuMhTyclkkW9Cg6OZIwvQrBJ580gzOapOybl4hv7nvewdyHIjDdNtWN4CXeJhWwJKuXp8Rkv/Mh+am3KryDUf65lpAeYdr63rVZXsrE9LBWDekG3gnGaa/3SM9SRcBQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769419826; c=relaxed/simple;
	bh=aQuK0odfYbvA8lTK4uctHrzL1AwniMgbpNZoaBMehIA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Z1dHrIVvtl7L146FgbHeWwCQ5Grq+ARuhgzgMkTt3FUwiohatXgM+bkJhbJ2PtpOG538oN7axya+rE5Kp0CDBfywfjoPr2EIVR7+ROe8Lfv3sX1uJXbwRSf2ng71v4BSK74L4rjxevdQJBBc6uuTk0pE2E9nz18ry9d9k2pgeZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvfjaY8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B83C116C6;
	Mon, 26 Jan 2026 09:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769419826;
	bh=aQuK0odfYbvA8lTK4uctHrzL1AwniMgbpNZoaBMehIA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=VvfjaY8AH+LnK/kCrvfPPmglYSpdx/2IxA8NwM8wh66Sej+rHEy3fawSM7F7aBmu1
	 6hV/E4PkTZQI6jgqLtKEo+0D8nJk8JLsNZl4rdq3jdu6XxITZy0kr9V8hYkW/ciW8d
	 JSHUoPYn2GY7UuosnQtIzPxrniT/tat3MrDzaM24lt8F/ylil/Q1qwqq9NCxdKSa2B
	 DRpWivblKgE1dC5BAROK2xz62zFqp/rI9bnxM9JR2VJe+PLDOzmx9ioDBboKJfACzh
	 C3wOzqRYONoZMRXHuNovaxLLK08RqIfJ8U2I6O4RbzGNvr090R7tdfaTKULw/kMPXz
	 /vTU/pwIBAyow==
Content-Type: multipart/mixed; boundary="===============2507318955601397522=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dae9aa2f4d4de48d86d1e65ab1ce73e01bcff2d003361feb26d06d91eb15b6f7@mail.kernel.org>
In-Reply-To: <e4c02c0f2673ade0b6e0c254605e011385b744df.1769417588.git.zhuhui@kylinos.cn>
References: <e4c02c0f2673ade0b6e0c254605e011385b744df.1769417588.git.zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH bpf-next v4 08/12] mm: memcontrol: Add BPF struct_ops for memory controller
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,akpm@linux-foundation.org,hannes@cmpxchg.org,mhocko@kernel.org,roman.gushchin@linux.dev,shakeel.butt@linux.dev,muchun.song@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,peterz@infradead.org,ojeda@kernel.org,nathan@kernel.org,kees@kernel.org,tj@kernel.org,jeffxu@chromium.org,mkoutny@suse.com,kernel@jfarr.cc,brauner@kernel.org,rdunlap@infradead.org,brgerst@gmail.com,masahiroy@kernel.org,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,inwardvessel@gmail.com,willemb@google.com,kerneljasonxing@gmail.com,paul.chaignon@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,chenridong@huaweicloud.com,lance.yang@linux.dev,jiayuan.chen@linux.dev,linux-kernel@vger.kernel.org,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,linu
 x-kselftest@vger.kernel.org
Cc: zhuhui@kylinos.cn,geliang@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 26 Jan 2026 09:30:25 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	FREEMAIL_CC(0.00)[kylinos.cn,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,cgroups@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13456-lists,cgroups=lfdr.de,bpf-ci];
	FREEMAIL_TO(0.00)[linux.dev,linux-foundation.org,cmpxchg.org,kernel.org,iogearbox.net,gmail.com,fomichev.me,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,davemloft.net,huaweicloud.com,vger.kernel.org,kvack.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:-];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[60];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+,1:+]
X-Rspamd-Queue-Id: 5A330860F4
X-Rspamd-Action: no action

--===============2507318955601397522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index f3b8c71870d8..1083be5d0362 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h

[ ... ]

> +#else /* CONFIG_BPF_SYSCALL */
> +
> +static inline unsigned long
> +bpf_memcg_get_high_delay(struct mem_cgroup *memcg) { return 0; }
> +static inline bpf_memcg_below_low(struct mem_cgroup *memcg) { return false; }
> +static inline bpf_memcg_below_min(struct mem_cgroup *memcg) { return false; }
                ^^^^^^^^^^^^^^^^^^^^

These two stubs are missing the bool return type. This will cause a
compilation error when CONFIG_BPF_SYSCALL is not set. Should these be:

  static inline bool bpf_memcg_below_low(...)
  static inline bool bpf_memcg_below_min(...)

> +static inline void memcontrol_bpf_online(struct mem_cgroup *memcg) { }
> +static inline void memcontrol_bpf_offline(struct mem_cgroup *memcg) { }
> +
> +#endif /* CONFIG_BPF_SYSCALL */

[ ... ]

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 716df49d7647..20c5c3552ce3 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c

[ ... ]

> +static int bpf_memcg_ops_reg(void *kdata, struct bpf_link *link)
> +{
> +	struct bpf_struct_ops_link *ops_link
> +		= container_of(link, struct bpf_struct_ops_link, link);
> +	struct memcg_bpf_ops *ops = kdata;
> +	struct mem_cgroup *memcg, *iter = NULL;
> +	int err = 0;
> +
> +	memcg = mem_cgroup_get_from_ino(ops_link->cgroup_id);
> +	if (IS_ERR_OR_NULL(memcg))
> +		return PTR_ERR(memcg);
> +
> +	cgroup_lock();
> +	while ((iter = mem_cgroup_iter(memcg, iter, NULL))) {
> +		if (READ_ONCE(iter->bpf_ops)) {
> +			mem_cgroup_iter_break(memcg, iter);
> +			err = -EBUSY;
> +			break;
> +		}
> +		WRITE_ONCE(iter->bpf_ops, ops);
> +	}
> +	if (err)
> +		clean_memcg_bpf_ops(memcg, NULL);
                                      ^^^^

When registration fails because a descendant cgroup already has a BPF
program attached, this calls clean_memcg_bpf_ops() with NULL. Looking at
clean_memcg_bpf_ops():

  while ((iter = mem_cgroup_iter(memcg, iter, NULL))) {
      if (ops) {
          if (!WARN_ON(READ_ONCE(iter->bpf_ops) != ops))
              WRITE_ONCE(iter->bpf_ops, NULL);
      } else
          WRITE_ONCE(iter->bpf_ops, NULL);   // unconditional clear
  }

With ops=NULL, this will unconditionally clear bpf_ops for all
descendants in the hierarchy, including the cgroup that already had a
different BPF program attached (which caused the -EBUSY error). This
would incorrectly detach that existing program.

Should this be clean_memcg_bpf_ops(memcg, ops) instead, so it only clears
the ops that were written during this failed registration attempt?

Note: This issue appears to be addressed in the subsequent commit
5f3bb9a8c33f ("mm/bpf: Add BPF_F_ALLOW_OVERRIDE support for
memcg_bpf_ops") which completely rewrites the registration logic.

> +	cgroup_unlock();
> +
> +	mem_cgroup_put(memcg);
> +	return err;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21352241149

--===============2507318955601397522==--

