Return-Path: <cgroups+bounces-13455-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOO/Occ0d2nhdAEAu9opvQ
	(envelope-from <cgroups+bounces-13455-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 26 Jan 2026 10:32:55 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BF3860D3
	for <lists+cgroups@lfdr.de>; Mon, 26 Jan 2026 10:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DF743020002
	for <lists+cgroups@lfdr.de>; Mon, 26 Jan 2026 09:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356763254B1;
	Mon, 26 Jan 2026 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjPNuEKr"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF7C324B30;
	Mon, 26 Jan 2026 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769419824; cv=none; b=eFdM47Qc0lLeBhphW3vK/OZ6yq4SMmJd6XySRdxLH9sO+GNawAgsH9gJwKdlBlVsSxkXmqsfcmeZFq/Cdz0rUIc2UHO4sFUkDtf4V+/hNEDTCCX3f4zx2OYBwbqWypR+AUHVhaPR+Hz+GUsmF8TdM6b5MvL7v34ggFFncEqG2VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769419824; c=relaxed/simple;
	bh=tPDTH/y75T67JFjuIWvMnrDHNL7T+b3GWP+6DE5AMmk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bzNcOq3R7snUxN7RVLO/b5yDBBjgzuVaHotOngcTqRAKiVaUqv4ptrilwzBehw74ICI6lg7+Svq8ebZ60yAxj9VgeUZMYXpMOQyinP/qjE+nYcDvBD0EsE3uOcnIAEp2cHfMw/Epa3B+3/B8IXTQDnYS5vhdFi1eF0xR7ikqudo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjPNuEKr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5A2C116C6;
	Mon, 26 Jan 2026 09:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769419824;
	bh=tPDTH/y75T67JFjuIWvMnrDHNL7T+b3GWP+6DE5AMmk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=MjPNuEKr3A4Hh5VIPhoiaA7JHMRRadBXQM5MCSbzj5KhL5Vt2D5vZdk26P+N8Uq5a
	 3xapmE78VcENeQdCYAkAZ5W+g5Sj3Q7qdluC60S200Q1/pQi4ajLIib1H39qJzi1SM
	 zZBF+dqICgUOLo4FM26KOVV63lbDQAX3Dgjnhr7Y+IvroK71HIX12dS1RQon4g/yF1
	 SB9exwUM2HJEYGjF4KGSv/o7AfIzeayiuXJalezv8cAvfzu9gEaRbO8zkEM3q5mN0c
	 ACsqtNyYmwTuNGSS3rD4AUkU9n5fojcajCTxxHalLmHT/lZ5LnBUR1m4O5ETw+3gvF
	 Dte7tqpHGVf3A==
Content-Type: multipart/mixed; boundary="===============4570348085458857697=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <522167db42c30a5a277f7f3cf0042aae0835cf95606d04b9a251ddd2b3a66f93@mail.kernel.org>
In-Reply-To: <d7dfd68ed07fa445d616c3e21217bccafc951ae1.1769417588.git.zhuhui@kylinos.cn>
References: <d7dfd68ed07fa445d616c3e21217bccafc951ae1.1769417588.git.zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH bpf-next v4 11/12] selftests/bpf: Add test for memcg_bpf_ops hierarchies
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,akpm@linux-foundation.org,hannes@cmpxchg.org,mhocko@kernel.org,roman.gushchin@linux.dev,shakeel.butt@linux.dev,muchun.song@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,peterz@infradead.org,ojeda@kernel.org,nathan@kernel.org,kees@kernel.org,tj@kernel.org,jeffxu@chromium.org,mkoutny@suse.com,kernel@jfarr.cc,brauner@kernel.org,rdunlap@infradead.org,brgerst@gmail.com,masahiroy@kernel.org,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,inwardvessel@gmail.com,willemb@google.com,kerneljasonxing@gmail.com,paul.chaignon@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,chenridong@huaweicloud.com,lance.yang@linux.dev,jiayuan.chen@linux.dev,linux-kernel@vger.kernel.org,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,linu
 x-kselftest@vger.kernel.org
Cc: zhuhui@kylinos.cn,geliang@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 26 Jan 2026 09:30:23 +0000 (UTC)
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
	TAGGED_FROM(0.00)[bounces-13455-lists,cgroups=lfdr.de,bpf-ci];
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
X-Rspamd-Queue-Id: 90BF3860D3
X-Rspamd-Action: no action

--===============4570348085458857697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_ops.c b/tools/testing/selftests/bpf/prog_tests/memcg_ops.c
> index a019ba2387bc..08ac97752ac9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/memcg_ops.c
> +++ b/tools/testing/selftests/bpf/prog_tests/memcg_ops.c
> @@ -539,3 +539,73 @@ void test_memcg_ops_below_min_over_high(void)

[ ... ]

> +void test_memcg_ops_hierarchies(void)
> +{
> +	int ret, first = -1, second = -1, third = -1;
> +	struct memcg_ops *skel;
                          ^^^^

Should skel be initialized to NULL here? The other tests in this file
(test_memcg_ops_over_high, test_memcg_ops_below_low_over_high, and
test_memcg_ops_below_min_over_high) all initialize their skeleton pointers
to NULL.

If any of the early checks fail (e.g. setup_cgroup_environment() or
create_and_get_cgroup()), the code jumps to cleanup where memcg_ops__detach()
is called. The skeleton __detach() function dereferences its argument without
checking for NULL, which would cause a crash with an uninitialized pointer.

> +	struct bpf_map *map;
> +	struct bpf_link *link1 = NULL, *link2 = NULL, *link3 = NULL;
> +	DECLARE_LIBBPF_OPTS(bpf_struct_ops_opts, opts);
> +
> +	ret = setup_cgroup_environment();
> +	if (!ASSERT_OK(ret, "setup_cgroup_environment"))
> +		goto cleanup;

[ ... ]

> +cleanup:
> +	bpf_link__destroy(link1);
> +	bpf_link__destroy(link2);
> +	bpf_link__destroy(link3);
> +	memcg_ops__detach(skel);
                         ^^^^

This dereferences skel without checking if it was ever assigned.

> +	close(first);
> +	close(second);
> +	close(third);
> +	cleanup_cgroup_environment();
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21352241149

--===============4570348085458857697==--

