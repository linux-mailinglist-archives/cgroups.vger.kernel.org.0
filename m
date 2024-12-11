Return-Path: <cgroups+bounces-5804-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC099ECE08
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 15:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07FFC283650
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 14:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C912368FB;
	Wed, 11 Dec 2024 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUmp0cVm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA1F381AA;
	Wed, 11 Dec 2024 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733926101; cv=none; b=LDc7JpbNev0mV33ceykUIP5WqWWJUvAB8PjLT/7XtHI6NLix6H08T1z7g/L50IsFSqTFmu2SSALmzgI8YbN2c8SQeWvtgibuDWt6eK2IRXu7uz/aUPcpCHXC7XcfuVu/z8Ltm2v24FsxN1Xr/OsfzmVYM0XjhxAmdS4y8OH9qU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733926101; c=relaxed/simple;
	bh=gzAq8YL0jZhrC7JLCuhzyeIX1l6HQa3wImNAgsCJI1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRRsU9sRdTANpscdwYtYqYpGjq0RxV1GqZgVxn4Ym4cfYQHNQP4JGIkl63uNT5jTriqixIQukWgEokMb0rEqNmP5yk62Afir7R0zgK63OYeIzl2zusaaNxl8T4cfdHcMUkSL9zsJdzHbyR7CULjUOE8hKBIsy8DoTzZPX38g5QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUmp0cVm; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d91653e9d7so24844336d6.1;
        Wed, 11 Dec 2024 06:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733926098; x=1734530898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCFHk8l64EnyqlgOuq7wPYYVMgx4PCOWKLcisFLb+jw=;
        b=IUmp0cVmTHyJUGI6/6WSrrs4r8Ljs/V2iLXq0ruUcKYcHEilRu7QK/HtTRb9WJmI5C
         MH0wmsYyVALVn3TiveMICMM11bhUabEGfS7VDlNKA54ZpQ2ts6q8Tbi/eWQb/86cJ4d9
         aV8QpDibCvSQL2J0tqyM6+37H1nqiC3a+bR+/jSP0TVAKZ5rgJHbZpuG7Y1tSf7/4uwF
         Klr9ZxZo3/b5q2SWn+MCPfeYLyEozlleTyV4/vkSNWGwWMUW3IiIahZucL7MLyG4HEjd
         Hnrz0ID+SWa2eOVfKoavSgp59m3ElImG0aUtv0NmsKjXmQnEvpDNaywsQL0f+Q44beNc
         vNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733926098; x=1734530898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCFHk8l64EnyqlgOuq7wPYYVMgx4PCOWKLcisFLb+jw=;
        b=HP0aqjSYSdhbNRSkj6QeqyWu9sbQuIWXhbsWqrr+4azcSa1u+Fg3IRGq3KncVK/MQp
         ObLII1Qy8azvVtNjQwhgwd4FohryaiOcGUN81l9XNx+aBzyil4BcEuv74isC9o3ADgoW
         nuaSr/Wnpumb0sdnr8GFb8eZb5wxgzBErwmBFihgwi6kRpIAAFD4moEWFLQf25UvjAHd
         /LabCWVAick4cxionvMl0D1ykbib727SzVtkmJpQhXWr+GrurLixAgAA7uvrkCH+SvsJ
         j/9FY3xWM2CAyk42rtJfH1rAl2d/rnsY8uhRGYbG042A/Q/eB4nrdfw+y935985mt7N0
         dNkg==
X-Forwarded-Encrypted: i=1; AJvYcCXb3KReAhA4oFNmgTX42oLkDvF5vXaT10gLOoDHmmSD0zIz5rj4taf9+9UTtCH6pm+rZH+5NctP@vger.kernel.org, AJvYcCXwJkBIRffuC4XtPNqPDQwl3/mJTktpTjZJd2vgEjDESPblQ9P5+IZ5o9o0tDrFJXKG1NMEo+/WJp3wG+yj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7xupDF3D5rqfZWlwtF8nvjBcjprHE7aSmB+cWIPARiaXXEF3Q
	6AHTlWQaYzCiU5/w+2chf++prsAeb4DZTR8NBi9AHywxYqUX9eBo02ENag/QGdcXQdm5hSup7mk
	lPClHi4vRAo7LZrILO0615QsNW0E=
X-Gm-Gg: ASbGnctOISXuYq7+y1KyaTgsYFyZPCtRkiNm6a8U2ngfDO3/QioAl9LZQqm9ijOtZNt
	lYLG0xlo9gQDu+Gx8ZYPPCj/gtFMH5eDE991q
X-Google-Smtp-Source: AGHT+IFs8a2HVux/ZsemMM1DT8Fr1MzZ/o/HDNSwSWyhxHCXnkDWQDaqDw69ZIj7wMUYANBgqvw9mXYTTpZfCHZkaDw=
X-Received: by 2002:ad4:4ea9:0:b0:6d3:7a47:2034 with SMTP id
 6a1803df08f44-6d9348d211emr43589956d6.3.1733926098096; Wed, 11 Dec 2024
 06:08:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211131729.43996-1-laoar.shao@gmail.com> <20241211131729.43996-4-laoar.shao@gmail.com>
 <wvqotmnk2kad3lyigbsc5vtq4ymdtaxqcjijaj2f5mdcp6m742@ltmazfge3eu4>
In-Reply-To: <wvqotmnk2kad3lyigbsc5vtq4ymdtaxqcjijaj2f5mdcp6m742@ltmazfge3eu4>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 11 Dec 2024 22:07:41 +0800
Message-ID: <CALOAHbB_i9rpG03FVKE5gyue0hpM-gE5V=X2gcjTXHjP2yNTGA@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] sched, psi: Don't account irq time if
 sched_clock_irqtime is disabled
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: mingo@redhat.com, peterz@infradead.org, hannes@cmpxchg.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	surenb@google.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 9:56=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Wed, Dec 11, 2024 at 09:17:28PM GMT, Yafang Shao <laoar.shao@gmail.com=
> wrote:
> > @@ -1286,7 +1286,7 @@ struct psi_trigger *psi_trigger_create(struct psi=
_group *group, char *buf,
> >       bool privileged;
> >       u32 window_us;
> >
> > -     if (static_branch_likely(&psi_disabled))
> > +     if (static_branch_likely(&psi_disabled) || !irqtime_enabled())
> >               return ERR_PTR(-EOPNOTSUPP);
>
> Beware this jumps out for _any_ PSI metric when only irq is disabled.
> I meant to add a guard to psi_show() (this is psi_trigger_create()).

My apologies, I'll fix it in the next version. How about the following
change instead?

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 7341d33d9118..263c26a36511 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1233,6 +1233,9 @@ int psi_show(struct seq_file *m, struct
psi_group *group, enum psi_res res)
        if (static_branch_likely(&psi_disabled))
                return -EOPNOTSUPP;

+       if (!irqtime_enabled() && res =3D=3D PSI_IRQ)
+               return -EOPNOTSUPP;
+
        /* Update averages before reporting them */
        mutex_lock(&group->avgs_lock);
        now =3D sched_clock();



--
Regards
Yafang

