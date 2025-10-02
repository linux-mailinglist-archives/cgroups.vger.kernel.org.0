Return-Path: <cgroups+bounces-10522-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4BDBB49DF
	for <lists+cgroups@lfdr.de>; Thu, 02 Oct 2025 19:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049731C1463
	for <lists+cgroups@lfdr.de>; Thu,  2 Oct 2025 17:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143BB244679;
	Thu,  2 Oct 2025 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpbaYCjC"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C318D19992C;
	Thu,  2 Oct 2025 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759424680; cv=none; b=Osf9Teo+NR3+PZC6Ju2edLKttO5m0ajUg0WDnTZnMZWKuraIA5sRwKjzNtRpJVkqUq6nw7diFTbIAcJKofXTkO5lPLh9JWjHB2GcT4IM432J4y1idbZGK18/rnvV1o26MaB9Vh+aEluTLuoY9CatS5VERijI0NFhWK7TfinzlGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759424680; c=relaxed/simple;
	bh=QLmeNNZrDdeQMsIKV4+FKvXjKd2aPGz9wzMUZd8nvuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+o1jnpfSrLJbuPxi+/vlOF6o9JAqg9I8gH9ByydVZUeMzcpPok25UoAnfoBF1KLhvPWziXLf+Ozaew8tjlyub+0/tp91LdohWr6kbhX8BsT99wKPiQ+8cvjP0lvLC4XgPMhv9nIsU9lYs2dEbcxCchieSkWXU+wG0UbyFjG8cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpbaYCjC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25972C4CEF9;
	Thu,  2 Oct 2025 17:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759424680;
	bh=QLmeNNZrDdeQMsIKV4+FKvXjKd2aPGz9wzMUZd8nvuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UpbaYCjC9hfQZmiQwOkhP+4TX7ANk8R9wdgcqV17N9WrC3lw/obrGY5PfhYXQ6pT4
	 JHglqqQj+qVFK93ZJg4GcWPfII/7WBB5eg7HihfXcYr3t5w5xLZZxUDIGJidjZOtqC
	 okSdWJV1+2WjjwcfyM19NNGPo05VGsmyDSjf6LAKKenQlDdASXhj+RJty/vhxOqQDw
	 u+PRzFLJjN4msJ9k8wvW9JgQ3amYO1Hph4ciZuX8/s1amn/uiyfgLm3+VNdYHTBe5g
	 yFoQYrN78tB9VL3SMLnTO+Nj+DBGxcybOC99Z70+NORd9Dfifzof2z9C2KzHDQMHrT
	 38utv+9dqZ/hA==
Date: Thu, 2 Oct 2025 07:04:39 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tiffany Yang <tiange@google.com>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Disable preemption for cgrp->freezer.freeze_seq
 when CONFIG_PREEMPT_RT=y.
Message-ID: <aN6wp15Jh0UKgujf@slm.duckdns.org>
References: <20251002052215.1433055-1-kuniyu@google.com>
 <58de560994011557adefca6b24ebe4e8@kernel.org>
 <20251002165549.m2wc3Dt6@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002165549.m2wc3Dt6@linutronix.de>

On Thu, Oct 02, 2025 at 06:55:49PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-10-02 06:45:01 [-1000], Tejun Heo wrote:
> > Applied to cgroup/for-6.18-fixes.
> 
> 10 minutes too slow then.

Oh, I can easily revert. Just let me know what you want to happen.

Thanks.

-- 
tejun

