Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B6277F7A6
	for <lists+cgroups@lfdr.de>; Thu, 17 Aug 2023 15:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351226AbjHQN0u (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Aug 2023 09:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238572AbjHQN0T (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Aug 2023 09:26:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F0E2D7E
        for <cgroups@vger.kernel.org>; Thu, 17 Aug 2023 06:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692278738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cuqVxLpsIYLElZVQ73xju8tiYA7l9NmX4sCWRz6Oz8A=;
        b=CiaorQmEFAxMSEAyjcxK0ggLTjClVWDpNkHgnkY+tAXNHak3cQpA8hl4Cu/XyrNLpK404v
        08076NBcPYLOwCmMucLaB7qnlvctQfRs7W7UxtLPcQEtubSDKuv5iF/2PSstuMdiU1Q2wS
        rfBEQX8WBZgnFmHwQbAa4qn3ECEfkfg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-SHE2s4w0PGewit8_8NSIVQ-1; Thu, 17 Aug 2023 09:25:33 -0400
X-MC-Unique: SHE2s4w0PGewit8_8NSIVQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E1718EE645;
        Thu, 17 Aug 2023 13:25:14 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 00AD3492C1B;
        Thu, 17 Aug 2023 13:25:13 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup v7 5/6] cgroup/cpuset: Documentation update for partition
Date:   Thu, 17 Aug 2023 09:24:53 -0400
Message-Id: <20230817132454.755459-6-longman@redhat.com>
In-Reply-To: <20230817132454.755459-1-longman@redhat.com>
References: <20230817132454.755459-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch updates the cgroup-v2.rst file to include information about
the new "cpuset.cpus.exclusive" and "cpuset.cpus.excluisve.effective"
control files as well as the new remote partition type.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 123 ++++++++++++++++++------
 1 file changed, 91 insertions(+), 32 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index b26b5274eaaf..e40b8560e002 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2226,6 +2226,49 @@ Cpuset Interface Files
 
 	Its value will be affected by memory nodes hotplug events.
 
+  cpuset.cpus.exclusive
+	A read-write multiple values file which exists on non-root
+	cpuset-enabled cgroups.
+
+	It lists all the exclusive CPUs that are allowed to be used
+	to create a new cpuset partition.  Its value is not used
+	unless the cgroup becomes a valid partition root.  See the
+	"cpuset.cpus.partition" section below for a description of what
+	a cpuset partition is.
+
+	When the cgroup becomes a partition root, the actual exclusive
+	CPUs that are allocated to that partition are listed in
+	"cpuset.cpus.exclusive.effective" which may be different
+	from "cpuset.cpus.exclusive".  If "cpuset.cpus.exclusive"
+	has previously been set, "cpuset.cpus.exclusive.effective"
+	is always a subset of it.
+
+	Users can manually set it to a value that is different from
+	"cpuset.cpus".	The only constraint in setting it is that the
+	list of CPUs must be exclusive with respect to its sibling.
+
+	For a parent cgroup, any one of its exclusive CPUs can only
+	be distributed to at most one of its child cgroups.  Having an
+	exclusive CPU appearing in two or more of its child cgroups is
+	not allowed (the exclusivity rule).  A value that violates the
+	exclusivity rule will be rejected with a write error.
+
+	The root cgroup is a partition root and all its available CPUs
+	are in its exclusive CPU set.
+
+  cpuset.cpus.exclusive.effective
+	A read-only multiple values file which exists on all non-root
+	cpuset-enabled cgroups.
+
+	This file shows the effective set of exclusive CPUs that
+	can be used to create a partition root.  The content of this
+	file will always be a subset of "cpuset.cpus" and its parent's
+	"cpuset.cpus.exclusive.effective" if its parent is not the root
+	cgroup.  It will also be a subset of "cpuset.cpus.exclusive"
+	if it is set.  If "cpuset.cpus.exclusive" is not set, it is
+	treated to have an implicit value of "cpuset.cpus" in the
+	formation of local partition.
+
   cpuset.cpus.partition
 	A read-write single value file which exists on non-root
 	cpuset-enabled cgroups.  This flag is owned by the parent cgroup
@@ -2239,26 +2282,41 @@ Cpuset Interface Files
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
+	is optional for the creation of a local partition as its
+	"cpuset.cpus.exclusive" file will assume an implicit value that
+	is the same as "cpuset.cpus" if it is not set.	Writing the
+	proper "cpuset.cpus.exclusive" values down the cgroup hierarchy
+	before the target partition root is mandatory for the creation
+	of a remote partition.
+
+	Currently, a remote partition cannot be created under a local
+	partition.  All the ancestors of a remote partition root except
+	the root cgroup cannot be a partition root.
+
+	The root cgroup is always a partition root and its state cannot
+	be changed.  All other non-root cgroups start out as "member".
 
 	When set to "root", the current cgroup is the root of a new
-	partition or scheduling domain that comprises itself and all
-	its descendants except those that are separate partition roots
-	themselves and their descendants.
+	partition or scheduling domain.  The set of exclusive CPUs is
+	determined by the value of its "cpuset.cpus.exclusive.effective".
 
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
@@ -2281,37 +2339,33 @@ Cpuset Interface Files
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
-	4) The "cpuset.cpus.effective" cannot be empty unless there is
+	1) The parent cgroup is a valid partition root.
+	2) The "cpuset.cpus.exclusive.effective" file cannot be empty,
+	   though it may contain offline CPUs.
+	3) The "cpuset.cpus.effective" cannot be empty unless there is
 	   no task associated with this partition.
 
-	External events like hotplug or changes to "cpuset.cpus" can
-	cause a valid partition root to become invalid and vice versa.
-	Note that a task cannot be moved to a cgroup with empty
-	"cpuset.cpus.effective".
+	For a remote partition root to be valid, all the above conditions
+	except the first one must be met.
 
-	For a valid partition root with the sibling cpu exclusivity
-	rule enabled, changes made to "cpuset.cpus" that violate the
-	exclusivity rule will invalidate the partition as well as its
-	sibling partitions with conflicting cpuset.cpus values. So
-	care must be taking in changing "cpuset.cpus".
+	External events like hotplug or changes to "cpuset.cpus" or
+	"cpuset.cpus.exclusive" can cause a valid partition root to
+	become invalid and vice versa.	Note that a task cannot be
+	moved to a cgroup with empty "cpuset.cpus.effective".
 
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
-	set of "cpuset.cpus".
+	value in "cpuset.cpus" or "cpuset.cpus.exclusive".
 
 	Poll and inotify events are triggered whenever the state of
 	"cpuset.cpus.partition" changes.  That includes changes caused
@@ -2321,6 +2375,11 @@ Cpuset Interface Files
 	to "cpuset.cpus.partition" without the need to do continuous
 	polling.
 
+	A user can pre-configure certain CPUs to an isolated state
+	with load balancing disabled at boot time with the "isolcpus"
+	kernel boot command line option.  If those CPUs are to be put
+	into a partition, they have to be used in an isolated partition.
+
 
 Device controller
 -----------------
-- 
2.31.1

