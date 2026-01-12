Return-Path: <cgroups+bounces-13051-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A66D1088D
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 05:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9161305F339
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 04:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBCF18DB37;
	Mon, 12 Jan 2026 04:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5xKH1eN"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEEE30C603
	for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 04:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768190993; cv=none; b=KPiC6JCsNCEW8U39abu/xfgTtbEfHHmYmlw4lKkTi7VD8FuhHI0TfC0GnQO+YgCeQYznCmzc0jKXgsj48pM4F8fc2+/9zaEzgIvpxg7zWHMUDn4wkeYW4NwMoG/DW+Xhk2KEDu8kFZjjndbCBQTF+YYS/hFE++s/WjUX5DzdCeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768190993; c=relaxed/simple;
	bh=/Hr5td0q2fKUO8L0UFsfzO/yV0xkttzaHGLMqqbjcaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Py5bZOS39R5uCvo++LjdJWW5yysU/RhvP2Z2TQ0a+VPCk+vEG5iIv+mM7/y+vRN2na2I8I+m/Jr84AHgHJqHM28hMb+hkqkCCxioVxY0nYyQ2R7oZwkPN7+Q1jHpTar6owmnaMQHz5OizSL1f4R/EJeDxkwRP0CzrAeaOW3YCS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q5xKH1eN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768190987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B2dX1nduvd1Y2+YZKFwl6uVgXF8yg4bmyS1EUMGzFdk=;
	b=Q5xKH1eNKCl0XoHGJQr7Jrsrx/+BnJy6zCWfKRbWGhcFb6Ey0nDi7WjLqoF8lq2oXrINzK
	Lh9vNFzHz9gP1l2dsOEFmOdeLFmSWNIo9yUoOPaLCi1jr4amGf5KRa9It4Kp3TQcKf6azu
	zpPaOkwQ4vY8FS9LyMoueqA9MvPVaWI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-LwE81DWaNQenJOz7_L9xJg-1; Sun,
 11 Jan 2026 23:09:44 -0500
X-MC-Unique: LwE81DWaNQenJOz7_L9xJg-1
X-Mimecast-MFC-AGG-ID: LwE81DWaNQenJOz7_L9xJg_1768190982
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A63919560B2;
	Mon, 12 Jan 2026 04:09:42 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.71])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4BD0718007D2;
	Mon, 12 Jan 2026 04:09:39 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Sun Shaojie <sunshaojie@kylinos.cn>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huawei.com>
Subject: [PATCH cgroup/for-6.20 v4 1/5] cgroup/cpuset: Streamline rm_siblings_excl_cpus()
Date: Sun, 11 Jan 2026 23:08:52 -0500
Message-ID: <20260112040856.460904-2-longman@redhat.com>
In-Reply-To: <20260112040856.460904-1-longman@redhat.com>
References: <20260112040856.460904-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

If exclusive_cpus is set, effective_xcpus must be a subset of
exclusive_cpus. Currently, rm_siblings_excl_cpus() checks both
exclusive_cpus and effective_xcpus consecutively. It is simpler
to check only exclusive_cpus if non-empty or just effective_xcpus
otherwise.

No functional change is expected.

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Chen Ridong<chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 221da921b4f9..da2b3b51630e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1355,23 +1355,29 @@ static int rm_siblings_excl_cpus(struct cpuset *parent, struct cpuset *cs,
 	int retval = 0;
 
 	if (cpumask_empty(excpus))
-		return retval;
+		return 0;
 
 	/*
-	 * Exclude exclusive CPUs from siblings
+	 * Remove exclusive CPUs from siblings
 	 */
 	rcu_read_lock();
 	cpuset_for_each_child(sibling, css, parent) {
+		struct cpumask *sibling_xcpus;
+
 		if (sibling == cs)
 			continue;
 
-		if (cpumask_intersects(excpus, sibling->exclusive_cpus)) {
-			cpumask_andnot(excpus, excpus, sibling->exclusive_cpus);
-			retval++;
-			continue;
-		}
-		if (cpumask_intersects(excpus, sibling->effective_xcpus)) {
-			cpumask_andnot(excpus, excpus, sibling->effective_xcpus);
+		/*
+		 * If exclusive_cpus is defined, effective_xcpus will always
+		 * be a subset. Otherwise, effective_xcpus will only be set
+		 * in a valid partition root.
+		 */
+		sibling_xcpus = cpumask_empty(sibling->exclusive_cpus)
+			      ? sibling->effective_xcpus
+			      : sibling->exclusive_cpus;
+
+		if (cpumask_intersects(excpus, sibling_xcpus)) {
+			cpumask_andnot(excpus, excpus, sibling_xcpus);
 			retval++;
 		}
 	}
-- 
2.52.0


