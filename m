Return-Path: <cgroups+bounces-13473-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EA6FMWPeGmarAEAu9opvQ
	(envelope-from <cgroups+bounces-13473-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 11:13:25 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2950928A8
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 11:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5B243078C91
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 10:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51ADB2EBBB7;
	Tue, 27 Jan 2026 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Miit5XPl"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE882E7F39;
	Tue, 27 Jan 2026 10:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769508511; cv=none; b=MvPEuf14aLLkcOR8yEPA/KgmEE1g4tIiqrEIWgsYRAEruzKmaVyrT3MI7ydVjWDH4eAdHSKlcMqkUrepyc8bDaoUSURHOMshC4sY28V4gx0ii/Ic11MJMouPCG2yqbVVqp058DzojkJOb/IS6sQ50j3JElSFSGdv1TVyFBZVIGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769508511; c=relaxed/simple;
	bh=YzokodqmRv7baDmZfSZRrm1pBfaNJEn2jzrXGQM+254=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bPUnJHdsMGt+1UF66fbtxe1k6756wuzwP9TEMT4X8OlV+QlB2rvQFnthJS5gHaO4XhZ4rmBK+t1+NYXl+LDu/vcX2tAOasS7/faSJXF4pcP2gtuZTwMchZ7EBt98zQneYvxkBPRdVxYkQqt8budp0r77Tqh9tIH1ttxOwbSe8ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Miit5XPl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A086EC116C6;
	Tue, 27 Jan 2026 10:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769508510;
	bh=YzokodqmRv7baDmZfSZRrm1pBfaNJEn2jzrXGQM+254=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Miit5XPld5MLyihi4exevpHeI+AjmN2+wmSrfG28Uw6DBocXcUTH5DWZNBbFNeuXj
	 yoHBAcucJ/42ARYyBUhwwVSn47ytuFHXJ/RlBtyCtWh/q/WBj3zzCmOA+h6riy191D
	 s6rS0C9mUgE0xPPu2NaUa5+vdCpDZGlzWT86CTkqgHL0Mih7pJLCUle1biVayEGoTS
	 YrZ2+fJ2Qxx2Ie3yEmAiilU9FI2AcfC7zG/Sq1bl5va3BmHOgu/iU7R4XUA7cZJwHc
	 bCJQtJgDYqyMO4lqWjnmlmVClDSorbh0lSUCQfVuIMZuhQjtQ6drF8+R5nBixvP3p3
	 QdQg8Q9FqpUfg==
Content-Type: multipart/mixed; boundary="===============2579571787754050133=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <25d7b7ce5d8358f2d2dd9fc50e74596872b86aae1488b67cea6f85715e8f91de@mail.kernel.org>
In-Reply-To: <ef784786a2e38c2effca5f331f11658eeafd5f3e.1769506741.git.zhuhui@kylinos.cn>
References: <ef784786a2e38c2effca5f331f11658eeafd5f3e.1769506741.git.zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH bpf-next v5 12/12] samples/bpf: Add memcg priority control example
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,akpm@linux-foundation.org,hannes@cmpxchg.org,mhocko@kernel.org,roman.gushchin@linux.dev,shakeel.butt@linux.dev,muchun.song@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,peterz@infradead.org,ojeda@kernel.org,nathan@kernel.org,kees@kernel.org,tj@kernel.org,jeffxu@chromium.org,mkoutny@suse.com,kernel@jfarr.cc,brauner@kernel.org,rdunlap@infradead.org,brgerst@gmail.com,masahiroy@kernel.org,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,inwardvessel@gmail.com,willemb@google.com,kerneljasonxing@gmail.com,paul.chaignon@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,chenridong@huaweicloud.com,lance.yang@linux.dev,jiayuan.chen@linux.dev,linux-kernel@vger.kernel.org,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,linu
 x-kselftest@vger.kernel.org
Cc: zhuhui@kylinos.cn,geliang@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 27 Jan 2026 10:08:29 +0000 (UTC)
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
	TAGGED_FROM(0.00)[bounces-13473-lists,cgroups=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_TO(0.00)[linux.dev,linux-foundation.org,cmpxchg.org,kernel.org,iogearbox.net,gmail.com,fomichev.me,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,davemloft.net,huaweicloud.com,vger.kernel.org,kvack.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:-];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+];
	RCPT_COUNT_GT_50(0.00)[60];
	NEURAL_HAM(-0.00)[-0.997];
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
X-Rspamd-Queue-Id: E2950928A8
X-Rspamd-Action: no action

--===============2579571787754050133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/samples/bpf/memcg.bpf.c b/samples/bpf/memcg.bpf.c
> new file mode 100644
> index 000000000000..e611ac0e641a
> --- /dev/null
> +++ b/samples/bpf/memcg.bpf.c

[ ... ]

> +SEC("tp/memcg/count_memcg_events")
> +int
> +handle_count_memcg_events(struct trace_event_raw_memcg_rstat_events *ctx)
> +{
> +	u32 key = 0;
> +	struct AggregationData *data;
> +	u64 current_ts;
> +
> +	if (ctx->id != local_config.high_cgroup_id ||
> +	    (ctx->item != PGFAULT))
                         ^^^^^^^

The BPF code monitors PGFAULT events here.

> diff --git a/samples/bpf/memcg.c b/samples/bpf/memcg.c
> new file mode 100644
> index 000000000000..0c47ed53f6ae
> --- /dev/null
> +++ b/samples/bpf/memcg.c

[ ... ]

> +static void usage(char *name)
> +{

[ ... ]

> +	fprintf(stderr,
> +		"  -t, --threshold=VALUE  The sum of 'val' PGSCAN of\n");
                                                     ^^^^^^

Should this say PGFAULT instead of PGSCAN? The commit message and the BPF
code in memcg.bpf.c both indicate that the program monitors PGFAULT events,
but the help text here mentions PGSCAN.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21392729810

AI-authorship-score: low
AI-authorship-explanation: Code is a straightforward adaptation of existing selftest code with standard kernel patterns; documentation error is more consistent with human copy-paste mistake than AI generation.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Documentation mismatch in help text (PGSCAN vs PGFAULT) could cause user confusion but has no runtime impact.

--===============2579571787754050133==--

