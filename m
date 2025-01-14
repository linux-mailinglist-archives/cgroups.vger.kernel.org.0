Return-Path: <cgroups+bounces-6141-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FF7A10CC3
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 17:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB9E3A60C7
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 16:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07BF1F9AA5;
	Tue, 14 Jan 2025 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TIg/Kz39"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466431B87C6
	for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736873662; cv=none; b=NPrfL1hejN0GbtiwOVGgD+ClwyIpQ470HDhn4D/iyp2vu07cjJhXSEUHzckSIv4hETTkRpvhX+dOS0dX4sE11edg7fQtr7Q8SBi6Mm1w7Y1lCo9C7fvkaCX8zzhz45wHf78+qaELMdz0lALRHeMyP4NjndSbphNBuMICOgeQnxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736873662; c=relaxed/simple;
	bh=QArxDshYBXXjPsSxBkOjDge7ebuo2qKnIT/yKZpkdfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aALJKHw0phB5WYqms2VOLCHZIOy8QHMXaUlU73WCheqp8XFYtMt6qrJRSFb13KFlvg+o07+KTjdCAZJeBsiyKlebVVgU8oAQuJGFJhkZlde0njpZl2pX9/toBHkK9DvlERGFsh93wQnRL7NL0WVKV7norc6jT+FqJ6nGCU2AbA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TIg/Kz39; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaf60d85238so1047688366b.0
        for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 08:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736873657; x=1737478457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LsRaccHvZKr6FJzMPGUpANQeurIQy5ZJPHMSFpAg7jM=;
        b=TIg/Kz39NGsfDd40XUVlW5h5e5ETYRuO2BuD6fD7buF1Fo2Xa9trrTRee/0jeQB6qg
         TWfo+/myhOFeozAiWg3HzD0KML8LunfygVaTkaXMXLifS2OCy46IXSg89m5nKoyRQskx
         1bT+Eg2ChcV3OXQpYAruXPu6rEJ9B+gijCPbAB3VCEqzsKmz98ttSMsrf0WtpmrxBHzp
         VkoJBiRTtwlgI34feP4KN8J7vE3/GWPR445OWKyAfQKfhNIHWY6oc9qFX9kCNw4KSXLc
         w9bMXBQbqLxKE0ipV6bEUGOxNG1BIY9i59K3n7ik5QOaJFDDzRYdprtXQSk2rhVksavq
         1dXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736873657; x=1737478457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LsRaccHvZKr6FJzMPGUpANQeurIQy5ZJPHMSFpAg7jM=;
        b=DqFZ4LY0VHqRM7WvtaQm+rLBwFYDx50Lqwm2ItsCK8jr7GJgma9MsovSLCLpZ4iYpP
         hSOjXPtmeEWNoOdbsrKdMYAZ6d2raSwK5l9tg639A2l9TZ3rjQkOKn7bFc1VIXFZrgsu
         eg26ZXRd+rIQ8Rf074uZDc7xuUvtbhnF8dG3EnjWZ662XYB/oovpKHHqBtycq7u1//1+
         MujlqMJcS9wgOV7TkdbAVq1TIJumJvOHVCiY5uQwXEZpeV+snkvziedOoooliUm5w9k/
         nsYNoySqpyfrpGmak8ruwwuVqVO69rq+ebouB8smPtMAnEKIiuESzuxPuDbGH2tKbCQJ
         xIbw==
X-Forwarded-Encrypted: i=1; AJvYcCX0DYcTe2wJokqCvwiy4aZvDjp8sWCQn9BWMYApBVZcTgAdkjF+pC93hfBMa0WCyvIr+FmYXdto@vger.kernel.org
X-Gm-Message-State: AOJu0YwAMeMfLYMULMJ0CcJ+cbtP48iMR47Erg/4qe5mod4dQnY6G6Ck
	Nvx324uzmdNnUO5cU7rnj/nQJmptGneteLCPtJmsBN92DV2do8SjO7ZtXN9foqs=
X-Gm-Gg: ASbGncsHLAFQMiN3on0sLfeouOtjiTU2UZ3bDRKTn1DRbsmItLD2bplKs1PPktAB7Tm
	sal7i7YelcxQjvcctJiY7rmajnFvkNmbmZ0bYj12hTOmYWXrCno1UNDkETMGn+w0Pv7UTWCjSm3
	NgKbND6rcbyT5uzUT0dMwyhgDtOK+izqJ5Rd4QKnx5mJmw9hgKnMIq3SHAklt5S+ups03lW3AH5
	+DwePXkmL1u8gl+G4OFrqAT5uyDgQldOp37CcgDZZ/iD0vGVcTRsqqJhaRo77aqmshzCw==
X-Google-Smtp-Source: AGHT+IE82dJIBD1oYsvhQ/wbzxr9AzjVtFcZvJeySe4F0GuPIoDu+lt8hhocCPFRA+YHPmI6489vFw==
X-Received: by 2002:a17:907:97d2:b0:aab:73c5:836 with SMTP id a640c23a62f3a-ab2ab711bfemr2444968566b.32.1736873657580;
        Tue, 14 Jan 2025 08:54:17 -0800 (PST)
Received: from localhost (109-81-90-202.rct.o2.cz. [109.81.90.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9904a4132sm6453355a12.75.2025.01.14.08.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 08:54:17 -0800 (PST)
Date: Tue, 14 Jan 2025 17:54:16 +0100
From: Michal Hocko <mhocko@suse.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Rik van Riel <riel@surriel.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	hakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Nhat Pham <nphamcs@gmail.com>
Subject: Re: [PATCH v2] memcg: allow exiting tasks to write back data to swap
Message-ID: <Z4aWuD_-BkcEjvj7@tiehlicka>
References: <20241212115754.38f798b3@fangorn>
 <CAJD7tkY=bHv0obOpRiOg4aLMYNkbEjfOtpVSSzNJgVSwkzaNpA@mail.gmail.com>
 <20241212183012.GB1026@cmpxchg.org>
 <Z2BJoDsMeKi4LQGe@tiehlicka>
 <20250114160955.GA1115056@cmpxchg.org>
 <Z4aU7dn_TKeeTmP_@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4aU7dn_TKeeTmP_@tiehlicka>

On Tue 14-01-25 17:46:39, Michal Hocko wrote:
> On Tue 14-01-25 11:09:55, Johannes Weiner wrote:
> > Hi,
> > 
> > On Mon, Dec 16, 2024 at 04:39:12PM +0100, Michal Hocko wrote:
> > > On Thu 12-12-24 13:30:12, Johannes Weiner wrote:
> [...]
> > > > If we return -ENOMEM to an OOM victim in a fault, the fault handler
> > > > will re-trigger OOM, which will find the existing OOM victim and do
> > > > nothing, then restart the fault.
> > > 
> > > IIRC the task will handle the pending SIGKILL if the #PF fails. If the
> > > charge happens from the exit path then we rely on ENOMEM returned from
> > > gup as a signal to back off. Do we have any caller that keeps retrying
> > > on ENOMEM?
> > 
> > We managed to extract a stack trace of the livelocked task:
> > 
> > obj_cgroup_may_swap
> > zswap_store
> > swap_writepage
> > shrink_folio_list
> > shrink_lruvec
> > shrink_node
> > do_try_to_free_pages
> > try_to_free_mem_cgroup_pages
> 
> OK, so this is the reclaim path and it fails due to reasons you mention
> below. This will retry several times until it hits mem_cgroup_oom which
> will bail in mem_cgroup_out_of_memory because of task_is_dying (returns
> true) and retry the charge + reclaim (as the oom killer hasn't done
> anything) with passed_oom = true this time and eventually got to nomem
> path and returns ENOMEM.  SUSE Labs

Btw. is there any actual reason why we cannot go nomem without going
to the oom killer (just to bail out) and go through the whole cycle
again? That seems arbitrary and simply burning a lot of cycle without
much chances to make any better outcome

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7b3503d12aaf..eb45eaf0acfc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2268,8 +2268,7 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (gfp_mask & __GFP_RETRY_MAYFAIL)
 		goto nomem;
 
-	/* Avoid endless loop for tasks bypassed by the oom killer */
-	if (passed_oom && task_is_dying())
+	if (task_is_dying())
 		goto nomem;
 
 	/*
-- 
Michal Hocko
SUSE Labs

