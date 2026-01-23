Return-Path: <cgroups+bounces-13387-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNHqEsE4c2lItAAAu9opvQ
	(envelope-from <cgroups+bounces-13387-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 10:00:49 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0643E72E28
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 10:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A15AF303EFF0
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 08:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3446344057;
	Fri, 23 Jan 2026 08:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fTSVavEG"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7D933C538
	for <cgroups@vger.kernel.org>; Fri, 23 Jan 2026 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769158730; cv=none; b=g9ZNEN9v4oLdmIocL15TmgNVUC90AvZf1+KGRTSm/xO0WM+WqJ8MNgk9TyN9GvJhuwt17PB24fbfp3V5Yb8wzVW1BuEYlftNYIetWPu14cqO9ebq/9Osh6G+hiQxn/4Xv++aos/AGj64NDNupdRf1Cv0tOJHWhsbJKIMJ0+GBLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769158730; c=relaxed/simple;
	bh=W2z9ag7GJdOo5y4sTtuZS1rUggdzi+NIWFP9U5JSzBw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Im1ChJpO14Tpxp88Hq7vS3WQnKT9Nd7BDfWpriDpbq6o3aAUgg2U8LMmnV8I3b5VtVaWQPUcm/7CSTsCyFonshyO21rkRCLE1nXBa/B5NIGjQOWivU2NZWdmdl9+HxxvCdwBDHoAFsPUBZQKcGLeO7VfM1TgIZMCJSf9Koj5k20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fTSVavEG; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769158721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yMDUAyLhkyqoXu0AnX5yMDVCDjfmzYBfHTdL76REPRM=;
	b=fTSVavEGC9/BVpguN5QVYm6QgZJEp24s+u5liPxQawZxkjy2xNt2bcSuWIp+ppId6ZUqs0
	JRlAOIGdjfyU2rNCDJGZVi2xCMUGSQ/OE35BXqXa+evHCC4pJld5lS+KTcbVbGzQ0QUo1n
	FPxiGBbhQtm8eBP+7QW/eolDZuX+f1g=
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
Subject: [RFC PATCH bpf-next v3 05/12] libbpf: introduce bpf_map__attach_struct_ops_opts()
Date: Fri, 23 Jan 2026 16:57:59 +0800
Message-ID: <03bf6aafe30def690c63e454d76e733f27dff4b3.1769157382.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1769157382.git.zhuhui@kylinos.cn>
References: <cover.1769157382.git.zhuhui@kylinos.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13387-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux-foundation.org,cmpxchg.org,kernel.org,linux.dev,iogearbox.net,gmail.com,fomichev.me,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,davemloft.net,huaweicloud.com,vger.kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hui.zhu@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,kylinos.cn:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0643E72E28
X-Rspamd-Action: no action

From: Roman Gushchin <roman.gushchin@linux.dev>

Introduce bpf_map__attach_struct_ops_opts(), an extended version of
bpf_map__attach_struct_ops(), which takes additional struct
bpf_struct_ops_opts argument.

struct bpf_struct_ops_opts has the relative_fd member, which allows
to pass an additional file descriptor argument. It can be used to
attach struct ops maps to cgroups.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 tools/lib/bpf/bpf.c      |  8 ++++++++
 tools/lib/bpf/libbpf.c   | 18 ++++++++++++++++--
 tools/lib/bpf/libbpf.h   | 14 ++++++++++++++
 tools/lib/bpf/libbpf.map |  2 +-
 4 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 21b57a629916..a2833a50a509 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -883,6 +883,14 @@ int bpf_link_create(int prog_fd, int target_fd,
 		if (!OPTS_ZEROED(opts, cgroup))
 			return libbpf_err(-EINVAL);
 		break;
+	case BPF_STRUCT_OPS:
+		relative_fd = OPTS_GET(opts, cgroup.relative_fd, 0);
+		attr.link_create.cgroup.relative_fd = relative_fd;
+		attr.link_create.cgroup.expected_revision =
+			OPTS_GET(opts, cgroup.expected_revision, 0);
+		if (!OPTS_ZEROED(opts, cgroup))
+			return libbpf_err(-EINVAL);
+		break;
 	default:
 		if (!OPTS_ZEROED(opts, flags))
 			return libbpf_err(-EINVAL);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index bbcfd72b07d5..37eb4f96b28e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -13459,12 +13459,19 @@ static int bpf_link__detach_struct_ops(struct bpf_link *link)
 	return close(link->fd);
 }
 
-struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
+struct bpf_link *bpf_map__attach_struct_ops_opts(const struct bpf_map *map,
+						 const struct bpf_struct_ops_opts *opts)
 {
+	DECLARE_LIBBPF_OPTS(bpf_link_create_opts, link_opts);
 	struct bpf_link_struct_ops *link;
 	__u32 zero = 0;
 	int err, fd;
 
+	if (!OPTS_VALID(opts, bpf_struct_ops_opts)) {
+		pr_warn("map '%s': invalid opts\n", map->name);
+		return libbpf_err_ptr(-EINVAL);
+	}
+
 	if (!bpf_map__is_struct_ops(map)) {
 		pr_warn("map '%s': can't attach non-struct_ops map\n", map->name);
 		return libbpf_err_ptr(-EINVAL);
@@ -13500,7 +13507,9 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
 		return &link->link;
 	}
 
-	fd = bpf_link_create(map->fd, 0, BPF_STRUCT_OPS, NULL);
+	link_opts.cgroup.relative_fd = OPTS_GET(opts, relative_fd, 0);
+
+	fd = bpf_link_create(map->fd, 0, BPF_STRUCT_OPS, &link_opts);
 	if (fd < 0) {
 		free(link);
 		return libbpf_err_ptr(fd);
@@ -13512,6 +13521,11 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
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
index dfc37a615578..5aef44bcfcc2 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -920,6 +920,20 @@ bpf_program__attach_cgroup_opts(const struct bpf_program *prog, int cgroup_fd,
 struct bpf_map;
 
 LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map);
+
+struct bpf_struct_ops_opts {
+	/* size of this struct, for forward/backward compatibility */
+	size_t sz;
+	__u32 flags;
+	__u32 relative_fd;
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
index d18fbcea7578..2bf514462045 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -453,5 +453,5 @@ LIBBPF_1.7.0 {
 		bpf_map__exclusive_program;
 		bpf_prog_assoc_struct_ops;
 		bpf_program__assoc_struct_ops;
-		btf__permute;
+		bpf_map__attach_struct_ops_opts;
 } LIBBPF_1.6.0;
-- 
2.43.0


