Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E056E33873F
	for <lists+cgroups@lfdr.de>; Fri, 12 Mar 2021 09:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhCLIYi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Fri, 12 Mar 2021 03:24:38 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25674 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231949AbhCLIY2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Mar 2021 03:24:28 -0500
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Mar 2021 03:24:28 EST
ARC-Seal: i=1; a=rsa-sha256; t=1615536544; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=OTJqQIFlM4Y9YwOSo28Ki7aWBw31ySLXqcUAbJ2BPASlwZVLW1Mm4GdzB7jwv4nR8oDz6Ins797JeWh/9RCb6ul1d5Rqa25U8o6fR85Byokepa2yGKljG3l3vQg+vIHpMzkcyIPne0FivP9zuZAOmTySs+5E2/5Tw4ugDOs9B3Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1615536544; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=WdIkUtKTZ+QqX4VIeF0sO/zsvOeoZNrqbPcj6CxnLCo=; 
        b=lmalM99V6gnOs7NtQzO1IIrjyuB7tpoiLlKeg3F2fm0e37ydVT5PpZsxH1CUjvew/T0rW2P9J39iUtzTaA9u/fYXBWAwfOYdLtIX0juJTPdkaN55tZeU1/wZCk+AIGFf8j6J2HY+N4H7+xUuFJvEdmBYLOLZKP5qtQXF5v91aDs=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        spf=pass  smtp.mailfrom=lifeng2221dd1@zoho.com.cn;
        dmarc=pass header.from=<lifeng2221dd1@zoho.com.cn> header.from=<lifeng2221dd1@zoho.com.cn>
Received: from localhost.localdomain (119.3.119.20 [119.3.119.20]) by mx.zoho.com.cn
        with SMTPS id 1615536542052342.6284454061615; Fri, 12 Mar 2021 16:09:02 +0800 (CST)
From:   Li Feng <lifeng2221dd1@zoho.com.cn>
To:     lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li Feng <lifeng2221dd1@zoho.com.cn>
Message-ID: <20210312080856.307010-1-lifeng2221dd1@zoho.com.cn>
Subject: [PATCH] cpuset: Modify the type of use_parent_ecpus from int to bool
Date:   Fri, 12 Mar 2021 16:08:56 +0800
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Since the use_parent_ecpus in cpuset is only used as bool type, change
the type from int to bool.

Signed-off-by: Li Feng <lifeng2221dd1@zoho.com.cn>
---
 kernel/cgroup/cpuset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 5258b68153e0..ab0bf3cc7093 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -158,7 +158,7 @@ struct cpuset {
 	 * use_parent_ecpus - set if using parent's effective_cpus
 	 * child_ecpus_count - # of children with use_parent_ecpus set
 	 */
-	int use_parent_ecpus;
+	bool use_parent_ecpus;
 	int child_ecpus_count;
 };
 
-- 
2.25.1


