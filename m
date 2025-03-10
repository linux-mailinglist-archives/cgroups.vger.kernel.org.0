Return-Path: <cgroups+bounces-6923-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB539A58FE9
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 10:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA34C188FF17
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 09:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BB9223322;
	Mon, 10 Mar 2025 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPK13vWn"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9052253E6
	for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599666; cv=none; b=cArjjIVd3JN4ZkWGrJhLNXspdLnzIYZkPaV0NYmhzo3INk+ju7RGEZtv23+F93gM7Sx2bS7Z86JM7W+AberswFUuGy8XRKT10NHYv6ll+ZKPSnTKOWCGT4c9nb9GeEw1iPSDSQA2TfInTIdXbF3ZDh7hkozvVY0tRwN9x0uGTUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599666; c=relaxed/simple;
	bh=D0qnJuVKmT1hoAQ/CBLa54Ot/pfZ5sOIHU5WXg+WzfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBe/G0H4u0UK5OcobCD30RRW2dguXQ8cro6AG/juLtk/VMKF/XNLG63xAh3K6v3lGcXVqTOrrtGcRdv0GoL4Z9yEMmEKUkkbQXXy8oTEj44Kr8DPMaaVw1m5kqIVaLvuuKju9LxNHjBJIWmB5DGfiJQ9667lbV+AFG8oa1WkpuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jPK13vWn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741599663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JmC4eg+RZE37SxbmWLTbwWm2ZOdazyFKRLy1uOVpLe0=;
	b=jPK13vWnGJ/JaRtWxLY7lxHmT1qvoTTf3cw2A/rvkJB5MZU4NSlWQUdCqI36SjYOaN+di0
	mD+h17Eyy7jFlYFpsRt8luuSMHN2ySRw1vIsQEV0VvD3Dgo4fksbQJtbMNSJhI4R1Qj8Du
	T6TLToc8ITPZiUhdk8tmMOC3EhRTx4M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-vj-i2XkAN5yJ77UygKDYBg-1; Mon, 10 Mar 2025 05:41:02 -0400
X-MC-Unique: vj-i2XkAN5yJ77UygKDYBg-1
X-Mimecast-MFC-AGG-ID: vj-i2XkAN5yJ77UygKDYBg_1741599661
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39143311936so360158f8f.0
        for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 02:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741599660; x=1742204460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmC4eg+RZE37SxbmWLTbwWm2ZOdazyFKRLy1uOVpLe0=;
        b=I4rkdv0nvaSdZXG9dHlkrDphlpcii2OSw3er9l0/NhZfUlCurIw0k5g0sO3f9kFNT3
         GrQXAWN30MAmv6+kqA3yCg3/kzxs/cd5/9+ZqP/M8MKGvf8DAibF8MkJ5zYON4yK9Mrp
         c99h+Omb6WNs6lf/BlfOcUsvtok/k7ZcpZu4mcjxahfLnjWGQbbruZxH9J6CqRNBKNkC
         PDLIJbzHqq82PKtzKUXpbgc6rtveUhITKL+qZJgKKVmgDlMqjtXvXeY89LIcGxIORfGS
         9+zphhJB+IJOK+ByyHv/sk7NlDltzgZeS4CCMn7eTw5HnrhOkFrwqvHKLzvNC8IFNXA/
         ilcw==
X-Forwarded-Encrypted: i=1; AJvYcCVQBRry0ti1+M7G8lLmknb9xwmTzVBMJRE+BTKTZl68w7uN0hqss8bLMRoH43d9h69X6t8/w72H@vger.kernel.org
X-Gm-Message-State: AOJu0YzjEhRRwRH1mcDqMSRhvEX4948xHG/Pw9CX/oV+8GWTQh56xvSv
	zPelIdXPyGLGqFB2LBRKzz+wfCE8zJiexSJFqYZZgzA0Q97EqEWlWYiUpCdymrsS8XzjTF13kUZ
	jIuxhtmmO+eSPdcDwYkFltCQ91747foEpUmhvNe+1oT9jB4mPfGSjKNz3bRkOQP8Ueg==
X-Gm-Gg: ASbGncukI3pE6wwruee4Z/cvNpQQi1mb+BFEprswj0YP5k2n5jRqbyEL/LGx0D/pZ1K
	WKMujZiQdO43rnAffD06DTp04lw7yGdqZYrugxgvUmCyyGI/GQ/2PIVRVhlrzB352XxgRlO7j8n
	xDK2Xs4HnwJNmZWMC/82JgWQL1ZShHyZxRdDaiPBLToIpde8mu4a4QT3/GiKsOFiStopIP2CG1/
	6BJfvdhAP7nX5VrF2GW1RcrXtDJlOibfJGn93wwKZDmiDicDKgTUmqD9RpRiAId70py/1fHkjmp
	mRzeadBYsXa5fp7gbF6Wj4m5x2diCMsh3fndnH2IWX0=
X-Received: by 2002:a05:6000:402a:b0:391:6fd:bb65 with SMTP id ffacd0b85a97d-39132d67e24mr8087669f8f.9.1741599659770;
        Mon, 10 Mar 2025 02:40:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3sT3VxqRqGbVJqED2DrKV+dHBvPin9Rx9+sU0PGy8vpk5mvBzNmpBa8T06MTqckjUtnwpBg==
X-Received: by 2002:a05:6000:402a:b0:391:6fd:bb65 with SMTP id ffacd0b85a97d-39132d67e24mr8087654f8f.9.1741599659379;
        Mon, 10 Mar 2025 02:40:59 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb7934sm14529582f8f.12.2025.03.10.02.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 02:40:58 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:40:55 +0100
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
Subject: [PATCH v3 8/8] include/{topology,cpuset}: Move
 dl_rebuild_rd_accounting to cpuset.h
Message-ID: <Z86zp5ej0shjk-rT@jlelli-thinkpadt14gen4.remote.csb>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310091935.22923-1-juri.lelli@redhat.com>

dl_rebuild_rd_accounting() is defined in cpuset.c, so it makes more
sense to move related declarations to cpuset.h.

Implement the move.

Suggested-by: Waiman Long <llong@redhat.com>
Reviewed-by: Waiman Long <llong@redhat.com>
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
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


