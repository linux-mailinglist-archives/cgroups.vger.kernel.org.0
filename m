Return-Path: <cgroups+bounces-10229-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C08B82E32
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 06:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081222A715C
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 04:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CAE23BCF0;
	Thu, 18 Sep 2025 04:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B6lohcSO"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D46A927
	for <cgroups@vger.kernel.org>; Thu, 18 Sep 2025 04:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758169925; cv=none; b=tAaK7y+CxNna8TmgrQ1RI+RKyROeE7D69lznftWkTcsDR1WDhxpr16oGYATb361FJBZYvkXnYJSqW0T3T6AThVqX8pzHUVtjlRHRhXCpLYkjAR2l5Vh2gy5GgTqy3NB9HCGCvJQZUZoDU6zEXXapSQvl1uov/lPzDR/p6KtUOtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758169925; c=relaxed/simple;
	bh=M77ITASNVzLLImCdqoS3b49c0JcaD23WggnJUmr1UUg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=N+YMAcBOD0aBE6OTE3vEmw6WsC567XF08EXEL/EG51iFK1IxDyQCuLE2ksYo5ngKM06C4DrshRqJx2ww7l4v98MJ1luWPxf6epOtgeGkGQS/9octgjs++JGlYXf8Jt5n8G8xaAhPPg3hzw9MVSxxABBEIDM/wZompPOtklRijqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=B6lohcSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189B1C4CEE7;
	Thu, 18 Sep 2025 04:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758169924;
	bh=M77ITASNVzLLImCdqoS3b49c0JcaD23WggnJUmr1UUg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B6lohcSOCMTKlBrW1kViDlx/4iBrxvDkdpxJzeManoz5hs8g8HnWP4LQGtnJdnxw5
	 ViWvBezOBvA+jOg0rlNypchR0dgnfxFNznwUzfn8Q0OP5AwSv2L3bd5Qr0Bv0ArcZT
	 F3n9J+ca3mzSUsQzOGzcfdFw05zfzSeLs9/ByuC8=
Date: Wed, 17 Sep 2025 21:32:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz,
 tj@kernel.org, muchun.song@linux.dev, venkat88@linux.ibm.com,
 hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, Lance Yang <lance.yang@linux.dev>, Masami Hiramatsu
 <mhiramat@kernel.org>
Subject: Re: [External] Re: [PATCH v6] memcg: Don't wait writeback
 completion when release memcg.
Message-Id: <20250917213203.4608d54da45a5b8bc80c2004@linux-foundation.org>
In-Reply-To: <CAHSKhtdPGuMW0jRRgARGt+ZdnC02v9O11=ofsgRmnZny3c5aaw@mail.gmail.com>
References: <20250917212959.355656-1-sunjunchao@bytedance.com>
	<20250917152155.5a8ddb3e4ff813289ea0b4c9@linux-foundation.org>
	<CAHSKhtdt9n-K6KGXTwofpRPo-pH0-YoKFLtEe3Z4CszmNL0rCg@mail.gmail.com>
	<20250917202606.4fac2c6852abc5ba8894f8ee@linux-foundation.org>
	<CAHSKhtdPGuMW0jRRgARGt+ZdnC02v9O11=ofsgRmnZny3c5aaw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 18 Sep 2025 12:22:35 +0800 Julian Sun <sunjunchao@bytedance.com> wrote:

> > Seems the intent here is mainly to prevent the warning.  If that
> > warning wasn't coming out, would we bother making these changes?  If
> > no, just kill the warning.
> 
> Got it. Seems like there's no more impact other than the pesky warning.
> BTW, I'm also seeing many hung task warnings when the mount/umount
> syscall is waiting for the s_umount semaphore—while s_umount is held
> by the writeback code path. I think the hung task is also undesirable,
> right? Since AFAICS there's also no more impact instead of the pesky
> warnings.

Sure.  Writeback is famous for potentially taking vast amounts of time
and that's perfectly reasonable and expected - lots of dirty data takes
lots of time to write out.  There is no misbehavior in this and warning
the operator about it is just silly.  If there is no action either they
or we can take to prevent the warning then just squash the warning.



