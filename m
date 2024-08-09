Return-Path: <cgroups+bounces-4179-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D33BA94C8DB
	for <lists+cgroups@lfdr.de>; Fri,  9 Aug 2024 05:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B8B2819B4
	for <lists+cgroups@lfdr.de>; Fri,  9 Aug 2024 03:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6521BC3F;
	Fri,  9 Aug 2024 03:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2Nfzm0a"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD5718B04
	for <cgroups@vger.kernel.org>; Fri,  9 Aug 2024 03:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723173852; cv=none; b=evloLz4Em6MMC9FDHcig/x0jPKuq0tcW7m05z1Kbpc7eyh3VOxRyXaN8zR+YkKs3YxJReOuQ5rHoLIT1BayX9OrDXqCe2Lmn4vGTjrWdXXWr99B3jPNo2qhO5rvX3FQH4ke+cj6e7C9JM+fELJTjTNssBei7wvMzJULTBxfFH/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723173852; c=relaxed/simple;
	bh=zLllgtJ8Y5UizVP7ZmuOLoMyXKOTMmB1fEG+ggYCA6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YTrXX4hRI8PxvjltVphZa52qmQh4Yi3BIVvCSrhzxBIyMJpj5Mrlb8NqGGvLWw4YwWC3NqrQtNOj4gzL7jfgJAIvyE04wLAK73vnvd4iX2nTxmzy9HF4Ey/Tih4cROHkCXWi2LyOOMvpSJKYmpZ2RQ6oyJ4vTPJeEbyHDh3/BTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K2Nfzm0a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723173848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G4nqDhT0g2nygRuu74hpthZDpxJstIniDobBGPyGMQI=;
	b=K2Nfzm0aNmc8jl7iLhVUI4ktAt/B0ybumMTklGYgmpUpNRJ+OHw26iVKOwHDrHR3VkleFr
	16MK5bqB7peRNSBTUvzMCQl2OISWZEuroP+F965nG6GvXWQhO0PpKQtB9icrEb/Lv5xchU
	8zcmajU8Wy8bYX+2NgVmgDJ8PLob0SU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-KT90tR09M-aS_4gmRsglzA-1; Thu,
 08 Aug 2024 23:24:05 -0400
X-MC-Unique: KT90tR09M-aS_4gmRsglzA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 156EB1955F54;
	Fri,  9 Aug 2024 03:24:03 +0000 (UTC)
Received: from llong.com (unknown [10.2.16.232])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 385AA1945109;
	Fri,  9 Aug 2024 03:24:00 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] cgroup: Fix incorrect WARN_ON_ONCE() in css_release_work_fn()
Date: Thu,  8 Aug 2024 23:22:59 -0400
Message-ID: <20240809032259.1233679-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

It turns out that the WARN_ON_ONCE() call in css_release_work_fn
introduced by commit ab0312526867 ("cgroup: Show # of subsystem CSSes
in cgroup.stat") is incorrect. Although css->nr_descendants must be
0 when a css is released and ready to be freed, the corresponding
cgrp->nr_dying_subsys[ss->id] may not be 0 if a subsystem is activated
and deactivated multiple times with one or more of its previous
activation leaving behind dying csses.

Fix the incorrect warning by removing the cgrp->nr_dying_subsys check.

Fixes: ab0312526867 ("cgroup: Show # of subsystem CSSes in cgroup.stat")
Closes: https://lore.kernel.org/cgroups/6f301773-2fce-4602-a391-8af7ef00b2fb@redhat.com/T/#t
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cgroup.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 601600afdd20..244ec600b4d8 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5465,7 +5465,14 @@ static void css_release_work_fn(struct work_struct *work)
 			ss->css_released(css);
 
 		cgrp->nr_dying_subsys[ss->id]--;
-		WARN_ON_ONCE(css->nr_descendants || cgrp->nr_dying_subsys[ss->id]);
+		/*
+		 * When a css is released and ready to be freed, its
+		 * nr_descendants must be zero. However, the corresponding
+		 * cgrp->nr_dying_subsys[ss->id] may not be 0 if a subsystem
+		 * is activated and deactivated multiple times with one or
+		 * more of its previous activation leaving behind dying csses.
+		 */
+		WARN_ON_ONCE(css->nr_descendants);
 		parent_cgrp = cgroup_parent(cgrp);
 		while (parent_cgrp) {
 			parent_cgrp->nr_dying_subsys[ss->id]--;
-- 
2.43.5


