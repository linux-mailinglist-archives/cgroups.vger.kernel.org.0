Return-Path: <cgroups+bounces-10544-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC464BB8B41
	for <lists+cgroups@lfdr.de>; Sat, 04 Oct 2025 10:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96582189FDF6
	for <lists+cgroups@lfdr.de>; Sat,  4 Oct 2025 08:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AFD2417D9;
	Sat,  4 Oct 2025 08:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SksNSPVp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335B3199949
	for <cgroups@vger.kernel.org>; Sat,  4 Oct 2025 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759566854; cv=none; b=EaKao6GKgB43rS0GF4sq3g8EIRGeZXYM0XMg5xriclOBM+nqIxTDU7PjQ2XLel/R5S9Z4piSDBS8P1NErLUiWfSEkSs4b9wZzhHznt7OzAdGv/ilLp5uDqDGsk1soiEXZZ+9YIQm7w4nL/S0/lwn7V7QBbLnLb0luTX+1xXi7xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759566854; c=relaxed/simple;
	bh=ewAScujQh6IO+nNyoKcQ1124xJn4eyXuYWjb3HxVNyI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U7WnaBI1Ekls+E/XGTiaU8H8T95GV6D/cixn2rogD3Yqr+w+S8Ojcfn4FiSPVVqdHL1yPxtjusPML68oSwHGO93NWDf3RZRcwy150wHGPtirNNzpkjl3MzErv+W4H6966wDPuuiJ3MaolNIvRPoBtpQ98DDpf96zMaFVVk942PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SksNSPVp; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3307af9b595so2548676a91.0
        for <cgroups@vger.kernel.org>; Sat, 04 Oct 2025 01:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759566852; x=1760171652; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DNUXIAMIgyuQcbpSIlbWyb8Yr08Un31/NnbXWZYjsP0=;
        b=SksNSPVp+5WQEnJ2UWC2Z0FOsEBGoOsImDoNqw+EFu0Gj5iRUnqnbjVuBYelmS2c0f
         H23xqUExrHXDzJQn0sA/A1bhW4jpeTmpdKGeOyE6KtPwjcy2H3/2RB8mw6skA2e1zyzc
         teU5EZ25mwovFgYjakFTRtswIpummiJR/Jdb/wT7YvOgJqMWuMgErdPe/sISlP54OEe9
         VneXjiWpVkF0/GBByrm+NtgVM18cihpavTIkjVGYICYtYkQq6uSr9HXxi5H15beZvPHE
         3IYs2DzAaECsSk6O97K39gQkBzxq9WpYLQ8QuWcGt+RDuCGV7IeKy8wTf/EGLC3Hxxtd
         8dyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759566852; x=1760171652;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNUXIAMIgyuQcbpSIlbWyb8Yr08Un31/NnbXWZYjsP0=;
        b=Ife9wNMgTu+7SnS1HLlvfFVQcr/ti1R8jXWiTjmDb9F95TX/fWkoNpqruSgp+MdTQ8
         LcoSpqyRVi1cdRu4oXlzQAyPlZlc5uDr+2J3FEydPi6WTp8UGsA9Rhshf03QDKPaaXSj
         THApHYolbucb9FZOMKTI0FX74ADmM8eAXEOWcJ8byzBdYC5KRF6ew2bdoFXB7uvHqveM
         VBacphesVT5qWZbJtmprJ6M+YzDOsBpobApe2FlP6y69PTpNTdqKROL//raLgoaKVUUO
         c7xDWFZiC80pl97ZvsPNTyV7oHGUxImnRXSI9U/4dAjNyt30jO/dj+N35CxTe7c8PNTu
         qK/Q==
X-Forwarded-Encrypted: i=1; AJvYcCURtw85lAOtxhOO7/b+AbMMNzFzxNVoHxaE9Nkq7F+lB8ObrocHRB3gHtnFWscpPriSZKS2svd5@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4em3gtNhtQjURU5GZSWbMnY+r6ZJ76Yli8phee366DCXSPyMc
	44jivGZs72SA5Sz6NHZE0YwwQJ3Ds3TQNYCAUu4PAFUX/+rAwmw4YvHa3RfNehwXJfFMHJ91Aa0
	H/RC/4ZMlGQ==
X-Google-Smtp-Source: AGHT+IG8WMGHaurimhri+gW5zRlp6uwHUCV2xHoW/prUeoq2RpfxaFVx0IibIcEVP1lg9S9cRSoC1Wbb2vOb
X-Received: from pjzh5.prod.google.com ([2002:a17:90a:ea85:b0:32d:e264:a78e])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3ec6:b0:330:3fb8:3885
 with SMTP id 98e67ed59e1d1-339c276e814mr6792475a91.18.1759566852200; Sat, 04
 Oct 2025 01:34:12 -0700 (PDT)
Date: Sat, 04 Oct 2025 01:34:10 -0700
In-Reply-To: <20251003114555.413804-1-nirbhay.lkd@gmail.com> (Nirbhay Sharma's
 message of "Fri, 3 Oct 2025 17:15:55 +0530")
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003114555.413804-1-nirbhay.lkd@gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Message-ID: <dbx87bxbvzel.fsf@ynaffit-andsys.c.googlers.com>
Subject: Re: [PATCH] cgroup: Fix seqcount lockdep assertion in cgroup freezer
From: Tiffany Yang <ynaffit@google.com>
To: Nirbhay Sharma <nirbhay.lkd@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Nirbhay Sharma <nirbhay.lkd@gmail.com> writes:

> The commit afa3701c0e45 ("cgroup: cgroup.stat.local time accounting")
> introduced a seqcount to track freeze timing but initialized it as a
> plain seqcount_t using seqcount_init().

> However, the write-side critical section in cgroup_do_freeze() holds
> the css_set_lock spinlock while calling write_seqcount_begin(). On
> PREEMPT_RT kernels, spinlocks do not disable preemption, causing the
> lockdep assertion for a plain seqcount_t, which checks for preemption
> being disabled, to fail.

> This triggers the following warning:
>    WARNING: CPU: 0 PID: 9692 at include/linux/seqlock.h:221

> Fix this by changing the type to seqcount_spinlock_t and initializing
> it with seqcount_spinlock_init() to associate css_set_lock with the
> seqcount. This allows lockdep to correctly validate that the spinlock
> is held during write operations, resolving the assertion failure on all
> kernel configurations.

> Reported-by: syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=27a2519eb4dad86d0156
> Fixes: afa3701c0e45 ("cgroup: cgroup.stat.local time accounting")
> Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
> ---
>   include/linux/cgroup-defs.h | 2 +-
>   kernel/cgroup/cgroup.c      | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index 539c64eeef38..933c4487a846 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -435,7 +435,7 @@ struct cgroup_freezer_state {
>   	int nr_frozen_tasks;

>   	/* Freeze time data consistency protection */
> -	seqcount_t freeze_seq;
> +	seqcount_spinlock_t freeze_seq;

>   	/*
>   	 * Most recent time the cgroup was requested to freeze.
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index ab096b884bbc..fe175326b155 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -5789,7 +5789,7 @@ static struct cgroup *cgroup_create(struct cgroup  
> *parent, const char *name,
>   	 * if the parent has to be frozen, the child has too.
>   	 */
>   	cgrp->freezer.e_freeze = parent->freezer.e_freeze;
> -	seqcount_init(&cgrp->freezer.freeze_seq);
> +	seqcount_spinlock_init(&cgrp->freezer.freeze_seq, &css_set_lock);
>   	if (cgrp->freezer.e_freeze) {
>   		/*
>   		 * Set the CGRP_FREEZE flag, so when a process will be

Thanks for this fix, Nirbhay!

-- 
Tiffany Y. Yang

