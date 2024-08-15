Return-Path: <cgroups+bounces-4293-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B268F9527F6
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 04:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9541F22993
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 02:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2464D23776;
	Thu, 15 Aug 2024 02:48:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84A01D52B;
	Thu, 15 Aug 2024 02:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723690136; cv=none; b=X8nHmonDGQV7aG8B4Ysj5j1UdWUaCGmYQ+6IPoDgJn48AxhyG4CqewpSzusP3JCtzHJpUOOR4Ybu2fxxOfNKJv+BL5Lfjb8q8Qh9k3WXgppbOVsRNsScO4+MIQfu7uB2l+1T6REPRJtUjRfrlsm2Iq0yZKQHdgiIeOjXmKxa40k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723690136; c=relaxed/simple;
	bh=bdu088pZKFH729KfhS5H9Me5eSzHAaJecUxfHl63hbo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n3s9nHiZCkw/JocZ66OEXeFh+Erq3jRHCoBV6F8elQ5cVqFYkeT/m4GGgEsW/YwcbLxLdrq9eIBoq4IDYRpKQedKKJiEBqgZUv6f7B/1lS9DCAG1z3MDuYOAbmnWmMZbW6S8LLM9M4Y1U03jyqgwGJdxWlBtjR102PfjfDTPCTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WkqLp0fFJzcd7R;
	Thu, 15 Aug 2024 10:48:34 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id BC483180100;
	Thu, 15 Aug 2024 10:48:49 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 15 Aug
 2024 10:48:49 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] cgroup: update some statememt about delegation
Date: Thu, 15 Aug 2024 02:41:18 +0000
Message-ID: <20240815024118.3137952-1-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100013.china.huawei.com (7.221.188.163)

The comment in cgroup_file_write is missing some interfaces, such as
'cgroup.threads'. All delegatable files are listed in
'/sys/kernel/cgroup/delegate', so update the comment in cgroup_file_write.
Besides, add a statement that files outside the namespace shouldn't be
visible from inside the delegated namespace.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 10 ++++++----
 kernel/cgroup/cgroup.c                  |  4 ++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index f2d1ec7d6aba..2665d08159fb 100644
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
+outside the namespace shouldn't be visible from within the delegated
+namespace, and the kernel rejects writes to all files on a namespace
+root from inside the namespace, except for those files listed in
+"/sys/kernel/cgroup/delegate" (including "cgroup.procs", "cgroup.threads",
+"cgroup.subtree_control", etc.).
 
 The end results are equivalent for both delegation types.  Once
 delegated, the user can build sub-hierarchy under the directory,
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a3fa645f8433..9758686f0332 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4130,8 +4130,8 @@ static ssize_t cgroup_file_write(struct kernfs_open_file *of, char *buf,
 	/*
 	 * If namespaces are delegation boundaries, disallow writes to
 	 * files in an non-init namespace root from inside the namespace
-	 * except for the files explicitly marked delegatable -
-	 * cgroup.procs and cgroup.subtree_control.
+	 * except for the set delegatable files shown in /sys/kernel/cgroup/delegate,
+	 * including cgroup.procs, cgroup.threads and cgroup.subtree_control, etc.
 	 */
 	if ((cgrp->root->flags & CGRP_ROOT_NS_DELEGATE) &&
 	    !(cft->flags & CFTYPE_NS_DELEGATABLE) &&
-- 
2.34.1


