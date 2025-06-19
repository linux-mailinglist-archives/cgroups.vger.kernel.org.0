Return-Path: <cgroups+bounces-8600-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE529ADFBF9
	for <lists+cgroups@lfdr.de>; Thu, 19 Jun 2025 05:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0173BE9D7
	for <lists+cgroups@lfdr.de>; Thu, 19 Jun 2025 03:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB334228CBC;
	Thu, 19 Jun 2025 03:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="et0by071"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B586F1C549F
	for <cgroups@vger.kernel.org>; Thu, 19 Jun 2025 03:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750305040; cv=none; b=Z8uWSt5FfTEzymooKlJveZa6nrxI5gGrUne561nc/8mifXPKrf8QReD22zgWFod2dxYIt6bf9Q2k1/G5JvbSQTNralCJO+2mchZV9izAZ3nCFMiUn87q7IQ7Pw2EFnvXraiaUu/PoiukX5CSQBbIHmLqlb1K4LIFYFwKuj42daU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750305040; c=relaxed/simple;
	bh=pqrw6/9BHgywfLi/lqVFm9DkWmg99AULXG9dRn96nww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/YKL8KPXBr7WgxaUYOfiet1IFbNZiROcqLyLfBB9IF7CQ3RK/PJcYdBnK7PT8eKjkrt+w75gmqwO90EhbJqu/8N42Mlk9pGrnBAJJaa9xn/z9CaOuby/HV52mqdK2lDGJt1+Mt7NoJuqwBhi9fwb69BdMrUEjFNRKTKnTFXC/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=et0by071; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54e98f73850so259633e87.1
        for <cgroups@vger.kernel.org>; Wed, 18 Jun 2025 20:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1750305037; x=1750909837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YolbIVvniBT6751HPBANG23kZ3+67ebn78JoEy5EXfU=;
        b=et0by071JYesZMGFbJS/1l2LxGRkML9qAC3ulbjxsL4HJuoxN1+AzccOvDeZ9u5KI7
         U1PNGnn+UNaqIY84DwMjXUMITUuxP7fFBVN13sKeZYjIYI+vbpbkROfQ7T5ZeAwpOqdn
         8vPnb2nXb6rjl2bQZVXvQgQWiRClrI80Ly4F8Xnr5WloopWp6It3bLVAdymPDF0nSvJ0
         4xm2FtA0+vaFQLsvbzHRyl6NgaNZJCjmlxMRHK+5ehoJAuubHxyVikepbel3l4FzgBJd
         RZFf3MQt14Aj+NeMx8dUfoKOlWC/+pknWu8bCZ3lbL5Bcd3uAH9LWtspcVn2bFW6pFxm
         iQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750305037; x=1750909837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YolbIVvniBT6751HPBANG23kZ3+67ebn78JoEy5EXfU=;
        b=qsLWSlv9Htx/4Bug+B1aAkRPCXUgX9Pqqn7NHZhYyeZFkKSpIXzcb3BF02+fDyiB9K
         UXny0rZklZyL/etcakEevl/dJif20ojKuXZcy4MtzPLppSP16Tav+/XR10U8Rnu8WcQO
         XXX94tdirndYPEaIKtLKHwGF0Lhda9f4KInu8RcekfV+hYjSIUMbIsrr6bFXznWy5NMl
         4EdHjp87HUZZKGd5O2yPtAVzMSUgMLNbiwHCJHnTXz3PkJAf8u/GrqRc97viOUutt5J5
         co2MjVuLw7Vcy0FmQirsGkrJkgYijYnsbGcljYEKp4H133bOiCrSmpbUod1NO1Gznuby
         CArQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuDckvj2WtqFi8cAA6jLTXvn90/D3SdeLPtArUllSsRtXZGUN/WyHzs9eHyfWyD/limitwbwfa@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu3HrLkiEJS+8+vezujmkYP9PPmVniryh+hhIZ4XPLWLuH0uNL
	bGqAT109Hre/ZUkcsDGhlV20MXAHZmCHqE23gS8ix8Im2PHBetATq+l6gd2Os7crGa2zV9LpppM
	77Qcr/xoAxu29lOluKsTBz4KwgiD3Uiry6zOXZ6Geaw==
X-Gm-Gg: ASbGnctMU2tI6h+WMYW0kho2RaWFsQdcNGd+sGf39UwhT1A1iTgJ4F0BvcVQ9Sp4Rf0
	vk1Jo4NmX7+esUsw8n2g6mTrzpqBLafAhf+8cZn+3pV1LlTxk7NloBDZ/bE0IvivlMM/r8yg6Zd
	Z10nGpLR45TgdxQn3bwiwFygWiYn9FDZ6IfX0zFdIjF3kL/AB/5amQRU9SkA==
X-Google-Smtp-Source: AGHT+IHpltUrLNuq9nIorOoo+2iB2Q1zkjadBe7Khn4P/l9/IDmG1oDSjSumBXfasQEgDqAn9JdNEGve8qxaN277HJw=
X-Received: by 2002:a05:6512:3989:b0:553:543d:d996 with SMTP id
 2adb3069b0e04-553b6f0f91bmr5767343e87.33.1750305036765; Wed, 18 Jun 2025
 20:50:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8029d719-9dc2-4c7d-af71-4f6ae99fe256@redhat.com>
 <CACSyD1Mmt54dVRiBibcGsum_rRV=_SwP=dxioAxq=EDmPRnY2Q@mail.gmail.com>
 <aC4J9HDo2LKXYG6l@slm.duckdns.org> <CACSyD1MvwPT7i5_PnEp32seeb7X_svdCeFtN6neJ0=QPY1hDsw@mail.gmail.com>
 <aC90-jGtD_tJiP5K@slm.duckdns.org> <CACSyD1P+wuSP2jhMsLHBAXDxGoBkWzK54S5BRzh63yby4g0OHw@mail.gmail.com>
 <aDCnnd46qjAvoxZq@slm.duckdns.org> <CACSyD1OWe-PkUjmcTtbYCbLi3TrxNQd==-zjo4S9X5Ry3Gwbzg@mail.gmail.com>
 <x7wdhodqgp2qcwnwutuuedhe6iuzj2dqzhazallamsyzdxsf7k@n2tcicd4ai3u>
 <CACSyD1My_UJxhDHNjvRmTyNKHcxjhQr0_SH=wXrOFd+dYa0h4A@mail.gmail.com> <pkzbpeu7w6jc6tzijldiqutv4maft2nyfjsbmobpjfr5kkn27j@e6bflvg7mewi>
In-Reply-To: <pkzbpeu7w6jc6tzijldiqutv4maft2nyfjsbmobpjfr5kkn27j@e6bflvg7mewi>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Thu, 19 Jun 2025 11:49:58 +0800
X-Gm-Features: Ac12FXx40uf43iyBgKM0BLFSLGPsXPQ2pByqjOiXn1b6gvpuapC4lhHK5kvY7Zo
Message-ID: <CACSyD1MhCaAzycSUSQfirLaLp22mcabVr3jfaRbJqFRkX2VoFw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] cpuset: introduce non-blocking cpuset.mems
 setting option
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Waiman Long <llong@redhat.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, muchun.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 5:05=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Wed, Jun 18, 2025 at 10:46:02AM +0800, Zhongkun He <hezhongkun.hzk@byt=
edance.com> wrote:
> > It is unnecessary to adjust memory affinity periodically from userspace=
,
> > as it is a costly operation.
>
> It'd be always costly when there's lots of data to migrate.
>
> > Instead, we need to shrink cpuset.mems to explicitly specify the NUMA
> > node from which newly allocated pages should come, and migrate the
> > pages once in userspace slowly  or adjusted by numa balance.
>
> IIUC, the issue is that there's no set_mempolicy(2) for 3rd party
> threads (it only operates on current) OR that the migration path should
> be optimized to avoid those latencies -- do you know what is the
> contention point?

Hi Michal

In our scenario, when we shrink the allowed cpuset.mems =E2=80=94for exampl=
e,
from nodes 1, 2, 3 to just nodes 2,3=E2=80=94there may still be a large num=
ber of pages
residing on node 1. Currently, modifying cpuset.mems triggers synchronous m=
emory
migration, which results in prolonged and unacceptable service downtime und=
er
cgroup v2. This behavior has become a major blocker for us in adopting
cgroup v2.

Tejun suggested adding an interface to control the migration rate, and
I plan to try
that later. However, we believe that the cpuset.migrate interface in
cgroup v1 is also
sufficient for our use case and is easier to work with.  :)

Thanks,
Zhongkun

>
> Thanks,
> Michal

