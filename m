Return-Path: <cgroups+bounces-6921-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74027A58FDB
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 10:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A90116B41D
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 09:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5965B224AEF;
	Mon, 10 Mar 2025 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COC1uk8f"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A5413DDB9
	for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599557; cv=none; b=OsriGc8Av0u14oZJO0JubtOEpXWaT1bGNyXducby45v6PrsI8AZ4B0qB7yZibkUusbXTTmLJaAXgexFtj4B8XCjLMd59/iM9ExFn5LceQzOBrUKQQ+kpxG2wVYZ7/OSqxsF4ngTQ1rvj2E4QcN7FYcsDNLHpKps2x/xvewrZjSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599557; c=relaxed/simple;
	bh=bSLpIN8jUdE9hjPba80yyQ52wEXooa6uwUai3Cd9z98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSk7FNkqGO1Qo22TXKoX/9ppgEQbFegImaEtbI/4ekgPTZSmAvMHBif+r/aZxqPmASRCXFYEkztM0UZ7Iq+JYpPXegl1+9D8IGdWIjFY4qAOge/6VFlMTCtfvl9N5fltVZ3eJVj0RlK6ZO2xIKOFYa+x/eXp4sQNTbswSNz9LyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=COC1uk8f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741599554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SVuaA2xIyG++dtxNPCuZKJBhnBA8DE84LuwYVWooLXw=;
	b=COC1uk8fAOK+DTXD4mL8n68lICEZrH/imZr9KrC3XGOq7AFejhMQCo7+H1goE+watOJSaB
	Zaw8JPHeA2t6XKpDjDhgVIcdbq4MApQuruDZZyRD4KG3w4XK06HK4EDMV+PN3laRZmpTr9
	20eAyX6bw46ji5s/7BVwPpmIBpi6lco=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-bt9iEyESO8uxoyhQNzePUg-1; Mon, 10 Mar 2025 05:39:12 -0400
X-MC-Unique: bt9iEyESO8uxoyhQNzePUg-1
X-Mimecast-MFC-AGG-ID: bt9iEyESO8uxoyhQNzePUg_1741599551
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3914bc0cc4aso303854f8f.3
        for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 02:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741599551; x=1742204351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVuaA2xIyG++dtxNPCuZKJBhnBA8DE84LuwYVWooLXw=;
        b=PlTB9BaCg8XFQF2SiOo00gok9mtN5MBhUhOMwtUulNbK+AADtBpnmw5av/s4VLkac3
         TQvcjM8AaVVePwltCRdQ3JOrxg2CaOcYoCiDxgGtlCJdWZ403PC97B2RGdskEHnT1XC/
         U+P+3Q2yVyyntpTYbmP2XwLNRgxBpUe7eS2VK0+hngYBfM6yNn8R9I0OcWoRkxEWwYMQ
         k5SeKxnzdzH5K1jrbviV4lhblad4dIAjrqXVzokCVECKYgzuzzZr1elrm1rFF9Q/vcmc
         Cd6cemEQ3vqUwT69SUMmRIZlkiCidah2LdtLy9JMJdsF5GwNtzKyFZ8Dk2DStF5WGCOY
         jg1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYGrD8bMvW75zUf3nZrj04esN1xsP63sW2FxybnaaIk/+Mfsje4vOFhUodJE9p5jdKOqECNFPm@vger.kernel.org
X-Gm-Message-State: AOJu0Yy67k5N+GM+II96YGSIo2v1VixLqXoF4zIFRugn1DzGFOnPRWF7
	tWbLS3K5rMrm2R0dIh93CI+dH5cXayNXoN0kwoinLJFiS3lxuCK0MiuSTcJZ54vpQXoO97YZOjE
	LDQVz+OmjCvaPDqh8gGYG8zjQwMKijBIFGQtQeKSRPQPplbFIOdB3UbI=
X-Gm-Gg: ASbGncu7rfyL9kAujcHHAcltCZuuDV3hPday9dLz3A6M1B9Ic3nLnYT0JW4Vggyw+5g
	ZFHO3y92O6QW5yG6yg24Dz7tCjlpguvTorFelKbVDu26/kb+b+JqUm4CgvB4qjNZzcdn6QNhW3j
	surGNqRRGCTtViOtMk3DCsMtOz/jJolbMjLoM82H7NIluxaRk7EckXCmjv1h3xFm3nAl5dq6lKg
	z7YdePaH/Rv2HqK53kHEpD+OAr2sQYdSL/5LCz57TV4mpX1SRlwttZ4/kKxDhHdpfSi2HPOM7lR
	EO1pn3toHwSEXWroxIOivWhPam5X467GmFdAW50P79A=
X-Received: by 2002:a5d:6d8c:0:b0:391:2a9a:47a3 with SMTP id ffacd0b85a97d-39132b5b802mr7939578f8f.0.1741599551523;
        Mon, 10 Mar 2025 02:39:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtDGjwhZCXPUTTbyre3WWNNE0mRndLmnRoT0m5vbhow+i+lvg8pi3nxLQvh3LPFdggIS2WXg==
X-Received: by 2002:a5d:6d8c:0:b0:391:2a9a:47a3 with SMTP id ffacd0b85a97d-39132b5b802mr7939557f8f.0.1741599551159;
        Mon, 10 Mar 2025 02:39:11 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01ebddsm14627111f8f.60.2025.03.10.02.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 02:39:09 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:39:07 +0100
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
Subject: [PATCH v3 6/8] cgroup/cpuset: Remove
 partition_and_rebuild_sched_domains
Message-ID: <Z86zO_uCamVRRUqe@jlelli-thinkpadt14gen4.remote.csb>
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

partition_and_rebuild_sched_domains() and partition_sched_domains() are
now equivalent.

Remove the former as a nice clean up.

Suggested-by: Waiman Long <llong@redhat.com>
Reviewed-by: Waiman Long <llong@redhat.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
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


