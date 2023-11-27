Return-Path: <cgroups+bounces-561-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFF07F9834
	for <lists+cgroups@lfdr.de>; Mon, 27 Nov 2023 05:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24110280CBA
	for <lists+cgroups@lfdr.de>; Mon, 27 Nov 2023 04:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1091C46BA;
	Mon, 27 Nov 2023 04:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxeEENAY"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C8B12D
	for <cgroups@vger.kernel.org>; Sun, 26 Nov 2023 20:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701058837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vrAxGQoF6gd7V1Rx42uLiZqFnKDFhpBL7AxUNIWxi4U=;
	b=TxeEENAY7WFf9lA5oBpIaHv3Eywtnqqln+7e+rbFZDDEjCZ6PMTkceA1e7wkfhO2T9UkXB
	nYG0y1M6oO1Pn5YF9sctgZfV0/LWuoCAKFC8phpfJL6gf1GsxYpl8UKx2fpdkGqciyEMIe
	YUJ6Oz1t8Pl1TJfieD+qwxuBPrJ1iRI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-4RH_A7RRPmmMZhIo6iqSCA-1; Sun,
 26 Nov 2023 23:20:35 -0500
X-MC-Unique: 4RH_A7RRPmmMZhIo6iqSCA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B35DA3806068;
	Mon, 27 Nov 2023 04:20:34 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.84])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BD8485028;
	Mon, 27 Nov 2023 04:20:33 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Frederic Weisbecker <frederic@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mrunal Patel <mpatel@redhat.com>,
	Ryan Phillips <rphillips@redhat.com>,
	Brent Rowsell <browsell@redhat.com>,
	Peter Hunt <pehunt@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup 0/2] cgroup/cpuset: Include isolated cpuset CPUs in cpu_is_isolated()
Date: Sun, 26 Nov 2023 23:19:54 -0500
Message-Id: <20231127041956.266026-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

This patchset enables the inclusion of CPUs in isolated cpuset partitions
in the cpu_is_isolated() check to reduce interference caused by vmstat
or memcg local stock flushing.

To reduce cpu_is_isolated() call overhead, a seqcount is used to
protect read access of the isolated cpumask without taking any lock. As
a result, the callback_lock is changed to a raw_spinlock_t to make it
work in PREEMPT_RT kernel too.

Waiman Long (2):
  cgroup/cpuset: Make callback_lock a raw_spinlock_t
  cgroup/cpuset: Include isolated cpuset CPUs in cpu_is_isolated() check

 include/linux/cpuset.h          |   6 ++
 include/linux/sched/isolation.h |   4 +-
 kernel/cgroup/cpuset.c          | 127 +++++++++++++++++++-------------
 3 files changed, 85 insertions(+), 52 deletions(-)

-- 
2.39.3


