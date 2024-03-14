Return-Path: <cgroups+bounces-2057-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A199E87C518
	for <lists+cgroups@lfdr.de>; Thu, 14 Mar 2024 23:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9731C21342
	for <lists+cgroups@lfdr.de>; Thu, 14 Mar 2024 22:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C8F768FF;
	Thu, 14 Mar 2024 22:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WjcchE2P"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D587351E
	for <cgroups@vger.kernel.org>; Thu, 14 Mar 2024 22:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710455007; cv=none; b=OON1TS/N3VnTYyLh3t23tr3YkOpNRhUN013hvVYhB6zziFQUCzgke82Y6Th1L1Id1rT+di3AZxcSJR08CsEHknHCl9cdhdbp1IhLTYlRChkj4X87PUhT+7JruKpe2Esp77CzBiy2EU0rjbqtYnJruUoOA4b19SEbp5MNnxylDXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710455007; c=relaxed/simple;
	bh=dxynYCTjVCxgm+FMj12PxMZVC3LD3ZmjNOihkbMEuQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAFrH5Y0eDF/HHEQ6gniuL20JRJVUJCOtQOXySnVMNTvg23ts1+FhKXJ4aZJL0U7HnBoZW7oOLPKP5C2u4c5DNuO0i4ByTiPKsZa/Kz7jaH1R2d+EZjJAm6hlCvOtDeB/8js6gc7Va5F94yf1KvJMGb+7kt3p6tnOwqHEL0YLTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WjcchE2P; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36646d1c2b7so16745ab.1
        for <cgroups@vger.kernel.org>; Thu, 14 Mar 2024 15:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710455003; x=1711059803; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fPSU/lY0e54nZlDMQRX0XdeyW69foMgt9vlKuEgC77c=;
        b=WjcchE2PLnOq7ajfbQY/B9pcYi8mrwO1KBFOX0kUFV+9817uF/scAuSWDqdmZ9uDlC
         oZ5bl2U/I1bjfVZtOQA1sDybEiW40XBBxbrrIjFZo84M/zQPOjpMGATPc/iFjuzlz/RF
         6DqSQi95/FNHvuSSlgPaO9Hxt7wtEFrEa0RQKRIo5FFQiO8g/zTtOBEWOLbAfJCpag54
         DOi8dM89tILsuK8HIp+chQaxJjUr53VK1eaZbRWLYh8NT695TUsuw2rkzW/+/JnjROiU
         F0GMhb/SXMUu9EpE225S4cfzzLrTV7Ct8zf/hhyhrHV9jIJVun2pvMtRTAlvDvxCwsqf
         LoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710455003; x=1711059803;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fPSU/lY0e54nZlDMQRX0XdeyW69foMgt9vlKuEgC77c=;
        b=ox9AXAwuWGdmu973odjgQeGBH8DPTG2edQOtgZnnuzJSdUhI7wOjrYxLGVlSFqOq1R
         FrRfowEs+K85KuA7MLC4BMYqX4nXFd8sIz7e5O1zeAzZy+2GXdUGZxvEznvrNp2B9Y2k
         3WuzHjf+M7crWn7KLaMD411V10c71evUVXaHKzfKZPLd+29R9MQwkBMdUq3vz6ARGGFq
         r85dFTdnYywhumAK/SobeiIKaUz94SR1VoyLbY80oKGDYxTfp0WP8jC1tFbjKPRVdJ01
         qMo2Gid7XRscG9ZIbgtPlRgIcdTom6YzptOKpyLgLcYGOgqu12BGHvfrU3e3ysdewJmO
         Czqg==
X-Forwarded-Encrypted: i=1; AJvYcCV9no7qMG2RuVFN+dYgSfg2pSOYgEjJ6H6MzvqiHxEivNwp3QguCRMbwwxX9oV7uKOWpworL8rlyEdjFE8GP4eJ6OBO40AWJg==
X-Gm-Message-State: AOJu0Yyt9356jSdOEwxj8GbDKfGfW5E5oKvKOywpz6vI93I/KX3Bxrpc
	DOjA4XVM5imMugwJYm78JCjUyswntxQBABV9vWDODOB7YmXjLPtYWIE2i6GVzg==
X-Google-Smtp-Source: AGHT+IGD4rpdTgr+e1aPncVPDvEICL6+gZqPHdIxGmsrhT5BvTIRbFPexxTE620rFJX8Cp9guryruw==
X-Received: by 2002:a05:6e02:2166:b0:366:7aff:6c7c with SMTP id s6-20020a056e02216600b003667aff6c7cmr328022ilv.14.1710455003129;
        Thu, 14 Mar 2024 15:23:23 -0700 (PDT)
Received: from google.com ([100.64.188.49])
        by smtp.gmail.com with ESMTPSA id he26-20020a0566386d1a00b0047462f8adfdsm392430jab.138.2024.03.14.15.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 15:23:22 -0700 (PDT)
Date: Thu, 14 Mar 2024 16:23:16 -0600
From: Yu Zhao <yuzhao@google.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>,
	Chris Down <chris@chrisdown.name>, cgroups@vger.kernel.org,
	hannes@cmpxchg.org, kernel-team@fb.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: MGLRU premature memcg OOM on slow writes
Message-ID: <ZfN41Bm2UA7qDPEA@google.com>
References: <ZcWOh9u3uqZjNFMa@chrisdown.name>
 <20240229235134.2447718-1-axelrasmussen@google.com>
 <ZeEhvV15IWllPKvM@chrisdown.name>
 <CAJHvVch2qVUDTJjNeSMqLBx0yoEm4zzb=ZXmABbd_5dWGQTpNg@mail.gmail.com>
 <CALOAHbBupMYBMWEzMK2xdhnqwR1C1+mJSrrZC1L0CKE2BMSC+g@mail.gmail.com>
 <CAJHvVcjhUNx8UP9mao4TdvU6xK7isRzazoSU53a4NCcFiYuM-g@mail.gmail.com>
 <ZfC16BikjhupKnVG@google.com>
 <ZfC2612ZYwwxpOmR@google.com>
 <CALOAHbAAnGjt2yd8avcSSkMA2MeUWN1-CTkN81GJF+udwE6+DQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbAAnGjt2yd8avcSSkMA2MeUWN1-CTkN81GJF+udwE6+DQ@mail.gmail.com>

On Wed, Mar 13, 2024 at 11:33:21AM +0800, Yafang Shao wrote:
> On Wed, Mar 13, 2024 at 4:11 AM Yu Zhao <yuzhao@google.com> wrote:
> >
> > On Tue, Mar 12, 2024 at 02:07:04PM -0600, Yu Zhao wrote:
> > > On Tue, Mar 12, 2024 at 09:44:19AM -0700, Axel Rasmussen wrote:
> > > > On Mon, Mar 11, 2024 at 2:11 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > > > >
> > > > > On Sat, Mar 9, 2024 at 3:19 AM Axel Rasmussen <axelrasmussen@google.com> wrote:
> > > > > >
> > > > > > On Thu, Feb 29, 2024 at 4:30 PM Chris Down <chris@chrisdown.name> wrote:
> > > > > > >
> > > > > > > Axel Rasmussen writes:
> > > > > > > >A couple of dumb questions. In your test, do you have any of the following
> > > > > > > >configured / enabled?
> > > > > > > >
> > > > > > > >/proc/sys/vm/laptop_mode
> > > > > > > >memory.low
> > > > > > > >memory.min
> > > > > > >
> > > > > > > None of these are enabled. The issue is trivially reproducible by writing to
> > > > > > > any slow device with memory.max enabled, but from the code it looks like MGLRU
> > > > > > > is also susceptible to this on global reclaim (although it's less likely due to
> > > > > > > page diversity).
> > > > > > >
> > > > > > > >Besides that, it looks like the place non-MGLRU reclaim wakes up the
> > > > > > > >flushers is in shrink_inactive_list() (which calls wakeup_flusher_threads()).
> > > > > > > >Since MGLRU calls shrink_folio_list() directly (from evict_folios()), I agree it
> > > > > > > >looks like it simply will not do this.
> > > > > > > >
> > > > > > > >Yosry pointed out [1], where MGLRU used to call this but stopped doing that. It
> > > > > > > >makes sense to me at least that doing writeback every time we age is too
> > > > > > > >aggressive, but doing it in evict_folios() makes some sense to me, basically to
> > > > > > > >copy the behavior the non-MGLRU path (shrink_inactive_list()) has.
> > > > > > >
> > > > > > > Thanks! We may also need reclaim_throttle(), depending on how you implement it.
> > > > > > > Current non-MGLRU behaviour on slow storage is also highly suspect in terms of
> > > > > > > (lack of) throttling after moving away from VMSCAN_THROTTLE_WRITEBACK, but one
> > > > > > > thing at a time :-)
> > > > > >
> > > > > >
> > > > > > Hmm, so I have a patch which I think will help with this situation,
> > > > > > but I'm having some trouble reproducing the problem on 6.8-rc7 (so
> > > > > > then I can verify the patch fixes it).
> > > > >
> > > > > We encountered the same premature OOM issue caused by numerous dirty pages.
> > > > > The issue disappears after we revert the commit 14aa8b2d5c2e
> > > > > "mm/mglru: don't sync disk for each aging cycle"
> > > > >
> > > > > To aid in replicating the issue, we've developed a straightforward
> > > > > script, which consistently reproduces it, even on the latest kernel.
> > > > > You can find the script provided below:
> > > > >
> > > > > ```
> > > > > #!/bin/bash
> > > > >
> > > > > MEMCG="/sys/fs/cgroup/memory/mglru"
> > > > > ENABLE=$1
> > > > >
> > > > > # Avoid waking up the flusher
> > > > > sysctl -w vm.dirty_background_bytes=$((1024 * 1024 * 1024 *4))
> > > > > sysctl -w vm.dirty_bytes=$((1024 * 1024 * 1024 *4))
> > > > >
> > > > > if [ ! -d ${MEMCG} ]; then
> > > > >         mkdir -p ${MEMCG}
> > > > > fi
> > > > >
> > > > > echo $$ > ${MEMCG}/cgroup.procs
> > > > > echo 1g > ${MEMCG}/memory.limit_in_bytes
> > > > >
> > > > > if [ $ENABLE -eq 0 ]; then
> > > > >         echo 0 > /sys/kernel/mm/lru_gen/enabled
> > > > > else
> > > > >         echo 0x7 > /sys/kernel/mm/lru_gen/enabled
> > > > > fi
> > > > >
> > > > > dd if=/dev/zero of=/data0/mglru.test bs=1M count=1023
> > > > > rm -rf /data0/mglru.test
> > > > > ```
> > > > >
> > > > > This issue disappears as well after we disable the mglru.
> > > > >
> > > > > We hope this script proves helpful in identifying and addressing the
> > > > > root cause. We eagerly await your insights and proposed fixes.
> > > >
> > > > Thanks Yafang, I was able to reproduce the issue using this script.
> > > >
> > > > Perhaps interestingly, I was not able to reproduce it with cgroupv2
> > > > memcgs. I know writeback semantics are quite a bit different there, so
> > > > perhaps that explains why.
> > > >
> > > > Unfortunately, it also reproduces even with the commit I had in mind
> > > > (basically stealing the "if (all isolated pages are unqueued dirty) {
> > > > wakeup_flusher_threads(); reclaim_throttle(); }" from
> > > > shrink_inactive_list, and adding it to MGLRU's evict_folios()). So
> > > > I'll need to spend some more time on this; I'm planning to send
> > > > something out for testing next week.
> > >
> > > Hi Chris,
> > >
> > > My apologies for not getting back to you sooner.
> > >
> > > And thanks everyone for all the input!
> > >
> > > My take is that Chris' premature OOM kills were NOT really due to
> > > the flusher not waking up or missing throttling.
> > >
> > > Yes, these two are among the differences between the active/inactive
> > > LRU and MGLRU, but their roles, IMO, are not as important as the LRU
> > > positions of dirty pages. The active/inactive LRU moves dirty pages
> > > all the way to the end of the line (reclaim happens at the front)
> > > whereas MGLRU moves them into the middle, during direct reclaim. The
> > > rationale for MGLRU was that this way those dirty pages would still
> > > be counted as "inactive" (or cold).
> > >
> > > This theory can be quickly verified by comparing how much
> > > nr_vmscan_immediate_reclaim grows, i.e.,
> > >
> > >   Before the copy
> > >     grep nr_vmscan_immediate_reclaim /proc/vmstat
> > >   And then after the copy
> > >     grep nr_vmscan_immediate_reclaim /proc/vmstat
> > >
> > > The growth should be trivial for MGLRU and nontrivial for the
> > > active/inactive LRU.
> > >
> > > If this is indeed the case, I'd appreciate very much if anyone could
> > > try the following (I'll try it myself too later next week).
> > >
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index 4255619a1a31..020f5d98b9a1 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -4273,10 +4273,13 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
> > >       }
> > >
> > >       /* waiting for writeback */
> > > -     if (folio_test_locked(folio) || folio_test_writeback(folio) ||
> > > -         (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
> > > -             gen = folio_inc_gen(lruvec, folio, true);
> > > -             list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
> > > +     if (folio_test_writeback(folio) || (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
> > > +             DEFINE_MAX_SEQ(lruvec);
> > > +             int old_gen, new_gen = lru_gen_from_seq(max_seq);
> > > +
> > > +             old_gen = folio_update_gen(folio, new_gen);
> > > +             lru_gen_update_size(lruvec, folio, old_gen, new_gen);
> > > +             list_move(&folio->lru, &lrugen->folios[new_gen][type][zone]);
> >
> > Sorry missing one line here:
> >
> >  +              folio_set_reclaim(folio);
> >
> > >               return true;
> > >       }
> 
> Hi Yu,
> 
> I have validated it using the script provided for Axel, but
> unfortunately, it still triggers an OOM error with your patch applied.
> Here are the results with nr_vmscan_immediate_reclaim:

Thanks for debunking it!

> - non-MGLRU
>   $ grep nr_vmscan_immediate_reclaim /proc/vmstat
>   nr_vmscan_immediate_reclaim 47411776
> 
>   $ ./test.sh 0
>   1023+0 records in
>   1023+0 records out
>   1072693248 bytes (1.1 GB, 1023 MiB) copied, 0.538058 s, 2.0 GB/s
> 
>   $ grep nr_vmscan_immediate_reclaim /proc/vmstat
>   nr_vmscan_immediate_reclaim 47412544
> 
> - MGLRU
>   $ grep nr_vmscan_immediate_reclaim /proc/vmstat
>   nr_vmscan_immediate_reclaim 47412544
> 
>   $ ./test.sh 1
>   Killed
> 
>   $ grep nr_vmscan_immediate_reclaim /proc/vmstat
>   nr_vmscan_immediate_reclaim 115455600

The delta is ~260GB, I'm still thinking how that could happen -- is this reliably reproducible?

> The detailed OOM info as follows,
> 
> [Wed Mar 13 11:16:48 2024] dd invoked oom-killer:
> gfp_mask=0x101c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_WRITE),
> order=3, oom_score_adj=0
> [Wed Mar 13 11:16:48 2024] CPU: 12 PID: 6911 Comm: dd Not tainted 6.8.0-rc6+ #24
> [Wed Mar 13 11:16:48 2024] Hardware name: Tencent Cloud CVM, BIOS
> seabios-1.9.1-qemu-project.org 04/01/2014
> [Wed Mar 13 11:16:48 2024] Call Trace:
> [Wed Mar 13 11:16:48 2024]  <TASK>
> [Wed Mar 13 11:16:48 2024]  dump_stack_lvl+0x6e/0x90
> [Wed Mar 13 11:16:48 2024]  dump_stack+0x10/0x20
> [Wed Mar 13 11:16:48 2024]  dump_header+0x47/0x2d0
> [Wed Mar 13 11:16:48 2024]  oom_kill_process+0x101/0x2e0
> [Wed Mar 13 11:16:48 2024]  out_of_memory+0xfc/0x430
> [Wed Mar 13 11:16:48 2024]  mem_cgroup_out_of_memory+0x13d/0x160
> [Wed Mar 13 11:16:48 2024]  try_charge_memcg+0x7be/0x850
> [Wed Mar 13 11:16:48 2024]  ? get_mem_cgroup_from_mm+0x5e/0x420
> [Wed Mar 13 11:16:48 2024]  ? rcu_read_unlock+0x25/0x70
> [Wed Mar 13 11:16:48 2024]  __mem_cgroup_charge+0x49/0x90
> [Wed Mar 13 11:16:48 2024]  __filemap_add_folio+0x277/0x450
> [Wed Mar 13 11:16:48 2024]  ? __pfx_workingset_update_node+0x10/0x10
> [Wed Mar 13 11:16:48 2024]  filemap_add_folio+0x3c/0xa0
> [Wed Mar 13 11:16:48 2024]  __filemap_get_folio+0x13d/0x2f0
> [Wed Mar 13 11:16:48 2024]  iomap_get_folio+0x4c/0x60
> [Wed Mar 13 11:16:48 2024]  iomap_write_begin+0x1bb/0x2e0
> [Wed Mar 13 11:16:48 2024]  iomap_write_iter+0xff/0x290
> [Wed Mar 13 11:16:48 2024]  iomap_file_buffered_write+0x91/0xf0
> [Wed Mar 13 11:16:48 2024]  xfs_file_buffered_write+0x9f/0x2d0 [xfs]
> [Wed Mar 13 11:16:48 2024]  ? vfs_write+0x261/0x530
> [Wed Mar 13 11:16:48 2024]  ? debug_smp_processor_id+0x17/0x20
> [Wed Mar 13 11:16:48 2024]  xfs_file_write_iter+0xe9/0x120 [xfs]
> [Wed Mar 13 11:16:48 2024]  vfs_write+0x37d/0x530
> [Wed Mar 13 11:16:48 2024]  ksys_write+0x6d/0xf0
> [Wed Mar 13 11:16:48 2024]  __x64_sys_write+0x19/0x20
> [Wed Mar 13 11:16:48 2024]  do_syscall_64+0x79/0x1a0
> [Wed Mar 13 11:16:48 2024]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> [Wed Mar 13 11:16:48 2024] RIP: 0033:0x7f63ea33e927
> [Wed Mar 13 11:16:48 2024] Code: 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff
> ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10
> b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54
> 24 18 48 89 74 24
> [Wed Mar 13 11:16:48 2024] RSP: 002b:00007ffc0e874768 EFLAGS: 00000246
> ORIG_RAX: 0000000000000001
> [Wed Mar 13 11:16:48 2024] RAX: ffffffffffffffda RBX: 0000000000100000
> RCX: 00007f63ea33e927
> [Wed Mar 13 11:16:48 2024] RDX: 0000000000100000 RSI: 00007f63dcafe000
> RDI: 0000000000000001
> [Wed Mar 13 11:16:48 2024] RBP: 00007f63dcafe000 R08: 00007f63dcafe000
> R09: 0000000000000000
> [Wed Mar 13 11:16:48 2024] R10: 0000000000000022 R11: 0000000000000246
> R12: 0000000000000000
> [Wed Mar 13 11:16:48 2024] R13: 0000000000000000 R14: 0000000000000000
> R15: 00007f63dcafe000
> [Wed Mar 13 11:16:48 2024]  </TASK>
> [Wed Mar 13 11:16:48 2024] memory: usage 1048556kB, limit 1048576kB, failcnt 153
> [Wed Mar 13 11:16:48 2024] memory+swap: usage 1048556kB, limit

I see you were actually on cgroup v1 -- this might be a different
problem than Chris' since he was on v2.

For v1, the throttling is done by commit 81a70c21d9
("mm/cgroup/reclaim: fix dirty pages throttling on cgroup v1").
IOW, the active/inactive LRU throttles in both v1 and v2 (done
in different ways) whereas MGLRU doesn't in either case.

> 9007199254740988kB, failcnt 0
> [Wed Mar 13 11:16:48 2024] kmem: usage 200kB, limit
> 9007199254740988kB, failcnt 0
> [Wed Mar 13 11:16:48 2024] Memory cgroup stats for /mglru:
> [Wed Mar 13 11:16:48 2024] cache 1072365568
> [Wed Mar 13 11:16:48 2024] rss 1150976
> [Wed Mar 13 11:16:48 2024] rss_huge 0
> [Wed Mar 13 11:16:48 2024] shmem 0
> [Wed Mar 13 11:16:48 2024] mapped_file 0
> [Wed Mar 13 11:16:48 2024] dirty 1072365568
> [Wed Mar 13 11:16:48 2024] writeback 0
> [Wed Mar 13 11:16:48 2024] workingset_refault_anon 0
> [Wed Mar 13 11:16:48 2024] workingset_refault_file 0
> [Wed Mar 13 11:16:48 2024] swap 0
> [Wed Mar 13 11:16:48 2024] swapcached 0
> [Wed Mar 13 11:16:48 2024] pgpgin 2783
> [Wed Mar 13 11:16:48 2024] pgpgout 1444
> [Wed Mar 13 11:16:48 2024] pgfault 885
> [Wed Mar 13 11:16:48 2024] pgmajfault 0
> [Wed Mar 13 11:16:48 2024] inactive_anon 1146880
> [Wed Mar 13 11:16:48 2024] active_anon 4096
> [Wed Mar 13 11:16:48 2024] inactive_file 802357248
> [Wed Mar 13 11:16:48 2024] active_file 270008320
> [Wed Mar 13 11:16:48 2024] unevictable 0
> [Wed Mar 13 11:16:48 2024] hierarchical_memory_limit 1073741824
> [Wed Mar 13 11:16:48 2024] hierarchical_memsw_limit 9223372036854771712
> [Wed Mar 13 11:16:48 2024] total_cache 1072365568
> [Wed Mar 13 11:16:48 2024] total_rss 1150976
> [Wed Mar 13 11:16:48 2024] total_rss_huge 0
> [Wed Mar 13 11:16:48 2024] total_shmem 0
> [Wed Mar 13 11:16:48 2024] total_mapped_file 0
> [Wed Mar 13 11:16:48 2024] total_dirty 1072365568
> [Wed Mar 13 11:16:48 2024] total_writeback 0
> [Wed Mar 13 11:16:48 2024] total_workingset_refault_anon 0
> [Wed Mar 13 11:16:48 2024] total_workingset_refault_file 0
> [Wed Mar 13 11:16:48 2024] total_swap 0
> [Wed Mar 13 11:16:48 2024] total_swapcached 0
> [Wed Mar 13 11:16:48 2024] total_pgpgin 2783
> [Wed Mar 13 11:16:48 2024] total_pgpgout 1444
> [Wed Mar 13 11:16:48 2024] total_pgfault 885
> [Wed Mar 13 11:16:48 2024] total_pgmajfault 0
> [Wed Mar 13 11:16:48 2024] total_inactive_anon 1146880
> [Wed Mar 13 11:16:48 2024] total_active_anon 4096
> [Wed Mar 13 11:16:48 2024] total_inactive_file 802357248
> [Wed Mar 13 11:16:48 2024] total_active_file 270008320
> [Wed Mar 13 11:16:48 2024] total_unevictable 0
> [Wed Mar 13 11:16:48 2024] Tasks state (memory values in pages):
> [Wed Mar 13 11:16:48 2024] [  pid  ]   uid  tgid total_vm      rss
> rss_anon rss_file rss_shmem pgtables_bytes swapents oom_score_adj name
> [Wed Mar 13 11:16:48 2024] [   6911]     0  6911    55506      640
>  256      384         0    73728        0             0 dd
> [Wed Mar 13 11:16:48 2024]
> oom-kill:constraint=CONSTRAINT_MEMCG,nodemask=(null),cpuset=/,mems_allowed=0-1,oom_memcg=/mglru,task_memcg=/mglru,task=dd,pid=6911,uid=0
> 
> The key information extracted from the OOM info is as follows:
> 
> [Wed Mar 13 11:16:48 2024] cache 1072365568
> [Wed Mar 13 11:16:48 2024] dirty 1072365568
> 
> This information reveals that all file pages are dirty pages.

I'm surprised to see there was 0 pages under writeback:
  [Wed Mar 13 11:16:48 2024] total_writeback 0
What's your dirty limit?

It's unfortunate that the mainline has no per-memcg dirty limit. (We
do at Google.)

> As of now, it appears that the most effective solution to address this
> issue is to revert the commit 14aa8b2d5c2e. Regarding this commit
> 14aa8b2d5c2e,  its original intention was to eliminate potential SSD
> wearout, although there's no concrete data available on how it might
> impact SSD longevity. If the concern about SSD wearout is purely
> theoretical, it might be reasonable to consider reverting this commit.

The SSD wearout problem was real -- it wasn't really due to
wakeup_flusher_threads() itself; rather, the original MGLRU code call
the function improperly. It needs to be called under more restricted
conditions so that it doesn't cause the SDD wearout problem again.
However, IMO, wakeup_flusher_threads() is just another bandaid trying
to work around a more fundamental problem. There is no guarantee that
the flusher will target the dirty pages in the memcg under reclaim,
right?

Do you mind trying the following first to see if we can get around
the problem without calling wakeup_flusher_threads().

Thanks!

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4255619a1a31..d3cfbd95996d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -225,7 +225,7 @@ static bool writeback_throttling_sane(struct scan_control *sc)
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return true;
 #endif
-	return false;
+	return lru_gen_enabled();
 }
 #else
 static bool cgroup_reclaim(struct scan_control *sc)
@@ -4273,8 +4273,10 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	}
 
 	/* waiting for writeback */
-	if (folio_test_locked(folio) || folio_test_writeback(folio) ||
-	    (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
+	if (folio_test_writeback(folio) || (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
+		sc->nr.dirty += delta;
+		if (!folio_test_reclaim(folio))
+			sc->nr.congested += delta;
 		gen = folio_inc_gen(lruvec, folio, true);
 		list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;

