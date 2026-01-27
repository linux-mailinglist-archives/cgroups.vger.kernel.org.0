Return-Path: <cgroups+bounces-13472-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMh0HpaPeGmarAEAu9opvQ
	(envelope-from <cgroups+bounces-13472-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 11:12:38 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8B392872
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 11:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D9D23062F94
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 10:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553E32E9EAC;
	Tue, 27 Jan 2026 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O77Lqwib"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F812E8B66;
	Tue, 27 Jan 2026 10:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769508508; cv=none; b=oj3TImT4j7nW03AWyG9CEvKEKaLoBRMjSKapshW0qiEg3JSOA7MttzJY/X2MGoxrHVoj5VI4FqxMuY1H7lLpIhmRDG5UIulITNFQyl43+1QxYdhJBkXEayFUgbr8zuZQoJ3rrrpgOoI6BIdMYUmJw2MhUekzcmm+vjTdstQlUVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769508508; c=relaxed/simple;
	bh=eXH7LTpBzt1Nf5PxVt/Zw5NAmsupLUnjjKZooxxdMvw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RE51NVntuaajX8LQ0WIOuosIMe9NgZD8NF2QIkM1oRijlTm5hUECRxsC59Jz/1T7uamYJM2cp/Ol6rkfPJkodmn4+DQSVGdNJfl0aDOgmV989iEd6Fo/KYYcdi8XhIwkahmTeHmYxz7lJXeHzaMz3kN4/yRtvf6W+EXath4acpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O77Lqwib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93118C116C6;
	Tue, 27 Jan 2026 10:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769508508;
	bh=eXH7LTpBzt1Nf5PxVt/Zw5NAmsupLUnjjKZooxxdMvw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=O77LqwibsgbYXv0sPD4MPA6EMA9pdPtxYNvTmdpyBaPZO3JR9RX/r9DQXxVe/yrQT
	 zlfOBASL3XdUncbooj9HoX4VQ0r4dWQfGK1fJCtOOjH8L6Kbu0EkPeF40wAJK65kKk
	 BrHXV23nDTtyCLnyhC8Ht6V+PquWe3ZQ6ueqZ9eIi91cHkd6HfX3WugtNcxzDAYsQM
	 gbg06EV0f5oa32Z3/1n7eXZnQ9KCxAUzcPlGsIKSpLxX1wmSI3IhWlHv6Gqb4aubrT
	 z2jQS0azW95V10FADHw+ibbhTtxXkWyVFhUn2ShVFrIlY9ulYiRMG1smlKXVmaPZuL
	 HGrjvItPTNinQ==
Content-Type: multipart/mixed; boundary="===============4938179612018120319=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <12bedb9d4fc0676edf3812bfcc8ff7c761286fc6d2e8ae4ca457a6602ec98dfe@mail.kernel.org>
In-Reply-To: <4a1ad099a2db96b92318cb924d2a7b76ee530209.1769506741.git.zhuhui@kylinos.cn>
References: <4a1ad099a2db96b92318cb924d2a7b76ee530209.1769506741.git.zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH bpf-next v5 10/12] mm/bpf: Add BPF_F_ALLOW_OVERRIDE support for memcg_bpf_ops
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,akpm@linux-foundation.org,hannes@cmpxchg.org,mhocko@kernel.org,roman.gushchin@linux.dev,shakeel.butt@linux.dev,muchun.song@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,peterz@infradead.org,ojeda@kernel.org,nathan@kernel.org,kees@kernel.org,tj@kernel.org,jeffxu@chromium.org,mkoutny@suse.com,kernel@jfarr.cc,brauner@kernel.org,rdunlap@infradead.org,brgerst@gmail.com,masahiroy@kernel.org,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,inwardvessel@gmail.com,willemb@google.com,kerneljasonxing@gmail.com,paul.chaignon@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,chenridong@huaweicloud.com,lance.yang@linux.dev,jiayuan.chen@linux.dev,linux-kernel@vger.kernel.org,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,linu
 x-kselftest@vger.kernel.org
Cc: zhuhui@kylinos.cn,geliang@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 27 Jan 2026 10:08:27 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kylinos.cn,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	TAGGED_FROM(0.00)[bounces-13472-lists,cgroups=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_TO(0.00)[linux.dev,linux-foundation.org,cmpxchg.org,kernel.org,iogearbox.net,gmail.com,fomichev.me,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,davemloft.net,huaweicloud.com,vger.kernel.org,kvack.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:-];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+];
	RCPT_COUNT_GT_50(0.00)[60];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Queue-Id: DC8B392872
X-Rspamd-Action: no action

--===============4938179612018120319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index e746eb9cbd56..7cd983e350d7 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c

[ ... ]

> static int bpf_memcg_ops_reg(void *kdata, struct bpf_link *link)
> {
> 	struct bpf_struct_ops_link *ops_link
> 		= container_of(link, struct bpf_struct_ops_link, link);
>-	struct memcg_bpf_ops *ops = kdata;
>+	struct memcg_bpf_ops *ops = kdata, *old_ops;
> 	struct mem_cgroup *memcg, *iter = NULL;
> 	int err = 0;

[ ... ]

>+	/* Check for incompatible bpf_ops in descendants. */
> 	while ((iter = mem_cgroup_iter(memcg, iter, NULL))) {
>-		if (READ_ONCE(iter->bpf_ops)) {
>-			mem_cgroup_iter_break(memcg, iter);
>+		struct memcg_bpf_ops *iter_ops = READ_ONCE(iter->bpf_ops);
>+
>+		if (iter_ops && iter_ops != old_ops) {
>+			/* cannot override existing bpf_ops of sub-cgroup. */
> 			err = -EBUSY;
>-			break;
>+			goto unlock_out;
                        ^^^^

It looks like this error path leaks a CSS reference. The original code
called mem_cgroup_iter_break(memcg, iter) before breaking out of the loop,
which releases the CSS reference held on iter. The new code jumps directly
to unlock_out without releasing this reference.

mem_cgroup_iter() acquires a reference on each returned memcg via
css_tryget() in mm/memcontrol.c. When breaking out of the loop early,
mem_cgroup_iter_break() must be called to release that reference.

Should this be:

    if (iter_ops && iter_ops != old_ops) {
        mem_cgroup_iter_break(memcg, iter);
        err = -EBUSY;
        goto unlock_out;
    }

> 		}
>+	}
>+
>+	while ((iter = mem_cgroup_iter(memcg, iter, NULL))) {
> 		WRITE_ONCE(iter->bpf_ops, ops);
>+		iter->bpf_ops_flags = ops_link->flags;
> 	}
>-	if (err)
>-		clean_memcg_bpf_ops(memcg, ops);
>+
>+unlock_out:
> 	cgroup_unlock();

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21392729810

AI-authorship-score: low
AI-authorship-explanation: The commit follows standard kernel documentation patterns without distinctive AI markers.
issues-found: 1
issue-severity-score: medium
issue-severity-explanation: CSS reference leak in error path leads to memcg lifetime issues but does not cause immediate system instability.

--===============4938179612018120319==--

