Return-Path: <cgroups+bounces-8340-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95485AC2D0E
	for <lists+cgroups@lfdr.de>; Sat, 24 May 2025 04:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A041BA6FC6
	for <lists+cgroups@lfdr.de>; Sat, 24 May 2025 02:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B3E193402;
	Sat, 24 May 2025 02:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PU8clbf7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CD87E9
	for <cgroups@vger.kernel.org>; Sat, 24 May 2025 02:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748052617; cv=none; b=g9N/kxnlJNyLXkF61IPbGbmpbZok7R8VzerRldpsJTAyGT3KAUPCmgb5z3pPhsjCBH0ojdGVZFPZ9TH2uPQXAlObnXGK/BoO4zVl8GZhhKtaHZBZPv7OJxPxU4X1JHM1ejZA5OEubfzcutx+JBxtlNZcEYssJG/JzYsW0VBu224=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748052617; c=relaxed/simple;
	bh=o4MvvKaZWgzzKt41LfWGF6XxHz6DvTMbHLbGblGx36c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gN05clQuAkZ5PPm+Gm0nbC3/Oys0e01QwH2QkcbkJxS72g4vTzO5OR2DuYQ/S4syz9E+0sdYEoRGijTa7aVrxAaLbouZCxjt759h5knhs0eoa0K7BtgB+CVepD23O1vCo0Y82NsSAn4xYO3qKhxC1TF7djwZsaP3MdbjoKXszbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PU8clbf7; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3280ce0795bso3634921fa.2
        for <cgroups@vger.kernel.org>; Fri, 23 May 2025 19:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748052614; x=1748657414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7TEkWtOA1fKJ9Z3MfHUljq+ctXCp/GLeazv/q5J3eQ=;
        b=PU8clbf7ukGyCeKd2uECagqv+9gGN324heIc/TboTLadTrNfcI6gRgMdVIJs08wmcn
         X42OPZ7l+1wt963IY0v/9i5xk+RNeqJeq96ubhCD3XldzXdRAThqlHFbs5X5cUd7kx3p
         8wOv5YGVujzxT7P+ZiRSQi3dovTWwEZIcQ/rcFG1Xircbe0iXKQYpJuky/gFsQ/uijyX
         bqR+6lo60OCKASBDJvBjFVuzR59Xu5RRKQXMpANgS1wExW+DYfPnZOTVMnWUKLMDIAG5
         WCoMTm8ajiI2TUS8mQZuvWeSRE5jWGxy27des1VDojRxzIUkem86+j8yaZaKS1QNlpd4
         JVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748052614; x=1748657414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7TEkWtOA1fKJ9Z3MfHUljq+ctXCp/GLeazv/q5J3eQ=;
        b=nPyvCHa3+0Ai+dzHTfLjsjJWpjmLKS1lLedl5lSRDnb4SDi+dfAWeF8LXubs3aWasg
         26SOMBeMy8HOtnZeaWGxn5lZvk9ii0wgtGtKvHJeRjYbcUFrUJlcVUT6VKfM6mEvZivX
         11pDY19HMfOFeCwb1A8IiJIi76WBbRyD4pOXd3EcVGQ62LRR0IGFg7E7rZW4HyBOaZR9
         ky/eyTkw3njSugrP4Wu6dfWOTHbh1Kna4EYA/xftOql7f6ZmEhHi1+p/DlfOkF42le6C
         jKTjCfzRs3fez/wtKikBPeWhtn0zE5NadiYdV/gjTcv89BR2FdAiFQ+MwN0R4AayRjKp
         ECBA==
X-Forwarded-Encrypted: i=1; AJvYcCWlFGQSlFY2R8BGWILbIHK94wxMUw6Y0QGTxEVAUz772m4gViQv8qPFeGPCvmYBnXbpOJ/W6trV@vger.kernel.org
X-Gm-Message-State: AOJu0YwsgjlsjNZjGDmJ/wUBmSfyBcaZ6hlp1sDr3wfPEwSSATjjKsFf
	gpHuH7HsH57uS8heaXs2vBqru1cFrR/qoWcd7cotk1L+3ebEgO61FO4m4thWf+ErQrYBR4Kugjm
	EZtBC4PCrEaTGxFCYCzMDfQSGfJWIgxpzoQRPBql1sA==
X-Gm-Gg: ASbGncsVtiy52cei0Pk3Wp7HSVEwSOvzNfsjNxbf00Rq7He0nx2No18DiuyRgXuLTOP
	mcTIAX91GMe0jcP5JaROCCiBfHBShZ7VruXLcgrSU2JxwEulPKIaLeILkuBCbDxOhTgiTb72ZqZ
	nTGCXiR+2YzcKNQ/PEJDxX4urVDFb+0UpbM2jva0c=
X-Google-Smtp-Source: AGHT+IHY5XW6K8OSyPXphlOcDwKBn+R3ju+NDtjgbho1Jx9msYMJnMGN5LmUHY0PKXrBeRjomdAYIIuLKlv3vv3K5ec=
X-Received: by 2002:a05:6512:1242:b0:54e:751f:40a2 with SMTP id
 2adb3069b0e04-5521c7adc37mr417766e87.14.1748052613881; Fri, 23 May 2025
 19:10:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520031552.1931598-1-hezhongkun.hzk@bytedance.com>
 <8029d719-9dc2-4c7d-af71-4f6ae99fe256@redhat.com> <CACSyD1Mmt54dVRiBibcGsum_rRV=_SwP=dxioAxq=EDmPRnY2Q@mail.gmail.com>
 <aC4J9HDo2LKXYG6l@slm.duckdns.org> <CACSyD1MvwPT7i5_PnEp32seeb7X_svdCeFtN6neJ0=QPY1hDsw@mail.gmail.com>
 <aC90-jGtD_tJiP5K@slm.duckdns.org> <CACSyD1P+wuSP2jhMsLHBAXDxGoBkWzK54S5BRzh63yby4g0OHw@mail.gmail.com>
 <aDCnnd46qjAvoxZq@slm.duckdns.org> <CACSyD1OWe-PkUjmcTtbYCbLi3TrxNQd==-zjo4S9X5Ry3Gwbzg@mail.gmail.com>
 <aDEdYIEpu_7o6Kot@slm.duckdns.org>
In-Reply-To: <aDEdYIEpu_7o6Kot@slm.duckdns.org>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Sat, 24 May 2025 10:09:36 +0800
X-Gm-Features: AX0GCFtSw_BI9F2a_IL3u-e95lEJrbiFfnBD-W_brUziurfcRh6cHEni89aqwos
Message-ID: <CACSyD1N2CjY-yqcSg+Q6KHKGzzQnio9HjwUHutup+FEX08wg0g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] cpuset: introduce non-blocking cpuset.mems
 setting option
To: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <llong@redhat.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	muchun.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 24, 2025 at 9:14=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Sat, May 24, 2025 at 09:10:21AM +0800, Zhongkun He wrote:
> ...
> > We move the task by modifying the cpuset.cpus and cpuset.mems and
> > the memory migration is an option with cpuset.memory_migrate
> > interface in V1. After we relocate the threads, the memory will be
> > migrated by syscall move_pages in userspace slowly, within a few
> > minutes.
> >
> > Presently, cpuset.mems triggers synchronous memory migration,
> > leading to prolonged and unacceptable service downtime in V2.
> >
> > So we hope to add back an interface similar to cgroup v1, optional
> > the migration.
>
> Ah, I see, so it's not that you aren't migrating the memory but more that
> the migration through cpuset.mems is too aggressive and causes disruption=
.
> Is that the right understanding?

Yes, exactly.

>
> If so, would an interface to specify the rate of migration be a better
> interface?
>

Per my understanding,  the interface of migration rate is far more complex.
To slow down the migration, moving it to the userspace can also help determ=
ine
when to carry out this operation.

Perhaps we can give it a try if there is a elegant code implementation whic=
h
can help the people do not migrate it in userspace.
If that path doesn't work, it's okay for us to disable the migration.

> Thanks.
>
> --
> tejun

