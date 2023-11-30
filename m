Return-Path: <cgroups+bounces-741-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B757FFCF1
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 21:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5482B281B28
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 20:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C6F55C28;
	Thu, 30 Nov 2023 20:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cTsoVc7Z"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A7010E6
	for <cgroups@vger.kernel.org>; Thu, 30 Nov 2023 12:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701377027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8uUhkmFY3baFHZKA0GPbNGpyZmiXUmHvRAktUmbwJUI=;
	b=cTsoVc7ZFBeZAtJFmGzSn39DThgbz42sJRQQQmftw8pf2wjrbKz5ygpu32wjwHDilpeOAX
	aI4Qc9hwx15isE/ily1ivlHFGk7u7gyYhbXj5bzwpk4M5NMndFHkDyYijcQB47O5ZxkpJu
	FZpvFt+8WyriUzxwf8Z9yuvHyPUEd5c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-hNwsiTMiMOu0QY_LOCCSfg-1; Thu,
 30 Nov 2023 15:43:44 -0500
X-MC-Unique: hNwsiTMiMOu0QY_LOCCSfg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 843A01C06ED1;
	Thu, 30 Nov 2023 20:43:43 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.192])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E72D340C6EB9;
	Thu, 30 Nov 2023 20:43:42 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joe Mario <jmario@redhat.com>,
	Sebastian Jug <sejug@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup v5 0/2] cgroup/rstat: Further reduce cpu_lock hold time in cgroup_rstat_flush_locked
Date: Thu, 30 Nov 2023 15:43:25 -0500
Message-Id: <20231130204327.494249-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

 v5:
  - Drop patch "cgroup/rstat: Reduce cpu_lock hold time in
    cgroup_rstat_flush_locked()" as it has been merged into the for-6.8
    branch.
  - Rework the recursive cgroup_rstat_push_children() into an iterative
    function to prevent possibility of stack overflow.

 v4:
  - Update patch 2 to fix a minor bug and update some of the comments.

 v3:
  - Minor comment twisting as suggested by Yosry.
  - Add patches 2 and 3 to further reduce lock hold time

The purpose of this patch series is to further reduce the cpu_lock
hold time of cgroup_rstat_flush_locked() so as to reduce the latency
impact when cgroup_rstat_updated() is called as they may contend with
each other on the cpu_lock.

Waiman Long (2):
  cgroup/rstat: Optimize cgroup_rstat_updated_list()
  cgroup: Avoid false cacheline sharing of read mostly rstat_cpu

 include/linux/cgroup-defs.h |   7 ++
 kernel/cgroup/rstat.c       | 153 +++++++++++++++++++++---------------
 2 files changed, 98 insertions(+), 62 deletions(-)

-- 
2.39.3


