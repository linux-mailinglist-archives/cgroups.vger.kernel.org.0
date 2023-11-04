Return-Path: <cgroups+bounces-170-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A978E7E0D66
	for <lists+cgroups@lfdr.de>; Sat,  4 Nov 2023 04:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879B11C210F0
	for <lists+cgroups@lfdr.de>; Sat,  4 Nov 2023 03:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70861FDE;
	Sat,  4 Nov 2023 03:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0LZU3/E"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061AD1C14
	for <cgroups@vger.kernel.org>; Sat,  4 Nov 2023 03:13:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DBDD6D
	for <cgroups@vger.kernel.org>; Fri,  3 Nov 2023 20:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699067602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N5kFWH7brXucsVBRzdMRgJtcTW19s76elB4wot7GI30=;
	b=g0LZU3/EhemxLxSrVMylocf9XpnAbIDhO+pO65y3vQMSQyrPUZRI3euJLz4PFeqw6w+Mqs
	dWG60HtogbsldFue0JqAeTpu9SCWYFIz1iARtgKPnjp+btHrnv6196Wix8oI8432fnvxkt
	TlKqIP3vq8/CqRcZGA/cFt3RRA4Vf30=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-FHsGKWLoMzyJ9-2FyZjS9A-1; Fri, 03 Nov 2023 23:13:17 -0400
X-MC-Unique: FHsGKWLoMzyJ9-2FyZjS9A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71975811003;
	Sat,  4 Nov 2023 03:13:17 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8BE49C1290F;
	Sat,  4 Nov 2023 03:13:16 +0000 (UTC)
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
Subject: [PATCH v3 0/3] cgroup/rstat: Reduce cpu_lock hold time in cgroup_rstat_flush_locked()
Date: Fri,  3 Nov 2023 23:13:00 -0400
Message-Id: <20231104031303.592879-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

 v3:
  - Minor comment twisting as suggested by Yosry.
  - Add patches 2 and 3 to further reduce lock hold time

The purpose of this patch series is to reduce of the cpu_lock hold time
in cgroup_rstat_flush_locked() so as to reduce the latency impact when
cgroup_rstat_updated() is called as they may contend with each other
on the cpu_lock.

A parallel kernel build on a 2-socket x86-64 server is used as the
benchmarking tool for measuring the lock hold time. Below were the lock
hold time frequency distribution before and after applying different
number of patches:

  Hold time   Before patch   Patch 1   Patches 1-2  Patches 1-3
  ---------   ------------   -------   -----------  -----------
    0-01 us      804,139   13,738,708   14,594,545   15,484,707
   01-05 us    9,772,767    1,177,194      439,926      207,382
   05-10 us    4,595,028        4,984        5,960        3,174
   10-15 us      303,481        3,562        3,543        3,006
   15-20 us       78,971        1,314        1,397        1,066
   20-25 us       24,583           18           25           15
   25-30 us        6,908           12           12           10
   30-40 us        8,015
   40-50 us        2,192
   50-60 us          316
   60-70 us           43
   70-80 us            7
   80-90 us            2
     >90 us            3

Waiman Long (3):
  cgroup/rstat: Reduce cpu_lock hold time in cgroup_rstat_flush_locked()
  cgroup/rstat: Optimize cgroup_rstat_updated_list()
  cgroup: Avoid false cacheline sharing of read mostly rstat_cpu

 include/linux/cgroup-defs.h |  14 ++++
 kernel/cgroup/rstat.c       | 129 +++++++++++++++++++++---------------
 2 files changed, 89 insertions(+), 54 deletions(-)

-- 
2.39.3


