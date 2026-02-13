Return-Path: <cgroups+bounces-13941-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJilEE/Zjmn9FQEAu9opvQ
	(envelope-from <cgroups+bounces-13941-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 08:57:03 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2CC133BCB
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 08:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B36C305EE96
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 07:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC28313E3E;
	Fri, 13 Feb 2026 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ES4O2rdX"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E4D2F619A;
	Fri, 13 Feb 2026 07:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770969416; cv=none; b=Qng8ijXz1SjKY9cwrvPGkZluqNeTlvysldAFRmXe6fGr6mFRdbwd6LptEvbrRiLEyy2iOQE7Kr28fhWFHegfxoFou7FEGUuD5vdeVQ2/sSxxfiXfJMlJD5D9R2NVHzSNG/wMDzlIRyZlvSLiEMDNv2DGlfXHuuY9q3j5DnZpz7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770969416; c=relaxed/simple;
	bh=Ksw0hqi4Ayhwf33M+Hk7rydODnGoE7z6sHemjEQ9aP8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EgUNao4Ux6lzYwQwC+ZvUM5fhgAno90VX6pfTTgaxhhQhrm5fF3ppois9oPyYy4Jcac+h9Z5bmq679w+we8e3pvk6S8iIHtCzDokHgHMerv0KVKhqZfbUxKcItVcVwe55HrvL4e+tYlAVJ4HcCayBGBrFDnQFocLaa/qGvypHmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ES4O2rdX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D032C116C6;
	Fri, 13 Feb 2026 07:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770969415;
	bh=Ksw0hqi4Ayhwf33M+Hk7rydODnGoE7z6sHemjEQ9aP8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ES4O2rdXCJS9AyDu3Ot580ALW9FC0Yn5MyYq8xtyxsKCrh+icFHLqS081duHsE0dr
	 xRgmys72IN5z4IA37aw5wzPzvpyqn2CSP1qEafGOqYF/FNC7/dCxrO1Xpz99bSWq66
	 ZTgkjOo9s+sgMHBoxMkgIg6w9+4PeVSVrYWyNt6P8QEYP774ahcPylmRUiZCQ41i3a
	 pLKQtF5ObvDQqD1PpR5MsT1t9dE6V1y3axPYsuo6qJr9QTHnElAJhwv0IPNUlrT7fi
	 5r91DiMbxYeua+uX+fYobQJKmXo/cRAwzIvcfkiz5c9I9qPJCZJAdrcjn974sVckd8
	 +kT5ihcL3jwng==
Content-Type: multipart/mixed; boundary="===============0586976686014415741=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9e26a97b0019726973b42c668185a64f588ecc2a0773dd683fd930eeef243470@mail.kernel.org>
In-Reply-To: <447797edc394ab8a8b2484bb6c92b56115254e27.1770965805.git.zhuhui@kylinos.cn>
References: <447797edc394ab8a8b2484bb6c92b56115254e27.1770965805.git.zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v2 3/3] bpf: selftests: Skip kmem test when cgroup.memory=nokmem is set
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,hannes@cmpxchg.org,mhocko@kernel.org,roman.gushchin@linux.dev,shakeel.butt@linux.dev,muchun.song@linux.dev,akpm@linux-foundation.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,zhuhui@kylinos.cn,inwardvessel@gmail.com,cgroups@vger.kernel.org,linux-mm@kvack.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 13 Feb 2026 07:56:55 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FREEMAIL_TO(0.00)[linux.dev,cmpxchg.org,kernel.org,linux-foundation.org,iogearbox.net,gmail.com,fomichev.me,google.com,kylinos.cn,vger.kernel.org,kvack.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	TAGGED_FROM(0.00)[bounces-13941-lists,cgroups=lfdr.de,bpf-ci];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Queue-Id: AD2CC133BCB
X-Rspamd-Action: no action

--===============0586976686014415741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c

[ ... ]

> +static bool cmdline_has(const char *arg)
> +{

[ ... ]

> +	cmdline[len] = '\0';
> +	if (strstr(cmdline, arg))
> +		ret = true;
> +
> +	return ret;
> +}

[ ... ]

> +	if (cmdline_has("cgroup.memory=nokmem")) {

The kernel's cgroup.memory= parameter accepts a comma-separated list
of options.  The parser in mm/memcontrol.c cgroup_memory() splits the
value on commas with strsep():

mm/memcontrol.c:cgroup_memory() {
    while ((token = strsep(&s, ",")) != NULL) {
        ...
        if (!strcmp(token, "nokmem"))
            cgroup_memory_nokmem = true;
        ...
    }
}

This means valid command lines include configurations like
"cgroup.memory=nosocket,nokmem" or "cgroup.memory=nobpf,nokmem".

Since cmdline_has() uses strstr() to match the full literal string
"cgroup.memory=nokmem", it only matches when nokmem is the first (or
only) option.  For "cgroup.memory=nosocket,nokmem", strstr() won't
find "cgroup.memory=nokmem" as a substring, so the check returns
false even though nokmem is active.

Would it be more robust to search for just "nokmem" within the
cgroup.memory= value, or to split on commas similar to how the kernel
parses it?

> +		if (!ASSERT_OK(read_stats(link), "read stats"))
> +			return;
> +		ASSERT_EQ(memcg_query->memcg_kmem, 0, "kmem value");
> +		return;
> +	}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21978734425

AI-authorship-score: low
AI-authorship-explanation: The patch addresses a specific real-world back-porting issue, shows iterative development across versions in response to human reviewer feedback, and uses standard kernel C patterns with no hallmarks of AI generation.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: The strstr-based cmdline check misses nokmem when it is not the first option in a comma-separated cgroup.memory= value, causing the test to fail on those configurations instead of being skipped.

--===============0586976686014415741==--

