Return-Path: <cgroups+bounces-4834-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2979744AE
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 23:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF0591C23C97
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 21:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776111AAE27;
	Tue, 10 Sep 2024 21:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJf4199l"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB94176FCF;
	Tue, 10 Sep 2024 21:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726003071; cv=none; b=XWKzjxHcZwhoWJR53TaFBO2oL/+hF/F2TuyXr83237htV+3TICBHmPQ0jnGm+n8hzcPhL8We+0q/poFEpvQoLh1WMqrnSSpQjCC/Y1JQThoO8gEFLYi4gdV02oLCUlHTEl50SdtB8n475jONShhPYq13UNwytvfKrgsucySoPp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726003071; c=relaxed/simple;
	bh=P0Hk/iCMM4k/FoA5zYdNDZbQLjR5F1uujVoLBkg1iec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8yR6b+wCKZP0zxFbmTvW6kAkU9ggCQm9bvaY4TAOjHHVW6jL6+WvZ93tnWuIY3viEri8iBbYggTPvORxW621kWucB8mWWwMBEvVhD45FXMxSWn6sZ+bthLIcyRicah+tZ2sYJWK/+M+urhdzWLPdgIF0PevZNn00He84+7TqYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJf4199l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F815C4CEC3;
	Tue, 10 Sep 2024 21:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726003070;
	bh=P0Hk/iCMM4k/FoA5zYdNDZbQLjR5F1uujVoLBkg1iec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hJf4199lFxM1fkMHeCsiI6ugm1lrdazW8wCmGVDtYgOZRpi6outrx+6eXxi2X5Rid
	 vicHg8V3TIAK94jnPkbGxuCI0Cz9wizeiCT/YMbY+AHvA3+2ljb/IHJKVH1USVvE6v
	 7wG31a02zWZccyFKV4rPj6L/+eFp3+h3qyQkJdKIhjtFNixG9hYvhNkDFxirU3jJcz
	 I2ikdfytM58KmLE36rxCkN/KL57+N+5n9HBJ037QeGgV41ORjmRclqHy+pUrRs2DiY
	 W5n6ONZseSswCqMQVYm9rSo2PwjdPq0OvDnP7XydUmFpLdMi6Wn7quZwRam1M0xndC
	 BgoxnwjuzR8wg==
Date: Tue, 10 Sep 2024 11:17:49 -1000
From: Tejun Heo <tj@kernel.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Chen Ridong <chenridong@huaweicloud.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Chen Ridong <chenridong@huawei.com>, martin.lau@linux.dev,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, bpf@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] cgroup: fix deadlock caused by cgroup_mutex and
 cpu_hotplug_lock
Message-ID: <ZuC3femqBNufgX1D@slm.duckdns.org>
References: <20240817093334.6062-1-chenridong@huawei.com>
 <20240817093334.6062-2-chenridong@huawei.com>
 <kz6e3oadkmrl7elk6z765t2hgbcqbd2fxvb2673vbjflbjxqck@suy4p2mm7dvw>
 <07501c67-3b18-48e3-8929-e773d8d6920f@huaweicloud.com>
 <ZuC0A98pxYc3TODM@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuC0A98pxYc3TODM@google.com>

On Tue, Sep 10, 2024 at 09:02:59PM +0000, Roman Gushchin wrote:
...
> > > By that reasoning any holder of cgroup_mutex on system_wq makes system
> > > susceptible to a deadlock (in presence of cpu_hotplug_lock waiting
> > > writers + cpuset operations). And the two work items must meet in same
> > > worker's processing hence probability is low (zero?) with less than
> > > WQ_DFL_ACTIVE items.
> 
> Right, I'm on the same page. Should we document then somewhere that
> the cgroup mutex can't be locked from a system wq context?
> 
> I think thus will also make the Fixes tag more meaningful.

I think that's completely fine. What's not fine is saturating system_wq.
Anything which creates a large number of concurrent work items should be
using its own workqueue. If anything, workqueue needs to add a warning for
saturation conditions and who are the offenders.

Thanks.

-- 
tejun

