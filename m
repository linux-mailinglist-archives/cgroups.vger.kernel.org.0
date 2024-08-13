Return-Path: <cgroups+bounces-4219-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1E694FD00
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 07:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEE51B21DA1
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 05:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4782262B;
	Tue, 13 Aug 2024 05:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enI3KUj9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C961C68C;
	Tue, 13 Aug 2024 05:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723525295; cv=none; b=BV1KGOz/hxoyX5j1lg6TZ7D/XowshiulhVKOEdK0PcurZe+S42qWuiRx4d25L1FjkJDUPNC7Ao3z/eVdPE9mhyKXk3F3knsVS++AbTSpYjbMyLUToFIjB0wFnw2YMGeIDDg0tqb0SxGkAFVNolDRpt90XrmWkHCSZ68nHzHFsBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723525295; c=relaxed/simple;
	bh=PmI29s3jhgufMzm/IjuPdl/MRTADLTlAH7IKB0CZEnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8Jso1HTEMr5fWxJ/cKL81VoD2hJg8oy0vZ7Xcxv7npMaWdRn35T0nBZzjyGHudthW5nnq2tebxxNHCThIlqLaes+pe4ZvyKGTcuvcoBdq4Y77A+r/Yt+s3jbN+YWh+DsnvPqLr/NPEsyhQJuKZmYRqS6xBTKALLSNfo2hhXPvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enI3KUj9; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52f04c29588so1258261e87.3;
        Mon, 12 Aug 2024 22:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723525291; x=1724130091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faS0v3HI+ptxTJXy/8GMg5Iu1t2r0HjJ/yVEjDqFytQ=;
        b=enI3KUj96bpOkV5eehycotahhaCtKCaFToiY2GyC4J9Gbv47lxsvJ2gRO91Higsb/A
         PkRV/l7Yi3D2jSW9hzebFw1kM78yV6NPz7XLUpHwnEaKiU1ggCcjnwXvsg5aHRM4QEfo
         OQwAwXB+IHDIxwyuE+NV0QTvW3Wh3K1gWiJ3CUVmNy7QIIMf8zBagnUJAJJCVfDimKLm
         QaeGzqcp5TT82nVnCnXtp6tqf123sFR44yUBeuW1DbY/C/tQD89bfQx7tBDF9cpl2oxR
         K92uJYCs1B9oSYMKj3evVP0In5Er4UcWLWNVJvrAwxDT4blnnAr0Gahi+bsiUsqGHnNq
         1rrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723525291; x=1724130091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=faS0v3HI+ptxTJXy/8GMg5Iu1t2r0HjJ/yVEjDqFytQ=;
        b=DSugNZ85+NLBkYikzQvLWi+84bhwOPbtFxcHWDa3D2Dlhzd2nGTW65UlXSmqguCAXi
         F8tUo0vogEXJ59mX9WGCSmDhszS8FIzc0bSoI5Ge7cFU/3jG8k1k11ZDCJZ0FSPQsQ8m
         Jah5xbhvhyqUshVkik9PwCf2z9DEDCTbRalCoBR6X9fZsZjqmCcs1JCPfY4WRjUSWWpU
         WhiKKi4+92X62tYbb9CWiE2luulAImDTqFgqJ6yz0t6yXDHf1FK79fsLpvOpAhaCJDBM
         12VfbWY3hwEG4pt9ka7iQBxiTApwDAp77AoERQeCZ511zXbpnldtU5JG3Z4UV44ZbN5X
         kQ2w==
X-Forwarded-Encrypted: i=1; AJvYcCXOB2c1LmLDexSbyytULvecrESNG7XzkG/se8VpNDcicanbgkqusNnd2XcfWSvUlG6Q3sDZfW1raiZxgl3xyTImlSAroCdqQ9LqIBVi3GzQXnZaGBY7GE2NruYMfH/x7ZKnf3qxQpsrob1TRGtzItNDVI65Ck7K6kLxYWFpHr7cNnem
X-Gm-Message-State: AOJu0Yxc5xb2GN3q2XeLxG1kaixj2xxK1nTwKoPA7RJeG94+vnJAd4Bp
	FCLrnUDlQs2XdYh2Qez8UYsOBqNoR07R+m8hMsVTYfHV5OnKYnE/XXX7Z4LellyD8O/A3BzkoeG
	z5sKuTVbhMDc3HthN2/u8EntGbkA=
X-Google-Smtp-Source: AGHT+IHg4HejanXu81YcwxgqcvuepXRrvMPaHjRu9QiPBBuRooRXcC8Yxq/ke7UZdeY3R4JwxgIS7Gqm2nE6xQI+vJE=
X-Received: by 2002:a05:6512:224e:b0:52e:bf53:1c13 with SMTP id
 2adb3069b0e04-5321364a52fmr1386641e87.7.1723525289864; Mon, 12 Aug 2024
 22:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812150049.8252-1-ioworker0@gmail.com> <zjbn575huc6pk7jpv2ipoayfk4bvfu5z5imb5muk5drksa7p3q@xcr5imtt4zro>
 <9ede36af-fca4-ed41-6b7e-cef157c640bb@huaweicloud.com>
In-Reply-To: <9ede36af-fca4-ed41-6b7e-cef157c640bb@huaweicloud.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 13 Aug 2024 13:00:53 +0800
Message-ID: <CAK1f24mwzXa8Az5WFYu+1UopTCStDWx3yDr1RugLwphS-hWizw@mail.gmail.com>
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

Hi Kuai,

Thanks a lot for jumping in!

On Tue, Aug 13, 2024 at 9:37=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2024/08/12 23:43, Michal Koutn=C3=BD =E5=86=99=E9=81=93:
> > +Cc Kuai
> >
> > On Mon, Aug 12, 2024 at 11:00:30PM GMT, Lance Yang <ioworker0@gmail.com=
> wrote:
> >> Hi all,
> >>
> >> I've run into a problem with Cgroup v2 where it doesn't seem to correc=
tly limit
> >> I/O operations when I set both wbps and wiops for a device. However, i=
f I only
> >> set wbps, then everything works as expected.
> >>
> >> To reproduce the problem, we can follow these command-based steps:
> >>
> >> 1. **System Information:**
> >>     - Kernel Version and OS Release:
> >>       ```
> >>       $ uname -r
> >>       6.10.0-rc5+
> >>
> >>       $ cat /etc/os-release
> >>       PRETTY_NAME=3D"Ubuntu 24.04 LTS"
> >>       NAME=3D"Ubuntu"
> >>       VERSION_ID=3D"24.04"
> >>       VERSION=3D"24.04 LTS (Noble Numbat)"
> >>       VERSION_CODENAME=3Dnoble
> >>       ID=3Dubuntu
> >>       ID_LIKE=3Ddebian
> >>       HOME_URL=3D"https://www.ubuntu.com/"
> >>       SUPPORT_URL=3D"https://help.ubuntu.com/"
> >>       BUG_REPORT_URL=3D"https://bugs.launchpad.net/ubuntu/"
> >>       PRIVACY_POLICY_URL=3D"https://www.ubuntu.com/legal/terms-and-pol=
icies/privacy-policy"
> >>       UBUNTU_CODENAME=3Dnoble
> >>       LOGO=3Dubuntu-logo
> >>       ```
> >>
> >> 2. **Device Information and Settings:**
> >>     - List Block Devices and Scheduler:
> >>       ```
> >>       $ lsblk
> >>       NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
> >>       sda     8:0    0   4.4T  0 disk
> >>       =E2=94=94=E2=94=80sda1  8:1    0   4.4T  0 part /data
> >>       ...
> >>
> >>       $ cat /sys/block/sda/queue/scheduler
> >>       none [mq-deadline] kyber bfq
> >>
> >>       $ cat /sys/block/sda/queue/rotational
> >>       1
> >>       ```
> >>
> >> 3. **Reproducing the problem:**
> >>     - Navigate to the cgroup v2 filesystem and configure I/O settings:
> >>       ```
> >>       $ cd /sys/fs/cgroup/
> >>       $ stat -fc %T /sys/fs/cgroup
> >>       cgroup2fs
> >>       $ mkdir test
> >>       $ echo "8:0 wbps=3D10485760 wiops=3D100000" > io.max
> >>       ```
> >>       In this setup:
> >>       wbps=3D10485760 sets the write bytes per second limit to 10 MB/s=
.
> >>       wiops=3D100000 sets the write I/O operations per second limit to=
 100,000.
> >>
> >>     - Add process to the cgroup and verify:
> >>       ```
> >>       $ echo $$ > cgroup.procs
> >>       $ cat cgroup.procs
> >>       3826771
> >>       3828513
> >>       $ ps -ef|grep 3826771
> >>       root     3826771 3826768  0 22:04 pts/1    00:00:00 -bash
> >>       root     3828761 3826771  0 22:06 pts/1    00:00:00 ps -ef
> >>       root     3828762 3826771  0 22:06 pts/1    00:00:00 grep --color=
=3Dauto 3826771
> >>       ```
> >>
> >>     - Observe I/O performance using `dd` commands and `iostat`:
> >>       ```
> >>       $ dd if=3D/dev/zero of=3D/data/file1 bs=3D512M count=3D1 &
> >>       $ dd if=3D/dev/zero of=3D/data/file1 bs=3D512M count=3D1 &
>
> You're testing buffer IO here, and I don't see that write back cgroup is
> enabled. Is this test intentional? Why not test direct IO?

Yes, I was testing buffered I/O and can confirm that CONFIG_CGROUP_WRITEBAC=
K
was enabled.

$ cat /boot/config-6.10.0-rc5+ |grep CONFIG_CGROUP_WRITEBACK
CONFIG_CGROUP_WRITEBACK=3Dy

We intend to configure both wbps (write bytes per second) and wiops
(write I/O operations
per second) for the containers. IIUC, this setup will effectively
restrict both their block device
I/Os and buffered I/Os.

> Why not test direct IO?

I was testing direct IO as well. However it did not work as expected with
`echo "8:0 wbps=3D10485760 wiops=3D100000" > io.max`.

$ time dd if=3D/dev/zero of=3D/data/file7 bs=3D512M count=3D1 oflag=3Ddirec=
t
1+0 records in
1+0 records out
536870912 bytes (537 MB, 512 MiB) copied, 51.5962 s, 10.4 MB/s

real 0m51.637s
user 0m0.000s
sys 0m0.313s

$ iostat -d 1 -h -y -p sda
 tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
kB_dscd Device
     9.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     9.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    12.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    12.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    10.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    10.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    10.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    10.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     7.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     7.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     9.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     9.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    11.00         0.0k         1.4M         0.0k       0.0k       1.4M
      0.0k sda
    11.00         0.0k         1.4M         0.0k       0.0k       1.4M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    11.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    11.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    55.00         0.0k         1.8M         0.0k       0.0k       1.8M
      0.0k sda
    55.00         0.0k         1.8M         0.0k       0.0k       1.8M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    11.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    11.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    11.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    11.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    14.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    14.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    10.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    10.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     7.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     7.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     9.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     9.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    12.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    12.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     7.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     7.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     7.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     7.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    14.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    14.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    12.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    12.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     7.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     7.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    10.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    10.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    13.00         0.0k         1.4M         0.0k       0.0k       1.4M
      0.0k sda
    13.00         0.0k         1.4M         0.0k       0.0k       1.4M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    12.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    12.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     7.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     7.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     7.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     7.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     9.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     9.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    10.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    10.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    13.00         0.0k         1.4M         0.0k       0.0k       1.4M
      0.0k sda
    13.00         0.0k         1.4M         0.0k       0.0k       1.4M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    12.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    12.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    18.00         0.0k         1.4M         0.0k       0.0k       1.4M
      0.0k sda
    18.00         0.0k         1.4M         0.0k       0.0k       1.4M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    10.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    10.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     9.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     9.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     9.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     9.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     7.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     7.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    11.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    11.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     9.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     9.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    12.00         0.0k         1.4M         0.0k       0.0k       1.4M
      0.0k sda
    12.00         0.0k         1.4M         0.0k       0.0k       1.4M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    10.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    10.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    10.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    10.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
  1804.00         0.0k       445.8M         0.0k       0.0k     445.8M
      0.0k sda
  1804.00         0.0k       445.8M         0.0k       0.0k     445.8M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     4.00         0.0k        24.0k         0.0k       0.0k      24.0k
      0.0k sda
     4.00         0.0k        24.0k         0.0k       0.0k      24.0k
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     0.00         0.0k         0.0k         0.0k       0.0k       0.0k
      0.0k sda
     0.00         0.0k         0.0k         0.0k       0.0k       0.0k
      0.0k sda1

There are two things that confuse me. First, initially, neither the
wbps nor the wiops
reached their limits. Second, in the last second, the wbps far
exceeded the limit.

But if I only set wbps, then everything works as expected with
`echo "8:0 wbps=3D10485760 wiops=3Dmax" > io.max`

> >>       ```
> >>       ```
> >>       $ iostat -d 1 -h -y -p sda
> >>
> >>         tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wr=
tn    kB_dscd Device
> >>       7.00         0.0k         1.3M         0.0k       0.0k       1.3=
M       0.0k sda
> >>       7.00         0.0k         1.3M         0.0k       0.0k       1.3=
M       0.0k sda1
> >>
> >>
> >>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrt=
n    kB_dscd Device
> >>       5.00         0.0k         1.2M         0.0k       0.0k       1.2=
M       0.0k sda
> >>       5.00         0.0k         1.2M         0.0k       0.0k       1.2=
M       0.0k sda1
> >>
> >>
> >>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrt=
n    kB_dscd Device
> >>      21.00         0.0k         1.4M         0.0k       0.0k       1.4=
M       0.0k sda
> >>      21.00         0.0k         1.4M         0.0k       0.0k       1.4=
M       0.0k sda1
> >>
> >>
> >>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrt=
n    kB_dscd Device
> >>       5.00         0.0k         1.2M         0.0k       0.0k       1.2=
M       0.0k sda
> >>       5.00         0.0k         1.2M         0.0k       0.0k       1.2=
M       0.0k sda1
> >>
> >>
> >>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrt=
n    kB_dscd Device
> >>       5.00         0.0k         1.2M         0.0k       0.0k       1.2=
M       0.0k sda
> >>       5.00         0.0k         1.2M         0.0k       0.0k       1.2=
M       0.0k sda1
> >>
> >>
> >>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrt=
n    kB_dscd Device
> >>    1848.00         0.0k       448.1M         0.0k       0.0k     448.1=
M       0.0k sda
> >>    1848.00         0.0k       448.1M         0.0k       0.0k     448.1=
M       0.0k sda1
>
> Looks like all dirty buffer got flushed to disk at the last second while
> the file is closed, this is expected.

The dd command completed in less than a second, but flushing all the
dirty buffers to
disk took a much longer time. By the time the flushing was completed,
the file had
already been closed, IIUC.

$ time dd if=3D/dev/zero of=3D/data/file5 bs=3D512M count=3D1
1+0 records in
1+0 records out
536870912 bytes (537 MB, 512 MiB) copied, 0.531944 s, 1.0 GB/s

real 0m0.578s
user 0m0.000s
sys 0m0.576s

$ iostat -d 1 -h -y -p sda
   tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
kB_dscd Device
     0.00         0.0k         0.0k         0.0k       0.0k       0.0k
      0.0k sda
     0.00         0.0k         0.0k         0.0k       0.0k       0.0k
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    74.00         0.0k       664.0k         0.0k       0.0k     664.0k
      0.0k sda
    74.00         0.0k       664.0k         0.0k       0.0k     664.0k
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    15.00         0.0k         1.1M         0.0k       0.0k       1.1M
      0.0k sda
    15.00         0.0k         1.1M         0.0k       0.0k       1.1M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     5.00         0.0k         1.2M         0.0k       0.0k       1.2M
      0.0k sda
     5.00         0.0k         1.2M         0.0k       0.0k       1.2M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     5.00         0.0k         1.2M         0.0k       0.0k       1.2M
      0.0k sda
     5.00         0.0k         1.2M         0.0k       0.0k       1.2M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     5.00         0.0k         1.2M         0.0k       0.0k       1.2M
      0.0k sda
     5.00         0.0k         1.2M         0.0k       0.0k       1.2M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     6.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     6.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     5.00         0.0k         1.2M         0.0k       0.0k       1.2M
      0.0k sda
     5.00         0.0k         1.2M         0.0k       0.0k       1.2M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     6.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     6.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    10.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    10.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     6.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     6.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     6.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     6.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     9.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     9.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     9.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     9.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     6.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     6.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     6.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     6.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     5.00         0.0k         1.2M         0.0k       0.0k       1.2M
      0.0k sda
     5.00         0.0k         1.2M         0.0k       0.0k       1.2M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    13.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    13.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    10.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    10.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     6.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     6.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     5.00         0.0k         1.2M         0.0k       0.0k       1.2M
      0.0k sda
     5.00         0.0k         1.2M         0.0k       0.0k       1.2M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    12.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    12.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     9.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     9.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     7.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     7.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    11.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    11.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     6.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     6.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    46.00         0.0k         1.7M         0.0k       0.0k       1.7M
      0.0k sda
    46.00         0.0k         1.7M         0.0k       0.0k       1.7M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     6.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     6.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    10.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    10.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     6.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     6.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     7.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     7.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     6.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     6.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    10.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    10.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     7.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     7.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     6.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     6.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     6.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     6.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    11.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    11.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     5.00         0.0k         1.2M         0.0k       0.0k       1.2M
      0.0k sda
     5.00         0.0k         1.2M         0.0k       0.0k       1.2M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     6.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     6.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    11.00         0.0k         1.4M         0.0k       0.0k       1.4M
      0.0k sda
    11.00         0.0k         1.4M         0.0k       0.0k       1.4M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    15.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    15.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
     8.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    15.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    15.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    10.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda
    10.00         0.0k         1.3M         0.0k       0.0k       1.3M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    49.00         0.0k         1.6M         0.0k       0.0k       1.6M
      0.0k sda
    49.00         0.0k         1.6M         0.0k       0.0k       1.6M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
    53.00         0.0k         1.6M         0.0k       0.0k       1.6M
      0.0k sda
    53.00         0.0k         1.6M         0.0k       0.0k       1.6M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
  1805.00         0.0k       448.4M         0.0k       0.0k     448.4M
      0.0k sda
  1805.00         0.0k       448.4M         0.0k       0.0k     448.4M
      0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
   kB_dscd Device
     0.00         0.0k         0.0k         0.0k       0.0k       0.0k
      0.0k sda
     0.00         0.0k         0.0k         0.0k       0.0k       0.0k
      0.0k sda1

> >>       ```
> >> Initially, the write speed is slow (<2MB/s) then suddenly bursts to se=
veral
> >> hundreds of MB/s.
> >
> > What it would be on average?
> > IOW how long would the whole operation in throttled cgroup take?
> >
> >>
> >>     - Testing with wiops set to max:
> >>       ```
> >>       echo "8:0 wbps=3D10485760 wiops=3Dmax" > io.max
> >>       $ dd if=3D/dev/zero of=3D/data/file1 bs=3D512M count=3D1 &
> >>       $ dd if=3D/dev/zero of=3D/data/file1 bs=3D512M count=3D1 &
> >>       ```
> >>       ```
> >>       $ iostat -d 1 -h -y -p sda
> >>
> >>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrt=
n    kB_dscd Device
> >>      48.00         0.0k        10.0M         0.0k       0.0k      10.0=
M       0.0k sda
> >>      48.00         0.0k        10.0M         0.0k       0.0k      10.0=
M       0.0k sda1
> >>
> >>
> >>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrt=
n    kB_dscd Device
> >>      40.00         0.0k        10.0M         0.0k       0.0k      10.0=
M       0.0k sda
> >>      40.00         0.0k        10.0M         0.0k       0.0k      10.0=
M       0.0k sda1
> >>
> >>
> >>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrt=
n    kB_dscd Device
> >>      41.00         0.0k        10.0M         0.0k       0.0k      10.0=
M       0.0k sda
> >>      41.00         0.0k        10.0M         0.0k       0.0k      10.0=
M       0.0k sda1
> >>
> >>
> >>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrt=
n    kB_dscd Device
> >>      46.00         0.0k        10.0M         0.0k       0.0k      10.0=
M       0.0k sda
> >>      46.00         0.0k        10.0M         0.0k       0.0k      10.0=
M       0.0k sda1
> >>
> >>
> >>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrt=
n    kB_dscd Device
> >>      55.00         0.0k        10.2M         0.0k       0.0k      10.2=
M       0.0k sda
> >>      55.00         0.0k        10.2M         0.0k       0.0k      10.2=
M       0.0k sda1
>
> And I don't this wiops=3Dmax is the reason, what need to explain is that
> why dirty buffer got flushed to disk synchronously before the dd finish
> and close the file?

The dd command operates in the background, and it seems that the dirty
buffers begin
to flush after the command has completed.

>
> >>       ```
> >> The iostat output shows the write operations as stabilizing at around =
10 MB/s,
> >> which aligns with the defined limit of 10 MB/s. After setting wiops to=
 max, the
> >> I/O limits appear to work as expected.
>
> Can you give the direct IO a test? And also enable write back cgroup for
> buffer IO.
>
> Thanks,
> Kuai


Thanks a lot again for your time!
Lance

>
> >>
> >>
> >> Thanks,
> >> Lance
> >
> > Thanks for the report Lance. Is this something you started seeing after
> > a kernel update or switch to cgroup v2? (Or you simply noticed with thi=
s
> > setup only?)
> >
> >
> > Michal
> >
>

