Return-Path: <cgroups+bounces-4081-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 635589472FD
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2024 03:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 945941C20A82
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2024 01:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8754613CABC;
	Mon,  5 Aug 2024 01:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="du47w7OD"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C11814A85
	for <cgroups@vger.kernel.org>; Mon,  5 Aug 2024 01:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722821455; cv=none; b=WlnbTvzPpXxSCZEnFpBXPMBxxKVN1HDWKcWcPm+4p2Knpp95odi73zVUL61pAY64NzsmPVyXDhPpiWRvLXg3wX1OaBcqYIbTZVGnyJlS8ZBrTI0ZEqTHmbq6XBTpIlsdkmekCxCYXGByYKwk6ol4gj5UxedI4THj4MCEgcV8Ins=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722821455; c=relaxed/simple;
	bh=wxhvQT5XZ92YauWA+/mGEHI6P9VMPAgoRgbBr5i9Xew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p/+tvRkjTVqvdZBkjaKHg+cJzZMJhBBG1ztfx9RSplHtwMicepmWyiU3qSiqghZEogxfTNrYm4khtesDoxKa1Isa6hi9OrUeaLu5Pu3aibfhDDhAMmTAQcPQigiEUn0yi4ChZKJLG30CBjdrSycsUKEopktVWZOe6sb4G6nQSHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=du47w7OD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722821452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l53X9Vck7Kb0usa8G9ZM6IH5QUxWVRImLsQUbwXOoOw=;
	b=du47w7ODvnH6ClgLQ5qguE0wAySQP3U/pttNeHJjXZ5IlUzA1H1LhqeoLmfUTKrVmRXPkC
	I/Ty/H9p3TV3I25KMQp4/+e7yCcY0qaWZvFIrptVglo4h3Ypv8WT3amxV9GrXiQyamh7RI
	ot0lhPi+XQyJbE8M5GftlZ8MQXEJoqY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-IMEPRfEiMPSfAfMbasos3w-1; Sun,
 04 Aug 2024 21:30:49 -0400
X-MC-Unique: IMEPRfEiMPSfAfMbasos3w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB70D1955D44;
	Mon,  5 Aug 2024 01:30:47 +0000 (UTC)
Received: from llong.com (unknown [10.2.16.2])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CB6131955F40;
	Mon,  5 Aug 2024 01:30:44 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Chen Ridong <chenridong@huawei.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup 0/5] cgroup/cpuset: Miscellaneous cpuset updates for 6.12
Date: Sun,  4 Aug 2024 21:30:14 -0400
Message-ID: <20240805013019.724300-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The first 2 patches in this series fix cpuset bugs found by Chen Ridong.
Patch 3 streamlines the sched domain rebuild process for hotplug
operation and eliminates the use of intermediate cpuset states for
sched domain generation. Patch 4 modifies generate_sched_domains()
to check the correctness of partition roots with non-overlapping CPUs.
Patch 5 adds new test cases to cover the bugs fixed in patches 1 and 2.

Chen Ridong (1):
  cgroup/cpuset: fix panic caused by partcmd_update

Waiman Long (4):
  cgroup/cpuset: Clear effective_xcpus on cpus_allowed clearing only if
    cpus.exclusive not set
  cgroup/cpuset: Eliminate unncessary sched domains rebuilds in hotplug
  cgroup/cpuset: Check for partition roots with overlapping CPUs
  selftest/cgroup: Add new test cases to test_cpuset_prs.sh

 kernel/cgroup/cpuset.c                        | 70 ++++++++++---------
 .../selftests/cgroup/test_cpuset_prs.sh       | 12 +++-
 2 files changed, 49 insertions(+), 33 deletions(-)

-- 
2.43.5


