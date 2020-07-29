Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303EB231FDF
	for <lists+cgroups@lfdr.de>; Wed, 29 Jul 2020 16:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgG2OFq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Jul 2020 10:05:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:33608 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgG2OFq (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 29 Jul 2020 10:05:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CDC60AC48;
        Wed, 29 Jul 2020 14:05:56 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/3] docs: cgroup: Explain reclaim protection target
Date:   Wed, 29 Jul 2020 16:05:35 +0200
Message-Id: <20200729140537.13345-2-mkoutny@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200729140537.13345-1-mkoutny@suse.com>
References: <20200729140537.13345-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index d09471aa7443..94bdff4f9e09 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -47,7 +47,8 @@ v1 is available under :ref:`Documentation/admin-guide/cgroup-v1/index.rst <cgrou
      5-2. Memory
        5-2-1. Memory Interface Files
        5-2-2. Usage Guidelines
-       5-2-3. Memory Ownership
+       5-2-3. Reclaim Protection
+       5-2-4. Memory Ownership
      5-3. IO
        5-3-1. IO Interface Files
        5-3-2. Writeback
@@ -1113,7 +1114,7 @@ PAGE_SIZE multiple when read back.
 	smaller overages.
 
 	Effective min boundary is limited by memory.min values of
-	all ancestor cgroups. If there is memory.min overcommitment
+	ancestor cgroups. If there is memory.min overcommitment
 	(child cgroup or cgroups are requiring more protected memory
 	than parent will allow), then each child cgroup will get
 	the part of parent's protection proportional to its
@@ -1139,7 +1140,7 @@ PAGE_SIZE multiple when read back.
 	smaller overages.
 
 	Effective low boundary is limited by memory.low values of
-	all ancestor cgroups. If there is memory.low overcommitment
+	ancestor cgroups. If there is memory.low overcommitment
 	(child cgroup or cgroups are requiring more protected memory
 	than parent will allow), then each child cgroup will get
 	the part of parent's protection proportional to its
@@ -1449,6 +1450,23 @@ memory - is necessary to determine whether a workload needs more
 memory; unfortunately, memory pressure monitoring mechanism isn't
 implemented yet.
 
+Reclaim Protection
+~~~~~~~~~~~~~~~~~~
+
+The protection configured with "memory.low" or "memory.min" applies relatively
+to the target of the reclaim (i.e. any of memory cgroup limits or global
+pressure located in the root cgroup).
+
+  ... - A - B - C
+              \ D
+          \ E
+
+The protection value configured for B applies unchanged to the reclaim
+targeting A (i.e. caused by competition with the sibling E).  When the reclaim
+targets ancestors of A, the effective protection of B is capped by the
+protection value configured for A (and any other intermediate ancestors between
+A and the target).
+
 
 Memory Ownership
 ~~~~~~~~~~~~~~~~
-- 
2.27.0

