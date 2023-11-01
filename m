Return-Path: <cgroups+bounces-148-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 997E17DE564
	for <lists+cgroups@lfdr.de>; Wed,  1 Nov 2023 18:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C495B1C20CF6
	for <lists+cgroups@lfdr.de>; Wed,  1 Nov 2023 17:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F72C15E83;
	Wed,  1 Nov 2023 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J48sp5tn"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B7E171C3
	for <cgroups@vger.kernel.org>; Wed,  1 Nov 2023 17:32:49 +0000 (UTC)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B6B123
	for <cgroups@vger.kernel.org>; Wed,  1 Nov 2023 10:32:47 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5b35579f475so497747b3.3
        for <cgroups@vger.kernel.org>; Wed, 01 Nov 2023 10:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698859967; x=1699464767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFbeZz+qhmHwwvlmlKC5sG1TF/aMrXYFZSbIKG8O8+w=;
        b=J48sp5tnA51XPS0d+p34ZDUJRoze2dGei2EOSuylyDKBPvgdKqTy5Yn4p6GXxxhXXf
         COqB11LeDJrtYLM0uC52PLFIdNBcc+2GE7gZh7dcwEHPMyZHbKFkzCUNQ/K9feCpGeRE
         peXuaIO4kbdr1LLbLcXLiRrfzL50v8TnUvGirvZ+2sugtvNNWcncUc2n3siHLgFEO25t
         kIUI/cTDqo7wruvYWGtDumev954cusn4nOrEr0Fly/mjd0PhuKpGSuqwffWxOOuogOnR
         dSG2INa80OD7dRir7LNw1Pm0RDPt4PDQc6LV9X6gFGdMhSK/bQ8aEubsUWac1vGQXbwz
         e/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698859967; x=1699464767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFbeZz+qhmHwwvlmlKC5sG1TF/aMrXYFZSbIKG8O8+w=;
        b=sNxkBgF5nZluN9qNmDyc3v5D9RMwfj9UkfftemZ6MMEAvIygbBS/S0wLCkwl5/tGLO
         lSmSyaaEEpd4Z5VFl+vf+icSt0cCajHxemPbI26jmBBgSITsIvWMAPnL4eNJ3mADcKvb
         8dtWT6AjiiweG8J1RO1lXlw2OI7YfAmx29/7j3xsmiKRB/ZzgIO/MIiq2H1Lb+4HWtfE
         U/IybFaOgUXRSc+USaPRlkbDXMQgNYl8nubTqWW2OuGojyvLl8EV9NiG2m8fVZsr23Bi
         H2c+/I9lM4gxzVJibw+GiDWMexsnwxklsApJ1k8PmPhqmdt3HWYZCw5dS84spm0F50TP
         5v4w==
X-Gm-Message-State: AOJu0Yzy/8seM6YNF3FAu0OPesglD6ZS400gd7L98jtwwabBsenbTMbM
	TF8NLQyUpsodwC6pd9Ygcx3xGpcEBT0mS/TVfnG8q+ELD2zFIHr1umM+Hw==
X-Google-Smtp-Source: AGHT+IHwUqQVcomT7YwFeSRjhG+YNoaY51DWB8uBw78hRSpyKgrKdEhyGhUzkAqGaqqxpH5cIaVG3vSpakes7tCudoA=
X-Received: by 2002:a81:e20c:0:b0:59b:5d6b:5110 with SMTP id
 p12-20020a81e20c000000b0059b5d6b5110mr18321124ywl.21.1698859966806; Wed, 01
 Nov 2023 10:32:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABdmKX3SOXpcK85a7cx3iXrwUj=i1yXqEz9i9zNkx8mB=ZXQ8A@mail.gmail.com>
 <CABdmKX0Grgp4F5GUjf76=ZhK+UxJwKaL2v-pM=phpdyrot+dNg@mail.gmail.com>
 <sgbmcjroeoi7ltt7432ajxj3nl6de4owm7gcg7d2dr2hsuncfi@r6tln7crkzyf>
 <CABdmKX3NQKB3h_CuYUYJahabj9fq+TSN=NAGdTaZqyd7r_A+yA@mail.gmail.com>
 <s2xtlyyyxu4rbv7gjyl7jbi5tt7lrz7qyr3axfeahsij443ahx@me6wx5gvyqni>
 <CABdmKX0Aiu7Run9YCYXVAX4o3-eP6nKcnzyWh_yuhVKVXTPQkA@mail.gmail.com>
 <CABdmKX1O4gFpALG03+Fna0fHgMgKjZyUamNcgSh-Dr+64zfyRg@mail.gmail.com>
 <CABdmKX2jJZiTwM0FgQctqBisp3h0ryX8=2dyAgbPOM8+NugM6Q@mail.gmail.com>
 <5quz2zmnv4ivte6phrduxrqqrcwanp45lnrxzesk4ykze52gx7@iwfkmy4shdok>
 <CABdmKX0h6oi7VE=rzSAvCFGPHhG6jWh+7k1_p6SwV5dYGcUPDQ@mail.gmail.com> <tejgnlgx3yr6vktof6kkje26b445aw2y5f2umrpraoas2jpgbl@eamdjvqfvvel>
In-Reply-To: <tejgnlgx3yr6vktof6kkje26b445aw2y5f2umrpraoas2jpgbl@eamdjvqfvvel>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 1 Nov 2023 10:32:35 -0700
Message-ID: <CABdmKX0uTXYR+JR4JjcXRVDViMpiJhy_zSywz967obCuKoWErQ@mail.gmail.com>
Subject: Re: [Bug Report] EBUSY for cgroup rmdir after cgroup.procs empty
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 8:29=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.com=
> wrote:
> Yeah, both of these seem too complex checks when most of the time the
> "stale" nr_populated_csets is sufficient (and notifications still).
>
> (Tracking nr_leaders would be broken in the case that I called "group
> leader separation".)
>
Ok understood, thanks.

> I've overlooked it at first (focused on exit_mm() only) but the
> reproducer is explicit about enabled kernel preemption which extends the
> gap quite a bit.
>
> (Fun fact: I tried moving cgroup_exit() next to task->signal->live
> decrement in do_exit() and test_core cgroup selftest still passes.
> (Not only) the preemption takes the fun out of it though.)

I found this commit which made me think we couldn't move cgroup_exit
up any further, but yeah preemption after the decrement is still a
tiny problem.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/k=
ernel/exit.c?id=3D0b3fcf178deefd7b64154c2c0760a2c63df0b74f

