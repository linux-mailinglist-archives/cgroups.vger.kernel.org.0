Return-Path: <cgroups+bounces-13673-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG4cFowSg2kPhQMAu9opvQ
	(envelope-from <cgroups+bounces-13673-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Feb 2026 10:34:04 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CFFE3E71
	for <lists+cgroups@lfdr.de>; Wed, 04 Feb 2026 10:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0097330CB9A9
	for <lists+cgroups@lfdr.de>; Wed,  4 Feb 2026 09:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92893A961E;
	Wed,  4 Feb 2026 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRAuHi/9"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960F03A9013;
	Wed,  4 Feb 2026 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770197321; cv=none; b=lZPyo49IyNYjxSGYgc70mZVIOjDJutysUH7Nl0TA9v0IH4k8I8949LqGI5cp+QpSIRnapwT+h18FEFETygYK6jk9pjP+NbYAigruXY2o8GCHvbXp4QrOga0iGEcYq1+xsIBONPa4/OTr6E9DP+hACpf5XrDt5aPbMH19YcY0TvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770197321; c=relaxed/simple;
	bh=i23KQLYVqaaHnlpy1V0F8zPNsHw9NrW9Nh2uMyA77DM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Q7KCI1rWvwBmULvNoQo6E1G+G4h+A8W04BjkUUm1t4vq9zxVnhrswhYcQuruRbr8+PtbB18DDlCQoRNFqCOYzaFKqawR7bsayTc/dT+3apmYn8PUIPYag+FIMBjPhTElX9sgnWtkoqe7d9K+9TUMXjFcBUoZkUzfNbppR//qdRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRAuHi/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D594C16AAE;
	Wed,  4 Feb 2026 09:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770197321;
	bh=i23KQLYVqaaHnlpy1V0F8zPNsHw9NrW9Nh2uMyA77DM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=rRAuHi/9b6nRIdkkbZ67+NDu7rXjZLms2kDRQQY5YRkj+HMc6Tcm6Ue+GGDg15JN3
	 8iNAt7rzE6PnIQeTfujsWsGKPQmbRlq/Ec4mzAEu9cgi01vE5J455AqTm0gLcrXPS8
	 dJJjMC5t8LMiLEAquqID3+jRhVDJutOIw20gnfeHn7vflpmXmPtDfgDm6zmNkO/B/w
	 tH8lEow9AS4THlw/TIJV2+igES7T8gA9RTDC5iBpksU09Mi4ldhRCMKVOwBgMzWUBP
	 S/wkmmlxnCdp7Kj/Xdco9E3e7sGJB0mh2WZxtYj4GbbOvg8zTijhdPH/699xiPn0v4
	 xYiQivzyOvTPA==
Content-Type: multipart/mixed; boundary="===============6059499729326011323=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3b1737450f8be7b9ab2c4a7aab7bc1bd7bdcd74d8ad526c5d60cd45918ad9d3a@mail.kernel.org>
In-Reply-To: <3879deea2efdbc75740e985e6cdbd67a57aa5651.1770194182.git.zhuhui@kylinos.cn>
References: <3879deea2efdbc75740e985e6cdbd67a57aa5651.1770194182.git.zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH bpf-next v6 06/12] bpf: Pass flags in bpf_link_create for struct_ops
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,akpm@linux-foundation.org,hannes@cmpxchg.org,mhocko@kernel.org,roman.gushchin@linux.dev,shakeel.butt@linux.dev,muchun.song@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,peterz@infradead.org,ojeda@kernel.org,nathan@kernel.org,kees@kernel.org,tj@kernel.org,jeffxu@chromium.org,mkoutny@suse.com,kernel@jfarr.cc,brauner@kernel.org,rdunlap@infradead.org,brgerst@gmail.com,masahiroy@kernel.org,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,inwardvessel@gmail.com,willemb@google.com,kerneljasonxing@gmail.com,paul.chaignon@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,chenridong@huaweicloud.com,lance.yang@linux.dev,jiayuan.chen@linux.dev,linux-kernel@vger.kernel.org,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,linu
 x-kselftest@vger.kernel.org
Cc: zhuhui@kylinos.cn,geliang@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  4 Feb 2026 09:28:40 +0000 (UTC)
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
	TAGGED_FROM(0.00)[bounces-13673-lists,cgroups=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kylinos.cn,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	FREEMAIL_TO(0.00)[linux.dev,linux-foundation.org,cmpxchg.org,kernel.org,iogearbox.net,gmail.com,fomichev.me,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,davemloft.net,huaweicloud.com,vger.kernel.org,kvack.org];
	NEURAL_SPAM(0.00)[0.975];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Queue-Id: F2CFFE3E71
X-Rspamd-Action: no action

--===============6059499729326011323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> UAPI Change:
> This patch updates the comment in include/uapi/linux/bpf.h to reflect
> that the cgroup-bpf attach flags (such as BPF_F_ALLOW_OVERRIDE) are
> now applicable to both BPF_PROG_ATTACH and BPF_LINK_CREATE commands.

The commit message states that include/uapi/linux/bpf.h was updated, but
the diff shows only tools/include/uapi/linux/bpf.h was modified.

Should include/uapi/linux/bpf.h also be updated to match? Currently the
main UAPI header still says:

    /* cgroup-bpf attach flags used in BPF_PROG_ATTACH command

while the tools copy now says:

    /* cgroup-bpf attach flags used in BPF_PROG_ATTACH and BPF_LINK_CREATE command

This leaves the two copies inconsistent.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21665371660

AI-authorship-score: low
AI-authorship-explanation: The minimal code change, multi-author collaboration, and human-like error in the commit message suggest human authorship, though the well-structured commit message has some AI-like characteristics.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: The commit message incorrectly claims to update include/uapi/linux/bpf.h when only tools/include/uapi/linux/bpf.h was modified, leaving the two UAPI header copies inconsistent.

--===============6059499729326011323==--

