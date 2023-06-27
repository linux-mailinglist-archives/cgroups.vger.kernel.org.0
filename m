Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0C973FE1C
	for <lists+cgroups@lfdr.de>; Tue, 27 Jun 2023 16:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjF0Oh5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Jun 2023 10:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjF0Ohb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Jun 2023 10:37:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1317835BC
        for <cgroups@vger.kernel.org>; Tue, 27 Jun 2023 07:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687876586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5WrK5WBWoc32LURr2EuT+ipNK/yro3aBjT13t4QPtY8=;
        b=f9pSxslYiw5Q1Z8BBehcBmyLCP7l22AFWitTUIdaqC6af6crh6U9FJvT3MXCHzq4hQcum+
        RFVe7oBNkJd1wqYfDC/okPk/117ZAjqVMLfiDsOpFR82SG5bTMUsu21QvW5Mx4WfbvVnCl
        LSu8lgzBhP0dRgfSu3c3PM38IutlG4w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-69eAfE6xOc2X-J3g1gNtrA-1; Tue, 27 Jun 2023 10:36:20 -0400
X-MC-Unique: 69eAfE6xOc2X-J3g1gNtrA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1C0B3C11CE6;
        Tue, 27 Jun 2023 14:35:38 +0000 (UTC)
Received: from llong.com (unknown [10.22.10.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E718F40C2063;
        Tue, 27 Jun 2023 14:35:37 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mrunal Patel <mpatel@redhat.com>,
        Ryan Phillips <rphillips@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>, Phil Auld <pauld@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 8/9] cgroup/cpuset: Documentation update for partition
Date:   Tue, 27 Jun 2023 10:35:07 -0400
Message-Id: <20230627143508.1576882-9-longman@redhat.com>
In-Reply-To: <20230627143508.1576882-1-longman@redhat.com>
References: <20230627143508.1576882-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch updates the cgroup-v2.rst file to include information about
the new "cpuset.cpus.exclusive" control file as well as the new remote
partition.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 100 ++++++++++++++++++------
 1 file changed, 74 insertions(+), 26 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index d9f3768a10db..8dd7464f93dc 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2215,6 +2215,27 @@ Cpuset Interface Files
 
 	Its value will be affected by memory nodes hotplug events.
 
+  cpuset.cpus.exclusive
+	A read-write multiple values file which exists on non-root
+	cpuset-enabled cgroups.
+
+	It lists all the exclusive CPUs that can be used to create a
+	new cpuset partition.  Its value is not used unless the cgroup
+	becomes a valid partition root.  See the next section below
+	for a description of what a cpuset partition is.
+
+	The root cgroup is a partition root and all its available CPUs
+	are in its exclusive CPU set.
+
+	There are constraints on what values are acceptable
+	to this control file.  Its value must be a subset of
+	the cgroup's "cpuset.cpus" value and the parent cgroup's
+	"cpuset.cpus.exclusive" value.	For a parent cgroup, any one
+	its exclusive CPUs can only be distributed to at most one of
+	its child cgroups.  Having an exclusive CPU appearing in two or
+	more of its child cgroups is not allowed (the exclusivity rule).
+	An invalid value will be rejected with a write error.
+
   cpuset.cpus.partition
 	A read-write single value file which exists on non-root
 	cpuset-enabled cgroups.  This flag is owned by the parent cgroup
@@ -2228,26 +2249,41 @@ Cpuset Interface Files
 	  "isolated"	Partition root without load balancing
 	  ==========	=====================================
 
-	The root cgroup is always a partition root and its state
-	cannot be changed.  All other non-root cgroups start out as
-	"member".
+	A cpuset partition is a collection of cpuset-enabled cgroups with
+	a partition root at the top of the hierarchy and its descendants
+	except those that are separate partition roots themselves and
+	their descendants.  A partition has exclusive access to the
+	set of exclusive CPUs allocated to it.	Other cgroups outside
+	of that partition cannot use any CPUs in that set.
+
+	There are two types of partitions - local and remote.  A local
+	partition is one whose parent cgroup is also a valid partition
+	root.  A remote partition is one whose parent cgroup is not a
+	valid partition root itself.  Writing to "cpuset.cpus.exclusive"
+	is not mandatory for the creation of a local partition as its
+	"cpuset.cpus.exclusive" file will be filled in automatically if
+	it is not set.	The automaticaly set value will be based on its
+	"cpuset.cpus" value.  Writing the proper "cpuset.cpus.exclusive"
+	values down the cgroup hierarchy is mandatory for the creation
+	of a remote partition.
+
+	Currently, a remote partition cannot be created under a local
+	partition.  All the ancestors of a remote partition root except
+	the root cgroup cannot be partition root.
+
+	The root cgroup is always a partition root and its state cannot
+	be changed.  All other non-root cgroups start out as "member".
 
 	When set to "root", the current cgroup is the root of a new
-	partition or scheduling domain that comprises itself and all
-	its descendants except those that are separate partition roots
-	themselves and their descendants.
+	partition or scheduling domain.  The set of exclusive CPUs is
+	determined by the value of its "cpuset.cpus.exclusive".
 
-	When set to "isolated", the CPUs in that partition root will
+	When set to "isolated", the CPUs in that partition will
 	be in an isolated state without any load balancing from the
 	scheduler.  Tasks placed in such a partition with multiple
 	CPUs should be carefully distributed and bound to each of the
 	individual CPUs for optimal performance.
 
-	The value shown in "cpuset.cpus.effective" of a partition root
-	is the CPUs that the partition root can dedicate to a potential
-	new child partition root. The new child subtracts available
-	CPUs from its parent "cpuset.cpus.effective".
-
 	A partition root ("root" or "isolated") can be in one of the
 	two possible states - valid or invalid.  An invalid partition
 	root is in a degraded state where some state information may
@@ -2270,33 +2306,40 @@ Cpuset Interface Files
 	In the case of an invalid partition root, a descriptive string on
 	why the partition is invalid is included within parentheses.
 
-	For a partition root to become valid, the following conditions
+	For a local partition root to be valid, the following conditions
 	must be met.
 
-	1) The "cpuset.cpus" is exclusive with its siblings , i.e. they
-	   are not shared by any of its siblings (exclusivity rule).
-	2) The parent cgroup is a valid partition root.
-	3) The "cpuset.cpus" is not empty and must contain at least
-	   one of the CPUs from parent's "cpuset.cpus", i.e. they overlap.
+	1) The parent cgroup is a valid partition root.
+	2) The "cpuset.cpus.exclusive" is exclusive with its siblings ,
+	   i.e. they are not shared by any of its siblings (exclusivity
+	   rule).
+	3) The "cpuset.cpus.exclusive" is not empty, but it may contain
+	   offline CPUs.
 	4) The "cpuset.cpus.effective" cannot be empty unless there is
 	   no task associated with this partition.
 
-	External events like hotplug or changes to "cpuset.cpus" can
-	cause a valid partition root to become invalid and vice versa.
-	Note that a task cannot be moved to a cgroup with empty
-	"cpuset.cpus.effective".
+	For a remote partition root to be valid, all the above conditions
+	except the first one must be met.
+
+	External events like hotplug or changes to "cpuset.cpus" or
+	"cpuset.cpus.exclusive" can cause a valid partition root to
+	become invalid and vice versa.	Note that a task cannot be
+	moved to a cgroup with empty "cpuset.cpus.effective".
 
 	For a valid partition root with the sibling cpu exclusivity
 	rule enabled, changes made to "cpuset.cpus" that violate the
 	exclusivity rule will invalidate the partition as well as its
 	sibling partitions with conflicting cpuset.cpus values. So
-	care must be taking in changing "cpuset.cpus".
+	care must be taking in changing "cpuset.cpus".	Changes to
+	"cpuset.cpus.exclusive" that violates the exclusivity rule will
+	not be allowed.
 
 	A valid non-root parent partition may distribute out all its CPUs
-	to its child partitions when there is no task associated with it.
+	to its child local partitions when there is no task associated
+	with it.
 
-	Care must be taken to change a valid partition root to
-	"member" as all its child partitions, if present, will become
+	Care must be taken to change a valid partition root to "member"
+	as all its child local partitions, if present, will become
 	invalid causing disruption to tasks running in those child
 	partitions. These inactivated partitions could be recovered if
 	their parent is switched back to a partition root with a proper
@@ -2310,6 +2353,11 @@ Cpuset Interface Files
 	to "cpuset.cpus.partition" without the need to do continuous
 	polling.
 
+	A user can pre-configure certain CPUs to an isolated state at
+	boot time with the "isolcpus" kernel boot command line option.
+	If those CPUs are to be put into a partition, they have to
+	be used in an isolated partition.
+
 
 Device controller
 -----------------
-- 
2.31.1

