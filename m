Return-Path: <cgroups+bounces-16277-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0A41MjUOFWrVSQcAu9opvQ
	(envelope-from <cgroups+bounces-16277-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 05:06:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA8D5D0320
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 05:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E0F13020EC3
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 03:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AB2390C84;
	Tue, 26 May 2026 03:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEZUsMWJ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9B3382289;
	Tue, 26 May 2026 03:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779764780; cv=none; b=IBu9ClLN8anDDXEvxFscs6u0LxDySGcOalOmatPbtqbyR7uTiU/efiKdSnZ4HAdrFN/FBxl7+7lABfG6pr9qGzJpP1XNVD/xgXVxzZlcU3xjk3SgWf/jz+Zx7CC0zwOzs0xQYqQ3VIbgqZ4xRt6aoOqdHXeq0SIqe3orW/f3T0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779764780; c=relaxed/simple;
	bh=PLfC3hhP65/R8Ef/PrNCGEFxKULcxSgtxTKT3eRkj68=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GW23eJtxmJ4fjj/ckfclDhVWKwSobkQH1Wmhrp+abXAW9fZKbQ31r+/N/pK3cEJGtzlnd22kdDPZg1chDAHdMV8+ftmrlT7F2urNTWIUVlVSUb4iF+CkBC+DN+whUHNMCQ2FhHTVd9K7Kk5UouBlOZOU/qyT8xhskiOx/Hceulk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEZUsMWJ reason="signature verification failed"; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6B91F000E9;
	Tue, 26 May 2026 03:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779764778;
	bh=bD1DxynsoU0auV377W9yW3PuxMlzlNdl+Ii+zM/7Nyw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OEZUsMWJZw+E2RPT7SKO+DpKRsUypIy4D1QbA93XYWm2kMCltw5/oEklDClh5LEJy
	 5lSKehzlacNUJqsYr+GRe7JLbgf1x09YNwO7zMvJGGT1yp3pMjzrZnqF3UqvsX0w2i
	 UxGVr9958J6eJhwfaq84fQZCCRE0h6gXORUvlP+LILyQh1+uFhtvronjqICIH3k71a
	 n7BEl4G6kAWOpsfMzLBBAfhFdlbakJ0krQreyQGgADtIIoAUjxAjgJ0Q4FB2f+PuLb
	 cibao5KCroPmmz4ejin76N8MkSL1Bqy6pdPJ0XD7RvaFjAx5Y2A0QGCBOoERO3y869
	 iZt6awx6fsXjg==
Content-Type: multipart/mixed; boundary="===============1607772065207942128=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8739793736cb8eb1ec6e271f59142e97a34af26ccb023469e23e5b47bed2aa61@mail.kernel.org>
In-Reply-To: <8bfb7027abcc02c21db565cf52d6af78a6ce5b7d.1779760876.git.zhuhui@kylinos.cn>
References: <8bfb7027abcc02c21db565cf52d6af78a6ce5b7d.1779760876.git.zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH bpf-next v7 03/11] libbpf: fix return value on memory allocation failure
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
Cc: geliang@kernel.org,baohua@kernel.org,laoar.shao@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 26 May 2026 03:06:17 +0000 (UTC)
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20260515];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,iogearbox.net,linux.dev,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,cgroups@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16277-lists,cgroups=lfdr.de,bpf-ci];
	FREEMAIL_TO(0.00)[linux.dev,kernel.org,iogearbox.net,gmail.com,cmpxchg.org,linux-foundation.org,davemloft.net,fomichev.me,meta.com,distanz.ch,cestc.cn,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,huaweicloud.com,web.codeaurora.org,vger.kernel.org,kvack.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:-];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[69];
	NEURAL_HAM(-0.00)[-0.736];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+,1:+]
X-Rspamd-Queue-Id: 4CA8D5D0320
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============1607772065207942128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index ab2071fdd3e8..1e8688975d16 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -13701,7 +13701,7 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
>
>  	link = calloc(1, sizeof(*link));
>  	if (!link)
> -		return libbpf_err_ptr(-EINVAL);
> +		return libbpf_err_ptr(-ENOMEM);
>
>  	/* kern_vdata should be prepared during the loading phase. */
>  	err = bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vdata, 0);

This is a pre-existing issue, but can this dereference a NULL map->st_ops
pointer?

If a user manually changes a map's type to BPF_MAP_TYPE_STRUCT_OPS using
bpf_map__set_type(), or if a malformed BPF object file defines a map in the
.maps section with this type, map->st_ops is never allocated.

The bpf_object_init_struct_ops() function only allocates st_ops for maps
found in the .struct_ops and .struct_ops.link sections.

Because bpf_map__is_struct_ops() only checks map->def.type, could a missing
NULL check on map->st_ops here and in bpf_map__init_kern_struct_ops() lead to
a crash when privileged daemons parse untrusted BPF ELF files?

Reviewed-by lore thread: https://lore.kernel.org/bpf/20260526024145.5309F1F000E9@smtp.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26429228214
--===============1607772065207942128==--

