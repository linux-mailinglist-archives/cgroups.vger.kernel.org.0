Return-Path: <cgroups+bounces-309-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A13F27E7900
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 07:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8AB01C20DF7
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 06:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98CA4C8E;
	Fri, 10 Nov 2023 06:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZIeYuYK"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372774C93;
	Fri, 10 Nov 2023 06:12:54 +0000 (UTC)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A704C06;
	Thu,  9 Nov 2023 22:12:50 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-45da9f949aaso736082137.2;
        Thu, 09 Nov 2023 22:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699596769; x=1700201569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtKRdOxRUcd7I/oBVCGyadSDout/ofwnbLIu0A50a+g=;
        b=GZIeYuYKgwbf0qEmwuY+15kKxN/WV+zlGGGD9+U9SoImmjhdEgz5z/AUDnCXiil3bF
         u+EUAQMrfHIlAycwaAmRux261NhxxTjUF0AEIJoJGS7PE05gZy4Fi9A7pMtIRzHlgimS
         Tg1B/F/TehlolAKeUVHp+KsXzsR+kkf/TtirtkhNN/ROTFNnin7+Wn8uAbK72eVK0rXr
         6g82Zvw+X+H5NAn9R3tUI8xvMCulo9j3qKM010BFF/hhfFDTVRToFYyamI5IWN1jCtXg
         wramptkzR7alDNNrWdaWU7yOPitSI5iH6kMRlHBSm1x7pp3BkVhbcLi/imKyWsKDhdl7
         4tjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699596769; x=1700201569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtKRdOxRUcd7I/oBVCGyadSDout/ofwnbLIu0A50a+g=;
        b=d4QHXT7k9N95mSgqZZDuZAHckGlEjtosGo10BrwzhQ6GU0SLJ9DoT+6XX9tpZuM2bq
         K+rU2ioI/Fo23zZHL6vGFXIwAgZOKQ365KE6UVEFLQvAlk7vX4brqJhBjrfGXObKlWf8
         E+k26xsjjefK5LQatJI8SI7YPsztCzlafBQv7wYIljMFFb0qfRJaLQovA6m1O/hcSzJG
         BOXL7VRbpQFlDiubVHXSnblMsIztaIGs7vnJTiaud4MGmMOPkivHEQln/e4KHXUOP7BG
         xOgvBrrekyeop3m2Z7qVY9tL1fmaqKk1TSHsdZAAuyxIk55+NZUiz/viTfgeuCNKVvL+
         7gCA==
X-Gm-Message-State: AOJu0Yx0ngQwhSN7mobRqXw292656NoONaz6u6QDG5X3p9qDa1MEsFT8
	IQuWw0/tWsU/dQpmPOLGoFbGuKjietpD2U6AAirQE+g+2lr8Vg==
X-Google-Smtp-Source: AGHT+IEMz2MwGXCRieGvDms4iMnTUb3TAaxR4ph+xijGLlOJXuWtwp0St8Riu/h6dcORezusU7ABuUPCAQDV1/xgx+A=
X-Received: by 2002:a05:6214:2aac:b0:671:188b:7367 with SMTP id
 js12-20020a0562142aac00b00671188b7367mr7899483qvb.65.1699596300242; Thu, 09
 Nov 2023 22:05:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231029061438.4215-1-laoar.shao@gmail.com> <ZU1rLOMUJQOGXti5@slm.duckdns.org>
 <CAADnVQJfEWkMhyqt5msd-GsuuEFONQPnhHjB7s2zKw0eAWv4sg@mail.gmail.com>
In-Reply-To: <CAADnVQJfEWkMhyqt5msd-GsuuEFONQPnhHjB7s2zKw0eAWv4sg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 10 Nov 2023 14:04:24 +0800
Message-ID: <CALOAHbAM86EaU=7FeKJ+B1vGxGX7oXMm4fDUgEVTAePKFDTrTg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/11] bpf, cgroup: Add BPF support for
 cgroup1 hierarchy
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Kui-Feng Lee <sinquersw@gmail.com>, Waiman Long <longman@redhat.com>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 7:35=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Nov 9, 2023 at 3:28=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
> >
> > Hello,
> >
> > Applied 1-5 to cgroup/for-6.8-bpf. The last patch is updated to use
> > irqsave/restore. Will post the updated version as a reply to the origin=
al
> > patch.
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.8-b=
pf
> >
> > Alexei, please feel free to pull from the branch. It's stable and will =
also
> > be included as a part of cgroup/for-6.8.
>
> Perfect. Thanks.
> Will probably pull it either tomorrow or on Monday/Tuesday.

will send a new version for the other parts after you pull it.

--=20
Regards
Yafang

