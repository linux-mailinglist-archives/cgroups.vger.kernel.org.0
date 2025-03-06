Return-Path: <cgroups+bounces-6866-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3437AA54D22
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 15:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C85B18883F5
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 14:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06805CA6B;
	Thu,  6 Mar 2025 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADQ81Y9f"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0D313C80C
	for <cgroups@vger.kernel.org>; Thu,  6 Mar 2025 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270290; cv=none; b=ZGrkVNUO5KZJpS7QvNt5gjnNpvdgCgKbznGzmZBd83F+Bd3/XGxjyV05J3DdodkAQcDFcePouokUz8hXpfbFm1YqgJli0jOyHB2qGOapyD7l23mRyKA7C/xMbxxAnzCGMDoEufoklFOi27WRrpaQD4ceWxpJQ91sYxFZxf2TPjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270290; c=relaxed/simple;
	bh=C/Cc8iMh5RhuOM/HCUsSqAmjstO6BDzi53uIK0zWZm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BOr0wjerKwRDWyKLz3ERtgL2wo37i1TsuQEb2Yx6vPqXbeesSjaDVNPMhxNWp8oUdBk11CT8zKyNYsvPuK3W4yN6I9dsjN4c3PEpKlG+R5Fo3qIdsAtzjG0YUw0sxhXc8cJKaVESoUphzCI7r8pTEh36D0vCXE+h/nISrLob8OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ADQ81Y9f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741270288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R3M6FX8T2xhunhC57UXeJA8V9v8swCagmqmFMiwHiP0=;
	b=ADQ81Y9fU16PnZnToxPbG/V53l74yPM68knDzHhf7Uy46+3Gos19xopurEIF81SK5AJvKp
	HNw+cXA+/Mw5VC6NHPYsR3wnUoTYmRT4lrhsUEjoYLkIw9qSFO0utDTD4EWfSYwp+Mv8u7
	XJljv6kT6uv6Pyp2fDKEGY+X0fU6gA0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-7RqrNbcEPGift_WjesVm0Q-1; Thu, 06 Mar 2025 09:11:22 -0500
X-MC-Unique: 7RqrNbcEPGift_WjesVm0Q-1
X-Mimecast-MFC-AGG-ID: 7RqrNbcEPGift_WjesVm0Q_1741270281
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c3b5004351so153649985a.2
        for <cgroups@vger.kernel.org>; Thu, 06 Mar 2025 06:11:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741270279; x=1741875079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3M6FX8T2xhunhC57UXeJA8V9v8swCagmqmFMiwHiP0=;
        b=sOaB7lZ45CpBJL6vD12JDBHCOuVn90Y5ocz19I0vm+oBvkRbKThgMzEMgaoXEwfUqe
         t0LVWOip74XlEXASdp6y9EgB42xzfcXIq2pKTLlxv5t+JWA5NZUrvJRrrm5V+APsp56Q
         td77b8AIiCNjDvdTZVuBQOXP3RoNX5H6xNS9XKJumKb/tcJKFIUt+GhYdu5APCmQb4K4
         qlULPcfvyS0Oa/oASuGFPlxbtIUlHsCrmyRRANJV6qLo97VzPKrB4uYOWW81+vMD02RO
         JFEWI6EGo7sle6y07MkyXdU34UZNClCkSAaCp+Iy83YIpU7N0onuUnVreaDsc2TO8Vpj
         swew==
X-Forwarded-Encrypted: i=1; AJvYcCX6Pv3Fd6YItwFZWq5nE13RSSot/OfC2iCDk9BpqFpJLnBDEHZc+sOnv4DgDcp+8raK2gRMEiWI@vger.kernel.org
X-Gm-Message-State: AOJu0YzSFq8enYjoJbZBNq0EZIyNUfnkL67CILoZAtYZfEdm+PX0b8ea
	o23aYV27k8pVriKnXpRKEkgjmavUsqromYZW59Kiy63B4YOawtpVhpBJu4jLZ6QjtxBAf0B07Cc
	TD0ULaFVyN57xub9wGUgD7rwIIxr9Xes/yDKorFL70AJBZ+1iGZ7V+zviJ853FCVy6Q==
X-Gm-Gg: ASbGncvd6Mx20R8VNKTIxiw1XZ0wnWtz65HgqiCDVdqVsLUS3Ckn7B6sTnH/hHzfcOQ
	pxWrtrh6iHGlbE1Wy/7z1EFyHfrzQ6dt85K0BiLKN/fzMEaQwKcl0Y6ZAwsnQzpdDb7sr26FLlP
	OX/OwmukPnyZiW82SmDgv5ZImL1DRj1pRqQ68/EduUn7OKiYXY+35zJVZ3/iKY71INMRq1N7I6n
	XFDS6VuQ7jBZrUma90M7XLvK+1VNwwXpbZ/t9JjJ51zOrDkYz68ub/icbiefw9TnFgJgEK42vBI
	oD2J+9LuBnUORgMixGLvgcnB41r5FID1huZZiFmFJJ+Xso1WRnFOpS2Op/kjjb3wFaJFt/C5+1n
	2W6h0
X-Received: by 2002:a05:620a:8706:b0:7c3:c1df:149a with SMTP id af79cd13be357-7c3d8ec7c89mr1017800185a.46.1741270279174;
        Thu, 06 Mar 2025 06:11:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/+GQVLhu46C/Nyd3wxyeBeqf/hT0BoGgJcoGKjcpXDkjFLsMk+xW8l/y0hrRplEO9PyuSkg==
X-Received: by 2002:a05:620a:8706:b0:7c3:c1df:149a with SMTP id af79cd13be357-7c3d8ec7c89mr1017797085a.46.1741270278850;
        Thu, 06 Mar 2025 06:11:18 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e551119fsm93658985a.108.2025.03.06.06.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:11:16 -0800 (PST)
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
Subject: [PATCH v2 8/8] include/{topology,cpuset}: Move dl_rebuild_rd_accounting to cpuset.h
Date: Thu,  6 Mar 2025 14:10:16 +0000
Message-ID: <20250306141016.268313-9-juri.lelli@redhat.com>
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

dl_rebuild_rd_accounting() is defined in cpuset.c, so it makes more
sense to move related declarations to cpuset.h.

Implement the move.

Suggested-by: Waiman Long <llong@redhat.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/cpuset.h         | 5 +++++
 include/linux/sched/topology.h | 2 --
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 835e7b793f6a..c414daa7d503 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -125,6 +125,7 @@ static inline int cpuset_do_page_mem_spread(void)
 
 extern bool current_cpuset_is_being_rebound(void);
 
+extern void dl_rebuild_rd_accounting(void);
 extern void rebuild_sched_domains(void);
 
 extern void cpuset_print_current_mems_allowed(void);
@@ -259,6 +260,10 @@ static inline bool current_cpuset_is_being_rebound(void)
 	return false;
 }
 
+static inline void dl_rebuild_rd_accounting(void)
+{
+}
+
 static inline void rebuild_sched_domains(void)
 {
 	partition_sched_domains(1, NULL, NULL);
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 96e69bfc3c8a..51f7b8169515 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -166,8 +166,6 @@ static inline struct cpumask *sched_domain_span(struct sched_domain *sd)
 	return to_cpumask(sd->span);
 }
 
-extern void dl_rebuild_rd_accounting(void);
-
 extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 				    struct sched_domain_attr *dattr_new);
 
-- 
2.48.1


