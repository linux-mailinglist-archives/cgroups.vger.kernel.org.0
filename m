Return-Path: <cgroups+bounces-5201-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2477C9AC94D
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 13:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53CD21C21344
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 11:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6611AAE3F;
	Wed, 23 Oct 2024 11:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRWJpznj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238D61AB500;
	Wed, 23 Oct 2024 11:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729683728; cv=none; b=jnV2m0hxrK+CJybBfgq5QocruGltEaoRgYpU0tw2Ohv0WbKojfUSqtIShqB/0Og53ZxVGqQ6tg15oISbOQQ2u17KJKzJfdwyn5tRLtfp0QixAlBgT/y/C/6Unxo3JQ84145Byu57T/52up900OoDEIWX908KW+knUDXpfhWI6tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729683728; c=relaxed/simple;
	bh=Kl/727hkIBAfNUIf6aKw4VSF2L+SHsLM5p/SxuGaXFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpqEFL/nkqvkFVpeC5gs5HbZUgETKrXCp2nsoosk7KY7Xbj8faRmkeFfqMdqhD4UsqgbQDUQd1SxbFQWfTezc1RGiMHa3K7XTYzskcE/iRyuPaLeJuK5acm/0yvyyEQnrnAzc19YCX2fYzE+CIv5weGbIv2fYlWFtoDUUs646pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRWJpznj; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71809fe188cso3208642a34.0;
        Wed, 23 Oct 2024 04:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729683726; x=1730288526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=810jMYZ38CorSXHU8xsHT8NByFpeWcHAd148xEtzxXs=;
        b=MRWJpznjCAObIYY4JoAFBnSU85phvo4og9dzPTfJfjtee/2tOE4Iim8+c1vYjzDfyr
         rnV8KopsABgJgU7UsloBPXbtIGCRPZ7CqkEEfAVRj0jNkeZg5Us/vJ6IxntQehFQJuqr
         IgfSEINuUxSth6Yn7Bg96RbxEI5n1rOnjaR1GrKcNTlqN7AcLvNwF6mphQFeqz/O7+kj
         V1a+LbjyZeAi1YmpthnS7hxKRGokJl5oUG5ICizXaHuFyyZmB6iaue3G4RPhqSWVoZsb
         ewvhjcaGodPWaJs/2AnLDATAtyAwCNlazbUUYf8PMCIYfqXLbywnnNTZuWCVWz/A67+M
         8Dxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729683726; x=1730288526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=810jMYZ38CorSXHU8xsHT8NByFpeWcHAd148xEtzxXs=;
        b=lrMH4RFqktWuJC8Xjzyl0a+4mZ0PoQHIv8WE4KuFjKA/Ns4FmSq6c0cmOTX+aV4Boo
         2FJ6HHRdwhSHEmGiA9QYisnhB/ZoNpBFydPa2vpklaeFxKMt/2n1HOmMbo3ejFPAPp6A
         py+BOV6ltNmw0T8W9TNRI0KKovnlKNxG87nioiPRViuEVxouLogn/iQAQ0QtP9OHv6Nm
         Fa/AyPGFxRa3NV1Qx60tjNLixRfEb8VlzJOyLs6BC7c/tLuU3dsXZ2cs9/gSft8eQTQh
         u3o5i3hfeSrrhqI0kRbQvptIWEwpcClWItFIUT9yVKkBnSksLsU3TvEYm761NBOh0TG6
         /bzw==
X-Forwarded-Encrypted: i=1; AJvYcCWEYPCNm29nV1jEoF3CBJsRr8/iSldFODLbHFTGU1B3e1kYuljv4PFITfboiJtZD5Pj6w20wLweKgWXnZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyikuN25BKCGQL/1XxwvigP6byL0moyCGufcva2W0hpLp8c//Z3
	SnqNOjrxHo5RdWenl+2iwzUO4B07TqHK2oaN82c4ofKHfJisqNYwgNyWWuoSTz7AAF3561y1pdi
	lgQn3C1iAAL1hmnt0WUnxWryy9Lk=
X-Google-Smtp-Source: AGHT+IEketPSFTluFAD7YIo9JaQFBf8ItBBRxUt7lrpg7fw172rV9WYDVnqddy5fh2nd+JhwAN/6xHKV+ew7RyH86/g=
X-Received: by 2002:a05:6830:658d:b0:718:1a11:79e2 with SMTP id
 46e09a7af769-7184b2b51eemr2848546a34.13.1729683726160; Wed, 23 Oct 2024
 04:42:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014031057.8199-1-laoar.shao@gmail.com>
In-Reply-To: <20241014031057.8199-1-laoar.shao@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 23 Oct 2024 19:41:30 +0800
Message-ID: <CALOAHbCoAMofLm6NV_7mT6XPZbck8Y11BveWrLV-t242Z4pbOw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 0/4] sched: Fix irq accounting for CONFIG_IRQ_TIME_ACCOUNTING
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, hannes@cmpxchg.org, 
	surenb@google.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:11=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> After enabling CONFIG_IRQ_TIME_ACCOUNTING to track IRQ pressure in our
> container environment, we encountered several user-visible behavioral
> changes:
>
> - Interrupted IRQ/softirq time is not accounted for in the cpuacct cgroup
>
>   This breaks userspace applications that rely on CPU usage data from
>   cgroups to monitor CPU pressure. This patchset resolves the issue by
>   ensuring that IRQ/softirq time is accounted for in the cgroup of the
>   interrupted tasks.
>
> - getrusage(2) does not include time interrupted by IRQ/softirq
>
>   Some services use getrusage(2) to check if workloads are experiencing C=
PU
>   pressure. Since IRQ/softirq time is no longer charged to task runtime,
>   getrusage(2) can no longer reflect the CPU pressure caused by heavy
>   interrupts.
>
> This patchset addresses the first issue, which is relatively
> straightforward. However, the second issue remains unresolved, as there
> might be debate over whether interrupted time should be considered part o=
f
> a task=E2=80=99s usage. Nonetheless, it is important to report interrupte=
d time to
> the user via some metric, though that is a separate discussion.
>
> Changes:
> v2->v3:
> - Add a helper account_irqtime() to avoid redundant code (Johannes)
>
> v1->v2: https://lore.kernel.org/cgroups/20241008061951.3980-1-laoar.shao@=
gmail.com/
> - Fix lockdep issues reported by kernel test robot <oliver.sang@intel.com=
>
>
> v1: https://lore.kernel.org/all/20240923090028.16368-1-laoar.shao@gmail.c=
om/
>
> Yafang Shao (4):
>   sched: Define sched_clock_irqtime as static key
>   sched: Don't account irq time if sched_clock_irqtime is disabled
>   sched, psi: Don't account irq time if sched_clock_irqtime is disabled
>   sched: Fix cgroup irq accounting for CONFIG_IRQ_TIME_ACCOUNTING
>
>  kernel/sched/core.c    | 78 +++++++++++++++++++++++++++++-------------
>  kernel/sched/cputime.c | 16 ++++-----
>  kernel/sched/psi.c     | 12 ++-----
>  kernel/sched/sched.h   |  1 +
>  kernel/sched/stats.h   |  7 ++--
>  5 files changed, 69 insertions(+), 45 deletions(-)
>
> --
> 2.43.5
>

Hello Peter, Hello Ingo,

Do you have comments or any suggestions on this fix?

--=20
Regards
Yafang

