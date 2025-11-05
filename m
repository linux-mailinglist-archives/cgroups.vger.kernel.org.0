Return-Path: <cgroups+bounces-11601-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19042C36C95
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 17:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E15135067BF
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 16:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10439333445;
	Wed,  5 Nov 2025 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dq+Z+qkn"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5C6321448;
	Wed,  5 Nov 2025 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359628; cv=none; b=j6DduiQPdsEhV2wJZpeMMuZha35rdMZ0+rnVgF2DJfOD4n2JeXzUGizm0dI2VVDuhhXrNZzgU10Gd7KKg4bwCqDmG8EnW/3YeuMpTFU8lKgAayQFld8EwxDxcovNKQEnFZg5vDX829oAL/7sOsXZwocdYStuBCgUtZxh/Z2Nlmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359628; c=relaxed/simple;
	bh=ZiqBlIwvWxlpVcujFbPdBpC6AbPwImMrmTjpqocgTqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPqlEMB9pDZAYq8uDFN49q3ZA/PZvPoO/GcEd9mZBSzWyETyQ6rXSD6ZKBvbuvcDmdiLqwZhsNvXP2FMcX/x2wZLAR3dZhjWjtQux3lLe6ydsgj8WO9xnCOI7drlyRKvmOlVVNeMx5LUyHYDyFMQ4oqVVbnc8P2JKVcipXQYlcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dq+Z+qkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E960C4CEF8;
	Wed,  5 Nov 2025 16:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762359628;
	bh=ZiqBlIwvWxlpVcujFbPdBpC6AbPwImMrmTjpqocgTqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dq+Z+qknBO03LtqXoltkF5eRh5LpjkMzLvMFOMYC02EFod3yJBeHc9uL7EDu44+uF
	 6l46aOGdyM26gphH04c9Q3Xwh3oh45YE2JvJzq4wQ0mU5eIiaXtDxmC7pi4XsdB5/z
	 Zlfl/7G8MUclWDD7tj1lgaEEKQiuxaQH9HpIp6/T+PNbzozPRUYI7Q20VamggeS1u5
	 6NDCnCsN1IztpstUyGwhKWKE3NOJVKTE9XQlc0eb/dRYMstjoTjnOabNpIWHZtmyth
	 JEKdwnjKtKM3jaSeRz5KX4ZQP7LzxlVXOiYkGsz9Lr+ZCgp+Ux4kmz95aYprENivwg
	 Ue9CKZnkP5HIQ==
Date: Wed, 5 Nov 2025 06:20:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Calvin Owens <calvin@wbinvd.org>, linux-kernel@vger.kernel.org,
	Dan Schatzberg <dschatzberg@meta.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, cgroups@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH cgroup/for-6.19 1/2] cgroup: Convert css_set_lock from
 spinlock_t to raw_spinlock_t
Message-ID: <aQt5Sw6aEkLxYIYQ@slm.duckdns.org>
References: <20251104181114.489391-1-calvin@wbinvd.org>
 <d03d2a6e0d0a09e9da6a54370f253c00@kernel.org>
 <20251105085036.GN4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105085036.GN4067720@noisy.programming.kicks-ass.net>

Hello,

On Wed, Nov 05, 2025 at 09:50:36AM +0100, Peter Zijlstra wrote:
> On Tue, Nov 04, 2025 at 09:32:24AM -1000, Tejun Heo wrote:
> > Convert css_set_lock from spinlock_t to raw_spinlock_t to address RT-related
> > scheduling constraints. cgroup_task_dead() is called from finish_task_switch()
> > which cannot schedule even in PREEMPT_RT kernels, requiring css_set_lock to be
> > a raw spinlock to avoid sleeping in a non-preemptible context.
> 
> The constraint for doing so, is that each critical section is actually
> bounded in time. The below seem to contain list iteration. I'm thinking
> it is unbounded since userspace is on control of the cgroup hierarchy.

Right, along with the problems Sebastian pointed out, doesn't look like this
is the way to go. This doesn't need to happen in line. It just needs to
happen after the last task switch. I'll bounce it out and run it
asynchronously after the rq lock is dropped.

Thanks.

-- 
tejun

