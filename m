Return-Path: <cgroups+bounces-4699-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1937C96C760
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2024 21:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70262811D4
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2024 19:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D581E6301;
	Wed,  4 Sep 2024 19:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="ncTSS+gm";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="DFe/ARZB"
X-Original-To: cgroups@vger.kernel.org
Received: from mx6.ucr.edu (mx.ucr.edu [138.23.62.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBD480638
	for <cgroups@vger.kernel.org>; Wed,  4 Sep 2024 19:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725477546; cv=none; b=GbbSG1A3Lo5vb+KJk1ilN/rRq0txzqBK/2cVv75jNa2YuGDCAi2nl7a7kK2yXG8zWX9LtBA3k598ARsXkXCEyeF4Io7qiF67/lZrTTP6SR3hrDTcg18J6gmosT0cr45RfcrPjf+67sXQhOZSNsRdhUj7AWiGOB2JDu0fFiqyQ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725477546; c=relaxed/simple;
	bh=V4W941XLc6H/+dnu0gbSD9ilMORE5y9ZR1cBEZLstFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXRQ3Ck26ddVmylkWiVNqqaq6MMsndJPX04EMgAkxn++PWNPzs+88WKKluDty4cFLZezj0/ro3Kcjes97692csyu7NxuHrCZzM8o6un1cgC5tCihZ+rw1HiJTbKXcWbSAIy9bJnfwrm+7rjBEO0nMgbgc9yHMuUQnBYbXy2ZHCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=ncTSS+gm; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=DFe/ARZB; arc=none smtp.client-ip=138.23.62.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1725477545; x=1757013545;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=V4W941XLc6H/+dnu0gbSD9ilMORE5y9ZR1cBEZLstFs=;
  b=ncTSS+gmZWsNnccSTC7+uK6A07NrrR+swudhGoUyCMu3koMJywAcvcy7
   R6GUnWBnwz/HyY7HQE1E0D3HRfnZ/Y9jU8kscqMG+t5K4+qGFumo3wQcd
   tAPs51S/s5n40VmkjjZhzjmNjLCwsArK7ogUoDMuxWFfp1kaqIwUquRkK
   1j+st1WcxuQx0KZFvO3ZrL8SnmMt+XxPAf2G42Urdd6GfGtLZdogCs/+1
   RTPdQpxcdc/1ZIk2j0gDlpW3FMjf61zUGHQtU6BGxIC583zHTV86lFjDG
   RirLCGBleP8tnbbf4glPsVZrgHV+tAGAazracEhkA8MoCoqbfViSHsHhW
   Q==;
X-CSE-ConnectionGUID: ST4Y2YxpTYOlb1Au6ULoxw==
X-CSE-MsgGUID: sp2ynpPySomdKSUyMXjapg==
Received: from mail-io1-f72.google.com ([209.85.166.72])
  by smtpmx6.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Sep 2024 12:18:58 -0700
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82a246b5043so820558539f.3
        for <cgroups@vger.kernel.org>; Wed, 04 Sep 2024 12:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1725477537; x=1726082337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wp619eUyj/srIfkacGO/5/4OpMLHA+ypleVADcaGWJ0=;
        b=DFe/ARZBd/BmKtNRoEt5qGW3j2cRznABpw/Esl54WnLgCDHhyQ/XY+KtttnJZkonoP
         cNLsV3vVQHXXKmjsSuBgEsZj+iQgSNvbpkcovHWlEBuWINHNao/ir7gemB0Q9ss83XO0
         tDMb/pBGkp0ykKqMnKyAHuxRbFr4BdfpP9sqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725477537; x=1726082337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wp619eUyj/srIfkacGO/5/4OpMLHA+ypleVADcaGWJ0=;
        b=Jh/tIbTW3vtHSSF/hm3u123F3uJiZYIu2SAleg8F/94sUoD+HdTIJT1TyOohGqmXBT
         nXhX0RFjfWDMwRT9+prQjIWiYTauERBOlEJJ+3aj8fNpWdKxsx2cLZZsw9dXgO6F9kgA
         VmF7Xq3lEKxag0E7InkccJ123YWXx3yDrqEU7UzPpK0hihScrztXwjNL+weBWZtuVEot
         S+OztbFo0UX9Ot62y3TQyHkVZ3rrW+5MvSmrpBedYGhMIdq0iIwHMelyrLDgLecvaAmB
         i4BScnryW8kLtRQKbzSRTD5HBDQLi5Rd4xfv1KaRzDSZ4hd1/THNjcI6zIwjbqBnQaPP
         3e/A==
X-Forwarded-Encrypted: i=1; AJvYcCVjNqAvOwMOVlABAUqCOOEkkvwJ6SUbKRuST0/J48qUfB8ScOrC4IOGiJnhO10krkAZFYszLEAy@vger.kernel.org
X-Gm-Message-State: AOJu0YxrV0Ui2iBBZIKxM5XikrG1E3adY9eBNcEZz4VWcaEONUKp5qcd
	+mH7sElMm7f6JOEmFXK0ig5noSg7499OpHTTwhyXieMgp3XcNQb2K8yS0voXbNbI+LnH4LAi/PA
	SfIIOpY8P76GJCi7ceBzD4e5qSo/zmUvafJgoJs8+F4ZrFKqCCmb1P83iJiJ5J+ZiAU4LqzdfSX
	iNYfEynlCTYLPGoalgyYUtd2myovKweJM=
X-Received: by 2002:a05:6602:6b07:b0:824:d9c0:3fc6 with SMTP id ca18e2360f4ac-82a3730aecfmr1566823139f.3.1725477537302;
        Wed, 04 Sep 2024 12:18:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8Djcz+0ooKKXLxn8YKkL5axvVjXixex3XMagQYxCNHQNt+JxXVPIaHG4A9H0SHwKI9lJoq0O3HO/addLf7wA=
X-Received: by 2002:a05:6602:6b07:b0:824:d9c0:3fc6 with SMTP id
 ca18e2360f4ac-82a3730aecfmr1566821739f.3.1725477537024; Wed, 04 Sep 2024
 12:18:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-6Uy-2kVrj05SeCiN4wZu75Vq5-TCEsiUGzYwzjO4+Ahg@mail.gmail.com>
 <Zs_gT7g9Dv-QAxfj@google.com> <CALAgD-5-8YjG=uOk_yAy_U8Dy9myRvC+pAiVe0R+Yt+xmEuCxQ@mail.gmail.com>
 <ZtEDEoL-fT2YKeGA@google.com> <CALAgD-6Vg9k=wd1zaJ+k-EaWLnzosAn2f=iz7FvhVpdS6eq-dA@mail.gmail.com>
In-Reply-To: <CALAgD-6Vg9k=wd1zaJ+k-EaWLnzosAn2f=iz7FvhVpdS6eq-dA@mail.gmail.com>
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Wed, 4 Sep 2024 12:18:46 -0700
Message-ID: <CANikGpcg3_hVS+-h5egaLNkHGvG50qVAZ21syT7Ogc6iK1SzKA@mail.gmail.com>
Subject: Re: BUG: general protection fault in get_mem_cgroup_from_objcg
To: Xingyu Li <xli399@ucr.edu>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, hannes@cmpxchg.org, mhocko@kernel.org, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

After several tests, I found that the same PoC can cause multiple
different crashes for some unknown reason. Thus, I suspect that the
bug is capable of performing unintended memory writing without being
caught by KASAN.
For reproducibility, I've created a GitHub repo at
https://github.com/TomAPU/Linux610BugReort, which contains the
software versions we used, the QEMU arguments we used to boot up the
kernel, the kernel config we used,  the pre-compiled kernel image,
Dockerfile that can be used to compile the kernel.
I hope this repo will be helpful for analyzing the bug.

Yours,
Juefei

On Thu, Aug 29, 2024 at 4:28=E2=80=AFPM Xingyu Li <xli399@ucr.edu> wrote:
>
> Juefei: Can you give some input on this?
>
> On Thu, Aug 29, 2024 at 4:24=E2=80=AFPM Roman Gushchin <roman.gushchin@li=
nux.dev> wrote:
> >
> > On Wed, Aug 28, 2024 at 10:20:04PM -0700, Xingyu Li wrote:
> > > Hi,
> > >
> > > Here is the kernel config file:
> > > https://gist.github.com/TomAPU/64f5db0fe976a3e94a6dd2b621887cdd
> > >
> > > how long does it take to reproduce?
> > > Juefei will follow on this, and I just CC'ed him.
> >
> > I ran the reproducer for several hours in a vm without much success.
> > So in order to make any progress I'd really need a help from your side.
> > If you can reproduce it consistently, can you, please, try to bisect it=
?
> >
> > Thanks!
>
>
>
> --
> Yours sincerely,
> Xingyu

