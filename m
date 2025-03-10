Return-Path: <cgroups+bounces-6920-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238FFA58FDA
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 10:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A04177A48AA
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 09:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC192253FF;
	Mon, 10 Mar 2025 09:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LzujpqwH"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09735224AE1
	for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599497; cv=none; b=cT8s9JUARxqiZxMhnSBqnvOFaYCRWgbB4+D2eL7GucJB9wzZmj0mJCATaVMy7gnE4rjnFp+iPR7ObM2A+e0MN2N7URsiQUHLv1UCZxKD7m4zm1TeUsPBBSpuwgK3DIUu610+MLtjYvSgSioz+Z4QdjRPd5xkvDGQwrnVlQ/p2nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599497; c=relaxed/simple;
	bh=BHue35hwwG3uT7E8+0hMoxP2lkZ4XCqRtFoZXci5eS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoPZxEddEoMpPZSO9ymSmx21bzVkb8RZ3KqogNSktgeL1rMut5l4LGoYbk7glaYq3ZYspLM4aCslvz6UafaXFbm8dgljkIY4GDqKEZSS3sygRtYSNPv3231AqntBgxxrMVFky61aaLzTHS207SB6JsXBqgRW+Fnrllx1xPRYDew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LzujpqwH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741599494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wzT3QSYSjmZ8G9yIANDr+xNeKe7EEcc7gC4o7NwYdRc=;
	b=LzujpqwHKE812U1FD3si1j0QN8El+SiY/M2c5Q8nFnuIrrVHyMMunLrB+MP6kep+TrhvgH
	acVUAJPKvuWJrtDFnfN7bjyTBsVMklA+WYCNmf5V07uAD4gb5sANpAWCCWecR1ImcKyvIt
	IVzGzqOSowFHeY0GEuqfxwXKn8tg23w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-bQ7SKpYxO3-aQHs6WapKzg-1; Mon, 10 Mar 2025 05:38:10 -0400
X-MC-Unique: bQ7SKpYxO3-aQHs6WapKzg-1
X-Mimecast-MFC-AGG-ID: bQ7SKpYxO3-aQHs6WapKzg_1741599490
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cec217977so6818635e9.0
        for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 02:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741599489; x=1742204289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzT3QSYSjmZ8G9yIANDr+xNeKe7EEcc7gC4o7NwYdRc=;
        b=g0DV30k/YLlD7arQrIwWegU6S8iS8zpRsnHAJPmdgV0+PJTC3KfgF8SgmOSWyrzR0r
         mbvqa2LCvjOBeX9wSdioWAzFav2M1t+mYuEkfbbbv+aJ8ZLO8i46jx/1AZYnIWKjUoBS
         cNCZMXiHx0+Av5Y/yaJ3bCR4B6kg3DBWKonnaDfg+vYfTx5lgqDFm69dZT0N0Zv+EMNA
         E959MqNZd6gF8V2kyywc6yfXPWNmeXWkC1tjB22egxpSBFJFtDKn93ZuiKEU1ahIKP+U
         DD5P2Y3Bw8WKscij1vw785icU/blLIgHWdeP7v+1roA/3DrQPSVyZE0vcQ980kMJuIby
         YN7g==
X-Forwarded-Encrypted: i=1; AJvYcCU9qGJ3CcTyGDU9lwFFqYjk89+9NM3ALSQL1BErqSewJCe4OhoQxPie8Mwk3/sf/bp6U/I6g04C@vger.kernel.org
X-Gm-Message-State: AOJu0YxVaGIvxaHum8MYxIS0STO0Hd1JTfq4gNwYKWrMR/IWGL2gvF0V
	8pmhog/u0TwklOkJH+/J6qA2UvwpfukcKDn5XDi6x1xt/rqpPj4DQoZAcdr3k8/+LRT4VFNz+CM
	h/ZHGN8FPs3o+1qxAcEn5vuW2KFhejhjr14Olw5EpfdWhQg/33FbqNxE=
X-Gm-Gg: ASbGnctdPBPuKP2++n420uPoqPH5m0FQvjOpLflsXUw2f1Byir/gGQIF8njLuUnbtzv
	Ife/KB78igvNZnVjLtmeZjQmnOGX09jHAzBh1FbmlolIkMsUuVJ7w3mk28n7QRJ3a0qjb5bWv74
	4NdeiSMPL/xKBTgOBPdLRCDwrObxPCYxdyojT83U5Anp1tK+U+mELI40t6dBG/IQU9nVCMbmIPC
	6XlJZ8jcL56DekHZTz5DCyJwVfgjGd1zDKq1+COYLuLRx4XMB/HZwrv6XIlQapsCXrxM0YAMazX
	po7YLIDemPBEIutG5a+bJmheS7v1SqISP7msRRChjno=
X-Received: by 2002:a5d:64e3:0:b0:391:4889:503e with SMTP id ffacd0b85a97d-3914889519cmr2493696f8f.33.1741599489626;
        Mon, 10 Mar 2025 02:38:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn7gYGzhHmPcL3pfBYzEcWegmbHHUv/hFVbJA3S4wb9NqXKERnd8N+fs7CM4yauTmldCM7Kg==
X-Received: by 2002:a5d:64e3:0:b0:391:4889:503e with SMTP id ffacd0b85a97d-3914889519cmr2493656f8f.33.1741599489271;
        Mon, 10 Mar 2025 02:38:09 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb7aefsm14111154f8f.20.2025.03.10.02.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 02:38:07 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:38:05 +0100
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
Subject: [PATCH v3 5/8] sched/topology: Remove redundant dl_clear_root_domain
 call
Message-ID: <Z86y_ebAmhSaND09@jlelli-thinkpadt14gen4.remote.csb>
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

We completely clean and restore root domains bandwidth accounting after
every root domains change, so the dl_clear_root_domain() call in
partition_sched_domains_locked() is redundant.

Remove it.

Reviewed-by: Waiman Long <llong@redhat.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
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


