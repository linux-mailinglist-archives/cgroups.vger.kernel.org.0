Return-Path: <cgroups+bounces-10356-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 306DDB91DB2
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 17:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C125189EA19
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 15:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD05F26E711;
	Mon, 22 Sep 2025 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOeJA5W9"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F49F9EC;
	Mon, 22 Sep 2025 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758553837; cv=none; b=d9xVLegXzv2DLBCeNS5fDud+iZVxKXldCi9G37cOma/Bpxd35F7/MMCke+wD/Ybvymo1VDKPhNDit+gMQeiVRFM9Ue1WObBjomB52B6UmVzDGHPYuPypka8O1JAT6jTedkU3K1yV79rGxCLskpg8cJ6Vm/zIQyzD7pkbsb2auzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758553837; c=relaxed/simple;
	bh=JN8oDzMx1WaAixG0/ckzOx5OBDLUH3iItZFLAdr2wko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUjvMIqTh3BrvwkwJtF1K0dBT1fl3YZuHv8leC5DGy1qMnSACf1jh6ac6yjNOk1YNq1twcltJITzUR/oMj0pm5pad2SB1TddO6C9+NnC1ga0na4Atf786RxG1egXXD5+z5jllzf/lQuFx2BtTlJVViRxYF5YhbtS2oCUA4v7hoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOeJA5W9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F984C4CEF0;
	Mon, 22 Sep 2025 15:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758553837;
	bh=JN8oDzMx1WaAixG0/ckzOx5OBDLUH3iItZFLAdr2wko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OOeJA5W9zP0FsNCFmuoLeFacEdE5IgjCqHPfkgpp2uqgBBvwQEhBqgCkpx0J4TW4v
	 4orpeeHRdTBX/eUJgxLL68tYJtbJ5KwU3+SnCpkAgtrvl8yppYA9Hh3EERSSfRSNeV
	 DGB2/baO2jQrD2AVxYSyUvI6V7jzZCZ6z4ECqVNVl1CqrbHRxQM3XRkzlAoTJ2pfiu
	 cmpmOoVL7PdWSwHjN16hc9zdckSG8dW8cz8lizbP/WmoVzFhE4iOPESXQwe5Cvm7ae
	 0A3CbZEAH5hYp/Tw3PPX8W8W/brhdnuoQj44BbUI4cOQJG1LIBNzAwweL0ZWPb8Sg0
	 NTsRSWPkJOslA==
Date: Mon, 22 Sep 2025 17:10:33 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, cgroups@vger.kernel.org
Subject: Re: [PATCH 17/33] cpuset: Propagate cpuset isolation update to
 workqueue through housekeeping
Message-ID: <aNFm6ZhhPpRrguyS@2a01cb069018a81087c6c9b3bf9471d3.ipv6.abo.wanadoo.fr>
References: <20250829154814.47015-1-frederic@kernel.org>
 <20250829154814.47015-18-frederic@kernel.org>
 <197dd0c0-f4cc-4e75-accb-6bf85ea5291d@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <197dd0c0-f4cc-4e75-accb-6bf85ea5291d@redhat.com>

Le Sun, Aug 31, 2025 at 10:51:27PM -0400, Waiman Long a écrit :
> 
> On 8/29/25 11:47 AM, Frederic Weisbecker wrote:
> > --- a/kernel/sched/isolation.c
> > +++ b/kernel/sched/isolation.c
> > @@ -102,6 +102,7 @@ EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
> >   int housekeeping_update(struct cpumask *mask, enum hk_type type)
> >   {
> >   	struct cpumask *trial, *old = NULL;
> > +	int err;
> >   	if (type != HK_TYPE_DOMAIN)
> >   		return -ENOTSUPP;
> > @@ -126,10 +127,11 @@ int housekeeping_update(struct cpumask *mask, enum hk_type type)
> >   	mem_cgroup_flush_workqueue();
> >   	vmstat_flush_workqueue();
> > +	err = workqueue_unbound_exclude_cpumask(housekeeping_cpumask(type));
> >   	kfree(old);
> > -	return 0;
> > +	return err;
> >   }
> 
> Actually workqueue_unbound_exclude_cpumask() expects a cpumask of all the
> CPUs that have been isolated. IOW, all the CPUs that are not in
> housekeeping_cpumask(HK_TYPE_DOMAIN). So we do the inversion here or we
> rename the function to, e.g. workqueue_unbound_cpumask_update() and make the
> change there.

Whoops! Thanks for noticing this.

Thanks.

> Cheers,
> Longman
> 

-- 
Frederic Weisbecker
SUSE Labs

