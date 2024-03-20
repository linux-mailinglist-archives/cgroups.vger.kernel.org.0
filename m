Return-Path: <cgroups+bounces-2074-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3C2881340
	for <lists+cgroups@lfdr.de>; Wed, 20 Mar 2024 15:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70A81F2276F
	for <lists+cgroups@lfdr.de>; Wed, 20 Mar 2024 14:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31AD4436F;
	Wed, 20 Mar 2024 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T56qo7hs"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13843FE48
	for <cgroups@vger.kernel.org>; Wed, 20 Mar 2024 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710944612; cv=none; b=mbYuk95NON919mWNZ3n6imArkAy1vmLwfjuBl4w74nLYSfQEgaLxxhqQ7kquO0sVoI86X1s1xNfTvgQeYq4czbtp6QAVbLVZb9E8g5gRD0k/nYOrhvdoGKjtJ1R8K1kIAJVI3aRnQAbb1JLRW9CPAD+tb5G0YGJ8qt/FfjAY0YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710944612; c=relaxed/simple;
	bh=fg8ARSlJ0lNbHtRXX06SbQBiDi1kldIxH5u8ezmpLfc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cqvDlp+JaKbbsTMl9hUQBzdicdqAdhJdWqSKM0csgj9Ar6/Vug21y0qYyilzp98hCuJIJfwNE3ccAkAfkU133t+Rqmfg1j2hq2uO+mTOZ3evrclcA+XeCg7xzHSWI3738aqKPXJwR0QBevrwHQ8t1XspnJkmIjGcEaaVXEJGz9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T56qo7hs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710944610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TgS8M5/jjzZGHXR40Y7YfxozTZJu95vPkXaKMt+h0Yo=;
	b=T56qo7hsBvh9rmjtb7bobcpfHdmqQHvUj73ejzyttzEEh/sCFB0uN3aK/NUd52qSqSCAQK
	8fP5jAyZm1U5Mm2WSJSB9yS+raSuAps5bRStFmsMe+RYvgMEI7QP+mWJQHbq/zulpyJSTt
	IRv+wOpXwmRFMdw8E8+RGfWAQ5JBtVc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-waoB-yvQOqCuDV_B5L1APQ-1; Wed,
 20 Mar 2024 10:23:26 -0400
X-MC-Unique: waoB-yvQOqCuDV_B5L1APQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AC37380213A;
	Wed, 20 Mar 2024 14:23:26 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.243])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5BED8200B672;
	Wed, 20 Mar 2024 14:23:25 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Brent Rowsell <browsell@redhat.com>,
	Mrunal Patel <mpatel@redhat.com>,
	Peter Hunt <pehunt@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] cgroup, docs: Clarify limitation of RT processes with cgroup v2 cpu controller
Date: Wed, 20 Mar 2024 10:23:02 -0400
Message-Id: <20240320142302.1790171-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

The limitation that all RT processes have to be in the root cgroup
before enabling cpu controller only applies if the CONFIG_RT_GROUP_SCHED
option is enabled in the running kernel. If a kernel does not have
CONFIG_RT_GROUP_SCHED enabled, RT processes can exist in a non-root
cgroup even when cpu controller is enabled. CPU sharing of RT processes
will not be under cgroup control, but other resources like memory can be.

Clarify this limitation to avoid confusion to users that are using
cgroup v2.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 17e6e9565156..23c600f0db32 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1058,12 +1058,15 @@ cpufreq governor about the minimum desired frequency which should always be
 provided by a CPU, as well as the maximum desired frequency, which should not
 be exceeded by a CPU.
 
-WARNING: cgroup2 doesn't yet support control of realtime processes and
-the cpu controller can only be enabled when all RT processes are in
-the root cgroup.  Be aware that system management software may already
-have placed RT processes into nonroot cgroups during the system boot
-process, and these processes may need to be moved to the root cgroup
-before the cpu controller can be enabled.
+WARNING: cgroup2 doesn't yet support control of realtime processes. For
+a kernel built with the CONFIG_RT_GROUP_SCHED option enabled for group
+scheduling of realtime processes, the cpu controller can only be enabled
+when all RT processes are in the root cgroup.  This limitation does
+not apply if CONFIG_RT_GROUP_SCHED is disabled.  Be aware that system
+management software may already have placed RT processes into nonroot
+cgroups during the system boot process, and these processes may need
+to be moved to the root cgroup before the cpu controller can be enabled
+with a CONFIG_RT_GROUP_SCHED enabled kernel.
 
 
 CPU Interface Files
-- 
2.39.3


