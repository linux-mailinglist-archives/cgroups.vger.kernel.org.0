Return-Path: <cgroups+bounces-11598-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5879C3696C
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 17:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742F4189D829
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 15:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9221D331A47;
	Wed,  5 Nov 2025 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oICOgyYK"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B4232939F;
	Wed,  5 Nov 2025 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358271; cv=none; b=sOec3iH7g/Y8u27Pj9QlH+Omh8hAp/6M0FyOETBprcyPDCjq34p1EyxhA+cfKbZOr5EjgaUQjJzeIF/joCQcEFj8x2vwH5iS7akO8398SFe9VT/qDZYUqTyjgaetPaWVpCOJmqeuvS+UETTL0wmsbpybL7cg4Ez75FlcGP+rhGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358271; c=relaxed/simple;
	bh=QE/o0Mh+dZdKXtnvDA4J2WYsUMjW6VDyfclBimdmgSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d00Q69EQPVOV0tgGcs3BpGsJmrG5h/KlGqa1/7VQR90W42m87m2fxxTh2WDfSyxajd3tonPmWDtqybQ7NNbRFPUzpd9V7uMvb1Mq0vnuvDAoMC/XhUjyXWAmi1PR95kKRMAV5AXaO+IRzWEwL1KOnxG8H4dkcbaTLv/aFhz9F0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oICOgyYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626DAC4CEF5;
	Wed,  5 Nov 2025 15:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762358270;
	bh=QE/o0Mh+dZdKXtnvDA4J2WYsUMjW6VDyfclBimdmgSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oICOgyYKQxTIre82iUXxYQa+v511n78p0LH/55yOrC/qPcixKX87gwddDj+41MvaU
	 udDR3K3EBQpgaowODsG18JDcxc/9Tm00bcjPVXc3wnknNjtgfgAbq406aWeHYZjI5z
	 4uu77joC5oJffXn+3DZusDdh4FUBNZjP+i+b3b0F4GSCsrwLEaBgWDor4d6LqO/29r
	 Pv3KNro8m3YZiHAE2j4eVhzRxEZTXzdKwYbom7E6szRwPYBQga2bH0zXkFLHi9b4jL
	 AJ2ZrrbUyJI3JInBqsQp2I7DwoEBzEHAGOgWbygjatGbYoaDoSc1t79LMgiLlaLprW
	 4ShYMDmkm4j5A==
Date: Wed, 5 Nov 2025 16:57:48 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Phil Auld <pauld@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Simon Horman <horms@kernel.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 13/33] cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset
Message-ID: <aQtz_ODTgiCGS_oB@localhost.localdomain>
References: <20251013203146.10162-1-frederic@kernel.org>
 <20251013203146.10162-14-frederic@kernel.org>
 <20251031125951.GA430420@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251031125951.GA430420@pauld.westford.csb>

Le Fri, Oct 31, 2025 at 08:59:51AM -0400, Phil Auld a écrit :
> > +int housekeeping_update(struct cpumask *mask, enum hk_type type)
> > +{
> > +	struct cpumask *trial, *old = NULL;
> > +
> > +	if (type != HK_TYPE_DOMAIN)
> > +		return -ENOTSUPP;
> > +
> > +	trial = kmalloc(sizeof(*trial), GFP_KERNEL);
> > +	if (!trial)
> > +		return -ENOMEM;
> > +
> > +	cpumask_andnot(trial, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT), mask);
> > +	if (!cpumask_intersects(trial, cpu_online_mask)) {
> > +		kfree(trial);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!housekeeping.flags)
> > +		static_branch_enable(&housekeeping_overridden);
> > +
> > +	if (!(housekeeping.flags & BIT(type)))
> > +		old = housekeeping_cpumask_dereference(type);
> > +	else
> > +		WRITE_ONCE(housekeeping.flags, housekeeping.flags | BIT(type));
> 
> Isn't this backwards?   If the bit is not set you save old to free it
> and if the bit is set you set it again.

That's completely backward!

Thanks for pointing out!

-- 
Frederic Weisbecker
SUSE Labs

