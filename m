Return-Path: <cgroups+bounces-6865-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61290A54D21
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 15:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F20921896D03
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 14:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00D8155757;
	Thu,  6 Mar 2025 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWABMSAp"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4529D20ADD1
	for <cgroups@vger.kernel.org>; Thu,  6 Mar 2025 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270283; cv=none; b=MrtgUgtH7nVr5QGPySUhk+u+I1icBT4VUOmmVRTHjAqWBbY3TkHZO7ZMn8b+02iOO75xsTphrvzjhSeLTMNBLN9XQDKcWIvl1ZYfmXK0iVC25fxr+B5vZ3h5PvPFvl+KEtwm2Jm1Duy5T9wAvQbL1BWGYeBVLK5e3AWkWANBbeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270283; c=relaxed/simple;
	bh=NJa7eHT7qOxfHmHXZjuOxjXW46aERM5gQU39+V2N3K4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwmqynEnOl9Vt+E7ysVeCXT9+e71WawPs7vw8Dr7+DpaSHp3ZYFL68H21dYz4b3rNg2SfXUx/LmyPtHUoksjGnVfDAaIuU0MOJ+Sb80wPM/sx84AiDiwfUztmtDPDZ/DQJshr2Pe2mjBq6X9eTCUo5d+/MZmCNj1FCIQLAPlvNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TWABMSAp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741270281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F4ZIFOGxzinJuVdUFfsoDQG+XLi9wvCEmtCRKGKKMyw=;
	b=TWABMSApGpoyYh5w5xbBQEbkGlpvEVLhnTcxU4vrORsK78ODKBS9GE9RiZe2pX7yGExWCH
	/RvvgytQtfCefmFwZ5KPSMAz1FefLqk73KePIUNDfkv2jBfPwHSguGtHnQzzC18mp74NBY
	FpfD2L+CYwUTtsf6NQRcfCSQ7zPCD+0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-02lCDPJnMn6hwgR7_4B1SA-1; Thu, 06 Mar 2025 09:11:10 -0500
X-MC-Unique: 02lCDPJnMn6hwgR7_4B1SA-1
X-Mimecast-MFC-AGG-ID: 02lCDPJnMn6hwgR7_4B1SA_1741270270
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c3b93cf715so147668085a.2
        for <cgroups@vger.kernel.org>; Thu, 06 Mar 2025 06:11:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741270270; x=1741875070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4ZIFOGxzinJuVdUFfsoDQG+XLi9wvCEmtCRKGKKMyw=;
        b=JbK+v+UdXGnjOs/ySdHHVkXUBu2w/XjCsAAryiWMfdF3Ahg4/iRYDRps5XxmGFQfHh
         AhlPrZmtk2iWrNU1dyzV3pl8ZhI/+b29XRx7egMDzdkPLCG0xWMLd4R6jmkPNq+7cIQ/
         371pIQwMLPMgWo0sHYgBFq5g6pHIHRyu9U03gvmqF1udRrb47EFT0+VHJSJMjIX+cZRx
         lAJW5q+dG32EPLrQndvyVzVEVA1e6OXNhoLtdQrHc7TpwZtWPRp5vsCmIV1l2TO8sqiO
         ok7FiKUfi6giE61bVWP3r8Ynb2AleyStzdG0vvG+csV+Pf8JO/JX0x3JkpJ1g0j3Qe90
         KaJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2o8keOFs6G8fGra7JxHUACTlKQ3D5hn7KuBmEFOwFVrn6lTNcZQ2WdyXcacQpqwfgazMsbvnA@vger.kernel.org
X-Gm-Message-State: AOJu0YyZC96fu/91S6x3XHmFG1MuqFOOm6wFAN6m/IkFDWw37mRnVnwA
	2PyUq03CYrhELBFAKpdCZ7smEoOl6AqZF35+jlTnxOyhQ5/XrAlkaacrDpRYiWEJbe8X6qHBT0L
	IROxMhXc//P8CdVJxGyDSMVw3GH1eIQn6EjbFEvlPIiCJRXh9qFItcRo=
X-Gm-Gg: ASbGncuqnGzmVSpPe2v6i7IQhvvVGhVpyN9VcpN2aibljURKpejZwm4oXneeEUrkjI1
	5NPfn+sGXMfQrBiGa04atg13i3dB534KITeKXhLCG1GuycESS8gf2YBrnu8cYN+EE5oYRswRak8
	diVUjP2YlwD6xdGOb3zNcvZ0j5fxvFMzoYZULkaEDHe5AYc1lyDuS9Yx7NZ+qW5WEdrsfMwzirl
	S/2k3QWr9rxI89Mc3VL9hrkUlYSPkojfTM4bsnDrZg45kNaNKkEs05YgPXPMjaZ/swQV9Zx0X2R
	FbiTBmBSissEpADYXm7yhhn27gxSfQyGglmAN7la5xfrLLwftusGZ/WU+Db/rrKrIVam0SHbKSz
	XI+Sq
X-Received: by 2002:a05:620a:2609:b0:7c0:7ff8:231a with SMTP id af79cd13be357-7c3d8e680dcmr998088285a.29.1741270269874;
        Thu, 06 Mar 2025 06:11:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGNuuK35swKKToS86/qmvAp2EsJ5mnlJsJBrB3uSoXbOl1vHKoKvdXC/bxVXHHhC8AQP5Gqw==
X-Received: by 2002:a05:620a:2609:b0:7c0:7ff8:231a with SMTP id af79cd13be357-7c3d8e680dcmr998084685a.29.1741270269556;
        Thu, 06 Mar 2025 06:11:09 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e551119fsm93658985a.108.2025.03.06.06.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:11:07 -0800 (PST)
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
	Jon Hunter <jonathanh@nvidia.com>,
	Waiman Long <llong@redhat.com>
Subject: [PATCH v2 6/8] cgroup/cpuset: Remove partition_and_rebuild_sched_domains
Date: Thu,  6 Mar 2025 14:10:14 +0000
Message-ID: <20250306141016.268313-7-juri.lelli@redhat.com>
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

partition_and_rebuild_sched_domains() and partition_sched_domains() are
now equivalent.

Remove the former as a nice clean up.

Suggested-by: Waiman Long <llong@redhat.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/cgroup/cpuset.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f66b2aefdc04..7995cd58a01b 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -993,15 +993,6 @@ void dl_rebuild_rd_accounting(void)
 	rcu_read_unlock();
 }
 
-static void
-partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
-				    struct sched_domain_attr *dattr_new)
-{
-	sched_domains_mutex_lock();
-	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
-	sched_domains_mutex_unlock();
-}
-
 /*
  * Rebuild scheduler domains.
  *
@@ -1063,7 +1054,7 @@ void rebuild_sched_domains_locked(void)
 	ndoms = generate_sched_domains(&doms, &attr);
 
 	/* Have scheduler rebuild the domains */
-	partition_and_rebuild_sched_domains(ndoms, doms, attr);
+	partition_sched_domains(ndoms, doms, attr);
 }
 #else /* !CONFIG_SMP */
 void rebuild_sched_domains_locked(void)
-- 
2.48.1


