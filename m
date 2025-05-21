Return-Path: <cgroups+bounces-8286-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA02ABED64
	for <lists+cgroups@lfdr.de>; Wed, 21 May 2025 10:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5D11696DD
	for <lists+cgroups@lfdr.de>; Wed, 21 May 2025 08:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49DA2356CF;
	Wed, 21 May 2025 08:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="BVjkU+Om"
X-Original-To: cgroups@vger.kernel.org
Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB4E235BF4;
	Wed, 21 May 2025 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747814410; cv=none; b=cQrAEVH8TOgzV+OE+d2DGNQCDWe9lrXPMoAvfj5y95zDFYFey7WBx+RaKRAtGma7SIQrhMkA/kcj1fIGnVS38S9NcYUk6rR6WiffT60EGirxinsObcLlaXKEAyCzVUfnZn8ebPj7TWtc9tFR9olj2GikBGpmy695qTubdhkRS0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747814410; c=relaxed/simple;
	bh=O18BluLzd0V6rN+4d/OuPHmQZQMOEKQe/u9KiGlBwCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIqgDVZ8hyrGdahrj4PNBz+LEUVqxAZHtHjtLdD8lmLiFAiCBJ59osza80BfaCgQGCSNjmJp24BAG+Iqu6edmV5pHzoRpSTKe8Tlik2FJHco8xeSrAAZj+jsLJkrvXVsYMC3v530OcK/1XUcZ5GTxX2QKyPblzIAz/Sykh6YKW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=BVjkU+Om; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1747814407; x=1779350407;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SRSeRZLTM88Xmp2dMNkQnEEMrTwWD8k4Sd+UM3+C5T0=;
  b=BVjkU+OmQDYbgjKbm0KtZV8q14tEUZa/tcvDSQ9+94qn99Q0UY5AWoKy
   jz4Lbb1an94t7v0ZtAfi9HwY0hyEh2L7SBW2oOMHnvClTjCFbA12jp/5T
   dO5WiYtVaT21V80mGo3mN/bBfqUMEfi7qeeRF1oL9ArJR8EZpkpu1mn1G
   HAXLOpllGwvcwTXQNnqflQQGmppX8LGj2+9kTu9N0rK1toCHeajZJCpFf
   UwbXlDC++rNcZljGlvGGaYKs3zBLEsK3eldKAGdTCEVnrK4+rmwO5Hlec
   IRC78VDRDDB3AWzcAezAGkZv0yud4ZaRjcEpm/9TCDBK/7KX2qfL5eXo9
   g==;
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 16:49:56 +0900
X-IronPort-AV: E=Sophos;i="6.15,303,1739804400"; 
   d="scan'208";a="532312397"
Received: from unknown (HELO JPC00244420) ([IPv6:2001:cf8:1:573:0:dddd:6b3e:119e])
  by jpmta-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 16:49:56 +0900
Date: Wed, 21 May 2025 16:49:43 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shinya Takumi <shinya.takumi@sony.com>,
	shashank.mahadasyam@sony.com
Subject: Re: [PATCH v2 3/3] cgroup, docs: cpu controller interaction with
 various scheduling policies
Message-ID: <aC2Fl4DVRbn6bS8H@JPC00244420>
References: <20250520-rt-and-cpu-controller-doc-v2-0-70a2b6a1b703@sony.com>
 <20250520-rt-and-cpu-controller-doc-v2-3-70a2b6a1b703@sony.com>
 <aCzjJp1ovS6kCqHj@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aCzjJp1ovS6kCqHj@slm.duckdns.org>

Hi Tejun,

On Tue, May 20, 2025 at 10:16:38AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, May 20, 2025 at 11:07:47PM +0900, Shashank Balaji via B4 Relay wrote:
> ...
> > +The interaction of a process with the cpu controller depends on its scheduling
> > +policy. We have the following scheduling policies: ``SCHED_IDLE``, ``SCHED_BATCH``,
> > +``SCHED_OTHER``, ``SCHED_EXT`` (if ``CONFIG_SCHED_CLASS_EXT`` is enabled), ``SCHED_FIFO``,
> > +``SCHED_RR``, and ``SCHED_DEADLINE``. ``SCHED_{IDLE,BATCH,OTHER,EXT}`` can be scheduled
> > +either by the fair-class scheduler or by a BPF scheduler::
> > +
> > +    CONFIG_SCHED_CLASS_EXT
> > +    ├─ Disabled
> > +    |   └─ SCHED_{IDLE,BATCH,OTHER} -> fair-class scheduler
> > +    └─ Enabled
> > +        ├─ BPF scheduler disabled
> > +        |   └─ SCHED_{IDLE,BATCH,OTHER,EXT} -> fair-class scheduler
> > +        ├─ BPF scheduler without SCX_OPS_SWITCH_PARTIAL enabled
> > +        |   └─ SCHED_{IDLE,BATCH,OTHER,EXT} -> BPF scheduler
> > +        └─ BPF scheduler with SCX_OPS_SWITCH_PARTIAL enabled
> > +            ├─ SCHED_{IDLE,BATCH,OTHER} -> fair-class scheduler
> > +            └─ SCHED_EXT -> BPF scheduler
> > +
> > +For more details on ``SCHED_EXT``, check out :ref:`Documentation/scheduler/sched-ext.rst. <sched-ext>`
> > +From the point of view of the cpu controller, processes can be categorized as
> > +follows:
> > +
> > +* Processes under the fair-class scheduler
> > +* Processes under a BPF scheduler with the ``cgroup_set_weight`` callback
> > +* Everything else: ``SCHED_{FIFO,RR,DEADLINE}`` and processes under a BPF scheduler
> > +  without the ``cgroup_set_weight`` callback
> > +
> > +Note that the ``cgroup_*`` family of callbacks require ``CONFIG_EXT_GROUP_SCHED``
> > +to be enabled. For each of the following interface files, the above categories
> > +will be referred to. All time durations are in microseconds.
> 
> Can we document the above in sched_ext documentation and point to it from
> here? Documenting sched_ext details here seems a bit out of place and prone
> to becoming stale over time.

Got it. Apart from that, is the content alright? 

> Can you please separate out indentation changes to a separate patch? These
> usually make reviewing tricky.

Got it.

Thank you

Regards,
Shashank

PS: Apologies for any malformed emails. I finally managed to switch from Outlook
to mutt.

