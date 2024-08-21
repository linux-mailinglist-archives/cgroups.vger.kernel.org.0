Return-Path: <cgroups+bounces-4403-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 941F3959FAD
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 16:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 078A0B22806
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 14:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34561B1D73;
	Wed, 21 Aug 2024 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHbfDon3"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C8C196D90
	for <cgroups@vger.kernel.org>; Wed, 21 Aug 2024 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250246; cv=none; b=olKdJ090EonRkbOAt1gfId9nKZiC6NI9mQb3mY8zyyDnEBN7wLh88HbHU76FK/LyzUdQpS8pTg6QEcqqzlS+qQGP2Fs+e+bSyK6CSeJv+6vUc6rf318Nc0xIdEQL3RoIMJ2yh6HnzVL2thMr5HPuXww1KPAhWbIDDHGC7BAb5xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250246; c=relaxed/simple;
	bh=kwjAfkQ1SQl2IccDcZCBAKSpIIcKlFhOwFsw96Fk0FY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tVUZq3z5TZuNAPSVIPG01OkjvqGOasIUr7Unkt9167ty4FXbT58xf2kPA9HoHJIaWaNoOiXqU9YAiHo2iQ9on4udEq50/HZfojJ+bXaK8QdH1C8oadp8rO+TnWiB2dqLw4gSquKG+FzS0c7WEcQgSJigbVcNl8ZmtlTuq1KFYj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHbfDon3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724250243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kW1kqXkjmjB16PeBN6etICCuzfHKbAWEkOeBe7oty7M=;
	b=HHbfDon3dgBfDu/HpJbTsix5n+IIM3gunxW1DpCKB8FyEXOXRMSklGuXqhcXbVC76Ddqo0
	oWqncRqwjHsOkUCj/bFmlHduKeRPCeWnhfvZvITO0z1mcO/R/go6NMFrnoZuoC+Sc0n1aj
	z6eynKcFc4dA+xyr2sQD8bYidxBrXTY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-ZAV2ryprPqOaqHQLVVYXrA-1; Wed,
 21 Aug 2024 10:23:58 -0400
X-MC-Unique: ZAV2ryprPqOaqHQLVVYXrA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA79C18EA8AD;
	Wed, 21 Aug 2024 14:23:55 +0000 (UTC)
Received: from llong.com (unknown [10.2.16.124])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2A61D19772CD;
	Wed, 21 Aug 2024 14:23:26 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Zefan Li <lizefan.x@bytedance.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Costa Shulyupin <cshulyup@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/2] isolation: Exclude dynamically isolated CPUs from housekeeping cpumasks
Date: Wed, 21 Aug 2024 10:23:10 -0400
Message-ID: <20240821142312.236970-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

 v2:
  - Add a TODO comment on overriding boot time housekeeping masks setting
    in the future when dynamic CPU isolation is good enough to deprecate
    isolcpus and nohz_full boot command line parameters.
  - Only save one copy of the boot time housekeeping mask as the CPU
    list used in isolcpus and nohz_full must be the same.
  - Include more housekeeping masks to be updated by cpuset.

 [v1] https://lore.kernel.org/lkml/20240229021414.508972-1-longman@redhat.com/

The housekeeping CPU masks, set up by the "isolcpus" and "nohz_full"
boot command line options, are used at boot time to exclude selected
CPUs from running some kernel housekeeping processes to minimize
disturbance to latency sensitive userspace applications. However, some
of housekeeping CPU masks are also checked at run time to avoid using
those isolated CPUs.

The purpose of this patch series is to exclude dynamically isolated
CPUs from some housekeeping masks so that subsystems that check the
housekeeping masks at run time will not see those isolated CPUs. It does
not migrate the housekeeping processes that have been running on those
newly isolated CPUs since bootup to other CPUs. That will hopefully be
done in the near future.

This patch series updates all the housekeeping cpumasks except the
HK_TYPE_TICK and HK_TYPE_MANAGED_IRQ which needs further investigation.

Waiman Long (2):
  sched/isolation: Exclude dynamically isolated CPUs from housekeeping
    masks
  cgroup/cpuset: Exclude isolated CPUs from housekeeping CPU masks

 include/linux/sched/isolation.h |   8 +++
 kernel/cgroup/cpuset.c          |  34 ++++++++--
 kernel/sched/isolation.c        | 112 +++++++++++++++++++++++++++++++-
 3 files changed, 146 insertions(+), 8 deletions(-)

-- 
2.43.5


