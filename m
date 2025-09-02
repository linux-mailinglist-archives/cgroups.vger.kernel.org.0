Return-Path: <cgroups+bounces-9629-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21633B40CF6
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 20:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB48A561FB4
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 18:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E3634AAE1;
	Tue,  2 Sep 2025 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCmzCUb2"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99CC31DDBD
	for <cgroups@vger.kernel.org>; Tue,  2 Sep 2025 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756836994; cv=none; b=iD5gHXivQOPi/MOPXGYLa5tSNSmjFsXUz/2D3jmNd5qsAIciKVxtO8r0wN+/X2k1XeooSBI/3ptVXZy/CjFjUUXW8YC9hMroHCVife3Z0Shy5kbVyntxNwvcYd5s/DECGREKKA/X03eEBZn+0ZfWq4QycMrtHz4sH6UEElFfuck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756836994; c=relaxed/simple;
	bh=MmGYueJ52ovIwKP3YmfiGStbzDOLjmxKvIylLal6H+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iX4aTPXkktKr9O1O7nXpgGYtpABQ1bl6BnVm0V9Zn08WLu3lgEJuVq180ien6AU+StwNQJL1fQAKQsxYf+q4fGOAj2zYY5mDTYd6qNnFMsdrxabG+WYyy3QmAUk+JvG/R1gAXStHRTEOde8xzKthLfOTyq73WCf+PJyMtvGE3jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hCmzCUb2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756836991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6DvzCRjYypR2+LzWycHI/14wcDkc02hWwwuI+cB+u4s=;
	b=hCmzCUb2IbOl9PBAv2AJxJgXKa5THPJg6sLNgdjZxVA+UCGlFliDciWJ0wx+w4AOjX/8lv
	4zI7kJ4siX3ne+V1Hj4PG5UikF+6zMrqazleYwIs5Nh5AjcNIZVzQDcZNVwaauVbEfnmrc
	O1ydLWzkEZ/2fjaFPJHcTtWIwBVllvE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-ovhCWA38ONC0WQWrqKm2Hw-1; Tue,
 02 Sep 2025 14:16:26 -0400
X-MC-Unique: ovhCWA38ONC0WQWrqKm2Hw-1
X-Mimecast-MFC-AGG-ID: ovhCWA38ONC0WQWrqKm2Hw_1756836985
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D29381956094;
	Tue,  2 Sep 2025 18:16:24 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.117])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 66B471956086;
	Tue,  2 Sep 2025 18:16:22 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ashay Jaiswal <quic_ashayj@quicinc.com>,
	Chen Ridong <chenridong@huawei.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] cgroup/cpuset: Prevent NULL pointer access in free_tmpmasks()
Date: Tue,  2 Sep 2025 14:15:37 -0400
Message-ID: <20250902181537.833102-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Commit 5806b3d05165 ("cpuset: decouple tmpmasks and cpumasks freeing in
cgroup") separates out the freeing of tmpmasks into a new free_tmpmask()
helper but removes the NULL pointer check in the process. Unfortunately a
NULL pointer can be passed to free_tmpmasks() in cpuset_handle_hotplug()
if cpuset v1 is active. This can cause segmentation fault and crash
the kernel.

Fix that by adding the NULL pointer check to free_tmpmasks().

Fixes: 5806b3d05165 ("cpuset: decouple tmpmasks and cpumasks freeing in cgroup")
Reported-by: Ashay Jaiswal <quic_ashayj@quicinc.com>
Closes: https://lore.kernel.org/lkml/20250902-cpuset-free-on-condition-v1-1-f46ffab53eac@quicinc.com/
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a78ccd11ce9b..c0c281a8860d 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -484,6 +484,9 @@ static inline int alloc_tmpmasks(struct tmpmasks *tmp)
  */
 static inline void free_tmpmasks(struct tmpmasks *tmp)
 {
+	if (!tmp)
+		return;
+
 	free_cpumask_var(tmp->new_cpus);
 	free_cpumask_var(tmp->addmask);
 	free_cpumask_var(tmp->delmask);
-- 
2.50.1


