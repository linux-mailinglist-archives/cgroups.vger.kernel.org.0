Return-Path: <cgroups+bounces-13399-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GP3LGQY+c2kztgAAu9opvQ
	(envelope-from <cgroups+bounces-13399-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 10:23:18 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AB67335C
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 10:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB45F301983A
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 09:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B264631690E;
	Fri, 23 Jan 2026 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiwWVxqw"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A65C33FE36;
	Fri, 23 Jan 2026 09:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769159949; cv=none; b=cpIiQai7X8efslQ0Pox+36Y6gY4+NyTXeAvpPbdDxhhhKFeQ/bTQMivzegS4vPfuel+1jUq9TTkXWU7hi4iBiKtrpbe7PiwxHPhWt5Ujg4VmTi49trSGB10jEoJbBsEZy8S384iBwSXljXgni46ABff4tAj4LLxFQKdRYsgks4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769159949; c=relaxed/simple;
	bh=sxaiTV/qjZ9OJLWuPUm5lpJHeVnyKAH5pIqR5axWKB8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=J3fuQ9i1AXeDENuSC8vZu1NoruhuDy5Q0tE+JYH22dQJNqBwffnls9BEsIjfmiTZm5OCkJPycWTfPBCetNSvnsovX2yKzKwdxBQTX3+gr3Eu2d6gLj7ax3ijzjC0fVt8WP7bkKmggAuYdIIogpNJ2q3O8lAqoPIoABB4p2CVTWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiwWVxqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4B0C116D0;
	Fri, 23 Jan 2026 09:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769159943;
	bh=sxaiTV/qjZ9OJLWuPUm5lpJHeVnyKAH5pIqR5axWKB8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=kiwWVxqwhLtICIYNAcF3V6WIubpaoam1UBgKy1c2x3txZXWC6q/CUSDTEEgAIWnSk
	 KXT8Dfsl3g+fQTcj94wL+fWM2u3jZ+5yLtLVsPdtlBrnoX57qVIjJizC7LlhxREbHT
	 x2USTPdVOG0S2IAJPc4BQnNEkGTBLTEfKce5lBHI1nRyFBGI6UqYtkurROa0l8JFD8
	 gyqpPZwgCw4cJEyO+prp7szjajg5CiSXvHZ7geqQGSFMMxg8yVs7rwhv28gEDMRUNj
	 v9rjQiJ1HImsMMOLlPkKxHg7gD4JcfQuCeGjIlq9QebL7CahgT/cSaNgLXTQnrxb9L
	 H8CcOpfVl2dYQ==
Content-Type: multipart/mixed; boundary="===============6020917005380425134=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <30378be80fdf3abf59019b02fe9dd351d63e9d71b9f074a9dd79de1b6a9bd6c9@mail.kernel.org>
In-Reply-To: <03bf6aafe30def690c63e454d76e733f27dff4b3.1769157382.git.zhuhui@kylinos.cn>
References: <03bf6aafe30def690c63e454d76e733f27dff4b3.1769157382.git.zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH bpf-next v3 05/12] libbpf: introduce bpf_map__attach_struct_ops_opts()
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,akpm@linux-foundation.org,hannes@cmpxchg.org,mhocko@kernel.org,roman.gushchin@linux.dev,shakeel.butt@linux.dev,muchun.song@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,peterz@infradead.org,ojeda@kernel.org,nathan@kernel.org,kees@kernel.org,tj@kernel.org,jeffxu@chromium.org,mkoutny@suse.com,kernel@jfarr.cc,brauner@kernel.org,rdunlap@infradead.org,brgerst@gmail.com,masahiroy@kernel.org,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,inwardvessel@gmail.com,willemb@google.com,kerneljasonxing@gmail.com,paul.chaignon@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,chenridong@huaweicloud.com,lance.yang@linux.dev,jiayuan.chen@linux.dev,linux-kernel@vger.kernel.org,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,linu
 x-kselftest@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 23 Jan 2026 09:19:02 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,cgroups@vger.kernel.org];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	TAGGED_FROM(0.00)[bounces-13399-lists,cgroups=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	FREEMAIL_TO(0.00)[linux.dev,linux-foundation.org,cmpxchg.org,kernel.org,iogearbox.net,gmail.com,fomichev.me,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,davemloft.net,huaweicloud.com,vger.kernel.org,kvack.org];
	NEURAL_SPAM(0.00)[0.890];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	RCPT_COUNT_GT_50(0.00)[58];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Queue-Id: C5AB67335C
X-Rspamd-Action: no action

--===============6020917005380425134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index d18fbcea7578..2bf514462045 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -453,5 +453,5 @@ LIBBPF_1.7.0 {
>  		bpf_map__exclusive_program;
>  		bpf_prog_assoc_struct_ops;
>  		bpf_program__assoc_struct_ops;
> -		btf__permute;
> +		bpf_map__attach_struct_ops_opts;
>  } LIBBPF_1.6.0;

Was the removal of btf__permute from the symbol map intentional? The function
is still implemented in btf.c and declared with LIBBPF_API in btf.h.

It looks like the line was replaced instead of having a new line added. This
would break applications using btf__permute() with link-time or runtime errors.

Perhaps this should be:

  bpf_program__assoc_struct_ops;
  bpf_map__attach_struct_ops_opts;
  btf__permute;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21280790825

--===============6020917005380425134==--

