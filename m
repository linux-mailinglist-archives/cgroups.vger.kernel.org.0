Return-Path: <cgroups+bounces-13674-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKgaBKgRg2kPhQMAu9opvQ
	(envelope-from <cgroups+bounces-13674-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Feb 2026 10:30:16 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7735DE3DB2
	for <lists+cgroups@lfdr.de>; Wed, 04 Feb 2026 10:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 253C23016B3B
	for <lists+cgroups@lfdr.de>; Wed,  4 Feb 2026 09:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3683A9D88;
	Wed,  4 Feb 2026 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFSx54P8"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8FD3A7F4C;
	Wed,  4 Feb 2026 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770197323; cv=none; b=aAS8da+0NHqKH0QnBotC6/OvaPb+xM6mRgzU8Oq8oR34U+wFr9zJNU7796OI3DGW+RsxXV9vDrihPC425u4z5IORjlC4tWkMcI7HnVVpaUEeqRhdGOD/nnW9fn9Bi2wBB9o5KUGcBCh7NxcsCLsliHYokn7knqo7l6jrTRMKif0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770197323; c=relaxed/simple;
	bh=wNmreD1B96IJwY1XBdvP/FHXcUDoGKx185+NrO65AHU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NMHNgkg2wGxjjGyhj+N9q/tksSBzcHJ/KFcK1z4FM8nFBYnSbiORhqDKDJqtzUIMehhQLlJfGi3r/GbsTDMZUTAj33+6E4xiq1l4VCS3RPcHr3plnWRvZ4n+twk00/MuXvDpIaLyc33x32NRklm2DOHvwA/nXq4/sevfn8wgILQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFSx54P8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF48BC4CEF7;
	Wed,  4 Feb 2026 09:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770197323;
	bh=wNmreD1B96IJwY1XBdvP/FHXcUDoGKx185+NrO65AHU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=AFSx54P8bWsWcKCo3dw/7CAusa6aLI+b4yMUNsGB4Ux5ceAOJBU7zoi3JUNOzBbYc
	 9oHVWnYgY/WmA1CVyAo0UI6r+m3rYBgu3W9dUg0jiGqByoxz4+zHhbhueezyHgh6t7
	 kKrOxA9zuxkC5AOu5T8QDqCr828iKaIkn73q4V8BGl+VVWT73YZ47tyXsrSYlefftl
	 zmZmIw8ea/zJ1+/dLVH7dhbnqMImPbd486nAd7rnw4lMfwqC0nlSTceXptUMhXQ8HR
	 Ry8/jNQ4ib598H8RXm17+FE1TUvAWp3tT0Ae+bA6ETEpGYjkcZBZRVdsUVhSyIPShf
	 Q93mDkPKVXg9g==
Content-Type: multipart/mixed; boundary="===============6939426097549955783=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bec784d0d78a505dfbfbd17ffe95840dc356c80ceec2a96f9659b442b64c92c6@mail.kernel.org>
In-Reply-To: <8b9d7d9485c627dc05cdeb6863abd5a1c81c95ec.1770194182.git.zhuhui@kylinos.cn>
References: <8b9d7d9485c627dc05cdeb6863abd5a1c81c95ec.1770194182.git.zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH bpf-next v6 05/12] libbpf: introduce bpf_map__attach_struct_ops_opts()
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,akpm@linux-foundation.org,hannes@cmpxchg.org,mhocko@kernel.org,roman.gushchin@linux.dev,shakeel.butt@linux.dev,muchun.song@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,peterz@infradead.org,ojeda@kernel.org,nathan@kernel.org,kees@kernel.org,tj@kernel.org,jeffxu@chromium.org,mkoutny@suse.com,kernel@jfarr.cc,brauner@kernel.org,rdunlap@infradead.org,brgerst@gmail.com,masahiroy@kernel.org,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,inwardvessel@gmail.com,willemb@google.com,kerneljasonxing@gmail.com,paul.chaignon@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,chenridong@huaweicloud.com,lance.yang@linux.dev,jiayuan.chen@linux.dev,linux-kernel@vger.kernel.org,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,linu
 x-kselftest@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  4 Feb 2026 09:28:42 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,cgroups@vger.kernel.org];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	TAGGED_FROM(0.00)[bounces-13674-lists,cgroups=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	FREEMAIL_TO(0.00)[linux.dev,linux-foundation.org,cmpxchg.org,kernel.org,iogearbox.net,gmail.com,fomichev.me,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,davemloft.net,huaweicloud.com,vger.kernel.org,kvack.org];
	NEURAL_SPAM(0.00)[0.981];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	RCPT_COUNT_GT_50(0.00)[58];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Queue-Id: 7735DE3DB2
X-Rspamd-Action: no action

--===============6939426097549955783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0c8bf0b5c..70a00da54 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -13503,7 +13510,9 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
>  		return &link->link;
>  	}
>
> -	fd = bpf_link_create(map->fd, 0, BPF_STRUCT_OPS, NULL);
> +	link_opts.cgroup.relative_fd = OPTS_GET(opts, relative_fd, 0);
> +
> +	fd = bpf_link_create(map->fd, 0, BPF_STRUCT_OPS, &link_opts);

The expected_revision field from bpf_struct_ops_opts is defined in the public
API but doesn't appear to be forwarded here. bpf_link_create() reads
opts->cgroup.expected_revision for BPF_STRUCT_OPS, and similar functions like
bpf_program__attach_cgroup_opts() forward all fields including expected_revision.

Was the expected_revision field intentionally left unused, or should there be a
line here like:

    link_opts.cgroup.expected_revision = OPTS_GET(opts, expected_revision, 0);

Note: A later commit in this series (e83943e72 "libbpf: Support passing
user-defined flags for struct_ops") adds forwarding for the flags field, but
expected_revision remains unused through the end of the series.

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index dfc37a615..5aef44bcf 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -920,6 +920,20 @@ bpf_program__attach_cgroup_opts(const struct bpf_program *prog, int cgroup_fd,
>  struct bpf_map;
>
>  LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map);
> +
> +struct bpf_struct_ops_opts {
> +	/* size of this struct, for forward/backward compatibility */
> +	size_t sz;
> +	__u32 flags;
> +	__u32 relative_fd;
> +	__u64 expected_revision;
                ^^^^^^^^^^^^^^^^^
The expected_revision field is defined here but is not read by
bpf_map__attach_struct_ops_opts() in libbpf.c, so any value set by users
will be silently ignored.

> +	size_t :0;
> +};


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21665371660

AI-authorship-score: low
AI-authorship-explanation: The commit follows standard libbpf API extension patterns with consistent naming and structure typical of experienced kernel developers.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: The expected_revision field in the public API struct is silently ignored, which could confuse users but does not cause system instability or crashes.

--===============6939426097549955783==--

