Return-Path: <cgroups+bounces-7777-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B33D1A99D86
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 02:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7BD71946953
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 00:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D4D70838;
	Thu, 24 Apr 2025 00:59:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A745E4D8CE;
	Thu, 24 Apr 2025 00:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745456358; cv=none; b=l2LIGsRz7ceZrIbAN+XuKY4TmRsIyecJG8HqxWb1ZjBJcFeKpBB2wKMmc7+jdqv8h2Xc05VZG+Xr8ut5kbkgo2W5/pviO0KO/5ku1+0Ie4EP2TRuJrFhYWidy5t5zTlivPhkr+EM3sMWGNpBLkAczEJtr0LOosSMgJKKUafv3kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745456358; c=relaxed/simple;
	bh=e9wW77GZn7tjk4Ak4YSfc09Z/r/BdOuzhaa1h3GtUcA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kxMEdLrek5VuwkQ4GS9EBLFDxazCXlL+O99D20rjsakWHi1JKvG47AKnyObWkAGeQqVDGEghbh3PPAD6hdPvUL5felwFzaLC53PdC66f9/dhrShlIT00LTX6mupZXhvczPusmLmQnDnpJTbX8752FVwX//4ukznAESIjZpbCbp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F092BC4CEE2;
	Thu, 24 Apr 2025 00:59:14 +0000 (UTC)
Date: Wed, 23 Apr 2025 21:01:08 -0400
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
Message-ID: <20250423210108.5b2452ad@gandalf.local.home>
In-Reply-To: <d3a458d0-5f39-4374-957e-a2a3edf4983a@oracle.com>
References: <20250424000146.1197285-1-libo.chen@oracle.com>
	<20250424000146.1197285-3-libo.chen@oracle.com>
	<20250423201829.17d4c382@gandalf.local.home>
	<d3a458d0-5f39-4374-957e-a2a3edf4983a@oracle.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 17:36:30 -0700
Libo Chen <libo.chen@oracle.com> wrote:

> >> +	TP_fast_assign(
> >> +		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
> >> +		__entry->pid		 = task_pid_nr(tsk);
> >> +		__entry->tgid		 = task_tgid_nr(tsk);
> >> +		__entry->ngid		 = task_numa_group_id(tsk);
> >> +		memcpy(__entry->mem_allowed, mem_allowed_ptr->bits,
> >> +		       sizeof(__entry->mem_allowed));  
> > 
> > Is mem_allowed->bits guaranteed to be the size of BITS_TO_LONGS(MAX_NUM_NODES)
> > in size? If not, then memcpy will read beyond that size.
> >   
> 
> Yes, evidence can be found in the definitions of nodemask_t and DECLARE_BITMAP:
> 
> // include/linux/nodemask_types.h 
> typedef struct { DECLARE_BITMAP(bits, MAX_NUMNODES); } nodemask_t;
> 
> // include/linux/types.h
> #define DECLARE_BITMAP(name,bits) \
> 	unsigned long name[BITS_TO_LONGS(bits)]
> 

Hmm, I wonder then if we should add in TP_fast_assign():

	BUILD_BUG_ON(sizeof(nodemask_t) != BITS_TO_LONGS(MAX_NUM_NODES) * sizeof(long));

-- Steve

