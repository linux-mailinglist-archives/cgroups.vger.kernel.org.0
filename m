Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203463E9948
	for <lists+cgroups@lfdr.de>; Wed, 11 Aug 2021 21:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhHKT6Y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Aug 2021 15:58:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38322 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229991AbhHKT6Y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Aug 2021 15:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628711880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=WxdcaYuyKYoi6tYy6rnNj7AJtwXW/DVftZFjymOGA2c=;
        b=c5lcvTKVGt+/wwgvMdYJ0ARA5hOF/ipJ7dKb/78lq1BiqvfHMbSQ5LUvXOHGzytGqMlEYu
        pK1DeMFmdVdFfC6ago9W3ypyOFRCiDc+SsEXgihnf4wk5Az9IqjbGeJNWdtOq3S5b7spzR
        Lwm5e/5O+sD82A6/1i0TCLUUlWCxi8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-THlbMnEaOlCLFHARtJeTbg-1; Wed, 11 Aug 2021 15:57:56 -0400
X-MC-Unique: THlbMnEaOlCLFHARtJeTbg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D109192D78F;
        Wed, 11 Aug 2021 19:57:41 +0000 (UTC)
Received: from llong.com (unknown [10.22.18.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98E29797C8;
        Wed, 11 Aug 2021 19:57:17 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH v2] cgroup/cpuset: Enable memory migration for cpuset v2
Date:   Wed, 11 Aug 2021 15:57:07 -0400
Message-Id: <20210811195707.30851-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When a user changes cpuset.cpus, each task in a v2 cpuset will be moved
to one of the new cpus if it is not there already. For memory, however,
they won't be migrated to the new nodes when cpuset.mems changes. This is
an inconsistency in behavior.

In cpuset v1, there is a memory_migrate control file to enable such
behavior by setting the CS_MEMORY_MIGRATE flag. Make it the default
for cpuset v2 so that we have a consistent set of behavior for both
cpus and memory.

There is certainly a cost to make memory migration the default, but it
is a one time cost that shouldn't really matter as long as cpuset.mems
isn't changed frequenty.  Update the cgroup-v2.rst file to document the
new behavior and recommend against changing cpuset.mems frequently.

Since there won't be any concurrent access to the newly allocated cpuset
structure in cpuset_css_alloc(), we can use the cheaper non-atomic
__set_bit() instead of the more expensive atomic set_bit().

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 11 +++++++++++
 kernel/cgroup/cpuset.c                  |  6 +++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 5c7377b5bd3e..babbe04c8d37 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2056,6 +2056,17 @@ Cpuset Interface Files
 	The value of "cpuset.mems" stays constant until the next update
 	and won't be affected by any memory nodes hotplug events.
 
+	Setting a non-empty value to "cpuset.mems" causes memory of
+	tasks within the cgroup to be migrated to the designated nodes if
+	they are currently using memory outside of the designated nodes.
+
+	There is a cost for this memory migration.  The migration
+	may not be complete and some memory pages may be left behind.
+	So it is recommended that "cpuset.mems" should be set properly
+	before spawning new tasks into the cpuset.  Even if there is
+	a need to change "cpuset.mems" with active tasks, it shouldn't
+	be done frequently.
+
   cpuset.mems.effective
 	A read-only multiple values file which exists on all
 	cpuset-enabled cgroups.
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index adb5190c4429..d151e1de93d4 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2737,12 +2737,16 @@ cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
 		return ERR_PTR(-ENOMEM);
 	}
 
-	set_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
+	__set_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
 	nodes_clear(cs->mems_allowed);
 	nodes_clear(cs->effective_mems);
 	fmeter_init(&cs->fmeter);
 	cs->relax_domain_level = -1;
 
+	/* Set CS_MEMORY_MIGRATE for default hierarchy */
+	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys))
+		__set_bit(CS_MEMORY_MIGRATE, &cs->flags);
+
 	return &cs->css;
 }
 
-- 
2.18.1

