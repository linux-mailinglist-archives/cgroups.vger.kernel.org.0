Return-Path: <cgroups+bounces-11474-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E87C29C94
	for <lists+cgroups@lfdr.de>; Mon, 03 Nov 2025 02:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 686784E977C
	for <lists+cgroups@lfdr.de>; Mon,  3 Nov 2025 01:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631D7277037;
	Mon,  3 Nov 2025 01:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5jdEu7Y"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BCE2765DF
	for <cgroups@vger.kernel.org>; Mon,  3 Nov 2025 01:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762133688; cv=none; b=f1nE09RcToBcCKl7CaXb4mWjbf4oLx8c1p3roJRGTz76V5CkpwRQVhv+1vPuMN83kFBt7U1RYVY6C7uO2HITG7LZM0Y+I3w5eq7LSes8C8qD/lVwu7yt/+DZ3ip2s202Ld0kKyYp0NlZPu2I+XkxBpiYLwDPc3jlV5d1nqLmZfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762133688; c=relaxed/simple;
	bh=ftMbpL6j/uQsNO3O6mNfkO4ZVF4ndgDgaVSJY8PJAk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VgWqZ71T3gVO8A27oxyCl55tbtEDdXn9HJDJmHVtY39AQ3ijYvvl4pf22BuEOV0JLp9PIKVYDaFQ3h3f8LYDA4l6+32rxCtaz0ZpNJubHdTKKQHdqAHbGqY70RHChMhUt4A5OYkorM0S4UReg44nr2YYc1o5WbnkLIXyqfEV/Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e5jdEu7Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762133685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lfUe6keLvgZWmVlJAkKYXrc9NNITdmhd/cHUPUOe4OU=;
	b=e5jdEu7Y4tL8tDhscr3STQ+yM3U4Z7iZXV6o+wpoua14qUg2XLHk8MaSI5fHWLM6lhM1AY
	p8G7tXskYO8ZifMaAbWTi14jvrCpOvHyPxy6VmR7iuEkzNBeRwqfA9Y81z0vJ+3qcdkZQI
	NLv633u8aOTvWtNAoJJW6SGIyC8FPUk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-GrnURyw5OYSREck9qxKEXQ-1; Sun,
 02 Nov 2025 20:34:42 -0500
X-MC-Unique: GrnURyw5OYSREck9qxKEXQ-1
X-Mimecast-MFC-AGG-ID: GrnURyw5OYSREck9qxKEXQ_1762133681
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BDE851956094;
	Mon,  3 Nov 2025 01:34:40 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5A7A21956056;
	Mon,  3 Nov 2025 01:34:38 +0000 (UTC)
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
Subject: [cgroup/for-6.19 PATCH 0/3] cgroup/cpuset: Additional housekeeping check & cleanup
Date: Sun,  2 Nov 2025 20:34:08 -0500
Message-ID: <20251103013411.239610-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The first two patches are based on the two cpuset patches from the
"timers: Exclude isolated cpus from timer migration" patch series [1]
with some minor modifications. They add additional nohz_full housekeeping
mask check to ensure that there is at least one common housekeeping
CPU that is not domain and nohz_full isolated.

The last patch is another cleanup patch to simplify the current
partition code.

[1] https://lore.kernel.org/lkml/20251020112802.102451-1-gmonaco@redhat.com/

Gabriele Monaco (2):
  cgroup/cpuset: Rename update_unbound_workqueue_cpumask() to
    update_isolation_cpumasks()
  cgroup/cpuset: Fail if isolated and nohz_full don't leave any
    housekeeping

Waiman Long (1):
  cgroup/cpuset: Globally track isolated_cpus update

 kernel/cgroup/cpuset.c | 139 +++++++++++++++++++++++++++++------------
 1 file changed, 100 insertions(+), 39 deletions(-)

-- 
2.51.1


