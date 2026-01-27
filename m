Return-Path: <cgroups+bounces-13470-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFV8LXKKeGmqqwEAu9opvQ
	(envelope-from <cgroups+bounces-13470-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 10:50:42 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D32A92131
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 10:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC6BF305A95A
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 09:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31803358A9;
	Tue, 27 Jan 2026 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O6bFglpo"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CD533372E;
	Tue, 27 Jan 2026 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769507305; cv=none; b=rhAAgekobGBIHiD3xQWwpHUAkii3Dyd2OrPVoIKN5mQC9/rkdkj11NRIbaIM4mdsF34cxmZcMAmd3PSAqz0D2TqQPm1pcRYYTs8iRsYn5Htx8R+DCSRKoQBpftjwWm1cIFwweMtIAmQYsGbtuj0CcyEduxNVeUrihUnzG5kong8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769507305; c=relaxed/simple;
	bh=aDizkIIrISoiSOmQOCh/qH2aJrcVckHeAXd0H3mi6To=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyrfo8HfpPRfnZ5mLoSqBOuz+b9UBTNNcVAt0vKHkb79fkXsZ4cgJaqvmTIqblPCsEczTOGvCj4Iwo5hEmQrRQgmVDfEgb5kARluqz/6+W6jLKW5wl77HjC+p9vUfucRO8sv/XmOXhh2nRRmGTaSMUaeTFCGnLiKq8wc/Mrjw2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O6bFglpo; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769507302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=38FTcR+0kk8dvZzN/w/J+BLbrBHVmHWXDv78hCgH2EM=;
	b=O6bFglpozchYmTk8MyWF7zSH8QHQ/5EZph8UjcURHY/I6G6u9aXp2ss64fZKkFnKeTpNvs
	tqZkyPA0egpf98Jjir8s3OFqJBVHPe/YdMWqAaDUaIlv3XWSiPw7BNJnNlyC8/LXNOvDMD
	WP6OVk0NbAaZUqMMsVcEI9DpEPS0RyQ=
From: Hui Zhu <hui.zhu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
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
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>,
	mkoutny@suse.com,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Brian Gerst <brgerst@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	davem@davemloft.net,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Lance Yang <lance.yang@linux.dev>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [RFC PATCH bpf-next v5 11/12] selftests/bpf: Add test for memcg_bpf_ops hierarchies
Date: Tue, 27 Jan 2026 17:47:36 +0800
Message-ID: <0b2c894a6544aa44db25d01def2c6c3e23a8bcb4.1769506741.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1769506741.git.zhuhui@kylinos.cn>
References: <cover.1769506741.git.zhuhui@kylinos.cn>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13470-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,cmpxchg.org,kernel.org,linux.dev,iogearbox.net,gmail.com,fomichev.me,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,davemloft.net,huaweicloud.com,vger.kernel.org,kvack.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hui.zhu@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[51];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: 2D32A92131
X-Rspamd-Action: no action

From: Hui Zhu <zhuhui@kylinos.cn>

Add a new selftest, `test_memcg_ops_hierarchies`, to validate the
behavior of attaching `memcg_bpf_ops` in a nested cgroup hierarchy,
specifically testing the `BPF_F_ALLOW_OVERRIDE` flag.

The test case performs the following steps:
1. Creates a three-level deep cgroup hierarchy: `/cg`, `/cg/cg`, and
   `/cg/cg/cg`.
2. Attaches a BPF struct_ops to the top-level cgroup (`/cg`) with the
   `BPF_F_ALLOW_OVERRIDE` flag.
3. Successfully attaches a new struct_ops to the middle cgroup
   (`/cg/cg`) without the flag, overriding the inherited one.
4. Asserts that attaching another struct_ops to the deepest cgroup
   (`/cg/cg/cg`) fails with -EBUSY, because its parent did not specify
   `BPF_F_ALLOW_OVERRIDE`.

This test ensures that the attachment logic correctly enforces the
override rules across a cgroup subtree.

Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 .../selftests/bpf/prog_tests/memcg_ops.c      | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_ops.c b/tools/testing/selftests/bpf/prog_tests/memcg_ops.c
index a596926ea233..91084e8acc32 100644
--- a/tools/testing/selftests/bpf/prog_tests/memcg_ops.c
+++ b/tools/testing/selftests/bpf/prog_tests/memcg_ops.c
@@ -533,3 +533,74 @@ void test_memcg_ops_below_min_over_high(void)
 	close(low_cgroup_fd);
 	cleanup_cgroup_environment();
 }
+
+void test_memcg_ops_hierarchies(void)
+{
+	int ret, first = -1, second = -1, third = -1;
+	struct memcg_ops *skel = NULL;
+	struct bpf_map *map;
+	struct bpf_link *link1 = NULL, *link2 = NULL, *link3 = NULL;
+	DECLARE_LIBBPF_OPTS(bpf_struct_ops_opts, opts);
+
+	ret = setup_cgroup_environment();
+	if (!ASSERT_OK(ret, "setup_cgroup_environment"))
+		goto cleanup;
+
+	first = create_and_get_cgroup("/cg");
+	if (!ASSERT_GE(first, 0, "create_and_get_cgroup /cg"))
+		goto cleanup;
+	ret = enable_controllers("/cg", "memory");
+	if (!ASSERT_OK(ret, "enable_controllers"))
+		goto cleanup;
+
+	second = create_and_get_cgroup("/cg/cg");
+	if (!ASSERT_GE(second, 0, "create_and_get_cgroup /cg/cg"))
+		goto cleanup;
+	ret = enable_controllers("/cg/cg", "memory");
+	if (!ASSERT_OK(ret, "enable_controllers"))
+		goto cleanup;
+
+	third = create_and_get_cgroup("/cg/cg/cg");
+	if (!ASSERT_GE(third, 0, "create_and_get_cgroup /cg/cg/cg"))
+		goto cleanup;
+	ret = enable_controllers("/cg/cg/cg", "memory");
+	if (!ASSERT_OK(ret, "enable_controllers"))
+		goto cleanup;
+
+	skel = memcg_ops__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "memcg_ops__open_and_load"))
+		goto cleanup;
+
+	map = bpf_object__find_map_by_name(skel->obj, "low_mcg_ops");
+	if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name low_mcg_ops"))
+		goto cleanup;
+
+	opts.relative_fd = first;
+	opts.flags = BPF_F_ALLOW_OVERRIDE;
+	link1 = bpf_map__attach_struct_ops_opts(map, &opts);
+	if (!ASSERT_OK_PTR(link1, "bpf_map__attach_struct_ops_opts"))
+		goto cleanup;
+
+	opts.relative_fd = second;
+	opts.flags = 0;
+	link2 = bpf_map__attach_struct_ops_opts(map, &opts);
+	if (!ASSERT_OK_PTR(link2, "bpf_map__attach_struct_ops_opts"))
+		goto cleanup;
+
+	opts.relative_fd = third;
+	opts.flags = 0;
+	link3 = bpf_map__attach_struct_ops_opts(map, &opts);
+	if (!ASSERT_ERR_PTR(link3, "bpf_map__attach_struct_ops_opts"))
+		goto cleanup;
+
+cleanup:
+	bpf_link__destroy(link1);
+	bpf_link__destroy(link2);
+	bpf_link__destroy(link3);
+	memcg_ops__detach(skel);
+	memcg_ops__destroy(skel);
+	close(first);
+	close(second);
+	close(third);
+	cleanup_cgroup_environment();
+}
-- 
2.43.0


