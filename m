Return-Path: <cgroups+bounces-17102-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tmFEBZFbN2pkMwcAu9opvQ
	(envelope-from <cgroups+bounces-17102-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 21 Jun 2026 05:33:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 604156AA1EB
	for <lists+cgroups@lfdr.de>; Sun, 21 Jun 2026 05:33:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=N24TcLlR;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17102-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17102-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 289B03053EBB
	for <lists+cgroups@lfdr.de>; Sun, 21 Jun 2026 03:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17883002CF;
	Sun, 21 Jun 2026 03:29:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443BF303A04
	for <cgroups@vger.kernel.org>; Sun, 21 Jun 2026 03:29:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782012555; cv=none; b=jsFfGeWwvobtRlksZUVqVgAYpR1XBMESqI4zMtDOTS4TvSSo+6KjVn7zF6Jj6TG/m+1HIO1KfLt6GPP1Ftvz5GyqsU2ldprA/YXBlD1OOvqIlOvHj4MG91L7VLELehX07i1m0UwHa0WggfFq4onDQYiSi6My0BLMI8/B06T5rs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782012555; c=relaxed/simple;
	bh=4H0rdFJNj44LT7qlsud2GcHj72d2l4n2CjblprnPxXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDfcyZHsCjTQDfSjMDpzH4y6ejvduSPW8c2tdvniY6ApMNR6DVdqqGi2wCCdcLgv0D3lVwgdRQnCRW8/7sO/EF3YQ+mqX1XA7INx6s8B8bcyxlINkWQw61xUlGzKmveP2vQ0V1yoaVRLBWhRdZuXb2xMYPX/UHwIgWWOwRWXJ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N24TcLlR; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782012551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jD+SaijJrmav0za5EwJSS6jYXBx9Rzk1ZdT3M+j3FaA=;
	b=N24TcLlRGtvzhbtO9lApoFX1fvfqKCFxm1zjOlWuY2xpasYMke3ECHZwC20gUdiwvb2zzG
	JovHMKEjjKwJ0ANs2whZV0DOl+2I+QWfkFP+pBWFRe0MyOOqMo8tKncyUFaGamMqah3lqG
	iYH34YHIKG2d8pfinmF8R3nTVOCBFqM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-ZwmyZHTrNai5tUvblafOUA-1; Sat,
 20 Jun 2026 23:29:06 -0400
X-MC-Unique: ZwmyZHTrNai5tUvblafOUA-1
X-Mimecast-MFC-AGG-ID: ZwmyZHTrNai5tUvblafOUA_1782012545
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C613D1956044;
	Sun, 21 Jun 2026 03:29:04 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.8])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 30CD1195604D;
	Sun, 21 Jun 2026 03:29:02 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ridong Chen <ridong.chen@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Li Zefan <lizefan@huawei.com>,
	Farhad Alemi <farhad.alemi@berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>,
	Guopeng Zhang <guopeng.zhang@linux.dev>,
	Gregory Price <gourry@gourry.net>,
	David Hildenbrand <david@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v7 3/9] cgroup/cpuset: Prevent race between task attach and cpuset state change
Date: Sat, 20 Jun 2026 23:28:10 -0400
Message-ID: <20260621032816.1806773-4-longman@redhat.com>
In-Reply-To: <20260621032816.1806773-1-longman@redhat.com>
References: <20260621032816.1806773-1-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17102-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:lizefan@huawei.com,m:farhad.alemi@berkeley.edu,m:akpm@linux-foundation.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,m:gourry@gourry.net,m:david@kernel.org,m:longman@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 604156AA1EB

Commit e44193d39e8d ("cpuset: let hotplug propagation work wait for
task attaching") was introduced to let hotplug operation to wait
until the completion of task attaching operation. However, it is
still possible that the states of the source or destination cpuset
can be changed between the cpuset_can_attach() call and the subsequent
cpuset_attach()/cpuset_cacnel_attach() call.

As a result, data gathered during cpuset_can_attach() cannot be reliably
used in the subsequent cpuset_attach()/cpuset_cacnel_attach()
call at all. Make the task attach operation more robust
and allow the sharing of data between cpuset_can_attach() and
cpuset_attach()/cpuset_cacnel_attach() by making cpuset_write_resmask()
and cpuset_partition_write() wait for the completion of task attach
and set the attach_in_progress flag in the source cpuset as well.

The comments about validate_change() are no longer valid as it won't
be called at all if an attach operation is in progress. So the comments
can be removed.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a1c8890d3519..65d095dcada1 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3080,11 +3080,8 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	cs->dl_bw_cpu = cpu;
 
 out_success:
-	/*
-	 * Mark attach is in progress.  This makes validate_change() fail
-	 * changes which zero cpus/mems_allowed.
-	 */
 	cs->attach_in_progress++;
+	oldcs->attach_in_progress++;
 
 out_unlock:
 	if (ret)
@@ -3235,10 +3232,19 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 		return -EACCES;
 
 	buf = strstrip(buf);
+retry:
+	wait_event(cpuset_attach_wq, cs->attach_in_progress == 0);
+
 	cpuset_full_lock();
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
+	/* Don't race with task attach */
+	if (cs->attach_in_progress) {
+		cpuset_full_unlock();
+		goto retry;
+	}
+
 	trialcs = dup_or_alloc_cpuset(cs);
 	if (!trialcs) {
 		retval = -ENOMEM;
@@ -3366,7 +3372,17 @@ static ssize_t cpuset_partition_write(struct kernfs_open_file *of, char *buf,
 	else
 		return -EINVAL;
 
+retry:
+	wait_event(cpuset_attach_wq, cs->attach_in_progress == 0);
+
 	cpuset_full_lock();
+
+	/* Don't race with task attach */
+	if (cs->attach_in_progress) {
+		cpuset_full_unlock();
+		goto retry;
+	}
+
 	if (is_cpuset_online(cs))
 		retval = update_prstate(cs, val);
 	cpuset_update_sd_hk_unlock();
@@ -3605,10 +3621,6 @@ static int cpuset_can_fork(struct task_struct *task, struct css_set *cset)
 	if (ret)
 		goto out_unlock;
 
-	/*
-	 * Mark attach is in progress.  This makes validate_change() fail
-	 * changes which zero cpus/mems_allowed.
-	 */
 	cs->attach_in_progress++;
 out_unlock:
 	mutex_unlock(&cpuset_mutex);
-- 
2.54.0


