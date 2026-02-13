Return-Path: <cgroups+bounces-13936-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OG6gDszRjmnJFAEAu9opvQ
	(envelope-from <cgroups+bounces-13936-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 08:25:00 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5CA13386A
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 08:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6D893095274
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 07:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ADF24E4B4;
	Fri, 13 Feb 2026 07:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bLZRB+KC"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0312D0614;
	Fri, 13 Feb 2026 07:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770967458; cv=none; b=UC4uD4oWIISvhi4MDFU1TZevZFTw6PGQ6B1H0DXn+LWynvdukV7f6Eredljox6THtJNtPSeKI7QXdw2diEr156CVQhD+PDcx4Ex29T2tY9PQ3I0WR7ti5Tu1oijoxrEzY4MDYWHV4Xg01w9xsZZd9xnwjMztDCEPDd5kD4cDsj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770967458; c=relaxed/simple;
	bh=uySMJvyft9jtAkrDAcp3YGsuHvDvCEgMDRF46Oa4B0Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Ff49jPTW9zfezy+qnf9neTe6T/qrhIqOEWTFSoI+/dOzC8aO/JFk/X6SXHm9GUJByJkVxQG1kQjNAFnoluM0xWIiuyzv8x/DoziPxfYxxYBef+8o/EmCoaXLnJ50VSf2ulP4Da6KOx9Y1QSUiTI1UkDVcotP9F3lvowyPW/RpRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bLZRB+KC; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770967445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VwNvFdIKZszOyx5SX4bymsUV474G0+X1JTSop6CJF0M=;
	b=bLZRB+KCujV6r+3tDxD/hCqTqrXaKPY5gKNVJCgqvm9HEhbrD39q8vpE7E4wD5kgiOVmdu
	eq3Sxy4rSM5H+g/vAMMjoAVUXltZTcZ7hYvyfJsPlHilNj02Y6e7JkSl0xQxzUDRmYi4BO
	fKZGFZsoa+VTnuaiC587gmVcpj4IImo=
From: Hui Zhu <hui.zhu@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Hui Zhu <zhuhui@kylinos.cn>,
	JP Kobryn <inwardvessel@gmail.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 0/3] Fix test_cgroup_iter_memcg issues found during back-porting
Date: Fri, 13 Feb 2026 15:23:38 +0800
Message-ID: <cover.1770965805.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13936-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,iogearbox.net,gmail.com,fomichev.me,google.com,kylinos.cn,vger.kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hui.zhu@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,kylinos.cn:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: 9D5CA13386A
X-Rspamd-Action: no action

From: Hui Zhu <zhuhui@kylinos.cn>

While back-porting "mm: bpf kfuncs to access memcg data", I
encountered issues with test_cgroup_iter_memcg, specifically
in test_kmem.

These patches are my fixes for the problems I encountered.

Changelog:
v2:
According to the comments of JP Kobryn, added bpf_core_enum_value()
usage in the BPF program to handle cross-kernel enum value differences
at load-time instead of compile-time.
Dropped the mm/memcontrol.c patch.
Modified test_kmem handling: instead of skipping when nokmem is set,
verify that kmem value is zero as expected.
According to the comments of bot, fixed assertion message: changed
"bpf_mem_cgroup_page_state" to "bpf_mem_cgroup_vm_events" for PGFAULT
check.

Hui Zhu (3):
  bpf: Use bpf_core_enum_value for stats in cgroup_iter_memcg
  selftests/bpf: Check bpf_mem_cgroup_page_state return value
  bpf: selftests: Skip kmem test when cgroup.memory=nokmem is set

 .../bpf/prog_tests/cgroup_iter_memcg.c        | 42 +++++++++++++++++++
 .../selftests/bpf/progs/cgroup_iter_memcg.c   | 41 ++++++++++++++----
 2 files changed, 76 insertions(+), 7 deletions(-)

-- 
2.43.0


