Return-Path: <cgroups+bounces-10006-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57878B5468C
	for <lists+cgroups@lfdr.de>; Fri, 12 Sep 2025 11:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1F51BC17FC
	for <lists+cgroups@lfdr.de>; Fri, 12 Sep 2025 09:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365732749F1;
	Fri, 12 Sep 2025 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aploMs7w"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F185D276028
	for <cgroups@vger.kernel.org>; Fri, 12 Sep 2025 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668345; cv=none; b=mGs3VWRKaQqSwjPvFayhE9h+nn3RzMbXygvIWAeGdyKho3nnXj2Y0XKNHRpGfKCl7j993HwhE8jCZDbi7cdHdiRJj/RUSPuWd7zyznN9rt8uvU/FAJ/UkCV5LPwwS8UM6gXCMEoYYfx31Rafyd/nL0FZ2T6G6qarhEDWPPSK3vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668345; c=relaxed/simple;
	bh=ioIOH2p5Blrv6vNOqNmSCymoSvN1zmkkAsnVeBc1SMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ev1nedUy0O4As1hXySVRwzqMwFN4oaw6M1vARY2JDaoVtqQL0yDOU5QN7w58gb2cItgh7U1mEv2hKP4fq9CBRkbUsZpSE+plz59ECL2KexSXhayaTu/FEwvS29IrF5y6Ybb1um2f5KRbhZpBBa3ejsaXaUqYXIHcSdTRdUctfPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aploMs7w; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b046f6fb230so320452266b.1
        for <cgroups@vger.kernel.org>; Fri, 12 Sep 2025 02:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757668341; x=1758273141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioIOH2p5Blrv6vNOqNmSCymoSvN1zmkkAsnVeBc1SMY=;
        b=aploMs7whY/LgaXCAuOUQbkHlH9PozV3z9HFoHHh4tp/dJFhM6pt21fAvHgYgjlN8M
         rmpVcHSueNagemUBdQowpA6BdoN7gqqaLplS1v3ScHX+yKhTwev5VBs4Bed/9bkH4dLN
         4rfLLpcIvHJONxgYVXSLM7qEor3rn+MmXCTKDCzXypEm5HHBP38sGD0OFUOjAm326bQ+
         1r2w7gh4g7621FkXF6rJzjHEIMZg4g13DDPyWgPK4mWuR3T6PMXO71Jvdha7GKG/r6lh
         avbJhFNvPx4G+gPZm0XJKYAQwKp/BQENGe5DK6uHxVZst/QOlcM6CwamdS6qIfXycNC8
         TKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757668341; x=1758273141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioIOH2p5Blrv6vNOqNmSCymoSvN1zmkkAsnVeBc1SMY=;
        b=ubdHWqUY4F/A02gx5TDDm4qstW6VaCbZcrPGv9KTdH5KW9tNdqoMPgpvYejwKq5vVM
         rdDHizOumBPwcshQEG0BFEUHeYUggnpRFiZ66bqMc/zddVtY2AdN58BzkEKa9Om6+Kky
         +rk0e6QK03N4Uk3iRi6OVxOHG/5s33Fl7Rh89VAU0EXF1dodHxrZiEekDgSjTeYPGsz4
         UpoCFDlsQYrW7oYJ3qAoWtuPpmOwVuoalCxdPYilQr7og62PtqZeGvujcJjUIEo5jZ0w
         97ccVBXGJlJVjq5d2PMq0BaIPj8F8Hb49nxP/pExxjOBRvYeVD71niTyS5sEKzYlmlvQ
         eAtw==
X-Forwarded-Encrypted: i=1; AJvYcCXsvtKByB5ca89tXZqNiGVsXCdFb0AodUyMWcxRI+CGFDjeP9uiMkD2faRt+D19jPVQY9pt5O6d@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1pfonZ1qdqQIddFsjl5H9x2ZUJ3RZD3av4wDS/qppbBSxC/LT
	RC4617PdefVy/Z7UY924O/MfYY/TDUALtV1vwfgJpbLi0BqToIIMoo2xneXR0ouTIWwTe2AmxGu
	AxVdkM6z5aj0fS8jrvojhmigyMRAjd3w=
X-Gm-Gg: ASbGncv155uXI9dYGEuNcEWrtBsanmpA0knh+R/fl2SU61bnvKhtpJzxPW7Q9bDz+qi
	lzteXxsP7mx4XSgYfzq/6K75LMG9+r8tUP7b5/lbLg2lgueCj57NmQgM3E5NVfs+he7Nk7SMnve
	q0/QydEF3AJ6/lGiy5WG7tw4wvVeUsXDZrnDQ2g5bWcxDT3wRJPQI1X2bzAyhv+ujByPtyPs8jG
	kAhttk=
X-Google-Smtp-Source: AGHT+IECQ2FSxCpELdyt8w8+Ta17OX81olY1L21qGnLXRiiNiAsbzwmD/JJZPTQJsBBXBb5BWfCf5Q2bF6gDjvOJbJk=
X-Received: by 2002:a17:907:3e9f:b0:b04:3402:391c with SMTP id
 a640c23a62f3a-b07a68bddd8mr590036766b.24.1757668340932; Fri, 12 Sep 2025
 02:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-27-4dd56e7359d8@kernel.org> <CAOQ4uxgtQQa-jzsnTBxgUTPzgtCiAaH8X6ffMqd+1Y5Jjy0dmQ@mail.gmail.com>
 <20250911-werken-raubzug-64735473739c@brauner> <CAOQ4uxgMgzOjz4E-4kJFJAz3Dpd=Q6vXoGrhz9F0=mb=4XKZqA@mail.gmail.com>
 <20250912-wirsing-karibus-7f6a98621dd1@brauner>
In-Reply-To: <20250912-wirsing-karibus-7f6a98621dd1@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 12 Sep 2025 11:12:09 +0200
X-Gm-Features: Ac12FXzXlVrWyNxThzcVLm8bWdnJouio3PTW50wsmgaWY6Ne9FaEF2yc3iNy4og
Message-ID: <CAOQ4uxgGpdQ42d-QRuHbvdrvZWrS9qz9=A2GRa2Bq-sMcK6w4w@mail.gmail.com>
Subject: Re: [PATCH 27/32] nsfs: support file handles
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	Lennart Poettering <mzxreary@0pointer.de>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 10:20=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Thu, Sep 11, 2025 at 01:36:28PM +0200, Amir Goldstein wrote:
> > On Thu, Sep 11, 2025 at 11:31=E2=80=AFAM Christian Brauner <brauner@ker=
nel.org> wrote:
> > >
> > > On Wed, Sep 10, 2025 at 07:21:22PM +0200, Amir Goldstein wrote:
> > > > On Wed, Sep 10, 2025 at 4:39=E2=80=AFPM Christian Brauner <brauner@=
kernel.org> wrote:
> > > > >
> > > > > A while ago we added support for file handles to pidfs so pidfds =
can be
> > > > > encoded and decoded as file handles. Userspace has adopted this q=
uickly
> > > > > and it's proven very useful.
> > > >
> > > > > Pidfd file handles are exhaustive meaning
> > > > > they don't require a handle on another pidfd to pass to
> > > > > open_by_handle_at() so it can derive the filesystem to decode in.
> > > > >
> > > > > Implement the exhaustive file handles for namespaces as well.
> > > >
> > > > I think you decide to split the "exhaustive" part to another patch,
> > > > so better drop this paragraph?
> > >
> > > Yes, good point. I've dont that.
> > >
> > > > I am missing an explanation about the permissions for
> > > > opening these file handles.
> > > >
> > > > My understanding of the code is that the opener needs to meet one o=
f
> > > > the conditions:
> > > > 1. user has CAP_SYS_ADMIN in the userns owning the opened namespace
> > > > 2. current task is in the opened namespace
> > >
> > > Yes.
> > >
> > > >
> > > > But I do not fully understand the rationale behind the 2nd conditio=
n,
> > > > that is, when is it useful?
> > >
> > > A caller is always able to open a file descriptor to it's own set of
> > > namespaces. File handles will behave the same way.
> > >
> >
> > I understand why it's safe, and I do not object to it at all,
> > I just feel that I do not fully understand the use case of how ns file =
handles
> > are expected to be used.
> > A process can always open /proc/self/ns/mnt
> > What's the use case where a process may need to open its own ns by hand=
le?
> >
> > I will explain. For CAP_SYS_ADMIN I can see why keeping handles that
> > do not keep an elevated refcount of ns object could be useful in the sa=
me
> > way that an NFS client keeps file handles without keeping the file obje=
ct alive.
> >
> > But if you do not have CAP_SYS_ADMIN and can only open your own ns
> > by handle, what is the application that could make use of this?
> > and what's the benefit of such application keeping a file handle instea=
d of
> > ns fd?
>
> A process is not always able to open /proc/self/ns/. That requires
> procfs to be mounted and for /proc/self/ or /proc/self/ns/ to not be
> overmounted. However, they can derive a namespace fd from their own
> pidfd. And that also always works if it's their own namespace.
>
> There's no need to introduce unnecessary behavioral differences between
> /proc/self/ns/, pidfd-derived namespace fs, and file-handle-derived
> namespace fds. That's just going to be confusing.
>
> The other thing is that there are legitimate use-case for encoding your
> own namespace. For example, you might store file handles to your set of
> namespaces in a file on-disk so you can verify when you get rexeced that
> they're still valid and so on. This is akin to the pidfd use-case.
>
> Or just plainly for namespace comparison reasons where you keep a file
> handle to your own namespaces and can then easily check against others.

OK. As I said no objections I was just curious about this use case.

FWIW, comparing current ns to a stored file handle does not really require
permission to open_by_handle_at(). name_to_handle_at() the current ns
and binary compare to the stored file handle should be a viable option.

This was exactly the reason for introducing AT_HANDLE_FID, so that fanotify
unprivileged watcher with no permission to open_by_handle_at() could compar=
e
an fid reported in an event with another fid they obtained earlier with
name_to_handle_at() and kept in a map.

Thanks for the explanation!
Amir.

