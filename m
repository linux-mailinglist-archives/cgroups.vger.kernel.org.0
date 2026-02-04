Return-Path: <cgroups+bounces-13672-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPqIJVgRg2kPhQMAu9opvQ
	(envelope-from <cgroups+bounces-13672-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Feb 2026 10:28:56 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7700EE3D6D
	for <lists+cgroups@lfdr.de>; Wed, 04 Feb 2026 10:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A5C26300CA14
	for <lists+cgroups@lfdr.de>; Wed,  4 Feb 2026 09:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0483A7F6B;
	Wed,  4 Feb 2026 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzqnLDSc"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE6C3A783C;
	Wed,  4 Feb 2026 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770197319; cv=none; b=Vi3z7s7IAIE64ObkBq6wntHvFt013pcRYVe6GkC//A56JZzAGDgZEuAajafoneXNEwjBYVFHxlR8iGJrn1Bv/jW+5VJasnskf3CkMV2Gvh7+GAWcAl6aC7nJGqXwbOGL2/O0ov7o6BShUu2LLHZeONajPU8OS4WYGlB4sa2BJM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770197319; c=relaxed/simple;
	bh=hGv/7w//6+bCcJo2PoukH/3G/bRcielsG9LBWTo4Xxs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PRBbUhIHxcwKiz9GaKs+HdQW2H97qnqMV0l42E1mypyodPjEy+eFVoDDtNyVyX19vVgeUTu723Rg+AVVeNZ4wrKU8Ji2knW8JAoGeM9k9z3fc1ntXPjsiNPUcEDZV2z93tBqzTMVxFongT4ItbBLUUVM7U030CcLk9c07D1e5nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzqnLDSc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D89DC19422;
	Wed,  4 Feb 2026 09:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770197319;
	bh=hGv/7w//6+bCcJo2PoukH/3G/bRcielsG9LBWTo4Xxs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=EzqnLDScBdg66jVR9qskXzcwt+V6OKIQknHhwE1F13tcaR/J7Wax2gr1CLNouXDeY
	 Sb6Y2Wd9CC6L47/enfwulnvn7vJ76DSUUYDcfYNqojAtqDNRH3F6M+R52DfTrfp6Hi
	 j8lA2Kx2TMmNSnO0NjHOR4kKSpo3zpPTRmUyxbmDkrO6bDRW71CLRtc/mNYr2qFoGv
	 CMHweO7NFbe5TwniqrilV/mIjfwivrGitu9jS6L27Z5DaBDVqmHzd9ZCvz5NXw5F8O
	 2Jhm/egfVtUizGxtKFz66Uk0g2szjonCTRUALOn2xE4gSA1WVM53b8r5C5LoLcHegX
	 7uIDb5+/PYduQ==
Content-Type: multipart/mixed; boundary="===============2395984818963869282=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0044b4c0aa82681725d87d242bc1ce63f5ee3cdd330f0262b042a334688f03e5@mail.kernel.org>
In-Reply-To: <ba2cd1640447097cece1560dd7183bc3db39c57a.1770194182.git.zhuhui@kylinos.cn>
References: <ba2cd1640447097cece1560dd7183bc3db39c57a.1770194182.git.zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH bpf-next v6 07/12] libbpf: Support passing user-defined flags for struct_ops
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,akpm@linux-foundation.org,hannes@cmpxchg.org,mhocko@kernel.org,roman.gushchin@linux.dev,shakeel.butt@linux.dev,muchun.song@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,peterz@infradead.org,ojeda@kernel.org,nathan@kernel.org,kees@kernel.org,tj@kernel.org,jeffxu@chromium.org,mkoutny@suse.com,kernel@jfarr.cc,brauner@kernel.org,rdunlap@infradead.org,brgerst@gmail.com,masahiroy@kernel.org,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,inwardvessel@gmail.com,willemb@google.com,kerneljasonxing@gmail.com,paul.chaignon@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,chenridong@huaweicloud.com,lance.yang@linux.dev,jiayuan.chen@linux.dev,linux-kernel@vger.kernel.org,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,linu
 x-kselftest@vger.kernel.org
Cc: zhuhui@kylinos.cn,geliang@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  4 Feb 2026 09:28:38 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,cgroups@vger.kernel.org];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	TAGGED_FROM(0.00)[bounces-13672-lists,cgroups=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kylinos.cn,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	FREEMAIL_TO(0.00)[linux.dev,linux-foundation.org,cmpxchg.org,kernel.org,iogearbox.net,gmail.com,fomichev.me,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,davemloft.net,huaweicloud.com,vger.kernel.org,kvack.org];
	NEURAL_SPAM(0.00)[0.974];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	RCPT_COUNT_GT_50(0.00)[60];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Queue-Id: 7700EE3D6D
X-Rspamd-Action: no action

--===============2395984818963869282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> The `bpf_struct_ops_opts` struct is extended with a `flags` member,
> which is then passed to the `bpf_link_create` syscall within
> `bpf_map__attach_struct_ops_opts`.

The commit message states the struct is "extended with a `flags` member", but
the flags field already exists in bpf_struct_ops_opts. It was added in commit
a09c73b18 ("libbpf: introduce bpf_map__attach_struct_ops_opts()"):

    struct bpf_struct_ops_opts {
        size_t sz;
        __u32 flags;
        __u32 relative_fd;
        __u64 expected_revision;
        size_t :0;
    };

This patch adds code to USE the existing flags field, not extend the struct.
Would a message like "Pass the existing flags field from bpf_struct_ops_opts
to bpf_link_create" be more accurate?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21665371660

AI-authorship-score: medium
AI-authorship-explanation: The commit message contains a factual inaccuracy about extending the struct when the field already existed, which could indicate AI-generated text that didn't fully analyze the prior commit in the series.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: The only issue is an inaccurate commit message that claims to extend a struct with a field that already exists; this is a documentation issue, not a code bug.

--===============2395984818963869282==--

