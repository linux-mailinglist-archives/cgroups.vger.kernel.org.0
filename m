Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203CD501F64
	for <lists+cgroups@lfdr.de>; Fri, 15 Apr 2022 02:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347857AbiDOAE3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Apr 2022 20:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347856AbiDOAEZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Apr 2022 20:04:25 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927E885962;
        Thu, 14 Apr 2022 17:01:58 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649980917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=740eiMaj1mMtgTIenrEzjJ/eAUZj68u7jwk/iuSKMgA=;
        b=w26K1SB+vI3qaqMdu0othXCQB1y7ABS7GYKBiHyjn7Oq83TXcDjd1nQYCaEtHy+xgPM2wp
        GsIYAeRN7r6m+9/Z7v8uqQDhugTRg+GPlcAUuoul5FPpn8AI9RG3IKCDqQzkdbFVSf5Awd
        sdlg8ExeisaxNfQ/UzhP7myUs0ox6Pc=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH 4/4] MAINTAINERS: add corresponding kselftests to memcg entry
Date:   Thu, 14 Apr 2022 17:01:33 -0700
Message-Id: <20220415000133.3955987-5-roman.gushchin@linux.dev>
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

List memory control and kernel memory control kselftests in the memory
resource controller entry.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 44dabe0145ae..0dd3d276f330 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5030,6 +5030,8 @@ L:	linux-mm@kvack.org
 S:	Maintained
 F:	mm/memcontrol.c
 F:	mm/swap_cgroup.c
+F:	tools/testing/selftests/cgroup/test_kmem.c
+F:	tools/testing/selftests/cgroup/test_memcontrol.c
 
 CORETEMP HARDWARE MONITORING DRIVER
 M:	Fenghua Yu <fenghua.yu@intel.com>
-- 
2.35.1

