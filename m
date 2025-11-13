Return-Path: <cgroups+bounces-11931-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF97C58E45
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 17:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 143A835BACE
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 16:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D93432860F;
	Thu, 13 Nov 2025 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEqDUXP6"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024553557E5;
	Thu, 13 Nov 2025 16:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051131; cv=none; b=hNNCjJA9ENRZ8/O6wESjeCWb/RBDzd3XJc9qj232VFpPrvHRKozSqYxnp1MfdPpFvFGQjo9mZbui9QE8PXPKJcafQXYL+xlvqBcKmdX7FYpHHOq6fjJHJxXTO+f6utY4Q9fr533cHasPIPuYeCqPk4aQaV1BlxlREhyTgiOW+B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051131; c=relaxed/simple;
	bh=WRc7MydUv0wNN3JkqWZCJa7Tzlz/EDsLRtKUuSg1bNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwpa0zOOvb5MlTB9EjGa57RrHCKf9upb5PQJ0Uj08OClGCv+VkhwJKP6tjiyG+PZ+jQiq5JJWGG+E0qTrc0+27zT7ThkwknlNesOt7vPpsnLlFDsC00dlugwi9mfypCauHOwlCG8YTaLYX2r1TX9s+OHU/mZoikptKqVrP3gBzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEqDUXP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F828C4CEF7;
	Thu, 13 Nov 2025 16:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051130;
	bh=WRc7MydUv0wNN3JkqWZCJa7Tzlz/EDsLRtKUuSg1bNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OEqDUXP6amzJSpmUNo+qIV1EKEqI7ekUCoKbqJqLHwb0D70FDxwEArQnbnrORc9Eq
	 vscjYTCH6eloR6xpA3BJkKLqIg92bAehzULM/VVwnYzXB5JoVh8VvBfCGOfgW6oGtY
	 /d1auze6xwslOPBsznwNRNaSCNXMHQ3/CDevWYIK8uEvhUQ6mJyt6l6jb8X0DJoLXB
	 DuOZOFPeQ2DdiG4usQr4EPeOmyG9B+SvsnoqTRCJidrHrJUuZiSB/IkJnGX5IvD2we
	 74J55Sb+XuHnLKv3v4MhzbvyNNUbpljIOXYDhdvQ/lWck8K38PwRHFZ1F/SCIk+slV
	 Epjy+9/fn+4mQ==
Date: Thu, 13 Nov 2025 06:25:29 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Waiman Long <llong@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Chen Ridong <chenridong@huawei.com>, Pingfan Liu <piliu@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [cgroup/for-6.19 PATCH] cgroup/cpuset: Make callback_lock a
 raw_spinlock_t
Message-ID: <aRYGeduETy3RPnFK@slm.duckdns.org>
References: <20251112035759.1162541-1-longman@redhat.com>
 <20251112085124.O5dlZ8Og@linutronix.de>
 <318f1024-ba7a-4d88-aac5-af9040c31021@redhat.com>
 <20251113075356.Ix4N-p8X@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113075356.Ix4N-p8X@linutronix.de>

Hello,

On Thu, Nov 13, 2025 at 08:53:56AM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-11-12 13:21:12 [-0500], Waiman Long wrote:
> > On 11/12/25 3:51 AM, Sebastian Andrzej Siewior wrote:
> > > On 2025-11-11 22:57:59 [-0500], Waiman Long wrote:
> > > > The callback_lock is a spinlock_t which is acquired either to read
> > > > a stable set of cpu or node masks or to modify those masks when
> > > > cpuset_mutex is also acquired. Sometime it may need to go up the
> > > > cgroup hierarchy while holding the lock to find the right set of masks
> > > > to use. Assuming that the depth of the cgroup hierarch is finite and
> > > > typically small, the lock hold time should be limited.
> > > We can't assume that, can we?
> > We can theoretically create a cgroup hierarchy with many levels, but no sane
> > users will actually do that. If this is a concern to you, I can certainly
> > drop this patch.
> 
> Someone will think this is sane and will wonder. We usually don't impose
> limits but make sure things are preemptible so it does not matter.

It's always better to be scalable but note that there are cases where the
overhead of nesting can't be hidden completely without significant
sacrifices in other areas and we don't want to overindex on depth
scalability at the cost of practical capabilities. This is also why cgroup
depth is a limited resource controlled by cgroup.max.depth knob.

If something works well with, say, 16 levels of nesting, it's already mostly
acceptable.

Thanks.

-- 
tejun

