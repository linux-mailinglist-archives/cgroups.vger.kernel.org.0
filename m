Return-Path: <cgroups+bounces-10531-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DDDBB72DB
	for <lists+cgroups@lfdr.de>; Fri, 03 Oct 2025 16:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3C74A0580
	for <lists+cgroups@lfdr.de>; Fri,  3 Oct 2025 14:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988AF23504B;
	Fri,  3 Oct 2025 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgQGLMH+"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513B62AF1B;
	Fri,  3 Oct 2025 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759501634; cv=none; b=WkcpmcAqjbqBw+03PkH9oSP1lflWWTwlp7rAGSRc/2ytK1T+2Tk7O1bdZEALRgtslBXOezHFrGqXMdGK5K1b6wzlnUZkRtR2ie+gDgRitkJoKoOkICg9TRSAD9Z9PZvxLsiKgC8C8VivwGNcFHmqGxij8ab/tTrHGiO6uML+Qm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759501634; c=relaxed/simple;
	bh=dGFgZnRHqdceZqsBoaf4qUSTMVbavHVe6dKEnyeKKns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJvPQX8LBCzutHBBSm7vPv39ki96QZ013z5Xru0Jv+KbKZKrg54Jrnan6nIcBodWnGIRzjA3HaNlpEEEXx5cIiq0V2beAyS/OpJ0HMQM1C1hkJZLgCquKCYvp3pE45f3av/UT9j27SmZu5Al2rKUvZqAdb7jDqnOyEqG11lKWzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgQGLMH+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A49DC4CEF5;
	Fri,  3 Oct 2025 14:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759501631;
	bh=dGFgZnRHqdceZqsBoaf4qUSTMVbavHVe6dKEnyeKKns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QgQGLMH+rW+2D0ZVkqgdP6Y7Qhz7kCt9KQ8/4gbwfX/Jrhz4WsdksbIhX3Tkkf+QR
	 POIeVYbv3SF91v7+4UBzL3ul/nYxr5W2RRUDuiaIRLdXRo/5n13zYBPVvk2sqVF3B2
	 v15mAip4KtkuHe7np2JHGzcZX+Y+pWCbxnbXuOjGc+PfQaRAz8RLPLeJRaRIceo3yZ
	 c5s+0eYhHqGjxR1YghfA033TNhlopfPgHZt/lmlDVeyaUKbF9Up8HjAWrqaC8tjvxf
	 USN11kMasr5pZX6HMMCIuJJKr/me8K3ns5+sGJJ8PlAlLDvzGutjbZro12o9B25qWR
	 1dzIb6PD2IEqg==
Date: Fri, 3 Oct 2025 04:27:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Nirbhay Sharma <nirbhay.lkd@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tiffany Yang <ynaffit@google.com>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH] cgroup: Fix seqcount lockdep assertion in cgroup freezer
Message-ID: <aN_dPpjupRpc9Tj1@slm.duckdns.org>
References: <20251003114555.413804-1-nirbhay.lkd@gmail.com>
 <nbtofen2pwqmp7r5odbyc4en6vv54rpznyaanxlb6tbx5yyg25@jx2re5hdmt5e>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nbtofen2pwqmp7r5odbyc4en6vv54rpznyaanxlb6tbx5yyg25@jx2re5hdmt5e>

On Fri, Oct 03, 2025 at 04:00:22PM +0200, Michal Koutný wrote:
> On Fri, Oct 03, 2025 at 05:15:55PM +0530, Nirbhay Sharma <nirbhay.lkd@gmail.com> wrote:
> > The commit afa3701c0e45 ("cgroup: cgroup.stat.local time accounting")
> > introduced a seqcount to track freeze timing but initialized it as a
> > plain seqcount_t using seqcount_init().
> > 
> > However, the write-side critical section in cgroup_do_freeze() holds
> > the css_set_lock spinlock while calling write_seqcount_begin(). On
> > PREEMPT_RT kernels, spinlocks do not disable preemption, causing the
> > lockdep assertion for a plain seqcount_t, which checks for preemption
> > being disabled, to fail.
> > 
> > This triggers the following warning:
> >   WARNING: CPU: 0 PID: 9692 at include/linux/seqlock.h:221
> > 
> > Fix this by changing the type to seqcount_spinlock_t and initializing
> > it with seqcount_spinlock_init() to associate css_set_lock with the
> > seqcount. This allows lockdep to correctly validate that the spinlock
> > is held during write operations, resolving the assertion failure on all
> > kernel configurations.
> > 
> > Reported-by: syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=27a2519eb4dad86d0156
> > Fixes: afa3701c0e45 ("cgroup: cgroup.stat.local time accounting")
> > Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
> 
> Link: https://lore.kernel.org/r/20251002165510.KtY3IT--@linutronix.de/
> 
> Yes, this is what was discussed yesterday. Thanks.
> 
> Acked-by: Michal Koutný <mkoutny@suse.com>

Okay, reverting that one and applying this one.

Thanks.

-- 
tejun

