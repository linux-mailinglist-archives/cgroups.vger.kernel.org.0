Return-Path: <cgroups+bounces-7779-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50474A99E44
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 03:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2355A32DC
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 01:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798D035964;
	Thu, 24 Apr 2025 01:31:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7952701C3;
	Thu, 24 Apr 2025 01:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745458313; cv=none; b=OWge/zMAzUOPzajJonsIWx3iYowbhfGykP45MkgYmADp6kIZQ4st2QRp1WzdfLuXpZfTpPtiGnRfPLKg3UXo0Wid3dPKOV+omsyjgZ4wGuA7iuY+KDHV0buYjNlfqoXOmj2xk01mCc5NT3/dpmN3JeHa3jKlzTRC+wRyndhtFuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745458313; c=relaxed/simple;
	bh=GeW1e6R6JmOltmNiht28rvndvxmDzGRFK32ew+RFDoA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TigHh+KAe9Tfl8BNq5R8/wI1ftLi/XC1Fx/+BtHoAxzZQElA5i8kCS+zAqE6BDNyPJQ/npkkLBjQqJlLRZhekgIiCr8ISEVTnQff6st566Cxqce8ZXbZTjaDvtcutD6iwdAaN73TMJ5gk4eOdge4xrgd4cVcPZF6VkgKob8lyOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3FEC4CEE2;
	Thu, 24 Apr 2025 01:31:50 +0000 (UTC)
Date: Wed, 23 Apr 2025 21:33:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Libo Chen <libo.chen@oracle.com>
Cc: akpm@linux-foundation.org, peterz@infradead.org, mgorman@suse.de,
 mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 tj@kernel.org, llong@redhat.com, sraithal@amd.com, venkat88@linux.ibm.com,
 kprateek.nayak@amd.com, raghavendra.kt@amd.com, yu.c.chen@intel.com,
 tim.c.chen@intel.com, vineethr@linux.ibm.com, chris.hyser@oracle.com,
 daniel.m.jordan@oracle.com, lorenzo.stoakes@oracle.com, mkoutny@suse.com,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] sched/numa: Add tracepoint that tracks the
 skipping of numa balancing due to cpuset memory pinning
Message-ID: <20250423213343.6c5dd621@gandalf.local.home>
In-Reply-To: <752119fe-b5fc-473e-8968-0b4a5ef34d3b@oracle.com>
References: <20250424000146.1197285-1-libo.chen@oracle.com>
	<20250424000146.1197285-3-libo.chen@oracle.com>
	<20250423201829.17d4c382@gandalf.local.home>
	<d3a458d0-5f39-4374-957e-a2a3edf4983a@oracle.com>
	<20250423210108.5b2452ad@gandalf.local.home>
	<752119fe-b5fc-473e-8968-0b4a5ef34d3b@oracle.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 18:12:55 -0700
Libo Chen <libo.chen@oracle.com> wrote:

> > Hmm, I wonder then if we should add in TP_fast_assign():
> > 
> > 	BUILD_BUG_ON(sizeof(nodemask_t) != BITS_TO_LONGS(MAX_NUM_NODES) * sizeof(long));
> >   
> 
> to guard against potential changes in nodemask_t definition? 

Correct.

Whenever there's an implicit dependency like this, where if something were
to change it can cause a bug in the kernel, it's always better to have a
build time check to catch it before it becomes an issue.

-- Steve

