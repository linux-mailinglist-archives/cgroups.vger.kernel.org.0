Return-Path: <cgroups+bounces-14092-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGo9AJf/mWliXwMAu9opvQ
	(envelope-from <cgroups+bounces-14092-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 19:55:19 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A80E16D91A
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 19:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAF753023062
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 18:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC43630BB91;
	Sat, 21 Feb 2026 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8e2edLq"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896EE3090C4
	for <cgroups@vger.kernel.org>; Sat, 21 Feb 2026 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771700098; cv=none; b=HysVzlnVgR/Q8vLlr29XpmMPPsXJAsSppYvueVuazO05nTppg3nLmpuwZp20mZ4Ol4mTJOxZOdjbp97rfGk7CmKgZ3dG4YWm40dRIiTJ1l5h4DBs6Cfar0OI7Uv2KVDe0plSHydM+96NbVPRg32LrTsGgsUfw+bZoQpAuI3+CXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771700098; c=relaxed/simple;
	bh=hnwKm3cHN0wYSPdYO1TG3wE2ivHbM3YkTcrGxlm0l88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBPLwBk5J8xCXECtLgsqs3wGF4MVmE5mpZneGWVIqmOLsKt71RmdLzmBvwDSsXdDYX5uCijhZ978GkoqiAEZEafzs1R0hanyM41mgSccJNjou3Don9PakpQpwP6O7sh+lgyQRc4++RQd6wTnw24b6aKI5MTFvVQuAWPsuTeC5sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8e2edLq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771700096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mq2cciCs0tqvPp9QLtFzwUl4nr4xQ0n8TapNOd99Qkg=;
	b=U8e2edLqyfSP5Q5DyxQEh0sDD6zYxduBp2yuPH0KffMT0Dd0j04B2IcLZ90kBM2Ty9GiXg
	Y9gOgmFkv1pPxXcVGdkyCbBotyXulUxQeUHQGPmXDJiWsUwi5KyfMrzv6p+NrUlQ40ld1i
	gQpyIiR9rLrhDuBh++6TVvPonr5LoWQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-GsCa34eJNzGUaNe9FQ14Kw-1; Sat,
 21 Feb 2026 13:54:53 -0500
X-MC-Unique: GsCa34eJNzGUaNe9FQ14Kw-1
X-Mimecast-MFC-AGG-ID: GsCa34eJNzGUaNe9FQ14Kw_1771700091
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CE4E1956095;
	Sat, 21 Feb 2026 18:54:51 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 09CA81955F22;
	Sat, 21 Feb 2026 18:54:45 +0000 (UTC)
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
Subject: [PATCH v6 2/8] cgroup/cpuset: Fix incorrect use of cpuset_update_tasks_cpumask() in update_cpumasks_hier()
Date: Sat, 21 Feb 2026 13:54:12 -0500
Message-ID: <20260221185418.29319-3-longman@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-14092-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A80E16D91A
X-Rspamd-Action: no action

Commit e2ffe502ba45 ("cgroup/cpuset: Add cpuset.cpus.exclusive for v2")
incorrectly changed the 2nd parameter of cpuset_update_tasks_cpumask()
from tmp->new_cpus to cp->effective_cpus. This second parameter is just
a temporary cpumask for internal use. The cpuset_update_tasks_cpumask()
function was originally called update_tasks_cpumask() before commit
381b53c3b549 ("cgroup/cpuset: rename functions shared between v1
and v2").

This mistake can incorrectly change the effective_cpus of the
cpuset when it is the top_cpuset or in arm64 architecture where
task_cpu_possible_mask() may differ from cpu_possible_mask.  So far
top_cpuset hasn't been passed to update_cpumasks_hier() yet, but arm64
arch can still be impacted. Fix it by reverting the incorrect change.

Fixes: e2ffe502ba45 ("cgroup/cpuset: Add cpuset.cpus.exclusive for v2")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 4d10e320b144..58660e06d322 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2156,7 +2156,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		WARN_ON(!is_in_v2_mode() &&
 			!cpumask_equal(cp->cpus_allowed, cp->effective_cpus));
 
-		cpuset_update_tasks_cpumask(cp, cp->effective_cpus);
+		cpuset_update_tasks_cpumask(cp, tmp->new_cpus);
 
 		/*
 		 * On default hierarchy, inherit the CS_SCHED_LOAD_BALANCE
-- 
2.53.0


