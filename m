Return-Path: <cgroups+bounces-10586-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EE1BC1EBB
	for <lists+cgroups@lfdr.de>; Tue, 07 Oct 2025 17:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CDA719A5166
	for <lists+cgroups@lfdr.de>; Tue,  7 Oct 2025 15:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEC52E5B2D;
	Tue,  7 Oct 2025 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJnC7Yow"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B292E6100
	for <cgroups@vger.kernel.org>; Tue,  7 Oct 2025 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759850612; cv=none; b=qZsL+vI7kXI7RxeuRJaF/DGs42G244zzzShUPKAMZrC9CcoabgZaINtR2h1tfrLLMfSRThvT8YBMrHVhEWSIfKeWJ52Q+vr3v1AfTXi+YIHfT82FAAi4Bme+TAE4t8zq5CEBfcj/OcjGzvHmOyiLw3uAbWn5uxCjMBeWoe0ecYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759850612; c=relaxed/simple;
	bh=Qaixh/0h0CexTahBH/Nbesb7dLvjfql5jNJYxSlQ13U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pY7efFMFyEfTdqU/htImlz3QnzrsdCM2TonS3hL5CWpJ2p1MM5wXf1UiVByA8tob1DW/O56x/C4ysazvsxy/QcJUsRAH2dZCIRXA99RDTATFwshJBqZQUummSsJ4fejnKM5rJUb0FIg0cEcEr8l9BFL2rHwjP6CYSm1Z4j0g7co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HJnC7Yow; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so934367866b.2
        for <cgroups@vger.kernel.org>; Tue, 07 Oct 2025 08:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759850608; x=1760455408; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UwG9PZuipETG7rnRpTzxcF+1B6JYfXyf2MeSzyquatI=;
        b=HJnC7YowAeXIjGVV3b79yxEzh66wwgYz5lOP7H9oHGT53cWPxcWC8X0L43Y/+GRnxv
         rl+tIcVIF0h7E3los7tb5XtGss78iKsQh+mVpEus4vf9YdwaqxxeoYo2hmaloPdaqtzq
         u415566smcfxQbq5BJVb860TVewDNSE4++jSI9lVDzpFducGS8/SgCVoQ4aZS/PwOvow
         5DloB9NC3fYWZg1z3JdDRy40RcKUUQho13o3kf+T2vydQMi/D4IcFG+CXLk5IBTSKr5K
         wsDwz7tcwe2FxIyeYyiy6shqjKdFMb6D63GnWn/vSaNUmavHAsi2MTxAfHHMCSQHZcPL
         NKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759850608; x=1760455408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UwG9PZuipETG7rnRpTzxcF+1B6JYfXyf2MeSzyquatI=;
        b=h4Wpefl9J1yeCL3ynu2zSpuGUhmBxg1C68eUKRUBclpEnkAWHrIrwUp4ox+3mSorn6
         kJlHE5QZQ+grxENyCyr8ajD10+HAoFg3KgEmclx81blTRzSCnNkzYCaIhcFwsmmPlGnU
         uRKfaxWAtamwdL1BsWCR3wmp7O1RJyoiOblaxq3cu9hO/pAxzRQJqH5K+rmcvoFpxTFr
         Tz1+1qETW58Ma6EE1Efpci8hl1f7A0HQDFEmDJI+1n6hjmqHCkdyrSnOztKXeGxXPw6p
         6kZsBqQFm3kx8xLm3KJkuDT8BCjM/6/LBV9AIukkmlmbLiI5qaXXf4eQX0Rzz0RssXBO
         WSxw==
X-Forwarded-Encrypted: i=1; AJvYcCWf3bxKOf15xQNLoaedmwuMfzgg9zkinQIZBla0UT2QFfDcfmacUEGw45TR0DjAAY2EKcFJZMAx@vger.kernel.org
X-Gm-Message-State: AOJu0YyyJzBIjXUf+dqvfQ2wvq20MeRR8xGOrhAHjpmR22aRnEoOJiX/
	AV3nyG0w8aj3SkhcxaI1gQp3Gfz9iESET72EeJeg7/JguiYHzo7H+WcouRV0KGj7MZSCVNfcPsO
	YLLRVW2XAF1o+127h1ISI7Vq/ipHHEjCoyy75SrJ1bA==
X-Gm-Gg: ASbGncsfWhaXd3HPGZXYWtcr4MBS2uePKZgxij70RYiXARMZ94KLxgZ430AzQ/KIvWG
	zEdowY3LP8Zt4igpVaG6D60vpoYG+xvyJ/TZvNgEIplbNqZGngeIN/mGoo1eXGQtKQpmE/1GFgw
	9VvDOQ0XG3vSm1sXq7ZHM0iXFcKOu6UIIOl1/lyJ9aEzYb7MTDBZW+cJ8BB+blWVhw+RK4xq0pV
	1y166A/NoaO4ja5m9Cdfe0h9s59uKrjpUFjje/0uPR/osIto8G36J8a6S6SQCDZ/hXuP5yHmA==
X-Google-Smtp-Source: AGHT+IFY9nkxh1XrpxsOJhE6hryneAH5gLOUnE5EpF4NzhHNwlkHm8SbyiGn3ZVrorhgVsPBNdhy5CzpeJS0xykTtj8=
X-Received: by 2002:a17:907:97d3:b0:b04:67f3:890f with SMTP id
 a640c23a62f3a-b49c3d753d4mr2301349966b.33.1759850607427; Tue, 07 Oct 2025
 08:23:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006104402.946760805@infradead.org>
In-Reply-To: <20251006104402.946760805@infradead.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 7 Oct 2025 17:23:13 +0200
X-Gm-Features: AS18NWAxqcxGakptEBnQb48nrcpm15RhoPtf2PjFIcOjN0vV7OYV5xWrjVCaxFw
Message-ID: <CAKfTPtB5i+5rqkuU8Q4D9fUGAnjKCqNR_y82ZAHHgJdFgcOTnw@mail.gmail.com>
Subject: Re: [PATCH 00/12] sched: Cleanup the change-pattern and related locking
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, longman@redhat.com, 
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com, arighi@nvidia.com, 
	changwoo@igalia.com, cgroups@vger.kernel.org, sched-ext@lists.linux.dev, 
	liuwenfang@honor.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 12:46, Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> Hi,
>
> There here patches clean up the scheduler 'change' pattern and related locking
> some. They are the less controversial bit of some proposed sched_ext changes
> and stand on their own.
>
> I would like to queue them into sched/core after the merge window.

Acked-by: Vincent Guittot <vincent.guittot@linaro.org> for the serie
in addition to the reviewed-by for patch 4

>
>
> Also in:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/cleanup
>
> ---
>  include/linux/cleanup.h  |   5 +
>  include/linux/sched.h    |   4 +-
>  kernel/cgroup/cpuset.c   |   2 +-
>  kernel/kthread.c         |  15 +--
>  kernel/sched/core.c      | 327 ++++++++++++++++++-----------------------------
>  kernel/sched/deadline.c  |  20 +--
>  kernel/sched/ext.c       |  47 +++----
>  kernel/sched/fair.c      |  15 ++-
>  kernel/sched/idle.c      |   9 +-
>  kernel/sched/rt.c        |   7 +-
>  kernel/sched/sched.h     | 198 ++++++++++++++++++++--------
>  kernel/sched/stats.h     |   2 +-
>  kernel/sched/stop_task.c |   9 +-
>  kernel/sched/syscalls.c  |  84 ++++--------
>  14 files changed, 373 insertions(+), 371 deletions(-)
>
>
>

