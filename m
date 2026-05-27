Return-Path: <cgroups+bounces-16351-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HHIAy0TF2pf3QcAu9opvQ
	(envelope-from <cgroups+bounces-16351-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 17:52:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3245E734C
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 17:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29F8430BA8F8
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 15:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FF03D5246;
	Wed, 27 May 2026 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6Mg9gRo"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCF329405
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896331; cv=none; b=TvvisXcQG+TVMwG6fUFVn+kL1nWg2rDEG1SC/9s6XL5A8G4pWKc7oGA29ef1GpgUd+kEJeWYzafTOmCnzJrHn4V5DIRFPb6I+qQKaFXB3tO7K8tLroCnUEvs3NcDjZfjWbIg/Kuxb0cJ9aaLvNjBOH3JeE6dU8hW4c7HEHbVxms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896331; c=relaxed/simple;
	bh=t47uX9LfNk/VS3b0UOzJFpGA6+4KBzYW1wQwcbN010E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k9DEKbKnNj89t2rU0HxxML1RFBuiaMbN1QJY7bBnqvWG05GpFTQvsY+cygi5mtiebNuk081N4h/Lkg8pQU0SS/Z0D1b2Uogk+mkhAATkNdBByVywaxl2IsfFOM5YqVIubveu6i1J4edjm97qvViqG7PNI3Me8MYx16qOk5VqlRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b6Mg9gRo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779896329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F12bV2mWWMDi602T7nrlB9gUt0uM29kW2bkxAW2G9zE=;
	b=b6Mg9gRoTId+F6dB6S+lnMxr9fBTH7tgga2t/so/LQRI0qPeGJ5o+kdmYvSyVawns6B5Cw
	RbbNtGtFpHyUQ3xZKSWFjoWRCVk3gJXJ2+Fyp6BakwsT0lq6Roosx+kI+DGQ/oF/0cd4YM
	Z70KuFArTwofEzjhAOA3iRGqac7+auQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-zwbd547OO9aHaS3dHadGVw-1; Wed,
 27 May 2026 11:38:45 -0400
X-MC-Unique: zwbd547OO9aHaS3dHadGVw-1
X-Mimecast-MFC-AGG-ID: zwbd547OO9aHaS3dHadGVw_1779896324
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5BB9819560B7;
	Wed, 27 May 2026 15:38:43 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.81.53])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3DC631800465;
	Wed, 27 May 2026 15:38:40 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huaweicloud.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-next v3 0/5] cgroup/cpuset: Support multiple source/destination cpusets for cpuset_*attach()
Date: Wed, 27 May 2026 11:37:55 -0400
Message-ID: <20260527153800.1557449-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16351-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5A3245E734C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 v3:
  - Rebased to the lastest linux-next tree.
  - Keep cpuset_attach_old_cs as suggested by Chen Ridong and replace
    patch 3 by a new one to make it track task group leader.

Sashiko AI review of another cpuset patch had found that cpuset_attach()
and cpuset_can_attach() can be passed a cgroup_taskset with tasks
migrating from one source cpuset to multiple destination cpusets and
vice versa.  Further testing of the cpuset code indicates that this is
indeed the case when the v2 cpuset controller is enabled or disabled.

Unfortunately, cpuset_attach() and cpuset_can_attach() still assume that
there will be one source and one destinaton cpuset which may result in
inocrrect behavior.

This patch series is created to fix this issue. The first 2 patches are
just preparatory patches to make the remaining patches easier to review.

Patch 3 makes cpuset_attach_old_cs to track group leader for use by
cpuset_migrate_mm().

Patch 4 moves mpol_rebind_mm() and cpuset_migrate_mm() inside
cpuset_attach_task() to make CLONE_INTO_CGROUP flag of clone(2) works
more like moving task from one cpuset to another one, while also make
supporting multiple source and destination cpusets easier.

Patch 5 makes the necessary changes to enable the support of multiple
source and destination cpusets by keeping all the source and destination
cpusets found during task iterations in two singly linked lists for
source and destination cpusets respectively.

Waiman Long (5):
  cgroup/cpuset: Add a cpuset_reserve_dl_bw() helper
  cgroup/cpuset: Expand the scope of cpuset_can_attach_check()
  cgroup/cpuset: Made cpuset_attach_old_cs track task group leaders
  cgroup/cpuset: Move mpol_rebind_mm/cpuset_migrate_mm() calls inside
    cpuset_attach_task()
  cgroup/cpuset: Support multiple source/destination cpusets for
    cpuset_*attach()

 kernel/cgroup/cpuset-internal.h |   6 +
 kernel/cgroup/cpuset.c          | 375 ++++++++++++++++++++++----------
 2 files changed, 263 insertions(+), 118 deletions(-)

-- 
2.54.0


