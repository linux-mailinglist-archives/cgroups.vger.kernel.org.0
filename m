Return-Path: <cgroups+bounces-13892-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABM7BxOcjWlT5QAAu9opvQ
	(envelope-from <cgroups+bounces-13892-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 10:23:31 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF4512BD13
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 10:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 343CA30512B7
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 09:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368402DE6FF;
	Thu, 12 Feb 2026 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nvPqHxHr"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921A82D8766
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770888198; cv=none; b=PkkgPRhPFp8mY9YQrmAWactNX5ap2O9jdXLw/kPIXMAlZmYW9+yK7/XiHR3VYNP65+qxJ0XAJb8I4g4TpOFOMv11NJwccIqJv22UB8HUtWLwSmZGg5SmX18gi1PM8O9oRWX0JxX9du88XbbWaofcjy7yXtw9WAaaOB8IT0ct+lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770888198; c=relaxed/simple;
	bh=ZhiMTHRn9zJu2lrX5+uOW7rcWa+9/2xEdqrmmvgHRvo=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=RwGO/4Bzt62nKi9Jc/94U1fqDU1//kMWo0S+UAncoyo5jriqilIZddDhM10HqXeNwF+Lf8xJhBGmZAPyzWd/HBCX9pTg5i+fESUm/Xf7Bv6clhFBqGtirwc+Uv44QCT7A12Z7cNvbJq7/MdJUS768K6wAF+gHiJ1Lsojb7cvrQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nvPqHxHr; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770888184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MOtwOaawqm5YCOOGpYlVVEXa/IipPl5Ioo0RNIEb2Qg=;
	b=nvPqHxHr0KgdC09FjroI0w+XrWY/hJ68UL4/0rh2ftPJh5s8PEVk6tHapWR7m/Ri5dxtnv
	nNQ0yX2uF46GhiKFyKQsKJbEln8+aTnsFZAO98AyIIXUrkhEn4mrYuzBh7bi7l7Nsdwoo+
	gniHvShoHs+8GogwC2C38z+MWvWD6r0=
Date: Thu, 12 Feb 2026 09:23:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: hui.zhu@linux.dev
Message-ID: <9302f6e6d89af6b68d673a2f90e366ebcf947e29@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Check
 bpf_mem_cgroup_page_state return value
To: bot+bpf-ci@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 shuah@kernel.org, zhuhui@kylinos.cn, inwardvessel@gmail.com,
 cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev
In-Reply-To: <0d926bdc5b5e030fafc82de73c3f3e5412c051fc6763f77da9ea6aa316bd8f13@mail.kernel.org>
References: <042df9438d9e78bcd66f1fa0e7043b9ea8cda96c.1770883926.git.zhuhui@kylinos.cn>
 <0d926bdc5b5e030fafc82de73c3f3e5412c051fc6763f77da9ea6aa316bd8f13@mail.kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13892-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,linux.dev,linux-foundation.org,iogearbox.net,gmail.com,fomichev.me,google.com,kylinos.cn,vger.kernel.org,kvack.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hui.zhu@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_RCPT(0.00)[cgroups,bpf-ci];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 6AF4512BD13
X-Rspamd-Action: no action

2026=E5=B9=B42=E6=9C=8812=E6=97=A5 16:50, bot+bpf-ci@kernel.org mailto:bo=
t+bpf-ci@kernel.org  =E5=86=99=E5=88=B0:


>=20
>=20>=20
>=20> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_mem=
cg.c b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> >  --- a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> >  +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> >=20
>=20[ ... ]
>=20
>=20>=20
>=20> @@ -170,6 +180,8 @@ static void test_pgfault(struct bpf_link *link,=
 struct memcg_query *memcg_query)
> >  if (!ASSERT_OK(read_stats(link), "read stats"))
> >  goto cleanup;
> >=20
>=20>  + ASSERT_NEQ(memcg_query->pgfault, (unsigned long)-1,
> >  + "bpf_mem_cgroup_page_state PGFAULT");
> >=20
>=20 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
>=20The assertion message references bpf_mem_cgroup_page_state(), but the=
 BPF
> program actually uses bpf_mem_cgroup_vm_events() to retrieve the pgfaul=
t
> value:
>=20
>=20tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c:
>  memcg_query.pgfault =3D bpf_mem_cgroup_vm_events(memcg, PGFAULT);
>=20
>=20Should the message be "bpf_mem_cgroup_vm_events PGFAULT" instead?

Good catch!  I will fix it in the next version.

Best,
Hui

>=20
>=20---
> AI reviewed your patch. Please fix the bug or email reply why it's not =
a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/REA=
DME.md
>=20
>=20CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21=
939182103
>=20
>=20AI-authorship-score: low
> AI-authorship-explanation: The commit message uses first-person narrati=
ve describing a real back-porting scenario, and the code changes are simp=
le repetitive assertions typical of human-written test improvements.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: Minor documentation issue where an assertio=
n message references the wrong BPF function name; does not affect test co=
rrectness or system behavior.
>

