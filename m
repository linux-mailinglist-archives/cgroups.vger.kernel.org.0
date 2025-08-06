Return-Path: <cgroups+bounces-9000-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F29B1CA9F
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 19:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF68618C26BE
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 17:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F7629C32B;
	Wed,  6 Aug 2025 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VedKB9Lu"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770E41A76B1
	for <cgroups@vger.kernel.org>; Wed,  6 Aug 2025 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501094; cv=none; b=VTE94JKkzkzLhXrqCU26lay2mnsibMdtNWlWqAy74H7FWn4hUb4m5PcO9OITzGG6Z03pKn+PXbJMbvyqxvjEOGs2Nf6KgDhruZFFO3NmL9JbF+wTwbyYOz7mVNUCItnz1tx50CrUvhddj+TNJFOB1HjMIbIPk1h95GVEablOoxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501094; c=relaxed/simple;
	bh=bfXmT8jKgLZKau4prNlHdRW3Gbqda/dJh/Dspikv5KU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U7+Gb5Vluhc2DLNQRESElAVrvkpHwEQi2wOr4GA/1ru6FmEYYSk+hbHZj68MJbUfRxdrKEtvxEOLnyOj0EZi9b2gnMI45VvbesGlfYK9CB+u7kyi/y9j45PMscusEUB2+l6EL3MLqsp1vX3wJbLUPtZO3vTrw3ylilMPwGrm+LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VedKB9Lu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754501091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=39EaVFDHzu/W+hGedi5xKnPwgEvi8H+M+2cZ6HVTU/4=;
	b=VedKB9Luvt41AfodA+FSPcZF244c/SJ7ihqtCflqc489sRCZWKWDhEUgEH2Ft9k7NVBf/7
	+8YBmyjugr/YVjN7M9kCZqYGqMmiAhMsvgi24V+EIKSUOV/IXMgg0eNjAkToihQGE5MzYs
	x0pF7Ov2BP5igyUP4mHv0KRkzECNXxw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-fIE6AbTvPuCzc6i0J_v3lQ-1; Wed,
 06 Aug 2025 13:24:48 -0400
X-MC-Unique: fIE6AbTvPuCzc6i0J_v3lQ-1
X-Mimecast-MFC-AGG-ID: fIE6AbTvPuCzc6i0J_v3lQ_1754501086
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09F2B1800357;
	Wed,  6 Aug 2025 17:24:46 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.89.125])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 86B633000198;
	Wed,  6 Aug 2025 17:24:43 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 0/3] cgroup/cpuset: Miscellaneous fixes and cleanup
Date: Wed,  6 Aug 2025 13:24:27 -0400
Message-ID: <20250806172430.1155133-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This patch series includes 2 bug fixes patches and 1 cleanup patch. 

Waiman Long (3):
  cgroup/cpuset: Use static_branch_enable_cpuslocked() on
    cpusets_insane_config_key
  cgroup/cpuset.c: Fix a partition error with CPU hotplug
  cgroup/cpuset: Remove the unnecessary css_get/put() in
    cpuset_partition_write()

 kernel/cgroup/cpuset.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

-- 
2.50.0


