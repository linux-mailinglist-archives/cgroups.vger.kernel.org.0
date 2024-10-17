Return-Path: <cgroups+bounces-5147-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ED59A1972
	for <lists+cgroups@lfdr.de>; Thu, 17 Oct 2024 05:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895511F2326C
	for <lists+cgroups@lfdr.de>; Thu, 17 Oct 2024 03:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BA71369B6;
	Thu, 17 Oct 2024 03:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLoZdNLw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0122C6BFC0;
	Thu, 17 Oct 2024 03:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729136689; cv=none; b=C2AlwlwOPP74/usTss9sBH3BAn1JDv1bKBMVfZwWRuK2cBlm9Iri5nB/j67jgkAQYL/ZOaeCpwMN4iRdrUp3ENKJ+Q9mBTKE+j2LUZYF4uW8yJgwvqZ7qIF5h953L2DQTzYUzMBcMpwRjXwW0mK/rDzb33aG20ACZnG/SBMZBLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729136689; c=relaxed/simple;
	bh=pRFPATnQENrImT54UxMxbwhpzy00PtA0DnAZUuGUA7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FjBfZ+ba/2O7hBbOAeBmijxoiHfuhigElLggpBMUexzPqEjO+QNeyB+v0ldFskee7T58WQy8ExSvl7fhwyGQ8brOftLPPpU/0vO6A3uG3+qAvDLZyDfiStYg5UIl10MdGbHlkCSMAPDM9GlvVUNPub7fVcvRHyD0It02FAoYAlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLoZdNLw; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c93109d09aso87292a12.3;
        Wed, 16 Oct 2024 20:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729136686; x=1729741486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRFPATnQENrImT54UxMxbwhpzy00PtA0DnAZUuGUA7A=;
        b=fLoZdNLwpw0X7Hji41xusrS4zZt/L87EWeo1ieECYOYP5ThLpOQxBC9QGydpZybP2i
         c9ZWS0kW8Lph7el61EfohiAfAqpAHA5Cn3O9n4eRmMxfbb90owuw6PZ0owo5ExxWOpaE
         Tde23EKgwCT926+9XXB7fgwHzUwWNHX7L26XD2SuXZeUmCRkA9MjxyaZrpfHr3nz0h28
         /dHrq9nigywH1DLhJzLs1jZ55ah2h9QkmSn7yvndz14YWoIUMVN8cqkB/PYYN4libuy5
         BsQCVTrukFb0qt7kCYuGHsGULep2DWP1SxDDsBNNmuUrXUptU+teZPieB3WiTDc3fQbK
         yf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729136686; x=1729741486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRFPATnQENrImT54UxMxbwhpzy00PtA0DnAZUuGUA7A=;
        b=C41iQlvf4S97IbSOg8FqKCnuAXP1cRhMRciKp3cCpKTVO6AALWJxTIdA97W7u39qkU
         J5dXLNv/jr0BFWqmVybxOAp7Rztjp+raOA2x8u49rIJrUNFHSW/JkY+A39CFC29MxeSS
         fTG39Hn3EUuBpzYL6vL/3QVgTuiFTz/mqms7B7n7zo9J9k4aq1ywKXYYoUcTf3iuae9u
         DJr/zsRJrDDxnC+Ce002LDgZ3ObTpx8anEJ7DxCWDKFfaGLkI+0UEQ/UCJ/xmxIHMihb
         vAiDsE6hKoHW6R5hRlIfIKqGd0J/qI8Ck8hU78vY152mWuCWxoQOl1o2h/6bo9MY4947
         3ywg==
X-Forwarded-Encrypted: i=1; AJvYcCWPGErth19FJoXKTDjOixyRNGqxx++qhr3UAWgpFx0Y9SDnoRNUqxnjRYJMwNIC+hIlO0Uq5vjWP2iOJcC0@vger.kernel.org, AJvYcCXOfHImGqeayFN/Wjy8ASN68fruvP+cG2QDJcsovKYfNawGlyXPfuBgzDumF/QEo38F6wKSVWs1@vger.kernel.org
X-Gm-Message-State: AOJu0YwN95FPoXZejPVMnJez+haFA+c4ldi5Qql5OYrZ7HpTyGKj3DCo
	yt7232NEdJU/mLHkqHi7OoJEmFqAoLmwjKhxbY7akSBWZ9nM8SXhtjJzGLVEghxJ42f8Ebi3Zl9
	AKnODMPs4y8WSDmy9yErOcJ6zesA=
X-Google-Smtp-Source: AGHT+IEFgLajsy6XSLEQ76Vln1OyqkMRcgiOrfUAS9O6+JLWrOflA44s8/kAHwo1yRMd1o3hAusxeWfNsvSc0wuZtaY=
X-Received: by 2002:a05:6402:5107:b0:5c3:eb29:50c5 with SMTP id
 4fb4d7f45d1cf-5c9997d3c9fmr1392040a12.9.1729136686031; Wed, 16 Oct 2024
 20:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJg=8jwFexnoTfPLg=Yd44WFVn05wAn0UgH6=baipc53mDxgyQ@mail.gmail.com>
 <CAJg=8jwrXQm19K9YpBuX=LQwwq1cDSpP6ez1XRRE7mAg_8_Xiw@mail.gmail.com> <CAG_fn=Ww=dZ82B0Or8OJfYm1KB7JGMUQ9ZwyjMNP6pN7BxmLQw@mail.gmail.com>
In-Reply-To: <CAG_fn=Ww=dZ82B0Or8OJfYm1KB7JGMUQ9ZwyjMNP6pN7BxmLQw@mail.gmail.com>
From: Marius Fleischer <fleischermarius@gmail.com>
Date: Wed, 16 Oct 2024 20:44:34 -0700
Message-ID: <CAJg=8jxjVZqQN-KcHEWAy2gfjOMZpt4wvLmQ-RF-fLZfhS5nvw@mail.gmail.com>
Subject: Re: general protection fault in bio_associate_blkg_from_css
To: Alexander Potapenko <glider@google.com>
Cc: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, 
	harrisonmichaelgreen@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexander,
Thank you so much for the hint!
I can confirm that the reproducer also triggers on version 6.12-rc3
(commit 8e929cb546ee42c9a61d24fae60605e9e3192354 from the
stable repo).
Hope this helps!
Best,
Marius

On Wed, 16 Oct 2024 at 00:18, Alexander Potapenko <glider@google.com> wrote=
:
>
> On Tue, Oct 15, 2024 at 8:24=E2=80=AFPM Marius Fleischer
> <fleischermarius@gmail.com> wrote:
> >
> > Hi,
> >
> > Hope you are doing well!
> >
> > Quick update from our side: The reproducers from the previous email
> > still trigger a general protection fault on v5.15 (commit hash
> > 3a5928702e7120f83f703fd566082bfb59f1a57e). Happy to also test on
> > other kernel versions if that helps.
> >
> > Please let us know if there is any other helpful information I can prov=
ide.
> >
> > Wishing you a nice day!
> >
> > Best,
> > Marius
>
> Hi Marius,
>
> Please consider only reporting bugs that are reproducible on the
> upstream kernel:
> https://github.com/google/syzkaller/blob/master/docs/linux/reporting_kern=
el_bugs.md
> 5.15 is almost three years old.

