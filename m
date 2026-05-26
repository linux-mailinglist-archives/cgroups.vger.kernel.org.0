Return-Path: <cgroups+bounces-16269-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJvUGhsEFWroSAcAu9opvQ
	(envelope-from <cgroups+bounces-16269-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 04:23:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF655CFDD8
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 04:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD180300AD8D
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 02:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAB52EDD78;
	Tue, 26 May 2026 02:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PZjgjlwc"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E832F8E80
	for <cgroups@vger.kernel.org>; Tue, 26 May 2026 02:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779762111; cv=none; b=P4yEFQ84vrUN4kaxfWbX1BcJiA0nJL9M6OZl429/AfdzoGHBEiNJK++pSm/HJBZ/zPA84kGs1AEG3i2LhXMfcSJRCWDBWX/owfrj0hPe/aAtUDbT77eptmucFA90a/WfxjN0Nn3IcoenkRE60rpOdOHSSfib0FsObzE8hUgBGJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779762111; c=relaxed/simple;
	bh=uZi3xorIb1H9ikhi5wArkjVayXHTg+sbCnE50nHmo5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ku0ZpthtdiGLiSndAuPhk+F9hGyXCQvG8iENfukW/aPF1P8xrTi3ln9rj2wLEPwZzg4PlJ7ln6nhzM+sL/hsKDCoT+K1qKvSuq/JyX/yG7ShJ3sr2IQKIInpQvlBFWvIHR9flcSv+2X83mpQH+K9UoQlcThv2YIed+KoGGuWElI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PZjgjlwc; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779762107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7Bh9sNsoNgUnqOqmMKX4zg5u4PI6PFUbnydcfDlgqU=;
	b=PZjgjlwcve5jLdLXC3W81a3ws371QG0/VRoWhYadFvjsVk98w+mAqx47aeLN8a6ph9YnUf
	wYAyBEJ/yMLAYymhs/N9jK+9yoIBpF574W/zXiDvjjYETKv45kx5umPmOt44LK4shgxJNN
	OIxwgn8cnfbIglwOOZDZKFLyxXRjcnE=
From: Hui Zhu <hui.zhu@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	davem@davemloft.net,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	KP Singh <kpsingh@kernel.org>,
	Tao Chen <chen.dylane@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Tobias Klauser <tklauser@distanz.ch>,
	Eyal Birger <eyal.birger@gmail.com>,
	Rong Tao <rongtao@cestc.cn>,
	Hao Luo <haoluo@google.com>,
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
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Lance Yang <lance.yang@linux.dev>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: geliang@kernel.org,
	baohua@kernel.org
Subject: [RFC PATCH bpf-next v7 04/11] libbpf: introduce bpf_map__attach_struct_ops_opts()
Date: Tue, 26 May 2026 10:20:04 +0800
Message-ID: <20bdaa33cc19364f5f10208c79ef94fe43bd5ac1.1779760876.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1779760876.git.zhuhui@kylinos.cn>
References: <cover.1779760876.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16269-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,cmpxchg.org,linux-foundation.org,davemloft.net,fomichev.me,meta.com,distanz.ch,cestc.cn,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,huaweicloud.com,vger.kernel.org,kvack.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hui.zhu@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[58];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.963];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,kylinos.cn:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6EF655CFDD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Roman Gushchin <roman.gushchin@linux.dev>

Introduce bpf_map__attach_struct_ops_opts(), an extended version of
bpf_map__attach_struct_ops(), which takes additional struct
bpf_struct_ops_opts argument.

This allows to pass a target_fd argument and the BPF_F_CGROUP_FD flag
and attach the struct ops to a cgroup as a result.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 tools/lib/bpf/libbpf.c   | 20 +++++++++++++++++---
 tools/lib/bpf/libbpf.h   | 14 ++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1e8688975d16..a1b54da1ded2 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -13683,11 +13683,18 @@ static int bpf_link__detach_struct_ops(struct bpf_link *link)
 	return close(link->fd);
 }
 
-struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
+struct bpf_link *bpf_map__attach_struct_ops_opts(const struct bpf_map *map,
+						 const struct bpf_struct_ops_opts *opts)
 {
+	DECLARE_LIBBPF_OPTS(bpf_link_create_opts, link_opts);
 	struct bpf_link_struct_ops *link;
+	int err, fd, target_fd;
 	__u32 zero = 0;
-	int err, fd;
+
+	if (!OPTS_VALID(opts, bpf_struct_ops_opts)) {
+		pr_warn("map '%s': invalid opts\n", map->name);
+		return libbpf_err_ptr(-EINVAL);
+	}
 
 	if (!bpf_map__is_struct_ops(map)) {
 		pr_warn("map '%s': can't attach non-struct_ops map\n", map->name);
@@ -13724,7 +13731,9 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
 		return &link->link;
 	}
 
-	fd = bpf_link_create(map->fd, 0, BPF_STRUCT_OPS, NULL);
+	link_opts.flags = OPTS_GET(opts, flags, 0);
+	target_fd = OPTS_GET(opts, target_fd, 0);
+	fd = bpf_link_create(map->fd, target_fd, BPF_STRUCT_OPS, &link_opts);
 	if (fd < 0) {
 		free(link);
 		return libbpf_err_ptr(fd);
@@ -13736,6 +13745,11 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
 	return &link->link;
 }
 
+struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
+{
+	return bpf_map__attach_struct_ops_opts(map, NULL);
+}
+
 /*
  * Swap the back struct_ops of a link with a new struct_ops map.
  */
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index bba4e8464396..18af178547ad 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -945,6 +945,20 @@ bpf_program__attach_cgroup_opts(const struct bpf_program *prog, int cgroup_fd,
 struct bpf_map;
 
 LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map);
+
+struct bpf_struct_ops_opts {
+	/* size of this struct, for forward/backward compatibility */
+	size_t sz;
+	__u32 flags;
+	__u32 target_fd;
+	__u64 expected_revision;
+	size_t :0;
+};
+#define bpf_struct_ops_opts__last_field expected_revision
+
+LIBBPF_API struct bpf_link *
+bpf_map__attach_struct_ops_opts(const struct bpf_map *map,
+				const struct bpf_struct_ops_opts *opts);
 LIBBPF_API int bpf_link__update_map(struct bpf_link *link, const struct bpf_map *map);
 
 struct bpf_iter_attach_opts {
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index dfed8d60af05..6105619b5ecf 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -454,6 +454,7 @@ LIBBPF_1.7.0 {
 		bpf_prog_assoc_struct_ops;
 		bpf_program__assoc_struct_ops;
 		btf__permute;
+		bpf_map__attach_struct_ops_opts;
 } LIBBPF_1.6.0;
 
 LIBBPF_1.8.0 {
-- 
2.43.0


