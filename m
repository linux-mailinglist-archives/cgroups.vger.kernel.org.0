Return-Path: <cgroups+bounces-3828-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8F1937EF7
	for <lists+cgroups@lfdr.de>; Sat, 20 Jul 2024 06:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C461F21AA4
	for <lists+cgroups@lfdr.de>; Sat, 20 Jul 2024 04:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADD3C157;
	Sat, 20 Jul 2024 04:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a8IX53ys"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D544B67D
	for <cgroups@vger.kernel.org>; Sat, 20 Jul 2024 04:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721451179; cv=none; b=RebKLXDELaz4+Wa4g4p9Y3eX++A3MllThgXdYolzj5zBSV758L7Ucjn0YuW/lpht1eseJcOEv0RyiApGpNjkaFCKFY5PsaFzfz5oLCdjET2Ht8vmDCmkoiOaD0MyTEGK0MQRFbiT0D9u2fMNqFfE8ErXxPKlectmk/Sec7hCmXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721451179; c=relaxed/simple;
	bh=UoLdUAJAryghMfc6CeCPhFdMgTNMlLLrJiaNMLYtDUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q5fLfM8TtmXVkNMEQ6WAg3kr+A+K4IenGL4HfCGhUNunGmMbXbgh4Ol7gHHaF5hAD1qqr7rSqllKxpCyPJd9S5XwYWJRwaxYU2K0jhBBb77Xk22EgumLmL9FJozaWaGk1YA0BMG99IlYo8GzowNfp3KKEO2g7yZ12X28WIwd1IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a8IX53ys; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52eafa1717bso2111500e87.2
        for <cgroups@vger.kernel.org>; Fri, 19 Jul 2024 21:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721451176; x=1722055976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSRulvHWjoBy0HLcI6v4db2avURTI4j4zJY+qVX3PAA=;
        b=a8IX53ysK6PSEBpNtiu/S8YefBzfW/cNabzTYv6ZMqleZL8dAJ2fQSb3Tkz9618kcO
         e8o+lzDLUKQbrlCU3brki9JL0kne5tctdmOzPM5yA9We/Spu0FdTDTqgA0j6C4nZlBD0
         Iymys9DDboJjcr2zcTYb72hCv1S/Dp2WeqcEXJ1v+4d0C2LiG9fmJ0qlZdP1vxTL+99I
         3FoTCvcjDb1cVemF1eoZYuK5ypW9KVFARMm+miZy5f5WuWQMwMGGVuuP2cM/UEHVq3NS
         /k3AJP3Izf4H7W2Jqy5xN2SaLGfo5rhLx3N65FbpMiRFG/+4DT5kKddVoS/yqkodvhIi
         zyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721451176; x=1722055976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fSRulvHWjoBy0HLcI6v4db2avURTI4j4zJY+qVX3PAA=;
        b=e9qNMdtigKYZQ9LSxwId7MNHtMJiXcw7cbjFL1gBqHFYp8W90lbbuJG/o5hJGJ6isJ
         r818X7Ia48epQj6h4cEGum5mwr1gzmY4KkrIbiNXWnskeQe+I3xW9Jh6EJLk2k18DPdg
         oyIcwPHui4b2qUQjV3aCuRmVRQOF/IsFx83b+M96/EQ9/QqgYgUAeLymCI7iZQHZtCFL
         BBdXmGJkAE2eP+LDfTyWSs8iAwSVE3L8KR4viv4qpafxfqSS3hV8z0TUvKxYsPsxgjZ4
         XQ8UI6E8vyAxe9XIFHxdTKBho8az3iRIz1t8iY5mFBEAaWUQ0neL7OL8q4sBxh+9xaob
         q8vw==
X-Forwarded-Encrypted: i=1; AJvYcCUwUpHoHXUiRrggjQ+EsxlcRskFhn3E0zSa4rFt2GzGpMBK6g9hke8wTkb3kFhKsJ2G8Foy7u3EvBgZruqrp6DY1NIK8BSuag==
X-Gm-Message-State: AOJu0Yyc4cT1Crq/Xt4DBIpa4z67BNXo2A1C/ae76lPz6vOzcr9mbwhL
	c6/gx8UGBzRf3FeTeJPciMVEFSl3rhLsQ1ZUoMtKR/tnazJqw2PKvIs7NLiSPJvaLZaha5zgQGE
	b1Zn0tWv9mSuFhrAuIT0YgI4Xsknb5srwi+vJ
X-Google-Smtp-Source: AGHT+IEuqDE8qtcuvEHCdMjPK+szxTU34wSvAmUMiAVDP0uGH3fdV3MdBRkljmhPdZlIdRmQlRwnnVbtKUVXHMJDaA0=
X-Received: by 2002:a05:6512:2351:b0:52c:8920:875 with SMTP id
 2adb3069b0e04-52ef8d960ffmr873936e87.20.1721451175516; Fri, 19 Jul 2024
 21:52:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172070450139.2992819.13210624094367257881.stgit@firesoul>
 <a4e67f81-6946-47c0-907e-5431e7e01eb1@kernel.org> <CAJD7tkYV3iwk-ZJcr_==V4e24yH-1NaCYFUL7wDaQEi8ZXqfqQ@mail.gmail.com>
 <100caebf-c11c-45c9-b864-d8562e2a5ac5@kernel.org> <k3aiufe36mb2re3fyfzam4hqdeshvbqcashxiyb5grn7w2iz2s@2oeaei6klok3>
 <5ccc693a-2142-489d-b3f1-426758883c1e@kernel.org> <iso3venoxgfdd6mtc6xatahxqqpev3ddl3sry72aoprpbavt5h@izhokjdp6ga6>
In-Reply-To: <iso3venoxgfdd6mtc6xatahxqqpev3ddl3sry72aoprpbavt5h@izhokjdp6ga6>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 19 Jul 2024 21:52:17 -0700
Message-ID: <CAJD7tkYWnT8bB8UjPPWa1eFvRY3G7RbiM_8cKrj+jhHz_6N_YA@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 3:48=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Fri, Jul 19, 2024 at 09:54:41AM GMT, Jesper Dangaard Brouer wrote:
> >
> >
> > On 19/07/2024 02.40, Shakeel Butt wrote:
> > > Hi Jesper,
> > >
> > > On Wed, Jul 17, 2024 at 06:36:28PM GMT, Jesper Dangaard Brouer wrote:
> > > >
> > > [...]
> > > >
> > > >
> > > > Looking at the production numbers for the time the lock is held for=
 level 0:
> > > >
> > > > @locked_time_level[0]:
> > > > [4M, 8M)     623 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@            =
   |
> > > > [8M, 16M)    860 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|
> > > > [16M, 32M)   295 |@@@@@@@@@@@@@@@@@                                =
   |
> > > > [32M, 64M)   275 |@@@@@@@@@@@@@@@@                                 =
   |
> > > >
> > >
> > > Is it possible to get the above histogram for other levels as well?
> >
> > Data from other levels available in [1]:
> >  [1]
> > https://lore.kernel.org/all/8c123882-a5c5-409a-938b-cb5aec9b9ab5@kernel=
.org/
> >
> > IMHO the data shows we will get most out of skipping level-0 root-cgrou=
p
> > flushes.
> >
>
> Thanks a lot of the data. Are all or most of these locked_time_level[0]
> from kswapds? This just motivates me to strongly push the ratelimited
> flush patch of mine (which would be orthogonal to your patch series).

Jesper and I were discussing a better ratelimiting approach, whether
it's measuring the time since the last flush, or only skipping if we
have a lot of flushes in a specific time frame (using __ratelimit()).
I believe this would be better than the current memcg ratelimiting
approach, and we can remove the latter.

WDYT?

>
> Shakeel

