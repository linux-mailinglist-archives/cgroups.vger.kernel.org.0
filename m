Return-Path: <cgroups+bounces-13474-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gINhIraOeGmqqwEAu9opvQ
	(envelope-from <cgroups+bounces-13474-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 11:08:54 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B9292767
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 11:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5903D30074A9
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 10:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755812EAB6B;
	Tue, 27 Jan 2026 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkWZSo7P"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254BD2EA16A;
	Tue, 27 Jan 2026 10:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769508513; cv=none; b=aVoSIzgXS8f9YdfjaNwv2ihDqbmAqFl6y6FTkZTubtx4/P2qsaOzqRMQdPPkqz2xoXmx5l11Ni5Zif1VKJcXZ9iviZNRJPEjDua54E+Qz2fU8bZW4SoIOSwsAUcMdF6uJC/GGRf0s4Com9NivQ2A3BXvuwoPj4go/OjF6vjfzzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769508513; c=relaxed/simple;
	bh=cy8xGVioBJHrY+OkOh4J/GrPQP8YQgHcws3ff81U3Ko=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Bwsdrseb+1aH0WqtNYpHVAre5kqg5jY9Ala3S6s65ny2IREd/MSBIs7aB8xef9GJqD8BB2icQ23qG73xyHa+hxf1gJzzUBwIqb51NErSsH3SkR5XzG5CzzL4zadKAHk5zbRR4dkJjJOl6/Bqcva1ZGJkVsT36ChWIsFvsFfy4B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkWZSo7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CD6C116C6;
	Tue, 27 Jan 2026 10:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769508512;
	bh=cy8xGVioBJHrY+OkOh4J/GrPQP8YQgHcws3ff81U3Ko=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=QkWZSo7P+uvsQFRqjZU2/MEn3LFFKSGP8uzTF83Ktz0a8JbxiiG3oUXSED78YLS6v
	 5ssWJ/1MFokjk5gx1S2wSXzZIs/quR94uCeO3/rTYJGbbKpCTe6U6qcrMF9L/5k9Da
	 u2C5zU0e0kCiXXq/et2CoNWMsT0kypjuXv0e/6ktqoxvZCW03AHGxaw9IrWoOnR2ws
	 0SnkL0lzIzzEJwikvU2NxvYItrCKLabKWSQdR10jSTNwdmxE7CB00+/ANHx48rqs6o
	 d/HBwBtgOXpiuR0hgI2sC0cxKpbIrv6INxhTK7M0uNebxa93K/Vc3jrkJp2tiht4B8
	 5R/oSenmYBOPA==
Content-Type: multipart/mixed; boundary="===============3455022572687602342=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7a66cf5f0e6a1e441fde4e593b26326132bd100531a9a1c5d318edf526ad6a6c@mail.kernel.org>
In-Reply-To: <635923ceadf1899672e4f7727ddc52554c11a3ac.1769506741.git.zhuhui@kylinos.cn>
References: <635923ceadf1899672e4f7727ddc52554c11a3ac.1769506741.git.zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH bpf-next v5 05/12] libbpf: introduce bpf_map__attach_struct_ops_opts()
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,akpm@linux-foundation.org,hannes@cmpxchg.org,mhocko@kernel.org,roman.gushchin@linux.dev,shakeel.butt@linux.dev,muchun.song@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,peterz@infradead.org,ojeda@kernel.org,nathan@kernel.org,kees@kernel.org,tj@kernel.org,jeffxu@chromium.org,mkoutny@suse.com,kernel@jfarr.cc,brauner@kernel.org,rdunlap@infradead.org,brgerst@gmail.com,masahiroy@kernel.org,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,inwardvessel@gmail.com,willemb@google.com,kerneljasonxing@gmail.com,paul.chaignon@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,chenridong@huaweicloud.com,lance.yang@linux.dev,jiayuan.chen@linux.dev,linux-kernel@vger.kernel.org,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,linu
 x-kselftest@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 27 Jan 2026 10:08:31 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	TAGGED_FROM(0.00)[bounces-13474-lists,cgroups=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_TO(0.00)[linux.dev,linux-foundation.org,cmpxchg.org,kernel.org,iogearbox.net,gmail.com,fomichev.me,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,davemloft.net,huaweicloud.com,vger.kernel.org,kvack.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:-];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+];
	RCPT_COUNT_GT_50(0.00)[58];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Queue-Id: 30B9292767
X-Rspamd-Action: no action

--===============3455022572687602342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 5846de364209..84a53c594f48 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -884,6 +884,14 @@ int bpf_link_create(int prog_fd, int target_fd,
>  		if (!OPTS_ZEROED(opts, cgroup))
>  			return libbpf_err(-EINVAL);
>  		break;
> +	case BPF_STRUCT_OPS:
> +		relative_fd = OPTS_GET(opts, cgroup.relative_fd, 0);
> +		attr.link_create.cgroup.relative_fd = relative_fd;
> +		attr.link_create.cgroup.expected_revision =
> +			OPTS_GET(opts, cgroup.expected_revision, 0);

The bpf_link_create() BPF_STRUCT_OPS case reads expected_revision from
the opts, but looking at bpf_map__attach_struct_ops_opts() below...

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0c8bf0b5cce4..70a00da54ff5 100644
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

Should there also be a line here to forward expected_revision? The
bpf_struct_ops_opts struct defines expected_revision and the BPF_STRUCT_OPS
case in bpf_link_create() reads it, but this function only sets relative_fd.
If a user passes expected_revision in their opts, it appears to be silently
ignored.

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index dfc37a615578..5aef44bcfcc2 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h

[ ... ]

> +struct bpf_struct_ops_opts {
> +	/* size of this struct, for forward/backward compatibility */
> +	size_t sz;
> +	__u32 flags;
> +	__u32 relative_fd;
> +	__u64 expected_revision;
                ^^^^^^^^^^^^^^^^
> +	size_t :0;
> +};
> +#define bpf_struct_ops_opts__last_field expected_revision

The expected_revision field is declared here and is even the __last_field,
but it does not appear to be forwarded to bpf_link_create_opts in
bpf_map__attach_struct_ops_opts(). Is this intentional, or was the
forwarding line missed?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21392729810

AI-authorship-score: low
AI-authorship-explanation: Commit message and code follow standard kernel/libbpf conventions without unusual patterns typically associated with AI-generated content.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: The expected_revision field in bpf_struct_ops_opts is defined but silently ignored, which could cause unexpected behavior for users relying on revision checking, but does not cause crashes or security issues.

--===============3455022572687602342==--

