Return-Path: <cgroups+bounces-2795-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD388BD235
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 18:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8D7285A7A
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 16:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07AE156223;
	Mon,  6 May 2024 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0q8uZ/zt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EE6155757
	for <cgroups@vger.kernel.org>; Mon,  6 May 2024 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715012012; cv=none; b=El9ki5N5M2Dh9B8PL/DgzoWJ33NEkQq56M2GAw3u+enjK/knTQG22Sg0j3+JW4U/P1n0GXXjSw7LIvKzs3qluoHyl+6OMijqdKw38WXetocFd0evrJseBf6mtH7XbFs1rbqjbBvnHq7TUB6Gs2uAYdZxnJLYAt4ZPOc8EVhLWXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715012012; c=relaxed/simple;
	bh=7+2Zwg31lOd07Oa1eR/hleD9eYRFnRcCwEZgaNvKYb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWm2M2DL2K7KSfY3dPsSjspxMDY1QplNaPjKIyO10miEgc6gd2BKav08PeAir7VS9Gh/opmxcBzjzpQgEl9/XgzTUr3DJ/cOB386uePYVlqG/NUbttfsvpESoze7pAUqTfmp2C4oSfKyUgkyfVJGbntVKNKBVefd1fxX3TkkxF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0q8uZ/zt; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59cdd185b9so178371066b.1
        for <cgroups@vger.kernel.org>; Mon, 06 May 2024 09:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715012009; x=1715616809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCYAJR1IdgPjREP1tbDJpbumcoJvWIKDqFqpn65YT0o=;
        b=0q8uZ/ztYZ+VXBBxCkCC74csBUt3IR6/hFFtBQeQptmiwZGrzv7ieaCtZ//Yv2n/uT
         hxk6+oYs0E6aPMbZ0KTgOQLqCp8TVaXU04/Ayg+Rd9IkYzlYfjRERGrT4OrJu4ZtkUde
         C6Uhf+2KH1BA4pbxLyiZMSYJ88RRicqdErRTg8uQw53shw1ExL5MI6BhOPu7gLqzQ919
         z3QbuikdV5FDHhFNqp9vrTXM+hnUVK8fMAEjcZXDXNd5bQBrZq3c87ubss3dVORpK26D
         70+xjpNT6XsyMeeM/51YqFZb/CrhgFpP+CulPraDuB55SXJnteecAzBJgGFiOhGt26Qj
         9Ftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715012009; x=1715616809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCYAJR1IdgPjREP1tbDJpbumcoJvWIKDqFqpn65YT0o=;
        b=OijDVqoROibE+MqCCFO5WVv5ZrDflrRbfhiuO9oC05/dGyB4/OmqXjzbcuDpyhLzjK
         Usqg67y4BJQQzKAnluSKvawufObC2CXHU1owD8BgK3TGzo0ym/sDT1e/x+dGD33Yd9ih
         Vj9nDMU67uXEnuwaX/vWGBW6rAakZbnkqt+qz5TlhDSTAwOQfVJQN9pDfukxpKr36VdP
         OJL+NTsTTVmYx+2q/Unrl6EFomhN6EjRM53CKfNyxdltglWMb29N4UpVFZZpxBYIpLT5
         +q74PMyD0NSwk4a97a/Erfnf2wRdSBOeGg3ZB/gxXAI1sHs2uLvELZm8IoGuKPvGAqAy
         FrEw==
X-Forwarded-Encrypted: i=1; AJvYcCWhZS6AYO97mU4y/MehHN8Q8aWVDBT7tGl137DuI7tLGmxZeRwNWSOZ5yTGTAyUb3jCn+ihd4hXsFF9jmqN7qZho0Zx1OlV2A==
X-Gm-Message-State: AOJu0Yystg7YXhVHo+Elb3/8IW9ugNHNV2xVJ2rtvTyS5VbLyJ7lSMPu
	Pc4rAj60DM7Fbz2ckjYFh6kT5DK3GSySkrCTxs9MeY4MZNA1CZYqA3h4o2vBAmVfHnSNXqOedD0
	pUkHWkMW2WRQNwXtGM38fxMop3aGBK2Iiw361
X-Google-Smtp-Source: AGHT+IEl6O4ILNj9fQHQiZgV5xjHRsOzMtUZx6feBdBMRClUOE2LxlyQoEi9EaI8l5Y5k/bVp0avGFzlHE80pzDES6s=
X-Received: by 2002:a17:906:2a98:b0:a59:c807:72d3 with SMTP id
 l24-20020a1709062a9800b00a59c80772d3mr89978eje.17.1715012009336; Mon, 06 May
 2024 09:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000007545d00615188a03@google.com> <0000000000001b9d500617c8b23c@google.com>
 <ZjjlLcjHuQoV-7gh@google.com> <gbsy4rpt3fbcspuepstk6tzzwd3mrosuba7ufm7phopwor4pyb@ucxrvdw6nly3>
In-Reply-To: <gbsy4rpt3fbcspuepstk6tzzwd3mrosuba7ufm7phopwor4pyb@ucxrvdw6nly3>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 6 May 2024 09:12:53 -0700
Message-ID: <CAJD7tkYVa5WQ=rSWYbm6EwAVJFjQE4iGsue8aOA80j6OHO6iQQ@mail.gmail.com>
Subject: Re: [syzbot] [mm?] [cgroups?] WARNING in __mod_memcg_lruvec_state
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: syzbot <syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, 
	syzkaller-bugs@googlegroups.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 8:59=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> On Mon, May 06, 2024 at 02:11:57PM +0000, Yosry Ahmed wrote:
> > On Mon, May 06, 2024 at 06:03:29AM -0700, syzbot wrote:
> > > syzbot has found a reproducer for the following issue on:
> > >
> > > HEAD commit:    2b84edefcad1 Add linux-next specific files for 202405=
06
> > > git tree:       linux-next
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1164931f1=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db499929e4=
aaba1af
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D9319a4268a6=
40e26b72b
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for=
 Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D123d5d1=
f180000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D165274509=
80000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/6a22cf95ee14=
/disk-2b84edef.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/f5c45b515282/vm=
linux-2b84edef.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/9bf98258a6=
62/bzImage-2b84edef.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
> > >
> > > ------------[ cut here ]------------
> > > __mod_memcg_lruvec_state: missing stat item 25
> > > WARNING: CPU: 0 PID: 5091 at mm/memcontrol.c:999 __mod_memcg_lruvec_s=
tate+0x18c/0x430 mm/memcontrol.c:999
> >
> > This doesn't seem to be the same issue as the original one syzbot
> > reported. It's the same function but a different warning. I am not sure
> > how to tell syzbot that.
> >
> > Anyway, this warning is the one newly introduced by Shakeel. It is
> > firing because NR_SHMEM_PMDMAPPED and/or NR_FILE_PMDMAPPED are being
> > updated using __lruvec_stat_mod_folio(), which also updates the memcg
> > stats. However, these stats are not exported per-memcg.
> >
> > I think the following should fix it.
> >
>
> Hey Yosry, can you please post your patch with the signoff? The patch
> looks good and you can put my ack on it.

Will do. I noticed we also update these stats from
__folio_remove_rmap(). I will send a patch fixing these as well, so
I'll not include your Ack for that as it will be different.

