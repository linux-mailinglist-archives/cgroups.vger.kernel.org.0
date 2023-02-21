Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4284069E264
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 15:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbjBUOe3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 09:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjBUOe2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 09:34:28 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07425FD7;
        Tue, 21 Feb 2023 06:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1676990067;
  x=1708526067;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e0/vm795K+DdiwKlFn5UN5He4cprPggTB4iadCKSttU=;
  b=c2aVEOSHIXeNdSzupVDL/Xc8tvIdiY1iEPB3wD22nysxQuqzPzWvAFkk
   EtUY/zqyaVQcV85IbbrRn0YaUIfhGxuSdMBgHbjkz0vg8A4oKfeTF5uVe
   iU1wbH4cRw0Xsk7biuXS0+p9yndMzFK0KAXqfstNh1Mgk0WIi/FCwsxL8
   p6IyDUbqdIUAPpUa5dlcScQtobaf8nirsBro/83t4tGcZAX9B4tbbLJ0z
   sApuKgesbLzq3pBghWxuahjG9JYBYY+2JNcSlfspPU2GzBbBhRmUTKnaC
   1d1/Ozk/DziluuEgMpM+PtdZiC46C1xpBm4HANq0t+sca0F+xs71ADfCh
   w==;
From:   Matthew Chae <matthew.chae@axis.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <kernel@axis.com>, <christopher.wong@axis.com>,
        Matthew Chae <matthew.chae@axis.com>,
        Muchun Song <muchun.song@linux.dev>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/memcontrol: add memory.peak in cgroup root
Date:   Tue, 21 Feb 2023 15:34:20 +0100
Message-ID: <20230221143421.10385-1-matthew.chae@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The kernel currently doesn't provide any method to show the overall
system's peak memory usage recorded. Instead, only each slice's peak
memory usage recorded except for cgroup root is shown through each
memory.peak.

Each slice might consume their peak memory at different time. This is
stored at memory.peak in each own slice. The sum of every memory.peak
doesn't mean the total system's peak memory usage recorded. The sum at
certain point without having a peak memory usage in their slice can have
the largest value.

       time |  slice1  |  slice2  |   sum
      =======================================
        t1  |    50    |   200    |   250
      ---------------------------------------
        t2  |   150    |   150    |   300
      ---------------------------------------
        t3  |   180    |    20    |   200
      ---------------------------------------
        t4  |    80    |    20    |   100

memory.peak value of slice1 is 180 and memory.peak value of slice2 is 200.
Only these information are provided through memory.peak value from each
slice without providing the overall system's peak memory usage. The total
sum of these two value is 380, but this doesn't represent the real peak
memory usage of the overall system. The peak value what we want to get is
shown in t2 as 300, which doesn't have any biggest number even in one
slice. Therefore the proper way to show the system's overall peak memory
usage recorded needs to be provided.

Hence, expose memory.peak in the cgrop root in order to allow this.

Co-developed-by: Christopher Wong <christopher.wong@axis.com>
Signed-off-by: Christopher Wong <christopher.wong@axis.com>
Signed-off-by: Matthew Chae <matthew.chae@axis.com>
---
 mm/memcontrol.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 73afff8062f9..974fc044a7e7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6646,7 +6646,6 @@ static struct cftype memory_files[] = {
 	},
 	{
 		.name = "peak",
-		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = memory_peak_read,
 	},
 	{
-- 
2.20.1

