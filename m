Return-Path: <cgroups+bounces-9755-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AF2B4656B
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 23:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 048731CC3E41
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 21:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A192E8893;
	Fri,  5 Sep 2025 21:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ioNP7jGZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2B726CE35
	for <cgroups@vger.kernel.org>; Fri,  5 Sep 2025 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757107225; cv=none; b=qC3fGCfSmwo3/wOsAJnzayP8VyVujiS6XOnjpou5Nkl/G1CPWghnKMP4gV24Oe5L8yvVVeSZ0eCrYjV20Mq4zCcoKj2Joas4PxB2VIPMuvf4VRXTvXGUf1tQbY9mg+8cv2mlqtGLMNHm4q339pLrnq66gFpJkPW88ucIz/BiQSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757107225; c=relaxed/simple;
	bh=1CyIY4Gge20GP7y0cDU45m2jcj75ZJgT0UYbOpjMvYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2x+M23dtV5fKBZMZo65SfI/s8bw5775TpdSJX/kzcLhL+u6oABiqIICmZFxIytVd41gFlpGtPZjy65OPpCJgrUgUG35ekTemwqm3kK3agEItlAbf9VNpuplR8+/Bc9SRjrTI1uEYV85KzeljWACMgCVXw0F8t+q0DPJ+BDl+1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ioNP7jGZ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55f76277413so3137641e87.3
        for <cgroups@vger.kernel.org>; Fri, 05 Sep 2025 14:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757107222; x=1757712022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihoNevlLzJDBSuy8DxcqIRmMmQ3q65NAy+tYYX30mhs=;
        b=ioNP7jGZrNMEGC0ABOigOo6NON0Ybh9/ggyGYDsJa0sFbX4ib5XP6Utr4LF52VgClJ
         FCpCRlSABhxNvdOCo0Ev+SRNM21pJVPD0Y61/2aKFumdt+aVp8xfPftbxAOaqpIz/jyB
         UCIAxD5NPUM58Ex1z+cDtVuz8QKu8nRpSrKb3PWyzFBh2PJmxySEokajbRKsuwyE2sol
         VtwZrX7b0e7x3aBOn5C3O0ZY8exHhGhGSWjLp3cvTWO2jtN0cdIzOH+0KIPjyz78rOP/
         jkULYyGOK4VbHHjCJX0g6DpgDFPHz1iplCvzlzGa7ABbZz/8BQCvibMsQbwT6ZVVaUNu
         30Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757107222; x=1757712022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihoNevlLzJDBSuy8DxcqIRmMmQ3q65NAy+tYYX30mhs=;
        b=DvsOM5IbfYcxaMTdZmbGMYfkldhJh87FL77pJaGfpgB7hMg+Kie+VyDU+srXz5PKWE
         5mrgOPmq2UPJnKItZtweHdZh+fN/j3vBiutVD5RDE00BsuLZ1WsIPE8j0TiGdS0PuKTl
         Qt1y8707GFbmNjNf7+5mxbViy9+OXrDXq5Z2/unXeCI7eBoKVJydCDCuOayfjrPC1D6D
         63jf4Lds4OmRg8+vCjCqVzKqtTzI0LegtFZwch61D1O4q2QE7/rdtlwWlENi9zk7Dd/U
         rBeDeVyiUP9ztGwAmROjB1DxGgSaL3vQA0SGCNZgXWZUqlHAPc4wPPUcvAv8IjBk4I0u
         UE9g==
X-Forwarded-Encrypted: i=1; AJvYcCWKtVLqYeLhsmmK7UO3joIxp7QOZTPEs2kBmu8K8MfaNX9CsFB+FC+UqSE4KOWMY1zsjoa4EC2+@vger.kernel.org
X-Gm-Message-State: AOJu0YwpNvmg1cB+67TRsd+QRtCDGUP0U0MfySUgoJTuFDXkIyvvBaW1
	OapUxk/R9BIpTHhguotfJAh9FoM/nqnoYqnPri8eQBcwYpobxO2MXwrSwg1ExJul/bQTUNUPjS6
	R5+ME7EMzn3bmbtsZFbaGNK6qWcObSDulKDR7SQA=
X-Gm-Gg: ASbGncvptg8KZW9hnDbNxRpG4fgcwn6qBJ4fk8cXxyfvk9RJr1IdtjGC6vcbaSVDDwS
	1oqZMZ5YDqaJpTkYRCGxrZeCwQQSAl9nR0XU8LTN8O24RbuAyGCDQlonrLwBncl6D/Z+UKxzvNA
	uI0JyAWxDTRxBXx4mXdWw6EYZVRMWbYHLOuz+bMsTPKsVxJ2M4FD7c6RTTGmHnEIIHrFZ6yG4Mr
	bf3JXNXjeOm2mfhBc1/pwPlqnPtl3pLWO8CgWxSgwIiNlDFFh7hmg==
X-Google-Smtp-Source: AGHT+IGklKSxmgtyLJoi1vvHN7sLHpD+0Iy8PrXyLbJxGTq/1I6kUc4ziYI23n3kTAxDik0wCpIxXBb5i2BdIOMmD6k=
X-Received: by 2002:a05:6512:3b12:b0:55f:6831:6ee7 with SMTP id
 2adb3069b0e04-562601b5384mr78383e87.21.1757107221283; Fri, 05 Sep 2025
 14:20:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYv0mbEBVs0oTiM+H4X-y7ZCwYpfa0hGCQCeVkW2ufGD_w@mail.gmail.com>
 <CANDhNCpWWNpBQfeGq_Bj1pEWTYULJGaubTuPJ2Yxjg4_ESzgBw@mail.gmail.com>
In-Reply-To: <CANDhNCpWWNpBQfeGq_Bj1pEWTYULJGaubTuPJ2Yxjg4_ESzgBw@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 5 Sep 2025 14:20:09 -0700
X-Gm-Features: Ac12FXyJR8KmvN8T2fwKhwhjrwRXLtrixZllcL7-1u48pK2bWIjS9VPSJc01V20
Message-ID: <CANDhNCrJYMcK+dak8ASX6uoVFkNSHMf3Bn1kOXDtqNqFb7LkJQ@mail.gmail.com>
Subject: Re: arm64/juno-r2: Kernel panic in cgroup_fj_stress.sh on next-20250904
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, Cgroups <cgroups@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 10:50=E2=80=AFAM John Stultz <jstultz@google.com> wr=
ote:
>
> On Fri, Sep 5, 2025 at 6:21=E2=80=AFAM Naresh Kamboju <naresh.kamboju@lin=
aro.org> wrote:
> >
> > Kernel warnings and a panic were observed on Juno-r2 while running
> > LTP controllers (cgroup_fj_stress.sh) on the Linux next-20250904 with
> > SCHED_PROXY_EXEC=3Dy enabled build.
> >
> > Regression Analysis:
> > - New regression? yes
> > - Reproducibility? yes
> >
> > First seen on next-20250904
> > Bad: next-20250904
> > Good: next-20250822
> >
> > Test regression: next-20250904 juno-r2 cgroup_fj_stress.sh kernel panic
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Thank you for the testing and the report here!
>
> > Juno-r2:
> >  * LTP controllers
> >    * cgroup_fj_stress.sh
> >
> > Test crash:
> > cgroup_fj_stress_net_cls_1_200_one:
> > [  365.917504] /usr/local/bin/kirk[402]: cgroup_fj_stress_net_cls_1_200=
_one:
> > start (command: cgroup_fj_stress.sh net_cls 1 200 one)
> > [  374.230110] ------------[ cut here ]------------
> > [  374.230132] WARNING: lib/timerqueue.c:55 at
> > timerqueue_del+0x68/0x70, CPU#5: swapper/5/0
>
> This looks like we are removing a timer that was already removed from the=
 queue.
>
> I don't see anything obvious right away in the delta that would clue
> me into what's going on, but I'll try to reproduce this.

So far I've not been able to reproduce this in my environment.  If you
are able to reproduce this easily, could you try enabling
CONFIG_DEBUG_OBJECTS_TIMERS to see if it shows anything?

thanks
-john

