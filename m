Return-Path: <cgroups+bounces-8637-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A67AEACC3
	for <lists+cgroups@lfdr.de>; Fri, 27 Jun 2025 04:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE51E4A79CA
	for <lists+cgroups@lfdr.de>; Fri, 27 Jun 2025 02:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38B7191F6A;
	Fri, 27 Jun 2025 02:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k4wYBXQ0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22D92AF03
	for <cgroups@vger.kernel.org>; Fri, 27 Jun 2025 02:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750990764; cv=none; b=DleeXDxINHuAOYmLMJCVCT4pr7ppW4lD8oYOkpkOEka6EpzK8LaX7/nyuGicvdRK4QWytQOZdU6T3HollcdZCCuI47cZOjFyKQpwqkqQVxrbmdJRz1jMqgAVbzQ99DUZ07kb4Ym9Zhe4bU17N/CvlV4orXWlKNcb/V5Ht42dfA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750990764; c=relaxed/simple;
	bh=8q6CJM/GFRlLq9Smxp01oFMgHVTi2ex5Wzz319Dh4eM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i86Sv6oxoTpt+WT65tXhgKkQAWzdGIv2+0r3xWwTardhzSzlSDZxqAMo1ZeIAHaAjYmVBosq65PF3B9FGCt7hX5LMUlK1maZBbX5hASvxHjUPd356wmLLxrATnAjbtHK63AxQDK0cjnUxF3DpqNWI0YOt6IawiCHfFAkz5mwTcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k4wYBXQ0; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso1780921a12.2
        for <cgroups@vger.kernel.org>; Thu, 26 Jun 2025 19:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750990761; x=1751595561; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWwZXUo62mcX92TFX431sVQuGGLnxjqGO4qZhUCoR54=;
        b=k4wYBXQ0weAUwcfC+L1LUrQ9W3G9aYh7Y4bfx4ExV+RW1hl9ICTcVSphfqyxR50AzW
         sUib7aT/gIxglQhlnYy0N+w7KEwQ3TIVJGG9uee708PkO9fkKWw5NvGqAQV2m3/u1u6Y
         atn6N+7wDUjoDz6KmphsWx+xq+GExeOat7V2FHufRI9crcFGMWV9P7zOZhcc6w4jIZag
         CKGe90q41mNd64oDTKL5/zH6PoHMeuUPS7vGpaZEUtcj2UHMjX/pPSqDw24UGoQbI4wI
         qCCEkmiIOd3mL7EwWMInQXDjqly7LGfC/dEag+hiF6ChUUmcqcQepVKv1RGtqwF0lajG
         KT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750990761; x=1751595561;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWwZXUo62mcX92TFX431sVQuGGLnxjqGO4qZhUCoR54=;
        b=Ew2Qvv/iFwdipdyKVP64Xhkr/iIfeG1Fz4i0YurqPiWiGCfVGTzwBwq6tcz1maixM7
         7t4wN39aac9lq98H0B4yhRLxz2zMLA66Cl4hOlZEia9wZZrrCQe6JaubdMo0SrRvaIeM
         ikT2xka6n1agQwJMMKNtcRsj2PU2LrM8z/U90yNfP266cR/jMmSPMsVJnthSLOaY6PNr
         PhKSzrTSrjnkii6IG8/HfXDhQgAj5ffSLdY+dh+7pkyvhFG6llLyu9DB1g/334t+0VHM
         +4apUyzu1bqr0Oma2qDtcN93h3H9DfZh3EMp9TkjRewAME7h2p5NeKYpuHK7uEkpOjPB
         OBZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUls5/Qw3gZTr0xZCZl8/N7GV9y8NGm9pJL8gFFLwHMPbryabZIh5xgK10tUX/BwY0Fd+AtvOTT@vger.kernel.org
X-Gm-Message-State: AOJu0YzAMFu63fXRoFqLV+TTPitCx2FEOS6RzS6NujH5u7U6JZQGdyTc
	2Muz3aIfPR4Qik8wrby50HHaEOOZ751FFBYRWnFIagujwU0mB0Ihk6Bfq5kq/U0iaA==
X-Gm-Gg: ASbGncvulO/slyhK9adOoslLtxc6IDo2sSOJzgi+09A5RlV401Dy+XAxp7esgL1m7D0
	LYhveHFx/reznhrNls1X80h9rQybo0ytuaxFE3fELI6c7p7rkcKnyPo4iPBUMcWNqJ9uWcZV1si
	SZwWLIjXJn9bfTL4Kgioncd4o0VtyG9Ol5FOn59egKKIINrI9rY264WLVnua6lf6xtJdZe2+x/O
	pLV/NqNjASJYylxSeMJz2u/NnITbYte9zuqCRM3UHzpocQkfAl54u+M6LolOM1tgDCDdj5FaV3i
	18IPZSS3egnXCf9dnrc9It4a6h/s1KLAiT7gyq1CUZp1xNTlkNqRpD3+CrWwvcbd9pxSVYQu9is
	AUkoKyi2nbzb3BbYkuUGFfkWHaAUHxKSskndxzr3N4namPkD1
X-Google-Smtp-Source: AGHT+IG/s6ATLPSKxfmzWXxp3UkhyhFpRn9zyuTIyeOzxumVvJMn1cbO+0L/Fo75LsD0jPY+4+ZCXg==
X-Received: by 2002:a17:90b:278e:b0:311:ffe8:20e6 with SMTP id 98e67ed59e1d1-318c8ecd20cmr1903986a91.3.1750990760898;
        Thu, 26 Jun 2025 19:19:20 -0700 (PDT)
Received: from ynaffit-andsys.c.googlers.com (225.193.16.34.bc.googleusercontent.com. [34.16.193.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c1394288sm962304a91.2.2025.06.26.19.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 19:19:20 -0700 (PDT)
From: Tiffany Yang <ynaffit@google.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org,  cgroups@vger.kernel.org,
  kernel-team@android.com,  John Stultz <jstultz@google.com>,  Thomas
 Gleixner <tglx@linutronix.de>,  Stephen Boyd <sboyd@kernel.org>,
  Anna-Maria Behnsen <anna-maria@linutronix.de>,  Frederic Weisbecker
 <frederic@kernel.org>,  Johannes Weiner <hannes@cmpxchg.org>,  Michal
 =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,  "Rafael J. Wysocki"
 <rafael@kernel.org>,
  Pavel Machek <pavel@kernel.org>,  Roman Gushchin
 <roman.gushchin@linux.dev>,  Chen Ridong <chenridong@huawei.com>,  Ingo
 Molnar <mingo@redhat.com>,  Peter Zijlstra <peterz@infradead.org>,  Juri
 Lelli <juri.lelli@redhat.com>,  Vincent Guittot
 <vincent.guittot@linaro.org>,  Dietmar Eggemann
 <dietmar.eggemann@arm.com>,  Steven Rostedt <rostedt@goodmis.org>,  Ben
 Segall <bsegall@google.com>,  Mel Gorman <mgorman@suse.de>,  Valentin
 Schneider <vschneid@redhat.com>
Subject: Re: [RFC PATCH] cgroup: Track time in cgroup v2 freezer
In-Reply-To: <aEDM_s7y8xMKJHph@slm.duckdns.org> (Tejun Heo's message of "Wed,
	4 Jun 2025 12:47:26 -1000")
References: <20250603224304.3198729-3-ynaffit@google.com>
	<aD9_V1rSqqESFekK@slm.duckdns.org>
	<dbx8y0u7i9e6.fsf@ynaffit-andsys.c.googlers.com>
	<aEDM_s7y8xMKJHph@slm.duckdns.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 26 Jun 2025 19:19:18 -0700
Message-ID: <dbx8y0tej595.fsf@ynaffit-andsys.c.googlers.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tejun Heo <tj@kernel.org> writes:

> Hello, Tiffany.
>
> On Wed, Jun 04, 2025 at 07:39:29PM +0000, Tiffany Yang wrote:
> ...
>> Thanks for taking a look! In this case, I would argue that the value we
>> are accounting for (time that a task has not been able to run because it
>> is in the cgroup v2 frozen state) is task-specific and distinct from the
>> time that the cgroup it belongs to has been frozen.
>> 
>> A cgroup is not considered frozen until all of its members are frozen,
>> and if one task then leaves the frozen state, the entire cgroup is
>> considered no longer frozen, even if its other members stay in the
>> frozen state. Similarly, even if a task is migrated from one frozen
>> cgroup (A) to another frozen cgroup (B), the time cgroup B has been
>> frozen would not be representative of that task even though it is a
>> member.
>> 
>> There is also latency between when each task in a cgroup is marked as
>> to-be-frozen/unfrozen and when it actually enters the frozen state, so
>> each descendant task has a different frozen time. For watchdogs that
>> elapse on a per-task basis, a per-cgroup time-in-frozen value would
>> underreport the actual time each task spent unable to run. Tasks that
>> miss a deadline might incorrectly be considered misbehaving when the
>> time they spent suspended was not correctly accounted for.
>> 
>> Please let me know if that answers your question or if there's something
>> I'm missing. I agree that it would be cleaner/preferable to keep this
>> accounting under a cgroup-specific umbrella, so I hope there is some way
>> to get around these issues, but it doesn't look like cgroup fs has a
>> good way to keep task-specific stats at the moment.
>
> I'm not sure freezing/frozen distinction is that meaningful. If each cgroup
> tracks total durations for both states, most threads should be able to rely
> on freezing duration delta, right? There shouldn't be significant time gap
> between freezing starting and most threads being frozen although the cgroup
> may not reach full frozen state due to e.g. NFS and what not.
>
> As long as threads are not migrated across cgroups, it should be able to do
> something like:
>
> 1. Read /proc/self/cgroup to determine the current cgroup.
> 2. Read and remember freezing duration $CGRP/cgroup.stat.
> 3. Do time taking operation.
> 4. Read $CGRP/cgrp.stat and calculate delta and deduct that from time taken.
>
> Would that work?
>
> Thanks.

Hi Tejun,

Thank you for your feedback! You made a good observation that it's
really the duration delta that matters here. I looked at tracking the
time from when we set/clear a cgroup's CGRP_FREEZE flag and compared
that to the per-task measurements of its members. For large (1000+
thread) cgroups, the latency between when a cgroup starts freezing and
when a task near the tail end of its cset->tasks actually enters the
handler is fairly significant. On an x86 VM, I saw a difference of about
1 tick per hundred tasks (i.e., the 6000th task would have been frozen
for 60 ticks less than the duration reported by its cgroup). We'd expect
this latency to accumulate more slowly on bare metal, but it would still
grow linearly.

Fortunately, since this same latency is present when we
unfreeze a cgroup and each member task, it's effectively canceled out
when we look at the freezing duration for tasks in cgroups that are not
currently frozen. For a running task, the measurement of how long it had
spent frozen in the past was within 1-2 ticks of its cgroup's. Our use
case does not look at this accounting until after a task has become
unfrozen, so the per-cgroup values seem like a reasonable substitution
for our purposes!

That being said, I realized from Michal's reply that the tracked value
doesn't have to be as narrow as the cgroup v2 freezing time. Basically,
we just want to give userspace some measure of time that a task cannot
run when it expects to be running. It doesn't seem practical to give an
exact accounting, but maybe tracking the time that each task spends in
some combination of stopped or frozen would provide a useful estimate.

What do you think?

-- 
Tiffany Y. Yang

