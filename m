Return-Path: <cgroups+bounces-17658-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LBxCDS6lUWo/HAMAu9opvQ
	(envelope-from <cgroups+bounces-17658-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 11 Jul 2026 04:06:38 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 996EC73FFC5
	for <lists+cgroups@lfdr.de>; Sat, 11 Jul 2026 04:06:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="MFY/GmBA";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17658-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17658-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A67EC3029634
	for <lists+cgroups@lfdr.de>; Sat, 11 Jul 2026 02:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CD72E285C;
	Sat, 11 Jul 2026 02:06:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAAA1A8F84
	for <cgroups@vger.kernel.org>; Sat, 11 Jul 2026 02:06:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783735596; cv=none; b=tHRy40Ja8VGMKWOGz6pdgb+gX+pfuVQgTafI6w4HTGAkHYKUSUZtF8mL5wjkW4Tst+7LnTd/gsKjejKxKDK1ZtvOuM1pAXBSwnkHoouLtWsigQDhlwVo1XYid0nS2Q3BP8BwAuPgb2uock3UVbnxrPfO25xDfcH+J0YhRsNdaTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783735596; c=relaxed/simple;
	bh=yHOlwA4JalvLdxQ59nij+rHNp9ihIyINljpHIlSTMR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecYM7EvIcpeHXdrituJemgJFFbuZkbiXp0xhHyjZGyLa58OzOCdABtEjJaHLHXsnkyhA6Etnw0TvGpPURRnkYuMCY7HSsg9KAV+F6tBI8UQnCdwxRxmhih7Qc8YcAZbqjWWFiBbD3Brzwl4oxDBdeF1/32CadIPoc2RIH26db+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MFY/GmBA; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783735593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3R5VYrw0wzwcSS1SANajnjhBgxsZAQa4mPyn/L+iyY=;
	b=MFY/GmBAyjHqxSErwt5KvQH1ZJrXu3VTdtGfRCrk8kPhLdgw4Sve/2P84uV+OalclPo4No
	dNYSl5czuXi0qZCyAPk8GdJ+jK0TJ9B4GEIy+d5xX5KoHe4uinGBaT83NZ2A/Arv4HFhuh
	eg9/6dl89I9NaS88DE75icp6rA2Jtho=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-f1swUgQVO3-chKg2I53rHQ-1; Fri,
 10 Jul 2026 22:06:30 -0400
X-MC-Unique: f1swUgQVO3-chKg2I53rHQ-1
X-Mimecast-MFC-AGG-ID: f1swUgQVO3-chKg2I53rHQ_1783735589
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1D851955F07;
	Sat, 11 Jul 2026 02:06:28 +0000 (UTC)
Received: from llong-thinkpadp1gen5.rmtusnh.csb (unknown [10.22.88.253])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 312FE1955F7B;
	Sat, 11 Jul 2026 02:06:26 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ridong Chen <ridong.chen@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-next 1/3] cgroup/cpuset: Handle the special case of non-moving tasks in cpuset_can_attach()
Date: Fri, 10 Jul 2026 22:05:38 -0400
Message-ID: <20260711020540.176740-2-longman@redhat.com>
In-Reply-To: <20260711020540.176740-1-longman@redhat.com>
References: <20260711020540.176740-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:longman@redhat.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17658-lists,cgroups=lfdr.de];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 996EC73FFC5

With cgroup v2 migration of a multithreaded process having threads
in different cgroups of a threaded subtree, it is possible that
cpuset_can_attach() can be called with tasks that are not migrating with
respect to cpuset if cpuset controller is not enabled in some of the
subtree cgroups. IOW, the old cpuset can be the same as the new one. This
can cause problem when we need to track the set of old cpusets and the
new cpusets in singly linked lists as a cpuset cannot be in both lists.

As reported by Tejun, the following is an example threaded subtree with
partial cpuset delegation that can cause this issue to show up.

  P (+cpuset)
  |- R (cpuset)        <- destination
  |  `- C (no cpuset)  -> effective cpuset == R
  `- W (cpuset)

Group leader in R, thread_a in C, thread_b in W; migrate the whole
process into R (echo $PID > R/cgroup.procs). thread_a moves C->R:
its cgroup changes so compare_css_sets() keeps it in the taskset, but
its cpuset css is unchanged (C inherits R's), so task_cs() == cs ==
R. cpuset is in ss_mask because thread_b (W->R) changed. can_attach()
then tags R as a source (thread_a) and the destination (thread_b):

Handle this special case by skipping tasks that are not migrating in
cpuset_can_attach() and avoid calling cpuset_can_attach_check() in this
case. By doing so, the destination cpuset will not be put into source
cpuset linked list.

As the source cpuset cannot be easily determined in cpuset_attach(),
unnecessary work can be performed if a task is not actually
migrating. However, no harm will be done except wasting some
CPU cycles. If it happens that none of the tasks is migrating,
attach_ctx.cpus_updated and attach_ctx.mems_updated will both be
false. So no task iteration will be done in this case.

Reported-by: Tejun Heo <tj@kernel.org>
Closes: https://lore.kernel.org/lkml/e254af713b5345aec3d086771ecf1e71@kernel.org
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index cf0d005d2b78..d99184ec60b5 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3136,18 +3136,13 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 
 	/* used later by cpuset_attach() */
 	attach_ctx.old_cs = task_cs(cgroup_taskset_first(tset, &css));
-	oldcs = attach_ctx.old_cs;
+	oldcs = NULL;
 	cs = css_cs(css);
 
 	mutex_lock(&cpuset_mutex);
 	attach_ctx.cpus_updated = false;
 	attach_ctx.mems_updated = false;
 
-	/* Check to see if task is allowed in the cpuset */
-	ret = cpuset_can_attach_check(cs, oldcs, &setsched_check);
-	if (ret)
-		goto out_unlock;
-
 	/*
 	 * The attach_ctx.old_cs is used mainly by cpuset_migrate_mm() to get
 	 * the old_mems_allowed value. There are two ways that many-to-one
@@ -3164,17 +3159,27 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	 * of child cpusets must always be a subset of the parent. So no real
 	 * page migration will be necessary no matter which child cpuset is
 	 * selected as attach_ctx.old_cs.
+	 *
+	 * For a v2 threaded subtree where cpuset isn't enabled in some of the
+	 * cgroups, it is possible that oldcs == cs for some of the tasks.
+	 * In this case, we can skip checking on those tasks as there is no
+	 * actual migration wrt cpuset.
 	 */
 	cgroup_taskset_for_each(task, css, tset) {
 		struct cpuset *new_oldcs = task_cs(task);
 
 		if (new_oldcs != oldcs) {
 			oldcs = new_oldcs;
+			if (oldcs == cs)
+				continue;
 			ret = cpuset_can_attach_check(cs, oldcs, &setsched_check);
 			if (ret)
 				goto out_unlock;
 		}
 
+		if (oldcs == cs)
+			continue;
+
 		ret = task_can_attach(task);
 		if (ret)
 			goto out_unlock;
-- 
2.55.0


