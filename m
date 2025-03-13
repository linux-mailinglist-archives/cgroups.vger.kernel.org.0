Return-Path: <cgroups+bounces-7047-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4DEA5FD28
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 18:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB35172FB3
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 17:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91147269CF8;
	Thu, 13 Mar 2025 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUH32h2R"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4561B153801
	for <cgroups@vger.kernel.org>; Thu, 13 Mar 2025 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885972; cv=none; b=YRROoZVTR+0FDvV+JcXg6TvZSnm7GFkCeNooK9sfZ+55vev8sEtMVmOjA1mgg9KH0riL4jeByhUeTDt80KmHW+B+hcrXZQqsmv8+BCdD/44l3gXb+lzArgrEglZ7YV9GGovEWKI1dSIqXL93w/7dnArbeaWjSoKC8ReBWqOJT9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885972; c=relaxed/simple;
	bh=aCNjCxT53589ZRllE+PYiqIoKKavHpFP+HFKZebl/To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GC7YQWHvkPQsH6tDuS479uWDsgDXqmZRcR2wgJTBO4HoBvVTgO77MHsAEt3oifMlvSPlSa2LtSV19V8YiNR9TmGN+eHWy+Ll9cdaOJ37iy7WbeJgCJtlk4uVYWQ+w6aWaflnXsVMmYGvHn0WomrGjbh89wINQ2a+lf8H0m826Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KUH32h2R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741885969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yTDVC0g+v7pz/pmpIDTMJxbXsOJE3z6M/wBloVGLsT8=;
	b=KUH32h2RrDI97bQOAPlrHNxTIJkWnntM0ChWen5AHr7zaTN4nqmkD9pVraWxzKZJpWGp04
	fTe7c+a+ZeexJj3fBaOR/YuWsEMzdt+gPDjBeDIQXLdxW850C8Jjva27guybUGeSR6jIzN
	agzaUaX1KxQuPUmxXpPTFlP/ehFQT/Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-4UKMFXjwMX6dlHPZybOVKQ-1; Thu, 13 Mar 2025 13:12:47 -0400
X-MC-Unique: 4UKMFXjwMX6dlHPZybOVKQ-1
X-Mimecast-MFC-AGG-ID: 4UKMFXjwMX6dlHPZybOVKQ_1741885967
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4394040fea1so6695985e9.0
        for <cgroups@vger.kernel.org>; Thu, 13 Mar 2025 10:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741885966; x=1742490766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTDVC0g+v7pz/pmpIDTMJxbXsOJE3z6M/wBloVGLsT8=;
        b=ey+TdbgSCVPyedFD7S7CR4WVZj5NDTdnSY4eOtcfE1WuZoqoWW3CAbK3c/vSMMHUaS
         xV8d3mMhN6SU2seCTCC+2sbBN0F8BpXDfLk1tTpJUkxRovRq510KY6Gw1VhNR4YnzZhv
         epqjtgyddTHB8id0HmxDOCvIcWGKytMiy0CODRuY4qj7rqnoxD2NWdAs+zDwDiroH8T9
         seW+PtRZmCPGbq734hnotk+LOi/wCErmLnVOI3m2buRf6VSpgkEsfLgNCtH9sw07WObw
         G1zKGCsxliutA3R0uqADbBuUE5TNUG+dg4qBkImcCoHEycDbWU78EVU9i2tB3hRl+g7I
         J4BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgWPwfu9w+h48dv30eYp4w27veQGQIrR9JOmkinuUsWxiMvFGdHYgKUqB+47ynhwvpXoreDhGF@vger.kernel.org
X-Gm-Message-State: AOJu0YzgDrQhA5UyZZMZRCjGpKb53N6jK27EOnkNMQSkhl5hUqy0/qQN
	iVNOvi6wLWWG1LhMl/BZEG3ORtEv9wC2jHaIIjCtyV8tCJFVXtwEjDz3BMG4yZ5Y9rXgnsUoTFy
	06LmlIbb7XYwzUe9lHbAigOyyD90yuA54Lmm56Y4RA5We0U+aKVkxxks=
X-Gm-Gg: ASbGncvgTAxnOBjljcHXgAp9Zn/x26N/XGQC1gHcYzzru0le4qSNe2t1tlEKl0yRAwg
	XNoZGIX/+RVi1RgjQfyUgKXuZoQgvr9kFACZQtOFC04Q2nmQNM+wZaGBLWKMjlvugE3o8F+kzqo
	EdNbhVjfwFr1N8FXGxm91/boZDwcFc1PO/x33f6M9FTVfmnlzS1TfXE1U35rGyyMjUFpCjBRieK
	cE2KRbRqZQJSijaL74nOMUz00VxJXiocMWGk76ikQOVGBsDAbzHFA+6Oq2yYVsYHTNj1JZCoH8i
	COvO8aOwF3h8wFibujK+KuAbbR7Vu2G9nbowE1ZlbQQ=
X-Received: by 2002:a05:600c:17d1:b0:43c:ed33:a500 with SMTP id 5b1f17b1804b1-43d180acf99mr26397275e9.10.1741885966600;
        Thu, 13 Mar 2025 10:12:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELRcMkCppH2SBJWCkSJarh6UnGy8xwMw2xvh+1UjQuiyGcl7kDXCMMZUpRXeCFwUhi56T58Q==
X-Received: by 2002:a05:600c:17d1:b0:43c:ed33:a500 with SMTP id 5b1f17b1804b1-43d180acf99mr26397005e9.10.1741885966203;
        Thu, 13 Mar 2025 10:12:46 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb8c2sm2647185f8f.85.2025.03.13.10.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:12:45 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:12:43 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>, luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH v4 7/8] sched/topology: Stop exposing
 partition_sched_domains_locked
Message-ID: <Z9MSC96a8FcqWV3G@jlelli-thinkpadt14gen4.remote.csb>
References: <20250313170011.357208-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313170011.357208-1-juri.lelli@redhat.com>

The are no callers of partition_sched_domains_locked() outside
topology.c.

Stop exposing such function.

Suggested-by: Waiman Long <llong@redhat.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/sched/topology.h | 10 ----------
 kernel/sched/topology.c        |  2 +-
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 1622232bd08b..96e69bfc3c8a 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -168,10 +168,6 @@ static inline struct cpumask *sched_domain_span(struct sched_domain *sd)
 
 extern void dl_rebuild_rd_accounting(void);
 
-extern void partition_sched_domains_locked(int ndoms_new,
-					   cpumask_var_t doms_new[],
-					   struct sched_domain_attr *dattr_new);
-
 extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 				    struct sched_domain_attr *dattr_new);
 
@@ -212,12 +208,6 @@ extern void __init set_sched_topology(struct sched_domain_topology_level *tl);
 
 struct sched_domain_attr;
 
-static inline void
-partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
-			       struct sched_domain_attr *dattr_new)
-{
-}
-
 static inline void
 partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 			struct sched_domain_attr *dattr_new)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index df2d94a57e84..95bde793651c 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2688,7 +2688,7 @@ static int dattrs_equal(struct sched_domain_attr *cur, int idx_cur,
  *
  * Call with hotplug lock and sched_domains_mutex held
  */
-void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
+static void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 				    struct sched_domain_attr *dattr_new)
 {
 	bool __maybe_unused has_eas = false;
-- 
2.48.1


