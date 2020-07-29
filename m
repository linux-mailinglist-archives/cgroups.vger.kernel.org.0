Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CDF231FE1
	for <lists+cgroups@lfdr.de>; Wed, 29 Jul 2020 16:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgG2OFr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Jul 2020 10:05:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:33630 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgG2OFq (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 29 Jul 2020 10:05:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E8A45AC83;
        Wed, 29 Jul 2020 14:05:56 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 3/3] docs: cgroup: No special handling of unpopulated memcgs
Date:   Wed, 29 Jul 2020 16:05:37 +0200
Message-Id: <20200729140537.13345-4-mkoutny@suse.com>
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

The current kernel doesn't handle unpopulated cgroups any special
regarding reclaim protection. Furthermore, this wasn't a case even when
this was introduced in
    bf8d5d52ffe89 ("memcg: introduce memory.min")
Drop the incorrect documentation. (Implementation taking into account
the inner-node constraint may be added later.)

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 47f9f056e66f..3d62922c4499 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1123,9 +1123,6 @@ PAGE_SIZE multiple when read back.
 	Putting more memory than generally available under this
 	protection is discouraged and may lead to constant OOMs.
 
-	If a memory cgroup is not populated with processes,
-	its memory.min is ignored.
-
   memory.low
 	A read-write single value file which exists on non-root
 	cgroups.  The default is "0".
-- 
2.27.0

