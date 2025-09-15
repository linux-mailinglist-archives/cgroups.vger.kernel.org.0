Return-Path: <cgroups+bounces-10068-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C864AB572BE
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 10:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07E6D7A7337
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 08:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773632EFDB8;
	Mon, 15 Sep 2025 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLWJE2h0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1372EDD45
	for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757924401; cv=none; b=k4giJ83OqX6/2W29w/lx1rjrxikkUjYIPDNQTmtg3vvFpjI/8tM1ilNeRisAMphqqrfqFlqMULBfhE0TmoR5B9V7s23B49tLits8ap6r67zWssfCvt9U4pi/7VI0xZDbfYbVmUz4dmR8TWTCOr95I0Nobwvw3ze6FkZyJ3Qa7RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757924401; c=relaxed/simple;
	bh=pYgWUUKXe3JWPoQ3EuJX2eOqpXAmM/Cmsyg27j/8/bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWYo5DfGEug4RMaq9gPpdvS3kaPVAWPCX9G1w/cmiLGUD0eBRTATttcADFiisfOCDN5suXyIYo4muSC5luXlOD7nCbQbtKmClXa/PyKwlBE7fNrxY0jLhk0DijvZDrlr6Y+73tUdv2BOFpQUfDvWe6dvCiYOdxqe/SjUlNYB0y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLWJE2h0; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso3555411b3a.1
        for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 01:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757924398; x=1758529198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUaDtBTQV0zd0yXQ6ReLCoQtRfP5AzMgI7L4iFOt2Rg=;
        b=jLWJE2h0Zf7efveYTCwfh+IWUBqwXwET7Uq6/4oR4MveTnTL4ZwCu9wgOSTwmuuc3Q
         a4f6vVnTGMU5p2egn4saoUPwwR5LN/BL0/0zIZE3bB6NNVLR0qtjy6Mh0v9AneiBYl/Z
         8r2yzqkEfKNrFPx7stdJm8aRCQyknIqDRcKON94PRCbHcZSLwoP7PxOjzBYhwt2aiOsT
         y4PQfjU6f4Evk/0LYVC1Y+6EgaZJxD/JurcQYPV4yPkA5FwX59foN9EaBAIch2J2aynl
         F1mbkvccqbKET2/rg8DZF0I4xBVRfMi2j1rn2se9kEkqubu5eJpr4MAaENb3lXsA9Pz2
         N9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757924398; x=1758529198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUaDtBTQV0zd0yXQ6ReLCoQtRfP5AzMgI7L4iFOt2Rg=;
        b=qs+ItgglyVEeae0Rt+DYttkb1zgT5KAYwZ2gzywWlHwDtGQbKKGe8tKjlfyETpolzw
         z7xTYioFiBwdvs7w+zEBGub6wHmnjazuTjcrMyY1KmhoJrjNhpHxegd0xVsZKH02lzc1
         I2Lz52ztkB7TAnjhtGz1NotkgpsVO+Qe9Wt97pHsOL3ZAJtZkrE8dDgWcvuVXuXCZxip
         r/fl3rz0e5OxrGnyEud+bEYuNzGhW1ipHH/7hrmDc01XhcxhbRRi21KMmn+e7NZByIyI
         AZQoeEot1WzQguQudqlqrcbAQbx2jysB+/sfQyi9ceoiuA2zesDKDcBljAtRer48H3sV
         3bIw==
X-Forwarded-Encrypted: i=1; AJvYcCUba6W4grqiz1I8fGtx6Xdqys/CEBf0tMnYgmzHmOfXbz1QldAeqm9kmv1Uc95QEFf0yJzb1bHN@vger.kernel.org
X-Gm-Message-State: AOJu0YzKiNInY+EGU/+ti+ah6e2avKuueztw0NEKuHlfi0iTdvXG9o5P
	aB6pBGpn7nK5rWcW0Gpt2u890EoaGROPXaBSNSxkYThJP1oIcUPNKm7d
X-Gm-Gg: ASbGncvT4hdT5oQCrckvXBKaUlKYRjB5kNStleXtS6/KDxgkiK3mQDmQBo5J5LEPtN2
	ZDaLZl/SVJ0uIT/rIueGhIKMF9nMxhK9Tb1qNVUBiKTTMaS8UMVa0cZsw534ucUKDRmc5zmsfNo
	CXRAKOYapVwa1MJnIqiLonaj6Pfxfi5d1lFhfrYuOo+lWKcjCZZ7iK6FuEFMh5MfUHYtLQGCRru
	Z/CQ7YiKfLBOIu6b0m0KEo4dbCUf9uvhu2KTBn5DuO8QihjFuqF1LLDeYVlRoYTgXTGUYlmtu90
	cftKBa7lDvGFlNT38ebfYDe4QmvGbEQyrUCjvydT9faNMWRh7/rYbHOpuakagSl9AsOL3g/K5lR
	EpM8SdRvxPc7852qhhQKmqipr2abUrltkWn3p
X-Google-Smtp-Source: AGHT+IEof1KUyWKHZqB6HF48Aikw3xXhLStAL8yIPxdIv4lh/c+onWEV5Kv2voPmTQ0ftIK1LyQHnw==
X-Received: by 2002:a05:6a20:6a10:b0:24e:c235:d7e6 with SMTP id adf61e73a8af0-26029ea90c7mr14499319637.5.1757924397224;
        Mon, 15 Sep 2025 01:19:57 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54b03cf65csm8045746a12.16.2025.09.15.01.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:19:54 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 2307941FA3A1; Mon, 15 Sep 2025 15:19:48 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux cgroups <cgroups@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	"Bagas Sanjaya" <bagasdotme@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrea Righi <arighi@nvidia.com>,
	Johannes Bechberger <me@mostlynerdless.de>,
	Changwoo Min <changwoo@igalia.com>,
	Shashank Balaji <shashank.mahadasyam@sony.com>,
	Ingo Molnar <mingo@kernel.org>,
	Jake Rice <jake@jakerice.dev>,
	Cengiz Can <cengiz@kernel.wtf>,
	"Mauro Carvalho Chehab" <mchehab@kernel.org>
Subject: [PATCH v2 2/4] Documentation: cgroup-v2: Add section numbers
Date: Mon, 15 Sep 2025 15:19:25 +0700
Message-ID: <20250915081942.25077-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915081942.25077-1-bagasdotme@gmail.com>
References: <20250915081942.25077-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=25034; i=bagasdotme@gmail.com; h=from:subject; bh=pYgWUUKXe3JWPoQ3EuJX2eOqpXAmM/Cmsyg27j/8/bs=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBnHT+c92vVLrr4udaXtqldTSs/9+lfq/eCBtX6s6kVZp rvRq0p2dJSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAiO/cxMuzunl7camV2Z7Jk 6IzS+1UKEzY9vWS7br/pRrM/175vuP6E4X/VVvfDXc0Flx4y7uTsPHHZwLBtvWwkx/om20bxRUF 1GWwA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add section numbers, following the numbering scheme in the manual
toctree. Note that sectnum:: directive cannot be used as it also
numbers the docs title.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 308 ++++++++++++------------
 1 file changed, 154 insertions(+), 154 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index c3979661d95cd9..fe8ac5aa0f1ec9 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -92,11 +92,11 @@ v1 is available under :ref:`Documentation/admin-guide/cgroup-v1/index.rst <cgrou
        R.5.1. Memory
 
 
-Introduction
-============
+1. Introduction
+===============
 
-Terminology
------------
+1.1. Terminology
+----------------
 
 "cgroup" stands for "control group" and is never capitalized.  The
 singular form is used to designate the whole feature and also as a
@@ -104,8 +104,8 @@ qualifier as in "cgroup controllers".  When explicitly referring to
 multiple individual control groups, the plural form "cgroups" is used.
 
 
-What is cgroup?
----------------
+1.2. What is cgroup?
+--------------------
 
 cgroup is a mechanism to organize processes hierarchically and
 distribute system resources along the hierarchy in a controlled and
@@ -135,11 +135,11 @@ restrictions set closer to the root in the hierarchy can not be
 overridden from further away.
 
 
-Basic Operations
-================
+2. Basic Operations
+===================
 
-Mounting
---------
+2.1. Mounting
+-------------
 
 Unlike v1, cgroup v2 has only single hierarchy.  The cgroup v2
 hierarchy can be mounted with the following mount command::
@@ -248,11 +248,11 @@ cgroup v2 currently supports the following mount options.
 
 
 
-Organizing Processes and Threads
---------------------------------
+2.2. Organizing Processes and Threads
+-------------------------------------
 
-Processes
-~~~~~~~~~
+2.2.1. Processes
+~~~~~~~~~~~~~~~~
 
 Initially, only the root cgroup exists to which all processes belong.
 A child cgroup can be created by creating a sub-directory::
@@ -303,8 +303,8 @@ is removed subsequently, " (deleted)" is appended to the path::
   0::/test-cgroup/test-cgroup-nested (deleted)
 
 
-Threads
-~~~~~~~
+2.2.2. Threads
+~~~~~~~~~~~~~~
 
 cgroup v2 supports thread granularity for a subset of controllers to
 support use cases requiring hierarchical resource distribution across
@@ -409,8 +409,8 @@ in a threaded cgroup::
 - perf_event
 - pids
 
-[Un]populated Notification
---------------------------
+2.3. [Un]populated Notification
+-------------------------------
 
 Each non-root cgroup has a "cgroup.events" file which contains
 "populated" field indicating whether the cgroup's sub-hierarchy has
@@ -432,11 +432,11 @@ file modified events will be generated on the "cgroup.events" files of
 both cgroups.
 
 
-Controlling Controllers
------------------------
+2.4. Controlling Controllers
+----------------------------
 
-Availability
-~~~~~~~~~~~~
+2.4.1. Availability
+~~~~~~~~~~~~~~~~~~~
 
 A controller is available in a cgroup when it is supported by the kernel (i.e.,
 compiled in, not disabled and not attached to a v1 hierarchy) and listed in the
@@ -444,8 +444,8 @@ compiled in, not disabled and not attached to a v1 hierarchy) and listed in the
 are exposed in the cgroup’s directory, allowing the distribution of the target
 resource to be observed or controlled within that cgroup.
 
-Enabling and Disabling
-~~~~~~~~~~~~~~~~~~~~~~
+2.4.2. Enabling and Disabling
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Each cgroup has a "cgroup.controllers" file which lists all
 controllers available for the cgroup to enable::
@@ -486,8 +486,8 @@ controller interface files - anything which doesn't start with
 "cgroup." are owned by the parent rather than the cgroup itself.
 
 
-Top-down Constraint
-~~~~~~~~~~~~~~~~~~~
+2.4.3. Top-down Constraint
+~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Resources are distributed top-down and a cgroup can further distribute
 a resource only if the resource has been distributed to it from the
@@ -498,8 +498,8 @@ the parent has the controller enabled and a controller can't be
 disabled if one or more children have it enabled.
 
 
-No Internal Process Constraint
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+2.4.4. No Internal Process Constraint
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Non-root cgroups can distribute domain resources to their children
 only when they don't have any processes of their own.  In other words,
@@ -528,11 +528,11 @@ children before enabling controllers in its "cgroup.subtree_control"
 file.
 
 
-Delegation
-----------
+2.5. Delegation
+---------------
 
-Model of Delegation
-~~~~~~~~~~~~~~~~~~~
+2.5.1. Model of Delegation
+~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 A cgroup can be delegated in two ways.  First, to a less privileged
 user by granting write access of the directory and its "cgroup.procs",
@@ -563,8 +563,8 @@ cgroups in or nesting depth of a delegated sub-hierarchy; however,
 this may be limited explicitly in the future.
 
 
-Delegation Containment
-~~~~~~~~~~~~~~~~~~~~~~
+2.5.2. Delegation Containment
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 A delegated sub-hierarchy is contained in the sense that processes
 can't be moved into or out of the sub-hierarchy by the delegatee.
@@ -605,11 +605,11 @@ namespace of the process which is attempting the migration.  If either
 is not reachable, the migration is rejected with -ENOENT.
 
 
-Guidelines
-----------
+2.6. Guidelines
+---------------
 
-Organize Once and Control
-~~~~~~~~~~~~~~~~~~~~~~~~~
+2.6.1. Organize Once and Control
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Migrating a process across cgroups is a relatively expensive operation
 and stateful resources such as memory are not moved together with the
@@ -625,8 +625,8 @@ distribution can be made by changing controller configuration through
 the interface files.
 
 
-Avoid Name Collisions
-~~~~~~~~~~~~~~~~~~~~~
+2.6.2. Avoid Name Collisions
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Interface files for a cgroup and its children cgroups occupy the same
 directory and it is possible to create children cgroups which collide
@@ -644,16 +644,16 @@ cgroup doesn't do anything to prevent name collisions and it's the
 user's responsibility to avoid them.
 
 
-Resource Distribution Models
-============================
+3. Resource Distribution Models
+===============================
 
 cgroup controllers implement several resource distribution schemes
 depending on the resource type and expected use cases.  This section
 describes major schemes in use along with their expected behaviors.
 
 
-Weights
--------
+3.1. Weights
+------------
 
 A parent's resource is distributed by adding up the weights of all
 active children and giving each the fraction matching the ratio of its
@@ -676,8 +676,8 @@ and is an example of this type.
 
 .. _cgroupv2-limits-distributor:
 
-Limits
-------
+3.2. Limits
+-----------
 
 A child can only consume up to the configured amount of the resource.
 Limits can be over-committed - the sum of the limits of children can
@@ -694,8 +694,8 @@ on an IO device and is an example of this type.
 
 .. _cgroupv2-protections-distributor:
 
-Protections
------------
+3.3. Protections
+----------------
 
 A cgroup is protected up to the configured amount of the resource
 as long as the usages of all its ancestors are under their
@@ -715,8 +715,8 @@ process migrations.
 example of this type.
 
 
-Allocations
------------
+3.4. Allocations
+----------------
 
 A cgroup is exclusively allocated a certain amount of a finite
 resource.  Allocations can't be over-committed - the sum of the
@@ -735,11 +735,11 @@ may be rejected.
 type.
 
 
-Interface Files
-===============
+4. Interface Files
+==================
 
-Format
-------
+4.1. Format
+-----------
 
 All interface files should be in one of the following formats whenever
 possible::
@@ -777,8 +777,8 @@ can be written at a time.  For nested keyed files, the sub key pairs
 may be specified in any order and not all pairs have to be specified.
 
 
-Conventions
------------
+4.2. Conventions
+----------------
 
 - Settings for a single feature should be contained in a single file.
 
@@ -849,8 +849,8 @@ Conventions
   generated on the file.
 
 
-Core Interface Files
---------------------
+4.3. Core Interface Files
+-------------------------
 
 All cgroup core files are prefixed with "cgroup."
 
@@ -1083,13 +1083,13 @@ All cgroup core files are prefixed with "cgroup."
 	Shows pressure stall information for IRQ/SOFTIRQ. See
 	:ref:`Documentation/accounting/psi.rst <psi>` for details.
 
-Controllers
-===========
+5. Controllers
+==============
 
 .. _cgroup-v2-cpu:
 
-CPU
----
+5.1. CPU
+--------
 
 The "cpu" controllers regulates distribution of CPU cycles.  This
 controller implements weight and absolute bandwidth limit models for
@@ -1119,8 +1119,8 @@ CONFIG_RT_GROUP_SCHED. Other controllers can be used for the resource control of
 realtime processes irrespective of CONFIG_RT_GROUP_SCHED.
 
 
-CPU Interface Files
-~~~~~~~~~~~~~~~~~~~
+5.1.1. CPU Interface Files
+~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The interaction of a process with the cpu controller depends on its scheduling
 policy and the underlying scheduler. From the point of view of the cpu controller,
@@ -1261,8 +1261,8 @@ will be referred to. All time durations are in microseconds.
 
 	This file affects only processes under the fair-class scheduler.
 
-Memory
-------
+5.2. Memory
+-----------
 
 The "memory" controller regulates distribution of memory.  Memory is
 stateful and implements both limit and protection models.  Due to the
@@ -1284,8 +1284,8 @@ following types of memory usages are tracked.
 The above list may expand in the future for better coverage.
 
 
-Memory Interface Files
-~~~~~~~~~~~~~~~~~~~~~~
+5.2.1. Memory Interface Files
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 All memory amounts are in bytes.  If a value which is not aligned to
 PAGE_SIZE is written, the value may be rounded up to the closest
@@ -1906,8 +1906,8 @@ The following nested keys are defined.
 	:ref:`Documentation/accounting/psi.rst <psi>` for details.
 
 
-Usage Guidelines
-~~~~~~~~~~~~~~~~
+5.2.2. Usage Guidelines
+~~~~~~~~~~~~~~~~~~~~~~~
 
 "memory.high" is the main mechanism to control memory usage.
 Over-committing on high limit (sum of high limits > available memory)
@@ -1930,8 +1930,8 @@ memory; unfortunately, memory pressure monitoring mechanism isn't
 implemented yet.
 
 
-Memory Ownership
-~~~~~~~~~~~~~~~~
+5.2.3. Memory Ownership
+~~~~~~~~~~~~~~~~~~~~~~~
 
 A memory area is charged to the cgroup which instantiated it and stays
 charged to the cgroup until the area is released.  Migrating a process
@@ -1949,8 +1949,8 @@ POSIX_FADV_DONTNEED to relinquish the ownership of memory areas
 belonging to the affected files to ensure correct memory ownership.
 
 
-IO
---
+5.3. IO
+-------
 
 The "io" controller regulates the distribution of IO resources.  This
 controller implements both weight based and absolute bandwidth or IOPS
@@ -1959,8 +1959,8 @@ only if cfq-iosched is in use and neither scheme is available for
 blk-mq devices.
 
 
-IO Interface Files
-~~~~~~~~~~~~~~~~~~
+5.3.1. IO Interface Files
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
   io.stat
 	A read-only nested-keyed file.
@@ -2145,8 +2145,8 @@ IO Interface Files
 	:ref:`Documentation/accounting/psi.rst <psi>` for details.
 
 
-Writeback
-~~~~~~~~~
+5.3.2. Writeback
+~~~~~~~~~~~~~~~~
 
 Page cache is dirtied through buffered writes and shared mmaps and
 written asynchronously to the backing filesystem by the writeback
@@ -2205,8 +2205,8 @@ writeback as follows.
 	vm.dirty[_background]_ratio.
 
 
-IO Latency
-~~~~~~~~~~
+5.3.3. IO Latency
+~~~~~~~~~~~~~~~~~
 
 This is a cgroup v2 controller for IO workload protection.  You provide a group
 with a latency target, and if the average latency exceeds that target the
@@ -2232,8 +2232,8 @@ avg_lat value in io.stat for your workload group to get an idea of the
 latency you see during normal operation.  Use the avg_lat value as a basis for
 your real setting, setting at 10-15% higher than the value in io.stat.
 
-How IO Latency Throttling Works
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+5.3.3.1. How IO Latency Throttling Works
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 io.latency is work conserving; so as long as everybody is meeting their latency
 target the controller doesn't do anything.  Once a group starts missing its
@@ -2258,8 +2258,8 @@ Once the victimized group starts meeting its latency target again it will start
 unthrottling any peer groups that were throttled previously.  If the victimized
 group simply stops doing IO the global counter will unthrottle appropriately.
 
-IO Latency Interface Files
-~~~~~~~~~~~~~~~~~~~~~~~~~~
+5.3.3.2. IO Latency Interface Files
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
   io.latency
 	This takes a similar format as the other controllers.
@@ -2284,8 +2284,8 @@ IO Latency Interface Files
 		duration of time between evaluation events.  Windows only elapse
 		with IO activity.  Idle periods extend the most recent window.
 
-IO Priority
-~~~~~~~~~~~
+5.3.4. IO Priority
+~~~~~~~~~~~~~~~~~~
 
 A single attribute controls the behavior of the I/O priority cgroup policy,
 namely the io.prio.class attribute. The following values are accepted for
@@ -2346,8 +2346,8 @@ The algorithm to set the I/O priority class for a request is as follows:
   into the maximum of the I/O priority class policy number and the numerical
   I/O priority class.
 
-PID
----
+5.4. PID
+--------
 
 The process number controller is used to allow a cgroup to stop any
 new tasks from being fork()'d or clone()'d after a specified limit is
@@ -2362,8 +2362,8 @@ Note that PIDs used in this controller refer to TIDs, process IDs as
 used by the kernel.
 
 
-PID Interface Files
-~~~~~~~~~~~~~~~~~~~
+5.4.1. PID Interface Files
+~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   pids.max
 	A read-write single value file which exists on non-root
@@ -2406,8 +2406,8 @@ through fork() or clone(). These will return -EAGAIN if the creation
 of a new process would cause a cgroup policy to be violated.
 
 
-Cpuset
-------
+5.5. Cpuset
+-----------
 
 The "cpuset" controller provides a mechanism for constraining
 the CPU and memory node placement of tasks to only the resources
@@ -2421,8 +2421,8 @@ The "cpuset" controller is hierarchical.  That means the controller
 cannot use CPUs or memory nodes not allowed in its parent.
 
 
-Cpuset Interface Files
-~~~~~~~~~~~~~~~~~~~~~~
+5.5.1. Cpuset Interface Files
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   cpuset.cpus
 	A read-write multiple values file which exists on non-root
@@ -2679,8 +2679,8 @@ Cpuset Interface Files
 	into a partition, they have to be used in an isolated partition.
 
 
-Device controller
------------------
+5.6. Device controller
+----------------------
 
 Device controller manages access to device files. It includes both
 creation of new device files (using mknod), and access to the
@@ -2703,14 +2703,14 @@ An example of BPF_PROG_TYPE_CGROUP_DEVICE program may be found in
 tools/testing/selftests/bpf/progs/dev_cgroup.c in the kernel source tree.
 
 
-RDMA
-----
+5.7. RDMA
+---------
 
 The "rdma" controller regulates the distribution and accounting of
 RDMA resources.
 
-RDMA Interface Files
-~~~~~~~~~~~~~~~~~~~~
+5.7.1. RDMA Interface Files
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   rdma.max
 	A readwrite nested-keyed file that exists for all the cgroups
@@ -2742,15 +2742,15 @@ RDMA Interface Files
 	  mlx4_0 hca_handle=1 hca_object=20
 	  ocrdma1 hca_handle=1 hca_object=23
 
-DMEM
-----
+5.8. DMEM
+---------
 
 The "dmem" controller regulates the distribution and accounting of
 device memory regions. Because each memory region may have its own page size,
 which does not have to be equal to the system page size, the units are always bytes.
 
-DMEM Interface Files
-~~~~~~~~~~~~~~~~~~~~
+5.8.1. DMEM Interface Files
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   dmem.max, dmem.min, dmem.low
 	A readwrite nested-keyed file that exists for all the cgroups
@@ -2785,14 +2785,14 @@ DMEM Interface Files
 	  drm/0000:03:00.0/vram0 12550144
 	  drm/0000:03:00.0/stolen 8650752
 
-HugeTLB
--------
+5.9. HugeTLB
+------------
 
 The HugeTLB controller allows to limit the HugeTLB usage per control group and
 enforces the controller limit during page fault.
 
-HugeTLB Interface Files
-~~~~~~~~~~~~~~~~~~~~~~~
+5.9.1. HugeTLB Interface Files
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   hugetlb.<hugepagesize>.current
 	Show current usage for "hugepagesize" hugetlb.  It exists for all
@@ -2818,8 +2818,8 @@ HugeTLB Interface Files
         hugetlb pages of <hugepagesize> in this cgroup.  Only active in
         use hugetlb pages are included.  The per-node values are in bytes.
 
-Misc
-----
+5.10. Misc
+----------
 
 The Miscellaneous cgroup provides the resource limiting and tracking
 mechanism for the scalar resources which cannot be abstracted like the other
@@ -2835,8 +2835,8 @@ Once a capacity is set then the resource usage can be updated using charge and
 uncharge APIs. All of the APIs to interact with misc controller are in
 include/linux/misc_cgroup.h.
 
-Misc Interface Files
-~~~~~~~~~~~~~~~~~~~~
+5.10.1. Misc Interface Files
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Miscellaneous controller provides 3 interface files. If two misc resources (res_a and res_b) are registered then:
 
@@ -2900,19 +2900,19 @@ Miscellaneous controller provides 3 interface files. If two misc resources (res_
         cgroup i.e. not hierarchical. The file modified event generated on
         this file reflects only the local events.
 
-Migration and Ownership
-~~~~~~~~~~~~~~~~~~~~~~~
+5.10.2. Migration and Ownership
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 A miscellaneous scalar resource is charged to the cgroup in which it is used
 first, and stays charged to that cgroup until that resource is freed. Migrating
 a process to a different cgroup does not move the charge to the destination
 cgroup where the process has moved.
 
-Others
-------
+5.11. Others
+------------
 
-perf_event
-~~~~~~~~~~
+5.11.1. perf_event
+~~~~~~~~~~~~~~~~~~
 
 perf_event controller, if not mounted on a legacy hierarchy, is
 automatically enabled on the v2 hierarchy so that perf events can
@@ -2920,15 +2920,15 @@ always be filtered by cgroup v2 path.  The controller can still be
 moved to a legacy hierarchy after v2 hierarchy is populated.
 
 
-Non-normative information
--------------------------
+5.N. Non-normative information
+------------------------------
 
 This section contains information that isn't considered to be a part of
 the stable kernel API and so is subject to change.
 
 
-CPU controller root cgroup process behaviour
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+5.N.1. CPU controller root cgroup process behaviour
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 When distributing CPU cycles in the root cgroup each thread in this
 cgroup is treated as if it was hosted in a separate child cgroup of the
@@ -2940,8 +2940,8 @@ kernel/sched/core.c file (values from this array should be scaled
 appropriately so the neutral - nice 0 - value is 100 instead of 1024).
 
 
-IO controller root cgroup process behaviour
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+5.N.2. IO controller root cgroup process behaviour
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Root cgroup processes are hosted in an implicit leaf child node.
 When distributing IO resources this implicit child node is taken into
@@ -2949,11 +2949,11 @@ account as if it was a normal child cgroup of the root cgroup with a
 weight value of 200.
 
 
-Namespace
-=========
+6. Namespace
+============
 
-Basics
-------
+6.1. Basics
+-----------
 
 cgroup namespace provides a mechanism to virtualize the view of the
 "/proc/$PID/cgroup" file and cgroup mounts.  The CLONE_NEWCGROUP clone
@@ -3000,8 +3000,8 @@ namespace is destroyed.  The cgroupns root and the actual cgroups
 remain.
 
 
-The Root and Views
-------------------
+6.2. The Root and Views
+-----------------------
 
 The 'cgroupns root' for a cgroup namespace is the cgroup in which the
 process calling unshare(2) is running.  For example, if a process in
@@ -3050,8 +3050,8 @@ Note that the relative path always starts with '/' to indicate that
 its relative to the cgroup namespace root of the caller.
 
 
-Migration and setns(2)
-----------------------
+6.3. Migration and setns(2)
+---------------------------
 
 Processes inside a cgroup namespace can move into and out of the
 namespace root if they have proper access to external cgroups.  For
@@ -3079,8 +3079,8 @@ namespace.  It is expected that the someone moves the attaching
 process under the target cgroup namespace root.
 
 
-Interaction with Other Namespaces
----------------------------------
+6.4. Interaction with Other Namespaces
+--------------------------------------
 
 Namespace specific cgroup hierarchy can be mounted by a process
 running inside a non-init cgroup namespace::
@@ -3096,16 +3096,16 @@ the view of cgroup hierarchy by namespace-private cgroupfs mount
 provides a properly isolated cgroup view inside the container.
 
 
-Information on Kernel Programming
-=================================
+P. Information on Kernel Programming
+====================================
 
 This section contains kernel programming information in the areas
 where interacting with cgroup is necessary.  cgroup core and
 controllers are not covered.
 
 
-Filesystem Support for Writeback
---------------------------------
+P.1. Filesystem Support for Writeback
+-------------------------------------
 
 A filesystem can support cgroup writeback by updating
 address_space_operations->writepages() to annotate bio's using the
@@ -3139,8 +3139,8 @@ cases by skipping wbc_init_bio() and using bio_associate_blkg()
 directly.
 
 
-Deprecated v1 Core Features
-===========================
+D. Deprecated v1 Core Features
+==============================
 
 - Multiple hierarchies including named ones are not supported.
 
@@ -3154,11 +3154,11 @@ Deprecated v1 Core Features
   "cgroup.stat" files at the root instead.
 
 
-Issues with v1 and Rationales for v2
-====================================
+R. Issues with v1 and Rationales for v2
+=======================================
 
-Multiple Hierarchies
---------------------
+R.1. Multiple Hierarchies
+-------------------------
 
 cgroup v1 allowed an arbitrary number of hierarchies and each
 hierarchy could host any number of controllers.  While this seemed to
@@ -3210,8 +3210,8 @@ how memory is distributed beyond a certain level while still wanting
 to control how CPU cycles are distributed.
 
 
-Thread Granularity
-------------------
+R.2. Thread Granularity
+-----------------------
 
 cgroup v1 allowed threads of a process to belong to different cgroups.
 This didn't make sense for some controllers and those controllers
@@ -3254,8 +3254,8 @@ misbehaving and poorly abstracted interfaces and kernel exposing and
 locked into constructs inadvertently.
 
 
-Competition Between Inner Nodes and Threads
--------------------------------------------
+R.3. Competition Between Inner Nodes and Threads
+------------------------------------------------
 
 cgroup v1 allowed threads to be in any cgroups which created an
 interesting problem where threads belonging to a parent cgroup and its
@@ -3295,8 +3295,8 @@ This clearly is a problem which needs to be addressed from cgroup core
 in a uniform way.
 
 
-Other Interface Issues
-----------------------
+R.4. Other Interface Issues
+---------------------------
 
 cgroup v1 grew without oversight and developed a large number of
 idiosyncrasies and inconsistencies.  One issue on the cgroup core side
@@ -3324,11 +3324,11 @@ cgroup v2 establishes common conventions where appropriate and updates
 controllers so that they expose minimal and consistent interfaces.
 
 
-Controller Issues and Remedies
-------------------------------
+R.5. Controller Issues and Remedies
+-----------------------------------
 
-Memory
-~~~~~~
+R.5.1. Memory
+~~~~~~~~~~~~~
 
 The original lower boundary, the soft limit, is defined as a limit
 that is per default unset.  As a result, the set of cgroups that
-- 
An old man doll... just what I always wanted! - Clara


