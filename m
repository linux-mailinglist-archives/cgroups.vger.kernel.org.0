Return-Path: <cgroups+bounces-13021-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1517D0CB58
	for <lists+cgroups@lfdr.de>; Sat, 10 Jan 2026 02:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A13D13030FF0
	for <lists+cgroups@lfdr.de>; Sat, 10 Jan 2026 01:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5816522689C;
	Sat, 10 Jan 2026 01:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+vSSPEf"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74849139D0A
	for <cgroups@vger.kernel.org>; Sat, 10 Jan 2026 01:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768008810; cv=none; b=my9D/HqV7UJJX+I9HQPa9gZy6tBexU5PnU6Xs15Eo/j62kBjCZtYuY++v0OETQMOtTForf3+Cxl9lwBl82JWOuppiKBj4NK2iH+WsmbgrACQg8dbEKYmytMSQeV5FOhihysmhtmtaZBWZRNHaJkgxT0VidO1CK+IQZVYZhsHELQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768008810; c=relaxed/simple;
	bh=aRYgeMLmqCOzjdMEsSBXlNSDI2suL/DZvOFjRxLIMZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cZwTfbGb2QbkQHU6HdPceu3AJLcWWHo/lBJgHA1uhIa0qMU1qyFCEwa3ig0JeBichLkI0GhJZyUOjreqZYytTMn+2q/mJDZSoo68GxIucjHMhmBWKawS0ADK0W1lhaek0cloqiG+Rdki3BGBDYPtg5+t7/b+Wu20CGECMNuCUBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X+vSSPEf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768008806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lVRLRCt4qvzFFpIg4QTORQdDltXyCsG/nJm0JxVlJbw=;
	b=X+vSSPEfhFnZAiRu+MwpyeJ8vC0Fpnbkfs9zbUnkBwKSDm+t5DKa57tbvsjKda8xDqw2Yb
	bj2Hx5eY92gdfUeFDD7KENq6Xs0ht8BxYY0mqGLzVBEniwijKce3tSGEI19PGmLXrB206i
	FEJ2yVhZBQukn29UcREt5/gUhAD3ud8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-qamzutzHMBiKNT9Q30y9Qw-1; Fri,
 09 Jan 2026 20:33:24 -0500
X-MC-Unique: qamzutzHMBiKNT9Q30y9Qw-1
X-Mimecast-MFC-AGG-ID: qamzutzHMBiKNT9Q30y9Qw_1768008802
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5161118005AD;
	Sat, 10 Jan 2026 01:33:22 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.90.10])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B4D791800285;
	Sat, 10 Jan 2026 01:33:19 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Sun Shaojie <sunshaojie@kylinos.cn>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH cgroup/for-6.20 v3 0/5] cgroup/cpuset: Don't invalidate sibling partitions on cpuset.cpus conflict
Date: Fri,  9 Jan 2026 20:32:41 -0500
Message-ID: <20260110013246.293889-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

 v3:
  - Patch 2: Change the condition for calling reset_partition_data() to
    (new_prs <= 0).
  - Patch 4: Update commit log and code comment to clarify the change.
  - Add a new patch 5 to move the empty cpus/mems check to
    cpuset1_validate_change().

 v2:
  - Patch 1: additional comment
  - Patch 2: simplify the conditions for triggering call to
    compute_excpus().
  - Patch 3: update description of cpuset.cpus.exclusive in cgroup-v2.rst
    to reflect the new behavior and change the name of the new
    cpus_excl_conflict() parameter to xcpus_changed.
  - Patch 4: update description of cpuset.cpus.partition in cgroup-v2.rst
    to clarify what exclusive CPUs will be used when a partition is
    created.

This patch series is inspired by the cpuset patch sent by Sun Shaojie [1].
The idea is to avoid invalidating sibling partitions when there is a
cpuset.cpus conflict. However this patch series does it in a slightly
different way to make its behavior more consistent with other cpuset
properties.

The first 3 patches are just some cleanup and minor bug fixes on
issues found during the investigation process. The last one is
the major patch that changes the way cpuset.cpus is being handled
during the partition creation process. Instead of invalidating sibling
partitions when there is a conflict, it will strip out the conflicting
exclusive CPUs and assign the remaining non-conflicting exclusive
CPUs to the new partition unless there is no more CPU left which will
fail the partition creation process. It is similar to the idea that
cpuset.cpus.effective may only contain a subset of CPUs specified in
cpuset.cpus. So cpuset.cpus.exclusive.effective may contain only a
subset of cpuset.cpus when a partition is created without setting
cpuset.cpus.exclusive.

Even setting cpuset.cpus.exclusive instead of cpuset.cpus may not
guarantee all the requested CPUs can be granted if parent doesn't have
access to some of those exclusive CPUs. The difference is that conflicts
from siblings is not possible with cpuset.cpus.exclusive as long as it
can be set successfully without failure.

[1] https://lore.kernel.org/lkml/20251117015708.977585-1-sunshaojie@kylinos.cn/

Waiman Long (5):
  cgroup/cpuset: Streamline rm_siblings_excl_cpus()
  cgroup/cpuset: Consistently compute effective_xcpus in
    update_cpumasks_hier()
  cgroup/cpuset: Don't fail cpuset.cpus change in v2
  cgroup/cpuset: Don't invalidate sibling partitions on cpuset.cpus
    conflict
  cgroup/cpuset: Move the v1 empty cpus/mems check to
    cpuset1_validate_change()

 Documentation/admin-guide/cgroup-v2.rst       |  40 +++--
 kernel/cgroup/cpuset-internal.h               |  12 ++
 kernel/cgroup/cpuset-v1.c                     |  33 ++++
 kernel/cgroup/cpuset.c                        | 163 ++++++------------
 .../selftests/cgroup/test_cpuset_prs.sh       |  29 +++-
 5 files changed, 150 insertions(+), 127 deletions(-)

-- 
2.52.0


