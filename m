Return-Path: <cgroups+bounces-10390-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849DBB95336
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 11:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2476A7B566E
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 09:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92068320A08;
	Tue, 23 Sep 2025 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+Te11x9"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD18320A24;
	Tue, 23 Sep 2025 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619031; cv=none; b=ouI/Q8qMkD2L3EesSpcx4V6Kk9zcPScUni3CcJCGXLHChxxrrOscFs60rnfKcDDZbFPD2t6Tg+p/bowQGIzG+NuWhCY3BNb/lMtdW+gddtOAxxB+VCJnDbbhFvkmaPeVjVYkOhgxHZFuBMQ4jf4ZHD2iwvwyTVWa5HdfTrswyIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619031; c=relaxed/simple;
	bh=iJojMmqjXmNM1AROfZxDC8FC4oHqEBcWIRk8sn0CBs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5rkvgT7PNvYXA5lk8Vf0/cVxE2enIdM69JU416Wb6z2YSXNc5O2RK2n4Ayop8+LZmOBEEPDVaNao6H58sGMK/8gywWZvaZ4N71NLAdoerIGQ5pob472L/lRxqm+NAUTmjw8rB0obyW56TgB1YPh2zDvJOKKgm/jtPfXsIgCcdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+Te11x9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1B3C4CEF5;
	Tue, 23 Sep 2025 09:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758619030;
	bh=iJojMmqjXmNM1AROfZxDC8FC4oHqEBcWIRk8sn0CBs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o+Te11x9qAXZtTHxQtqwn2W2os6yeJS1u1MHlfUbnb+JQBNcrAoOgu1pUBHxpQ4Jh
	 TOGRswcnPpBswcIIk8IhPzgSBlPEbA6s4WJzJxKjz/Pxqony/clyu6dEC+uxDfatmw
	 eXgdkXqaA6s9ci7tmQbdYV1iz8cXNvzo1XXc/EPuZDK63ols59iHBFmXlbKCeDOSfE
	 YsRFVtB1Fi017+eLcNEo4YSAM/oR/saka+wk2D7iN8tgzLuZWpZkwACYKGqI0gBv2L
	 DZUM8VP/tDonbooBpL0gZ/6Px+oAsdIreQ6X95Wv6ehoL2i+G/b5XvLoXC2zWTGOZ/
	 ueWWwGjX3BMZA==
Date: Tue, 23 Sep 2025 11:17:07 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org
Subject: Re: [PATCH 26/33] cgroup/cpuset: Fail if isolated and nohz_full
 don't leave any housekeeping
Message-ID: <aNJlk7wcAsPF_j-z@2a01cb069018a810e4ede1071806178f.ipv6.abo.wanadoo.fr>
References: <20250829154814.47015-1-frederic@kernel.org>
 <20250829154814.47015-27-frederic@kernel.org>
 <6457dd87-95cb-4c4d-aaab-6c9b65414a75@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6457dd87-95cb-4c4d-aaab-6c9b65414a75@redhat.com>

Le Tue, Sep 02, 2025 at 11:44:00AM -0400, Waiman Long a écrit :
> 
> On 8/29/25 11:48 AM, Frederic Weisbecker wrote:
> > From: Gabriele Monaco <gmonaco@redhat.com>
> > 
> > Currently the user can set up isolated cpus via cpuset and nohz_full in
> > such a way that leaves no housekeeping CPU (i.e. no CPU that is neither
> > domain isolated nor nohz full). This can be a problem for other
> > subsystems (e.g. the timer wheel imgration).
> > 
> > Prevent this configuration by blocking any assignation that would cause
> > the union of domain isolated cpus and nohz_full to covers all CPUs.
> > 
> > Acked-by: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >   kernel/cgroup/cpuset.c | 57 ++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 57 insertions(+)
> > 
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index df1dfacf5f9d..8260dd699fd8 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -1275,6 +1275,19 @@ static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus
> >   		cpumask_andnot(isolated_cpus, isolated_cpus, xcpus);
> >   }
> > +/*
> > + * isolated_cpus_should_update - Returns if the isolated_cpus mask needs update
> > + * @prs: new or old partition_root_state
> > + * @parent: parent cpuset
> > + * Return: true if isolated_cpus needs modification, false otherwise
> > + */
> > +static bool isolated_cpus_should_update(int prs, struct cpuset *parent)
> > +{
> > +	if (!parent)
> > +		parent = &top_cpuset;
> > +	return prs != parent->partition_root_state;
> > +}
> > +
> >   /*
> >    * partition_xcpus_add - Add new exclusive CPUs to partition
> >    * @new_prs: new partition_root_state
> > @@ -1339,6 +1352,36 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
> >   	return isolcpus_updated;
> >   }
> > +/*
> > + * isolcpus_nohz_conflict - check for isolated & nohz_full conflicts
> > + * @new_cpus: cpu mask for cpus that are going to be isolated
> > + * Return: true if there is conflict, false otherwise
> > + *
> > + * If nohz_full is enabled and we have isolated CPUs, their combination must
> > + * still leave housekeeping CPUs.
> > + */
> > +static bool isolcpus_nohz_conflict(struct cpumask *new_cpus)
> > +{
> > +	cpumask_var_t full_hk_cpus;
> > +	int res = false;
> > +
> > +	if (!housekeeping_enabled(HK_TYPE_KERNEL_NOISE))
> > +		return false;
> > +
> > +	if (!alloc_cpumask_var(&full_hk_cpus, GFP_KERNEL))
> > +		return true;
> > +
> > +	cpumask_and(full_hk_cpus, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
> > +		    housekeeping_cpumask(HK_TYPE_DOMAIN));
> > +	cpumask_andnot(full_hk_cpus, full_hk_cpus, isolated_cpus);
> > +	cpumask_and(full_hk_cpus, full_hk_cpus, cpu_online_mask);
> > +	if (!cpumask_weight_andnot(full_hk_cpus, new_cpus))
> > +		res = true;
> > +
> > +	free_cpumask_var(full_hk_cpus);
> > +	return res;
> > +}
> > +
> >   static void update_housekeeping_cpumask(bool isolcpus_updated)
> >   {
> >   	int ret;
> > @@ -1453,6 +1496,9 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
> >   	if (!cpumask_intersects(tmp->new_cpus, cpu_active_mask) ||
> >   	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
> >   		return PERR_INVCPUS;
> > +	if (isolated_cpus_should_update(new_prs, NULL) &&
> > +	    isolcpus_nohz_conflict(tmp->new_cpus))
> > +		return PERR_HKEEPING;
> >   	spin_lock_irq(&callback_lock);
> >   	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
> > @@ -1552,6 +1598,9 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
> >   		else if (cpumask_intersects(tmp->addmask, subpartitions_cpus) ||
> >   			 cpumask_subset(top_cpuset.effective_cpus, tmp->addmask))
> >   			cs->prs_err = PERR_NOCPUS;
> > +		else if (isolated_cpus_should_update(prs, NULL) &&
> > +			 isolcpus_nohz_conflict(tmp->addmask))
> > +			cs->prs_err = PERR_HKEEPING;
> >   		if (cs->prs_err)
> >   			goto invalidate;
> >   	}
> > @@ -1904,6 +1953,12 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
> >   			return err;
> >   	}
> > +	if (deleting && isolated_cpus_should_update(new_prs, parent) &&
> > +	    isolcpus_nohz_conflict(tmp->delmask)) {
> > +		cs->prs_err = PERR_HKEEPING;
> > +		return PERR_HKEEPING;
> > +	}
> > +
> >   	/*
> >   	 * Change the parent's effective_cpus & effective_xcpus (top cpuset
> >   	 * only).
> > @@ -2924,6 +2979,8 @@ static int update_prstate(struct cpuset *cs, int new_prs)
> >   		 * Need to update isolated_cpus.
> >   		 */
> >   		isolcpus_updated = true;
> > +		if (isolcpus_nohz_conflict(cs->effective_xcpus))
> > +			err = PERR_HKEEPING;
> >   	} else {
> >   		/*
> >   		 * Switching back to member is always allowed even if it
> 
> In both remote_cpus_update() and update_parent_effective_cpumask(), some new
> CPUs can be added to the isolation list while other CPUs can be removed from
> it. So isolcpus_nohz_conflict() should include both set in its analysis to
> avoid false positive. Essentally, if the CPUs removed from the isolated_cpus
> intersect with the nohz_full housekeeping mask, there is no conflict.

I assume this was fixed in latest Gabriele posting?

Thanks.

> 
> Cheers,
> Longman
> 

-- 
Frederic Weisbecker
SUSE Labs

