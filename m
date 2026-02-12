Return-Path: <cgroups+bounces-13899-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PgjB2cEjmlf+gAAu9opvQ
	(envelope-from <cgroups+bounces-13899-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 17:48:39 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DDF12F9A8
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 17:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C44C300E587
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 16:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22562E645;
	Thu, 12 Feb 2026 16:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3Ecwjcf"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2782D3738
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770914892; cv=none; b=AQ4d72azBbSUJ/PQjiNvC/kVUE6qKzV4ZSWFF1lUwbFMqATLj0RHomOH6SNYROpUxLOg4A/dVJcdiWhn3EyDuBalFo9S9QThNzKfK6qy3rnZiZ0q4acqsI2U5gk3xiXRNSlDG+64xNnz0NFo/TkEdHyR25RT8RUGloAGEJ+CiKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770914892; c=relaxed/simple;
	bh=sEIIJSYnZpvauvSASLQ3csoM6BerjWwcrHU8Z7IAfiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tONw+MdWsgPt+/Fs5AYzf97ea76KS1UVzbkDNsnf4rh0XyaGrOia8ZKpGFFKFmMFyIshBxywfGFnXsAFPAPNJFk8J0lezkWIAeb/GJnZY0ocKgM8MNfUfz1Wijx6bDWc0QOlCJ6cYvSuoNFc8ZUoxNRxugaGKJ+eJu4xr7Esupg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c3Ecwjcf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770914890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IV4KOsWbu66LHPnMQVrH+zBgc3B06m6KKDZounUUUzI=;
	b=c3EcwjcfPV/HG1/rkC+ABYCTPoKiULiX0pld8yxfdFsnzHRIKiGcd6dXeLqcwaLYDyevwj
	8Mk9XuXkuNbzpur1w+k1NaFxGTsu4k59Sg7xMK2iOxChrlb/W4e14z2kCILhyItYwGBBRv
	s6kO1q00eeyluWO/ESfVoEmiP7nj18I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-wDebt_02OWuFesm9gfJa-Q-1; Thu,
 12 Feb 2026 11:48:06 -0500
X-MC-Unique: wDebt_02OWuFesm9gfJa-Q-1
X-Mimecast-MFC-AGG-ID: wDebt_02OWuFesm9gfJa-Q_1770914883
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EEB8E1800259;
	Thu, 12 Feb 2026 16:48:02 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.194])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7FFE11800464;
	Thu, 12 Feb 2026 16:47:59 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huaweicloud.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v5 1/6] cgroup/cpuset: Fix incorrect change to effective_xcpus in partition_xcpus_del()
Date: Thu, 12 Feb 2026 11:46:35 -0500
Message-ID: <20260212164640.2408295-2-longman@redhat.com>
In-Reply-To: <20260212164640.2408295-1-longman@redhat.com>
References: <20260212164640.2408295-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13899-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 84DDF12F9A8
X-Rspamd-Action: no action

The effective_xcpus of a cpuset can contain offline CPUs. In
partition_xcpus_del(), the xcpus parameter is incorrectly used as
a temporary cpumask to mask out offline CPUs. As xcpus can be the
effective_xcpus of a cpuset, this can result in unexpected changes
in that cpumask. Fix this problem by not making any changes to the
xcpus parameter.

Fixes: 11e5f407b64a ("cgroup/cpuset: Keep track of CPUs in isolated partitions")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index c43efef7df71..a366ef84f982 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1221,8 +1221,8 @@ static void partition_xcpus_del(int old_prs, struct cpuset *parent,
 		isolated_cpus_update(old_prs, parent->partition_root_state,
 				     xcpus);
 
-	cpumask_and(xcpus, xcpus, cpu_active_mask);
 	cpumask_or(parent->effective_cpus, parent->effective_cpus, xcpus);
+	cpumask_and(parent->effective_cpus, parent->effective_cpus, cpu_active_mask);
 }
 
 /*
-- 
2.52.0


