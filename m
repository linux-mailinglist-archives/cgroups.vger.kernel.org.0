Return-Path: <cgroups+bounces-13901-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFF3HlEFjmnO+gAAu9opvQ
	(envelope-from <cgroups+bounces-13901-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 17:52:33 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 119D212FAA2
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 17:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0036F319A036
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 16:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6157735E553;
	Thu, 12 Feb 2026 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GhOFLd02"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C5E35D60A
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770914900; cv=none; b=RgmMJcS4mB6f2yVLIs5Ge/aTIr6vkfVm2sEuAup3ichtFwwpb15Kz9nf8FZc2dE2ofCKHgHemE4L5aIfMA9Zl3HbjWlGBu+i+GBWhh9jc14EfX0P08FFjUHAzagTyvf19M6xaXTpCYiqSav1mcCDIhtkk+3Lz+5+VFQinSq7mPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770914900; c=relaxed/simple;
	bh=fuv/jyg3v7GpHgjIBWv6SQzEBACOf0vyAQ8TxmVeSCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ipkmo66Ko/6c4Ln3rMYMHDLbISEW/CtKSXBa1IkBKW2xsH908vYLk5JWS/Hxdznc6/Yrw38QYzDtr0hsIP+VrctTYzlIR50+VKxT4bcys6dab9e+M6jepvytcX283VlamSeMktNqPfU9dlMa4pAJYk/UN2b6llhWkaTYvNTyQxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GhOFLd02; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770914898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6qAkghoKFfQsdHzpQw7M41IwcTa05blMdq+6OMoGRvc=;
	b=GhOFLd0224v/g1wFiVnF0vyUhzv6yCNXI019Ol2kC4QGGuJt4ayWnmsl/Lewz9PnF9q7UQ
	BEa6OGfeC6msX/PfTFFgoeV0w6zU0I3BgTv3R0k9LDe8jT39S6/HWPRWBWQsFkr8QFxk67
	B7YlwcOBfoRQY0rJpbS6Z43sonuUd0E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-698C9_Y1OxOGmVsJ680FmQ-1; Thu,
 12 Feb 2026 11:48:13 -0500
X-MC-Unique: 698C9_Y1OxOGmVsJ680FmQ-1
X-Mimecast-MFC-AGG-ID: 698C9_Y1OxOGmVsJ680FmQ_1770914890
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2BB01955F22;
	Thu, 12 Feb 2026 16:48:09 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.194])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AABA01800464;
	Thu, 12 Feb 2026 16:48:06 +0000 (UTC)
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
Subject: [PATCH v5 3/6] cgroup/cpuset: Set isolated_cpus_updating only if isolated_cpus is changed
Date: Thu, 12 Feb 2026 11:46:37 -0500
Message-ID: <20260212164640.2408295-4-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13901-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 119D212FAA2
X-Rspamd-Action: no action

As cpuset is updating HK_TYPE_DOMAIN housekeeping mask when there is
a change in the set of isolated CPUs, making this change is now more
costly than before.  Right now, the isolated_cpus_updating flag can be
set even if there is no real change in isolated_cpus. Put in additional
checks to make sure that isolated_cpus_updating is set only if there
is a real change in isolated_cpus.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e55855269432..c792380f9b60 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1180,11 +1180,15 @@ static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus
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
2.52.0


