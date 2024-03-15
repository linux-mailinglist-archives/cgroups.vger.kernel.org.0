Return-Path: <cgroups+bounces-2058-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558E787C79D
	for <lists+cgroups@lfdr.de>; Fri, 15 Mar 2024 03:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47B261C20D69
	for <lists+cgroups@lfdr.de>; Fri, 15 Mar 2024 02:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23F96FA9;
	Fri, 15 Mar 2024 02:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxQ4JT+D"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103398BF1;
	Fri, 15 Mar 2024 02:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710470352; cv=none; b=DdzrrOYGHOFdKknVQ12Zqdnp13kJVjNIjDXL+Qx2jd1NCwmDi39b/kAvM/QBrChPVLEzcrrLAdCasEuvYws+/1n+FcAoR8e2/kjQMAl1AAVOMoGJ9m0Zq8PwzmtJxRuYjSWGit4sTyC+uAbVLZit1CJXsm1VMBRJxPqkbxozWOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710470352; c=relaxed/simple;
	bh=gU7qAVxlALDZhqxbuah+5+YR3GW002r1n4RhhfCb2w0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8+9rmmZ8P4wf5Vs0EyXP+LCifRY5o+JYc94RUZj7PfHIeIHPaZ2ZygFHKwgP2q5czrY4UbdlVtYnEEU7q7VBmaRDsUk9iLpHHZpL32y/kZ0w+q9IgJQzeaHGFu4QgC+BUah90F2aortgEUb7lRYpMp8CLr2hS/G7YRP3SC5AfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxQ4JT+D; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-690cbf99143so9223666d6.3;
        Thu, 14 Mar 2024 19:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710470348; x=1711075148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YQIDD5k9cvnuXBRBnQeWg0FDh8xhcSKqwSjMhtt24s=;
        b=CxQ4JT+Dtl3PplL2BAoeDi0Bg4euN171sjul3pPTH1A3RLMNXyOHGt6r2WF9YIiBFt
         HEaRfPnWgu8RpCMLlRn3tR0Vj4zYvEWeX/GftS2JQm1JJPuoEdoKmFo1/ESOnnUzX4lx
         NqbhBC/sBntUCGatM7cfsfIaYx96obVCPfi38etw4s/Ty/dikfEoeSEQkAnsnysect3T
         2BZNltkvbRh15tZcAO2SEmNhGOlSW5Z7xvUQvMSaIs5fMIbvPHFXz6TjDlrAW3jDO2B4
         KQ8c/pWpqpayqAN7twG+2Ce2CjjfAmqR3mQRyqt3R+rMkySegedfo8u09a0yGCjvt4hc
         6EvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710470348; x=1711075148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YQIDD5k9cvnuXBRBnQeWg0FDh8xhcSKqwSjMhtt24s=;
        b=XOdSUYSFQVkuhS+Niuu9aQ4qr+SVUOH8aaptEWAaUr0U1k/qVC+2ENfHsz1Xb7LEZS
         s4hL7ReIfTMcJV6oL1civ0JNB9S0c9agxQxJVdJ0ep59ZUtVNfg8NshTZlMKQCfGE/Eg
         /Y47tRzJoMo2UZjM4VuKFQ5yA12s8fre8yxB7QTmpgwSgqJSR0bO3uGgPStHTkOXuEiw
         LkkV53mctohx6YGQAv8ipvwn2Nwv7tcNtfHyPmG46w8xOPVYO3Lou4hygDdjFnBi4Mo2
         8s7+8PagUPy3l83RXXL6Ab3iVd3YJ7IPkB4hHeTVLbG2yHY7fwYxVRwQUgF7BtS4N60z
         qJFw==
X-Forwarded-Encrypted: i=1; AJvYcCU1G/S5y/rHJxs90ydDcUHjBBoR4j+IMPDqT4NRLtQR5QP/BwiXp370MWWZe4VuGgPrPWd8RuhDf7Gcnik85S1B/P0tcKQ+NTqqRJ308L3yOhbk4/per2So8h4fVF0IcwNnssLaXQ==
X-Gm-Message-State: AOJu0YwsLU0UCnpUSq5A4MIJIIYrDCp0vTESdUKHES/5zVTBr+xtNnXe
	9W+mJnLZK27hZX7B6rOru8Cyn/n1Rag0bujU7xyPcfziU39RVoTskCAYukpVrzwaHVtoC240hi6
	a67kDxuk1em+8IQiU7yUsXiH9Mpg=
X-Google-Smtp-Source: AGHT+IHW2sB6Wtm93WZpORi51K6C5eYrj3eG1LLqDI2/3wnTV+AyzkguSta+uO/p/U8tYohRrm30LyOWGRhvzGbKPqM=
X-Received: by 2002:a0c:cd12:0:b0:690:b258:a4de with SMTP id
 b18-20020a0ccd12000000b00690b258a4demr3795415qvm.10.1710470347808; Thu, 14
 Mar 2024 19:39:07 -0700 (PDT)
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
 <CALOAHbAAnGjt2yd8avcSSkMA2MeUWN1-CTkN81GJF+udwE6+DQ@mail.gmail.com> <ZfN41Bm2UA7qDPEA@google.com>
In-Reply-To: <ZfN41Bm2UA7qDPEA@google.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 15 Mar 2024 10:38:31 +0800
Message-ID: <CALOAHbDn0Dbxfhd72d=7-Z_9PjpP_1pXSm3r9daG_XC_f7vFDQ@mail.gmail.com>
Subject: Re: MGLRU premature memcg OOM on slow writes
To: Yu Zhao <yuzhao@google.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>, Chris Down <chris@chrisdown.name>, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, kernel-team@fb.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 6:23=E2=80=AFAM Yu Zhao <yuzhao@google.com> wrote:
>
> On Wed, Mar 13, 2024 at 11:33:21AM +0800, Yafang Shao wrote:
> > On Wed, Mar 13, 2024 at 4:11=E2=80=AFAM Yu Zhao <yuzhao@google.com> wro=
te:
> > >
> > > On Tue, Mar 12, 2024 at 02:07:04PM -0600, Yu Zhao wrote:
> > > > On Tue, Mar 12, 2024 at 09:44:19AM -0700, Axel Rasmussen wrote:
> > > > > On Mon, Mar 11, 2024 at 2:11=E2=80=AFAM Yafang Shao <laoar.shao@g=
mail.com> wrote:
> > > > > >
> > > > > > On Sat, Mar 9, 2024 at 3:19=E2=80=AFAM Axel Rasmussen <axelrasm=
ussen@google.com> wrote:
> > > > > > >
> > > > > > > On Thu, Feb 29, 2024 at 4:30=E2=80=AFPM Chris Down <chris@chr=
isdown.name> wrote:
> > > > > > > >
> > > > > > > > Axel Rasmussen writes:
> > > > > > > > >A couple of dumb questions. In your test, do you have any =
of the following
> > > > > > > > >configured / enabled?
> > > > > > > > >
> > > > > > > > >/proc/sys/vm/laptop_mode
> > > > > > > > >memory.low
> > > > > > > > >memory.min
> > > > > > > >
> > > > > > > > None of these are enabled. The issue is trivially reproduci=
ble by writing to
> > > > > > > > any slow device with memory.max enabled, but from the code =
it looks like MGLRU
> > > > > > > > is also susceptible to this on global reclaim (although it'=
s less likely due to
> > > > > > > > page diversity).
> > > > > > > >
> > > > > > > > >Besides that, it looks like the place non-MGLRU reclaim wa=
kes up the
> > > > > > > > >flushers is in shrink_inactive_list() (which calls wakeup_=
flusher_threads()).
> > > > > > > > >Since MGLRU calls shrink_folio_list() directly (from evict=
_folios()), I agree it
> > > > > > > > >looks like it simply will not do this.
> > > > > > > > >
> > > > > > > > >Yosry pointed out [1], where MGLRU used to call this but s=
topped doing that. It
> > > > > > > > >makes sense to me at least that doing writeback every time=
 we age is too
> > > > > > > > >aggressive, but doing it in evict_folios() makes some sens=
e to me, basically to
> > > > > > > > >copy the behavior the non-MGLRU path (shrink_inactive_list=
()) has.
> > > > > > > >
> > > > > > > > Thanks! We may also need reclaim_throttle(), depending on h=
ow you implement it.
> > > > > > > > Current non-MGLRU behaviour on slow storage is also highly =
suspect in terms of
> > > > > > > > (lack of) throttling after moving away from VMSCAN_THROTTLE=
_WRITEBACK, but one
> > > > > > > > thing at a time :-)
> > > > > > >
> > > > > > >
> > > > > > > Hmm, so I have a patch which I think will help with this situ=
ation,
> > > > > > > but I'm having some trouble reproducing the problem on 6.8-rc=
7 (so
> > > > > > > then I can verify the patch fixes it).
> > > > > >
> > > > > > We encountered the same premature OOM issue caused by numerous =
dirty pages.
> > > > > > The issue disappears after we revert the commit 14aa8b2d5c2e
> > > > > > "mm/mglru: don't sync disk for each aging cycle"
> > > > > >
> > > > > > To aid in replicating the issue, we've developed a straightforw=
ard
> > > > > > script, which consistently reproduces it, even on the latest ke=
rnel.
> > > > > > You can find the script provided below:
> > > > > >
> > > > > > ```
> > > > > > #!/bin/bash
> > > > > >
> > > > > > MEMCG=3D"/sys/fs/cgroup/memory/mglru"
> > > > > > ENABLE=3D$1
> > > > > >
> > > > > > # Avoid waking up the flusher
> > > > > > sysctl -w vm.dirty_background_bytes=3D$((1024 * 1024 * 1024 *4)=
)
> > > > > > sysctl -w vm.dirty_bytes=3D$((1024 * 1024 * 1024 *4))
> > > > > >
> > > > > > if [ ! -d ${MEMCG} ]; then
> > > > > >         mkdir -p ${MEMCG}
> > > > > > fi
> > > > > >
> > > > > > echo $$ > ${MEMCG}/cgroup.procs
> > > > > > echo 1g > ${MEMCG}/memory.limit_in_bytes
> > > > > >
> > > > > > if [ $ENABLE -eq 0 ]; then
> > > > > >         echo 0 > /sys/kernel/mm/lru_gen/enabled
> > > > > > else
> > > > > >         echo 0x7 > /sys/kernel/mm/lru_gen/enabled
> > > > > > fi
> > > > > >
> > > > > > dd if=3D/dev/zero of=3D/data0/mglru.test bs=3D1M count=3D1023
> > > > > > rm -rf /data0/mglru.test
> > > > > > ```
> > > > > >
> > > > > > This issue disappears as well after we disable the mglru.
> > > > > >
> > > > > > We hope this script proves helpful in identifying and addressin=
g the
> > > > > > root cause. We eagerly await your insights and proposed fixes.
> > > > >
> > > > > Thanks Yafang, I was able to reproduce the issue using this scrip=
t.
> > > > >
> > > > > Perhaps interestingly, I was not able to reproduce it with cgroup=
v2
> > > > > memcgs. I know writeback semantics are quite a bit different ther=
e, so
> > > > > perhaps that explains why.
> > > > >
> > > > > Unfortunately, it also reproduces even with the commit I had in m=
ind
> > > > > (basically stealing the "if (all isolated pages are unqueued dirt=
y) {
> > > > > wakeup_flusher_threads(); reclaim_throttle(); }" from
> > > > > shrink_inactive_list, and adding it to MGLRU's evict_folios()). S=
o
> > > > > I'll need to spend some more time on this; I'm planning to send
> > > > > something out for testing next week.
> > > >
> > > > Hi Chris,
> > > >
> > > > My apologies for not getting back to you sooner.
> > > >
> > > > And thanks everyone for all the input!
> > > >
> > > > My take is that Chris' premature OOM kills were NOT really due to
> > > > the flusher not waking up or missing throttling.
> > > >
> > > > Yes, these two are among the differences between the active/inactiv=
e
> > > > LRU and MGLRU, but their roles, IMO, are not as important as the LR=
U
> > > > positions of dirty pages. The active/inactive LRU moves dirty pages
> > > > all the way to the end of the line (reclaim happens at the front)
> > > > whereas MGLRU moves them into the middle, during direct reclaim. Th=
e
> > > > rationale for MGLRU was that this way those dirty pages would still
> > > > be counted as "inactive" (or cold).
> > > >
> > > > This theory can be quickly verified by comparing how much
> > > > nr_vmscan_immediate_reclaim grows, i.e.,
> > > >
> > > >   Before the copy
> > > >     grep nr_vmscan_immediate_reclaim /proc/vmstat
> > > >   And then after the copy
> > > >     grep nr_vmscan_immediate_reclaim /proc/vmstat
> > > >
> > > > The growth should be trivial for MGLRU and nontrivial for the
> > > > active/inactive LRU.
> > > >
> > > > If this is indeed the case, I'd appreciate very much if anyone coul=
d
> > > > try the following (I'll try it myself too later next week).
> > > >
> > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > > index 4255619a1a31..020f5d98b9a1 100644
> > > > --- a/mm/vmscan.c
> > > > +++ b/mm/vmscan.c
> > > > @@ -4273,10 +4273,13 @@ static bool sort_folio(struct lruvec *lruve=
c, struct folio *folio, struct scan_c
> > > >       }
> > > >
> > > >       /* waiting for writeback */
> > > > -     if (folio_test_locked(folio) || folio_test_writeback(folio) |=
|
> > > > -         (type =3D=3D LRU_GEN_FILE && folio_test_dirty(folio))) {
> > > > -             gen =3D folio_inc_gen(lruvec, folio, true);
> > > > -             list_move(&folio->lru, &lrugen->folios[gen][type][zon=
e]);
> > > > +     if (folio_test_writeback(folio) || (type =3D=3D LRU_GEN_FILE =
&& folio_test_dirty(folio))) {
> > > > +             DEFINE_MAX_SEQ(lruvec);
> > > > +             int old_gen, new_gen =3D lru_gen_from_seq(max_seq);
> > > > +
> > > > +             old_gen =3D folio_update_gen(folio, new_gen);
> > > > +             lru_gen_update_size(lruvec, folio, old_gen, new_gen);
> > > > +             list_move(&folio->lru, &lrugen->folios[new_gen][type]=
[zone]);
> > >
> > > Sorry missing one line here:
> > >
> > >  +              folio_set_reclaim(folio);
> > >
> > > >               return true;
> > > >       }
> >
> > Hi Yu,
> >
> > I have validated it using the script provided for Axel, but
> > unfortunately, it still triggers an OOM error with your patch applied.
> > Here are the results with nr_vmscan_immediate_reclaim:
>
> Thanks for debunking it!
>
> > - non-MGLRU
> >   $ grep nr_vmscan_immediate_reclaim /proc/vmstat
> >   nr_vmscan_immediate_reclaim 47411776
> >
> >   $ ./test.sh 0
> >   1023+0 records in
> >   1023+0 records out
> >   1072693248 bytes (1.1 GB, 1023 MiB) copied, 0.538058 s, 2.0 GB/s
> >
> >   $ grep nr_vmscan_immediate_reclaim /proc/vmstat
> >   nr_vmscan_immediate_reclaim 47412544
> >
> > - MGLRU
> >   $ grep nr_vmscan_immediate_reclaim /proc/vmstat
> >   nr_vmscan_immediate_reclaim 47412544
> >
> >   $ ./test.sh 1
> >   Killed
> >
> >   $ grep nr_vmscan_immediate_reclaim /proc/vmstat
> >   nr_vmscan_immediate_reclaim 115455600
>
> The delta is ~260GB, I'm still thinking how that could happen -- is this =
reliably reproducible?

Yes, it is reliably reproducible on cgroup1 with the script provided as fol=
lows:

    $ ./test.sh 1

>
> > The detailed OOM info as follows,
> >
> > [Wed Mar 13 11:16:48 2024] dd invoked oom-killer:
> > gfp_mask=3D0x101c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_HARDWALL|__GFP_MOVABLE=
|__GFP_WRITE),
> > order=3D3, oom_score_adj=3D0
> > [Wed Mar 13 11:16:48 2024] CPU: 12 PID: 6911 Comm: dd Not tainted 6.8.0=
-rc6+ #24
> > [Wed Mar 13 11:16:48 2024] Hardware name: Tencent Cloud CVM, BIOS
> > seabios-1.9.1-qemu-project.org 04/01/2014
> > [Wed Mar 13 11:16:48 2024] Call Trace:
> > [Wed Mar 13 11:16:48 2024]  <TASK>
> > [Wed Mar 13 11:16:48 2024]  dump_stack_lvl+0x6e/0x90
> > [Wed Mar 13 11:16:48 2024]  dump_stack+0x10/0x20
> > [Wed Mar 13 11:16:48 2024]  dump_header+0x47/0x2d0
> > [Wed Mar 13 11:16:48 2024]  oom_kill_process+0x101/0x2e0
> > [Wed Mar 13 11:16:48 2024]  out_of_memory+0xfc/0x430
> > [Wed Mar 13 11:16:48 2024]  mem_cgroup_out_of_memory+0x13d/0x160
> > [Wed Mar 13 11:16:48 2024]  try_charge_memcg+0x7be/0x850
> > [Wed Mar 13 11:16:48 2024]  ? get_mem_cgroup_from_mm+0x5e/0x420
> > [Wed Mar 13 11:16:48 2024]  ? rcu_read_unlock+0x25/0x70
> > [Wed Mar 13 11:16:48 2024]  __mem_cgroup_charge+0x49/0x90
> > [Wed Mar 13 11:16:48 2024]  __filemap_add_folio+0x277/0x450
> > [Wed Mar 13 11:16:48 2024]  ? __pfx_workingset_update_node+0x10/0x10
> > [Wed Mar 13 11:16:48 2024]  filemap_add_folio+0x3c/0xa0
> > [Wed Mar 13 11:16:48 2024]  __filemap_get_folio+0x13d/0x2f0
> > [Wed Mar 13 11:16:48 2024]  iomap_get_folio+0x4c/0x60
> > [Wed Mar 13 11:16:48 2024]  iomap_write_begin+0x1bb/0x2e0
> > [Wed Mar 13 11:16:48 2024]  iomap_write_iter+0xff/0x290
> > [Wed Mar 13 11:16:48 2024]  iomap_file_buffered_write+0x91/0xf0
> > [Wed Mar 13 11:16:48 2024]  xfs_file_buffered_write+0x9f/0x2d0 [xfs]
> > [Wed Mar 13 11:16:48 2024]  ? vfs_write+0x261/0x530
> > [Wed Mar 13 11:16:48 2024]  ? debug_smp_processor_id+0x17/0x20
> > [Wed Mar 13 11:16:48 2024]  xfs_file_write_iter+0xe9/0x120 [xfs]
> > [Wed Mar 13 11:16:48 2024]  vfs_write+0x37d/0x530
> > [Wed Mar 13 11:16:48 2024]  ksys_write+0x6d/0xf0
> > [Wed Mar 13 11:16:48 2024]  __x64_sys_write+0x19/0x20
> > [Wed Mar 13 11:16:48 2024]  do_syscall_64+0x79/0x1a0
> > [Wed Mar 13 11:16:48 2024]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> > [Wed Mar 13 11:16:48 2024] RIP: 0033:0x7f63ea33e927
> > [Wed Mar 13 11:16:48 2024] Code: 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff
> > ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10
> > b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54
> > 24 18 48 89 74 24
> > [Wed Mar 13 11:16:48 2024] RSP: 002b:00007ffc0e874768 EFLAGS: 00000246
> > ORIG_RAX: 0000000000000001
> > [Wed Mar 13 11:16:48 2024] RAX: ffffffffffffffda RBX: 0000000000100000
> > RCX: 00007f63ea33e927
> > [Wed Mar 13 11:16:48 2024] RDX: 0000000000100000 RSI: 00007f63dcafe000
> > RDI: 0000000000000001
> > [Wed Mar 13 11:16:48 2024] RBP: 00007f63dcafe000 R08: 00007f63dcafe000
> > R09: 0000000000000000
> > [Wed Mar 13 11:16:48 2024] R10: 0000000000000022 R11: 0000000000000246
> > R12: 0000000000000000
> > [Wed Mar 13 11:16:48 2024] R13: 0000000000000000 R14: 0000000000000000
> > R15: 00007f63dcafe000
> > [Wed Mar 13 11:16:48 2024]  </TASK>
> > [Wed Mar 13 11:16:48 2024] memory: usage 1048556kB, limit 1048576kB, fa=
ilcnt 153
> > [Wed Mar 13 11:16:48 2024] memory+swap: usage 1048556kB, limit
>
> I see you were actually on cgroup v1 -- this might be a different
> problem than Chris' since he was on v2.

Right, we are still using cgroup1. They might not be the same issue.

>
> For v1, the throttling is done by commit 81a70c21d9
> ("mm/cgroup/reclaim: fix dirty pages throttling on cgroup v1").
> IOW, the active/inactive LRU throttles in both v1 and v2 (done
> in different ways) whereas MGLRU doesn't in either case.
>
> > 9007199254740988kB, failcnt 0
> > [Wed Mar 13 11:16:48 2024] kmem: usage 200kB, limit
> > 9007199254740988kB, failcnt 0
> > [Wed Mar 13 11:16:48 2024] Memory cgroup stats for /mglru:
> > [Wed Mar 13 11:16:48 2024] cache 1072365568
> > [Wed Mar 13 11:16:48 2024] rss 1150976
> > [Wed Mar 13 11:16:48 2024] rss_huge 0
> > [Wed Mar 13 11:16:48 2024] shmem 0
> > [Wed Mar 13 11:16:48 2024] mapped_file 0
> > [Wed Mar 13 11:16:48 2024] dirty 1072365568
> > [Wed Mar 13 11:16:48 2024] writeback 0
> > [Wed Mar 13 11:16:48 2024] workingset_refault_anon 0
> > [Wed Mar 13 11:16:48 2024] workingset_refault_file 0
> > [Wed Mar 13 11:16:48 2024] swap 0
> > [Wed Mar 13 11:16:48 2024] swapcached 0
> > [Wed Mar 13 11:16:48 2024] pgpgin 2783
> > [Wed Mar 13 11:16:48 2024] pgpgout 1444
> > [Wed Mar 13 11:16:48 2024] pgfault 885
> > [Wed Mar 13 11:16:48 2024] pgmajfault 0
> > [Wed Mar 13 11:16:48 2024] inactive_anon 1146880
> > [Wed Mar 13 11:16:48 2024] active_anon 4096
> > [Wed Mar 13 11:16:48 2024] inactive_file 802357248
> > [Wed Mar 13 11:16:48 2024] active_file 270008320
> > [Wed Mar 13 11:16:48 2024] unevictable 0
> > [Wed Mar 13 11:16:48 2024] hierarchical_memory_limit 1073741824
> > [Wed Mar 13 11:16:48 2024] hierarchical_memsw_limit 9223372036854771712
> > [Wed Mar 13 11:16:48 2024] total_cache 1072365568
> > [Wed Mar 13 11:16:48 2024] total_rss 1150976
> > [Wed Mar 13 11:16:48 2024] total_rss_huge 0
> > [Wed Mar 13 11:16:48 2024] total_shmem 0
> > [Wed Mar 13 11:16:48 2024] total_mapped_file 0
> > [Wed Mar 13 11:16:48 2024] total_dirty 1072365568
> > [Wed Mar 13 11:16:48 2024] total_writeback 0
> > [Wed Mar 13 11:16:48 2024] total_workingset_refault_anon 0
> > [Wed Mar 13 11:16:48 2024] total_workingset_refault_file 0
> > [Wed Mar 13 11:16:48 2024] total_swap 0
> > [Wed Mar 13 11:16:48 2024] total_swapcached 0
> > [Wed Mar 13 11:16:48 2024] total_pgpgin 2783
> > [Wed Mar 13 11:16:48 2024] total_pgpgout 1444
> > [Wed Mar 13 11:16:48 2024] total_pgfault 885
> > [Wed Mar 13 11:16:48 2024] total_pgmajfault 0
> > [Wed Mar 13 11:16:48 2024] total_inactive_anon 1146880
> > [Wed Mar 13 11:16:48 2024] total_active_anon 4096
> > [Wed Mar 13 11:16:48 2024] total_inactive_file 802357248
> > [Wed Mar 13 11:16:48 2024] total_active_file 270008320
> > [Wed Mar 13 11:16:48 2024] total_unevictable 0
> > [Wed Mar 13 11:16:48 2024] Tasks state (memory values in pages):
> > [Wed Mar 13 11:16:48 2024] [  pid  ]   uid  tgid total_vm      rss
> > rss_anon rss_file rss_shmem pgtables_bytes swapents oom_score_adj name
> > [Wed Mar 13 11:16:48 2024] [   6911]     0  6911    55506      640
> >  256      384         0    73728        0             0 dd
> > [Wed Mar 13 11:16:48 2024]
> > oom-kill:constraint=3DCONSTRAINT_MEMCG,nodemask=3D(null),cpuset=3D/,mem=
s_allowed=3D0-1,oom_memcg=3D/mglru,task_memcg=3D/mglru,task=3Ddd,pid=3D6911=
,uid=3D0
> >
> > The key information extracted from the OOM info is as follows:
> >
> > [Wed Mar 13 11:16:48 2024] cache 1072365568
> > [Wed Mar 13 11:16:48 2024] dirty 1072365568
> >
> > This information reveals that all file pages are dirty pages.
>
> I'm surprised to see there was 0 pages under writeback:
>   [Wed Mar 13 11:16:48 2024] total_writeback 0
> What's your dirty limit?

The background dirty threshold is 2G, and the dirty threshold is 4G.

    sysctl -w vm.dirty_background_bytes=3D$((1024 * 1024 * 1024 * 2))
    sysctl -w vm.dirty_bytes=3D$((1024 * 1024 * 1024 * 4))

>
> It's unfortunate that the mainline has no per-memcg dirty limit. (We
> do at Google.)

Per-memcg dirty limit is a useful feature. We also support it in our
local kernel, but we didn't enable it for this test case.
It is unclear why the memcg maintainers insist on rejecting the
per-memcg dirty limit :(

>
> > As of now, it appears that the most effective solution to address this
> > issue is to revert the commit 14aa8b2d5c2e. Regarding this commit
> > 14aa8b2d5c2e,  its original intention was to eliminate potential SSD
> > wearout, although there's no concrete data available on how it might
> > impact SSD longevity. If the concern about SSD wearout is purely
> > theoretical, it might be reasonable to consider reverting this commit.
>
> The SSD wearout problem was real -- it wasn't really due to
> wakeup_flusher_threads() itself; rather, the original MGLRU code call
> the function improperly. It needs to be called under more restricted
> conditions so that it doesn't cause the SDD wearout problem again.
> However, IMO, wakeup_flusher_threads() is just another bandaid trying
> to work around a more fundamental problem. There is no guarantee that
> the flusher will target the dirty pages in the memcg under reclaim,
> right?

Right, it is a system-wide fluser.

>
> Do you mind trying the following first to see if we can get around
> the problem without calling wakeup_flusher_threads().

I have tried it, but it still triggers the OOM. Below is the information.

[   71.713649] dd invoked oom-killer:
gfp_mask=3D0x101c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_HARDWALL|__GFP_MOVABLE|__G=
FP_WRITE),
order=3D3, oom_score_adj=3D0
[   71.716317] CPU: 60 PID: 7218 Comm: dd Not tainted 6.8.0-rc6+ #26
[   71.717677] Call Trace:
[   71.717917]  <TASK>
[   71.718137]  dump_stack_lvl+0x6e/0x90
[   71.718485]  dump_stack+0x10/0x20
[   71.718799]  dump_header+0x47/0x2d0
[   71.719147]  oom_kill_process+0x101/0x2e0
[   71.719523]  out_of_memory+0xfc/0x430
[   71.719868]  mem_cgroup_out_of_memory+0x13d/0x160
[   71.720322]  try_charge_memcg+0x7be/0x850
[   71.720701]  ? get_mem_cgroup_from_mm+0x5e/0x420
[   71.721137]  ? rcu_read_unlock+0x25/0x70
[   71.721506]  __mem_cgroup_charge+0x49/0x90
[   71.721887]  __filemap_add_folio+0x277/0x450
[   71.722304]  ? __pfx_workingset_update_node+0x10/0x10
[   71.722773]  filemap_add_folio+0x3c/0xa0
[   71.723149]  __filemap_get_folio+0x13d/0x2f0
[   71.723551]  iomap_get_folio+0x4c/0x60
[   71.723911]  iomap_write_begin+0x1bb/0x2e0
[   71.724309]  iomap_write_iter+0xff/0x290
[   71.724683]  iomap_file_buffered_write+0x91/0xf0
[   71.725140]  xfs_file_buffered_write+0x9f/0x2d0 [xfs]
[   71.725793]  ? vfs_write+0x261/0x530
[   71.726148]  ? debug_smp_processor_id+0x17/0x20
[   71.726574]  xfs_file_write_iter+0xe9/0x120 [xfs]
[   71.727161]  vfs_write+0x37d/0x530
[   71.727501]  ksys_write+0x6d/0xf0
[   71.727821]  __x64_sys_write+0x19/0x20
[   71.728181]  do_syscall_64+0x79/0x1a0
[   71.728529]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[   71.729002] RIP: 0033:0x7fd77053e927
[   71.729340] Code: 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7
0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89
74 24
[   71.730988] RSP: 002b:00007fff032b7218 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[   71.731664] RAX: ffffffffffffffda RBX: 0000000000100000 RCX: 00007fd7705=
3e927
[   71.732308] RDX: 0000000000100000 RSI: 00007fd762cfe000 RDI: 00000000000=
00001
[   71.732955] RBP: 00007fd762cfe000 R08: 00007fd762cfe000 R09: 00000000000=
00000
[   71.733592] R10: 0000000000000022 R11: 0000000000000246 R12: 00000000000=
00000
[   71.734237] R13: 0000000000000000 R14: 0000000000000000 R15: 00007fd762c=
fe000
[   71.735175]  </TASK>
[   71.736115] memory: usage 1048548kB, limit 1048576kB, failcnt 114
[   71.736123] memory+swap: usage 1048548kB, limit 9007199254740988kB, fail=
cnt 0
[   71.736127] kmem: usage 184kB, limit 9007199254740988kB, failcnt 0
[   71.736131] Memory cgroup stats for /mglru:
[   71.736364] cache 1072300032
[   71.736370] rss 1224704
[   71.736373] rss_huge 0
[   71.736376] shmem 0
[   71.736380] mapped_file 0
[   71.736383] dirty 1072300032
[   71.736386] writeback 0
[   71.736389] workingset_refault_anon 0
[   71.736393] workingset_refault_file 0
[   71.736396] swap 0
[   71.736400] swapcached 0
[   71.736403] pgpgin 2782
[   71.736406] pgpgout 1427
[   71.736410] pgfault 882
[   71.736414] pgmajfault 0
[   71.736417] inactive_anon 0
[   71.736421] active_anon 1220608
[   71.736424] inactive_file 0
[   71.736428] active_file 1072300032
[   71.736431] unevictable 0
[   71.736435] hierarchical_memory_limit 1073741824
[   71.736438] hierarchical_memsw_limit 9223372036854771712
[   71.736442] total_cache 1072300032
[   71.736445] total_rss 1224704
[   71.736448] total_rss_huge 0
[   71.736451] total_shmem 0
[   71.736455] total_mapped_file 0
[   71.736458] total_dirty 1072300032
[   71.736462] total_writeback 0
[   71.736465] total_workingset_refault_anon 0
[   71.736469] total_workingset_refault_file 0
[   71.736472] total_swap 0
[   71.736475] total_swapcached 0
[   71.736478] total_pgpgin 2782
[   71.736482] total_pgpgout 1427
[   71.736485] total_pgfault 882
[   71.736488] total_pgmajfault 0
[   71.736491] total_inactive_anon 0
[   71.736494] total_active_anon 1220608
[   71.736497] total_inactive_file 0
[   71.736501] total_active_file 1072300032
[   71.736504] total_unevictable 0
[   71.736508] Tasks state (memory values in pages):
[   71.736512] [  pid  ]   uid  tgid total_vm      rss rss_anon
rss_file rss_shmem pgtables_bytes swapents oom_score_adj name
[   71.736522] [   7215]     0  7215    55663      768        0
768         0    81920        0             0 test.sh
[   71.736586] [   7218]     0  7218    55506      640      256
384         0    69632        0             0 dd
[   71.736596] oom-kill:constraint=3DCONSTRAINT_MEMCG,nodemask=3D(null),cpu=
set=3D/,mems_allowed=3D0-1,oom_memcg=3D/mglru,task_memcg=3D/mglru,task=3Dte=
st.sh,pid=3D7215,uid=3D0
[   71.736766] Memory cgroup out of memory: Killed process 7215
(test.sh) total-vm:222652kB, anon-rss:0kB, file-rss:3072kB,
shmem-rss:0kB, UID:0 pgtables:80kB oom_score_adj:0

And the key information:

[   71.736442] total_cache 1072300032
[   71.736458] total_dirty 1072300032
[   71.736462] total_writeback 0

>
> Thanks!
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4255619a1a31..d3cfbd95996d 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -225,7 +225,7 @@ static bool writeback_throttling_sane(struct scan_con=
trol *sc)
>         if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
>                 return true;
>  #endif
> -       return false;
> +       return lru_gen_enabled();
>  }
>  #else
>  static bool cgroup_reclaim(struct scan_control *sc)
> @@ -4273,8 +4273,10 @@ static bool sort_folio(struct lruvec *lruvec, stru=
ct folio *folio, struct scan_c
>         }
>
>         /* waiting for writeback */
> -       if (folio_test_locked(folio) || folio_test_writeback(folio) ||
> -           (type =3D=3D LRU_GEN_FILE && folio_test_dirty(folio))) {
> +       if (folio_test_writeback(folio) || (type =3D=3D LRU_GEN_FILE && f=
olio_test_dirty(folio))) {
> +               sc->nr.dirty +=3D delta;
> +               if (!folio_test_reclaim(folio))
> +                       sc->nr.congested +=3D delta;
>                 gen =3D folio_inc_gen(lruvec, folio, true);
>                 list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
>                 return true;


--=20
Regards
Yafang

