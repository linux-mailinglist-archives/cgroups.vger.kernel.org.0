Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0015501F5C
	for <lists+cgroups@lfdr.de>; Fri, 15 Apr 2022 02:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347800AbiDOAEM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Apr 2022 20:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240890AbiDOAEL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Apr 2022 20:04:11 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE30B57164;
        Thu, 14 Apr 2022 17:01:45 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649980904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=x0OJT7vtHeCsFa3T3M2nSJtuwiJNpM1MZE2d38sUzeE=;
        b=TnMKjcFycGksoGIHsEZYPyuP5tGDPSWVACST3hbjTjCsgJ+rldhg9Bza3n9fsrh56wJTYB
        WJReZfLJggzdlpikXj9ouMRFCzA+2uY3TyOh9z/sguWkNnBzjhfigrHxD+DYDn6mI9XhrM
        kk2gFy8dWtqvNlsR/WkxT/qaUPQbqFc=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH 0/4] mm: memcg kselftests fixes
Date:   Thu, 14 Apr 2022 17:01:29 -0700
Message-Id: <20220415000133.3955987-1-roman.gushchin@linux.dev>
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

I'm resending two memcg kselftests fixes, which I first posted in 2019 [1],
however they didn't go anywhere. I've rechecked them and they're are both
still actual, even though there were new regressions introduced since that,
so not all tests are passing now. I know that David Vernet (cc'ed) is working
on fixing (some of) them, so hopefully he'll post more fixes soon.

I believe it's better for such patches to go through mm and cgroup trees
(and mailing lists), where there are better chances for them to be properly
reviewed, so adding corresponding entries to the MAINTAINERS file to make it
obvious.

1: https://lore.kernel.org/lkml/20191203165758.GA607734@chrisdown.name/T/


Roman Gushchin (4):
  kselftests: memcg: update the oom group leaf events test
  kselftests: memcg: speed up the memory.high test
  MAINTAINERS: add corresponding kselftests to cgroup entry
  MAINTAINERS: add corresponding kselftests to memcg entry

 MAINTAINERS                                      | 3 +++
 tools/testing/selftests/cgroup/test_memcontrol.c | 7 ++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.35.1

