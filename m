Return-Path: <cgroups+bounces-13396-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIpND7Q9c2kztgAAu9opvQ
	(envelope-from <cgroups+bounces-13396-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 10:21:56 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1A4732C9
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 10:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A760305DED3
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 09:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4A5310647;
	Fri, 23 Jan 2026 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5SCKLXy"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBEF309DCB;
	Fri, 23 Jan 2026 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769159941; cv=none; b=mr4LrCXVwQ6D8mFcIpd5feWj9H/TFXIhRlnLzwJg6KLCLUn32FrVvlrA4cDAyzolNqbwKYWnFscZVf/bfCSqkK7XvV+7DbtC4OGaVP0WfgfCgxU0rQ3RQNVvGM4/n7fOgThClZCzdoz3V7racSbyIm6U50cPLS4UddgI8RLnLmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769159941; c=relaxed/simple;
	bh=lAPN0HhdMwPzTnR1YDIQgmBs7lFW2+TjNgBMANKYj8Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EYNyBprusl6f58nGCsBO3VrFODESkRybtYMOQ+TvqEsfskyasFqqcfS87FZdGCuprGsqbhE9gREzvOSmaPm2xc+fYOTzfVWaoRV22dkiR0bVl7Ku2NLOR/M6d99z1bLz0EhCH0Wl/bWEHbRzDeJdqgPfnWaDCLMD/eUatwTLxhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5SCKLXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBFFC19422;
	Fri, 23 Jan 2026 09:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769159941;
	bh=lAPN0HhdMwPzTnR1YDIQgmBs7lFW2+TjNgBMANKYj8Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=N5SCKLXyAELrFNy+gkbgIPeqfEvjDDv6H9Nvceu5DlOURyvJQieEH89DsJoE871Lq
	 F2KUj/E1ZofIKSKhXCfShq5QIzhc1EcGMdvPIHwDrDBUa1pQuvRAG1+OsMTUnHte5F
	 /HOCWw4+OY36AeeDHJA09t7H3R1zVLSMM461NItNIhQ6QMp6xN2sNq9SBi/saCLzcy
	 k771BwY2DcyxlCXkJim6NjWEBd9Drwa3SKlUi9lSmE4oJ3fygQGYmlJiUQYGIRQT8m
	 uyRo+ni/Wa9GwHvAM16GSiQ3a4Klus5nCUx1cvz/JOXgUw6S8/ZUxtBxt3MQK0lzUf
	 mlUpBzxraCRvw==
Content-Type: multipart/mixed; boundary="===============6891829209060571098=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0031e5a293a89b42ac55e019d44bc9cf6ad0eca5ab75f07eb1f12b46a5ec560c@mail.kernel.org>
In-Reply-To: <e6ec046aab6205c6c381fdc4860decf6b8643ea8.1769157382.git.zhuhui@kylinos.cn>
References: <e6ec046aab6205c6c381fdc4860decf6b8643ea8.1769157382.git.zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH bpf-next v3 12/12] samples/bpf: Add memcg priority control example
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,akpm@linux-foundation.org,hannes@cmpxchg.org,mhocko@kernel.org,roman.gushchin@linux.dev,shakeel.butt@linux.dev,muchun.song@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,peterz@infradead.org,ojeda@kernel.org,nathan@kernel.org,kees@kernel.org,tj@kernel.org,jeffxu@chromium.org,mkoutny@suse.com,kernel@jfarr.cc,brauner@kernel.org,rdunlap@infradead.org,brgerst@gmail.com,masahiroy@kernel.org,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,inwardvessel@gmail.com,willemb@google.com,kerneljasonxing@gmail.com,paul.chaignon@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,chenridong@huaweicloud.com,lance.yang@linux.dev,jiayuan.chen@linux.dev,linux-kernel@vger.kernel.org,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,linu
 x-kselftest@vger.kernel.org
Cc: zhuhui@kylinos.cn,geliang@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 23 Jan 2026 09:18:59 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,cgroups@vger.kernel.org];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	TAGGED_FROM(0.00)[bounces-13396-lists,cgroups=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kylinos.cn,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	FREEMAIL_TO(0.00)[linux.dev,linux-foundation.org,cmpxchg.org,kernel.org,iogearbox.net,gmail.com,fomichev.me,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,davemloft.net,huaweicloud.com,vger.kernel.org,kvack.org];
	NEURAL_SPAM(0.00)[0.798];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	RCPT_COUNT_GT_50(0.00)[60];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E1A4732C9
X-Rspamd-Action: no action

--===============6891829209060571098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index 95a4fa1f1e44..6416c8aa3034 100644

[ ... ]

> @@ -360,6 +366,7 @@ BPF_SKELS_LINKED := $(addprefix $(obj)/,$(LINKED_SKELS))
>
>  $(BPF_SKELS_LINKED): $(BPF_OBJS_LINKED) $(BPFTOOL)
>  	@echo "  BPF GEN-OBJ " $(@:.skel.h=)
> +	echo $(Q)$(BPFTOOL) gen object $(@:.skel.h=.lbpf.o) $(addprefix $(obj)/,$($(@F)-deps))
>  	$(Q)$(BPFTOOL) gen object $(@:.skel.h=.lbpf.o) $(addprefix $(obj)/,$($(@F)-deps))

Was this debug echo intended to be left in? The line without the @ prefix
will print the unexpanded command during the build, which looks like
leftover debug output.

> diff --git a/samples/bpf/memcg.c b/samples/bpf/memcg.c
> new file mode 100644
> index 000000000000..85432cb01c27
> --- /dev/null
> +++ b/samples/bpf/memcg.c

[ ... ]

> +	high_cgroup_id = get_cgroup_id(high_path);
> +	if (!high_cgroup_id)
> +		goto out;
> +	high_cgroup_fd = open(high_path, O_RDONLY);
> +	if (high_cgroup_fd < 0) {
> +		fprintf(stderr,
> +			"ERROR: open high cgroup '%s' failed: %d\n",
> +			low_path, errno);
                        ^^^^^^^^

Should this be high_path instead of low_path? The error message says
"open high cgroup" but prints low_path.

[ ... ]

> +	struct bpf_link *link = NULL, *link_low = NULL, *link_high = NULL;

[ ... ]

> +	if (over_high_ms) {

[ ... ]

> +		link_low = bpf_map__attach_struct_ops_opts(map, &opts);

[ ... ]

> +	if (use_below_low || use_below_min) {
> +		map = bpf_object__find_map_by_name(obj, "high_mcg_ops");

[ ... ]

> +		link_low = bpf_map__attach_struct_ops_opts(map, &opts);
                ^^^^^^^^

This assigns to link_low again, overwriting the previous link if both
over_high_ms and (use_below_low || use_below_min) are set. Should this
be link_high instead? The link_high variable is declared but never
assigned, and the first bpf_link would be leaked in this scenario.

[ ... ]

> +out:
> +	bpf_link__destroy(link);
> +	bpf_link__destroy(link_low);
> +	bpf_link__destroy(link_high);

Here link_high is always NULL since it was never assigned above.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21280790825

--===============6891829209060571098==--

