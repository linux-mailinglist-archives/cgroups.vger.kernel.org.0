Return-Path: <cgroups+bounces-10521-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62C1BB4997
	for <lists+cgroups@lfdr.de>; Thu, 02 Oct 2025 18:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F7F13C0ED0
	for <lists+cgroups@lfdr.de>; Thu,  2 Oct 2025 16:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4295825C6F9;
	Thu,  2 Oct 2025 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qEJXvUaw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3kd6Qi3A"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C95522655B;
	Thu,  2 Oct 2025 16:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759424153; cv=none; b=CbVarUSCvtFIkizICN/1x5u76ooLtCgngtWUbk3csZFUku+I9/bX/ntgqVFJsBVJK5BR6FkVzjOz6fPAgCIN7Iee+UIcqGpvc+kLK0aXle/k3uW6xqtGzfm5w2jIk0bdUv9EGdfUPNuzKo0ibVlrWoqfO592bQBvjXn12zhEYsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759424153; c=relaxed/simple;
	bh=158AWIWKJ035WJd8lrrqV1P5Nf1OhRkaj2KJNsU+V4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3b16nhcjJkaAHqi/5fajetc7DPoKbwaH6HOAdKGu8tSP+o8gDdcAwKyIyDAeonWVovga5W4QHw1EGSXcgyEjliwDMWhOd9jbURz3+SC0bYAzflfntBfU0bD+6vf6OmOrawueSdI0SKP35wRp8GoBR++Fh6yyY3/TN5sFctLAAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qEJXvUaw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3kd6Qi3A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 2 Oct 2025 18:55:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759424150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FE/VSYSfV9vM8Q5rJ/NpFe+yGjMC0CFrECDc1Ady7cc=;
	b=qEJXvUawxy7QoaJKlaYuCpp98keUx587KrdfCUaqx1j1ARNtuthCJm7W3cMd+83sslWJXk
	KZfd1yFf3wZLBv+4/QjGAmLzPFgtrX9d48Y3MKHkRH0p6WWVrqJDQwC1gFMcwwpw79wjsD
	WR13N1JFBNOjjghFcPMDYp6mcYjlJ+9gZ8aZ35mWs5j31IMSQRdfhInby/AcKWpfh9kB9l
	2knKf9JJEkfKvoWvOV8oT9mUp4oR60eFH49sODcWTxVahO7yKcUaYFT8HZMOP1ud6R+DML
	n/0cd6B5j2kNpnGcP1OL6jHGZoflF1/g4mPitHx9FK52KXMEjP7Hec2EVe4B2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759424150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FE/VSYSfV9vM8Q5rJ/NpFe+yGjMC0CFrECDc1Ady7cc=;
	b=3kd6Qi3AAkKjhNqQ1oUYmD6gDKQ0qZZ5LROeF9Zt2hamqHYD7Enrh2SAsJEk9aWcM/C8Sm
	rE8Y1tzku9b2rzCw==
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
Message-ID: <20251002165549.m2wc3Dt6@linutronix.de>
References: <20251002052215.1433055-1-kuniyu@google.com>
 <58de560994011557adefca6b24ebe4e8@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58de560994011557adefca6b24ebe4e8@kernel.org>

On 2025-10-02 06:45:01 [-1000], Tejun Heo wrote:
> Applied to cgroup/for-6.18-fixes.

10 minutes too slow then.

> Thanks.
> 

Sebastian

