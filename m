Return-Path: <cgroups+bounces-6089-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BB7A09639
	for <lists+cgroups@lfdr.de>; Fri, 10 Jan 2025 16:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D8C188E48B
	for <lists+cgroups@lfdr.de>; Fri, 10 Jan 2025 15:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF285212D88;
	Fri, 10 Jan 2025 15:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBRz/Kx+"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34BB211A2F
	for <cgroups@vger.kernel.org>; Fri, 10 Jan 2025 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736523921; cv=none; b=Mp29V8DDCn1ZciKUHyIYaRdzzfC4I3YEnTOhdUzhgmbbUFBWlFM/Tqb+bIxCHQGHwdnKVaO8Z0peRaQVXV7tWthd7skKWr1L5yQvFzQtUwBP/LhJh6LebgRWVaCalIvf9lsMy2Kh43urafZC89qfFs/7Wu3DLOKqqchcDNVM/1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736523921; c=relaxed/simple;
	bh=Cvzf6PuulWAVQx4MERWU4qNpmFpzckKnUbUUjm7tSuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2f2BRM8pVU4LS5VOtQ8/w1c5cXDUOELFBHVZahH7R/EP6RsWwYbittZsxE163O2jMJ4uv7xYnJF8ic/lpL2uP4YognQqInSbVD5ZxKWtT1hMfVjUIz+Piwi2NU6ieC5miLUECLO5zeU8DaOZ/fpHt1NgSdw6RrsYYG6WYsvTvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RBRz/Kx+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736523918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5z9OBzc9iSRfWm9qMeZ19ILH/+scSAfJCQBDndG0wl8=;
	b=RBRz/Kx+XcI74rMaGJdv7ob4PSenVAt5P2xfjthrIEL9VdtxQj9s6GyMjbVttzDQZeJNFM
	6j4dxj+vVfz6qcjeQP8yY1u2M+eHsSa0/9wlGhBz9EvZR3URSqRCBIoLD4Fs/8uOm977ba
	fW+T7pDjCfU27usc6U8I9h8p7LNwxRA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-4-cDFXtqPJaZpCP0zpt0Fw-1; Fri, 10 Jan 2025 10:45:16 -0500
X-MC-Unique: 4-cDFXtqPJaZpCP0zpt0Fw-1
X-Mimecast-MFC-AGG-ID: 4-cDFXtqPJaZpCP0zpt0Fw
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b6e241d34eso325887885a.0
        for <cgroups@vger.kernel.org>; Fri, 10 Jan 2025 07:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736523915; x=1737128715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5z9OBzc9iSRfWm9qMeZ19ILH/+scSAfJCQBDndG0wl8=;
        b=W/DbqxUhMgU9suBvV9DO/TZ/IcCfXc2FKgz9yqLYGP0sGad6SvZQ68GVjUW6F4F4Yt
         Z8srn9jZssbbQwdcKdQInTHLBygA2UWVSnTsMKj7EGLFe3Vtfu9aQRgneDaeQPzd8/vV
         DZIvdmKTje6Wxptn/dlOZmqZq7+2uf5F2WHKMHBVkSCnymUWBX9ho/eS5p6czl/GwBwy
         2jdnQtOinQ+Rr5JuAJfs0zOCFwuCy9/AAID0NdY689DyVSojpVkfKP9/rbjsBq3hfvy1
         BJxKNrHlM0wrWrz6CscUefbuWTBpzMdPzEX02OrY2z4Jno7e3MQy8JQJ1H9gg15ue7g/
         5XWw==
X-Forwarded-Encrypted: i=1; AJvYcCWTxGCWTH8MXaKw52z5dzwOj5nUNrSCTJ85Uaqg0Dwy3BAlaketutCUvRUyvj6EALkOO4SQXNDM@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk0nCNkdEsL/2HOktXsDfQs8ND0TK0fXQKAJooi+5vU5ihaEZm
	4T9BXoReoKEW2Qs5SydLTzn5t2ZUiPIGGmTPy6hpj7hTLmHCXuZyfhDTur/a1D55iUF9tgSlY64
	ndHDk07R0cIZchdbCeJxBrkhrufQH6Q16l2uKBbdi5jl/VPqJESP22cw=
X-Gm-Gg: ASbGncvJLJ3inxlbDaI7VuQ9h6UJRHV+DubAyGcHZfr6foMH/zlQPIWCi2GI3AAToA5
	MknH1xstohssdFfgr2DMEk9XyfCYo3rHm91fHsgurwYffahoFaM62Mxe2/I1J3KrKQGiHmDcc1X
	tFYa8q5YVRqZFFvzp9Ak5xnJv7R1Ic330gkfWi0FAZ/EeOeypLodJypn+h1zkgBXC+dpLFyj/wq
	R2Mvhe/ZJAzZGdyi1Sfr9la9HYBF9Vhn60o2UDfgox1XnKlkS5g4jK9YAcGDbjVqETJutNf5/CF
	TS47XijMJg==
X-Received: by 2002:a05:620a:7207:b0:7bc:db11:4951 with SMTP id af79cd13be357-7bcdb114dd5mr1416503785a.48.1736523915525;
        Fri, 10 Jan 2025 07:45:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPzD8fYBKzXAbtv3fhWySvLFCusA2JljqcdQCmxxJLeMLNNBsjLqbbmB0FFit/UgirxU5aDg==
X-Received: by 2002:a05:620a:7207:b0:7bc:db11:4951 with SMTP id af79cd13be357-7bcdb114dd5mr1416499885a.48.1736523915202;
        Fri, 10 Jan 2025 07:45:15 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.92.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce324828esm183203985a.45.2025.01.10.07.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 07:45:14 -0800 (PST)
Date: Fri, 10 Jan 2025 16:45:08 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Phil Auld <pauld@redhat.com>, Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
Message-ID: <Z4FAhF5Nvx2N_Zu6@jlelli-thinkpadt14gen4.remote.csb>
References: <20241114142810.794657-1-juri.lelli@redhat.com>
 <ZzYhyOQh3OAsrPo9@jlelli-thinkpadt14gen4.remote.csb>
 <Zzc1DfPhbvqDDIJR@jlelli-thinkpadt14gen4.remote.csb>
 <ba51a43f-796d-4b79-808a-b8185905638a@nvidia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba51a43f-796d-4b79-808a-b8185905638a@nvidia.com>

Hi Jon,

On 10/01/25 11:52, Jon Hunter wrote:
> Hi Juri,
> 

...

> I have noticed a suspend regression on one of our Tegra boards and bisect is
> pointing to this commit. If I revert this on top of -next then I don't see
> the issue.
> 
> The only messages I see when suspend fails are ...
> 
> [   53.905976] Error taking CPU1 down: -16
> [   53.909887] Non-boot CPUs are not disabled
> 
> So far this is only happening on Tegra186 (ARM64). Let me know if you have
> any thoughts.

Are you running any DEADLINE task in your configuration?

In any case, could you please repro with the following (as a start)?
It should print additional debugging info on the console.

Thanks!
Juri

---
 kernel/sched/deadline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 62192ac79c30..77736bab1992 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3530,6 +3530,7 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 		 * dl_servers we can discount, as tasks will be moved out the
 		 * offlined CPUs anyway.
 		 */
+		printk_deferred("%s: cpu=%d cap=%lu fair_server_bw=%llu total_bw=%llu dl_bw_cpus=%d\n", __func__, cpu, cap, fair_server_bw, dl_b->total_bw, dl_bw_cpus(cpu));
 		if (dl_b->total_bw - fair_server_bw > 0) {
 			/*
 			 * Leaving at least one CPU for DEADLINE tasks seems a


