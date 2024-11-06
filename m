Return-Path: <cgroups+bounces-5462-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898969BF9E9
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2024 00:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFB3CB22824
	for <lists+cgroups@lfdr.de>; Wed,  6 Nov 2024 23:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD70A20D51B;
	Wed,  6 Nov 2024 23:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNld1z1C"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E7E20D505
	for <cgroups@vger.kernel.org>; Wed,  6 Nov 2024 23:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730935378; cv=none; b=dyHS5PH0QU043AZ7eNPC5zxe6QoqOHK1F7MpOPpfUekBlr18L67dQdijxSsOCkGu/C7J1C5KogTH9WZqv8whsxfD4iJO3CXLVqFAfXe2BxTC8C8Y8Jm1QIga8a3vRIAndKVi4R7CECeSZ2/LoYDE3Yw4zjatrQiPZIyf4XSSYFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730935378; c=relaxed/simple;
	bh=ZRsZKSpD8AGeF9GYcFFMhOlvqYru3RCE/Zuw/Pjv2mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TV0i7aElZ4MGh9Jx7xTyvp+byH6bYiSOiTyUxB5V77poOOZZyjNUr4Xba64ww/nO3jS6be+dG4RsRhLXGQte9d8Tnjzj1+BUO5gKI91cshMY3VpEF7FK3OaL4xs0u7KuLZoWUy8HIJJ/xKbM3oRCj0hPLGEP+4DAvPrMu2qUYW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HNld1z1C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730935375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DlAJxXvAaicdmQcRjbPL9yT3IVxGMViMrr8OkJo1fpo=;
	b=HNld1z1CzOsS7ycye5sdJyi6Fmpwgc3mWs4KEa8JEgR7KhlhK28u7P3AXSfJcSjNplWA1p
	1za1R+wbr+9Hg8YIssAh9Zf+fCpPanL34W0OKBMZE4kysW85/x7mbBdiiI/oFkeLShu2+z
	iAWll1MjxL4/fyWgcoEYncKFkrAZ0h4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-B4s6VWCfMeGmLqybkFOTQg-1; Wed, 06 Nov 2024 18:22:54 -0500
X-MC-Unique: B4s6VWCfMeGmLqybkFOTQg-1
X-Mimecast-MFC-AGG-ID: B4s6VWCfMeGmLqybkFOTQg
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d458087c0so843558f8f.1
        for <cgroups@vger.kernel.org>; Wed, 06 Nov 2024 15:22:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730935373; x=1731540173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DlAJxXvAaicdmQcRjbPL9yT3IVxGMViMrr8OkJo1fpo=;
        b=Fu0lv7PX5k+q6BjATNh3wivH2i5k42cXSU7PDfoxqkxL2O660sdiAJK4TDzJZYDzrs
         CvLExrSH+C0vWgUTU2BPmhfKrS0hfiJgX7XKwRynqD2gRWeM3F72+RF9nTQF02Vw1CQ8
         S680fTC1rDEoYGFq5RZ2IT9alVDF6O3Q0MAwP/IQ6DgPTNI3uJbd5sVsaQ+JdJv7ZYZh
         i0xbT5X/NXdMaRLI/EGDlWN7s5th58eJQwx9oSwoCrRsiC+eo+BJeOvCfC//xZj/88OI
         pbbxvihlg2nerujJgiRc6HwKXIEpyQ3CouD8D0Uyvp1+MeP2J0CRm3RnpSLA0c7gvtQy
         tPTw==
X-Forwarded-Encrypted: i=1; AJvYcCW6z+paho6/O8nJb4/xpnSCJHc3OGwo7/K6DqXHX9GeF13fUhLdeN0gRIQ2XZLm6qnb3BU6NxMa@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl5UwUsRGJ/dDeQnKLVpdpOuHjt4/jskDvSNhco1TmrceW8JWQ
	aLrwA9rpwA6e3fQTuwYvy1p8S6xG7c3EMvn3NiIZAVF0WZl63XxHlNG2my/9ZsYkJAdun/sNzmy
	oL8fnft6HM9axmmCqIdAAptCZRqzMZpKCnxZcCFGlEl8zOPR3Lsj63tFsYjzltF0dMm4/Sss9XB
	8nmdEs8KxsVjhjMym81zWAolz40uoPCQ==
X-Received: by 2002:a5d:6d04:0:b0:37c:fdc8:77ab with SMTP id ffacd0b85a97d-381ec5d2a25mr750633f8f.7.1730935373111;
        Wed, 06 Nov 2024 15:22:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IED8dbEfyAL8ooo8GPjsYUR6b8v06yZSyJJBhEN0YD0lcZceYOU0DyiocvCsAGXa+6yihn58aU4AvlD9ufSOHo=
X-Received: by 2002:a5d:6d04:0:b0:37c:fdc8:77ab with SMTP id
 ffacd0b85a97d-381ec5d2a25mr750625f8f.7.1730935372755; Wed, 06 Nov 2024
 15:22:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZyAnSAw34jwWicJl@slm.duckdns.org> <1998a069-50a0-46a2-8420-ebdce7725720@redhat.com>
 <ZyF858Ruj-jgdLLw@slm.duckdns.org> <CABgObfYR6e0XV94USugVOO5XcOfyctr1rAm+ZWJwfu9AHYPtiA@mail.gmail.com>
 <ZyJ3eG8YHeyxqOe_@slm.duckdns.org> <CAMw=ZnQk5ttytEKO6pK+VLEhSO9diRAqE9DEUwjXnQkz+Vf7kA@mail.gmail.com>
In-Reply-To: <CAMw=ZnQk5ttytEKO6pK+VLEhSO9diRAqE9DEUwjXnQkz+Vf7kA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 7 Nov 2024 00:22:33 +0100
Message-ID: <CABgObfYrX8O-Vj5g7t8DD=6_twedXToajNtLedLgtKR6+G9_Hg@mail.gmail.com>
Subject: Re: cgroup2 freezer and kvm_vm_worker_thread()
To: Luca Boccassi <bluca@debian.org>
Cc: Tejun Heo <tj@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, kvm@vger.kernel.org, 
	cgroups@vger.kernel.org, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 12:21=E2=80=AFAM Luca Boccassi <bluca@debian.org> wr=
ote:
>
> On Wed, 30 Oct 2024 at 18:14, Tejun Heo <tj@kernel.org> wrote:
> >
> > Hello,
> >
> > On Wed, Oct 30, 2024 at 01:05:16PM +0100, Paolo Bonzini wrote:
> > > On Wed, Oct 30, 2024 at 1:25=E2=80=AFAM Tejun Heo <tj@kernel.org> wro=
te:
> > > > > I'm not sure if the KVM worker thread should process signals.  We=
 want it
> > > > > to take the CPU time it uses from the guest, but otherwise it's n=
ot running
> > > > > on behalf of userspace in the way that io_wq_worker() is.
> > > >
> > > > I see, so io_wq_worker()'s handle signals only partially. It sets
> > > > PF_USER_WORKER which ignores fatal signals, so the only signals whi=
ch take
> > > > effect are STOP/CONT (and friends) which is handled in do_signal_st=
op()
> > > > which is also where the cgroup2 freezer is implemented.
> > >
> > > What about SIGKILL? That's the one that I don't want to have for KVM
> > > workers, because they should only stop when the file descriptor is
> > > closed.
> >
> > I don't think SIGKILL does anything for PF_USER_WORKER threads. Those a=
re
> > all handled in the fatal: label in kernel/signal.c::get_signal() and th=
e
> > function just returns for PF_USER_WORKER threads. I haven't used it mys=
elf
> > but looking at io_uring usage, it seems pretty straightforward.
> >
> > > (Replying to Luca: the kthreads are dropping some internal data
> > > structures that KVM had to "de-optimize" to deal with processor bugs.
> > > They allow the data structures to be rebuilt in the optimal way using
> > > large pages).
> > >
> > > > Given that the kthreads are tied to user processes, I think it'd be=
 better
> > > > to behave similarly to user tasks as possible in this regard if use=
rspace
> > > > being able to stop/cont these kthreads are okay.
> > >
> > > Yes, I totally agree with you on that, I'm just not sure of the best
> > > way to do it.
> > >
> > > I will try keeping the kthread and adding allow_signal(SIGSTOP).  Tha=
t
> > > should allow me to process the SIGSTOP via get_signal().
> >
> > I *think* you can just copy what io_wq_worker() is doing.
>
> Any update on this? We keep getting reports of this issue, so it would
> be great if there was a fix for 6.12. Thanks!

No, did not have time yet.

Paolo


