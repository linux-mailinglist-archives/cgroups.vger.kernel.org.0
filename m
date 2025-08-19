Return-Path: <cgroups+bounces-9278-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6E5B2C505
	for <lists+cgroups@lfdr.de>; Tue, 19 Aug 2025 15:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54020A21196
	for <lists+cgroups@lfdr.de>; Tue, 19 Aug 2025 13:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F8133CEA8;
	Tue, 19 Aug 2025 13:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YyzS69Yp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KIUELU3C"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475BE134CF;
	Tue, 19 Aug 2025 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608822; cv=none; b=VJc+cZUwmfxJ0UglEslia9z7Ggk8mptjujnSZW43UDG0RN5KyWleofFuNpCnNpMq77S67nqG51WEAX0qKA3k997iDVDMi+hGXiMQIizLZZ36MML+5zJ5vp020NZxeXQpJk+vjCShweopMUnTWhm3ax+681XRYmxsHt02XvXGzRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608822; c=relaxed/simple;
	bh=G6B7tqpxuZUp89hJxYSF+ooqPCxIAKaEKj5LW0V4ZS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iozM1lr/mcVEOgNO28SLwg+mqPaKpK0o1fOPQ1wqrVaAya0puhJ0hj3GBEGWL5PBR9NihLXvmHj9bEuzEr31uyBjAxxrCuP2k7IxNIGZOvuDkZVPU4Q5j7s0mhG0rHQkzdlHDc23W5/w0QUCGEkSsol28uZ6x9djWgFkcDpnEOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YyzS69Yp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KIUELU3C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Aug 2025 15:06:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755608818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fcst1kKyduOpiM5s2IszivugeQbhO707fJBDCu3lH9c=;
	b=YyzS69Ypo/ZY9PWLbcVo/0SaZTHTkU2z9GWAdWIfl2PVGl8qbWCxf0iwBmdt2wpu1G18Lp
	S3lM0U5ttrZzq6c3uAwvALSee2wfxwRCMgMe/yUT9kxzdZS95Tz8SgswqEzVbZiKRA+Tfa
	kSJB2k9/0sNkIj7gs7Zb7Q4h2Z+ZUbzbxQSHWypJy+CtGvAi4ZmCuAWbCfv06hHZoB1SGD
	NY3ZsT85V0bKvS+T82gizkzunj5zHrEi21GVStaw6D+q5nWmJkAV6o4OZwB0/M2AoxmcSU
	c2/MpDQKSLcIaviuoEX73bvc7AfxCC8rcETjCJR1UqCzwsj/lerFUAB02iC2eA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755608818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fcst1kKyduOpiM5s2IszivugeQbhO707fJBDCu3lH9c=;
	b=KIUELU3CQOrpO7y21PFpdTByTJkwCx2RliawJgLdkuLxXlZttxa2wnIAi2yPsDOYMySFLo
	pzTMMJO8hjcocxDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, will@kernel.org, boqun.feng@gmail.com,
	longman@redhat.com, clrkwllms@kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] sched/cgroup: Lock optimize for cgroup cpu throttle
Message-ID: <20250819130656.DdJqAScZ@linutronix.de>
References: <20250811151316.838707-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250811151316.838707-1-jackzxcui1989@163.com>

On 2025-08-11 23:13:16 [+0800], Xin Zhao wrote:
> Dear Sebastian,
> 
> I believe what you mentioned is related to the same issue that Valentin
> brought up later, which is the current solution of "delaying CPU throttling
> through the task_work mechanism until returning to user mode."
> My colleagues and I indeed noticed this from the beginning. However, on our
> 6.1.134 RT-Linux system, we have tried new versions of this solution one by
> one, but they have all failed during basic script tests, so none have reached
> the stage of being used in our project. I see that this modification has been
> promoted in the community for more than two years, yet it remains in a state
> that doesn't work well (on our 6.1.134 RT-Linux system). I wonder if the
> changes require too many considerations or if this modification simply isn't
> suitable for running on RT-Linux. Our project cannot afford to wait, and
> there are many performance issues in RT-Linux.

You are free to use the patch.
Based on your description I assume that the patch Valentin referenced
will solve your problem. If not, it will be interesting to know why it
is not working. Otherwise you keep maintaining your patch.

> Thanks
> Xin Zhao

Sebastian

