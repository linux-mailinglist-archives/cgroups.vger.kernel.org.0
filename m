Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D202EC92E
	for <lists+cgroups@lfdr.de>; Thu,  7 Jan 2021 04:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbhAGDrf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Wed, 6 Jan 2021 22:47:35 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25627 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725803AbhAGDrf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Jan 2021 22:47:35 -0500
X-Greylist: delayed 1025 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Jan 2021 22:47:34 EST
ARC-Seal: i=1; a=rsa-sha256; t=1609990167; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=TTuK7FcOgt6M/47/wYNX6651L6/PURDUYErdg92uwhug9euszEDczSb1E//eFhfdkhbDjGhDcQv280g6NtJp4SfYdbioaYigxf0CaBh5EalmNxjz5+aCLe4QuYPtRYENzXDg+iwSza/9kvAYcr5Di876NA6SFn6ewB35Hzkg2l4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1609990167; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=uYWksE99Or1EF4PbUoKnLfDhtz7wVdnHJRMthtjqons=; 
        b=WSsnug5l6e+DDfBo65464OA32qKvxZ8w+8L94u2YPggs16Mx8cWIJHwK7P/1Zf3XiMuvBNZ/UKb2V5A4JF9itW/yX4vJYzNKyViqL/GtqoXxxSVnMC8qNN2gndmEah3YDB7/2Ek4PKXtscok/QForPEqQDZQKniJhDWGGlsE5eM=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        spf=pass  smtp.mailfrom=lifeng2221dd1@zoho.com.cn;
        dmarc=pass header.from=<lifeng2221dd1@zoho.com.cn> header.from=<lifeng2221dd1@zoho.com.cn>
Received: from localhost.localdomain (119.3.119.20 [119.3.119.20]) by mx.zoho.com.cn
        with SMTPS id 1609990165137116.07589932104474; Thu, 7 Jan 2021 11:29:25 +0800 (CST)
From:   lifeng68 <lifeng2221dd1@zoho.com.cn>
To:     lizefan@huawei.com, tj@kernel.org, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        lifeng68 <lifeng2221dd1@zoho.com.cn>
Message-ID: <20210107032916.1097229-1-lifeng2221dd1@zoho.com.cn>
Subject: [PATCH] cpuset: Modify the type of use_parent_ecpus from int to bool
Date:   Thu,  7 Jan 2021 11:29:16 +0800
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

Signed-off-by: lifeng68 <lifeng2221dd1@zoho.com.cn>
---
 kernel/cgroup/cpuset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 53c70c470a38..c074e9f1064b 100644
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


