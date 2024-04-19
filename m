Return-Path: <cgroups+bounces-2609-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E85748AAB16
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 11:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51C9281DA8
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 09:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214E57641D;
	Fri, 19 Apr 2024 08:59:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFA1757F7;
	Fri, 19 Apr 2024 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713517188; cv=none; b=iqb7oyhIMYo8ItjbERUbsGTMgP25xhp4lOsC09vljMSHNp1T10OU2ZvzRDg9fDH7DPqMzYBhunDe8UtvDu7T8I0uqsWMD8qCzGXvojKRkF0Vqb+TFx4/rc05/etCLoK03EYgyfHxmGE0pn5agxo0N9SwOaj3j9ND1jl3sFGqZxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713517188; c=relaxed/simple;
	bh=nrVql+dhu47+Yo4J4ftWOub8YL90A762db0V4CFPkks=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M4LhrhbYIg3CmkELe/1g4ITPipIffJattVeoXIDuHNg6YfAe/Fci/4vctgAwGnLtBfHcCGwMw08MMTMqUDfjnWLTYOCD62Dl8jsCq14ZPkV+npxE10DOAKD+kPm8jqighNmLW+9X9MYa/bhM7GvHkYlJf08yIKxsIS6qts639E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VLT685D5cz1N8Q2;
	Fri, 19 Apr 2024 16:56:48 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id A0259140124;
	Fri, 19 Apr 2024 16:59:43 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 16:59:43 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] cgroup: avoid invalid loop in cgroup_no_v1()
Date: Fri, 19 Apr 2024 08:53:16 +0000
Message-ID: <20240419085316.957277-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500023.china.huawei.com (7.185.36.114)

We should break the for_each_subsys loop after the token matches
the name of subsys and cgroup_no_v1_mask is set.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/cgroup/cgroup-v1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 520a11cb12f4..b9dbf6bf2779 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -1335,6 +1335,7 @@ static int __init cgroup_no_v1(char *str)
 				continue;
 
 			cgroup_no_v1_mask |= 1 << i;
+			break;
 		}
 	}
 	return 1;
-- 
2.34.1


