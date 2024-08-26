Return-Path: <cgroups+bounces-4445-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8427C95E6A3
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 04:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFBF0B20C6E
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 02:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CAE8F6A;
	Mon, 26 Aug 2024 02:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKtRh6tb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945DB645;
	Mon, 26 Aug 2024 02:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724638578; cv=none; b=eD48/MdUI1DhFlNUzpcIaEyWynl6nQ+/qFZF9GAM/h1IycVY3adfydYt5eCdgoolRJqrINR0RtANcqNEpC95zyIVxVGUJ5+zoLcn2IZWVGhYbKCKh6RtvohxHiRnQmVhWVGhXy/bVEf2pVrJyWA+hBx8p1xTnxM+iDK5y95kJN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724638578; c=relaxed/simple;
	bh=MuSHuq16qg1I/CnC8dMMMMnpB5Ce49Db6+pJD+a9CWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dCae6xqgOQBPxKKQMMCB//dytEm1csW9UQSX9ykZyOwSCZDIbon4lQx6on+mLikgGsbK+vh/NNT7OTsPhuxlwYx6vYxU6t87narGQm3ed+rd1+Wu5tMvweFz2cLJn6+CajUU6xQABQFl7mvNEtLekH7R6HShkGLc+O04tCQaebw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKtRh6tb; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5bef295a2b4so6068210a12.0;
        Sun, 25 Aug 2024 19:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724638575; x=1725243375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3t51FcKH1O1ZTqoTyt4cTRme4HJT18VHTa5y/zw0NA=;
        b=JKtRh6tbdVHZnnMaHugpVRVO31WHxcG93/MEH1NtCXkODCmVK4+4k90nclSzgXSR7w
         W2Yrbwm/NltIdigLet4z93XcskaOX4+1l/C6/2UPDNtNPBXSfNdPuIz4ecBj3QXWKKNp
         JNnEVQLy51A+qBEZ0d84hm0hHCFpq6i7bIS6sjBOCz4ZcNJuDdRGNMv4OKV3bjuec/zX
         Yq4zOhzOlkSVFbduh2CKe0cQpoNnsY4TVn58SjcP3NILIXvJo7CpjXm1+r7PFT7B2ZvD
         npFCUVc2XINaSpIyStcGa0s8rFvJmMF2i+EFLDRth1+V00rESod8v1xbhjh0njH5BLRz
         DD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724638575; x=1725243375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3t51FcKH1O1ZTqoTyt4cTRme4HJT18VHTa5y/zw0NA=;
        b=xFBesfe3W0kkdNTXleynzhFlFGY1qXMcqRqItt+7K/+QkzqPW8qAvGwxU7VceY2GPP
         7kwiWrBXg3NAmslTBWcTRyEtNc3UUvKY3pSCCJ/HRoUJt9t3FKXxivGpkKtwqgqlK8tM
         2/CezgVUQMVHIsZn5/AF3gp8Q0dDAkcc7PaOCg1UOKm4r3e7foTKEqN90Rk3pWEdasl6
         nNMeqeKnU8XoUQ/DAnyNKlFSPhyTqha8FVf3xoTq43RiX9jJHyhkfPtDXGDSXaKbh01+
         8DixiDK5LkGds60kL7BnmI8MVZyVDRDthF0rcvd8LophP5RtLFnM35aN7rJAdZOJ5a1e
         zDJA==
X-Forwarded-Encrypted: i=1; AJvYcCU879+wQYFc1GilPxYwAIsJqtSHTZP/dwFilrdRBi0JeI2ORWnFuARsSD9o223yGtGZrThq3txN@vger.kernel.org, AJvYcCVCpoH3pBKCU4oQKa6jzmOpajWAuYu39hqKVe4EG5NecvUdbppYvh8hme2XnHRLc/fWLZ3CU8fbW/EtCASQ@vger.kernel.org, AJvYcCXVcBl6nMmR/xoma8SH7jetPPpe6HOVNfEEyVofXtUZARwriZtQPSpbrx/ko8ONTE8i2MnzE6Da90j6QeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/HeUt96+8C83m4+CJf0JliMzfROWnDRn77E0DbawT1sZIIXbI
	BjGpt/839hS0J7Bv1recpmCV/LBO7RZvEgLGwQCyKOO8dSrz0e8mshKBH69MHzXlKV00GQMUlox
	5vt5N7byotiNwnK094G0uHCrRBnA=
X-Google-Smtp-Source: AGHT+IGFnGf4z4OSEQbXlIeyv/4lEOAoGE+B28Ov4LIIZkQ0+J1LqBp2ssQAobhn+5Dqhpgh+0dfZ28rlgx5kEwyuy8=
X-Received: by 2002:a05:6402:2551:b0:5be:ddbe:2798 with SMTP id
 4fb4d7f45d1cf-5bf2c0693admr11170100a12.18.1724638574276; Sun, 25 Aug 2024
 19:16:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7c3499ac-faa7-cc0c-2d90-b8291fce5492@huaweicloud.com>
 <20240823120510.61853-1-ioworker0@gmail.com> <36c4744a-3827-f6d7-664a-8ee2b7d0e281@huaweicloud.com>
In-Reply-To: <36c4744a-3827-f6d7-664a-8ee2b7d0e281@huaweicloud.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Mon, 26 Aug 2024 10:15:38 +0800
Message-ID: <CAK1f24=AJ81+hqQ+KK4wWceGCcSQWyyrb-ekRXu4_9gDM88PCQ@mail.gmail.com>
Subject: Re: [BUG] cgroupv2/blk: inconsistent I/O behavior in Cgroup v2 with
 set device wbps and wiops
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: 21cnbao@gmail.com, a.hindborg@samsung.com, axboe@kernel.dk, 
	baolin.wang@linux.alibaba.com, boqun.feng@gmail.com, cgroups@vger.kernel.org, 
	david@redhat.com, fujita.tomonori@lab.ntt.co.jp, josef@toxicpanda.com, 
	libang.li@antgroup.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mkoutny@suse.com, 
	paolo.valente@unimore.it, tj@kernel.org, vbabka@kernel.org, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kuai,

Thanks a lot for following up on this!

On Mon, Aug 26, 2024 at 9:31=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2024/08/23 20:05, Lance Yang =E5=86=99=E9=81=93:
> > My bad, I got tied up with some stuff :(
> >
> > Hmm... tried your debug patch today, but my test results are different =
from
> > yours. So let's take a look at direct IO with raw disk first.
> >
> > ```
> > $ lsblk
> > NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
> > sda      8:0    0   90G  0 disk
> > =E2=94=9C=E2=94=80sda1   8:1    0    1G  0 part /boot/efi
> > =E2=94=94=E2=94=80sda2   8:2    0 88.9G  0 part /
> > sdb      8:16   0   10G  0 disk
> >
> > $ cat  /sys/block/sda/queue/scheduler
> > none [mq-deadline]
> >
> > $ cat  /sys/block/sda/queue/rotational
> > 0
> >
> > $ cat  /sys/block/sdb/queue/rotational
> > 0
> >
> > $ cat  /sys/block/sdb/queue/scheduler
> > none [mq-deadline]
> >
> > $ cat /boot/config-6.11.0-rc3+ |grep CONFIG_CGROUP_
> > # CONFIG_CGROUP_FAVOR_DYNMODS is not set
> > CONFIG_CGROUP_WRITEBACK=3Dy
> > CONFIG_CGROUP_SCHED=3Dy
> > CONFIG_CGROUP_PIDS=3Dy
> > CONFIG_CGROUP_RDMA=3Dy
> > CONFIG_CGROUP_FREEZER=3Dy
> > CONFIG_CGROUP_HUGETLB=3Dy
> > CONFIG_CGROUP_DEVICE=3Dy
> > CONFIG_CGROUP_CPUACCT=3Dy
> > CONFIG_CGROUP_PERF=3Dy
> > CONFIG_CGROUP_BPF=3Dy
> > CONFIG_CGROUP_MISC=3Dy
> > # CONFIG_CGROUP_DEBUG is not set
> > CONFIG_CGROUP_NET_PRIO=3Dy
> > CONFIG_CGROUP_NET_CLASSID=3Dy
> >
> > $ cd /sys/fs/cgroup/test/ && cat cgroup.controllers
> > cpu io memory pids
> >
> > $ cat io.weight
> > default 100
> >
> > $ cat io.prio.class
> > no-change
> > ```
> >
> > With wiops, the result is as follows:
> >
> > ```
> > $ echo "8:16 wbps=3D10485760 wiops=3D100000" > io.max
> >
> > $ dd if=3D/dev/zero of=3D/dev/sdb bs=3D50M count=3D1 oflag=3Ddirect
> > 1+0 records in
> > 1+0 records out
> > 52428800 bytes (52 MB, 50 MiB) copied, 5.05893 s, 10.4 MB/s
> >
> > $ dmesg -T
> > [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 2984 ffff0000fb3=
a8f00
> > [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 6176 ffff0000fb3=
a97c0
> > [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 7224 ffff0000fb3=
a9180
> > [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb=
3a8640
> > [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb=
3a9400
> > [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb=
3a8c80
> > [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb=
3a9040
> > [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb=
3a92c0
> > [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 4096 ffff0000fb3=
a8000
>
> >
> > And without wiops, the result is quite different:
> >
> > ```
> > $ echo "8:16 wbps=3D10485760 wiops=3Dmax" > io.max
> >
> > $ dd if=3D/dev/zero of=3D/dev/sdb bs=3D50M count=3D1 oflag=3Ddirect
> > 1+0 records in
> > 1+0 records out
> > 52428800 bytes (52 MB, 50 MiB) copied, 5.08187 s, 10.3 MB/s
> >
> > $ dmesg -T
> > [Fri Aug 23 10:59:10 2024] __blk_throtl_bio: bio start 2880 ffff0000c74=
659c0
> > [Fri Aug 23 10:59:10 2024] __blk_throtl_bio: bio start 6992 ffff00014f6=
21b80
> > [Fri Aug 23 10:59:10 2024] __blk_throtl_bio: bio start 92528 ffff00014f=
620dc0
>
> I don't know why IO size from fs layer is different in this case.

Me neither...

>
> > ```
> >
> > Then, I retested for ext4 as you did.
> >
> > ```
> > $ lsblk
> > NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
> > sda      8:0    0   90G  0 disk
> > =E2=94=9C=E2=94=80sda1   8:1    0    1G  0 part /boot/efi
> > =E2=94=94=E2=94=80sda2   8:2    0 88.9G  0 part /
> > sdb      8:16   0   10G  0 disk
> >
> > $ df -T /data
> > Filesystem     Type 1K-blocks     Used Available Use% Mounted on
> > /dev/sda2      ext4  91222760 54648704  31894224  64% /
> > ```
> >
> > With wiops, the result is as follows:
> >
> > ```
> > $ echo "8:0 wbps=3D10485760 wiops=3D100000" > io.max
> >
> > $ rm -rf /data/file1 && dd if=3D/dev/zero of=3D/data/file1 bs=3D50M cou=
nt=3D1 oflag=3Ddirect
> > 1+0 records in
> > 1+0 records out
> > 52428800 bytes (52 MB, 50 MiB) copied, 5.06227 s, 10.4 MB/s
> >
> > $ dmesg -T
> > [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 2984 ffff0000fb3=
a8f00
> > [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 6176 ffff0000fb3=
a97c0
> > [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 7224 ffff0000fb3=
a9180
> > [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb=
3a8640
> > [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb=
3a9400
> > [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb=
3a8c80
> > [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb=
3a9040
> > [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb=
3a92c0
> > [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 4096 ffff0000fb3=
a8000
>
> >
> > And without wiops, the result is also quite different:
> >
> > ```
> > $ echo "8:0 wbps=3D10485760 wiops=3Dmax" > io.max
> >
> > $ rm -rf /data/file1 && dd if=3D/dev/zero of=3D/data/file1 bs=3D50M cou=
nt=3D1 oflag=3Ddirect
> > 1+0 records in
> > 1+0 records out
> > 52428800 bytes (52 MB, 50 MiB) copied, 5.03759 s, 10.4 MB/s
> >
> > $ dmesg -T
> > [Fri Aug 23 11:05:07 2024] __blk_throtl_bio: bio start 2904 ffff0000c4e=
9f2c0
> > [Fri Aug 23 11:05:07 2024] __blk_throtl_bio: bio start 5984 ffff0000c4e=
9e000
> > [Fri Aug 23 11:05:07 2024] __blk_throtl_bio: bio start 7496 ffff0000c4e=
9e3c0
> > [Fri Aug 23 11:05:07 2024] __blk_throtl_bio: bio start 16384 ffff0000c4=
e9eb40
> > [Fri Aug 23 11:05:07 2024] __blk_throtl_bio: bio start 16384 ffff0000c4=
e9f540
> > [Fri Aug 23 11:05:07 2024] __blk_throtl_bio: bio start 16384 ffff0000c4=
e9e780
> > [Fri Aug 23 11:05:07 2024] __blk_throtl_bio: bio start 16384 ffff0000c4=
e9ea00
> > [Fri Aug 23 11:05:07 2024] __blk_throtl_bio: bio start 16384 ffff0000c4=
e9f900
> > [Fri Aug 23 11:05:07 2024] __blk_throtl_bio: bio start 4096 ffff0000c4e=
9e8c0
>
> While ext4 is the same. And I won't say result is different here.

Perhap there is other subtle stuff at play since ext4 is the same?

> > [
> > ```
> >
> > Hmm... I still hava two questions here:
> > 1. Is wbps an average value?
>
> Yes.
> > 2. What's the difference between setting 'max' and setting a very high =
value for 'wiops'?
>
> The only difference is that:
>
> - If there is no iops limit, splited IO will be dispatched directly;
> - If there is iops limit, splited IO will be throttled again. iops is
> high, however, blk-throtl is FIFO, splited IO will have to wait for
> formal request to be throttled by bps first before checking the iops
> limit for splited IO.

Thanks a lot again for the lesson!
Lance

>
> Thanks,
> Kuai
>
> >
> > Thanks a lot again for your time!
> > Lance
> > .
> >
>

