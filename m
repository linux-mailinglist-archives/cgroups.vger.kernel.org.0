Return-Path: <cgroups+bounces-2333-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB321899494
	for <lists+cgroups@lfdr.de>; Fri,  5 Apr 2024 06:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C7B1F2548A
	for <lists+cgroups@lfdr.de>; Fri,  5 Apr 2024 04:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0533D208CE;
	Fri,  5 Apr 2024 04:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gvs8UBj2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01423A21
	for <cgroups@vger.kernel.org>; Fri,  5 Apr 2024 04:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712292495; cv=none; b=bjeeNAJ/ZZUqjnBbwUm+RNtvutL0PrmRv0XVBTR4ABp2C3z6+l5NqwTiCRwGoyGJe0OSUxe/IhAVkA6K2mqL5aNp0VDORXpIDSPD2H1POwET6QUSb6TB/ByALFMVrl6CrQJ7/mFDQ3ZNxcIr2Tpe//qB0/qPIWZnmFre22pfGEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712292495; c=relaxed/simple;
	bh=/sP0SD/6VqgaBAHZ+LHcRfVmnRlCmXpDOr9SbVDicas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rNWs7dA3/AvTO14MgzL/HJGk2i+7K4+8A7+5rrRX6qPR7v5EfebzudM0WcGKPi3DpZq2zUFTLeadthW6SK69CroDD5NdLvnRrI+5Eta86pGuf4MV0SQ5YxY6ANw4dJQ0hGRUvoR8uWpVBsU3VTHG4xLTucH7tVK8hSKMPB7p1+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gvs8UBj2; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a46ba938de0so242990466b.3
        for <cgroups@vger.kernel.org>; Thu, 04 Apr 2024 21:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712292492; x=1712897292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFngNohcsIWWF9VBx68/C+XJdy9eZcqacGTQk/W+jbI=;
        b=gvs8UBj2OZ7kfvX/yxpZHfvqZC8IaTsGdI8dQKranVqAFIjghKq+sNal8aKTGEB/9K
         w8ErvSX5EQNs3YFQxcc0Msb4OGyRjLlAmpV4I9EHoIVI/zP5er14NQjaigywFPJInd3Z
         emDjMlddFBl3//+NYcjjr/eNmMGM0Md0xlx5yUDGGnH9QIchu4dOY1DsXvKm+yhjiK4n
         +XRC3cbKSHoW6R70poDKYLdt4rDnpfH/PhcE829Dtwcy2HOsQTtvxTcqUd6SMvz74jn6
         mgW8SaEorxPMLZhneH3NhH93Q9/Zj9R3+MKPOY1sJDrcNswmUIv3KF/bcnZVq5UNMJYj
         8zXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712292492; x=1712897292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFngNohcsIWWF9VBx68/C+XJdy9eZcqacGTQk/W+jbI=;
        b=uiMvOGUztKBxaBW73YKtxFvcRfOQh7C/0wx2WTSMBN8/9rnRybdP3BFijKbhK+to97
         rE+4DWVLHgRMmXu6Ug2R6RPlWqk9obTLX3ZsNHlWFNHGnVkusQX9jwsG2GWO0bKOmd33
         YJ/ZU80jcGWhB6TpsJ6/97NiSULPJcEOtVLpuCWen5Me3AkbyPmr5kgs5BfuYuufqm4i
         lb0CCjGFt4vgbm9ZgIDEw4fCA+DAqEn4C7RKhstsUhED+pTRWDWVZEYrRp7tMGAm6OHu
         juR9GZsyhs5OFVLiAOis0CguK6wt9/69xQ0dpkeMoZJlW+xeQx3WG2zHxi0JKXAoaB2f
         WPcA==
X-Forwarded-Encrypted: i=1; AJvYcCU2bYGN6605ZNDfRkZD/cgNIEc8S2fD4pPpUBRdXoq+8y8UUgYC+JSuqr7kHZ4TsdDAV6rReedDpnTBMQb3IW8XJWVD3U+ivA==
X-Gm-Message-State: AOJu0YyJtFRGuJIUpma6v6OxOVtD+bSmJ+xyXz1d2NrjsAhDexRqnX1H
	YeW+l7l2MRPz8TxVFeCG62jpGejxEpJSjQLfGaND5y5lvxEGWm3cOutRQAQCqzImP5JrKzUEM4l
	usrCKuVZ7sSx1O3mdZ3a4Gb5MqJMoCXe5TNxt
X-Google-Smtp-Source: AGHT+IG0FTUjSAmspO/nmTPWRrODUK6jOybARjqK66uz0z8iWEoCJvp6YB5mNy5YKEO10BQdeJehh0/wHKz/44T7/BE=
X-Received: by 2002:a17:907:985b:b0:a4e:109f:7b4b with SMTP id
 jj27-20020a170907985b00b00a4e109f7b4bmr215688ejc.41.1712292492092; Thu, 04
 Apr 2024 21:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000007545d00615188a03@google.com> <20240403180752.f95e1b77e033b5e03164c160@linux-foundation.org>
 <CAJD7tkakCEg9zkwCrBr8GyObO7b9KOD6rUgyqniFN+YTCePd0A@mail.gmail.com> <CAOUHufZPLEmrh0x43k2ysqvwYwEotGk8Bw=fwyO9aLXXv0aM9Q@mail.gmail.com>
In-Reply-To: <CAOUHufZPLEmrh0x43k2ysqvwYwEotGk8Bw=fwyO9aLXXv0aM9Q@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 4 Apr 2024 21:47:34 -0700
Message-ID: <CAJD7tkbMR1AdKz3GquHym1MGROgpMcjiubKQ2oOzmpObTHd9Tw@mail.gmail.com>
Subject: Re: [syzbot] [cgroups?] [mm?] WARNING in __mod_memcg_lruvec_state
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	syzbot <syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com>, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 6:44=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Thu, Apr 4, 2024 at 7:36=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
> >
> > On Wed, Apr 3, 2024 at 6:08=E2=80=AFPM Andrew Morton <akpm@linux-founda=
tion.org> wrote:
> > >
> > > On Tue, 02 Apr 2024 01:03:26 -0700 syzbot <syzbot+9319a4268a640e26b72=
b@syzkaller.appspotmail.com> wrote:
> > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    317c7bc0ef03 Merge tag 'mmc-v6.9-rc1' of git://git.=
kernel...
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D15fd40c=
5180000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df64ec42=
7e98bccd7
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D9319a4268=
a640e26b72b
> > > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils=
 for Debian) 2.40
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > >
> > > > Downloadable assets:
> > > > disk image (non-bootable): https://storage.googleapis.com/syzbot-as=
sets/7bc7510fe41f/non_bootable_disk-317c7bc0.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/efab473d72c0/=
vmlinux-317c7bc0.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/5ba3f56d=
362d/bzImage-317c7bc0.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by: syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
> > > >
> > > > ------------[ cut here ]------------
> > > > WARNING: CPU: 0 PID: 30105 at mm/memcontrol.c:865 __mod_memcg_lruve=
c_state+0x3fa/0x550 mm/memcontrol.c:865
> > > > Modules linked in:
> > > > CPU: 0 PID: 30105 Comm: syz-executor.2 Not tainted 6.9.0-rc1-syzkal=
ler-00178-g317c7bc0ef03 #0
> > > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-deb=
ian-1.16.2-1 04/01/2014
> > > > RIP: 0010:__mod_memcg_lruvec_state+0x3fa/0x550 mm/memcontrol.c:865
> > > > Code: 45 85 e4 75 1d 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f c3 c=
c cc cc cc b8 00 04 00 00 e9 80 fd ff ff 89 c6 e9 a0 fd ff ff 90 <0f> 0b 90=
 e9 a7 fc ff ff 48 c7 c7 18 43 e1 8f e8 32 51 f8 ff e9 5e
> > > > RSP: 0018:ffffc900034beef8 EFLAGS: 00010202
> > > > RAX: 0000000000000292 RBX: 0000000000000001 RCX: 1ffffffff1fc2863
> > > > RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff888024b92bc8
> > > > RBP: ffff888024b92000 R08: 0000000000000005 R09: 0000000000000000
> > > > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
> > > > R13: ffff88801c326000 R14: 0000000000000001 R15: ffff888024b92000
> > > > FS:  00007f0811bf96c0(0000) GS:ffff88806b000000(0000) knlGS:0000000=
000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 000000000cfff1dd CR3: 000000003e4e2000 CR4: 0000000000350ef0
> > > > DR0: 0000000000000031 DR1: 0000000000000000 DR2: 0000000000000000
> > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > Call Trace:
> > > >  <TASK>
> > > >  __update_lru_size include/linux/mm_inline.h:47 [inline]
> > > >  lru_gen_update_size include/linux/mm_inline.h:199 [inline]
> > > >  lru_gen_add_folio+0x62d/0xe80 include/linux/mm_inline.h:262
> > > >  lruvec_add_folio include/linux/mm_inline.h:323 [inline]
> > > >  lru_add_fn+0x3fc/0xd80 mm/swap.c:215
> > > >  folio_batch_move_lru+0x243/0x400 mm/swap.c:233
> > >
> > > Well it beats me.  I assume we failed to update for a new case.  I'll
> > > toss this into -next to perhaps shed a bit of light.
> > >
> > > --- a/mm/memcontrol.c~__mod_memcg_lruvec_state-enhance-diagnostics
> > > +++ a/mm/memcontrol.c
> > > @@ -860,10 +860,12 @@ void __mod_memcg_lruvec_state(struct lru
> > >                 case NR_ANON_THPS:
> > >                 case NR_SHMEM_PMDMAPPED:
> > >                 case NR_FILE_PMDMAPPED:
> > > -                       WARN_ON_ONCE(!in_task());
> > > +                       if (WARN_ON_ONCE(!in_task()))
> > > +                               pr_warn("stat item index: %d\n", idx)=
;
> > >                         break;
> > >                 default:
> > > -                       VM_WARN_ON_IRQS_ENABLED();
> > > +                       if (VM_WARN_ON_IRQS_ENABLED())
> > > +                               pr_warn("stat item index: %d\n", idx)=
;
> >
> > Line 865 from this commit should be this warning (i.e. warning because
> > IRQs are enabled). This also makes sense because __update_lru_size()
> > should not be updating any of the above stats.
> >
> > folio_batch_move_lru() in the above call stack should be acquiring the
> > lock with IRQs disabled though, so I am not sure what's going on from
> > a quick look.
> >
> > Adding Yu Zhao here.
>
> Probably an RT build where _irqsave doesn't disable IRQ?

Yeah, that's possible. I don't have enough familiarity with RT to know
for sure. Perhaps lruvec->lru_lock needs to be changed to a
raw_spinlock_t? I am not sure if that's the correct course of action.

