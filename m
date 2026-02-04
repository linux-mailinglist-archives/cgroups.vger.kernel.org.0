Return-Path: <cgroups+bounces-13671-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CGwJSUSg2kPhQMAu9opvQ
	(envelope-from <cgroups+bounces-13671-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Feb 2026 10:32:21 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 419C4E3E25
	for <lists+cgroups@lfdr.de>; Wed, 04 Feb 2026 10:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F40730467F1
	for <lists+cgroups@lfdr.de>; Wed,  4 Feb 2026 09:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC043A7F41;
	Wed,  4 Feb 2026 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCC37vWy"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6093A7855;
	Wed,  4 Feb 2026 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770197317; cv=none; b=UkpZailz2GpWxImbcLSThNFHEj4Fodg3RkXGk55oO+Qgl40U97GWSIpkpgM0SersjjOzAuu9BakEia7EaA2KLqg+UkaxvufDzxWG61zCnq+BiwXmlHz5p2H0mVItoc1FExxw3r4nUv3HFbF2EZm3hMNqgVvPQQl+YtilGsVctoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770197317; c=relaxed/simple;
	bh=iLmLS/irenZofYvUMwo2u3+RQqPVVKJnWwXqNzruW7s=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=l31NMMcVl6+MIPKam4EQAYxxhv15Gw9DRidHwJkbGTg/j9CeuFu4rxQXuHNSMX67uST8lnPfGpW0htok+ZIhqmGRf3py7KumMCT0vQoJjGeVdu6XZqQ99pT4LfwH4b9K7reNuYCw2PeK1M6sYUfj6gyodFfhNcaicfgYrR2F1Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCC37vWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F87C2BC86;
	Wed,  4 Feb 2026 09:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770197317;
	bh=iLmLS/irenZofYvUMwo2u3+RQqPVVKJnWwXqNzruW7s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=YCC37vWyvS6r6gFjTX1IJ1uJZEPpkgORKe21i5o2FhLGTx+qsSxzl+ZI7UMe4Aqac
	 SF1OqDIUZKjWDlfn6ZEBDZxJN61PQDo0aVn3rRL7t1BXHzsEnUa3n7lDybRUTh2zgA
	 XshKQijMriVAdh5TzjaI4Wpr6v2lHovO8y7v9H+5M7QCcxL+8x9TFjkgMOFRfkGP9U
	 OFGgjqqhO1K2HjJjnCACwc0DwFqMEUwkCZoxDb5XYpYwk0PVMdcF2xi6J4mhMJRs7W
	 GMSbWUWNpq2bz3evxVGgpQy+CBXYPUb5PeenIPnGFZuZCrhy2hOnDBjMUgJ9tF+PNO
	 KCvqTPHY1cOzg==
Content-Type: multipart/mixed; boundary="===============4976973485721389665=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a1f4a2908ada3a81838bdddc64907529c53a5be29de83c928a70f2b3736783da@mail.kernel.org>
In-Reply-To: <d3e3dba90cf47c7da97a8a4142e7e816c5c1ace5.1770194182.git.zhuhui@kylinos.cn>
References: <d3e3dba90cf47c7da97a8a4142e7e816c5c1ace5.1770194182.git.zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH bpf-next v6 12/12] samples/bpf: Add memcg priority control example
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,akpm@linux-foundation.org,hannes@cmpxchg.org,mhocko@kernel.org,roman.gushchin@linux.dev,shakeel.butt@linux.dev,muchun.song@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,peterz@infradead.org,ojeda@kernel.org,nathan@kernel.org,kees@kernel.org,tj@kernel.org,jeffxu@chromium.org,mkoutny@suse.com,kernel@jfarr.cc,brauner@kernel.org,rdunlap@infradead.org,brgerst@gmail.com,masahiroy@kernel.org,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,inwardvessel@gmail.com,willemb@google.com,kerneljasonxing@gmail.com,paul.chaignon@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,chenridong@huaweicloud.com,lance.yang@linux.dev,jiayuan.chen@linux.dev,linux-kernel@vger.kernel.org,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,linu
 x-kselftest@vger.kernel.org
Cc: zhuhui@kylinos.cn,geliang@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  4 Feb 2026 09:28:36 +0000 (UTC)
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
	TAGGED_FROM(0.00)[bounces-13671-lists,cgroups=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kylinos.cn,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	FREEMAIL_TO(0.00)[linux.dev,linux-foundation.org,cmpxchg.org,kernel.org,iogearbox.net,gmail.com,fomichev.me,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,davemloft.net,huaweicloud.com,vger.kernel.org,kvack.org];
	NEURAL_SPAM(0.00)[0.965];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	RCPT_COUNT_GT_50(0.00)[60];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 419C4E3E25
X-Rspamd-Action: no action

--===============4976973485721389665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> 1. memcg.bpf.c: A BPF program that monitors PGFAULT events on a
>    high-priority cgroup. When activity exceeds a threshold, it uses
>    the `get_high_delay_ms`, `below_low`, or `below_min` hooks to
>    apply pressure on a low-priority cgroup.

Is this description accurate? Looking at the code, below_low and
below_min are implemented in high_mcg_ops which is attached to the
high-priority cgroup:

    high_mcg_ops = {
        .below_low = (void *)below_low_impl,
        .below_min = (void *)below_min_impl,
    };

And in memcg.c, high_mcg_ops is attached via:

    .relative_fd = high_cgroup_fd,

According to the memcg_bpf_ops documentation, below_low and below_min
provide protection for a cgroup (returning true means the cgroup is
protected from reclaim), rather than applying pressure. Only
get_high_delay_ms (attached to the low-priority cgroup via low_mcg_ops)
actually throttles/applies pressure.

Could the commit message clarify that below_low/below_min protect the
high-priority cgroup, while get_high_delay_ms throttles the low-priority
one?

> diff --git a/samples/bpf/memcg.c b/samples/bpf/memcg.c
> new file mode 100644
> index 000000000..0ed174608
> --- /dev/null
> +++ b/samples/bpf/memcg.c

[ ... ]

> +	prog = bpf_object__find_program_by_name(obj,
> +						"handle_count_memcg_events");
> +	if (!prog) {
> +		fprintf(stderr,
> +			"ERROR: finding a prog in BPF object file failed\n");
> +		goto out;
> +	}

If bpf_object__find_program_by_name() fails here, should the err variable
be set to an error code before the goto? As written, err could be 0 (from
the previous successful bpf_map_update_elem() call), causing main() to
return 0 (success) even though the program failed.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21665371660

AI-authorship-score: low
AI-authorship-explanation: The technical misunderstanding about hook purposes and dual authorship suggest human collaboration rather than AI generation.
issues-found: 2
issue-severity-score: low
issue-severity-explanation: The issues found are a misleading commit message description and a missing error code assignment in sample code, neither of which causes system instability.

--===============4976973485721389665==--

