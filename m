Return-Path: <cgroups+bounces-7048-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341CEA5FD32
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 18:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53064208F8
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 17:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FB1269D1D;
	Thu, 13 Mar 2025 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDmC00yv"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5637B26A0B7
	for <cgroups@vger.kernel.org>; Thu, 13 Mar 2025 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886018; cv=none; b=l6wTuNy+In/raowaD6EQIWTYVlqBIqT5llfKAhyjz/NULNkRCCX7f5ud7J3Byid/CvaLWDKQOBoHb4qLhW9d3RdiOS28Zj/HMK1bbUHn7bBiWZMjw3It/Gtp6BZWarRZz5ojtq3JXmrG9jkcMrgUYRPi8tJlsZxZF1yqV4Tezl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886018; c=relaxed/simple;
	bh=WqHYUTx+eFUkw2RW2AHRWFLhORx7kUJq9HKMYWBIj8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/Ff+ynD/+PAScLZFOSGfLYUCUbc8W6WKRrRQLz21zJx5HtuUFSJlHpwa+ydkVyONyaDrs5xWFe51oZB59lR+Okx/8kEaZKQu49ZufPeoNMG2gB7ROlEjsP0E7ChNwAZPyJL2qCLTXcvk8QkPee8aRZd7t0ZOdYwHFQLYNBt5KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fDmC00yv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741886015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bupEj0syAwoPVUhQa42XfJiVX6UxcC7+LozYYJO5dvc=;
	b=fDmC00yvJpzWfH2b7kWRpwd/4Ml0RTjEEPjfqaTLhAPhsqj5ileVqxCBAPZCtu+X52Bk1T
	3/kaAe71yF+kFFcOVViobWaG8bzTGKj92v1+rURe92PXZ1O+1uyrNnZy1n3DwgjakOI6pf
	IXVzQ0f0ZHV9tDaCpX+7dK2ovoRjndw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-ddvbyuEAN3KQLGWKuDq43Q-1; Thu, 13 Mar 2025 13:13:33 -0400
X-MC-Unique: ddvbyuEAN3KQLGWKuDq43Q-1
X-Mimecast-MFC-AGG-ID: ddvbyuEAN3KQLGWKuDq43Q_1741886012
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3913f97d115so616980f8f.0
        for <cgroups@vger.kernel.org>; Thu, 13 Mar 2025 10:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741886012; x=1742490812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bupEj0syAwoPVUhQa42XfJiVX6UxcC7+LozYYJO5dvc=;
        b=RQNBBkZ7q0IjQ3U0JLcUAxvo1z5BoAFmcHdAVUXrKJOhPmVdgSru/jfTKIpscdvLrB
         Q2iZeXNzXZxvb6pVLyaAAWyv9nYEMrqHfJfN+fEZcgmAhIGEei6+VUABcmqBJDzI2kMb
         1xwUIt9Eqyijp/fqQiSFmlrBwz3SvTgr8eVg+GvLZmPFL1CbR39cCLeGVmMHT5IdEVH8
         2AbOLQCKONah1Qptp1PQBy/k3eqSi/GgfTIkipt1nSWMhzAFFl7SfafQ0E0qhLaR2Sjd
         hfvYNQXUQxYqbW8sEWM7EhTC0eizd9+NAz/vPzhsLhJ9jGiihoxg9HSKS5g33rMQPzUW
         tIkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/69d0C1ofNfdoHtWS/ObjVybsmn8EsTcxFEElYC7EdYYPPieYFKkIwXb634kqRmfO70M4ae00@vger.kernel.org
X-Gm-Message-State: AOJu0YzCT6DMTwCkXS5jCwYiZERZZGI0pAtFqHcgjmDOO7Ig56U6CcBM
	lQqkrwV2wZavA97y2GDxDZ35zq8Cjot1A5sCM29ysz9NSXuYSmp/UsFSxEVj2Y44HWueC9CxwMZ
	RXAbA9qbuArap2CFQb7Hl+2/saREKDn+Wnzb/huBwEDS7utsORPkLldI=
X-Gm-Gg: ASbGncuX+4SBYqmZkaYVSmkgKaAJmLDagIkadO9UEVEGJYyjJ0QJ5/ehHGwHrgYAgOX
	0wYCUkfWOGlCs0tBv+QXgOKWaUBcIf6SZA1n2o3gi45BkI32w8Yg7iaYIHIs/hTRorhX6uqdFR/
	9c0p7f3pWnXcsKah0Y3OWPKUG62ZdBIt5kTmZfOK/4XuNDmsBM5fBiJ2RwFoIGGVQRJtP53Gj3Y
	SM65PqvbCVH7MDT8HFQyI1IyTwl6Ozu34C0JPbW553I6X2u5iU/ngD0DfUqCeE1mTWPGqiR/6s+
	9tQNJlx2yh9Yu4Kq2d2qjaufm8Q9XE95lEfBzCDHUFM=
X-Received: by 2002:a05:6000:2c1:b0:390:f0ff:2c10 with SMTP id ffacd0b85a97d-395b954eb19mr3355820f8f.19.1741886011880;
        Thu, 13 Mar 2025 10:13:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEEnc4cttulcmus+Fv0WW0T5aRNhlzgKWFpdFHOzzTN1NDvd2Ek9XGkn5vqNfWrw9ReDOVzw==
X-Received: by 2002:a05:6000:2c1:b0:390:f0ff:2c10 with SMTP id ffacd0b85a97d-395b954eb19mr3355799f8f.19.1741886011521;
        Thu, 13 Mar 2025 10:13:31 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6b70sm2787906f8f.30.2025.03.13.10.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:13:30 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:13:29 +0100
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
Subject: [PATCH v4 8/8] include/{topology,cpuset}: Move
 dl_rebuild_rd_accounting to cpuset.h
Message-ID: <Z9MSOVMpU7jpVrMU@jlelli-thinkpadt14gen4.remote.csb>
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

dl_rebuild_rd_accounting() is defined in cpuset.c, so it makes more
sense to move related declarations to cpuset.h.

Implement the move.

Suggested-by: Waiman Long <llong@redhat.com>
Reviewed-by: Waiman Long <llong@redhat.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/cpuset.h         | 5 +++++
 include/linux/sched/topology.h | 2 --
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 17cc90d900f9..5466c96a33db 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -125,6 +125,7 @@ static inline int cpuset_do_page_mem_spread(void)
 
 extern bool current_cpuset_is_being_rebound(void);
 
+extern void dl_rebuild_rd_accounting(void);
 extern void rebuild_sched_domains(void);
 
 extern void cpuset_print_current_mems_allowed(void);
@@ -260,6 +261,10 @@ static inline bool current_cpuset_is_being_rebound(void)
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


