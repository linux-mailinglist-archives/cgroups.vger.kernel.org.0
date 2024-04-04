Return-Path: <cgroups+bounces-2327-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D49F289922B
	for <lists+cgroups@lfdr.de>; Fri,  5 Apr 2024 01:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0393B1C2298B
	for <lists+cgroups@lfdr.de>; Thu,  4 Apr 2024 23:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3667113C672;
	Thu,  4 Apr 2024 23:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sgyD3VhR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9E813C3DD
	for <cgroups@vger.kernel.org>; Thu,  4 Apr 2024 23:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712273805; cv=none; b=tTXIAmWcToAeQm6RiEXxAcxlep/psUgZuECoiRwEHWOt20X5nkmJh5fr6ciHKN9aiG4QikeQPRLm7nbjIH98M7EBkoNPF1fDfJKqmQz02FfePl2sgztcrrrUTwYmAfYwwkj0dfSZ1M96SsqfNCHR5soS84IrUVc+ATGpwVBOPDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712273805; c=relaxed/simple;
	bh=KouUn0K398FqDmbn//sdAxYDPb3wIt3ud/qQYiZUIAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f89FmmWVXZ5OZ0Eswqw2t4xqyIL/QKMxgn1YWENNyqLR+isuYGFIw06sBr6w1mVs6S/oMgkgLzomlOOlSM6DG9t9h/qEB8Emt5/LhkZpmbz0JTh2gcLSlglZQESFjKB0hu+8zwgc4jFKdKnHvkkwyCPzfqgtNTh/+I9wTvKycgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sgyD3VhR; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e0f8480fbso1707810a12.1
        for <cgroups@vger.kernel.org>; Thu, 04 Apr 2024 16:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712273801; x=1712878601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPaPLo4tvZFunx9Zm5TfZKvrRMiMo0LvEV2TyEtrGw8=;
        b=sgyD3VhR/MKZFIPwlen97fISoMB+qgplSJ2hj3Ao9vh4VRg2H9iJTWM04XOmgyMJyh
         cpcL1c/aG6Ww4CBWD7uzIu8eiHFF1zzVbpLa+jELoOpn7AZn9gffREgcc/wwhYoOf939
         RkfnAQ0Q+kfyUa3xM9lgf2/slksbjM0EVQny+ldH8YNuV3oUwiNMFubwCPXwq3c7YTH7
         O9HTTxWpp8lLdLCnXbEtOqfaNenKTa7UD89kHj8hQaEzfuXsXCV5yWYJEXWGhd2OOpSO
         Ml0gpaDaDPF1Z4M2ipKfs7Wh4/iZo8QVF+PvkkOBfsrdSeNTp4xOIIZUZfeIuwQnzAcF
         CF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712273801; x=1712878601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPaPLo4tvZFunx9Zm5TfZKvrRMiMo0LvEV2TyEtrGw8=;
        b=lzZziJ5spDfmMsrsOFXq7wxSGaZbToJ/Kyra968eC9ZuhZV4u9QNqeIfNixSECDXx2
         LbQ5+KJ4F4nRZ3VC1qJ47Wqcuv4skzQGITqSHoitvCQGFOOmQxb9Tb4C3SOeuKwXe5dk
         oRR9obiA0AqZ3PoNUfIRUxDazDvtc5LDvVC+glgIh+Kxlj0THTikQX4irSeIdpU4ElrM
         k27zfed9x9wnsliFE4pV8DTbzLfocK9Mzt56dTfxwRYduqwY1DO1zCBN2OuJ9Tg0LlKg
         /aUcwHAi9r/8HfQWPf3jKcKGDIB4ROpDRj7xxzpT6i54qbc+gedFvNksfvXtSXPHpiXI
         DEzg==
X-Forwarded-Encrypted: i=1; AJvYcCU7n8YLYjAseSDN6zDc7a04ly6me6INqL3Hvz7BEm1Ivf+xCUMXkumDVHe30uOBzRN+b2HCKhCGJ7QqWDJMc2VDy0os6lvx+g==
X-Gm-Message-State: AOJu0Yx11ebCib8OcJqEUAV1AwufGK8Qdwqhl2uu/vBcj14PaHYGVucv
	0RDI+Bven5oKzhyd567ulqi6/KG+THLDUlr5BMertGxrxiIqoeCTSWxvK+0EjDD3KGekG+Nz0du
	2m6ITHyk4GCJ1s/i3sMM+Jt2rHlREs+qCxArN
X-Google-Smtp-Source: AGHT+IHgW8H5JiF83eWk2CFNYwC1L+/Z6Sy81eE18wk8rH7kEwSDoBNRg3oIUIv1wE0Hit+Kk3O2AQVQPQrOwuBDwCA=
X-Received: by 2002:a17:906:5290:b0:a45:ad29:725c with SMTP id
 c16-20020a170906529000b00a45ad29725cmr683187ejm.62.1712273801359; Thu, 04 Apr
 2024 16:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000007545d00615188a03@google.com> <20240403180752.f95e1b77e033b5e03164c160@linux-foundation.org>
In-Reply-To: <20240403180752.f95e1b77e033b5e03164c160@linux-foundation.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 4 Apr 2024 16:36:03 -0700
Message-ID: <CAJD7tkakCEg9zkwCrBr8GyObO7b9KOD6rUgyqniFN+YTCePd0A@mail.gmail.com>
Subject: Re: [syzbot] [cgroups?] [mm?] WARNING in __mod_memcg_lruvec_state
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com>, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 6:08=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Tue, 02 Apr 2024 01:03:26 -0700 syzbot <syzbot+9319a4268a640e26b72b@sy=
zkaller.appspotmail.com> wrote:
>
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    317c7bc0ef03 Merge tag 'mmc-v6.9-rc1' of git://git.kern=
el...
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D15fd40c5180=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df64ec427e98=
bccd7
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D9319a4268a640=
e26b72b
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for=
 Debian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/7bc7510fe41f/non_bootable_disk-317c7bc0.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/efab473d72c0/vmli=
nux-317c7bc0.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/5ba3f56d362d=
/bzImage-317c7bc0.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 30105 at mm/memcontrol.c:865 __mod_memcg_lruvec_st=
ate+0x3fa/0x550 mm/memcontrol.c:865
> > Modules linked in:
> > CPU: 0 PID: 30105 Comm: syz-executor.2 Not tainted 6.9.0-rc1-syzkaller-=
00178-g317c7bc0ef03 #0
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-=
1.16.2-1 04/01/2014
> > RIP: 0010:__mod_memcg_lruvec_state+0x3fa/0x550 mm/memcontrol.c:865
> > Code: 45 85 e4 75 1d 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc=
 cc cc b8 00 04 00 00 e9 80 fd ff ff 89 c6 e9 a0 fd ff ff 90 <0f> 0b 90 e9 =
a7 fc ff ff 48 c7 c7 18 43 e1 8f e8 32 51 f8 ff e9 5e
> > RSP: 0018:ffffc900034beef8 EFLAGS: 00010202
> > RAX: 0000000000000292 RBX: 0000000000000001 RCX: 1ffffffff1fc2863
> > RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff888024b92bc8
> > RBP: ffff888024b92000 R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
> > R13: ffff88801c326000 R14: 0000000000000001 R15: ffff888024b92000
> > FS:  00007f0811bf96c0(0000) GS:ffff88806b000000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000000000cfff1dd CR3: 000000003e4e2000 CR4: 0000000000350ef0
> > DR0: 0000000000000031 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  __update_lru_size include/linux/mm_inline.h:47 [inline]
> >  lru_gen_update_size include/linux/mm_inline.h:199 [inline]
> >  lru_gen_add_folio+0x62d/0xe80 include/linux/mm_inline.h:262
> >  lruvec_add_folio include/linux/mm_inline.h:323 [inline]
> >  lru_add_fn+0x3fc/0xd80 mm/swap.c:215
> >  folio_batch_move_lru+0x243/0x400 mm/swap.c:233
>
> Well it beats me.  I assume we failed to update for a new case.  I'll
> toss this into -next to perhaps shed a bit of light.
>
> --- a/mm/memcontrol.c~__mod_memcg_lruvec_state-enhance-diagnostics
> +++ a/mm/memcontrol.c
> @@ -860,10 +860,12 @@ void __mod_memcg_lruvec_state(struct lru
>                 case NR_ANON_THPS:
>                 case NR_SHMEM_PMDMAPPED:
>                 case NR_FILE_PMDMAPPED:
> -                       WARN_ON_ONCE(!in_task());
> +                       if (WARN_ON_ONCE(!in_task()))
> +                               pr_warn("stat item index: %d\n", idx);
>                         break;
>                 default:
> -                       VM_WARN_ON_IRQS_ENABLED();
> +                       if (VM_WARN_ON_IRQS_ENABLED())
> +                               pr_warn("stat item index: %d\n", idx);

Line 865 from this commit should be this warning (i.e. warning because
IRQs are enabled). This also makes sense because __update_lru_size()
should not be updating any of the above stats.

folio_batch_move_lru() in the above call stack should be acquiring the
lock with IRQs disabled though, so I am not sure what's going on from
a quick look.

Adding Yu Zhao here.

