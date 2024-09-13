Return-Path: <cgroups+bounces-4874-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6100978114
	for <lists+cgroups@lfdr.de>; Fri, 13 Sep 2024 15:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BA4EB24D5A
	for <lists+cgroups@lfdr.de>; Fri, 13 Sep 2024 13:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E751DB559;
	Fri, 13 Sep 2024 13:25:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8811E892;
	Fri, 13 Sep 2024 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233939; cv=none; b=KdhNOLykSY+Rip7KCc0CfwiLGfTUL/UU/3YQmiN1eBGwUqN6KC2Il+y+FqNpksHy+JWSi7QiS41gq0ATwJ1QZOExmZ+l/pj/VawAYg0mU/W3XyO0bK8+Tk4ySWMbzmnmCIkkRjJRotdr+ok61A+w8aliKdgc9pRIqIuoJPbCKe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233939; c=relaxed/simple;
	bh=jrkvQb9JHC+R7KVldUDHK5KkjrVybDN0XoN4ddqbUPY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T5txcDJmC8+QLATR9jaV6K9NK7QKWnglhQaoSTaq5p7OZr1Z3J6bR26jkOqwJkaJ5e1bhnoyUQnnNiJZS47JgPRFlLJuwmn9XxtGVgy7FGlJzD/PYcLhmh45m+6fckPSnvEbyl2PFMJvdJKMR69ahU13nIAYA4OhCdji/T/43gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X4w6F2wj6z20nvp;
	Fri, 13 Sep 2024 21:25:25 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id A7D5A1402CD;
	Fri, 13 Sep 2024 21:25:33 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 13 Sep
 2024 21:25:32 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <martin.lau@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>, <tj@kernel.org>,
	<lizefan.x@bytedance.com>, <hannes@cmpxchg.org>, <roman.gushchin@linux.dev>
CC: <bpf@vger.kernel.org>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/3] workqueue: doc: Add a note saturating the system_wq is not permitted
Date: Fri, 13 Sep 2024 13:17:19 +0000
Message-ID: <20240913131720.1762188-3-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913131720.1762188-1-chenridong@huawei.com>
References: <20240913131720.1762188-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100013.china.huawei.com (7.221.188.163)

If something is expected to generate large number of concurrent works,
it should utilize its own dedicated workqueue rather than system wq.
Because this may saturate system_wq and potentially block other's works.
eg, cgroup release work. Let's document this as a note.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 Documentation/core-api/workqueue.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index 16f861c9791e..338b25e86f8c 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -356,6 +356,10 @@ Guidelines
   special attribute, can use one of the system wq.  There is no
   difference in execution characteristics between using a dedicated wq
   and a system wq.
+  Note: If something is expected to generate large number of concurrent
+  works, it should utilize its own dedicated workqueue rather than
+  system wq. Because this may saturate system_wq and potentially block
+  other's works. eg, cgroup release work.
 
 * Unless work items are expected to consume a huge amount of CPU
   cycles, using a bound wq is usually beneficial due to the increased
-- 
2.34.1


