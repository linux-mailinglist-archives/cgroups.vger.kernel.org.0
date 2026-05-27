Return-Path: <cgroups+bounces-16352-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALtHKhoQF2o12wcAu9opvQ
	(envelope-from <cgroups+bounces-16352-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 17:39:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6083A5E700F
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 17:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5070D303EA6C
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 15:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87543D9DB2;
	Wed, 27 May 2026 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9lkNS0K"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B7C37A488
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896331; cv=none; b=R2jOpvfItW9Vit8R80109f0xJTMzAGXiruy3CyexAs+XI3ZtFc3cNFoir3IUUfc/DwxNqyv/RMOvPmBKtdSUBRvCkZ+Ty325ScPn2DZUdyuo23l6DNE2LyNa+kL/QtoePuftWUeBcWmkSq4tU0m5hTKNRV2oQHHF94Ue6oJ3/vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896331; c=relaxed/simple;
	bh=ja8QwMW/mmlNgmqfj0hBpJdp841yTjdEA77sLJvBLk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSkNsUkteW75xzvSwVvNe3FjtGceKnV2Db/8p4ctSV56YqakD+CJ1PIegL+CCnOxTxxDCHG5fxVdFDdemxvJeBTmWWjFpDPMqIB2aeiIAPOxrmn9Wzs+UmDpzj/rvQPBc6jczKa6KQU5NKOd0m2594yA3zd/PDJfAEHthyiNAbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R9lkNS0K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779896329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdylMAS/gkAyE0POz57Y8ng1h9gF+KWnXVKL0TsaNFQ=;
	b=R9lkNS0KZ6r8fwyB9iUXphjiHFN1gsyYfpgO4QykU5Sc+ErydF1ZoaYZxudKIy23PhZHpQ
	xzQNf/SVJRVghUQJAVjSuC8j8nukRNp+s2kx00+/cZNrMa8SHCES96SRc7M9gz/WnaKWcv
	0IG+oLbGvOkVnvCaS4FKHW+GkXisAaA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-Ds-_atucNM2ea22E4Shkkw-1; Wed,
 27 May 2026 11:38:47 -0400
X-MC-Unique: Ds-_atucNM2ea22E4Shkkw-1
X-Mimecast-MFC-AGG-ID: Ds-_atucNM2ea22E4Shkkw_1779896326
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E04CC18002F0;
	Wed, 27 May 2026 15:38:45 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.81.53])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B4D3B1800576;
	Wed, 27 May 2026 15:38:43 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huaweicloud.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-next v3 1/5] cgroup/cpuset: Add a cpuset_reserve_dl_bw() helper
Date: Wed, 27 May 2026 11:37:56 -0400
Message-ID: <20260527153800.1557449-2-longman@redhat.com>
In-Reply-To: <20260527153800.1557449-1-longman@redhat.com>
References: <20260527153800.1557449-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16352-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6083A5E700F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extract the DL bandwidth allocation code in cpuset_attach() to a new
cpuset_reserve_dl_bw() helper to simplify code.

No functional change is expected.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 53 ++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 51327333980a..d720bcc7ef83 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2980,6 +2980,25 @@ static int cpuset_can_attach_check(struct cpuset *cs)
 	return 0;
 }
 
+static int cpuset_reserve_dl_bw(struct cpuset *cs)
+{
+	int cpu, ret;
+
+	if (!cs->sum_migrate_dl_bw)
+		return 0;
+
+	cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
+	if (unlikely(cpu >= nr_cpu_ids))
+		return -EINVAL;
+
+	ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
+	if (ret)
+		return ret;
+
+	cs->dl_bw_cpu = cpu;
+	return 0;
+}
+
 static void reset_migrate_dl_data(struct cpuset *cs)
 {
 	cs->nr_migrate_dl_tasks = 0;
@@ -2994,7 +3013,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	struct cpuset *cs, *oldcs;
 	struct task_struct *task;
 	bool setsched_check;
-	int cpu, ret;
+	int ret;
 
 	/* used later by cpuset_attach() */
 	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
@@ -3050,31 +3069,19 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		}
 	}
 
-	if (!cs->sum_migrate_dl_bw)
-		goto out_success;
-
-	cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
-	if (unlikely(cpu >= nr_cpu_ids)) {
-		ret = -EINVAL;
-		goto out_unlock;
-	}
-
-	ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
-	if (ret)
-		goto out_unlock;
-
-	cs->dl_bw_cpu = cpu;
-
-out_success:
-	/*
-	 * Mark attach is in progress.  This makes validate_change() fail
-	 * changes which zero cpus/mems_allowed.
-	 */
-	cs->attach_in_progress++;
+	ret = cpuset_reserve_dl_bw(cs);
 
 out_unlock:
-	if (ret)
+	if (ret) {
 		reset_migrate_dl_data(cs);
+	} else {
+		/*
+		 * Mark attach is in progress.  This makes validate_change() fail
+		 * changes which zero cpus/mems_allowed.
+		 */
+		cs->attach_in_progress++;
+	}
+
 	mutex_unlock(&cpuset_mutex);
 	return ret;
 }
-- 
2.54.0


