Return-Path: <cgroups+bounces-11548-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C07C2EC2D
	for <lists+cgroups@lfdr.de>; Tue, 04 Nov 2025 02:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 470B54F385A
	for <lists+cgroups@lfdr.de>; Tue,  4 Nov 2025 01:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE5A205E26;
	Tue,  4 Nov 2025 01:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/aSpWgh"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA5A204583
	for <cgroups@vger.kernel.org>; Tue,  4 Nov 2025 01:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762219858; cv=none; b=K4/S/+mdGCxWmVGa6VpeEQnNcxDdeYYL082nFRXjALPsBSAbQM4JTjnbzGdi+JDoEYH9wkEJRchFg2UTsefhcaXMpfXW/pZQxouMi8r1GxUI8UiqGNB7L58rcUCMpDicHFzKMX5dxKjJXEBw+gVOU2fiS6h1SE/5E34rpIoOUMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762219858; c=relaxed/simple;
	bh=wyI6JuoFFvcp2coubHDVUmKQi19UlKB889L9cYsosn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UV0zNszwUUljS5i878SkxW/tmSEngwl1Zl6iNakSY5EAWVYyfvR0zb8vXmtIIpfb3IoecTX9SYF+ELrypNyUbHNwgaKD+Fjqc7FEBp90+InoO7JGb2zmRQRHPnHdgF6aff7z6xyNWFPMgUottrguIbxgstKfFgjObJ1Vlcp/bjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b/aSpWgh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762219855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=63+VzXcuonlOm2rn3TRZvFDWJecsweUFsYVd2rNOP/o=;
	b=b/aSpWghYChjOsAm+OZftCTFqhYonKdDgbwJUnUW/aYKikdgInvqi2gDW8HbFOf5WoW3Vz
	qXkMe27hl0nUWIv6uEfRpGI/Ez37uBzGVs0u2UEbE9mq19lSCd1Isg0/Ep3JMbiTMJy1+R
	jJlw+AgRmVQPe5QzXP3pSbDJXvjotfs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-_0KbAWghP3e8X5irLt1UbA-1; Mon,
 03 Nov 2025 20:30:52 -0500
X-MC-Unique: _0KbAWghP3e8X5irLt1UbA-1
X-Mimecast-MFC-AGG-ID: _0KbAWghP3e8X5irLt1UbA_1762219851
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5EDC9195609D;
	Tue,  4 Nov 2025 01:30:50 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.81.236])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E933F30001A1;
	Tue,  4 Nov 2025 01:30:47 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ridong <chenridong@huawei.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [cgroup/for-6.19 PATCH v2 0/3] cgroup/cpuset: Additional housekeeping check & cleanup
Date: Mon,  3 Nov 2025 20:30:34 -0500
Message-ID: <20251104013037.296013-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

 v2: Update patch 2 to correct some of the checking code and add
     prstate_housekeeping_conflict() as suggested by Chen Ridong.

The first two patches are based on the two cpuset patches from the
"timers: Exclude isolated cpus from timer migration" patch series [1]
with some modifications. They add additional nohz_full housekeeping
mask check to ensure that there is at least one common housekeeping
CPU that is not domain and nohz_full isolated.

The last patch is another cleanup patch to simplify the current
partition code.

[1] https://lore.kernel.org/lkml/20251020112802.102451-1-gmonaco@redhat.com/

Gabriele Monaco (1):
  cgroup/cpuset: Rename update_unbound_workqueue_cpumask() to
    update_isolation_cpumasks()

Waiman Long (2):
  cgroup/cpuset: Fail if isolated and nohz_full don't leave any
    housekeeping
  cgroup/cpuset: Globally track isolated_cpus update

 kernel/cgroup/cpuset.c | 148 ++++++++++++++++++++++++++++++-----------
 1 file changed, 109 insertions(+), 39 deletions(-)

-- 
2.51.1


