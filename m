Return-Path: <cgroups+bounces-5902-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4869F2432
	for <lists+cgroups@lfdr.de>; Sun, 15 Dec 2024 14:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88EA18865FC
	for <lists+cgroups@lfdr.de>; Sun, 15 Dec 2024 13:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC70189912;
	Sun, 15 Dec 2024 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoLQGfIp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF682FB6;
	Sun, 15 Dec 2024 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734269951; cv=none; b=Qt7OlkOEjA5FY17JF7GHyOgRUmzcWUX5DYJz6XJIcBu8qTyycjfZlCNE6sV1PR8nKDnje/qBz6fAeZSmTh27QQHTikq5lv7J3kK7wnMJveKFrjXIxLHdJiVD8wPRqEUim4HTdP9hP9GX8qJCgX47ysUQBaGVulaA7mq6oPbjRpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734269951; c=relaxed/simple;
	bh=XrmQpKYSflNuoXEKhdYJgDyQhZ51vc8r81OH3xptc9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+H+AN0AWr8evf1upK8lZbQ2ft1SBCPTbyl+ZDo4+qrwhOJ4UTUEjZSDKd/4Oyxw3ZRZZbSKdYrl7fIRDzjEgRs1IGJ1URzX5t8Axcaji4QOtzX17fr1BEI3G3rSBQql1V+1BndkRhoR9hcYfM0jtZSqYaOF5J84mlq5KiS14uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoLQGfIp; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso17181736d6.2;
        Sun, 15 Dec 2024 05:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734269949; x=1734874749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8uqDP/lnio0NPV20RWWSTO61S0pA+rXkOSNzbD4q0Y=;
        b=eoLQGfIpKFvJWOIyqdD9sQmopgGZB+T+nee9g8XaS06KqbcrdXTPAgOqfg5dkSkvoJ
         Ko0UOfsPt1AWl6gtpVw690NtRT/2oN+JNDElUC+wFuuJtAtWr5TteOV/1JQ8JqHJ55bQ
         JW2e3i87fq7tMSLmjwdrvn1dUQnffI+XKT8NF2CN4suGnlNw+IYUek22koQWaO8AkYEy
         TJbFS9UiNQjRUl7tsq6vUT0XbmsYxh9zy88wwv8lfPT7RoxwiCIXVozw54A3aHM+9cJT
         woTqfn6ymSwn7AV8AX+WarqhnvOdDP9vjkaOIffEfOe+M3nfGvV0J54Ytpd2EYhHHwwe
         DkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734269949; x=1734874749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8uqDP/lnio0NPV20RWWSTO61S0pA+rXkOSNzbD4q0Y=;
        b=A7biol5zeEoX/87hklqzf+4ERTjwV+3IUb8I28jHbeI+F+iU2WFQVkwex4jlURlCeE
         LvsgC1zxCrq3FvjGWgjetDzsLJy1ThHuVjuZIO8rdrqSplXhqvgNdiZpCeAfrs9n14CA
         oSEE+TToAXO2Vg4szfm/zTQuVeHE2EFmxiO45oACa9mv2I3ReJDi654RUz5yEsYblfqf
         OMnQOQsAi7kzjyJ4Jdl3mho05ll8ch2oMyB+IgFifeXhLdYZaU9TLBGetFTg8qDQughy
         PGTqTFY84H6ADMzoQuqEwSvTCavliwl2aOnh61HMZjenUP8eyiU/EFsIg9ot8m9bP0ep
         DG5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2XEsv5EeBK3AuXBtdUmT3W0OtgLTBaaABHMIaYqryuE2lS2o1CSV5ddUfXqJlbpozNqwj36AsLTgXD8E6@vger.kernel.org, AJvYcCUYb1qCAH6jhwbaww2ah7nPmO1s+qRznjUJDM2Jk5H98YSgk0b0eDaB+YpTMmznAj6bGKH+MiwM@vger.kernel.org
X-Gm-Message-State: AOJu0YyoVS1ZQs3m+NPxC18GcunFXUuTVvw23wq2YfYAIX79t1bJQ2C5
	1KUoHVKmVFizNPKbptA0c7LyXiKTT5t/CH5tNWyTHj0wr9AhRYAX9yRWO8e1zQvwZwd+mKSG65i
	lzH0zMp3rqCqfIjUg+lQLzOkTiD0=
X-Gm-Gg: ASbGncuAUNUHfrxKLol3QvWNZHwYd82+krp/ygRrg9leeMejNwbD/i1UsLtvXJEMP4I
	E7zitwxs8OnqiIPyEzPikzKArurIeQInYYQk+sCY=
X-Google-Smtp-Source: AGHT+IH1cQTQtahFCfhq2nr+zIjpQm6ClX1Md5Mqi72xfTObwsSxE3+Yv+PNKdT0/pqlixXzv/rqQdqXsGpRjycbFEo=
X-Received: by 2002:a05:6214:2523:b0:6d8:b097:fad3 with SMTP id
 6a1803df08f44-6dc968726bcmr170066866d6.35.1734269948990; Sun, 15 Dec 2024
 05:39:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241215032315.43698-4-laoar.shao@gmail.com> <202412152009.HZ862kna-lkp@intel.com>
In-Reply-To: <202412152009.HZ862kna-lkp@intel.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 15 Dec 2024 21:38:33 +0800
Message-ID: <CALOAHbCpO-zeH1u5mQs9FvAP-V9JHf9G8LiQdbapDxoMMKzUhg@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] sched, psi: Don't account irq time if
 sched_clock_irqtime is disabled
To: kernel test robot <lkp@intel.com>
Cc: mingo@redhat.com, peterz@infradead.org, mkoutny@suse.com, 
	hannes@cmpxchg.org, oe-kbuild-all@lists.linux.dev, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, surenb@google.com, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 9:08=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Yafang,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on tip/sched/core]
> [also build test ERROR on peterz-queue/sched/core linus/master v6.13-rc2 =
next-20241213]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/sched-=
Define-sched_clock_irqtime-as-static-key/20241215-112638
> base:   tip/sched/core
> patch link:    https://lore.kernel.org/r/20241215032315.43698-4-laoar.sha=
o%40gmail.com
> patch subject: [PATCH v7 3/4] sched, psi: Don't account irq time if sched=
_clock_irqtime is disabled
> config: arc-randconfig-001-20241215 (https://download.01.org/0day-ci/arch=
ive/20241215/202412152009.HZ862kna-lkp@intel.com/config)
> compiler: arc-elf-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20241215/202412152009.HZ862kna-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202412152009.HZ862kna-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    In file included from kernel/sched/build_utility.c:96:
>    kernel/sched/psi.c: In function 'psi_show':
> >> kernel/sched/psi.c:1243:42: error: 'PSI_IRQ' undeclared (first use in =
this function); did you mean 'PSI_IO'?
>     1243 |         if (!irqtime_enabled() && res =3D=3D PSI_IRQ)
>          |                                          ^~~~~~~
>          |                                          PSI_IO
>    kernel/sched/psi.c:1243:42: note: each undeclared identifier is report=
ed only once for each function it appears in

Thanks for the report.
will update it as follows,

#ifdef CONFIG_IRQ_TIME_ACCOUNTING
        if (!irqtime_enabled() && res =3D=3D PSI_IRQ)
                return -EOPNOTSUPP;
#endif

--=20
Regards
Yafang

