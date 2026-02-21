Return-Path: <cgroups+bounces-14094-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPtLNb7/mWliXwMAu9opvQ
	(envelope-from <cgroups+bounces-14094-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 19:55:58 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDAD16D97D
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 19:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEE88305DA05
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 18:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C9B2EBB86;
	Sat, 21 Feb 2026 18:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cTasftjN"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F922DB78E
	for <cgroups@vger.kernel.org>; Sat, 21 Feb 2026 18:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771700109; cv=none; b=hOagZLdFV2vT3dEDXG8RwfQg3LPQyDzOOCOTf/CynbT/NR6SDtBAFzXRQM3UE1lKAeQE1XshFGkBJXWBzq6OQbRxHdXjCAmOq1aXMAevhmZ5EqLuHdkAIy8iH/CTqI628JA22T5oimOsqHMCtGropZ0bHUUpIAK4B90Ascz4yFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771700109; c=relaxed/simple;
	bh=3/mMWO/OLnn9oAQq9BtmSdQudV3VYbGTs9aKl2ZAVQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X29VqMyOZ105klhcQ2IipigO0Bvt2i9Dw7hO9GnD/LfMls+YQBI+9VARFM/tCgSBxbC9mEp0Y0C7eRjV0sB2Vg6JrN3WbqzY2qrbLMgdIgKOMXqlXkNBxNUn1LYMQcoyhz/tLUP0KGbjIWSW9M1WnGQqFGcGJfE/FU0RQB9IqqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cTasftjN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771700107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dnRXsnkA10h3F4dXZbAzjijGxS97Xcwkc9wwb0raH3g=;
	b=cTasftjN9yT8RajH4GI6bYxPPNpVA5EIYxLJJ8NQQLA1waODl50N2PIWUXXkm1hdRtGRCC
	s9wDtp8vHnDnPScRD7/a0YA2CIROv89dsf77wzloYkeMlIhNU1qXJTIvv/InbyW9WUCMny
	qk4Atjirm7LHDb4Bd0Vi1zIatjXzFoE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-oT5MGJmXM_uYAVmrqn1PCQ-1; Sat,
 21 Feb 2026 13:55:03 -0500
X-MC-Unique: oT5MGJmXM_uYAVmrqn1PCQ-1
X-Mimecast-MFC-AGG-ID: oT5MGJmXM_uYAVmrqn1PCQ_1771700101
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D44F195608E;
	Sat, 21 Feb 2026 18:55:01 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BFD241955F22;
	Sat, 21 Feb 2026 18:54:56 +0000 (UTC)
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
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v6 4/8] cgroup/cpuset: Set isolated_cpus_updating only if isolated_cpus is changed
Date: Sat, 21 Feb 2026 13:54:14 -0500
Message-ID: <20260221185418.29319-5-longman@redhat.com>
In-Reply-To: <20260221185418.29319-1-longman@redhat.com>
References: <20260221185418.29319-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14094-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8BDAD16D97D
X-Rspamd-Action: no action

As cpuset is updating HK_TYPE_DOMAIN housekeeping mask when there is
a change in the set of isolated CPUs, making this change is now more
costly than before.  Right now, the isolated_cpus_updating flag can be
set even if there is no real change in isolated_cpus. Put in additional
checks to make sure that isolated_cpus_updating is set only if there
is a real change in isolated_cpus.

Reviewed-by: Chen Ridong <chenridong@huaweicloud.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e8c0b3cfd1f9..05adf6697030 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1179,11 +1179,15 @@ static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus
 	WARN_ON_ONCE(old_prs == new_prs);
 	lockdep_assert_held(&callback_lock);
 	lockdep_assert_held(&cpuset_mutex);
-	if (new_prs == PRS_ISOLATED)
+	if (new_prs == PRS_ISOLATED) {
+		if (cpumask_subset(xcpus, isolated_cpus))
+			return;
 		cpumask_or(isolated_cpus, isolated_cpus, xcpus);
-	else
+	} else {
+		if (!cpumask_intersects(xcpus, isolated_cpus))
+			return;
 		cpumask_andnot(isolated_cpus, isolated_cpus, xcpus);
-
+	}
 	isolated_cpus_updating = true;
 }
 
-- 
2.53.0


