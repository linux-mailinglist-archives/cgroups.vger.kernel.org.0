Return-Path: <cgroups+bounces-4305-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BFA952EF8
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 15:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 314541C2308A
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 13:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139F717C984;
	Thu, 15 Aug 2024 13:21:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2601E521;
	Thu, 15 Aug 2024 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728118; cv=none; b=OtJwbsnHH463aLl62DMQtoAZ5aYIAPv0leEGbplvhVokAl0ZCHL4SFLUO5Ut5C2VQUtWF2hVUEOMViAAtNML1oBQIFLqAG6UJKXjbKB/Ti4CPai6osld658wyHXikPpoCtPmnHqk0unigXu4VC8cLT605tcDXugs56KySfy745w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728118; c=relaxed/simple;
	bh=Oe5QLGz9IsxtEhKFpb2QYxfZH/epKIlSLym8xKeYm1M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=leayrsGvp9ONBlI9Olep6oI0fzngfWYyxm92g93etyAQGVtYnDQn8GKrICE0D97qvHqmaWNQEnz12IIClUXa6455P63Ikd4SVlr19S5Jd6pVDXaLSW6OPzXsRe1q7JxYWEUrBsQnBeM83AifiW+5vViSomIQKmopupOZ6VrHhzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Wl5MF6NLgz1xvH1;
	Thu, 15 Aug 2024 21:19:53 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id C4B5414040F;
	Thu, 15 Aug 2024 21:21:45 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 15 Aug
 2024 21:21:45 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 -next] cgroup: update some statememt about delegation
Date: Thu, 15 Aug 2024 13:14:08 +0000
Message-ID: <20240815131408.3151804-1-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd100013.china.huawei.com (7.221.188.163)

The comment in cgroup_file_write is missing some interfaces, such as
'cgroup.threads'. All delegatable files are listed in
'/sys/kernel/cgroup/delegate', so update the comment in cgroup_file_write.
Besides, add a statement that files outside the namespace shouldn't be
visible from inside the delegated namespace.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 10 ++++++----
 kernel/cgroup/cgroup.c                  |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index f2d1ec7d6aba..3618168de371 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -533,10 +533,12 @@ cgroup namespace on namespace creation.
 Because the resource control interface files in a given directory
 control the distribution of the parent's resources, the delegatee
 shouldn't be allowed to write to them.  For the first method, this is
-achieved by not granting access to these files.  For the second, the
-kernel rejects writes to all files other than "cgroup.procs" and
-"cgroup.subtree_control" on a namespace root from inside the
-namespace.
+achieved by not granting access to these files.  For the second, files
+outside the namespace should be hidden from the delegatee by the means
+of at least mount namespacing, and the kernel rejects writes to all files
+on a namespace root from inside the cgroup namespace, except for those
+files listed in "/sys/kernel/cgroup/delegate" (including "cgroup.procs",
+"cgroup.threads", "cgroup.subtree_control", etc.).
 
 The end results are equivalent for both delegation types.  Once
 delegated, the user can build sub-hierarchy under the directory,
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a3fa645f8433..16b9749e131e 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4131,7 +4131,7 @@ static ssize_t cgroup_file_write(struct kernfs_open_file *of, char *buf,
 	 * If namespaces are delegation boundaries, disallow writes to
 	 * files in an non-init namespace root from inside the namespace
 	 * except for the files explicitly marked delegatable -
-	 * cgroup.procs and cgroup.subtree_control.
+	 * eg. cgroup.procs, cgroup.threads and cgroup.subtree_control.
 	 */
 	if ((cgrp->root->flags & CGRP_ROOT_NS_DELEGATE) &&
 	    !(cft->flags & CFTYPE_NS_DELEGATABLE) &&
-- 
2.34.1


