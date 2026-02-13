Return-Path: <cgroups+bounces-13942-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YICZIVrZjmn9FQEAu9opvQ
	(envelope-from <cgroups+bounces-13942-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 08:57:14 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B81133BEA
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 08:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 706D7301941A
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 07:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804B5314B84;
	Fri, 13 Feb 2026 07:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dj0ruJXc"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42006314A95;
	Fri, 13 Feb 2026 07:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770969417; cv=none; b=YfP3LNX31bFIXm5++057LFujHvak4LILAXDI4vQA+TIAyfFcDQYVH1FH03EiJYVhCJhNifpbcYXLvNTiryRbIPPxwuEV0k/xu68lxTPz/q0UivCNKWpfVCM+M27xC+NckRhizZ/Ms/yFdz0gwYOaAu8rXfEpfmXhGaAQdOmbwag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770969417; c=relaxed/simple;
	bh=PpQWvYCrQta7omtcLnAeHaRE+LVjwufS1aP9UvbTMQA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=D1/NkbbX/wme9bh/Oe6sKdRKPvbMkvU8X26nosXLPyBJvPb++Vr94uSc+KsOryN5sphiASjIXAZMtSslDG4jn8//YWZPHcn1G4Phod6iRSUBrkCzC5MspilRv9vsjI4+MlGqzzANuoTZ4quipexF2D+0eKysrP1cQGgbXATov3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dj0ruJXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6798C2BC86;
	Fri, 13 Feb 2026 07:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770969417;
	bh=PpQWvYCrQta7omtcLnAeHaRE+LVjwufS1aP9UvbTMQA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Dj0ruJXcAKlcq/8kwv/FD7QRg5vxmqV7VF3eF8+UgOpcVkQXVZU57zwM9H6nqivEG
	 fUeDyj6+Fi5MrsHqR5qNpy+eK6N2XXvaNTp2DyP3FUl4ewGkX6+2lHwKHzUqR89e0s
	 bYWQ3DfnyzZstdvVar2Tf8feoi7ySq8bnEQKBUzT8Gj4l2ahDFpyUf1Lm3QLQyfsIu
	 XGKvpRxaHH3qzh2W7I7NjjQN4AcAezIGkmyh0PF/FXP/U/S8QEKZtOutvZzsXwBaEp
	 ZYtioZHBCvbOisz0mgJvGwsu6IR/5zWN4L700WmT58qzu9fDkkbkbyu8DqFQcDxnQG
	 IyFyvuDLLQPvQ==
Content-Type: multipart/mixed; boundary="===============6972505930256429267=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1d048c48e087e02590e6943bdfed93db4202f3c600155483cc38cea21e565f8b@mail.kernel.org>
In-Reply-To: <ba61b77c71b6285eefa022a84bf80c5913b313de.1770965805.git.zhuhui@kylinos.cn>
References: <ba61b77c71b6285eefa022a84bf80c5913b313de.1770965805.git.zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: Check bpf_mem_cgroup_page_state return value
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,hannes@cmpxchg.org,mhocko@kernel.org,roman.gushchin@linux.dev,shakeel.butt@linux.dev,muchun.song@linux.dev,akpm@linux-foundation.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,zhuhui@kylinos.cn,inwardvessel@gmail.com,cgroups@vger.kernel.org,linux-mm@kvack.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 13 Feb 2026 07:56:56 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FREEMAIL_TO(0.00)[linux.dev,cmpxchg.org,kernel.org,linux-foundation.org,iogearbox.net,gmail.com,fomichev.me,google.com,kylinos.cn,vger.kernel.org,kvack.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	TAGGED_FROM(0.00)[bounces-13942-lists,cgroups=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid]
X-Rspamd-Queue-Id: E3B81133BEA
X-Rspamd-Action: no action

--===============6972505930256429267==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c

[ ... ]

> @@ -143,6 +151,8 @@ static void test_kmem(struct bpf_link *link, struct memcg_query *memcg_query)
>  	if (!ASSERT_OK(read_stats(link), "read stats"))
>  		goto cleanup;
>
> +	ASSERT_NEQ(memcg_query->memcg_kmem, (unsigned long)-1,
> +		  "bpf_mem_cgroup_vm_events MEMCG_KMEM");

Should this assertion string say "bpf_mem_cgroup_page_state MEMCG_KMEM"
instead?  The BPF program in progs/cgroup_iter_memcg.c populates
memcg_kmem using bpf_mem_cgroup_page_state(), not
bpf_mem_cgroup_vm_events():

    idx = bpf_core_enum_value(enum memcg_stat_item, MEMCG_KMEM);
    ...
    memcg_query.memcg_kmem = bpf_mem_cgroup_page_state(memcg, idx);

> @@ -170,6 +180,8 @@ static void test_pgfault(struct bpf_link *link, struct memcg_query *memcg_query)
>  	if (!ASSERT_OK(read_stats(link), "read stats"))
>  		goto cleanup;
>
> +	ASSERT_NEQ(memcg_query->pgfault, (unsigned long)-1,
> +		  "bpf_mem_cgroup_page_state PGFAULT");

Similarly, should this say "bpf_mem_cgroup_vm_events PGFAULT"?  The BPF
program retrieves pgfault using bpf_mem_cgroup_vm_events():

    idx = bpf_core_enum_value(enum vm_event_item, PGFAULT);
    ...
    memcg_query.pgfault = bpf_mem_cgroup_vm_events(memcg, idx);

It looks like the two assertion description strings for test_kmem and
test_pgfault were swapped.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21978734425

AI-authorship-score: low
AI-authorship-explanation: The commit describes a specific back-porting scenario, and the copy-paste error in swapped assertion strings is characteristic of human authorship.
issues-found: 2
issue-severity-score: low
issue-severity-explanation: Two assertion description strings are swapped between test_kmem and test_pgfault, producing misleading diagnostics on test failure but not affecting test correctness or system stability.

--===============6972505930256429267==--

