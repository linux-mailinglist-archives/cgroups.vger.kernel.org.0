Return-Path: <cgroups+bounces-7045-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B573FA5FD22
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 18:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9DD173B92
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 17:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212D226A0AD;
	Thu, 13 Mar 2025 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UY0nch8E"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD75201025
	for <cgroups@vger.kernel.org>; Thu, 13 Mar 2025 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885887; cv=none; b=pXj07EIrCAuB/FOmJae3wvidyutgb+tlZeYQ+N+lxWoN0b5rdHIPul2v11l5hds53uW2zSnDD1jnoLs99C+HB4rYzWpzgvMIkTlditAlasuV2j9M/qRohKCkBphuPLyfuXWP6pO5YqzDXwxgMUmsM10sDXMvdiralP4Zx453N0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885887; c=relaxed/simple;
	bh=lb+ZbAQnclNwseWR5txyK6ca+JbKI+Yza7gQXBm7aCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHI9wMd9edEAYv3Kjrv3lkxXwCZW2dWz4Jf8kGHvt1g9PRCVb9U5FIBlgLgrXcick4Ll8sJR/sGRSY9v91+PPKvh61OGjOYcsnpMgUz2eT5/D++hZ0ARM0AndjA8jtckuh8HpgCa1vH3AZ4PAut7z809BCwF3eCFgugXsaYCRis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UY0nch8E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741885885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=toM7pu0/nKvqJbZZIzL7Jc4TbRaykE4Ah5TJhKkkzP8=;
	b=UY0nch8EIGPzRB/BwhNmQ9ChoInF2lGInQWGy2fAO8NEeXMqpG7Y/0mTeEhjc60tE39d86
	EV2cYE3efivO1zrvYK3DGfxTxkUIY4kUiDfHnX7T7OQsRD3QMsxoodPTEAGDyhJ2dDxiJQ
	9/EV7NrNchIH+MLv5FspK4RFz7FyzDw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-nt_nhPafOPCmnw3OktilgQ-1; Thu, 13 Mar 2025 13:11:23 -0400
X-MC-Unique: nt_nhPafOPCmnw3OktilgQ-1
X-Mimecast-MFC-AGG-ID: nt_nhPafOPCmnw3OktilgQ_1741885883
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39135d31ca4so649995f8f.1
        for <cgroups@vger.kernel.org>; Thu, 13 Mar 2025 10:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741885882; x=1742490682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toM7pu0/nKvqJbZZIzL7Jc4TbRaykE4Ah5TJhKkkzP8=;
        b=oFZo1Io5ywSg/ONTzZaJeE4taNXSE6WsVDF88cJtheHix9hR33L2cnDJFlOQx9C7r0
         2l7rC6/F65dTMK/y+BdTGnSQZUWNrbfwxW4eA8TcjWekAuILoKX/s+rjM+an2qgPmb4P
         uqUdUe9WuU4/LI5HOs50+hpc2CWHbKyCFZ3F9tGuK+bTkgF9sMykhRu17KXFBGJpPXtY
         6JHDNMNKmUjr4sFOEkgH1vIhcCrxeVe6MeITzM6qOXzpF5TgmmyAlFw1yqa+Jn7i2k8j
         8AkggvXYu8uvpo3tohjw4UiuMi2uv9uykfAnnJGK5jlLG1uSVpp2ylTN4xxU/z1/hfN5
         Xbkg==
X-Forwarded-Encrypted: i=1; AJvYcCUh5gA38fW/trPZMETWLq+MYWBLxtneS7Bg48t4wkH9MHePk/WCfOzPRUubyugsKroyX5bxoSbD@vger.kernel.org
X-Gm-Message-State: AOJu0YwzulkjzpsMDm9yfDPKqZ7koRBDTZah578iL4bQ3fprjelaknvL
	8zmFYSW6oO5+/QCW/GTUPKSHj8VwFG2MUyN1nMs/JjiDASd9rhGlVV6R3uf+nsUJ4wIFgGh22ml
	DWTYOCEchw11WM68SOc6zt1EyLk1xIvB8bRvH8zD/s71ReIwYnU8vNZo=
X-Gm-Gg: ASbGncv32ulUUq96He4EZmDGMeouv50qLv/xX9qAh9iLuo/1bVbnJaLqf7V9AvL8GFe
	ZAtfcDarO2OE9DrYwQYTnfumLN5sYt5N8nANEdwIiOwnkKokmTV1k7DfxU1fHMAUcHwV56jr/wm
	uGg3MtTAuDJ4fxOsO+zkQZ9dYqbQnQwth9fXxRhhHMSjUy97OApAhZONpKprnwxojbxH1GzKdj1
	bnTjd/45ObZG1RD/eGoc/J5n7qmh1EW78PkeREEp7QGrexWImdVos2GwqnekIhZBuiGs2Pr/mrB
	JqFS1q45tvfmAea1En49zm+x3DNgTPz8sLo9gqaA6U4=
X-Received: by 2002:a05:6000:4026:b0:391:a74:d7e2 with SMTP id ffacd0b85a97d-395b9b10d93mr3353423f8f.26.1741885881879;
        Thu, 13 Mar 2025 10:11:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrw1KHuvAQ5Oit6WEwU940Ut+Qi7Yu7A4vk0V+1jznfYA+D03YAhRUY0Z/WYBn49xltnyVOQ==
X-Received: by 2002:a05:6000:4026:b0:391:a74:d7e2 with SMTP id ffacd0b85a97d-395b9b10d93mr3353290f8f.26.1741885880667;
        Thu, 13 Mar 2025 10:11:20 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a75b0f6sm59705935e9.22.2025.03.13.10.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:11:20 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:11:17 +0100
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
Subject: [PATCH v4 5/8] sched/topology: Remove redundant dl_clear_root_domain
 call
Message-ID: <Z9MRtcX4tz4tcLRR@jlelli-thinkpadt14gen4.remote.csb>
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

We completely clean and restore root domains bandwidth accounting after
every root domains change, so the dl_clear_root_domain() call in
partition_sched_domains_locked() is redundant.

Remove it.

Reviewed-by: Waiman Long <llong@redhat.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
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


