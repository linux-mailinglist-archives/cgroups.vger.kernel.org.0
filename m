Return-Path: <cgroups+bounces-10526-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E93ABB544D
	for <lists+cgroups@lfdr.de>; Thu, 02 Oct 2025 22:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 915844E6F04
	for <lists+cgroups@lfdr.de>; Thu,  2 Oct 2025 20:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B201F22FAFD;
	Thu,  2 Oct 2025 20:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Z0kqxss";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8kSvIlRE"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA2C29AAE3;
	Thu,  2 Oct 2025 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759438304; cv=none; b=PilDFFsalivC/T2Vy067OC72BEKwGlp4CqX8pHkOlTqFuFL8jhNLxQq6bewh4jQ7MjNSwJEXTNOKb5kEN19RoIqt7Bq1aF3/wy/wGOJSYRMFBRJlOI4lhXyMysep3BuBbTz3tZi4HDHA3DaDrlm7SRCmhH5dZPtWPCsCsKcj7Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759438304; c=relaxed/simple;
	bh=dopwefVuTCsWZ+fwA+ryfs3snT67V6/qV44P15kyr+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrPT/jaIX/26e+3Rg2IudhkP2bm/8EMgn8CMTA6r6vvOdUtZjfaTq+z6FYpDDl57+mhAeE908rq8lV1KoMZvWrKntHY6xHkWYBX9+gcuvUd4LDZ4u/Axh8Wnj9sYT+6uhc1k3eivaD5vyHuQIhgL+Q/7GjWq8MEnN/qJbCwBCvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0Z0kqxss; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8kSvIlRE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 2 Oct 2025 22:51:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759438299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3rI0u3owtbYqzxuN2BjhxPFE9umTiK9vObo1UxEey0Y=;
	b=0Z0kqxssRsdZ/3T9LkWMyQlBOD6zGEeHoD+eIjISFEfryF1iCJu4oi7qM+onY1zHaOBM5X
	r4ZAQHQuw98w1ZrFrIw3Fimj80mUpdCvSDOF/QDJGnaku4RiNReiY1Fy6bgrHC7DhdOzP+
	bYjLuWYd9mEKng508Qk0ESRsBFe3ax3LJXlUQkueUuk8STd+TSoEl00RgF90EuSHoZERFG
	t1XswgtgWGPsf6RWsKCec79pgy/BDcTMnWfNnQBlrCl0OsU90ZPZjtEsme+/uZiCE2ifBO
	ApRtAxOow3v1TMq/lhFM2GffiEi/EH0VHOldwP2NDs1FEjENoU465cmm+upDcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759438299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3rI0u3owtbYqzxuN2BjhxPFE9umTiK9vObo1UxEey0Y=;
	b=8kSvIlREXTRKmShb8hQJ6y0hHTeBCB3Exwc272Ftb01eIb4a3GdT13myW/XkgSIhtn04vD
	+6c5ztkHE6GNzIBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tiffany Yang <tiange@google.com>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Disable preemption for cgrp->freezer.freeze_seq
 when CONFIG_PREEMPT_RT=y.
Message-ID: <20251002205138.Of7qOs-D@linutronix.de>
References: <20251002052215.1433055-1-kuniyu@google.com>
 <58de560994011557adefca6b24ebe4e8@kernel.org>
 <20251002165549.m2wc3Dt6@linutronix.de>
 <aN6wp15Jh0UKgujf@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aN6wp15Jh0UKgujf@slm.duckdns.org>

On 2025-10-02 07:04:39 [-1000], Tejun Heo wrote:
> On Thu, Oct 02, 2025 at 06:55:49PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2025-10-02 06:45:01 [-1000], Tejun Heo wrote:
> > > Applied to cgroup/for-6.18-fixes.
> > 
> > 10 minutes too slow then.
> 
> Oh, I can easily revert. Just let me know what you want to happen.

Oh, thank you. I will prepare than the suggest patch. I don't mind if
someone beats me to it ;)

> Thanks.

Sebastian

