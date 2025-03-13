Return-Path: <cgroups+bounces-7046-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A4CA5FD25
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 18:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A1AE3A3BBE
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 17:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B64155382;
	Thu, 13 Mar 2025 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YM/k4R5A"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CF063B9
	for <cgroups@vger.kernel.org>; Thu, 13 Mar 2025 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885930; cv=none; b=R07oOydlACRzB4wg+cVY2vsdGWVEefFCNtBsOqAlcGHvu0hBIXo0gG1ZjM/wq4ep5/fyIw6+MjRZiYI2+enJw/1YwJHHweuX/rDOPGaRworZ3qacfEQifgryoVcKmL5I9Buk4n4+Q/iIFI1qIX5wnoH0KVcEFUH0TZfIqBAXrHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885930; c=relaxed/simple;
	bh=+eE9WT0Gb1oQ7l+5iK4YZ/BXWxyzhii5ao/7GfKePmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmD9BA0gUUBDtxcfQzFrC1wf5zusC8A0WLRWvKtBKi5IvgCvUvrVWh6W49zJt6MyAS1nvEIgiXLTucC1dTAPULt0kweUsDJjb+SQTnD4+FFmCeAWgt8Y497EXRMoOUptcEoqyJ5444miQYD+pwlImdedopq48VvLVH2h+RKrWbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YM/k4R5A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741885927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nGrmHbgAII+9uPhNMvyhCYNvKc1gV86tMiTemisyc0o=;
	b=YM/k4R5Ay/rti/BapNUigzrIm7N50J0uoiytymLkT1CiWdKFn5GJPvBhNxFUmPtNdc/egV
	VA5tlkHkmTRk+tvE1AtNPlRWc+tTBEYgt5sSIl7e8zJKIT23okEABCf1qlwhgGpJpTn8YB
	+qJaUN4y1qjgJ+LWpn13iysSBsmptjE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-VNSS-aGdPjGpvPd1MekiXw-1; Thu, 13 Mar 2025 13:12:06 -0400
X-MC-Unique: VNSS-aGdPjGpvPd1MekiXw-1
X-Mimecast-MFC-AGG-ID: VNSS-aGdPjGpvPd1MekiXw_1741885925
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ceb011ea5so6486615e9.2
        for <cgroups@vger.kernel.org>; Thu, 13 Mar 2025 10:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741885925; x=1742490725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGrmHbgAII+9uPhNMvyhCYNvKc1gV86tMiTemisyc0o=;
        b=E4dDZcatheqGJO3oNIJUy0fkWS+Xhpu/3lGX/9UhzBAef+ToNTsTxhurBR84J/pVKo
         svkRZLT8AuGKeP41yXEOi1XCdh58riMzhD/JA1X5/sIvddu1ycjxJRzSE23oUwqdUt5Z
         kgci5IIrSaAqA5+jZZWCpX6+T5UtdogqthyMsn1dZvSSYtc+o6z7GbQ8w/PDzlts2Lqi
         SuKNxXrplmgmZR2A21W0l5KuOFHx7+/JO/15CvR7R92/S/0+NhTUGSPuuZ2IuKNvfg4/
         EDa5pc03ikGgahra7M9lE8ppa6T4/4TwmSvX9eNoA2RYF3BAXn0OIkeZCxv3Wo4p12Co
         tmQg==
X-Forwarded-Encrypted: i=1; AJvYcCVlGyiB60Smjd1+GQPGB4mQ+ZhVc+MwXzA2GbhrmmF8LUSz79gojDrRErjXPhWoIc8PULf7RzmB@vger.kernel.org
X-Gm-Message-State: AOJu0Yzune13ZOORO8kJwJ1y2ttpgNyzBwG3dyjwbseX2+vhIeKNo9Ai
	Gh9mLpc9/EcOdSkRJbIiqRptKMrIcKTVVDwa340okXrohqpVrcEY7wSi+6fxiUQp1/T/YEhltVk
	C1CrJFKjg8PgCg9FY4jaxjEO6w6UhJlQjwh+Z2BAoUptjHydrwvPtL0M=
X-Gm-Gg: ASbGncuib3KjkkarkTnkKP9uhjCTS9rI53W4OAD8fUtSynEXd6iJ3M+IC3KnmwsoGK+
	ZLNpaKo2qBO12XXbiHfRXiEw8dQidqX4iKgWyw+l7hCbYU8GWA1inKCAbDtA3fyJKCdfkQdwG4T
	3m/qTtQp7i5qGNhMO0yJzhSnpvbhN3WGsamSjJXFlVty+lnrb9nAdkDRmH4XdNxmP73fQK2eWnn
	xm6YzsVow+318tlaXNABl1ecxZWyNj2Zr3j13YXfc5gg3nQz7kWRw4YMzUYsRCjOstBjKTuF+c0
	lh+02GPsfCXQPGxuUPofDRl66Foa5gWiKeJF35K9Ymw=
X-Received: by 2002:a05:600c:3b1a:b0:43c:eea9:f45d with SMTP id 5b1f17b1804b1-43d1d8c6d50mr4689025e9.18.1741885925381;
        Thu, 13 Mar 2025 10:12:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyjRHKruacR3ykIkv2Ici+Gurb8exc5FYumQgohkNFhqNL6UYwE5HWX2mxAmRslvWd1m7+Tg==
X-Received: by 2002:a05:600c:3b1a:b0:43c:eea9:f45d with SMTP id 5b1f17b1804b1-43d1d8c6d50mr4688815e9.18.1741885925020;
        Thu, 13 Mar 2025 10:12:05 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a8c5d04sm62439625e9.27.2025.03.13.10.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:12:04 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:12:02 +0100
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
Subject: [PATCH v4 6/8] cgroup/cpuset: Remove
 partition_and_rebuild_sched_domains
Message-ID: <Z9MR4ryNDJZDzsSG@jlelli-thinkpadt14gen4.remote.csb>
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

partition_and_rebuild_sched_domains() and partition_sched_domains() are
now equivalent.

Remove the former as a nice clean up.

Suggested-by: Waiman Long <llong@redhat.com>
Reviewed-by: Waiman Long <llong@redhat.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/cgroup/cpuset.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 1892dc8cd211..a51099e5d587 100644
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


