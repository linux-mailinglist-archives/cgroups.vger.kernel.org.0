Return-Path: <cgroups+bounces-4201-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE5494E80C
	for <lists+cgroups@lfdr.de>; Mon, 12 Aug 2024 09:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05F41C21B9C
	for <lists+cgroups@lfdr.de>; Mon, 12 Aug 2024 07:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0291916849A;
	Mon, 12 Aug 2024 07:45:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41A413E40F;
	Mon, 12 Aug 2024 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723448741; cv=none; b=omK2uaXj8/LMP7zh4TExF6JlGQX96BPdO2x70e+KZYvNw+eB2c3xvLliLU4/2CKogMEPhbARs3oouPAb2Sw7KeEuzDOt47ukrYOBKgOmB0FbthqZTRpOG45l/O55YKZ2wH0Ixn4kxlkscodZ7EZE+tm0EX/O6CiRllmhHSEHL/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723448741; c=relaxed/simple;
	bh=TKcMFQSeCQZWv/nWYsGRVTZl4PK3WoyJ8xphSu+459U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=br0Lo5TAgq/kTLpW6G7Gpiw+Uo3IAIYB5fWmtnly16msKbq+NtSG7H0pnAAOqFUmL00n6+jZcpb21nOfBC4YkDI2IxBiowEIxm8jT3vUrx2oukCq+ORW2gqpKTuzOhwDFerzZ6MEifMOyxKPu1tIVmGpdVrZ1a0rltbWErxHelw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wj5zF64l1z1S7c8;
	Mon, 12 Aug 2024 15:40:41 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B3F21A016C;
	Mon, 12 Aug 2024 15:45:31 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 12 Aug
 2024 15:45:30 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 1/2] cgroup: update comment about delegation
Date: Mon, 12 Aug 2024 07:37:45 +0000
Message-ID: <20240812073746.3070616-2-chenridong@huawei.com>
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

There are three interfaces that delegatee was not allowed to write.
However, cgroup.threads was missed at some place, just add it.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 6 +++---
 kernel/cgroup/cgroup.c                  | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index f2d1ec7d6aba..513fd142293c 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -534,9 +534,9 @@ Because the resource control interface files in a given directory
 control the distribution of the parent's resources, the delegatee
 shouldn't be allowed to write to them.  For the first method, this is
 achieved by not granting access to these files.  For the second, the
-kernel rejects writes to all files other than "cgroup.procs" and
-"cgroup.subtree_control" on a namespace root from inside the
-namespace.
+kernel rejects writes to all files other than "cgroup.procs",
+"cgroup.threads" and "cgroup.subtree_control" on a namespace
+root from inside the namespace.
 
 The end results are equivalent for both delegation types.  Once
 delegated, the user can build sub-hierarchy under the directory,
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a3fa645f8433..8dbe00000fd4 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4131,7 +4131,7 @@ static ssize_t cgroup_file_write(struct kernfs_open_file *of, char *buf,
 	 * If namespaces are delegation boundaries, disallow writes to
 	 * files in an non-init namespace root from inside the namespace
 	 * except for the files explicitly marked delegatable -
-	 * cgroup.procs and cgroup.subtree_control.
+	 * cgroup.procs, cgroup.threads and cgroup.subtree_control.
 	 */
 	if ((cgrp->root->flags & CGRP_ROOT_NS_DELEGATE) &&
 	    !(cft->flags & CFTYPE_NS_DELEGATABLE) &&
-- 
2.34.1


