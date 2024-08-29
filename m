Return-Path: <cgroups+bounces-4597-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FB2965365
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 01:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D111F23F93
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 23:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E43B18EFDE;
	Thu, 29 Aug 2024 23:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="IfosvDL5";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="sGSHPI7U"
X-Original-To: cgroups@vger.kernel.org
Received: from mx-lax3-2.ucr.edu (mx-lax3-2.ucr.edu [169.235.156.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85500189F5B
	for <cgroups@vger.kernel.org>; Thu, 29 Aug 2024 23:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724974093; cv=none; b=g+va5xVE0EtZiofMPHGV+GQ7S9JtdJ90Fd2VBc/7kKAcc4FgAfvg7b1GUqm1SP7jVMmhjqUayEqq/pYnp4Nulhj4EXpdnHSOTKtuHg/lCaoZnf+7sZOtuvl+17o4v24IlDbfpPue6+FDcw6t3bZKLA3rPWKbqTzceW3bqVl7LMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724974093; c=relaxed/simple;
	bh=aPBGdzIUtqksQ7B6dOMgEsV38mKnXn6qQ25F7q2ECnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=olRLiyL3rtCJ6nYt3rTu/DO8wvRqln6TmrHTaiuyvkuXWN6xF4oNS3EkVABbasmn7LaMoZ51kKwxXWlgoXI9r3bNe4xTVTWLZAXQlHgg7XcBtk0/nJEeKt/cnEZJzRsuMsNnYrf6jGOoHOL4QF77N8rzr/aNhrfhpoKp/74UOag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=IfosvDL5; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=sGSHPI7U; arc=none smtp.client-ip=169.235.156.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724974091; x=1756510091;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=aPBGdzIUtqksQ7B6dOMgEsV38mKnXn6qQ25F7q2ECnI=;
  b=IfosvDL5Iy402vfw4gxqgbqwsvLWi0LA34+nFQoi/PTBsy2V0hPZWgIt
   fubAQAOO0WaTblD8PN7aE1C31B5GBjWZhQ5yCJ8425Zq1VN6jdu8PioXv
   8KtmIjE0k2YAwCEgji1slSPWhY6UhUiicaGEjXoQoM4UxMcnuntH9IbAn
   Qqs6f5cDiC9umJLMJWG7Fsob5fTeep4PAMyJdLaJ3wakVdmmCD09ZcM/H
   ErjKd1NncMPZDtMOc2zbZ+piEPAPWcToVL4/QC8b8xGgaqVRyJm6dAzWy
   jUxOPpSETuIohgfAb5C68iAXG+orrvwijeKyNX8U1JypEDovxZ9lheyQd
   Q==;
X-CSE-ConnectionGUID: 4fGTX9g3RIy0aMdmyu+RdA==
X-CSE-MsgGUID: CZIvu+DjQ4O95qnUFCQciw==
Received: from mail-pj1-f71.google.com ([209.85.216.71])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 29 Aug 2024 16:28:10 -0700
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d432914cc7so1112669a91.0
        for <cgroups@vger.kernel.org>; Thu, 29 Aug 2024 16:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724974090; x=1725578890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPBGdzIUtqksQ7B6dOMgEsV38mKnXn6qQ25F7q2ECnI=;
        b=sGSHPI7UDGlPV1+93HNFNYLl9XvqGa4fU51cLNl+qmPAt6YHKg34Cqli2J1VLR8+7i
         MJGWwG+8/0JAY/mv5YD1+O/mRj+G545ywlfRP2ceNSMyC/lZhfAY18qzEr+ODhT4zlt4
         j9q5pE1qmzOpVW+B/+5FdKanf1GKA2qTx6FPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724974090; x=1725578890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPBGdzIUtqksQ7B6dOMgEsV38mKnXn6qQ25F7q2ECnI=;
        b=RANCZqJfDYc8g5LXHxcIxBQko9+A0gFCWFVUwSREBj1+sxi+nlraOVt3xDYvcIMinH
         9tV89MJoY/+6ME4L7JMEurFb2z6KMMgDD7MSD2YORa/fn13QZQcMwhphR8meoggltbwX
         WOfIhqO5L+8+y0fNh0Gh5a705YdUD8+yF7Crp617+13CPMYR7xKDFxVp1EYa3lp+AYbX
         4jQLx6u0KPHTl2CrgSp9XIlN7620fCCuH5sstkjBAw8hj15lhIlLp3LVeUC+You3VoIk
         JuXJN+CxpF3loCHVoInnlNbNp+udoPibwMEcaf196ITIwPNZNxicR5UTfkAOtSze4pNH
         nVxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/aU7XXxPE9fAiECY+87UIMYLbE9m6RAmtoOHKpwdI835+BGfDQ8oXSywz5RX035IkpLZNh89i@vger.kernel.org
X-Gm-Message-State: AOJu0Yx65iTLoIMW1j5vSknXNIrlbU5aH14OcH2Ei+UVy3AHy1w882EC
	Wu2BxWOxvF6k+8RMohJfZqxOx9dXZ8PSU9SRnUvY8wsCIHisupbEpuFR5yTE65wm+Y8wHFBSkZ7
	M68pBYzivCJktwKc4RyAhz29JXu0Xhm9MZEmVjYAWibQsEkoUexl1wnKpc0flcNG/T8vIbU8fT+
	sz4IWVDJfJambngSoc30DgdFr7skolFGw=
X-Received: by 2002:a17:90a:7807:b0:2c9:75a7:5c25 with SMTP id 98e67ed59e1d1-2d856c7e4e8mr5697862a91.15.1724974090042;
        Thu, 29 Aug 2024 16:28:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/ftKnmUjyZCuqOjMEk1OFSOiaq0Iaf0lLk96xUKx8Qd1ZghN5c4b5HHa1WIK0tLHqz2+6bwA7Ogb8xZ1NyYk=
X-Received: by 2002:a17:90a:7807:b0:2c9:75a7:5c25 with SMTP id
 98e67ed59e1d1-2d856c7e4e8mr5697833a91.15.1724974089662; Thu, 29 Aug 2024
 16:28:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-6Uy-2kVrj05SeCiN4wZu75Vq5-TCEsiUGzYwzjO4+Ahg@mail.gmail.com>
 <Zs_gT7g9Dv-QAxfj@google.com> <CALAgD-5-8YjG=uOk_yAy_U8Dy9myRvC+pAiVe0R+Yt+xmEuCxQ@mail.gmail.com>
 <ZtEDEoL-fT2YKeGA@google.com>
In-Reply-To: <ZtEDEoL-fT2YKeGA@google.com>
From: Xingyu Li <xli399@ucr.edu>
Date: Thu, 29 Aug 2024 16:27:57 -0700
Message-ID: <CALAgD-6Vg9k=wd1zaJ+k-EaWLnzosAn2f=iz7FvhVpdS6eq-dA@mail.gmail.com>
Subject: Re: BUG: general protection fault in get_mem_cgroup_from_objcg
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yu Hao <yhao016@ucr.edu>, Juefei Pu <jpu007@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Juefei: Can you give some input on this?

On Thu, Aug 29, 2024 at 4:24=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> On Wed, Aug 28, 2024 at 10:20:04PM -0700, Xingyu Li wrote:
> > Hi,
> >
> > Here is the kernel config file:
> > https://gist.github.com/TomAPU/64f5db0fe976a3e94a6dd2b621887cdd
> >
> > how long does it take to reproduce?
> > Juefei will follow on this, and I just CC'ed him.
>
> I ran the reproducer for several hours in a vm without much success.
> So in order to make any progress I'd really need a help from your side.
> If you can reproduce it consistently, can you, please, try to bisect it?
>
> Thanks!



--=20
Yours sincerely,
Xingyu

