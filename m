Return-Path: <cgroups+bounces-4200-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5FA94E80A
	for <lists+cgroups@lfdr.de>; Mon, 12 Aug 2024 09:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526271F2220D
	for <lists+cgroups@lfdr.de>; Mon, 12 Aug 2024 07:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7611D161306;
	Mon, 12 Aug 2024 07:45:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AECF13E40F;
	Mon, 12 Aug 2024 07:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723448737; cv=none; b=Q2i1gI6el6eVWfBBl0CiNuqX6WKq3rEmwOfC5nstyAUtAE3JsL3sx/iLVaGRhQjlaKDngcwYXeaHyvAwwj1YWdHl6UdQPaBQS1XFORjYFsJ/B5arsyM4VEqm9u+/3iLF2lND5OwPv1K2dg8NPQZMOUWx4ZrUOAVVXSLJa6iP8wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723448737; c=relaxed/simple;
	bh=WsrhgyVIDSbIDkdI/1g/lmrLmkheDEr9RdTZOc2jwJo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uOTz5ke07mOMQmYwV4uvqJl6kFf71QasIFekhxgV+Ojg0hjiOZHfMcf5Kh8B3pIES0pM6NM8GLX1e4YPK3qgW4H87AcaMaZedmc9PpNfFiyszcY1lLduakZyhEumxJ8Ypi+CQxgPTZeL/n5piUn82Cq611VM+jk2qm5b+QApSbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wj63L26hSzpTQL;
	Mon, 12 Aug 2024 15:44:14 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id C7A771402E2;
	Mon, 12 Aug 2024 15:45:31 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 12 Aug
 2024 15:45:31 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 2/2] cgroup: Disallow delegatee to write all interfaces outsize of cgroup ns
Date: Mon, 12 Aug 2024 07:37:46 +0000
Message-ID: <20240812073746.3070616-3-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812073746.3070616-1-chenridong@huawei.com>
References: <20240812073746.3070616-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100013.china.huawei.com (7.221.188.163)

The delegatee shouldn't be allowed to write to the resource control
interface files. The kernel rejects writes to all files other than
"cgroup.procs", "cgroup.threads" and "cgroup.subtree_control" on a
namespace root from inside the namespace. However, delegatee can write
"cgroup.subtree_control" outsize of the namespace, this can be reproduced
by as follows:

cd /sys/fs/cgroup
echo '+pids' > cgroup.subtree_control
mkdir dlgt_grp_ns
echo '+pids' > dlgt_grp_ns/cgroup.subtree_control
mkdir dlgt_grp_ns/dlgt_grp_ns1
echo $$ > dlgt_grp_ns/dlgt_grp_ns1/cgroup.procs
echo 200 > dlgt_grp_ns/dlgt_grp_ns1/pids.max
unshare -Cm /bin/bash
echo max > dlgt_grp_ns/dlgt_grp_ns1/pids.max // Permission denied
echo -pids > dlgt_grp_ns/cgroup.subtree_control // pids was unlimited now

We set pids.max to 200 in the cgroup dlgt_grp_ns1, and we created a new
cgroup namespace. The delegatee can't write to
dlgt_grp_ns/dlgt_grp_ns1/pids.max. However, delegatee can write to
dlgt_grp_ns/cgroup.subtree_control, which is outside of the cgroup
namespace, and this invalided the pids limitation.

Cgroup namespaces, as delegation boundaries, should disallow the delegatee
to write all interfaces outside of the cgroup namespace.

Fixes: 5136f6365ce3 ("cgroup: implement "nsdelegate" mount option")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cgroup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 8dbe00000fd4..1ef9413c02e3 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4134,8 +4134,10 @@ static ssize_t cgroup_file_write(struct kernfs_open_file *of, char *buf,
 	 * cgroup.procs, cgroup.threads and cgroup.subtree_control.
 	 */
 	if ((cgrp->root->flags & CGRP_ROOT_NS_DELEGATE) &&
-	    !(cft->flags & CFTYPE_NS_DELEGATABLE) &&
-	    ctx->ns != &init_cgroup_ns && ctx->ns->root_cset->dfl_cgrp == cgrp)
+		ctx->ns != &init_cgroup_ns &&
+		(!cgroup_is_descendant(cgrp, ctx->ns->root_cset->dfl_cgrp) ||
+			(!(cft->flags & CFTYPE_NS_DELEGATABLE) &&
+			ctx->ns->root_cset->dfl_cgrp == cgrp)))
 		return -EPERM;
 
 	if (cft->write)
-- 
2.34.1


