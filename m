Return-Path: <cgroups+bounces-2047-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A61EF87A1F1
	for <lists+cgroups@lfdr.de>; Wed, 13 Mar 2024 04:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D751F225C3
	for <lists+cgroups@lfdr.de>; Wed, 13 Mar 2024 03:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB86C144;
	Wed, 13 Mar 2024 03:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+RhbdYk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFE910A01;
	Wed, 13 Mar 2024 03:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710300841; cv=none; b=RX80P+c3Zx6zFXBXpe46Xj3R53Vhe+zy1Y7i62GClnjYREhEuwvG9hNtbP5FICOpJz6xto01jxYP90dmEu+xKZuXrZfcGMfRWh1NJHTY+uLchwdcY+pjI/G4FC2Mj6gikuTDaabPkrFobxxb3h05GKOgfAMIIJ3EalCQVew/iuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710300841; c=relaxed/simple;
	bh=/On8k4vyETEu6WTe0KxLZS6dEteydlkGh4TTnnC7TJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Esci21zeKz75oWGuLYO1Ao0hfcfYs6i1wXG9viaPa8otdV2JCw8rPqVd3nsEbGdujr49+rZ9X8Wg+wbF345EOk4WudXEL0y+Js0KUSNQkVR9/r3mu/AN2i9sRody3fneiw+Ml3aM0Xh0mUBpa5lQga1kfbXZ7tVyr9Uk1ZL+KX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+RhbdYk; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6910c1f983bso3746076d6.0;
        Tue, 12 Mar 2024 20:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710300838; x=1710905638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuENEYXMhuQPnOQ0QKI/DLZWxbU7Fvwd76DVVZKAww8=;
        b=f+RhbdYkY244EwvD2fgwRS5foBOpFF9z0AIys5TfiHQ9yxignNrL5NqYc32znct2fS
         noXZfvRGrv6lyHHd+y0lP1CBedJwXk/O7XBPR3jnWjC4oUBVo82lLCUM16vZB5jFPFmx
         PcUu/HIBWqW8GBdO21wXbWc8hoixHXpwLENjKkK3fi6vX8VymM11YZynvQ9gK0f9JDMs
         xwkMKtJu1dRxok8ir/v0qivk3+xIyk69Gucj4lx44azgcP9ezicit1fmwezLwvioGPcJ
         m8Uyi4JAx7EQJgSCXNDJbOWM1qGSRTE1nOZ7PRiBp+yjXU9mfE605lyGJPT+EogZaMbI
         bI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710300838; x=1710905638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuENEYXMhuQPnOQ0QKI/DLZWxbU7Fvwd76DVVZKAww8=;
        b=Z42C33xkaPWADB19Pi63bNMpL0HYEU2sBWFW7IVeTefGRFbC3kuMro9r/05TJQlJXh
         YnA25T3UblYFnvqLcjxeUsZkLi6EgkiurwHbkph1leuUFWnOoKrJiyRKFFgxL5FMyo0l
         z9nOT8miyJlIrJB+r4tHvy+AAEfpruNCZSUB8zY5SyoVLovhjv6pwV24CFGNMjtUaVjZ
         c8mAL0qbKR57Qi5kAyM+Cao08H6GsoNdAvGZunBWIG2R4Mv82yrcfE2KA9EKFTloWgVZ
         IrfjbZiP9q+FR7Dq6K6AgCSpkh4KVcOjwm7NvowWFzQSZyKw7syzJUnJbHWIWanxvRbM
         ZKfg==
X-Forwarded-Encrypted: i=1; AJvYcCWF97iwvA7Q/zWXiLkXYD8wxsxT/RukcGbUer7LsCUDJb32SWVPY7paQ2IwycPOEmriHgyo0m5+Tg8SwRL5bCSbkgU6LX5Ct7gf6rHQUnM4hB89Na4WHPXOJ0FwmlrpYeOys0jhHQ==
X-Gm-Message-State: AOJu0Ywqsbg0YOpRwEXN57fgjUNAK798YhJJk4E12fQEuQ9XQ7Pbj3GA
	JrAxsKqXLQT4d8L4pi7fzY4jDm7Y7nOL0XEkNw3zNkxTrIeHacZu4J1lVcXojt9Tg4aQP1VK4w0
	3Q4H1k2knJl4BCe5oeZqWs/h/emw=
X-Google-Smtp-Source: AGHT+IEkhFr+oNLUXdL2/mGvZxP9hbY6R0/lebxkFAdhKa87FdP1nlrhaX0JPZOMKoM9tIrsuBO4eAQKG60exBKDUT0=
X-Received: by 2002:a05:6214:4a41:b0:690:d000:c819 with SMTP id
 ph1-20020a0562144a4100b00690d000c819mr8068306qvb.60.1710300838384; Tue, 12
 Mar 2024 20:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZcWOh9u3uqZjNFMa@chrisdown.name> <20240229235134.2447718-1-axelrasmussen@google.com>
 <ZeEhvV15IWllPKvM@chrisdown.name> <CAJHvVch2qVUDTJjNeSMqLBx0yoEm4zzb=ZXmABbd_5dWGQTpNg@mail.gmail.com>
 <CALOAHbBupMYBMWEzMK2xdhnqwR1C1+mJSrrZC1L0CKE2BMSC+g@mail.gmail.com>
 <CAJHvVcjhUNx8UP9mao4TdvU6xK7isRzazoSU53a4NCcFiYuM-g@mail.gmail.com>
 <ZfC16BikjhupKnVG@google.com> <ZfC2612ZYwwxpOmR@google.com>
In-Reply-To: <ZfC2612ZYwwxpOmR@google.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 13 Mar 2024 11:33:21 +0800
Message-ID: <CALOAHbAAnGjt2yd8avcSSkMA2MeUWN1-CTkN81GJF+udwE6+DQ@mail.gmail.com>
Subject: Re: MGLRU premature memcg OOM on slow writes
To: Yu Zhao <yuzhao@google.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>, Chris Down <chris@chrisdown.name>, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, kernel-team@fb.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 4:11=E2=80=AFAM Yu Zhao <yuzhao@google.com> wrote:
>
> On Tue, Mar 12, 2024 at 02:07:04PM -0600, Yu Zhao wrote:
> > On Tue, Mar 12, 2024 at 09:44:19AM -0700, Axel Rasmussen wrote:
> > > On Mon, Mar 11, 2024 at 2:11=E2=80=AFAM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > > >
> > > > On Sat, Mar 9, 2024 at 3:19=E2=80=AFAM Axel Rasmussen <axelrasmusse=
n@google.com> wrote:
> > > > >
> > > > > On Thu, Feb 29, 2024 at 4:30=E2=80=AFPM Chris Down <chris@chrisdo=
wn.name> wrote:
> > > > > >
> > > > > > Axel Rasmussen writes:
> > > > > > >A couple of dumb questions. In your test, do you have any of t=
he following
> > > > > > >configured / enabled?
> > > > > > >
> > > > > > >/proc/sys/vm/laptop_mode
> > > > > > >memory.low
> > > > > > >memory.min
> > > > > >
> > > > > > None of these are enabled. The issue is trivially reproducible =
by writing to
> > > > > > any slow device with memory.max enabled, but from the code it l=
ooks like MGLRU
> > > > > > is also susceptible to this on global reclaim (although it's le=
ss likely due to
> > > > > > page diversity).
> > > > > >
> > > > > > >Besides that, it looks like the place non-MGLRU reclaim wakes =
up the
> > > > > > >flushers is in shrink_inactive_list() (which calls wakeup_flus=
her_threads()).
> > > > > > >Since MGLRU calls shrink_folio_list() directly (from evict_fol=
ios()), I agree it
> > > > > > >looks like it simply will not do this.
> > > > > > >
> > > > > > >Yosry pointed out [1], where MGLRU used to call this but stopp=
ed doing that. It
> > > > > > >makes sense to me at least that doing writeback every time we =
age is too
> > > > > > >aggressive, but doing it in evict_folios() makes some sense to=
 me, basically to
> > > > > > >copy the behavior the non-MGLRU path (shrink_inactive_list()) =
has.
> > > > > >
> > > > > > Thanks! We may also need reclaim_throttle(), depending on how y=
ou implement it.
> > > > > > Current non-MGLRU behaviour on slow storage is also highly susp=
ect in terms of
> > > > > > (lack of) throttling after moving away from VMSCAN_THROTTLE_WRI=
TEBACK, but one
> > > > > > thing at a time :-)
> > > > >
> > > > >
> > > > > Hmm, so I have a patch which I think will help with this situatio=
n,
> > > > > but I'm having some trouble reproducing the problem on 6.8-rc7 (s=
o
> > > > > then I can verify the patch fixes it).
> > > >
> > > > We encountered the same premature OOM issue caused by numerous dirt=
y pages.
> > > > The issue disappears after we revert the commit 14aa8b2d5c2e
> > > > "mm/mglru: don't sync disk for each aging cycle"
> > > >
> > > > To aid in replicating the issue, we've developed a straightforward
> > > > script, which consistently reproduces it, even on the latest kernel=
.
> > > > You can find the script provided below:
> > > >
> > > > ```
> > > > #!/bin/bash
> > > >
> > > > MEMCG=3D"/sys/fs/cgroup/memory/mglru"
> > > > ENABLE=3D$1
> > > >
> > > > # Avoid waking up the flusher
> > > > sysctl -w vm.dirty_background_bytes=3D$((1024 * 1024 * 1024 *4))
> > > > sysctl -w vm.dirty_bytes=3D$((1024 * 1024 * 1024 *4))
> > > >
> > > > if [ ! -d ${MEMCG} ]; then
> > > >         mkdir -p ${MEMCG}
> > > > fi
> > > >
> > > > echo $$ > ${MEMCG}/cgroup.procs
> > > > echo 1g > ${MEMCG}/memory.limit_in_bytes
> > > >
> > > > if [ $ENABLE -eq 0 ]; then
> > > >         echo 0 > /sys/kernel/mm/lru_gen/enabled
> > > > else
> > > >         echo 0x7 > /sys/kernel/mm/lru_gen/enabled
> > > > fi
> > > >
> > > > dd if=3D/dev/zero of=3D/data0/mglru.test bs=3D1M count=3D1023
> > > > rm -rf /data0/mglru.test
> > > > ```
> > > >
> > > > This issue disappears as well after we disable the mglru.
> > > >
> > > > We hope this script proves helpful in identifying and addressing th=
e
> > > > root cause. We eagerly await your insights and proposed fixes.
> > >
> > > Thanks Yafang, I was able to reproduce the issue using this script.
> > >
> > > Perhaps interestingly, I was not able to reproduce it with cgroupv2
> > > memcgs. I know writeback semantics are quite a bit different there, s=
o
> > > perhaps that explains why.
> > >
> > > Unfortunately, it also reproduces even with the commit I had in mind
> > > (basically stealing the "if (all isolated pages are unqueued dirty) {
> > > wakeup_flusher_threads(); reclaim_throttle(); }" from
> > > shrink_inactive_list, and adding it to MGLRU's evict_folios()). So
> > > I'll need to spend some more time on this; I'm planning to send
> > > something out for testing next week.
> >
> > Hi Chris,
> >
> > My apologies for not getting back to you sooner.
> >
> > And thanks everyone for all the input!
> >
> > My take is that Chris' premature OOM kills were NOT really due to
> > the flusher not waking up or missing throttling.
> >
> > Yes, these two are among the differences between the active/inactive
> > LRU and MGLRU, but their roles, IMO, are not as important as the LRU
> > positions of dirty pages. The active/inactive LRU moves dirty pages
> > all the way to the end of the line (reclaim happens at the front)
> > whereas MGLRU moves them into the middle, during direct reclaim. The
> > rationale for MGLRU was that this way those dirty pages would still
> > be counted as "inactive" (or cold).
> >
> > This theory can be quickly verified by comparing how much
> > nr_vmscan_immediate_reclaim grows, i.e.,
> >
> >   Before the copy
> >     grep nr_vmscan_immediate_reclaim /proc/vmstat
> >   And then after the copy
> >     grep nr_vmscan_immediate_reclaim /proc/vmstat
> >
> > The growth should be trivial for MGLRU and nontrivial for the
> > active/inactive LRU.
> >
> > If this is indeed the case, I'd appreciate very much if anyone could
> > try the following (I'll try it myself too later next week).
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 4255619a1a31..020f5d98b9a1 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -4273,10 +4273,13 @@ static bool sort_folio(struct lruvec *lruvec, s=
truct folio *folio, struct scan_c
> >       }
> >
> >       /* waiting for writeback */
> > -     if (folio_test_locked(folio) || folio_test_writeback(folio) ||
> > -         (type =3D=3D LRU_GEN_FILE && folio_test_dirty(folio))) {
> > -             gen =3D folio_inc_gen(lruvec, folio, true);
> > -             list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
> > +     if (folio_test_writeback(folio) || (type =3D=3D LRU_GEN_FILE && f=
olio_test_dirty(folio))) {
> > +             DEFINE_MAX_SEQ(lruvec);
> > +             int old_gen, new_gen =3D lru_gen_from_seq(max_seq);
> > +
> > +             old_gen =3D folio_update_gen(folio, new_gen);
> > +             lru_gen_update_size(lruvec, folio, old_gen, new_gen);
> > +             list_move(&folio->lru, &lrugen->folios[new_gen][type][zon=
e]);
>
> Sorry missing one line here:
>
>  +              folio_set_reclaim(folio);
>
> >               return true;
> >       }

Hi Yu,

I have validated it using the script provided for Axel, but
unfortunately, it still triggers an OOM error with your patch applied.
Here are the results with nr_vmscan_immediate_reclaim:

- non-MGLRU
  $ grep nr_vmscan_immediate_reclaim /proc/vmstat
  nr_vmscan_immediate_reclaim 47411776

  $ ./test.sh 0
  1023+0 records in
  1023+0 records out
  1072693248 bytes (1.1 GB, 1023 MiB) copied, 0.538058 s, 2.0 GB/s

  $ grep nr_vmscan_immediate_reclaim /proc/vmstat
  nr_vmscan_immediate_reclaim 47412544

- MGLRU
  $ grep nr_vmscan_immediate_reclaim /proc/vmstat
  nr_vmscan_immediate_reclaim 47412544

  $ ./test.sh 1
  Killed

  $ grep nr_vmscan_immediate_reclaim /proc/vmstat
  nr_vmscan_immediate_reclaim 115455600


The detailed OOM info as follows,

[Wed Mar 13 11:16:48 2024] dd invoked oom-killer:
gfp_mask=3D0x101c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_HARDWALL|__GFP_MOVABLE|__G=
FP_WRITE),
order=3D3, oom_score_adj=3D0
[Wed Mar 13 11:16:48 2024] CPU: 12 PID: 6911 Comm: dd Not tainted 6.8.0-rc6=
+ #24
[Wed Mar 13 11:16:48 2024] Hardware name: Tencent Cloud CVM, BIOS
seabios-1.9.1-qemu-project.org 04/01/2014
[Wed Mar 13 11:16:48 2024] Call Trace:
[Wed Mar 13 11:16:48 2024]  <TASK>
[Wed Mar 13 11:16:48 2024]  dump_stack_lvl+0x6e/0x90
[Wed Mar 13 11:16:48 2024]  dump_stack+0x10/0x20
[Wed Mar 13 11:16:48 2024]  dump_header+0x47/0x2d0
[Wed Mar 13 11:16:48 2024]  oom_kill_process+0x101/0x2e0
[Wed Mar 13 11:16:48 2024]  out_of_memory+0xfc/0x430
[Wed Mar 13 11:16:48 2024]  mem_cgroup_out_of_memory+0x13d/0x160
[Wed Mar 13 11:16:48 2024]  try_charge_memcg+0x7be/0x850
[Wed Mar 13 11:16:48 2024]  ? get_mem_cgroup_from_mm+0x5e/0x420
[Wed Mar 13 11:16:48 2024]  ? rcu_read_unlock+0x25/0x70
[Wed Mar 13 11:16:48 2024]  __mem_cgroup_charge+0x49/0x90
[Wed Mar 13 11:16:48 2024]  __filemap_add_folio+0x277/0x450
[Wed Mar 13 11:16:48 2024]  ? __pfx_workingset_update_node+0x10/0x10
[Wed Mar 13 11:16:48 2024]  filemap_add_folio+0x3c/0xa0
[Wed Mar 13 11:16:48 2024]  __filemap_get_folio+0x13d/0x2f0
[Wed Mar 13 11:16:48 2024]  iomap_get_folio+0x4c/0x60
[Wed Mar 13 11:16:48 2024]  iomap_write_begin+0x1bb/0x2e0
[Wed Mar 13 11:16:48 2024]  iomap_write_iter+0xff/0x290
[Wed Mar 13 11:16:48 2024]  iomap_file_buffered_write+0x91/0xf0
[Wed Mar 13 11:16:48 2024]  xfs_file_buffered_write+0x9f/0x2d0 [xfs]
[Wed Mar 13 11:16:48 2024]  ? vfs_write+0x261/0x530
[Wed Mar 13 11:16:48 2024]  ? debug_smp_processor_id+0x17/0x20
[Wed Mar 13 11:16:48 2024]  xfs_file_write_iter+0xe9/0x120 [xfs]
[Wed Mar 13 11:16:48 2024]  vfs_write+0x37d/0x530
[Wed Mar 13 11:16:48 2024]  ksys_write+0x6d/0xf0
[Wed Mar 13 11:16:48 2024]  __x64_sys_write+0x19/0x20
[Wed Mar 13 11:16:48 2024]  do_syscall_64+0x79/0x1a0
[Wed Mar 13 11:16:48 2024]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[Wed Mar 13 11:16:48 2024] RIP: 0033:0x7f63ea33e927
[Wed Mar 13 11:16:48 2024] Code: 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff
ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10
b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54
24 18 48 89 74 24
[Wed Mar 13 11:16:48 2024] RSP: 002b:00007ffc0e874768 EFLAGS: 00000246
ORIG_RAX: 0000000000000001
[Wed Mar 13 11:16:48 2024] RAX: ffffffffffffffda RBX: 0000000000100000
RCX: 00007f63ea33e927
[Wed Mar 13 11:16:48 2024] RDX: 0000000000100000 RSI: 00007f63dcafe000
RDI: 0000000000000001
[Wed Mar 13 11:16:48 2024] RBP: 00007f63dcafe000 R08: 00007f63dcafe000
R09: 0000000000000000
[Wed Mar 13 11:16:48 2024] R10: 0000000000000022 R11: 0000000000000246
R12: 0000000000000000
[Wed Mar 13 11:16:48 2024] R13: 0000000000000000 R14: 0000000000000000
R15: 00007f63dcafe000
[Wed Mar 13 11:16:48 2024]  </TASK>
[Wed Mar 13 11:16:48 2024] memory: usage 1048556kB, limit 1048576kB, failcn=
t 153
[Wed Mar 13 11:16:48 2024] memory+swap: usage 1048556kB, limit
9007199254740988kB, failcnt 0
[Wed Mar 13 11:16:48 2024] kmem: usage 200kB, limit
9007199254740988kB, failcnt 0
[Wed Mar 13 11:16:48 2024] Memory cgroup stats for /mglru:
[Wed Mar 13 11:16:48 2024] cache 1072365568
[Wed Mar 13 11:16:48 2024] rss 1150976
[Wed Mar 13 11:16:48 2024] rss_huge 0
[Wed Mar 13 11:16:48 2024] shmem 0
[Wed Mar 13 11:16:48 2024] mapped_file 0
[Wed Mar 13 11:16:48 2024] dirty 1072365568
[Wed Mar 13 11:16:48 2024] writeback 0
[Wed Mar 13 11:16:48 2024] workingset_refault_anon 0
[Wed Mar 13 11:16:48 2024] workingset_refault_file 0
[Wed Mar 13 11:16:48 2024] swap 0
[Wed Mar 13 11:16:48 2024] swapcached 0
[Wed Mar 13 11:16:48 2024] pgpgin 2783
[Wed Mar 13 11:16:48 2024] pgpgout 1444
[Wed Mar 13 11:16:48 2024] pgfault 885
[Wed Mar 13 11:16:48 2024] pgmajfault 0
[Wed Mar 13 11:16:48 2024] inactive_anon 1146880
[Wed Mar 13 11:16:48 2024] active_anon 4096
[Wed Mar 13 11:16:48 2024] inactive_file 802357248
[Wed Mar 13 11:16:48 2024] active_file 270008320
[Wed Mar 13 11:16:48 2024] unevictable 0
[Wed Mar 13 11:16:48 2024] hierarchical_memory_limit 1073741824
[Wed Mar 13 11:16:48 2024] hierarchical_memsw_limit 9223372036854771712
[Wed Mar 13 11:16:48 2024] total_cache 1072365568
[Wed Mar 13 11:16:48 2024] total_rss 1150976
[Wed Mar 13 11:16:48 2024] total_rss_huge 0
[Wed Mar 13 11:16:48 2024] total_shmem 0
[Wed Mar 13 11:16:48 2024] total_mapped_file 0
[Wed Mar 13 11:16:48 2024] total_dirty 1072365568
[Wed Mar 13 11:16:48 2024] total_writeback 0
[Wed Mar 13 11:16:48 2024] total_workingset_refault_anon 0
[Wed Mar 13 11:16:48 2024] total_workingset_refault_file 0
[Wed Mar 13 11:16:48 2024] total_swap 0
[Wed Mar 13 11:16:48 2024] total_swapcached 0
[Wed Mar 13 11:16:48 2024] total_pgpgin 2783
[Wed Mar 13 11:16:48 2024] total_pgpgout 1444
[Wed Mar 13 11:16:48 2024] total_pgfault 885
[Wed Mar 13 11:16:48 2024] total_pgmajfault 0
[Wed Mar 13 11:16:48 2024] total_inactive_anon 1146880
[Wed Mar 13 11:16:48 2024] total_active_anon 4096
[Wed Mar 13 11:16:48 2024] total_inactive_file 802357248
[Wed Mar 13 11:16:48 2024] total_active_file 270008320
[Wed Mar 13 11:16:48 2024] total_unevictable 0
[Wed Mar 13 11:16:48 2024] Tasks state (memory values in pages):
[Wed Mar 13 11:16:48 2024] [  pid  ]   uid  tgid total_vm      rss
rss_anon rss_file rss_shmem pgtables_bytes swapents oom_score_adj name
[Wed Mar 13 11:16:48 2024] [   6911]     0  6911    55506      640
 256      384         0    73728        0             0 dd
[Wed Mar 13 11:16:48 2024]
oom-kill:constraint=3DCONSTRAINT_MEMCG,nodemask=3D(null),cpuset=3D/,mems_al=
lowed=3D0-1,oom_memcg=3D/mglru,task_memcg=3D/mglru,task=3Ddd,pid=3D6911,uid=
=3D0

The key information extracted from the OOM info is as follows:

[Wed Mar 13 11:16:48 2024] cache 1072365568
[Wed Mar 13 11:16:48 2024] dirty 1072365568

This information reveals that all file pages are dirty pages.

As of now, it appears that the most effective solution to address this
issue is to revert the commit 14aa8b2d5c2e. Regarding this commit
14aa8b2d5c2e,  its original intention was to eliminate potential SSD
wearout, although there's no concrete data available on how it might
impact SSD longevity. If the concern about SSD wearout is purely
theoretical, it might be reasonable to consider reverting this commit.

