Return-Path: <cgroups+bounces-13938-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDiaONbSjmnJFAEAu9opvQ
	(envelope-from <cgroups+bounces-13938-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 08:29:26 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C706133908
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 08:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30932305F213
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 07:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2762DBF75;
	Fri, 13 Feb 2026 07:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I1fiQCId"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C23C2D8798
	for <cgroups@vger.kernel.org>; Fri, 13 Feb 2026 07:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770967763; cv=none; b=otdMSRukLZ5JtnEJSAXcQ0rtsd23W/2pjBHQb+VRWS1qQZ2g1Q7/ghxqDbqvhDeK0stRx/XrFwW169oWr806YgoMz3MP/lqQVGdswh3UvfmklnMf+09ZdtUBSPyHXjGZzXuyLN8H7te4teAkkiiFTH/C2n0YTNcP4ZROfy92tTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770967763; c=relaxed/simple;
	bh=NXDdy6TLdcN/ZgcBWQv6QQcGWTMVgESa649jXEx/dnU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=YD9KWZjc0h+MVIWhvGkw0KX3bN36GqkiIrVDThvyDRf4ASxr03/3dHH/tEv7Fen2bTMv0qDMESxofvvh2m3KNxblIDXWGUB4U4RR7pKWxoqm/6kNEKzEFBL88HlG/wa1SsXv2MKj2nZhq+0a25CwuKQAsNtisrkLGPVVky4+VWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I1fiQCId; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770967750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fSwf5ADGpMtIggy35MSUTnrYPRQGw4N4LrsqqQW6yMw=;
	b=I1fiQCIdi33AXVqAq540kk3FFgeJgOEnmlXDwjZd933vVw1+sSRvYUJ87b5Yy4QEt0JRgG
	Gtw99BbzPBQoBik4CHYFnqH432Sin748f4ljULf/1rUY/JyNqR3cGsIzoo1rgj7JiHZo4g
	/DYknPckRglXHqMKH36oBIfCO1HJUQQ=
Date: Fri, 13 Feb 2026 07:29:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: hui.zhu@linux.dev
Message-ID: <dd404ba15aeabb9f72d187f1045def2c873854bc@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Check
 bpf_mem_cgroup_page_state return value
To: "JP Kobryn" <inwardvessel@gmail.com>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "Michal Hocko" <mhocko@kernel.org>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, "Shakeel Butt"
 <shakeel.butt@linux.dev>, "Muchun Song" <muchun.song@linux.dev>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>, "Hui Zhu"
 <zhuhui@kylinos.cn>, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
In-Reply-To: <e49fc187-0ef8-4557-abac-0082653fa645@gmail.com>
References: <cover.1770883926.git.zhuhui@kylinos.cn>
 <042df9438d9e78bcd66f1fa0e7043b9ea8cda96c.1770883926.git.zhuhui@kylinos.cn>
 <e49fc187-0ef8-4557-abac-0082653fa645@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13938-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,iogearbox.net,fomichev.me,google.com,kylinos.cn,vger.kernel.org,kvack.org];
	FROM_NEQ_ENVFROM(0.00)[hui.zhu@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,linux.dev:mid,linux.dev:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C706133908
X-Rspamd-Action: no action

2026=E5=B9=B42=E6=9C=8813=E6=97=A5 08:14, "JP Kobryn" <inwardvessel@gmail=
.com mailto:inwardvessel@gmail.com?to=3D%22JP%20Kobryn%22%20%3Cinwardvess=
el%40gmail.com%3E > =E5=86=99=E5=88=B0:


>=20
>=20On 2/12/26 12:23 AM, Hui Zhu wrote:
>=20
>=20>=20
>=20> From: Hui Zhu <zhuhui@kylinos.cn>
> >  When back-porting test_progs to different kernel versions, I encount=
ered
> >  an issue where the test_cgroup_iter_memcg test would falsely pass ev=
en
> >  when bpf_mem_cgroup_page_state() failed.
> >  The problem occurs when test_progs compiled on one kernel version is
> >  executed on another kernel with different enum values for memory
> >  statistics (e.g., NR_ANON_MAPPED, NR_FILE_PAGES). [...]
> >=20
>=20This patch looks good but I think to fully solve this cross-kernel is=
sue
> we should use co-re in the bpf program. In your second revision, can yo=
u
> add an additional patch to make use of bpf_core_enum_value()? This way
> instead of relying on enum values in vmlinux.h at compile-time, we use
> the btf info at load-time instead to get the proper value for the given
> kernel.
>

I post v2 according to your comments.
Thanks for your review.

Best,
Hui

