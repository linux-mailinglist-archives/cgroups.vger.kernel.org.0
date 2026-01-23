Return-Path: <cgroups+bounces-13395-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GE+sIwY9c2kztgAAu9opvQ
	(envelope-from <cgroups+bounces-13395-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 10:19:02 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2679F731DE
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 10:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAF5B3017FA5
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 09:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802A5315D47;
	Fri, 23 Jan 2026 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4KhXs3I"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365C930DD38;
	Fri, 23 Jan 2026 09:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769159939; cv=none; b=VuTugaWKxMyLeDd1/ySSLu7InJZKj0RV0UCFb/PS5dJ0uyInpSPxhwwUPTy6oovRVBA7C03o71UP5yCdaIXo+hBYJ4p26XROGz7UoMRsyU9QKeqgKX4Rea4CS7Fmv3wJZpY0lXO7ifwOoUTbUw7ghagOjB6fp3V7KJGCo7Ev3pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769159939; c=relaxed/simple;
	bh=Yj/0342sqfLBIPiqehTF1fNxuPJu6F+hRc2WRAQWcuA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Z6biVbITpMU8gOaJ0M3IFpLhbB+366vhYz4Yvn4em5cFQixtTf6QJ60gAniPEsVCwJ66GWTQ2z4eJvc5GzcJ08YN58u4gaJxOgIvVHRd9wbsFNh/i7ISt2QD8pqnAAHaWUH5gVQAi1/b/p+dciXkjOOxgxIYW+OoNAIr4VPjDwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4KhXs3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00317C4CEF1;
	Fri, 23 Jan 2026 09:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769159938;
	bh=Yj/0342sqfLBIPiqehTF1fNxuPJu6F+hRc2WRAQWcuA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=o4KhXs3IAcxW1VHcGUecCF0/Sd7ez/fIAyJCNmpzuKqaaLt4qW5en1ElzlA4OJbJE
	 +aAmUlTDGNVZI3jZkb0+DXyxqDTqjDszWBJkqewICLJTj+zHBVzoi9gvNjnAO70BXW
	 1HCZfTQjLTUqc5WZxtjXU7kD8RoGWCHn6oO/Ps6Luo2dj1GLKwuDboFQTpqeRHCVRA
	 BfEt6HkYtr+gh1Qj6OUQR72ELqo3q+KUOkC53xoZBwbwYtGkq87mmerADXL4iK4QJR
	 lT8eojQQ5dLFc8JseAMWYZuwuqcHgi1o1QsY82a6qbTcmTfJfmAmXonS2Oe2VrsA1f
	 crOk4bVvC5+Lw==
Content-Type: multipart/mixed; boundary="===============1550164231886997435=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <806d3538bf542f23b9b89c35199996f195e82b2cdde50c40ca8478cbbe6af3fb@mail.kernel.org>
In-Reply-To: <db8b80a445a61b437c35c71ec2edb573002656fc.1769157382.git.zhuhui@kylinos.cn>
References: <db8b80a445a61b437c35c71ec2edb573002656fc.1769157382.git.zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH bpf-next v3 11/12] selftests/bpf: Add test for memcg_bpf_ops hierarchies
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,akpm@linux-foundation.org,hannes@cmpxchg.org,mhocko@kernel.org,roman.gushchin@linux.dev,shakeel.butt@linux.dev,muchun.song@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,peterz@infradead.org,ojeda@kernel.org,nathan@kernel.org,kees@kernel.org,tj@kernel.org,jeffxu@chromium.org,mkoutny@suse.com,kernel@jfarr.cc,brauner@kernel.org,rdunlap@infradead.org,brgerst@gmail.com,masahiroy@kernel.org,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,inwardvessel@gmail.com,willemb@google.com,kerneljasonxing@gmail.com,paul.chaignon@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,chenridong@huaweicloud.com,lance.yang@linux.dev,jiayuan.chen@linux.dev,linux-kernel@vger.kernel.org,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,linu
 x-kselftest@vger.kernel.org
Cc: zhuhui@kylinos.cn,geliang@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 23 Jan 2026 09:18:57 +0000 (UTC)
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
	TAGGED_FROM(0.00)[bounces-13395-lists,cgroups=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kylinos.cn,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	FREEMAIL_TO(0.00)[linux.dev,linux-foundation.org,cmpxchg.org,kernel.org,iogearbox.net,gmail.com,fomichev.me,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,davemloft.net,huaweicloud.com,vger.kernel.org,kvack.org];
	NEURAL_SPAM(0.00)[0.710];
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
X-Rspamd-Queue-Id: 2679F731DE
X-Rspamd-Action: no action

--===============1550164231886997435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_ops.c b/tools/testing/selftests/bpf/prog_tests/memcg_ops.c
> index 9a8d16296f2d..bab9f3094f59 100644
> --- a/tools/testing/selftests/bpf/prog_tests/memcg_ops.c
> +++ b/tools/testing/selftests/bpf/prog_tests/memcg_ops.c

[ ... ]

> +void test_memcg_ops_hierarchies(void)
> +{
> +	int ret, first = -1, second = -1, third = -1;
> +	struct memcg_ops *skel;
> +	struct bpf_map *map;
> +	struct bpf_link *link1 = NULL, *link2 = NULL, *link3 = NULL;

[ ... ]

> +	opts.relative_fd = second;
> +	opts.flags = 0;
> +	link2 = bpf_map__attach_struct_ops_opts(map, &opts);
> +	if (!ASSERT_OK_PTR(link2, "bpf_map__attach_struct_ops_opts"))
> +		goto cleanup;
> +
> +	opts.relative_fd = third;
> +	opts.flags = 0;
> +	link2 = bpf_map__attach_struct_ops_opts(map, &opts);
> +	if (!ASSERT_ERR_PTR(link3, "bpf_map__attach_struct_ops_opts"))
                          ^^^^^

The result of the third bpf_map__attach_struct_ops_opts() call is stored in
link2, but the assertion checks link3. Since link3 is initialized to NULL
and never modified, the ASSERT_ERR_PTR check does not validate the actual
return value of the third attachment.

Should this be assigning to link3 instead of link2?

> +		goto cleanup;
> +
> +cleanup:
> +	bpf_link__destroy(link1);
> +	bpf_link__destroy(link2);

If the fix is to use link3 for the third attachment result, should
bpf_link__destroy(link3) be added here as well?

> +	memcg_ops__detach(skel);
> +	close(first);
> +	close(second);
> +	close(third);
> +	cleanup_cgroup_environment();
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21280790825

--===============1550164231886997435==--

