Return-Path: <cgroups+bounces-3000-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1A18CEE62
	for <lists+cgroups@lfdr.de>; Sat, 25 May 2024 11:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A122B1F217E6
	for <lists+cgroups@lfdr.de>; Sat, 25 May 2024 09:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DEB1CABD;
	Sat, 25 May 2024 09:52:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C26182DA;
	Sat, 25 May 2024 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716630748; cv=none; b=j+TtgLT9BbZ9eRfrQLU8yQV+4wo4jYn86tKAsswRlictj9vZSh2P2arBwl5mTl9FbmCniMh5UDou4c53g9FQ4SZdpzjA4s1SpYdnsBScyJiohL7T/ImzzP8PuwP7/7d8Jov27BSy9XUD7w0j9Cpji5mOe5fiGx6QOjoBzxpj8iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716630748; c=relaxed/simple;
	bh=tD+QmczheTUxar1fCHJMe0b9E8lkZgr0CdMtPvYE72A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i/Hzdl+CQfK1v+vgWmSbhIpaHxFNgkP5UjhMhAp74BpvKUqLKRySbAZhxjQk+jWT/wuuZsbOOmUufrsOg5te1lw0w6BJKQRdccXtpQMTUVA0D59xMKaEo/aYkIF5FIAhll1tgFJpVhfuQvKjmMTWKWazrhTPIGtz8hjiWZWI0UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VmcXl1W7YzkXfv;
	Sat, 25 May 2024 17:48:07 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id A8B4718007A;
	Sat, 25 May 2024 17:52:23 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 25 May 2024 17:52:23 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <longman@redhat.com>, <lizefan.x@bytedance.com>, <tj@kernel.org>,
	<hannes@cmpxchg.org>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] cgroup/cpuset: Update comment on callback_lock
Date: Sat, 25 May 2024 09:45:02 +0000
Message-ID: <20240525094502.1585015-1-xiujianfeng@huawei.com>
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
 dggpeml500023.china.huawei.com (7.185.36.114)

Since commit 51ffe41178c4 ("cpuset: convert away from cftype->read()"),
cpuset_common_file_read() has been renamed.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/cgroup/cpuset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a553e3d46498..f9d2a3487645 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -434,7 +434,7 @@ static struct cpuset top_cpuset = {
  * by other task, we use alloc_lock in the task_struct fields to protect
  * them.
  *
- * The cpuset_common_file_read() handlers only hold callback_lock across
+ * The cpuset_common_seq_show() handlers only hold callback_lock across
  * small pieces of code, such as when reading out possibly multi-word
  * cpumasks and nodemasks.
  *
-- 
2.34.1


