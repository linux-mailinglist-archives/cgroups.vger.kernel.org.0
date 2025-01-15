Return-Path: <cgroups+bounces-6161-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90204A1178E
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 03:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA99718844C4
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 02:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C3A22E40F;
	Wed, 15 Jan 2025 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxYF56AS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC4122E3E9;
	Wed, 15 Jan 2025 02:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736909946; cv=none; b=eFThb/V/wA5gs57Ugj9PFlun8GPN9Io/jFL/XrjkPTwFGu96IVzp0LMxLmnUX4DuMDsAaI0/0xINpQT4wT23n9hGn81uOEq2SxAMixcUDOLBagKi8khpoAyKAvO9cvMX14CLQxLVYX1CoZr9/tfRbt3CyDH5tS5YEdhtFi3EHc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736909946; c=relaxed/simple;
	bh=jwU7aCyg20KNF7ssdjXpO2OEORgrVNvi3ngrOHwEZ1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqzk2x4sRUUt3Ukvbk0K8SAf8zarKHXguX09CCyXzEICrlYP26e4bhLVZtXruXnQOrii+48xxykwnrBH9A9ODQ/hXx/ZzqjBAgm0LndI90Tv+cJAprkY9YzEe4MfUmS1zj9bCKgQ+8oxCNCSJLtEgsC175qpbtfrBTmgrVQZEUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxYF56AS; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b6e9db19c8so502107685a.3;
        Tue, 14 Jan 2025 18:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736909942; x=1737514742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeNYRqCXp83bmP8MaMvN/WFLlPcmxObNXoivEWRhmTA=;
        b=HxYF56AS3HhHq+HAiZRmC4Dez16cTPKcY0aLTtL8OLF0CmsuYSl9OPbCFVT8Mkb15g
         +UANlpmL2RgJFdmnyYiC9ABHw9gUabweGPD6WzUI5Sh3ZsXAOx9C+1rexrIX+/12KFX0
         lZIL/Qgem8G5BgMMDrl9RVO1nHjzQIj+s3qynD83NajsAAlXs9mS1ZLeTDjpcN2oXIhT
         dLUxL3lQzk4tSAQ2TynGMdyrXatU27n3V1PhFC704wHICwjdlZ856RtELsYTXQUW2QU9
         Pg58Y6FbXiiV8ATCx3Ua97ecFviolIr0YeiYgo9DOK/Zh2d1z8kWcEmZ3sl9M1sJIO42
         e1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736909942; x=1737514742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WeNYRqCXp83bmP8MaMvN/WFLlPcmxObNXoivEWRhmTA=;
        b=Eqhc6vxsCYyDNP8ppRJNKK6DozI7vZyfM+CpkkEBXLBLYMSPGc9ACmQNHUNL6WTICr
         XyEey1U2/21SAt9OoKiqBGigZLnGT1QNwJ+VMK5DQqmgMhNmHYIKNF9AcnWhkCvWv7nr
         YrbLOMV0Q/mTF6fz1X/QzZazt+2QzeENBbT81LrWFDUJ0IRAE5/2C+0G79SQkOFLSDXY
         MvK7wqNC4Rpbb/rqJBQ1uaUGIso7d7Ss0hyuJb5shT32EFthSLfbovdnw/NptYGmkuG+
         75xGvqXTE5tAmyzmMJVKdEcAjaPDdAM3blpq7COw0xh5h6aYxOe9oHMP0d6FQsgva/5Y
         g7Ww==
X-Forwarded-Encrypted: i=1; AJvYcCV9ao7Odf4acVJ7MB38phFaYCMSkuZ7/huUjC4M1GsdBbmH6gURnjR2tlqmPc4ULQowIM2A2mJe@vger.kernel.org, AJvYcCWdU47YPcUx7ANLJw46SiWk29Akhfi6pAGIhSl79qqp5AGTkQL7WdFYLovY1HSaT7KE18gU5g9W4XUwljUt@vger.kernel.org
X-Gm-Message-State: AOJu0YzE+Lo0E4IH8PGZ2oQ4VnHMklIUTl1bHC5hgtOFLEA0tmhVQbe+
	I0F+o9sYbZcVa5Ph+1qlykQPC/FONbON3STwnKlu0VsGIBcx4GLs65Abw7NXtxpSgx9anbmLnT5
	729Cd6kW6McJkgj0jmxYY/Fu683s=
X-Gm-Gg: ASbGncvw7pyG8eQ1/9jDytGQQHNMHIk/702TT+NQFwPmyeK0b3BUYtuiB6mbA9GvsFx
	j4VzAjSH79eqMa7jRMJoYRMCzoRLmlaxFT3gm
X-Google-Smtp-Source: AGHT+IGno1xvnkB2a1XVPVlPICRUZzwEN2fyLLcNQGhACuu6B6Dd2i+2S669m6D304fmzbWwo0olKM1xfYuMRUBu4mw=
X-Received: by 2002:a05:620a:136c:b0:7be:39e7:a025 with SMTP id
 af79cd13be357-7be39e7a116mr1308964785a.26.1736909941703; Tue, 14 Jan 2025
 18:59:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103022409.2544-1-laoar.shao@gmail.com> <20250103022409.2544-5-laoar.shao@gmail.com>
 <z2s55zx724rsytuyppikxxnqrxt23ojzoovdpkrk3yc4nwqmc7@of7dq2vj7oi3>
 <CALOAHbAY8MLDT=EdzY6TzQv3ZF4OGXTWoWBEs45zQijZH4C0Gw@mail.gmail.com> <kc5uqohpi55tlv2ntmzlji7tkowxjja7swpwkyj6znmdw6rnjl@4wsolhiqbrss>
In-Reply-To: <kc5uqohpi55tlv2ntmzlji7tkowxjja7swpwkyj6znmdw6rnjl@4wsolhiqbrss>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 15 Jan 2025 10:58:25 +0800
X-Gm-Features: AbW1kvYkzOEijQezgrK4c3_lkbEW6vqMx6hrDrzxhJWbJfD6ZrxWdwc7CZvGmUw
Message-ID: <CALOAHbDRA5Ak-N4DyHfNhVhVMT-8CuVVagkgYNv2nBB6eNqFsQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] sched: Fix cgroup irq time for CONFIG_IRQ_TIME_ACCOUNTING
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, hannes@cmpxchg.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	surenb@google.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	lkp@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 11:48=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.c=
om> wrote:
>
> On Thu, Jan 09, 2025 at 09:46:23PM +0800, Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > No, in the case of !CONFIG_IRQ_TIME_ACCOUNTING, CPU usage will
> > increase as we add more workloads. In other words, this is a
> > user-visible behavior change, and we should aim to avoid it.
>
> I wouldn't be excited about that -- differently configured kernel is
> supposed to behave differently.
>
> > Document it as follows?
>
> That makes sense to me, with explanation of "where" the time
> (dis)appears.
>
> >
> > "Enabling CONFIG_IRQ_TIME_ACCOUNTING will exclude IRQ usage from the
> > CPU usage of your tasks. In other words, your task's CPU usage will
> > only reflect user time and system time."
>           reflect proper user ...
>   and IRQ usage is only attributed on the global level visible e.g. in
>   /proc/stat or irq.pressure (possibly on cgroup level).

I completely agree with you that it's essential to clearly document
this behavior change. Thanks for your suggestion.

>
> > If we document it clearly this way, I believe no one will try to enable=
 it ;-)
>
> I understand that users who want to have the insight between real system
> time and IRQ time would enable it.
>
>
> > It worked well before the introduction of CONFIG_IRQ_TIME_ACCOUNTING.
> > Why not just maintain the previous behavior, especially since it's not
> > difficult to do so?
>
> Then why do you need CONFIG_IRQ_TIME_ACCOUNTING enabled? Bundling it
> together with (not so) random tasks used to work for you.

Our motivation for enabling irq.pressure was to monitor and address
issues caused by IRQ activity. On our production servers, we have
already enabled {cpu,memory,io}.pressure, which have proven to be very
helpful. We believed that irq.pressure could provide similar benefits.

However, we encountered an unexpected behavior change introduced by
enabling irq.pressure, which has been unacceptable to our users. As a
result, we have reverted this configuration in our production
environment. If the issues we observed cannot be resolved, we will not
enable irq.pressure again.

>
> > We=E2=80=99re unsure how to use this metric to guide us, and I don't th=
ink
> > there will be clear guidance on how irq.pressure relates to CPU
> > utilization. :(
>
> (If irq.pressure is not useful in this case, then when is it useful? I
> obviously need to brush up on this.)

It=E2=80=99s not that =E2=80=9Cirq.pressure is not useful in this case,=E2=
=80=9D but rather
that irq.pressure introduces a behavior change that we find
unacceptable.

Our motivation for enabling irq.pressure stems from the lack of a
dedicated IRQ utilization metric in cpuacct.stat or cpu.stat
(cgroup2). For example:

 $ cat cpuacct.stat
  user 21763829
  system 1052269        <<<< irq is included in system

 $ cat cpu.stat
  usage_usec 3878342
  user_usec 1589312
  system_usec 2289029   <<<< irq is included here
  ...

To address this, I propose introducing a separate metric, such as irq
or irq_usec (cgroup2), to explicitly reflect the IRQ utilization of a
cgroup. This approach would eliminate the need to enable irq.pressure
while providing the desired insights into IRQ usage.

WDYT ?

--
Regards


Yafang

