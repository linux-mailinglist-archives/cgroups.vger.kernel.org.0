Return-Path: <cgroups+bounces-6805-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F33A0A4D6C7
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 09:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3894D3A8A31
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 08:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B941FCF74;
	Tue,  4 Mar 2025 08:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MdWBNRXe"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04121FC7C2
	for <cgroups@vger.kernel.org>; Tue,  4 Mar 2025 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077703; cv=none; b=aOEWSGuIzlmFwvIHxAiVPmeiOklXTNA9WxYQQI9gr1dYkPYylTdUIs9uXZd1zlo8HeDg/t2OBFv6bvsmrS74RodpnNygg6GH9tZUupPSBLJUx9m30PZmx86Q+RzpN6t88MfcwwM/2DEXXKNCcRR2SF96NTRwDaSoYAL5l+L6fy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077703; c=relaxed/simple;
	bh=+tyAV4Hec65TSNaKqrd86BlyoB/UL+9or/H6GiAPaFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rq+uRn+8ftWxvdpQSCT9J++58kY+XcvhRFJ18LBynYjodXEdfdrBYaBGWZ6vpDe3rCcTMc/4OK2exV5t/+DorPZMTnjzqr5EfYLpcdZ70g+BJDfgaN6KSJx3ru4hvg4wJTHwnLHdZJOAptbiCjI1tyshyXospFbPM2TGrTFuVaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MdWBNRXe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741077700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P3+x8ZcbjsMBBC18OSg29VFMjfEWmgYEE5sP6YSqtFk=;
	b=MdWBNRXefpFPXhJVzM52Y30Eq8B7QmXVFHtJNS3NbgIvrMfGG3LPTrs3YuLYlRXhhF4iNT
	g8WPNv3HZLATlqnqAOaKdDavn8V85aAOSmRylV0wEoBu7ayDaS2tyfREMHNgdE4hUCazMg
	4nNPWUamH7SCDLvjSFKNqgKAeUQTwCw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-7kbNsEMvNw6Zr2M6L_z90Q-1; Tue, 04 Mar 2025 03:41:34 -0500
X-MC-Unique: 7kbNsEMvNw6Zr2M6L_z90Q-1
X-Mimecast-MFC-AGG-ID: 7kbNsEMvNw6Zr2M6L_z90Q_1741077694
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7bb849aa5fbso1474725185a.0
        for <cgroups@vger.kernel.org>; Tue, 04 Mar 2025 00:41:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741077694; x=1741682494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3+x8ZcbjsMBBC18OSg29VFMjfEWmgYEE5sP6YSqtFk=;
        b=h9Yvw5oqPqvlqb3QxAC+yAFxUqTYa2WTDRdkVz+R5Z4DsI0PA8wqGcAVBtfImsVymG
         DJKriY7eT87T90vF9Ra2PtcM6s5qwYih6SAqgYA2IQtwavYU4EZtvvSXsWTfacmpqSwB
         aaIuUb//VvH5+Xjc7UzT9snt23sqcepQXdbG0pv0VRQ1T1yFy544E+/YAtQr5MT3p9Fb
         I10ItgwrBbnfvrYI5wrW/MBRJb9VWIeJ/twSP6FUEGc5O8qYir4lfA1kLZek2FekjKzb
         IPuzYsjV/E9pGJf+joL0DKb2Ar1B0cx+V44JHStEvGnZH0hw7JHPswsElh4QPOVJSbcw
         fPRw==
X-Forwarded-Encrypted: i=1; AJvYcCWJO9G+t1t+0NkfhNZd/AJrsTRQ94WiDFu248ozISs9oJs9pJRH//kPz/kpy5lc70dGaOpaxA0a@vger.kernel.org
X-Gm-Message-State: AOJu0YyPIw7KMJzkx7RvvpsZ0IVPRl6ARbWHdRXIKmdH2bzx8jPzvWY1
	H02FCXohEXnTljUkkKvWO9SQ0KbfxyJbi12NG5StOAWXNK20u/g8coYSD93lsOuFZMo43RIC2GA
	HdmTYEoaHC1IQcrBgjxSD73QPAYcP8CfHkMwuwoN7vpgUSM52H+izh8k=
X-Gm-Gg: ASbGncteXtSanh9lVSP7f1pHtUi76MajrY14S5COWjaEi77nO1Jyi65v+2W2MfM84Ai
	fFC0d2rZVsByjoFlmBrRkSZRmizBwPhUUL/eQKc2MnSb+aomHeXzABxglFAHs7oillt2Xow8MdZ
	JEatYL+EZ3pkHPQIOor1m1VwqK8CDsdpG34UyO2MGa6fvW82YVXq/zbwq5rSkkfWQlbcj7OUM21
	5ihZrvldl9acOJFCyaLCdSRTlKH+MT3gb5+6oVc6jHuggGrK2b2P6aiHpTSzazJAbMOjWARt0ZF
	zm+7I1/Edl2uvvnsjeRMKvzoldnbXsRj3kFjaxwSpSV4Uagpc7+PnsHpYB80vUNpPB1qndXbIxt
	R2VA6
X-Received: by 2002:a05:620a:24cc:b0:7c0:a524:fb9c with SMTP id af79cd13be357-7c39c67e5demr2469795485a.47.1741077694045;
        Tue, 04 Mar 2025 00:41:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF36ZSWWjVDT1inIQxVAoHh+evvEzMmrsNt8O4ZQ99AjTkmT/HmwUmDBF2MKdn3vcE/w9gZ7Q==
X-Received: by 2002:a05:620a:24cc:b0:7c0:a524:fb9c with SMTP id af79cd13be357-7c39c67e5demr2469793185a.47.1741077693721;
        Tue, 04 Mar 2025 00:41:33 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c0a94fbbsm218395285a.1.2025.03.04.00.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 00:41:31 -0800 (PST)
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>,
	luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 5/5] sched/topology: Remove redundant dl_clear_root_domain call
Date: Tue,  4 Mar 2025 08:40:45 +0000
Message-ID: <20250304084045.62554-6-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304084045.62554-1-juri.lelli@redhat.com>
References: <20250304084045.62554-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We completely clean and restore root domains bandwidth accounting after
every root domains change, so the dl_clear_root_domain() call in
partition_sched_domains_locked() is redundant.

Remove it.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/topology.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index bdfda0ef1bd9..c525e919f383 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2725,21 +2725,8 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 	for (i = 0; i < ndoms_cur; i++) {
 		for (j = 0; j < n && !new_topology; j++) {
 			if (cpumask_equal(doms_cur[i], doms_new[j]) &&
-			    dattrs_equal(dattr_cur, i, dattr_new, j)) {
-				struct root_domain *rd;
-
-				/*
-				 * This domain won't be destroyed and as such
-				 * its dl_bw->total_bw needs to be cleared.
-				 * Tasks contribution will be then recomputed
-				 * in function dl_update_tasks_root_domain(),
-				 * dl_servers contribution in function
-				 * dl_restore_server_root_domain().
-				 */
-				rd = cpu_rq(cpumask_any(doms_cur[i]))->rd;
-				dl_clear_root_domain(rd);
+			    dattrs_equal(dattr_cur, i, dattr_new, j))
 				goto match1;
-			}
 		}
 		/* No match - a current sched domain not in new doms_new[] */
 		detach_destroy_domains(doms_cur[i]);
-- 
2.48.1


