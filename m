Return-Path: <cgroups+bounces-9352-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE158B3279C
	for <lists+cgroups@lfdr.de>; Sat, 23 Aug 2025 10:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42D95E6EC3
	for <lists+cgroups@lfdr.de>; Sat, 23 Aug 2025 08:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0C22367C9;
	Sat, 23 Aug 2025 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Dhgw3tS+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3866212557
	for <cgroups@vger.kernel.org>; Sat, 23 Aug 2025 08:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755937393; cv=none; b=tgOZkvQk8k0bNtCv0XefMC27Pb0QpzP0sJCFj/7zCUDQEsPLsG7lFUg9eoBmOKx3AAzQ3SItTIAn/aqyCQoA68vYW1MeXwOMpZz23oGSsPe0KB81NZoJTEZuXPLJL8grgUw/jEHzDM3cLq9dTNBfxfa1pU7fQzxVh0lT8JPJmL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755937393; c=relaxed/simple;
	bh=0YFVWJ6mEe6+mn0X64o0CABy88FGkC9zJTxkoaKV3IM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFSChTHY/5wF2CiIEtNzz79ifTYtOY1ca0mIlUw7plzUX3X2OcfnimqAXRXwz71rVaoDRcX43/c+FiUT+HrOvYvE5Kv5m7NdrMUQSlV0IwXeC082BXYwTHnxr6FEHjGiJI7yQQAIE42Dx53m8Ikx3Q+NraM272dTg34xvYZcFrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Dhgw3tS+; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d603b62adso24682547b3.1
        for <cgroups@vger.kernel.org>; Sat, 23 Aug 2025 01:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755937388; x=1756542188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ECUzsLpIGLfSNANJzOpUlmNgO6Xf1gnfi/48aM/B14=;
        b=Dhgw3tS+SvAzJux3hluqYJKg7APtQ8TJ/1Fq5DdVm25l75SwrR2kHrsB55ytJQ9Zzv
         4IEir0wJa3+zVIHK78a/zeNvREH0WzBTheId471/fshWK0oIfUtZ9ZCgLw7Uhfr3ke3o
         iUt6Earv4gBcScQ1E59H0lkqiyTQaNevKyVKp39CTX/IkbJOClRpHOeYwas404VktLE4
         BaenDxDLAQ/pISyebGhWCaEdVIQKyXEYe/XdeYleu9w5P+FWN8EYcxzCLKYkp9ZfQFLy
         S/9SxE/HooS077EbnnSAvSgmNtgVvvWmZYNPK8eLLuPpcli2LWuBljW12D2SRYqXFYH9
         PKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755937388; x=1756542188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ECUzsLpIGLfSNANJzOpUlmNgO6Xf1gnfi/48aM/B14=;
        b=mqzuRGre1QgRKoxgJHfELCOh8mENXROVnC4AsTmzgR94z0CthgNb0pMWZGNiNOlIFi
         NWyypJysi0Ypb1hmJBI2sYHbghIm5g4KFmRBdKy6prslfIgppCfKif/hRCDgAmu+2m6E
         N6X8VHXdPqeQ0gsnyjeQpGYopSijc54B1d3rErObNZgWNtGLQgZhqfEtOez5pjRNYpNc
         64C6LnQFzICTrC5JZNewLPYK7vcWzxsqlJE0zhAU3DwHhJ8PaizrDzUHkUhSCW3eHEAg
         66/abzy/whmXV2tALomZPdcvTzIggZGjc/AkZfa5PDVuei18qxzLvHwn8bwAIvBrk1jH
         dV5A==
X-Forwarded-Encrypted: i=1; AJvYcCUL5PAI7PY5RlMJ32e6fqDjcATPWy+uzxVXvohnXlT2+CGd7kaIVHJhsNAKxFWAF/PB7fIZXvZk@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh9ziCiRnlimQd1+Dml8/LtF1n/KcqrdWmmCEqNyvJSEqv+7Lo
	B/ZTOIan5S0BoKghZ369mTnPkP9avhe0KVJ+RR1c3FQ/uNHAX/rMXga1MX5GN/2pbIZIzJ+G+qC
	rMbsCx2Xkjc+ssyNpxnStZk4zxu3nItQASyT8rnTeoA==
X-Gm-Gg: ASbGncsz6AFw3SrpPVxJHNOh501GIRjPC691uuX6qbrTPYJP0bOtNtI8mYMJWsmdEt8
	Plf5etew2PA/NVcb4lxFnVDqrOs9KEhecYD429FcFHDb+ydUD6FUHDSrtOMBMT4uRo87vCZIMwO
	tScq57NrlLL/wMStlU01sJTyIocFEtuuA7sjGBIU+zG5tW0Au4AUMYFjms17rhfbolECg7QRKMC
	lPlxuN3td33
X-Google-Smtp-Source: AGHT+IH0BVIyZiw5bWrCKqslz5gV80c6AufAKs2rnSguLnlMSKmrPRYkojH4j4/wRFQ/wNMvYf2Fi3seu0hZ9/B27eE=
X-Received: by 2002:a05:690c:4c09:b0:719:f37e:e69c with SMTP id
 00721157ae682-71fdc421889mr66924497b3.36.1755937388335; Sat, 23 Aug 2025
 01:23:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHSKhtebXWE5m0RcesWe_w2z1Gpqt1n5X0wuE9oD1tX6VxztUg@mail.gmail.com>
 <76a95839-00b1-43b8-af78-af4da8a2941c@gmail.com>
In-Reply-To: <76a95839-00b1-43b8-af78-af4da8a2941c@gmail.com>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Sat, 23 Aug 2025 16:22:57 +0800
X-Gm-Features: Ac12FXyXLbqkgSJ552CB_VB52RDuHyiA8g2c5o9dPYHcJpfZiX_QPTNVRfVvNBQ
Message-ID: <CAHSKhtd_oM8yXBwgm1-6FGhDEaDGCWunohMnb4AtV8Y-__z-zg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] memcg: Don't wait writeback completion
 when release memcg.
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, tj@kernel.org, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Aug 23, 2025 at 4:08=E2=80=AFPM Giorgi Tchankvetadze
<giorgitchankvetadze1997@gmail.com> wrote:
>
> Hi there. Can we fix this by allowing callers to set work->done =3D NULL
> when no completion is desired?

No, we can't do that. Because cgwb_frn needs to track the state of wb
work by work->done.cnt, if we set work->done =3D Null, then we can not
know whether the wb work finished or not. See
mem_cgroup_track_foreign_dirty_slowpath() and
mem_cgroup_flush_foreign() for details.

> The already-existing "if (done)" check in finish_writeback_work()
> already provides the necessary protection, so the change is purely
> mechanical.
>
>
>
> On 8/23/2025 10:18 AM, Julian Sun wrote:
> > Hi,
> >
> > On Sat, Aug 23, 2025 at 1:56=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote=
:
> >> > Hello, > > On Fri, Aug 22, 2025 at 04:22:09PM +0800, Julian Sun
> > wrote: > > +struct wb_wait_queue_head { > > + wait_queue_head_t waitq; =
>
> >  > + wb_wait_wakeup_func_t wb_wakeup_func; > > +}; > > wait_queue_head_=
t
> > itself already allows overriding the wakeup function. > Please look for
> > init_wait_func() usages in the tree. Hopefully, that should > contain
> > the changes within memcg.
> > Well... Yes, I checked this function before, but it can't do the same
> > thing as in the previous email. There are some differences=E2=80=94plea=
se
> > check the code in the last email.
> >
> > First, let's clarify: the key point here is that if we want to remove
> > wb_wait_for_completion() and avoid self-freeing, we must not access
> > "done" in finish_writeback_work(), otherwise it will cause a UAF.
> > However, init_wait_func() can't achieve this. Of course, I also admit
> > that the method in the previous email seems a bit odd.
> >
> > To summarize again, the root causes of the problem here are:
> > 1. When memcg is released, it calls wb_wait_for_completion() to
> > prevent UAF, which is completely unnecessary=E2=80=94cgwb_frn only need=
s to
> > issue wb work and no need to wait writeback finished.
> > 2. The current finish_writeback_work() will definitely dereference
> > "done", which may lead to UAF.
> >
> > Essentially, cgwb_frn introduces a new scenario where no wake-up is
> > needed. Therefore, we just need to make finish_writeback_work() not
> > dereference "done" and not wake up the waiting thread. However, this
> > cannot keep the modifications within memcg...
> >
> > Please correct me if my understanding is incorrect.
> >> > Thanks. > > -- > tejun
> >
> > Thanks,
> > --
> > Julian Sun <sunjunchao@bytedance.com>
> >
>
>
> > Hi,
> >
> > On Sat, Aug 23, 2025 at 1:56=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote=
:
> >> > Hello, > > On Fri, Aug 22, 2025 at 04:22:09PM +0800, Julian Sun
> > wrote: > > +struct wb_wait_queue_head { > > + wait_queue_head_t waitq; =
>
> >  > + wb_wait_wakeup_func_t wb_wakeup_func; > > +}; > > wait_queue_head_=
t
> > itself already allows overriding the wakeup function. > Please look for
> > init_wait_func() usages in the tree. Hopefully, that should > contain
> > the changes within memcg.
> > Well... Yes, I checked this function before, but it can't do the same
> > thing as in the previous email. There are some differences=E2=80=94plea=
se
> > check the code in the last email.
> >
> > First, let's clarify: the key point here is that if we want to remove
> > wb_wait_for_completion() and avoid self-freeing, we must not access
> > "done" in finish_writeback_work(), otherwise it will cause a UAF.
> > However, init_wait_func() can't achieve this. Of course, I also admit
> > that the method in the previous email seems a bit odd.
> >
> > To summarize again, the root causes of the problem here are:
> > 1. When memcg is released, it calls wb_wait_for_completion() to
> > prevent UAF, which is completely unnecessary=E2=80=94cgwb_frn only need=
s to
> > issue wb work and no need to wait writeback finished.
> > 2. The current finish_writeback_work() will definitely dereference
> > "done", which may lead to UAF.
> >
> > Essentially, cgwb_frn introduces a new scenario where no wake-up is
> > needed. Therefore, we just need to make finish_writeback_work() not
> > dereference "done" and not wake up the waiting thread. However, this
> > cannot keep the modifications within memcg...
> >
> > Please correct me if my understanding is incorrect.
> >> > Thanks. > > -- > tejun
> >
> > Thanks,
> > --
> > Julian Sun <sunjunchao@bytedance.com>
> >
>
>

Thanks,
--=20
Julian Sun <sunjunchao@bytedance.com>

