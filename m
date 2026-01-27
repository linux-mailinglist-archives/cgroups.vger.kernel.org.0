Return-Path: <cgroups+bounces-13475-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BwsADePeGmqqwEAu9opvQ
	(envelope-from <cgroups+bounces-13475-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 11:11:03 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E28C9280E
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 11:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4BA12301BE18
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 10:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD832F0C49;
	Tue, 27 Jan 2026 10:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcYpJ1iW"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C247E2E88AE;
	Tue, 27 Jan 2026 10:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769508515; cv=none; b=jHv+m+h531IL84ULg6t+GuHSc7LaPbQjv8Lgu90OMu7yVD/GMNvpg2u1inzqgT+OgWChE1nRqtJg0PAoelm/kpgM2MF/8eDsBZw1bpnR3Dc8YyVopCxdWzI8g8efqE8vicqKAT29wM/xDhTB5ME9FJQyBFgQ7xWQ+LNVtT3+aIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769508515; c=relaxed/simple;
	bh=pxcghcGoznBPYSsYWOnMk9AZAKVnZLIBsd7EtsGmQiE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dYyRettbgGD8R6pp4QG6k6+tycf5pPD0Xyr2pN9ZLhAGFmLu3OC0CuD2rpMOxdV0nJVathIO7zKVVliOEPi9QhNYAzP++rvAXWmSzsdfz9PZUm1D+mKaGjDtr6t5jxM/gcwnhrRwKxFvejS+eoW7kMKG0T/NV/yufeZ5h61ig/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcYpJ1iW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFAEC16AAE;
	Tue, 27 Jan 2026 10:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769508515;
	bh=pxcghcGoznBPYSsYWOnMk9AZAKVnZLIBsd7EtsGmQiE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=fcYpJ1iWIhFQ77RVschYYFWk5OXRaNQW0yy0eCDumbo/Zk3DKGOOjbRYQjX/PF02Y
	 OoTplVx9aQUE1BRdSdhEMcYbZ8jIk+uyj41DJMN2pNoT+wdYjF2YkMjHJPTD+FNQU7
	 jDuZVivjOHWzcjmvjQ7k2KYozA8SOxbZWqktmip3jCMB9ZiCRvrd94ZcbcqP5nffHH
	 SRJFou7vgvpsHMYeF1gY1G448k4m0zLmcGl8XxA+PUzZFaQ/hvh4S1ByLk2MiLJMGh
	 y9VgFxXSi7pYN9mPcYk4R9aNsFni6Ly8v0L+fZOmJuGydhMP7B5DkcY98fiE1XdU3r
	 OuAcVpbRBeryw==
Content-Type: multipart/mixed; boundary="===============5556048094623002563=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <34fb17bae65a38450661486263eaffebd488c8943bbf9416e72ba2c0e3b31e07@mail.kernel.org>
In-Reply-To: <f02bee79100c0df5d799d0d941666b0bf9700ac9.1769506741.git.zhuhui@kylinos.cn>
References: <f02bee79100c0df5d799d0d941666b0bf9700ac9.1769506741.git.zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH bpf-next v5 09/12] selftests/bpf: Add tests for memcg_bpf_ops
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,akpm@linux-foundation.org,hannes@cmpxchg.org,mhocko@kernel.org,roman.gushchin@linux.dev,shakeel.butt@linux.dev,muchun.song@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,peterz@infradead.org,ojeda@kernel.org,nathan@kernel.org,kees@kernel.org,tj@kernel.org,jeffxu@chromium.org,mkoutny@suse.com,kernel@jfarr.cc,brauner@kernel.org,rdunlap@infradead.org,brgerst@gmail.com,masahiroy@kernel.org,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,inwardvessel@gmail.com,willemb@google.com,kerneljasonxing@gmail.com,paul.chaignon@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,chenridong@huaweicloud.com,lance.yang@linux.dev,jiayuan.chen@linux.dev,linux-kernel@vger.kernel.org,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,linu
 x-kselftest@vger.kernel.org
Cc: zhuhui@kylinos.cn,geliang@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 27 Jan 2026 10:08:34 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kylinos.cn,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	TAGGED_FROM(0.00)[bounces-13475-lists,cgroups=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_TO(0.00)[linux.dev,linux-foundation.org,cmpxchg.org,kernel.org,iogearbox.net,gmail.com,fomichev.me,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,davemloft.net,huaweicloud.com,vger.kernel.org,kvack.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:-];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+];
	RCPT_COUNT_GT_50(0.00)[60];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E28C9280E
X-Rspamd-Action: no action

--===============5556048094623002563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_ops.c b/tools/testing/selftests/bpf/prog_tests/memcg_ops.c
> new file mode 100644
> index 000000000000..a596926ea233
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/memcg_ops.c

[ ... ]

> +void test_memcg_ops_over_high(void)
> +{
> +	int err, map_fd;
> +	struct memcg_ops *skel = NULL;

[ ... ]

> +	skel = memcg_ops__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "memcg_ops__open_and_load"))
> +		goto out;

[ ... ]

> +out:
> +	bpf_link__destroy(link);
> +	bpf_link__destroy(link2);
> +	memcg_ops__detach(skel);
> +	memcg_ops__destroy(skel);
                  ^^^^

Can this cause a NULL pointer dereference? When memcg_ops__open_and_load()
fails, skel is NULL and the code jumps to out: where memcg_ops__detach(skel)
is called. The generated __detach() function does not check for NULL, unlike
__destroy() which does. Since __destroy() already calls __detach() internally
after checking for NULL, the explicit memcg_ops__detach(skel) call appears
to be unnecessary and would crash when skel is NULL.

The same pattern appears in test_memcg_ops_below_low_over_high() and
test_memcg_ops_below_min_over_high().


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21392729810

AI-authorship-score: medium
AI-authorship-explanation: The commit message uses verbose, explanatory language with markdown formatting that is somewhat atypical for kernel commits, and the repetitive test function structure with the redundant detach call suggests possible AI assistance in code generation.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: The memcg_ops__detach(NULL) call can crash the test if the skeleton fails to load, but this only affects the selftest program and not the kernel itself.

--===============5556048094623002563==--

