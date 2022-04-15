Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF6F501F62
	for <lists+cgroups@lfdr.de>; Fri, 15 Apr 2022 02:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347836AbiDOAE0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Apr 2022 20:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347839AbiDOAEW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Apr 2022 20:04:22 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD8A6350F;
        Thu, 14 Apr 2022 17:01:55 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649980914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hmYLxb1+mMr6jmOwnIg2k48EEFJdR9ToYiqAQACrt3M=;
        b=nfzHyoF3QlG0i3ONCxWOVkP22GqWy34FQSUolZw34J6jzLgX3HnZJW//B8a7oIXF18S5Lj
        6q+QBKlYxNFwuJhjmv06yLBxj6h0wbsU2Q7lC7w3ogchvkCNC4Pfke1EFRxtDGdTwuCZh+
        8BDA/ZA6jVpPFrWjLd2z1e5nwQ6yOdw=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: [PATCH 3/4] MAINTAINERS: add corresponding kselftests to cgroup entry
Date:   Thu, 14 Apr 2022 17:01:32 -0700
Message-Id: <20220415000133.3955987-4-roman.gushchin@linux.dev>
In-Reply-To: <20220415000133.3955987-1-roman.gushchin@linux.dev>
References: <20220415000133.3955987-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

List cgroup kselftests in the cgroup MAINTAINERS entry.
These are tests covering core, freezer and cgroup.kill
functionality.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d5731c03a485..44dabe0145ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4996,6 +4996,7 @@ F:	Documentation/admin-guide/cgroup-v1/
 F:	Documentation/admin-guide/cgroup-v2.rst
 F:	include/linux/cgroup*
 F:	kernel/cgroup/
+F:	tools/testing/selftests/cgroup/
 
 CONTROL GROUP - BLOCK IO CONTROLLER (BLKIO)
 M:	Tejun Heo <tj@kernel.org>
-- 
2.35.1

