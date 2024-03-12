Return-Path: <cgroups+bounces-2041-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88492879CAC
	for <lists+cgroups@lfdr.de>; Tue, 12 Mar 2024 21:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB8801C2163D
	for <lists+cgroups@lfdr.de>; Tue, 12 Mar 2024 20:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA5E1428F8;
	Tue, 12 Mar 2024 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ty185xmY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAE81420DF
	for <cgroups@vger.kernel.org>; Tue, 12 Mar 2024 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710274293; cv=none; b=t9837H5U++GnzLBleeP/4+1Bk3K2MB2EzTkRcwARQZjCwe1oMX1TfSkYGO7ovo/KgBOth2jksjuAwREwBacCocHBR9PlHW2cwJfuLddD7krsmcmya1tHzDIz2JXilc7C6OwlbZbQ02K2vkD2KKUjVWMsUgrz1N239cnL2DNx1qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710274293; c=relaxed/simple;
	bh=cA87yRqJJwxmkxglQuA6f8G73KJdrvRpBLSuoXJ8JDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjCLbDlczn0NUX47oHIzRtrHcFPv5q9a/hnoJm0xk6iJBUaNMbypIfr83gG4hEni5RT/GNVdEGT1O3BpGHDQZbtN2lTVOZUgEeZNxky/hQn7hoFy0KnTfKvZXiQNMK8T7N82rVIw/95TNWBeEfWgtAsNXWaSvrZsnJMvo13kvsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ty185xmY; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3663528c0a5so29715ab.0
        for <cgroups@vger.kernel.org>; Tue, 12 Mar 2024 13:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710274290; x=1710879090; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gtyufjympz261LAYpMFsuxxNb0cIyOumJAAy8HMFSng=;
        b=Ty185xmY2v2QrjX8pRIfWJSYrmLxXSGZePtuMAsf/udI58ObvGa3Dpqr7f+2xXjllE
         mwmvWqaUbwBDTffCHjRP4T7PQLNW+XN1YmqdGSoZufJuTKJSwR+yVrkhwmo0ZSmTQfMN
         KTAUKpxLiYcDZ4BkDwAvVnHV1xq4rNV5hulFm6dxeXbjHyTKpBpNGOzItQzaLd4Yt3Xu
         RG4mpHxgQKxwC4FomtNSUjPrddTE7dm8+WMUbcSKeeWP1NyY80fIoMtAnxbaiUErnEDA
         llF0dH9323RUPMI0cRsPWAC2w++02Q33mcuMrm4NsVvaZ1xXFUyn6nGjmP6HP7ZAw5Fg
         1O3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710274290; x=1710879090;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gtyufjympz261LAYpMFsuxxNb0cIyOumJAAy8HMFSng=;
        b=twfzSuNpG3KmEVDLfJM+Xwf/Z8gffeyhRYjmACevh0Ib19ehY/DPGZF7TAeieUENXX
         ZNKF9B6fPCDzuJhZE5OycCbfssWz/KF3Icn3YRZwDGO4WiVLKMhCKvJ6tyLZAiWeTsXi
         U4YwxgU8BWYBFgQS/1TJC4D3xwmKx6itYhcYUJhWind4j/CUwFStk0sCy+kRpNWO+fO6
         36f8Pfa7PG9ZPoZvL/09Byvhe9/5tSj+nzELPrcnKg2eySB5O6k+anE6Yzm85WFf5GRg
         koDrtzpl7TQ+WaAUd56dySl3Yr8UKx8OlqsMJ7XoltJmJHfhUvE6FMK0xz6aPGuWUsvg
         U/7w==
X-Forwarded-Encrypted: i=1; AJvYcCUka7qhnGxKJWtKh4N1WrJpuMthZ4FyTOVX5ltHopY5J9+7y1GCCKMmQXAAxDNDMp7GXwXei5RUOfFiRzGICc17pKPjOfDfSw==
X-Gm-Message-State: AOJu0YzWR/Snsb9B2ZbemnHkkbaSyf6+R65sl1ul/c+9h/VdhH5raR3k
	OW4d0s/srkgH4FQ+YGdJeTe6pZo9JKoJ0V9aWLMJQeNj6LEOWQ7Y2MqwE6MNIQ==
X-Google-Smtp-Source: AGHT+IGJ79aNGwwMiN/XE1qv+e3S3QKnXAHJweEMjS7wLLVhClpO1ctbpd91SmbTh3SMXUAE9E8ZXQ==
X-Received: by 2002:a05:6e02:20ce:b0:366:5dc2:2843 with SMTP id 14-20020a056e0220ce00b003665dc22843mr79777ilq.14.1710274290030;
        Tue, 12 Mar 2024 13:11:30 -0700 (PDT)
Received: from google.com ([100.64.188.49])
        by smtp.gmail.com with ESMTPSA id fw18-20020a0566381d9200b00476018ee74csm2483211jab.20.2024.03.12.13.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 13:11:28 -0700 (PDT)
Date: Tue, 12 Mar 2024 14:11:23 -0600
From: Yu Zhao <yuzhao@google.com>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, Chris Down <chris@chrisdown.name>,
	cgroups@vger.kernel.org, hannes@cmpxchg.org, kernel-team@fb.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: MGLRU premature memcg OOM on slow writes
Message-ID: <ZfC2612ZYwwxpOmR@google.com>
References: <ZcWOh9u3uqZjNFMa@chrisdown.name>
 <20240229235134.2447718-1-axelrasmussen@google.com>
 <ZeEhvV15IWllPKvM@chrisdown.name>
 <CAJHvVch2qVUDTJjNeSMqLBx0yoEm4zzb=ZXmABbd_5dWGQTpNg@mail.gmail.com>
 <CALOAHbBupMYBMWEzMK2xdhnqwR1C1+mJSrrZC1L0CKE2BMSC+g@mail.gmail.com>
 <CAJHvVcjhUNx8UP9mao4TdvU6xK7isRzazoSU53a4NCcFiYuM-g@mail.gmail.com>
 <ZfC16BikjhupKnVG@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfC16BikjhupKnVG@google.com>

On Tue, Mar 12, 2024 at 02:07:04PM -0600, Yu Zhao wrote:
> On Tue, Mar 12, 2024 at 09:44:19AM -0700, Axel Rasmussen wrote:
> > On Mon, Mar 11, 2024 at 2:11 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > > On Sat, Mar 9, 2024 at 3:19 AM Axel Rasmussen <axelrasmussen@google.com> wrote:
> > > >
> > > > On Thu, Feb 29, 2024 at 4:30 PM Chris Down <chris@chrisdown.name> wrote:
> > > > >
> > > > > Axel Rasmussen writes:
> > > > > >A couple of dumb questions. In your test, do you have any of the following
> > > > > >configured / enabled?
> > > > > >
> > > > > >/proc/sys/vm/laptop_mode
> > > > > >memory.low
> > > > > >memory.min
> > > > >
> > > > > None of these are enabled. The issue is trivially reproducible by writing to
> > > > > any slow device with memory.max enabled, but from the code it looks like MGLRU
> > > > > is also susceptible to this on global reclaim (although it's less likely due to
> > > > > page diversity).
> > > > >
> > > > > >Besides that, it looks like the place non-MGLRU reclaim wakes up the
> > > > > >flushers is in shrink_inactive_list() (which calls wakeup_flusher_threads()).
> > > > > >Since MGLRU calls shrink_folio_list() directly (from evict_folios()), I agree it
> > > > > >looks like it simply will not do this.
> > > > > >
> > > > > >Yosry pointed out [1], where MGLRU used to call this but stopped doing that. It
> > > > > >makes sense to me at least that doing writeback every time we age is too
> > > > > >aggressive, but doing it in evict_folios() makes some sense to me, basically to
> > > > > >copy the behavior the non-MGLRU path (shrink_inactive_list()) has.
> > > > >
> > > > > Thanks! We may also need reclaim_throttle(), depending on how you implement it.
> > > > > Current non-MGLRU behaviour on slow storage is also highly suspect in terms of
> > > > > (lack of) throttling after moving away from VMSCAN_THROTTLE_WRITEBACK, but one
> > > > > thing at a time :-)
> > > >
> > > >
> > > > Hmm, so I have a patch which I think will help with this situation,
> > > > but I'm having some trouble reproducing the problem on 6.8-rc7 (so
> > > > then I can verify the patch fixes it).
> > >
> > > We encountered the same premature OOM issue caused by numerous dirty pages.
> > > The issue disappears after we revert the commit 14aa8b2d5c2e
> > > "mm/mglru: don't sync disk for each aging cycle"
> > >
> > > To aid in replicating the issue, we've developed a straightforward
> > > script, which consistently reproduces it, even on the latest kernel.
> > > You can find the script provided below:
> > >
> > > ```
> > > #!/bin/bash
> > >
> > > MEMCG="/sys/fs/cgroup/memory/mglru"
> > > ENABLE=$1
> > >
> > > # Avoid waking up the flusher
> > > sysctl -w vm.dirty_background_bytes=$((1024 * 1024 * 1024 *4))
> > > sysctl -w vm.dirty_bytes=$((1024 * 1024 * 1024 *4))
> > >
> > > if [ ! -d ${MEMCG} ]; then
> > >         mkdir -p ${MEMCG}
> > > fi
> > >
> > > echo $$ > ${MEMCG}/cgroup.procs
> > > echo 1g > ${MEMCG}/memory.limit_in_bytes
> > >
> > > if [ $ENABLE -eq 0 ]; then
> > >         echo 0 > /sys/kernel/mm/lru_gen/enabled
> > > else
> > >         echo 0x7 > /sys/kernel/mm/lru_gen/enabled
> > > fi
> > >
> > > dd if=/dev/zero of=/data0/mglru.test bs=1M count=1023
> > > rm -rf /data0/mglru.test
> > > ```
> > >
> > > This issue disappears as well after we disable the mglru.
> > >
> > > We hope this script proves helpful in identifying and addressing the
> > > root cause. We eagerly await your insights and proposed fixes.
> > 
> > Thanks Yafang, I was able to reproduce the issue using this script.
> > 
> > Perhaps interestingly, I was not able to reproduce it with cgroupv2
> > memcgs. I know writeback semantics are quite a bit different there, so
> > perhaps that explains why.
> > 
> > Unfortunately, it also reproduces even with the commit I had in mind
> > (basically stealing the "if (all isolated pages are unqueued dirty) {
> > wakeup_flusher_threads(); reclaim_throttle(); }" from
> > shrink_inactive_list, and adding it to MGLRU's evict_folios()). So
> > I'll need to spend some more time on this; I'm planning to send
> > something out for testing next week.
> 
> Hi Chris,
> 
> My apologies for not getting back to you sooner.
> 
> And thanks everyone for all the input!
> 
> My take is that Chris' premature OOM kills were NOT really due to
> the flusher not waking up or missing throttling.
> 
> Yes, these two are among the differences between the active/inactive
> LRU and MGLRU, but their roles, IMO, are not as important as the LRU
> positions of dirty pages. The active/inactive LRU moves dirty pages
> all the way to the end of the line (reclaim happens at the front)
> whereas MGLRU moves them into the middle, during direct reclaim. The
> rationale for MGLRU was that this way those dirty pages would still
> be counted as "inactive" (or cold).
> 
> This theory can be quickly verified by comparing how much
> nr_vmscan_immediate_reclaim grows, i.e.,
> 
>   Before the copy
>     grep nr_vmscan_immediate_reclaim /proc/vmstat
>   And then after the copy
>     grep nr_vmscan_immediate_reclaim /proc/vmstat
> 
> The growth should be trivial for MGLRU and nontrivial for the
> active/inactive LRU.
> 
> If this is indeed the case, I'd appreciate very much if anyone could
> try the following (I'll try it myself too later next week).
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4255619a1a31..020f5d98b9a1 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4273,10 +4273,13 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
>  	}
>  
>  	/* waiting for writeback */
> -	if (folio_test_locked(folio) || folio_test_writeback(folio) ||
> -	    (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
> -		gen = folio_inc_gen(lruvec, folio, true);
> -		list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
> +	if (folio_test_writeback(folio) || (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
> +		DEFINE_MAX_SEQ(lruvec);
> +		int old_gen, new_gen = lru_gen_from_seq(max_seq);
> +
> +		old_gen = folio_update_gen(folio, new_gen);
> +		lru_gen_update_size(lruvec, folio, old_gen, new_gen);
> +		list_move(&folio->lru, &lrugen->folios[new_gen][type][zone]);

Sorry missing one line here:

 +		folio_set_reclaim(folio);

>  		return true;
>  	}
>  
> > > > If I understand the issue right, all we should need to do is get a
> > > > slow filesystem, and then generate a bunch of dirty file pages on it,
> > > > while running in a tightly constrained memcg. To that end, I tried the
> > > > following script. But, in reality I seem to get little or no
> > > > accumulation of dirty file pages.
> > > >
> > > > I thought maybe fio does something different than rsync which you said
> > > > you originally tried, so I also tried rsync (copying /usr/bin into
> > > > this loop mount) and didn't run into an OOM situation either.
> > > >
> > > > Maybe some dirty ratio settings need tweaking or something to get the
> > > > behavior you see? Or maybe my test has a dumb mistake in it. :)
> > > >
> > > >
> > > >
> > > > #!/usr/bin/env bash
> > > >
> > > > echo 0 > /proc/sys/vm/laptop_mode || exit 1
> > > > echo y > /sys/kernel/mm/lru_gen/enabled || exit 1
> > > >
> > > > echo "Allocate disk image"
> > > > IMAGE_SIZE_MIB=1024
> > > > IMAGE_PATH=/tmp/slow.img
> > > > dd if=/dev/zero of=$IMAGE_PATH bs=1024k count=$IMAGE_SIZE_MIB || exit 1
> > > >
> > > > echo "Setup loop device"
> > > > LOOP_DEV=$(losetup --show --find $IMAGE_PATH) || exit 1
> > > > LOOP_BLOCKS=$(blockdev --getsize $LOOP_DEV) || exit 1
> > > >
> > > > echo "Create dm-slow"
> > > > DM_NAME=dm-slow
> > > > DM_DEV=/dev/mapper/$DM_NAME
> > > > echo "0 $LOOP_BLOCKS delay $LOOP_DEV 0 100" | dmsetup create $DM_NAME || exit 1
> > > >
> > > > echo "Create fs"
> > > > mkfs.ext4 "$DM_DEV" || exit 1
> > > >
> > > > echo "Mount fs"
> > > > MOUNT_PATH="/tmp/$DM_NAME"
> > > > mkdir -p "$MOUNT_PATH" || exit 1
> > > > mount -t ext4 "$DM_DEV" "$MOUNT_PATH" || exit 1
> > > >
> > > > echo "Generate dirty file pages"
> > > > systemd-run --wait --pipe --collect -p MemoryMax=32M \
> > > >         fio -name=writes -directory=$MOUNT_PATH -readwrite=randwrite \
> > > >         -numjobs=10 -nrfiles=90 -filesize=1048576 \
> > > >         -fallocate=posix \
> > > >         -blocksize=4k -ioengine=mmap \
> > > >         -direct=0 -buffered=1 -fsync=0 -fdatasync=0 -sync=0 \
> > > >         -runtime=300 -time_based

