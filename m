Return-Path: <cgroups+bounces-16280-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Fi1JnMOFWrVSQcAu9opvQ
	(envelope-from <cgroups+bounces-16280-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 05:07:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C475D0372
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 05:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 597663008FE7
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 03:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43273A1684;
	Tue, 26 May 2026 03:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miAoSySF"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C87139A4B9;
	Tue, 26 May 2026 03:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779764785; cv=none; b=VL38BjkGxR5vLh/sMZkDywoCJ4QFkdhyaVkcMJ/MI05QSoP5bDI1sVuvt8RqHwjXnnjF/8HAYsqKsHDxLFCTsswB7RIzg7RKinQuBla7LTmygZ8Iea+21CQ7tclNUk9HcskhP3v58r/YjCbpqMWRavSj9epDH2N//2SqVn+q8jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779764785; c=relaxed/simple;
	bh=HGQjZzHGgQDL4Zj5+ktUND7tDt+ywvnOB3+uu9LM9LY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=BOKK7v0HJ1tl5qyRjZ4ndaJzTtoaxN839jmUfvNZGB5xmL8+LETPWqZTry4pTzS5AP+N6o1L5v+kzZ+xtEy1c+VrK0+qV0XYSB7Ip3VyoRG7dB/hhHLaAZN+NtI3nuDmk/Lk73EE9u0V+LemfomG+ZVBgdDoCO4VzgcvKT9bNuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miAoSySF reason="signature verification failed"; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A3C1F00A3C;
	Tue, 26 May 2026 03:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779764784;
	bh=PuCwAibjo4il47YSW70WARwryK18pod4qEuZtgh/MWA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=miAoSySF8EVzWhz9imT+sy+M1nNqxZMYQ/mRAuANUa7IRGhkoFUFvGaCHhfy6O4kc
	 3pHnFJX0uT4iyiCvjjscyxM6wUC0etmm7CntOOJNa7Cl5W1rcAqpumZi6zMF1aJM77
	 TBZ3IDrPj7i/SJ169dsorvg6uvpic5KuK3HJWYGJQLQiQjizT8l9CoXzSEdwjqfaJn
	 xQzSxTlVYAc8bdOLuBFjyrPhT9aDHdPBJsSWwH00pMYSkFnvzZSI52CVtd5cS6bocN
	 GP0+7TfEA+jzNj+xVOo5MacobpWF5zod7rvHE7YxvEaH+kWMlcZ9wzAc1TgljLAsVo
	 X4o5dXXHEV1oQ==
Content-Type: multipart/mixed; boundary="===============0436309527624145819=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <975872964206d12a299b9d3e938e6e312db4e96bb23f748d97dd6c05d6aee2b1@mail.kernel.org>
In-Reply-To: <b3af3d0f9a925f79a6e4e7218e8ce84dfbeb5254.1779760876.git.zhuhui@kylinos.cn>
References: <b3af3d0f9a925f79a6e4e7218e8ce84dfbeb5254.1779760876.git.zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH bpf-next v7 10/11] selftests/bpf: Add selftest for memcg async reclaim via BPF
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
Date: Tue, 26 May 2026 03:06:23 +0000 (UTC)
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,kylinos.cn,iogearbox.net,gmail.com,linux.dev,meta.com];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20260515];
	TAGGED_FROM(0.00)[bounces-16280-lists,cgroups=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_TO(0.00)[linux.dev,kernel.org,iogearbox.net,gmail.com,cmpxchg.org,linux-foundation.org,davemloft.net,fomichev.me,meta.com,distanz.ch,cestc.cn,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,huaweicloud.com,web.codeaurora.org,vger.kernel.org,kvack.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:-];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+];
	RCPT_COUNT_GT_50(0.00)[69];
	NEURAL_HAM(-0.00)[-0.707];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.kernel.org:mid]
X-Rspamd-Queue-Id: B9C475D0372
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============0436309527624145819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/MAINTAINERS b/MAINTAINERS
> index c9b3dfe2498b..29de8e2fe55d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6576,7 +6576,9 @@ F:	mm/memcontrol-v1.h

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c b/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
> new file mode 100644
> index 000000000000..bf25967c911c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
> @@ -0,0 +1,333 @@

[ ... ]

> +void test_memcg_async_reclaim(void)
> +{
> +	u64 cgroup_id, old_max, new_max;
> +	int cgroup_fd, ret;
> +	struct memcg_async_reclaim *skel;
> +	struct bpf_link *link = NULL;
> +	char data_file1[] = "/tmp/test_data_1_XXXXXX";
> +	char data_file2[] = "/tmp/test_data_2_XXXXXX";

Can skel be dereferenced if it isn't initialized? The skel variable is
declared without initialization to NULL, while link is explicitly
initialized to NULL. If control reaches the cleanup block without
memcg_async_reclaim__open_and_load() succeeding, skel remains
uninitialized:

> +cleanup:
> +	bpf_link__destroy(link);
> +	memcg_async_reclaim__detach(skel);
> +	memcg_async_reclaim__destroy(skel);

The generated detach and destroy helpers will dereference skel through
obj->skeleton. Other tests in prog_tests/ check if (skel) before calling
detach/destroy to handle this case safely.

This was raised by XIAO WU in v6 review
(https://lore.kernel.org/all/20260423171516.00004adc@gmail.com/) in the
context of memcg_ops hierarchies test, but the same pattern appears in
this new async_reclaim test added in v7.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26429228214
--===============0436309527624145819==--

