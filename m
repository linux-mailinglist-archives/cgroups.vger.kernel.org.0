Return-Path: <cgroups+bounces-10726-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D7CBD95D5
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 14:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0F03A539A
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 12:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61085313E03;
	Tue, 14 Oct 2025 12:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ex+R3y//"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118C730C371;
	Tue, 14 Oct 2025 12:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445352; cv=none; b=ilgK6zH0AtT58u537RTFowaxi0C86GJj/VN2SGc39YXEw9wgGgzHzfsQSzU0l+ILCF0mU97IMpaAmIhL2w66/7Oj0dUkOzBt49LH6byFFihMYCcYk6Ii7FSSmSuKsxizBNH02M4Vm3RQN6nZbu0O1uviQedg2+RLf2EYrGc4RVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445352; c=relaxed/simple;
	bh=veFrev4WHDqJr8PvwptdqQ0qevY7NBnf6uVDF8KwJvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxmTxoxjML0O3WpvgiLc3Rlkh8W/6MwJ80l5McQjRg52Z3AJeqyzk9+pDR9Jd7dEUyCKX0/Tgc+1aAHdP7KBbp2P1xVFH/IuG+U7MNj1Gp4V5rJo9L94Em2SeyfX6x4DoT/VbJSlKlDRirutcIWdNhXIadbSr0DxvLNPcYy9Qcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ex+R3y//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613B6C4CEE7;
	Tue, 14 Oct 2025 12:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760445351;
	bh=veFrev4WHDqJr8PvwptdqQ0qevY7NBnf6uVDF8KwJvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ex+R3y//T9kDG4MIndwspLzW9Vx5zWHgE/EaFVi2WPfvoDb9Wm53ZgK3WweiF8OFR
	 UUpPSvNXvWaVMMSpa2NFfFoaYru8wVeUVp9LWCfqdK4O6GNUzIU3ucGrpMQufywb47
	 kOIrAwSVguW0XyImU4o61QWE8OzcAoMP5nF5hHqTTSVn/s4CFrSlHrUfEukcVzsd7q
	 KdYC4RfDc08pweMnxmXVaFZYxFRHfmp2XAIaBzqAfakhF25hwmpiq40lUfIiv+6zWC
	 FcLWsoZRYCArglDakt8a2zEa8ZDsd246egHvmkRQV9YE36MTf7aguEqQQhhipNbJvY
	 GuHfp8lhzzwuQ==
Date: Tue, 14 Oct 2025 13:35:43 +0100
From: Simon Horman <horms@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
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
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 30/33] kthread: Add API to update preferred affinity on
 kthread runtime
Message-ID: <aO5Dn2AwQWn0SQKQ@horms.kernel.org>
References: <20251013203146.10162-1-frederic@kernel.org>
 <20251013203146.10162-31-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013203146.10162-31-frederic@kernel.org>

On Mon, Oct 13, 2025 at 10:31:43PM +0200, Frederic Weisbecker wrote:

...

> @@ -900,6 +899,46 @@ int kthread_affine_preferred(struct task_struct *p, const struct cpumask *mask)
>  }
>  EXPORT_SYMBOL_GPL(kthread_affine_preferred);
>  
> +/**
> + * kthread_affine_preferred_update - update a kthread's preferred affinity
> + * @p: thread created by kthread_create().
> + * @cpumask: new mask of CPUs (might not be online, must be possible) for @k
> + *           to run on.

nit: @mask: ...

Likewise for the documentation of kthread_affine_preferred()
in a subsequent patch in this series.

> + *
> + * Update the cpumask of the desired kthread's affinity that was passed by
> + * a previous call to kthread_affine_preferred(). This can be called either
> + * before or after the first wakeup of the kthread.
> + *
> + * Returns 0 if the affinity has been applied.
> + */
> +int kthread_affine_preferred_update(struct task_struct *p,
> +				    const struct cpumask *mask)

...

