Return-Path: <cgroups+bounces-2039-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E2D879C8F
	for <lists+cgroups@lfdr.de>; Tue, 12 Mar 2024 21:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99BA1C21920
	for <lists+cgroups@lfdr.de>; Tue, 12 Mar 2024 20:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068CD14264F;
	Tue, 12 Mar 2024 20:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v0B8U0Jo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123DA7D406
	for <cgroups@vger.kernel.org>; Tue, 12 Mar 2024 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710274032; cv=none; b=NEC+avjcWxSFZubb8JqqBJIhUYgWkE1m0pyJwXSE7saWqmjENZAK6Jvw698JXaaHgAEQZPhOjt3iL5iY2CF5ib26zMaRLPqfINcuM3ieosahoP4BogclIevw/zccWovzHtXuoxW88p/T5J+SbbzMQ5eWlVBKuf00ZFkvzJ9V6pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710274032; c=relaxed/simple;
	bh=qUCTPlmygVZMn4ybnM4YXMYrNgQOhFUeSNsA1t/8do8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSpOCd5kNWXRd+WisBrcJ5MzM5vx/6+fTFRssVaoOBaxysY4ivsFuMOzZDYptfOMelf1lgYPPclfp+mhnqp8CoKC/AvqoVcPg8IBqIlNSLkqnlDeT9CCn21lzUQI6QH6XTp6zSgo6MbESG332gAl6YF6oYH8rQw8W9et3zmuAc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v0B8U0Jo; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36645c1169cso29765ab.0
        for <cgroups@vger.kernel.org>; Tue, 12 Mar 2024 13:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710274030; x=1710878830; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z7Q03zM1IVSIFtblUjZYYL4rwsX8KkQoK8j6nmVhRrM=;
        b=v0B8U0JoGmh3u78mbqbVC4hzVAZGN8PrpM2yxZSgx2S+Ak9J1ms2o7R6k6RmZeubze
         kKWnPIdTA86UOQAzOa+CkZ1lmX58wufZLPizKDB4NYkLvmydsz2469N103U2F/e21MrO
         oWhrOvg8yp2ymUuGZnK7mQ8JTFCyNVx1O7X1Szc4mPx4M3WdxJoP6xBxVnNqz6hasIQV
         8THt6nSlspUki+72Do/5sLAScjf0+QclZqwnN1zF9xArh7omeaADG6+qTnGlA1vJr2JK
         Oy1VfuqfIog8zm7hw7ebvdgT6TmVvV29yQ1Adm/hnNMR3KDGIXfn4D8+4n1xxbKoidnd
         v4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710274030; x=1710878830;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7Q03zM1IVSIFtblUjZYYL4rwsX8KkQoK8j6nmVhRrM=;
        b=cDQU7MF36WwV1WHWOPvUxcE94JQWbmTqWT0hisEB3DebcO3rr7sg3+jui26kdKymEg
         u5u5P6EGLbAjzDtoKpnwONhd8P5zPa8h2I/jWwwjZm0fLdbdIl2zdEp40MGyn75h9+RT
         ZnH72XfyN26SPat5Oqo9xIZa+JiTKwuFvShTOajIODuUOLz7GVh3DzpfJCBjF9i1G5mJ
         EFIn/1r/QoorsXIkNsLM7KfJllhI6rFFRMBX/FodI5vnAgNO4XLdti8bLnz8P3sz2Q+A
         f6gnfqKNMjdcS9ezVe0PDrm3W4AyjrVM1j7gafGkB5JkNh4Vfr5ENKyVS7t3EFI0q15h
         C43A==
X-Forwarded-Encrypted: i=1; AJvYcCVwo7dt0vPeH0u4Q6DP/WgFzRPcqZr8zdfysHSS7ynWnl4gEDSwBK++APpq1zN4iWgwMiZLm3o7m3pvp44QiJcFjHe+xF26XQ==
X-Gm-Message-State: AOJu0YxyCIgDRJQ2g3WDZulSc1lWLceLY8WX6hmPfmHhA+fpzZjsK6ve
	vM6S8IfoE5Ag+42iQhd7ywZasW+1uD5eFBka4jSyXOz3QkymRDS7ESVFUXTlyw==
X-Google-Smtp-Source: AGHT+IFHCVwXD7f3JR1HTZN7DbJBUtlY5Iyt4qqDJbw8WqZxUb2L2t87WR6swprQd92qpAgtNSZ8JA==
X-Received: by 2002:a05:6e02:304a:b0:366:2b:4236 with SMTP id be10-20020a056e02304a00b00366002b4236mr30942ilb.6.1710274030013;
        Tue, 12 Mar 2024 13:07:10 -0700 (PDT)
Received: from google.com ([100.64.188.49])
        by smtp.gmail.com with ESMTPSA id j16-20020a02cc70000000b00476e5e352c8sm1536103jaq.151.2024.03.12.13.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 13:07:09 -0700 (PDT)
Date: Tue, 12 Mar 2024 14:07:04 -0600
From: Yu Zhao <yuzhao@google.com>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, Chris Down <chris@chrisdown.name>,
	cgroups@vger.kernel.org, hannes@cmpxchg.org, kernel-team@fb.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: MGLRU premature memcg OOM on slow writes
Message-ID: <ZfC16BikjhupKnVG@google.com>
References: <ZcWOh9u3uqZjNFMa@chrisdown.name>
 <20240229235134.2447718-1-axelrasmussen@google.com>
 <ZeEhvV15IWllPKvM@chrisdown.name>
 <CAJHvVch2qVUDTJjNeSMqLBx0yoEm4zzb=ZXmABbd_5dWGQTpNg@mail.gmail.com>
 <CALOAHbBupMYBMWEzMK2xdhnqwR1C1+mJSrrZC1L0CKE2BMSC+g@mail.gmail.com>
 <CAJHvVcjhUNx8UP9mao4TdvU6xK7isRzazoSU53a4NCcFiYuM-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJHvVcjhUNx8UP9mao4TdvU6xK7isRzazoSU53a4NCcFiYuM-g@mail.gmail.com>

On Tue, Mar 12, 2024 at 09:44:19AM -0700, Axel Rasmussen wrote:
> On Mon, Mar 11, 2024 at 2:11 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > On Sat, Mar 9, 2024 at 3:19 AM Axel Rasmussen <axelrasmussen@google.com> wrote:
> > >
> > > On Thu, Feb 29, 2024 at 4:30 PM Chris Down <chris@chrisdown.name> wrote:
> > > >
> > > > Axel Rasmussen writes:
> > > > >A couple of dumb questions. In your test, do you have any of the following
> > > > >configured / enabled?
> > > > >
> > > > >/proc/sys/vm/laptop_mode
> > > > >memory.low
> > > > >memory.min
> > > >
> > > > None of these are enabled. The issue is trivially reproducible by writing to
> > > > any slow device with memory.max enabled, but from the code it looks like MGLRU
> > > > is also susceptible to this on global reclaim (although it's less likely due to
> > > > page diversity).
> > > >
> > > > >Besides that, it looks like the place non-MGLRU reclaim wakes up the
> > > > >flushers is in shrink_inactive_list() (which calls wakeup_flusher_threads()).
> > > > >Since MGLRU calls shrink_folio_list() directly (from evict_folios()), I agree it
> > > > >looks like it simply will not do this.
> > > > >
> > > > >Yosry pointed out [1], where MGLRU used to call this but stopped doing that. It
> > > > >makes sense to me at least that doing writeback every time we age is too
> > > > >aggressive, but doing it in evict_folios() makes some sense to me, basically to
> > > > >copy the behavior the non-MGLRU path (shrink_inactive_list()) has.
> > > >
> > > > Thanks! We may also need reclaim_throttle(), depending on how you implement it.
> > > > Current non-MGLRU behaviour on slow storage is also highly suspect in terms of
> > > > (lack of) throttling after moving away from VMSCAN_THROTTLE_WRITEBACK, but one
> > > > thing at a time :-)
> > >
> > >
> > > Hmm, so I have a patch which I think will help with this situation,
> > > but I'm having some trouble reproducing the problem on 6.8-rc7 (so
> > > then I can verify the patch fixes it).
> >
> > We encountered the same premature OOM issue caused by numerous dirty pages.
> > The issue disappears after we revert the commit 14aa8b2d5c2e
> > "mm/mglru: don't sync disk for each aging cycle"
> >
> > To aid in replicating the issue, we've developed a straightforward
> > script, which consistently reproduces it, even on the latest kernel.
> > You can find the script provided below:
> >
> > ```
> > #!/bin/bash
> >
> > MEMCG="/sys/fs/cgroup/memory/mglru"
> > ENABLE=$1
> >
> > # Avoid waking up the flusher
> > sysctl -w vm.dirty_background_bytes=$((1024 * 1024 * 1024 *4))
> > sysctl -w vm.dirty_bytes=$((1024 * 1024 * 1024 *4))
> >
> > if [ ! -d ${MEMCG} ]; then
> >         mkdir -p ${MEMCG}
> > fi
> >
> > echo $$ > ${MEMCG}/cgroup.procs
> > echo 1g > ${MEMCG}/memory.limit_in_bytes
> >
> > if [ $ENABLE -eq 0 ]; then
> >         echo 0 > /sys/kernel/mm/lru_gen/enabled
> > else
> >         echo 0x7 > /sys/kernel/mm/lru_gen/enabled
> > fi
> >
> > dd if=/dev/zero of=/data0/mglru.test bs=1M count=1023
> > rm -rf /data0/mglru.test
> > ```
> >
> > This issue disappears as well after we disable the mglru.
> >
> > We hope this script proves helpful in identifying and addressing the
> > root cause. We eagerly await your insights and proposed fixes.
> 
> Thanks Yafang, I was able to reproduce the issue using this script.
> 
> Perhaps interestingly, I was not able to reproduce it with cgroupv2
> memcgs. I know writeback semantics are quite a bit different there, so
> perhaps that explains why.
> 
> Unfortunately, it also reproduces even with the commit I had in mind
> (basically stealing the "if (all isolated pages are unqueued dirty) {
> wakeup_flusher_threads(); reclaim_throttle(); }" from
> shrink_inactive_list, and adding it to MGLRU's evict_folios()). So
> I'll need to spend some more time on this; I'm planning to send
> something out for testing next week.

Hi Chris,

My apologies for not getting back to you sooner.

And thanks everyone for all the input!

My take is that Chris' premature OOM kills were NOT really due to
the flusher not waking up or missing throttling.

Yes, these two are among the differences between the active/inactive
LRU and MGLRU, but their roles, IMO, are not as important as the LRU
positions of dirty pages. The active/inactive LRU moves dirty pages
all the way to the end of the line (reclaim happens at the front)
whereas MGLRU moves them into the middle, during direct reclaim. The
rationale for MGLRU was that this way those dirty pages would still
be counted as "inactive" (or cold).

This theory can be quickly verified by comparing how much
nr_vmscan_immediate_reclaim grows, i.e.,

  Before the copy
    grep nr_vmscan_immediate_reclaim /proc/vmstat
  And then after the copy
    grep nr_vmscan_immediate_reclaim /proc/vmstat

The growth should be trivial for MGLRU and nontrivial for the
active/inactive LRU.

If this is indeed the case, I'd appreciate very much if anyone could
try the following (I'll try it myself too later next week).

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4255619a1a31..020f5d98b9a1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4273,10 +4273,13 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	}
 
 	/* waiting for writeback */
-	if (folio_test_locked(folio) || folio_test_writeback(folio) ||
-	    (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
-		gen = folio_inc_gen(lruvec, folio, true);
-		list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
+	if (folio_test_writeback(folio) || (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
+		DEFINE_MAX_SEQ(lruvec);
+		int old_gen, new_gen = lru_gen_from_seq(max_seq);
+
+		old_gen = folio_update_gen(folio, new_gen);
+		lru_gen_update_size(lruvec, folio, old_gen, new_gen);
+		list_move(&folio->lru, &lrugen->folios[new_gen][type][zone]);
 		return true;
 	}
 
> > > If I understand the issue right, all we should need to do is get a
> > > slow filesystem, and then generate a bunch of dirty file pages on it,
> > > while running in a tightly constrained memcg. To that end, I tried the
> > > following script. But, in reality I seem to get little or no
> > > accumulation of dirty file pages.
> > >
> > > I thought maybe fio does something different than rsync which you said
> > > you originally tried, so I also tried rsync (copying /usr/bin into
> > > this loop mount) and didn't run into an OOM situation either.
> > >
> > > Maybe some dirty ratio settings need tweaking or something to get the
> > > behavior you see? Or maybe my test has a dumb mistake in it. :)
> > >
> > >
> > >
> > > #!/usr/bin/env bash
> > >
> > > echo 0 > /proc/sys/vm/laptop_mode || exit 1
> > > echo y > /sys/kernel/mm/lru_gen/enabled || exit 1
> > >
> > > echo "Allocate disk image"
> > > IMAGE_SIZE_MIB=1024
> > > IMAGE_PATH=/tmp/slow.img
> > > dd if=/dev/zero of=$IMAGE_PATH bs=1024k count=$IMAGE_SIZE_MIB || exit 1
> > >
> > > echo "Setup loop device"
> > > LOOP_DEV=$(losetup --show --find $IMAGE_PATH) || exit 1
> > > LOOP_BLOCKS=$(blockdev --getsize $LOOP_DEV) || exit 1
> > >
> > > echo "Create dm-slow"
> > > DM_NAME=dm-slow
> > > DM_DEV=/dev/mapper/$DM_NAME
> > > echo "0 $LOOP_BLOCKS delay $LOOP_DEV 0 100" | dmsetup create $DM_NAME || exit 1
> > >
> > > echo "Create fs"
> > > mkfs.ext4 "$DM_DEV" || exit 1
> > >
> > > echo "Mount fs"
> > > MOUNT_PATH="/tmp/$DM_NAME"
> > > mkdir -p "$MOUNT_PATH" || exit 1
> > > mount -t ext4 "$DM_DEV" "$MOUNT_PATH" || exit 1
> > >
> > > echo "Generate dirty file pages"
> > > systemd-run --wait --pipe --collect -p MemoryMax=32M \
> > >         fio -name=writes -directory=$MOUNT_PATH -readwrite=randwrite \
> > >         -numjobs=10 -nrfiles=90 -filesize=1048576 \
> > >         -fallocate=posix \
> > >         -blocksize=4k -ioengine=mmap \
> > >         -direct=0 -buffered=1 -fsync=0 -fdatasync=0 -sync=0 \
> > >         -runtime=300 -time_based

