Return-Path: <cgroups+bounces-6493-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD0EA2F734
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 19:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746693A42BF
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 18:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB3C25744E;
	Mon, 10 Feb 2025 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Eqq0fv/E"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3447255E4C
	for <cgroups@vger.kernel.org>; Mon, 10 Feb 2025 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212507; cv=none; b=Zp3E2X/qrlibDdpKEq+zVywYwFkTUBTqwXoI6H1DW8uc24DQmQ9NKji683L9+9bGG/gdUrdmi2WiDdy8Rf15QBVP87DUfymurQDDgdWCClYC2auVrj2Ei2eQSKEx2ykDG99DCstaWSab3fHwm4xvKleK5eoByvMJkrqFwDn2GW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212507; c=relaxed/simple;
	bh=zWuoo7ND2Cayr7LKqH469oOc4M8MkwV//oIaGZjQhm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWqerxNjwIRUMIYWjzKV4Qxp0ZAIOesqHjXBsiljKnIwcOWmAj8YKu5pYfpYlqjAx/d+duI3QJH8trtZ3mbIL9s2a8quFMYFjYOcgE0fQqsGlRV7sUrbLYm8bzkmP09DhLV7s5wCu95QMcKR/yRFaB02vZbhVkr0byTodaq2P6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Eqq0fv/E; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 10 Feb 2025 10:34:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739212501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Px6n4/iF3ATy1tkEKiiYXPtCS0uyJnLM3LWN0RZhHL8=;
	b=Eqq0fv/EZqZxres6gXvwinFpZxvxoAbVnSYhy/hOzYIeULRrCalvzQY8wdrpNDLwQReVpz
	qhKuOIIHVO/vQnzJEhcb+aYrzKJQC7n3mi2fMRb0VdpW4j3MLoC00YTmnAxqtyeHapkPwS
	SrJNH6alGGJKnHKCG7ULeUTw9Xpdgxk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: "T.J. Mercier" <tjmercier@google.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: add hierarchical effective limits for v2
Message-ID: <j2qxkp3tjq7yenl3tkjisaxry7aqdwaxlpx7rn7mpkdi7fkf2c@xva7vgzspb2p>
References: <20250205222029.2979048-1-shakeel.butt@linux.dev>
 <mshcu3puv5zjsnendao73nxnvb2yiprml7aqgndc37d7k4f2em@vqq2l6dj7pxh>
 <ctuqkowzqhxvpgij762dcuf24i57exuhjjhuh243qhngxi5ymg@lazsczjvy4yd>
 <5jwdklebrnbym6c7ynd5y53t3wq453lg2iup6rj4yux5i72own@ay52cqthg3hy>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5jwdklebrnbym6c7ynd5y53t3wq453lg2iup6rj4yux5i72own@ay52cqthg3hy>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 10, 2025 at 05:24:17PM +0100, Michal Koutný wrote:
> Hello.
> 
> On Thu, Feb 06, 2025 at 11:09:05AM -0800, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > Oh I totally forgot about your series. In my use-case, it is not about
> > dynamically knowning how much they can expand and adjust themselves but
> > rather knowing statically upfront what resources they have been given.
> 
> From the memcg PoV, the effective value doesn't tell how much they were
> given (because of sharing).
> 
> > More concretely, these are workloads which used to completely occupy a
> > single machine, though within containers but without limits. These
> > workloads used to look at machine level metrics at startup on how much
> > resources are available.
> 
> I've been there but haven't found convincing mapping of global to memcg
> limits.
> 
> The issue is that such a value won't guarantee no OOM when below because
> it can be (generally) effectively shared.
> 
> (Alas, apps typically don't express their memory needs in units of
> PSI. So it boils down to a system wide monitor like systemd-oomd and
> cooperation with it.)
> 

I think you missed the static partitioning of resources use-case I
mentioned. The issue you are pointing exist for the system level metrics
as well i.e. a worklod looking at system metrics can't say how much they
are given but in my specific case, the workloads know they occupy the
full machine. Now we want to move such workloads to multi-tenant
environment but the resources are still statically partitioned and not
overcommitted, so effective limit will tell how much they are given.

> > Now these workloads are being moved to multi-tenant environment but
> > still the machine is partitioned statically between the workloads. So,
> > these workloads need to know upfront how much resources are allocated to
> > them upfront and the way the cgroup hierarchy is setup, that information
> > is a bit above the tree.
> 
> FTR, e.g. in systemd setups, this can be partially overcome by exposed
> EffectiveMemoryMax= (the service manager who configures the resources
> also can do the ancestry traversal).
> kubernetes has downward API where generic resource info is shared into
> containers and I recall that lxcfs could mangle procfs
> memory info wrt memory limits for legacy apps.
> 
> 
> As I think about it, the cgroupns (in)visibility should be resolved by
> assigning the proper limit to namespace's root group memory.max (read
> only for contained user) and the traversal...
> 

I think here your point is why not have userspace based solution. I
think it is possible but not convenient and adds an external dependency
in the workload.

> 
> On Thu, Feb 06, 2025 at 11:37:31AM -0800, "T.J. Mercier" <tjmercier@google.com> wrote:
> > but having a single file to read instead of walking up the
> > tree with multiple reads to calculate an effective limit would be
> > nice.
> 
> ...in kernel is nice but possible performance gain isn't worth hiding
> the shareability of the effective limit.
> 
> 
> So I wonder what is the current PoV of more MM people...

Yup, let's see more opinion on this.

Thanks Michal for your feedback.

