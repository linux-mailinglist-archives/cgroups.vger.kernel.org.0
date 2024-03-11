Return-Path: <cgroups+bounces-2024-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975A6877C4A
	for <lists+cgroups@lfdr.de>; Mon, 11 Mar 2024 10:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02A6AB20AAC
	for <lists+cgroups@lfdr.de>; Mon, 11 Mar 2024 09:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A38414275;
	Mon, 11 Mar 2024 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ju28+9JR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D161401E;
	Mon, 11 Mar 2024 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148305; cv=none; b=GJySmhTIoFc9zSbFQcGDb8AXbkIfDG3nXZ44EhkV9BqiPoxIefcABvu8a3phlVzbkrOmwJOxO9j9LeOtN6Oxhei6rbKdKbzrqsWIOazWCFEx6DpNDpWBYUy7ydbsJEXfUsCdGWNdy/CJR0ZdvhBo2HYgLjaqzUeVU7RG3C47dyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148305; c=relaxed/simple;
	bh=bQycjD3Nt7s486XLfov6DBezJbQVxS3qMWOSqeVVRFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AkKR2EK7VnOiCOrlhUdSZBO+ZuJo0TpeTtwegarzfocO1EC1Byd9UEKXVnGIGdBzs5mNAqgXkUXSbYX63NYXApbBx+MlFac4sC8NiF3S1RunT+ZeygE7bHC4jMSUn9BS0+hlgXny6suL2L6OeFc4ZNMcMPni61Z39pgnn/xGSm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ju28+9JR; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7cedcea89a0so2728973241.1;
        Mon, 11 Mar 2024 02:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710148303; x=1710753103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qvSkoWG3hG+H8BATALROwaa3X2nvmLzNfY2hVRikCs=;
        b=Ju28+9JRSFBYJdKkowGB1F8BLGRWwxS2DsFMFaEYZMDQM/czaDsCUrdn6ykl4LXoWs
         ixYic1jVTk3DKFNv2HYgcD26+XE2kl81vv++yX1BgCim9MIbQoRorfLotawVdZccaswt
         2X0/7SMd76YOX1iRxvuwxgzrWR28thg8i9QMa5Gkf+h1db92fNJQpkits0KPDrgnI66O
         j6GWGCpACHtgUvG7Qcg7MfckYwlupJEkjPU8nWSTA7EbxbtIQ3n0RauTiZNZAFcRkLzU
         MOzeC/Q0NClU0lAtfwAq7iUFMF70/OEhRGnihKMv8EqPZ8g7YEqOmWZTHSgYNJCdGS5h
         W/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710148303; x=1710753103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qvSkoWG3hG+H8BATALROwaa3X2nvmLzNfY2hVRikCs=;
        b=RIuiiaBeaqRypjVSHweHaU9hJI6DslRjHC+kBVYoaZy65JuBV/wSj0XzWpP53qM4rd
         9n7wKeTiru04xklqR0skQkjYhlg3xF0QsgykL7CYZKZZM0IHh+c2YKZ9BOq5b9/Bskag
         pChskKChmWcWvTQBFd9RdmS5srF7nybhw9UzUmhlT9Rli330Sm2zCNsU7oHdM6jnh7As
         ruwa/M3HN4/cxqOHUO1kcqh6oiZOGEWQZ30O1XxPAlYInbyJ9kApBV6BLM1Ax5TqgovP
         +J4+dbfziyABgUGvUMrmxblMW+sO7N+2c7bDdje/5us5wFbKvT7T8ZL2YN4wFCUPC2Kz
         sHbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0tMif3x7OLyFqeHaw5oy1re2kaPhPR/EjFDT97iWarvhXDHAgiJrX6w+es65kEFV/ibivNVrq36II1bbgFrtHjQOVRA7JyQ6GMhSsarG8fjP+hLp10OemHSo0DM8cAYvDdE4qdQ==
X-Gm-Message-State: AOJu0Yx0qwcZrsnfr7EWFfpHv/tg+20HLrXCwKZgpBciaDMJqBxUkOT8
	dSxkpvemnANiF50lZvvSKAkmoCujYkd51ZkFlHdZX3ppFj6FvzIjhpe/nfLLE+rV/oks9rdmYZR
	88nCvoGhxPobyKrfrZ4s3Vg7YnLaF9XT6iF2Jq7qdZsY=
X-Google-Smtp-Source: AGHT+IGhj+x8PbYBec92s0jPkmQjnzq8HzpZbtjL6JMxo4ac2s/kS8iToRyYZSqvmkrMguR+LbUdOyKos2a5RyaKjr8=
X-Received: by 2002:a05:6102:1814:b0:473:df7:1084 with SMTP id
 jg20-20020a056102181400b004730df71084mr3630428vsb.29.1710148303200; Mon, 11
 Mar 2024 02:11:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZcWOh9u3uqZjNFMa@chrisdown.name> <20240229235134.2447718-1-axelrasmussen@google.com>
 <ZeEhvV15IWllPKvM@chrisdown.name> <CAJHvVch2qVUDTJjNeSMqLBx0yoEm4zzb=ZXmABbd_5dWGQTpNg@mail.gmail.com>
In-Reply-To: <CAJHvVch2qVUDTJjNeSMqLBx0yoEm4zzb=ZXmABbd_5dWGQTpNg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 11 Mar 2024 17:11:06 +0800
Message-ID: <CALOAHbBupMYBMWEzMK2xdhnqwR1C1+mJSrrZC1L0CKE2BMSC+g@mail.gmail.com>
Subject: Re: MGLRU premature memcg OOM on slow writes
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Chris Down <chris@chrisdown.name>, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	kernel-team@fb.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 9, 2024 at 3:19=E2=80=AFAM Axel Rasmussen <axelrasmussen@google=
.com> wrote:
>
> On Thu, Feb 29, 2024 at 4:30=E2=80=AFPM Chris Down <chris@chrisdown.name>=
 wrote:
> >
> > Axel Rasmussen writes:
> > >A couple of dumb questions. In your test, do you have any of the follo=
wing
> > >configured / enabled?
> > >
> > >/proc/sys/vm/laptop_mode
> > >memory.low
> > >memory.min
> >
> > None of these are enabled. The issue is trivially reproducible by writi=
ng to
> > any slow device with memory.max enabled, but from the code it looks lik=
e MGLRU
> > is also susceptible to this on global reclaim (although it's less likel=
y due to
> > page diversity).
> >
> > >Besides that, it looks like the place non-MGLRU reclaim wakes up the
> > >flushers is in shrink_inactive_list() (which calls wakeup_flusher_thre=
ads()).
> > >Since MGLRU calls shrink_folio_list() directly (from evict_folios()), =
I agree it
> > >looks like it simply will not do this.
> > >
> > >Yosry pointed out [1], where MGLRU used to call this but stopped doing=
 that. It
> > >makes sense to me at least that doing writeback every time we age is t=
oo
> > >aggressive, but doing it in evict_folios() makes some sense to me, bas=
ically to
> > >copy the behavior the non-MGLRU path (shrink_inactive_list()) has.
> >
> > Thanks! We may also need reclaim_throttle(), depending on how you imple=
ment it.
> > Current non-MGLRU behaviour on slow storage is also highly suspect in t=
erms of
> > (lack of) throttling after moving away from VMSCAN_THROTTLE_WRITEBACK, =
but one
> > thing at a time :-)
>
>
> Hmm, so I have a patch which I think will help with this situation,
> but I'm having some trouble reproducing the problem on 6.8-rc7 (so
> then I can verify the patch fixes it).

We encountered the same premature OOM issue caused by numerous dirty pages.
The issue disappears after we revert the commit 14aa8b2d5c2e
"mm/mglru: don't sync disk for each aging cycle"

To aid in replicating the issue, we've developed a straightforward
script, which consistently reproduces it, even on the latest kernel.
You can find the script provided below:

```
#!/bin/bash

MEMCG=3D"/sys/fs/cgroup/memory/mglru"
ENABLE=3D$1

# Avoid waking up the flusher
sysctl -w vm.dirty_background_bytes=3D$((1024 * 1024 * 1024 *4))
sysctl -w vm.dirty_bytes=3D$((1024 * 1024 * 1024 *4))

if [ ! -d ${MEMCG} ]; then
        mkdir -p ${MEMCG}
fi

echo $$ > ${MEMCG}/cgroup.procs
echo 1g > ${MEMCG}/memory.limit_in_bytes

if [ $ENABLE -eq 0 ]; then
        echo 0 > /sys/kernel/mm/lru_gen/enabled
else
        echo 0x7 > /sys/kernel/mm/lru_gen/enabled
fi

dd if=3D/dev/zero of=3D/data0/mglru.test bs=3D1M count=3D1023
rm -rf /data0/mglru.test
```

This issue disappears as well after we disable the mglru.

We hope this script proves helpful in identifying and addressing the
root cause. We eagerly await your insights and proposed fixes.

>
> If I understand the issue right, all we should need to do is get a
> slow filesystem, and then generate a bunch of dirty file pages on it,
> while running in a tightly constrained memcg. To that end, I tried the
> following script. But, in reality I seem to get little or no
> accumulation of dirty file pages.
>
> I thought maybe fio does something different than rsync which you said
> you originally tried, so I also tried rsync (copying /usr/bin into
> this loop mount) and didn't run into an OOM situation either.
>
> Maybe some dirty ratio settings need tweaking or something to get the
> behavior you see? Or maybe my test has a dumb mistake in it. :)
>
>
>
> #!/usr/bin/env bash
>
> echo 0 > /proc/sys/vm/laptop_mode || exit 1
> echo y > /sys/kernel/mm/lru_gen/enabled || exit 1
>
> echo "Allocate disk image"
> IMAGE_SIZE_MIB=3D1024
> IMAGE_PATH=3D/tmp/slow.img
> dd if=3D/dev/zero of=3D$IMAGE_PATH bs=3D1024k count=3D$IMAGE_SIZE_MIB || =
exit 1
>
> echo "Setup loop device"
> LOOP_DEV=3D$(losetup --show --find $IMAGE_PATH) || exit 1
> LOOP_BLOCKS=3D$(blockdev --getsize $LOOP_DEV) || exit 1
>
> echo "Create dm-slow"
> DM_NAME=3Ddm-slow
> DM_DEV=3D/dev/mapper/$DM_NAME
> echo "0 $LOOP_BLOCKS delay $LOOP_DEV 0 100" | dmsetup create $DM_NAME || =
exit 1
>
> echo "Create fs"
> mkfs.ext4 "$DM_DEV" || exit 1
>
> echo "Mount fs"
> MOUNT_PATH=3D"/tmp/$DM_NAME"
> mkdir -p "$MOUNT_PATH" || exit 1
> mount -t ext4 "$DM_DEV" "$MOUNT_PATH" || exit 1
>
> echo "Generate dirty file pages"
> systemd-run --wait --pipe --collect -p MemoryMax=3D32M \
>         fio -name=3Dwrites -directory=3D$MOUNT_PATH -readwrite=3Drandwrit=
e \
>         -numjobs=3D10 -nrfiles=3D90 -filesize=3D1048576 \
>         -fallocate=3Dposix \
>         -blocksize=3D4k -ioengine=3Dmmap \
>         -direct=3D0 -buffered=3D1 -fsync=3D0 -fdatasync=3D0 -sync=3D0 \
>         -runtime=3D300 -time_based
>


--=20
Regards
Yafang

