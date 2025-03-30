Return-Path: <cgroups+bounces-7262-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371E7A75CDF
	for <lists+cgroups@lfdr.de>; Sun, 30 Mar 2025 23:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA113A8999
	for <lists+cgroups@lfdr.de>; Sun, 30 Mar 2025 21:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BE61E2853;
	Sun, 30 Mar 2025 21:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O1/pM1xn"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16B11E2602
	for <cgroups@vger.kernel.org>; Sun, 30 Mar 2025 21:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743371641; cv=none; b=YQ6+RpDTpTq8M/Yho0cmS5zm7z78LhF2UP3z5dKJ1xEm3V5v/IcnEchlq/LIWF3X94v/AisubjBG9uBpqeMtEX0j6m7wjTdGkpPXNfcp9OpQXBUCXVR7conF3Zygye7Fwg7PMm4QDKJxlvCiyH8WPxLVQ4fYGlEyg9K8MmtEqL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743371641; c=relaxed/simple;
	bh=stscICFifwoUqJQJWiTNHJ0+TBc9ug/dKZdkyIhs3j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+9LMQvIkrcqwmAq2T0mvlxrSMWcYMQbyyzFjHMD+R/Q2iEyJsBwTZZsVaSyTbTCuqR4bf+l90nKPDOD+x0rEZ75OVdFjit3r1CXg7ln/vV3YxhMte05GNI+RUcP//HvDM7pf7mTWMnHVtFOD+SrTuobemWTZWReygjaf1PAlRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O1/pM1xn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743371638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2JwxzaAEp0Htb1fNzDI1GIEL1hkSI9BANp97CsqZ5jc=;
	b=O1/pM1xnYdrTwR1b+y45CNT0igAauI5BNfNs3UEC+lmKgcXMzF5I7Ze9UE2TG/+Lgh4k9B
	GNVPhfdsT5DZoHR0ipe9EpnX4jKsxto//NTsxTIjrS00tZ/oX++pZhOFjRfkzmfCAJXKJK
	cHHLlMmobRcjplk/RKZYPjHdlVs5oVU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-Rv4_vOknNpGPMAIzxA84Ew-1; Sun,
 30 Mar 2025 17:53:57 -0400
X-MC-Unique: Rv4_vOknNpGPMAIzxA84Ew-1
X-Mimecast-MFC-AGG-ID: Rv4_vOknNpGPMAIzxA84Ew_1743371635
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0FAE2180034D;
	Sun, 30 Mar 2025 21:53:55 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.34])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3DB831801750;
	Sun, 30 Mar 2025 21:53:53 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 07/10] cgroup/cpuset: Remove unneeded goto in sched_partition_write() and rename it
Date: Sun, 30 Mar 2025 17:52:45 -0400
Message-ID: <20250330215248.3620801-8-longman@redhat.com>
In-Reply-To: <20250330215248.3620801-1-longman@redhat.com>
References: <20250330215248.3620801-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The goto statement in sched_partition_write() is not needed. Remove
it and rename sched_partition_write()/sched_partition_show() to
cpuset_partition_write()/cpuset_partition_show().

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index aa529b2dbf56..306b60430091 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3272,7 +3272,7 @@ int cpuset_common_seq_show(struct seq_file *sf, void *v)
 	return ret;
 }
 
-static int sched_partition_show(struct seq_file *seq, void *v)
+static int cpuset_partition_show(struct seq_file *seq, void *v)
 {
 	struct cpuset *cs = css_cs(seq_css(seq));
 	const char *err, *type = NULL;
@@ -3303,7 +3303,7 @@ static int sched_partition_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
+static ssize_t cpuset_partition_write(struct kernfs_open_file *of, char *buf,
 				     size_t nbytes, loff_t off)
 {
 	struct cpuset *cs = css_cs(of_css(of));
@@ -3324,11 +3324,8 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
 	css_get(&cs->css);
 	cpus_read_lock();
 	mutex_lock(&cpuset_mutex);
-	if (!is_cpuset_online(cs))
-		goto out_unlock;
-
-	retval = update_prstate(cs, val);
-out_unlock:
+	if (is_cpuset_online(cs))
+		retval = update_prstate(cs, val);
 	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 	css_put(&cs->css);
@@ -3372,8 +3369,8 @@ static struct cftype dfl_files[] = {
 
 	{
 		.name = "cpus.partition",
-		.seq_show = sched_partition_show,
-		.write = sched_partition_write,
+		.seq_show = cpuset_partition_show,
+		.write = cpuset_partition_write,
 		.private = FILE_PARTITION_ROOT,
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.file_offset = offsetof(struct cpuset, partition_file),
-- 
2.48.1


