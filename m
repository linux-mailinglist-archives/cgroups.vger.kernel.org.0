Return-Path: <cgroups+bounces-4222-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E47F94FDBF
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 08:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3B21B222EE
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 06:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8C644375;
	Tue, 13 Aug 2024 06:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0Qs2r5I"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBCB3611B;
	Tue, 13 Aug 2024 06:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723529892; cv=none; b=bPvL+tJNtE/BnAspX5qXplrxz5NLTPFX065Pcz7nO6fZp8OJbtBv7Sc+ENaTV5KriEu6y8GICNYn90y8HbUSh+pZfWQcUhuf1bqRmR+q2mlie3xUxn9mwwAjjJYjL1NT8jOkoJvW3kH9Vd8T0iSxfTKYPg5ZfXLkBceH2DH843o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723529892; c=relaxed/simple;
	bh=o7Msg2ywpVXLM3aXhV6CIXDYtA9ahSvXowThpmyuSBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SnBt3jl0Ai4yJhuCUTbHeIGFdj7KBmXDWw3A7gANf9/3ahweBPsJS2dAvI9nfCT26zBvXNjQH83XnMm33fIVq4fgStjRTYRRS5jv88IhT87fLJ++wpM3f9lMgk3vfHoiU63USpPsHLzycPHdYHfbC8Wj8EAKsE7P0FKXFqon4Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0Qs2r5I; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5b5b67d0024so5812358a12.0;
        Mon, 12 Aug 2024 23:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723529888; x=1724134688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+g+z1RGD7NU2gbGbBKpzfSa2hMVvKkEjAdSNcJPLjs=;
        b=S0Qs2r5I8LDzVTnTIJqkJH95VcymFQiQYCaAsvnx3hklEZgLFKBRw2X9iPNWDXg1Xx
         xXHDX6FFCoeOxu7MZapTDxnI2PxiZJ1kBx7Kv5GRFC+S52KdgIGOpstUPSP9c8H5c/z+
         PLXSNygI7OIE8gv2aF/22j1Hkvcuu1Vv27fSj8902OmNJ9ziES1tCr85P5O1KpWdCe4z
         6duejA/ugIBNxnPGmOrtI0uPLFLDqRk+6cajlCT3OHnDLQVrna3PjaFltWzuQN8gVGPn
         +jg8pBEhWoD0QbYxc46H78cUBeyh4Puyv1ZCmNIcOkuxpj0ilvgXgqGwPdt+0BfzdiSQ
         E0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723529888; x=1724134688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+g+z1RGD7NU2gbGbBKpzfSa2hMVvKkEjAdSNcJPLjs=;
        b=N0S57Rchyoe8TNz+yd8p7rMnXGY9g4nnVFAzsUd1plzombuzXRiulZxj61t9OBECCE
         RPpgbLVCxyhlqm1X9tFbNbO0WKlKC4j4mz1BS165VTfsEQSMcQJjJ+ypF/j5DAOaPE8P
         f0EAUe8bdbWGqW34oONLo82hO11INCzWQUUH42sgtJ1ChgO8p3SrjUXmetUHwU5aeYXk
         xzH29kZNPH8xJfy3FoGcoEm80/qv2noMqFs+9MZ8AjV1GvIHtxxqDD9OPq4xZDHnsmcq
         iyQ2I/yywiCvvbNgBkSn54M4OTmKKCQcQQVbDPBp4trB7r5uHCc3RKSz230oPUhzctem
         a9nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWICrBvkY595jeIe0Sj2kKM3Ne/dAP/4cPWzoABhD2L7iW0N+PQ052HWRifp+zjl6pRxIjCOzqdJplQXuwUE/XKUa4TlRzZSy9ajIZYT12L/6GKtJfyt2q2ApVLqUEikgTh17wHL8XT4MKYKKb9NJNVE1Le4BMCGAwgCbvWjiYFXtMw
X-Gm-Message-State: AOJu0YwGeahGX0U3mly8jy1CvdfeQ+rJ2z1iFGYFVnX89tUADAKqfOqc
	hkM3qWDh51t6BE6FDwjJlZvEOjAhYotvrhLtBqzb0XhAnEib+kWoJL0iEWhaCmlYmK9VF23ZvTA
	8Kz/P/3fJtbk9RoC2JRS8eW41HCs=
X-Google-Smtp-Source: AGHT+IGrfFiMMvx5Z+gBLeKE4Pf/N/gMzc/KSiWz2TjQS59VsD0MNowfq5IKWZeZ3owo5g4ohGYRpmnU6PfQIGhe4UI=
X-Received: by 2002:a05:6402:3489:b0:5a7:464a:ac0 with SMTP id
 4fb4d7f45d1cf-5bd44c30b9dmr1589244a12.11.1723529887659; Mon, 12 Aug 2024
 23:18:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812150049.8252-1-ioworker0@gmail.com> <zjbn575huc6pk7jpv2ipoayfk4bvfu5z5imb5muk5drksa7p3q@xcr5imtt4zro>
 <9ede36af-fca4-ed41-6b7e-cef157c640bb@huaweicloud.com> <CAK1f24mwzXa8Az5WFYu+1UopTCStDWx3yDr1RugLwphS-hWizw@mail.gmail.com>
In-Reply-To: <CAK1f24mwzXa8Az5WFYu+1UopTCStDWx3yDr1RugLwphS-hWizw@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 13 Aug 2024 14:17:30 +0800
Message-ID: <CAK1f24=R9tgxGB3T3JPsHAhg+hAgvRg+-K-gWT_+WYVOTRtSpA@mail.gmail.com>
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

I just realized that bursts appear to depend on the maximum values of wbps =
and
wiops, when wiops is not `max`?

Thanks,
Lance

On Tue, Aug 13, 2024 at 1:00=E2=80=AFPM Lance Yang <ioworker0@gmail.com> wr=
ote:
>
> Hi Kuai,
>
> Thanks a lot for jumping in!
>
> On Tue, Aug 13, 2024 at 9:37=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com>=
 wrote:
> >
> > Hi,
> >
> > =E5=9C=A8 2024/08/12 23:43, Michal Koutn=C3=BD =E5=86=99=E9=81=93:
> > > +Cc Kuai
> > >
> > > On Mon, Aug 12, 2024 at 11:00:30PM GMT, Lance Yang <ioworker0@gmail.c=
om> wrote:
> > >> Hi all,
> > >>
> > >> I've run into a problem with Cgroup v2 where it doesn't seem to corr=
ectly limit
> > >> I/O operations when I set both wbps and wiops for a device. However,=
 if I only
> > >> set wbps, then everything works as expected.
> > >>
> > >> To reproduce the problem, we can follow these command-based steps:
> > >>
> > >> 1. **System Information:**
> > >>     - Kernel Version and OS Release:
> > >>       ```
> > >>       $ uname -r
> > >>       6.10.0-rc5+
> > >>
> > >>       $ cat /etc/os-release
> > >>       PRETTY_NAME=3D"Ubuntu 24.04 LTS"
> > >>       NAME=3D"Ubuntu"
> > >>       VERSION_ID=3D"24.04"
> > >>       VERSION=3D"24.04 LTS (Noble Numbat)"
> > >>       VERSION_CODENAME=3Dnoble
> > >>       ID=3Dubuntu
> > >>       ID_LIKE=3Ddebian
> > >>       HOME_URL=3D"https://www.ubuntu.com/"
> > >>       SUPPORT_URL=3D"https://help.ubuntu.com/"
> > >>       BUG_REPORT_URL=3D"https://bugs.launchpad.net/ubuntu/"
> > >>       PRIVACY_POLICY_URL=3D"https://www.ubuntu.com/legal/terms-and-p=
olicies/privacy-policy"
> > >>       UBUNTU_CODENAME=3Dnoble
> > >>       LOGO=3Dubuntu-logo
> > >>       ```
> > >>
> > >> 2. **Device Information and Settings:**
> > >>     - List Block Devices and Scheduler:
> > >>       ```
> > >>       $ lsblk
> > >>       NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
> > >>       sda     8:0    0   4.4T  0 disk
> > >>       =E2=94=94=E2=94=80sda1  8:1    0   4.4T  0 part /data
> > >>       ...
> > >>
> > >>       $ cat /sys/block/sda/queue/scheduler
> > >>       none [mq-deadline] kyber bfq
> > >>
> > >>       $ cat /sys/block/sda/queue/rotational
> > >>       1
> > >>       ```
> > >>
> > >> 3. **Reproducing the problem:**
> > >>     - Navigate to the cgroup v2 filesystem and configure I/O setting=
s:
> > >>       ```
> > >>       $ cd /sys/fs/cgroup/
> > >>       $ stat -fc %T /sys/fs/cgroup
> > >>       cgroup2fs
> > >>       $ mkdir test
> > >>       $ echo "8:0 wbps=3D10485760 wiops=3D100000" > io.max
> > >>       ```
> > >>       In this setup:
> > >>       wbps=3D10485760 sets the write bytes per second limit to 10 MB=
/s.
> > >>       wiops=3D100000 sets the write I/O operations per second limit =
to 100,000.
> > >>
> > >>     - Add process to the cgroup and verify:
> > >>       ```
> > >>       $ echo $$ > cgroup.procs
> > >>       $ cat cgroup.procs
> > >>       3826771
> > >>       3828513
> > >>       $ ps -ef|grep 3826771
> > >>       root     3826771 3826768  0 22:04 pts/1    00:00:00 -bash
> > >>       root     3828761 3826771  0 22:06 pts/1    00:00:00 ps -ef
> > >>       root     3828762 3826771  0 22:06 pts/1    00:00:00 grep --col=
or=3Dauto 3826771
> > >>       ```
> > >>
> > >>     - Observe I/O performance using `dd` commands and `iostat`:
> > >>       ```
> > >>       $ dd if=3D/dev/zero of=3D/data/file1 bs=3D512M count=3D1 &
> > >>       $ dd if=3D/dev/zero of=3D/data/file1 bs=3D512M count=3D1 &
> >
> > You're testing buffer IO here, and I don't see that write back cgroup i=
s
> > enabled. Is this test intentional? Why not test direct IO?
>
> Yes, I was testing buffered I/O and can confirm that CONFIG_CGROUP_WRITEB=
ACK
> was enabled.
>
> $ cat /boot/config-6.10.0-rc5+ |grep CONFIG_CGROUP_WRITEBACK
> CONFIG_CGROUP_WRITEBACK=3Dy
>
> We intend to configure both wbps (write bytes per second) and wiops
> (write I/O operations
> per second) for the containers. IIUC, this setup will effectively
> restrict both their block device
> I/Os and buffered I/Os.
>
> > Why not test direct IO?
>
> I was testing direct IO as well. However it did not work as expected with
> `echo "8:0 wbps=3D10485760 wiops=3D100000" > io.max`.
>
> $ time dd if=3D/dev/zero of=3D/data/file7 bs=3D512M count=3D1 oflag=3Ddir=
ect
> 1+0 records in
> 1+0 records out
> 536870912 bytes (537 MB, 512 MiB) copied, 51.5962 s, 10.4 MB/s
>
> real 0m51.637s
> user 0m0.000s
> sys 0m0.313s
>
> $ iostat -d 1 -h -y -p sda
>  tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
> kB_dscd Device
>      9.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      9.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     12.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     12.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     10.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     10.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     10.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     10.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      7.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      7.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      9.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      9.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     11.00         0.0k         1.4M         0.0k       0.0k       1.4M
>       0.0k sda
>     11.00         0.0k         1.4M         0.0k       0.0k       1.4M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     11.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     11.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     55.00         0.0k         1.8M         0.0k       0.0k       1.8M
>       0.0k sda
>     55.00         0.0k         1.8M         0.0k       0.0k       1.8M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     11.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     11.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     11.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     11.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     14.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     14.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     10.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     10.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      7.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      7.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      9.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      9.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     12.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     12.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      7.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      7.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      7.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      7.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     14.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     14.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     12.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     12.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      7.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      7.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     10.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     10.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     13.00         0.0k         1.4M         0.0k       0.0k       1.4M
>       0.0k sda
>     13.00         0.0k         1.4M         0.0k       0.0k       1.4M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     12.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     12.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      7.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      7.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      7.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      7.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      9.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      9.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     10.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     10.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     13.00         0.0k         1.4M         0.0k       0.0k       1.4M
>       0.0k sda
>     13.00         0.0k         1.4M         0.0k       0.0k       1.4M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     12.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     12.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     18.00         0.0k         1.4M         0.0k       0.0k       1.4M
>       0.0k sda
>     18.00         0.0k         1.4M         0.0k       0.0k       1.4M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     10.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     10.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      9.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      9.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      9.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      9.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      7.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      7.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     11.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     11.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      9.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      9.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     12.00         0.0k         1.4M         0.0k       0.0k       1.4M
>       0.0k sda
>     12.00         0.0k         1.4M         0.0k       0.0k       1.4M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     10.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     10.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     10.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     10.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>   1804.00         0.0k       445.8M         0.0k       0.0k     445.8M
>       0.0k sda
>   1804.00         0.0k       445.8M         0.0k       0.0k     445.8M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      4.00         0.0k        24.0k         0.0k       0.0k      24.0k
>       0.0k sda
>      4.00         0.0k        24.0k         0.0k       0.0k      24.0k
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      0.00         0.0k         0.0k         0.0k       0.0k       0.0k
>       0.0k sda
>      0.00         0.0k         0.0k         0.0k       0.0k       0.0k
>       0.0k sda1
>
> There are two things that confuse me. First, initially, neither the
> wbps nor the wiops
> reached their limits. Second, in the last second, the wbps far
> exceeded the limit.
>
> But if I only set wbps, then everything works as expected with
> `echo "8:0 wbps=3D10485760 wiops=3Dmax" > io.max`
>
> > >>       ```
> > >>       ```
> > >>       $ iostat -d 1 -h -y -p sda
> > >>
> > >>         tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_=
wrtn    kB_dscd Device
> > >>       7.00         0.0k         1.3M         0.0k       0.0k       1=
.3M       0.0k sda
> > >>       7.00         0.0k         1.3M         0.0k       0.0k       1=
.3M       0.0k sda1
> > >>
> > >>
> > >>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_w=
rtn    kB_dscd Device
> > >>       5.00         0.0k         1.2M         0.0k       0.0k       1=
.2M       0.0k sda
> > >>       5.00         0.0k         1.2M         0.0k       0.0k       1=
.2M       0.0k sda1
> > >>
> > >>
> > >>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_w=
rtn    kB_dscd Device
> > >>      21.00         0.0k         1.4M         0.0k       0.0k       1=
.4M       0.0k sda
> > >>      21.00         0.0k         1.4M         0.0k       0.0k       1=
.4M       0.0k sda1
> > >>
> > >>
> > >>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_w=
rtn    kB_dscd Device
> > >>       5.00         0.0k         1.2M         0.0k       0.0k       1=
.2M       0.0k sda
> > >>       5.00         0.0k         1.2M         0.0k       0.0k       1=
.2M       0.0k sda1
> > >>
> > >>
> > >>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_w=
rtn    kB_dscd Device
> > >>       5.00         0.0k         1.2M         0.0k       0.0k       1=
.2M       0.0k sda
> > >>       5.00         0.0k         1.2M         0.0k       0.0k       1=
.2M       0.0k sda1
> > >>
> > >>
> > >>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_w=
rtn    kB_dscd Device
> > >>    1848.00         0.0k       448.1M         0.0k       0.0k     448=
.1M       0.0k sda
> > >>    1848.00         0.0k       448.1M         0.0k       0.0k     448=
.1M       0.0k sda1
> >
> > Looks like all dirty buffer got flushed to disk at the last second whil=
e
> > the file is closed, this is expected.
>
> The dd command completed in less than a second, but flushing all the
> dirty buffers to
> disk took a much longer time. By the time the flushing was completed,
> the file had
> already been closed, IIUC.
>
> $ time dd if=3D/dev/zero of=3D/data/file5 bs=3D512M count=3D1
> 1+0 records in
> 1+0 records out
> 536870912 bytes (537 MB, 512 MiB) copied, 0.531944 s, 1.0 GB/s
>
> real 0m0.578s
> user 0m0.000s
> sys 0m0.576s
>
> $ iostat -d 1 -h -y -p sda
>    tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
> kB_dscd Device
>      0.00         0.0k         0.0k         0.0k       0.0k       0.0k
>       0.0k sda
>      0.00         0.0k         0.0k         0.0k       0.0k       0.0k
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     74.00         0.0k       664.0k         0.0k       0.0k     664.0k
>       0.0k sda
>     74.00         0.0k       664.0k         0.0k       0.0k     664.0k
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     15.00         0.0k         1.1M         0.0k       0.0k       1.1M
>       0.0k sda
>     15.00         0.0k         1.1M         0.0k       0.0k       1.1M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      5.00         0.0k         1.2M         0.0k       0.0k       1.2M
>       0.0k sda
>      5.00         0.0k         1.2M         0.0k       0.0k       1.2M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      5.00         0.0k         1.2M         0.0k       0.0k       1.2M
>       0.0k sda
>      5.00         0.0k         1.2M         0.0k       0.0k       1.2M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      5.00         0.0k         1.2M         0.0k       0.0k       1.2M
>       0.0k sda
>      5.00         0.0k         1.2M         0.0k       0.0k       1.2M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      6.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      6.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      5.00         0.0k         1.2M         0.0k       0.0k       1.2M
>       0.0k sda
>      5.00         0.0k         1.2M         0.0k       0.0k       1.2M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      6.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      6.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     10.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     10.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      6.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      6.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      6.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      6.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      9.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      9.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      9.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      9.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      6.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      6.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      6.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      6.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      5.00         0.0k         1.2M         0.0k       0.0k       1.2M
>       0.0k sda
>      5.00         0.0k         1.2M         0.0k       0.0k       1.2M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     13.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     13.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     10.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     10.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      6.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      6.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      5.00         0.0k         1.2M         0.0k       0.0k       1.2M
>       0.0k sda
>      5.00         0.0k         1.2M         0.0k       0.0k       1.2M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     12.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     12.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      9.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      9.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      7.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      7.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     11.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     11.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      6.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      6.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     46.00         0.0k         1.7M         0.0k       0.0k       1.7M
>       0.0k sda
>     46.00         0.0k         1.7M         0.0k       0.0k       1.7M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      6.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      6.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     10.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     10.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      6.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      6.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      7.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      7.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      6.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      6.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     10.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     10.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      7.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      7.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      6.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      6.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      6.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      6.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     11.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     11.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      5.00         0.0k         1.2M         0.0k       0.0k       1.2M
>       0.0k sda
>      5.00         0.0k         1.2M         0.0k       0.0k       1.2M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      6.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      6.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     11.00         0.0k         1.4M         0.0k       0.0k       1.4M
>       0.0k sda
>     11.00         0.0k         1.4M         0.0k       0.0k       1.4M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     15.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     15.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>      8.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     15.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     15.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     10.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda
>     10.00         0.0k         1.3M         0.0k       0.0k       1.3M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     49.00         0.0k         1.6M         0.0k       0.0k       1.6M
>       0.0k sda
>     49.00         0.0k         1.6M         0.0k       0.0k       1.6M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>     53.00         0.0k         1.6M         0.0k       0.0k       1.6M
>       0.0k sda
>     53.00         0.0k         1.6M         0.0k       0.0k       1.6M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>   1805.00         0.0k       448.4M         0.0k       0.0k     448.4M
>       0.0k sda
>   1805.00         0.0k       448.4M         0.0k       0.0k     448.4M
>       0.0k sda1
>
>
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>    kB_dscd Device
>      0.00         0.0k         0.0k         0.0k       0.0k       0.0k
>       0.0k sda
>      0.00         0.0k         0.0k         0.0k       0.0k       0.0k
>       0.0k sda1
>
> > >>       ```
> > >> Initially, the write speed is slow (<2MB/s) then suddenly bursts to =
several
> > >> hundreds of MB/s.
> > >
> > > What it would be on average?
> > > IOW how long would the whole operation in throttled cgroup take?
> > >
> > >>
> > >>     - Testing with wiops set to max:
> > >>       ```
> > >>       echo "8:0 wbps=3D10485760 wiops=3Dmax" > io.max
> > >>       $ dd if=3D/dev/zero of=3D/data/file1 bs=3D512M count=3D1 &
> > >>       $ dd if=3D/dev/zero of=3D/data/file1 bs=3D512M count=3D1 &
> > >>       ```
> > >>       ```
> > >>       $ iostat -d 1 -h -y -p sda
> > >>
> > >>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_w=
rtn    kB_dscd Device
> > >>      48.00         0.0k        10.0M         0.0k       0.0k      10=
.0M       0.0k sda
> > >>      48.00         0.0k        10.0M         0.0k       0.0k      10=
.0M       0.0k sda1
> > >>
> > >>
> > >>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_w=
rtn    kB_dscd Device
> > >>      40.00         0.0k        10.0M         0.0k       0.0k      10=
.0M       0.0k sda
> > >>      40.00         0.0k        10.0M         0.0k       0.0k      10=
.0M       0.0k sda1
> > >>
> > >>
> > >>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_w=
rtn    kB_dscd Device
> > >>      41.00         0.0k        10.0M         0.0k       0.0k      10=
.0M       0.0k sda
> > >>      41.00         0.0k        10.0M         0.0k       0.0k      10=
.0M       0.0k sda1
> > >>
> > >>
> > >>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_w=
rtn    kB_dscd Device
> > >>      46.00         0.0k        10.0M         0.0k       0.0k      10=
.0M       0.0k sda
> > >>      46.00         0.0k        10.0M         0.0k       0.0k      10=
.0M       0.0k sda1
> > >>
> > >>
> > >>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_w=
rtn    kB_dscd Device
> > >>      55.00         0.0k        10.2M         0.0k       0.0k      10=
.2M       0.0k sda
> > >>      55.00         0.0k        10.2M         0.0k       0.0k      10=
.2M       0.0k sda1
> >
> > And I don't this wiops=3Dmax is the reason, what need to explain is tha=
t
> > why dirty buffer got flushed to disk synchronously before the dd finish
> > and close the file?
>
> The dd command operates in the background, and it seems that the dirty
> buffers begin
> to flush after the command has completed.
>
> >
> > >>       ```
> > >> The iostat output shows the write operations as stabilizing at aroun=
d 10 MB/s,
> > >> which aligns with the defined limit of 10 MB/s. After setting wiops =
to max, the
> > >> I/O limits appear to work as expected.
> >
> > Can you give the direct IO a test? And also enable write back cgroup fo=
r
> > buffer IO.
> >
> > Thanks,
> > Kuai
>
>
> Thanks a lot again for your time!
> Lance
>
> >
> > >>
> > >>
> > >> Thanks,
> > >> Lance
> > >
> > > Thanks for the report Lance. Is this something you started seeing aft=
er
> > > a kernel update or switch to cgroup v2? (Or you simply noticed with t=
his
> > > setup only?)
> > >
> > >
> > > Michal
> > >
> >

