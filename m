Return-Path: <cgroups+bounces-6861-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE7CA54D17
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 15:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1397B1896C0E
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 14:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00511624EC;
	Thu,  6 Mar 2025 14:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VW/FJZ9n"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF94155C8C
	for <cgroups@vger.kernel.org>; Thu,  6 Mar 2025 14:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270274; cv=none; b=Xpj7AXy+K0RRdt4dfqP6XmaUaQNz41/72/lDA8LNhMZrOfAp+WX6eyZLYkYkuCnCVTloQr5ZV2O+VZ5nUV58oUcs1q8z8O8MVpn6CoxStBjsYlVr+Z7udoAAKQft/OAsO7hyhTxjJQVTIrkcArJBSB6SfUIu0TOKYallLOgvFU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270274; c=relaxed/simple;
	bh=cplnuDUbV4SAYo0qglwwGQchejE9iVs1NjhsTNgnpto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fn4jBihW4eA7jDbgA8hpYGmYbMXF7T6uyBxTLfJLqTqUUi8uZQUGcwS8aXI5FPk8Z9pIHUUfoWKvhhlQndo95pMFPeUCg3RtTNlrMdWpacD5fiidGiAhy8uVvcwm39Fm+JrvJ3JrsEQRnqfA5pVBn/6X7wtO+hI9KwrxkBlTU/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VW/FJZ9n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741270271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kCUje7imDL8b0wxv56NHBIYICMyM6jGJVE452JEQ/Q=;
	b=VW/FJZ9nkN/d8A9DxNTBTFTd7YsXF648zBEzLQIKvDLUcuEO+EEmrXyUFQ54TbpNL6WSE7
	q8eRK9V/WHrvy/30fxo8bEura/XYeOeZRKZYmmXPqlpLpPbf/mGI6sj2IvX7CJlW2qIucZ
	9P4/mDtenryyjqnD5hn1d9NR/3aJPVQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-dK8gZBRjN7KrIz8qS_CRcQ-1; Thu, 06 Mar 2025 09:11:05 -0500
X-MC-Unique: dK8gZBRjN7KrIz8qS_CRcQ-1
X-Mimecast-MFC-AGG-ID: dK8gZBRjN7KrIz8qS_CRcQ_1741270265
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c3c0ccf1d3so412335685a.0
        for <cgroups@vger.kernel.org>; Thu, 06 Mar 2025 06:11:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741270265; x=1741875065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kCUje7imDL8b0wxv56NHBIYICMyM6jGJVE452JEQ/Q=;
        b=d34J4RPNXZtbfdlCzymW5m9vzXElpfrQ59Kf8V2WRHSWiCFRSAAi5gWSEZUGDutjh7
         8e5hqo3x6qIGLLENMN17D7TvFLlMuTYQEAO8j8MmPkLzyLmIIRyEykks4UHiacTHfObB
         bgB3xiMj5RXJ1CbYHQMuOg2j6jSZ/5Bykui6IIc56ulDeqdh82gNzCDSuYlRVqpf5vuY
         yTQWxQxgacWVi+wvh16HOYChNiAfwYhgoon28K7kkNLVAU9+3QpBnQCUhPvcWZ4j4HyH
         NGLYQhLhnefbvKJz44QOI8r/xGwTgAeKK8D2YackrwTApUlPu1xsjTEaEWWCwU4h4L8y
         Fy0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgZ4lVB+AC8MAQk8wdeQT+eQe6Gp8I/e0Dva0iKwGFG92gyXVNoIBZmk6KSU5C3DGrg60VfV0X@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8NFGRQlsoRPmeECDBRSMMDOGbuuIUb9W9wVAekdgO5kzi6ZaA
	E6+87khmNlfwzwZyUY12o5X/W/g061n6e/yM/xa5A2diokEhNvab58zocZ3+IuqYR1Db53PHr8A
	2vIuz2lutVdLskpOQViQy0GgyKC4aHc3ahOOMttOybr9TIFSWKKGdGj4=
X-Gm-Gg: ASbGncs53Zozx2+Tef2X/UG7fCwReFLApEjYz4SeERAoT2Pbs5FACD7vAew2LlwOcA4
	ohEdp4pUzyhgl3ucF1awSOItCsNTedwVz9X/OJCaQnZWLFBNhM7MIx71aIAnAmjdd0uggp4TGh3
	1Rm3a5HFulLDAFzJVg8m/8PJ3KvClOWX+hIM1RxnCx/oIX23WHqjqHAHuQvOrIhqN7rgaxpOd61
	GATgJkib/+uTjpHYBh4OvfaLLrMBsFxieG6c1S9eCbNTTph+EWzTLitAvnHR9UsvahTPu99QSoo
	N66ysS4kl8jQs4NCXFysSzKhXE6nT9wwYv7Z4nS9VsbpgR+T6qvcYEUbFt2PQSCpX9c819RVQeB
	sNJVv
X-Received: by 2002:a05:620a:6287:b0:7c0:9fab:bee with SMTP id af79cd13be357-7c3e39d9226mr498955985a.10.1741270265091;
        Thu, 06 Mar 2025 06:11:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyPK8COEy50ocv6BjRYPq5igje9OSBoylwKnvL6uU29QylUOyC7S13wYPM+quAriw2L+vvEw==
X-Received: by 2002:a05:620a:6287:b0:7c0:9fab:bee with SMTP id af79cd13be357-7c3e39d9226mr498952285a.10.1741270264818;
        Thu, 06 Mar 2025 06:11:04 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e551119fsm93658985a.108.2025.03.06.06.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:11:02 -0800 (PST)
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
Subject: [PATCH v2 5/8] sched/topology: Remove redundant dl_clear_root_domain call
Date: Thu,  6 Mar 2025 14:10:13 +0000
Message-ID: <20250306141016.268313-6-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306141016.268313-1-juri.lelli@redhat.com>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
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
index 363ad268a25b..df2d94a57e84 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2720,21 +2720,8 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
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


