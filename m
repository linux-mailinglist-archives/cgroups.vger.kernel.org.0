Return-Path: <cgroups+bounces-13397-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCjWMyo9c2kztgAAu9opvQ
	(envelope-from <cgroups+bounces-13397-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 10:19:38 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D4973234
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 10:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C32B1302C76E
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 09:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BB8339859;
	Fri, 23 Jan 2026 09:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InW/yky3"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D4B3164D3;
	Fri, 23 Jan 2026 09:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769159946; cv=none; b=JxsVbiJz189epFbCcOSiwc91QNe9RXe2kmLsKBl5xC347L3CIwQCy9o1AHav4z/rIraaa7oh7jnAi4eRMf8Bw/dU0netSZRCWzHbWgIRdcc2GKzMireZXmOgDS1//NuZb4vvC3Th8WPvIlVzZcW5gCrqRV5yQRe/Pex9+Qf9rT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769159946; c=relaxed/simple;
	bh=++ck5HBZpMPSGGpoonSSzPKOjTBgq1xO2oJuGzY5lWE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kh9df3Cxw3l5ZxN+Ohjod6jJfJkF2xTf8aP/BNAEVdlf5g6vUZSG0Jkoqy9Lz8ISs4yuJHCZSyoQ15RI0HC4yj8UiJBwOV7htFT++MzcAkW2/ROg3T2V1U8Xfzujpch3uQ5l+FBeiWM6kvM38FvwNhEeHNLOxry2Jnd4m13bD9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InW/yky3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D6FC19422;
	Fri, 23 Jan 2026 09:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769159946;
	bh=++ck5HBZpMPSGGpoonSSzPKOjTBgq1xO2oJuGzY5lWE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=InW/yky3spHD+VBL/Qubq9HdIWp1bq9AGY9a5aZ2YmU+pKqOnipVCfNDJt14vOnFo
	 9Ft2oZDTviiR/bowI6zlIWddMT8I5Ul7/TZjzSq3JSZd1SYjENW4vkO7jIvqbMaawn
	 ZibHjAyS5VJ3/jb4FYoyWyCYRBVcqkQs1KNNTLluXVTdzOG+9IifYB1/nsbs00FAEO
	 4ubr6fqhaf0Ta0LmzkjnYVMYIyxIE8RQaBGp9BoMpXuBsCGu5egLFcs/4p21F10B67
	 jBlGYrsbfePzLz78Gmx5Qsgj6QPP10wXwijDTMui34uAx8ZMNJVrrAfd8OWAU3eX0T
	 cQcdYe91kgOwA==
Content-Type: multipart/mixed; boundary="===============0725732639387219158=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b0f009e6e0f8ec688597c5c3954b3335069f3aa60441a7c3f44246af7a9c4629@mail.kernel.org>
In-Reply-To: <e34da0fc270eb7cc41f6b388026f503799541675.1769157382.git.zhuhui@kylinos.cn>
References: <e34da0fc270eb7cc41f6b388026f503799541675.1769157382.git.zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH bpf-next v3 02/12] bpf: initial support for attaching struct ops to cgroups
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,akpm@linux-foundation.org,hannes@cmpxchg.org,mhocko@kernel.org,roman.gushchin@linux.dev,shakeel.butt@linux.dev,muchun.song@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,peterz@infradead.org,ojeda@kernel.org,nathan@kernel.org,kees@kernel.org,tj@kernel.org,jeffxu@chromium.org,mkoutny@suse.com,kernel@jfarr.cc,brauner@kernel.org,rdunlap@infradead.org,brgerst@gmail.com,masahiroy@kernel.org,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,inwardvessel@gmail.com,willemb@google.com,kerneljasonxing@gmail.com,paul.chaignon@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,chenridong@huaweicloud.com,lance.yang@linux.dev,jiayuan.chen@linux.dev,linux-kernel@vger.kernel.org,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,linu
 x-kselftest@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 23 Jan 2026 09:19:05 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,cgroups@vger.kernel.org];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	TAGGED_FROM(0.00)[bounces-13397-lists,cgroups=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	FREEMAIL_TO(0.00)[linux.dev,linux-foundation.org,cmpxchg.org,kernel.org,iogearbox.net,gmail.com,fomichev.me,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,davemloft.net,huaweicloud.com,vger.kernel.org,kvack.org];
	NEURAL_SPAM(0.00)[0.828];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	RCPT_COUNT_GT_50(0.00)[58];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 93D4973234
X-Rspamd-Action: no action

--===============0725732639387219158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index de01cf3025b3..f575c5cd0dc8 100644

[ ... ]

> @@ -1377,6 +1378,18 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
>  	}
>  	bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_map_lops, NULL,
>  		      attr->link_create.attach_type);
> +#ifdef CONFIG_CGROUPS
> +	if (attr->link_create.cgroup.relative_fd) {
> +		struct cgroup *cgrp;
> +
> +		cgrp = cgroup_get_from_fd(attr->link_create.cgroup.relative_fd);
> +		if (IS_ERR(cgrp))
> +			return PTR_ERR(cgrp);
                        ^^^^^^^^^^^^^^^^^

When cgroup_get_from_fd() fails, this returns directly without cleaning
up. At this point in bpf_struct_ops_link_create(), link has already been
allocated via kzalloc() and map has a reference from bpf_map_get().

Should this use goto err_out instead? The err_out label calls
bpf_map_put(map) and kfree(link), which would be needed here but are
bypassed by the direct return.

> +
> +		link->cgroup_id = cgroup_id(cgrp);
> +		cgroup_put(cgrp);
> +	}
> +#endif /* CONFIG_CGROUPS */
>
>  	err = bpf_link_prime(&link->link, &link_primer);
>  	if (err)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21280790825

--===============0725732639387219158==--

