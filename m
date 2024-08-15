Return-Path: <cgroups+bounces-4292-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F859527C2
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 04:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 362CEB218EB
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 02:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D867CB676;
	Thu, 15 Aug 2024 01:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWturdic"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983F910F1;
	Thu, 15 Aug 2024 01:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723687198; cv=none; b=Tj+1w4kCTARIRkosnPeXjJsn7sfVERmxQqjdBZRT43kBfGk+Af1Xj0QE19PObLmt4GD95twSVgUWQE8QHQU98r9uTgaWDUumTQKVTE3YUcc3rgjAYTky/jHsinjHKZB5k4q56XnIc5+U1+Q26Ca0IbEmOBCR5por0XFMOH/mnAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723687198; c=relaxed/simple;
	bh=P8cL7PJL3H6XupR00I33XgtMFOknii2H/OBA/mUEbqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hMd9snJ1UArI8lcOcM321chv79aY75L5bgj3b1lt0qmIemyf8i8NPc6ovO/KLnJVToYqp0+hRnGagL/Bhq4cTB8NHTpZ1XgQ1UFTLIH+gX+KfBYWWTA7SmJcEyEEEPBj7KzubfPpan+PXFQ8yu//xnBxNNxGPVydEwuiGoc15gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWturdic; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5af326eddb2so2470694a12.1;
        Wed, 14 Aug 2024 18:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723687195; x=1724291995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5M2kShGXyDR1Geq5rz4axGkWcle2bfeUFW2zqe1cx8=;
        b=fWturdic7XoPKrJgRWTbdUiwHFiNI8lbdO4t8y4PjbCFdu0p4mV8kXimw8+/qUNDmJ
         nl5CzrsJW612Uzw/A+V/GpfpSnTQ+DtIP8LQ2OCldrAV5+U8//mcIJLX7rTrRzbq2fPO
         YDRBzYLoqtfKa1CSWxL/wvGFp7E6y6qx+5yT8q/+by2oBCd0R3IpI+LIO3bokvKV+fzs
         0b+kU+gb5j0EUH1BpQKDpSG4m/x/CkpYPUVJlq1eEpWQEym09jGln5h2hXy8QBcg0eLv
         f40+5HuiXJAAkQCI6uPS3TmKZRWBYhxQKePtc2NcGCk0A1ZPsBj6r/AiLS3NYNtbrB2S
         i+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723687195; x=1724291995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5M2kShGXyDR1Geq5rz4axGkWcle2bfeUFW2zqe1cx8=;
        b=eMc8qEBqYym5yjpbbBLAcaryXUCbkadgxI0vt8i6+uSiuV+sRD8MkaB3mSMSYA0N18
         PYQtw5LJr77Wd3tgEi4Y/tAkU509XLei0JcMYYfa7kWD8PS1GdiBk/ih4LKAyhT8ZUln
         0VONxFcpXaT1TGaly9Y36HscdV9XTOG2bEM1LVD1hZvQCTo3b5zf5YhRTgiyM1Mmx4PU
         QE19WvfOrOTuWIbMz9C36iBIPuFeoV84Vf9ATyLv9816Bfw1jQgcqg7jFU+Q4joikiIF
         200qY29iQjCl9e6+hnsVCFuipWOaaJnZW4+0BHv7NWHqeyFDgC149ITAqXF+TM64ljjH
         3pjg==
X-Forwarded-Encrypted: i=1; AJvYcCWpYHDtErl1sxj8nSHuhzut1rWIMgaAlcv3wlKt7CtuU0GMQ+acNHwg78SI+8sG7u8jp1XnDRsKMN02Jmo8Wh8GOxWRe0/DmTcsNl3dtpPdoUj6PmZJ+z2M1MfmBhmMM1fgDbGn3MpMoy35PncCy34CqDBnj885eultHnA7zd0+zc4+
X-Gm-Message-State: AOJu0YzId3AxebSa3x3/Rv7CLDyJ/s3T6DKP9kYlX2Kmo+9pi15uwf7k
	6cOPjIF33MK5RLqk2NGfLp0o8BGUzgHA2Iho0+1FgTezi8T/zNoOY40tzoqc2GOClmKc79+4kGx
	G61qpJzVWh4b3sZ7fTbWxUozOxfU=
X-Google-Smtp-Source: AGHT+IHyI3/Gx6+mN8IuZMBEsk36H0MA/+wRoo1GrXR1EOE3B074mBwM2t1Ui0ouHOwYM+zv6eMsbiK7yY4mAZdY6oA=
X-Received: by 2002:a05:6402:26d0:b0:57d:3e48:165d with SMTP id
 4fb4d7f45d1cf-5beb3a5b193mr1306075a12.4.1723687194447; Wed, 14 Aug 2024
 18:59:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812150049.8252-1-ioworker0@gmail.com> <zjbn575huc6pk7jpv2ipoayfk4bvfu5z5imb5muk5drksa7p3q@xcr5imtt4zro>
 <9ede36af-fca4-ed41-6b7e-cef157c640bb@huaweicloud.com> <CAK1f24mwzXa8Az5WFYu+1UopTCStDWx3yDr1RugLwphS-hWizw@mail.gmail.com>
 <eef1f655-4fff-618d-4b8e-447230ec8ed9@huaweicloud.com> <7c3499ac-faa7-cc0c-2d90-b8291fce5492@huaweicloud.com>
In-Reply-To: <7c3499ac-faa7-cc0c-2d90-b8291fce5492@huaweicloud.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 15 Aug 2024 09:59:18 +0800
Message-ID: <CAK1f24kx7W=aQEodg4eyii6R8a4e-f3MfCbB4ozAV3AV6urdTg@mail.gmail.com>
Subject: Re: [BUG] cgroupv2/blk: inconsistent I/O behavior in Cgroup v2 with
 set device wbps and wiops
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	cgroups@vger.kernel.org, josef@toxicpanda.com, tj@kernel.org, 
	fujita.tomonori@lab.ntt.co.jp, boqun.feng@gmail.com, a.hindborg@samsung.com, 
	paolo.valente@unimore.it, axboe@kernel.dk, vbabka@kernel.org, 
	david@redhat.com, 21cnbao@gmail.com, baolin.wang@linux.alibaba.com, 
	libang.li@antgroup.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 3:19=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2024/08/13 14:39, Yu Kuai =E5=86=99=E9=81=93:
> > Hi,
> >
> > =E5=9C=A8 2024/08/13 13:00, Lance Yang =E5=86=99=E9=81=93:
> >> Hi Kuai,
> >>
> >> Thanks a lot for jumping in!
> >>
> >> On Tue, Aug 13, 2024 at 9:37=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.c=
om> wrote:
> >>>
> >>> Hi,
> >>>
> >>> =E5=9C=A8 2024/08/12 23:43, Michal Koutn=C3=BD =E5=86=99=E9=81=93:
> >>>> +Cc Kuai
> >>>>
> >>>> On Mon, Aug 12, 2024 at 11:00:30PM GMT, Lance Yang
> >>>> <ioworker0@gmail.com> wrote:
> >>>>> Hi all,
> >>>>>
> >>>>> I've run into a problem with Cgroup v2 where it doesn't seem to
> >>>>> correctly limit
> >>>>> I/O operations when I set both wbps and wiops for a device.
> >>>>> However, if I only
> >>>>> set wbps, then everything works as expected.
> >>>>>
> >>>>> To reproduce the problem, we can follow these command-based steps:
> >>>>>
> >>>>> 1. **System Information:**
> >>>>>      - Kernel Version and OS Release:
> >>>>>        ```
> >>>>>        $ uname -r
> >>>>>        6.10.0-rc5+
> >>>>>
> >>>>>        $ cat /etc/os-release
> >>>>>        PRETTY_NAME=3D"Ubuntu 24.04 LTS"
> >>>>>        NAME=3D"Ubuntu"
> >>>>>        VERSION_ID=3D"24.04"
> >>>>>        VERSION=3D"24.04 LTS (Noble Numbat)"
> >>>>>        VERSION_CODENAME=3Dnoble
> >>>>>        ID=3Dubuntu
> >>>>>        ID_LIKE=3Ddebian
> >>>>>        HOME_URL=3D"https://www.ubuntu.com/"
> >>>>>        SUPPORT_URL=3D"https://help.ubuntu.com/"
> >>>>>        BUG_REPORT_URL=3D"https://bugs.launchpad.net/ubuntu/"
> >>>>>
> >>>>> PRIVACY_POLICY_URL=3D"https://www.ubuntu.com/legal/terms-and-polici=
es/privacy-policy"
> >>>>>
> >>>>>        UBUNTU_CODENAME=3Dnoble
> >>>>>        LOGO=3Dubuntu-logo
> >>>>>        ```
> >>>>>
> >>>>> 2. **Device Information and Settings:**
> >>>>>      - List Block Devices and Scheduler:
> >>>>>        ```
> >>>>>        $ lsblk
> >>>>>        NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
> >>>>>        sda     8:0    0   4.4T  0 disk
> >>>>>        =E2=94=94=E2=94=80sda1  8:1    0   4.4T  0 part /data
> >>>>>        ...
> >>>>>
> >>>>>        $ cat /sys/block/sda/queue/scheduler
> >>>>>        none [mq-deadline] kyber bfq
> >>>>>
> >>>>>        $ cat /sys/block/sda/queue/rotational
> >>>>>        1
> >>>>>        ```
> >>>>>
> >>>>> 3. **Reproducing the problem:**
> >>>>>      - Navigate to the cgroup v2 filesystem and configure I/O
> >>>>> settings:
> >>>>>        ```
> >>>>>        $ cd /sys/fs/cgroup/
> >>>>>        $ stat -fc %T /sys/fs/cgroup
> >>>>>        cgroup2fs
> >>>>>        $ mkdir test
> >>>>>        $ echo "8:0 wbps=3D10485760 wiops=3D100000" > io.max
> >>>>>        ```
> >>>>>        In this setup:
> >>>>>        wbps=3D10485760 sets the write bytes per second limit to 10 =
MB/s.
> >>>>>        wiops=3D100000 sets the write I/O operations per second limi=
t
> >>>>> to 100,000.
> >>>>>
> >>>>>      - Add process to the cgroup and verify:
> >>>>>        ```
> >>>>>        $ echo $$ > cgroup.procs
> >>>>>        $ cat cgroup.procs
> >>>>>        3826771
> >>>>>        3828513
> >>>>>        $ ps -ef|grep 3826771
> >>>>>        root     3826771 3826768  0 22:04 pts/1    00:00:00 -bash
> >>>>>        root     3828761 3826771  0 22:06 pts/1    00:00:00 ps -ef
> >>>>>        root     3828762 3826771  0 22:06 pts/1    00:00:00 grep
> >>>>> --color=3Dauto 3826771
> >>>>>        ```
> >>>>>
> >>>>>      - Observe I/O performance using `dd` commands and `iostat`:
> >>>>>        ```
> >>>>>        $ dd if=3D/dev/zero of=3D/data/file1 bs=3D512M count=3D1 &
> >>>>>        $ dd if=3D/dev/zero of=3D/data/file1 bs=3D512M count=3D1 &
> >>>
> >>> You're testing buffer IO here, and I don't see that write back cgroup=
 is
> >>> enabled. Is this test intentional? Why not test direct IO?
> >>
> >> Yes, I was testing buffered I/O and can confirm that
> >> CONFIG_CGROUP_WRITEBACK
> >> was enabled.
> >>
> >> $ cat /boot/config-6.10.0-rc5+ |grep CONFIG_CGROUP_WRITEBACK
> >> CONFIG_CGROUP_WRITEBACK=3Dy
> >>
> >> We intend to configure both wbps (write bytes per second) and wiops
> >> (write I/O operations
> >> per second) for the containers. IIUC, this setup will effectively
> >> restrict both their block device
> >> I/Os and buffered I/Os.
> >>
> >>> Why not test direct IO?
> >>
> >> I was testing direct IO as well. However it did not work as expected w=
ith
> >> `echo "8:0 wbps=3D10485760 wiops=3D100000" > io.max`.
> >>
> >> $ time dd if=3D/dev/zero of=3D/data/file7 bs=3D512M count=3D1 oflag=3D=
direct
> >
> > So, you're issuing one huge IO, with 512M.
> >> 1+0 records in
> >> 1+0 records out
> >> 536870912 bytes (537 MB, 512 MiB) copied, 51.5962 s, 10.4 MB/s
> >
> > And this result looks correct. Please noted that blk-throtl works befor=
e
> > IO submit, while iostat reports IO that are done. A huge IO can be
> > throttled for a long time.
> >>
> >> real 0m51.637s
> >> user 0m0.000s
> >> sys 0m0.313s
> >>
> >> $ iostat -d 1 -h -y -p sda
> >>   tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
> >> kB_dscd Device
> >>       9.00         0.0k         1.3M         0.0k       0.0k       1.3=
M
> >>        0.0k sda
> >>       9.00         0.0k         1.3M         0.0k       0.0k       1.3=
M
> >>        0.0k sda1
> >
> > I don't understand yet is why there are few IO during the wait. Can you
> > test for a raw disk to bypass filesystem?
>
> To be updated, I add a debug patch for this:

Kuai, sorry for the delayed response ;(

I'll give this debug patch a try and do other tests for a raw disk to bypas=
s
the file system as well, and get back to you ASAP.

Thanks a lot for reaching out!
Lance

>
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index dc6140fa3de0..3b2648c17079 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -1119,8 +1119,10 @@ static void blk_throtl_dispatch_work_fn(struct
> work_struct *work)
>
>          if (!bio_list_empty(&bio_list_on_stack)) {
>                  blk_start_plug(&plug);
> -               while ((bio =3D bio_list_pop(&bio_list_on_stack)))
> +               while ((bio =3D bio_list_pop(&bio_list_on_stack))) {
> +                       printk("%s: bio done %lu %px\n", __func__,
> bio_sectors(bio), bio);
>                          submit_bio_noacct_nocheck(bio);
> +               }
>                  blk_finish_plug(&plug);
>          }
>   }
> @@ -1606,6 +1608,8 @@ bool __blk_throtl_bio(struct bio *bio)
>          bool throttled =3D false;
>          struct throtl_data *td =3D tg->td;
>
> +       printk("%s: bio start %lu %px\n", __func__, bio_sectors(bio), bio=
);
> +
>          rcu_read_lock();
>          spin_lock_irq(&q->queue_lock);
>          sq =3D &tg->service_queue;
> @@ -1649,6 +1653,7 @@ bool __blk_throtl_bio(struct bio *bio)
>                  tg =3D sq_to_tg(sq);
>                  if (!tg) {
>                          bio_set_flag(bio, BIO_BPS_THROTTLED);
> +                       printk("%s: bio done %lu %px\n", __func__,
> bio_sectors(bio), bio);
>                          goto out_unlock;
>                  }
>          }
>
> For dirct IO with raw disk:
>
> with or without wiops, the result is the same:
>
> [  469.736098] __blk_throtl_bio: bio start 2128 ffff8881014c08c0
> [  469.736903] __blk_throtl_bio: bio start 2144 ffff88817852ec80
> [  469.737585] __blk_throtl_bio: bio start 2096 ffff88817852f080
> [  469.738392] __blk_throtl_bio: bio start 2096 ffff88817852f480
> [  469.739358] __blk_throtl_bio: bio start 2064 ffff88817852e880
> [  469.740330] __blk_throtl_bio: bio start 2112 ffff88817852fa80
> [  469.741262] __blk_throtl_bio: bio start 2080 ffff88817852e280
> [  469.742280] __blk_throtl_bio: bio start 2096 ffff88817852e080
> [  469.743281] __blk_throtl_bio: bio start 2104 ffff88817852f880
> [  469.744309] __blk_throtl_bio: bio start 2240 ffff88817852e680
> [  469.745050] __blk_throtl_bio: bio start 2184 ffff88817852e480
> [  469.745857] __blk_throtl_bio: bio start 2120 ffff88817852f680
> [  469.746779] __blk_throtl_bio: bio start 2512 ffff88817852fe80
> [  469.747611] __blk_throtl_bio: bio start 2488 ffff88817852f280
> [  469.748242] __blk_throtl_bio: bio start 2120 ffff88817852ee80
> [  469.749159] __blk_throtl_bio: bio start 2256 ffff88817852fc80
> [  469.750087] __blk_throtl_bio: bio start 2576 ffff88817852ea80
> [  469.750802] __blk_throtl_bio: bio start 2112 ffff8881014a3a80
> [  469.751586] __blk_throtl_bio: bio start 2240 ffff8881014a2880
> [  469.752383] __blk_throtl_bio: bio start 2160 ffff8881014a2e80
> [  469.753289] __blk_throtl_bio: bio start 2248 ffff8881014a3c80
> [  469.754024] __blk_throtl_bio: bio start 2536 ffff8881014a2680
> [  469.754913] __blk_throtl_bio: bio start 2088 ffff8881014a3080
> [  469.766036] __blk_throtl_bio: bio start 211344 ffff8881014a3280
> [  469.842366] blk_throtl_dispatch_work_fn: bio done 2128 ffff8881014c08c=
0
> [  469.952627] blk_throtl_dispatch_work_fn: bio done 2144 ffff88817852ec8=
0
> [  470.048729] blk_throtl_dispatch_work_fn: bio done 2096 ffff88817852f08=
0
> [  470.152642] blk_throtl_dispatch_work_fn: bio done 2096 ffff88817852f48=
0
> [  470.256661] blk_throtl_dispatch_work_fn: bio done 2064 ffff88817852e88=
0
> [  470.360662] blk_throtl_dispatch_work_fn: bio done 2112 ffff88817852fa8=
0
> [  470.464626] blk_throtl_dispatch_work_fn: bio done 2080 ffff88817852e28=
0
> [  470.568652] blk_throtl_dispatch_work_fn: bio done 2096 ffff88817852e08=
0
> [  470.672623] blk_throtl_dispatch_work_fn: bio done 2104 ffff88817852f88=
0
> [  470.776620] blk_throtl_dispatch_work_fn: bio done 2240 ffff88817852e68=
0
> [  470.889801] blk_throtl_dispatch_work_fn: bio done 2184 ffff88817852e48=
0
> [  470.992686] blk_throtl_dispatch_work_fn: bio done 2120 ffff88817852f68=
0
> [  471.112633] blk_throtl_dispatch_work_fn: bio done 2512 ffff88817852fe8=
0
> [  471.232680] blk_throtl_dispatch_work_fn: bio done 2488 ffff88817852f28=
0
> [  471.336695] blk_throtl_dispatch_work_fn: bio done 2120 ffff88817852ee8=
0
> [  471.448645] blk_throtl_dispatch_work_fn: bio done 2256 ffff88817852fc8=
0
> [  471.576632] blk_throtl_dispatch_work_fn: bio done 2576 ffff88817852ea8=
0
> [  471.680709] blk_throtl_dispatch_work_fn: bio done 2112 ffff8881014a3a8=
0
> [  471.792680] blk_throtl_dispatch_work_fn: bio done 2240 ffff8881014a288=
0
> [  471.896682] blk_throtl_dispatch_work_fn: bio done 2160 ffff8881014a2e8=
0
> [  472.008698] blk_throtl_dispatch_work_fn: bio done 2248 ffff8881014a3c8=
0
> [  472.136630] blk_throtl_dispatch_work_fn: bio done 2536 ffff8881014a268=
0
> [  472.240678] blk_throtl_dispatch_work_fn: bio done 2088 ffff8881014a308=
0
> [  482.560633] blk_throtl_dispatch_work_fn: bio done 211344 ffff8881014a3=
280
>
> Hence the upper layer issue some small IO first, then with a 100+MB IO,
> and wait time looks correct.
>
> Then, I retest for xfs, result are still the same with or without wiops:
>
> [ 1175.907019] __blk_throtl_bio: bio start 8192 ffff88816daf8480
> [ 1175.908224] __blk_throtl_bio: bio start 8192 ffff88816daf8e80
> [ 1175.910618] __blk_throtl_bio: bio start 8192 ffff88816daf9280
> [ 1175.911991] __blk_throtl_bio: bio start 8192 ffff88816daf8280
> [ 1175.913187] __blk_throtl_bio: bio start 8192 ffff88816daf9080
> [ 1175.914904] __blk_throtl_bio: bio start 8192 ffff88816daf9680
> [ 1175.916099] __blk_throtl_bio: bio start 8192 ffff88816daf8880
> [ 1175.917844] __blk_throtl_bio: bio start 8192 ffff88816daf8c80
> [ 1175.919025] __blk_throtl_bio: bio start 8192 ffff88816daf8a80
> [ 1175.920868] __blk_throtl_bio: bio start 8192 ffff888178a84080
> [ 1175.922068] __blk_throtl_bio: bio start 8192 ffff888178a84280
> [ 1175.923819] __blk_throtl_bio: bio start 8192 ffff888178a84480
> [ 1175.925017] __blk_throtl_bio: bio start 8192 ffff888178a84680
> [ 1175.926851] __blk_throtl_bio: bio start 8192 ffff888178a84880
> [ 1175.928025] __blk_throtl_bio: bio start 8192 ffff888178a84a80
> [ 1175.929806] __blk_throtl_bio: bio start 8192 ffff888178a84c80
> [ 1175.931007] __blk_throtl_bio: bio start 8192 ffff888178a84e80
> [ 1175.932852] __blk_throtl_bio: bio start 8192 ffff888178a85080
> [ 1175.934041] __blk_throtl_bio: bio start 8192 ffff888178a85280
> [ 1175.935892] __blk_throtl_bio: bio start 8192 ffff888178a85480
> [ 1175.937074] __blk_throtl_bio: bio start 8192 ffff888178a85680
> [ 1175.938860] __blk_throtl_bio: bio start 8192 ffff888178a85880
> [ 1175.940053] __blk_throtl_bio: bio start 8192 ffff888178a85a80
> [ 1175.941824] __blk_throtl_bio: bio start 8192 ffff888178a85c80
> [ 1175.943040] __blk_throtl_bio: bio start 8192 ffff888178a85e80
> [ 1175.944945] __blk_throtl_bio: bio start 8192 ffff88816b046080
> [ 1175.946156] __blk_throtl_bio: bio start 8192 ffff88816b046280
> [ 1175.948261] __blk_throtl_bio: bio start 8192 ffff88816b046480
> [ 1175.949521] __blk_throtl_bio: bio start 8192 ffff88816b046680
> [ 1175.950877] __blk_throtl_bio: bio start 8192 ffff88816b046880
> [ 1175.952051] __blk_throtl_bio: bio start 8192 ffff88816b046a80
> [ 1175.954313] __blk_throtl_bio: bio start 8192 ffff88816b046c80
> [ 1175.955530] __blk_throtl_bio: bio start 8192 ffff88816b046e80
> [ 1175.957370] __blk_throtl_bio: bio start 8192 ffff88816b047080
> [ 1175.958818] __blk_throtl_bio: bio start 8192 ffff88816b047280
> [ 1175.960093] __blk_throtl_bio: bio start 8192 ffff88816b047480
> [ 1175.961900] __blk_throtl_bio: bio start 8192 ffff88816b047680
> [ 1175.963070] __blk_throtl_bio: bio start 8192 ffff88816b047880
> [ 1175.965262] __blk_throtl_bio: bio start 8192 ffff88816b047a80
> [ 1175.966527] __blk_throtl_bio: bio start 8192 ffff88816b047c80
> [ 1175.967928] __blk_throtl_bio: bio start 8192 ffff88816b047e80
> [ 1175.969124] __blk_throtl_bio: bio start 8192 ffff888170e84080
> [ 1175.971369] __blk_throtl_bio: bio start 8192 ffff888170e84280
>
>
> Hence xfs is always issuing 4MB IO, that's whay stable wbps can be
> observed by iostat. The main difference is that a 100+MB IO is issued
> from the last test and throttle for about 10+s.
>
> Then for your case, you might want to comfirm what kind of IO are
> submitted from upper layer.
>
> Thanks,
> Kuai
> >
> > Thanks,
> > Kuai
> >
> >
> > .
> >
>

