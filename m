Return-Path: <cgroups+bounces-13384-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKsDOjQ4c2lItAAAu9opvQ
	(envelope-from <cgroups+bounces-13384-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 09:58:28 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A865372D4E
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 09:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8454D301E7C6
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 08:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2317337692;
	Fri, 23 Jan 2026 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NMD50k4b"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28E0329395
	for <cgroups@vger.kernel.org>; Fri, 23 Jan 2026 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769158593; cv=none; b=oCiPA3yASj7/E8WFIJxW1cO4Kxr70c8xoEyizKzPtdnu11uFfr9pANDN/tSt2p7rHGQBtsCG2hfyWyE1a9JO43wvR0Pdw8YNik5MsvulSJAduatTy8DgN9JE2OXQlwCIjb5KGTkZvSGg59cBN0F7xiTslDv1iUuYgsKDBzpI7+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769158593; c=relaxed/simple;
	bh=VMWSjdZBbwCROxtM45L3N2YVJItH/AEKdFdBA0R/Kg8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gef5U08QWjEXRZL1AxQRu3Mwk+D0+oRkr+Xr6ys6I3AJUaYF4rtjmCr77HO+XHdZ4E7TMrQ7/eB/vQlKUYyvSZ0au5Rs4IoyxP+eHlEdT5bBjs2kfXk6YaLysRQbRLPjzw88h2favPmmsrlhqz3Prw5EFrvpx2tV2ePnxIlIp7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NMD50k4b; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769158589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mRzQHCKarCYBi7G1xIo0Ho9ytROzsvuCqz+L2Dk75mk=;
	b=NMD50k4bUm77bwDcYhOB0EpujUCmId6LC0LnmOQ+cN7HRcsMqcCVMBNhz7FEmicI88cTzs
	fCiKD/e7ZUORx7uTYhwqmUndQiS7GsgwVJdfUZ4G1Wtzv8/QnHJOyc0nCpr8f/K4LOtplX
	e4UW3EsGa7P7cP1zRrhbOsTQC9UwH8w=
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
Subject: [RFC PATCH bpf-next v3 02/12] bpf: initial support for attaching struct ops to cgroups
Date: Fri, 23 Jan 2026 16:55:20 +0800
Message-ID: <e34da0fc270eb7cc41f6b388026f503799541675.1769157382.git.zhuhui@kylinos.cn>
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
	TAGGED_FROM(0.00)[bounces-13384-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:mid,linux.dev:email,linux.dev:dkim]
X-Rspamd-Queue-Id: A865372D4E
X-Rspamd-Action: no action

From: Roman Gushchin <roman.gushchin@linux.dev>

When a struct ops is being attached and a bpf link is created,
allow to pass a cgroup fd using bpf attr, so that struct ops
can be attached to a cgroup instead of globally.

Attached struct ops doesn't hold a reference to the cgroup,
only preserves cgroup id.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/bpf.h         |  1 +
 kernel/bpf/bpf_struct_ops.c | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 031682f1ad39..7c15bac782fc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1885,6 +1885,7 @@ struct bpf_struct_ops_link {
 	struct bpf_link link;
 	struct bpf_map __rcu *map;
 	wait_queue_head_t wait_hup;
+	u64 cgroup_id;
 };
 
 struct bpf_link_primer {
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index de01cf3025b3..f575c5cd0dc8 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -13,6 +13,7 @@
 #include <linux/btf_ids.h>
 #include <linux/rcupdate_wait.h>
 #include <linux/poll.h>
+#include <linux/cgroup.h>
 
 struct bpf_struct_ops_value {
 	struct bpf_struct_ops_common_value common;
@@ -1377,6 +1378,18 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	}
 	bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_map_lops, NULL,
 		      attr->link_create.attach_type);
+#ifdef CONFIG_CGROUPS
+	if (attr->link_create.cgroup.relative_fd) {
+		struct cgroup *cgrp;
+
+		cgrp = cgroup_get_from_fd(attr->link_create.cgroup.relative_fd);
+		if (IS_ERR(cgrp))
+			return PTR_ERR(cgrp);
+
+		link->cgroup_id = cgroup_id(cgrp);
+		cgroup_put(cgrp);
+	}
+#endif /* CONFIG_CGROUPS */
 
 	err = bpf_link_prime(&link->link, &link_primer);
 	if (err)
-- 
2.43.0


