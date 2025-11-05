Return-Path: <cgroups+bounces-11600-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E00CC36BC3
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 17:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 249D350050A
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 16:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785A933E34D;
	Wed,  5 Nov 2025 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIS7pvJI"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5053385A0;
	Wed,  5 Nov 2025 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359544; cv=none; b=ZC5Vou4/8aptBxYH4NjbbXwfoHwp1MrKLzwYpy+exmj8wGaY51vC+nFB4ihmEAydX/0o76pBL1wMQ5nXXuKgQ6DuJs0n5jTDuCaACtRPe3loLDiHwsT/uoVo4uHaqEiOsuUpj+LVB3TmG5RDJyiCbAmiUmXcI/VMqMSqYhsVERU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359544; c=relaxed/simple;
	bh=NCcAa0pDfh+8ix09a1OPmKTAjDiOwhgcNW3yTAqYn9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5n0Ba6X0UYv+HrNBzZeQexvjTPXUIUG2frkMYE9fjztJaQxJxMMptzQgEaLhlow205XTjSWdpsH5D14i0LWIPMFP1idBD8mWeWoJerlAd/TJngpu9WlW7MzsTpmnV2xWHpAi8RqajXjxQ1UF6va6Z06+gd2z1xY0CDs5Kj40fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIS7pvJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FA7C2BCB0;
	Wed,  5 Nov 2025 16:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762359543;
	bh=NCcAa0pDfh+8ix09a1OPmKTAjDiOwhgcNW3yTAqYn9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hIS7pvJIikT/daVfuiV6hOw8rowj5kF2jyQbPmqVAFcLSi/BrVw3VOFQj8kzc8LQZ
	 BcEJjyvW51mn/gil4UEklR2UCI7uWz2xoeiwgAfIwwPnKAy/ClBPGF/Qx6MEs6DQnn
	 fk5w3ty+2y3OhZ3BzMg0uhahAgno29sYHwIT0yJwUeNHjP1cxmUz2yweGOJmL5ARGE
	 F8Y3XmHwKHl/HbDapWAEsr+p4YXenBiXqPsHNr/e5dBpT4m2GdekcoFdO+kTLUs0W9
	 e6KlIWXhRo4IbK2XzltdkrC1u4ykAP4tvHNHE8h8yAxmCcbVZF/awAFDG6g6V61wyx
	 vfvp1Co3/C2CQ==
Date: Wed, 5 Nov 2025 06:19:02 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Calvin Owens <calvin@wbinvd.org>, linux-kernel@vger.kernel.org,
	Dan Schatzberg <dschatzberg@meta.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, cgroups@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH cgroup/for-6.19 1/2] cgroup: Convert css_set_lock from
 spinlock_t to raw_spinlock_t
Message-ID: <aQt49uB4lEDPqVYE@slm.duckdns.org>
References: <20251104181114.489391-1-calvin@wbinvd.org>
 <d03d2a6e0d0a09e9da6a54370f253c00@kernel.org>
 <20251105073009.xNtOAM_u@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105073009.xNtOAM_u@linutronix.de>

On Wed, Nov 05, 2025 at 08:30:09AM +0100, Sebastian Andrzej Siewior wrote:
> This one has a kfree(link) and kfree takes spinlock_t so not working.
...
> 
> I am also a bit worried about all these list iterations which happen
> under the lock. There is no upper limit meaning the list can grow with
> limits affecting the time the lock is held.

Good points. Let me think of something else.

Thanks.

-- 
tejun

