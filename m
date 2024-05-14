Return-Path: <cgroups+bounces-2874-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DE08C4B34
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 04:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DA4BB22B6E
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 02:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A0EAD32;
	Tue, 14 May 2024 02:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOhjoXpO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1629979D2;
	Tue, 14 May 2024 02:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715654269; cv=none; b=CDQn6Dz0Bfe0D7v5gL1ki9nfJd9rzTXKSRLhsSpGPFTLiraOS3JmCSktNoYs1a6HGpaCGWYMXvukXf6Idv4Sb5uiG5/tLTcMYHbPRM90mGFl60X+jNzvl10mkfKCdkydBL/eQtIsE2aIV8DfRDsorvkvZmqLD8WxgBqTVuv/ejU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715654269; c=relaxed/simple;
	bh=ekzT3/ALmq1PjIJdX057ZpcKoIJb0LpnFk9nb9TeOgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLrOMON34Qgon6Hp9bhseMkLcHIG8WVmMF/e+rrtrJHVivRwzC/SomsKv6Iqpo3AGubDQmNTMC/kIbK8/+aVk2grWpW7BlqDSGlCWolqFGK4OeBHstvIFwfEUegZ5jubcGGyawp6CI/BK80GHLNK89o0Pv1mwzBw8c7331j2NMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOhjoXpO; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51ef64d051bso5834638e87.1;
        Mon, 13 May 2024 19:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715654266; x=1716259066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYzw8FYz26q93IeZfDcCF7zSochl7yn4cVs5hUQhg0w=;
        b=UOhjoXpOn839HQEIUXQbWRFhQL0Xu1FDOAX7kaVJ/jkMVJ5y+ax94VX+4WBKQVAKg7
         oP93FN/+rlN/PZ2rTaxjH/A10uBg4nz6sE1CEcI6iFFpPMS9H3UkzWjuoW0Awo8Gbp/w
         cdWFimdVWjEv5MQp0j4exmrzBQrU4kzBCzdPSHj7XBoAg2+rYQe4vdmgnSoqXsXJ5FeB
         G7MJU9ySotZCUoEWQOWnXHHc2MrsY9mXdQ223bspJAcvg+oZ93XzdV7rgWgTtJ+PlB5T
         1fPlyzvi2J3Nr5KPreJuMTdRrS5Qk9e/331AjEK8KfV6u1RVQ+taNzVF8oA7rE/6Zy7K
         8aJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715654266; x=1716259066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYzw8FYz26q93IeZfDcCF7zSochl7yn4cVs5hUQhg0w=;
        b=oNNqXAKGRUE3YNiltmhPKw8u4tegAg59VhzKI4jOq4hiHASszLv928OxQAOqO9ZYit
         D7Pxbkno2q3DfpZumgMpVY6IWcrc4icTbEyuCIghQVc13PxPQ+B0z+NIoBFspoutkPJn
         dUbAvsRbUlio0ghwC5bxjL+i+s3Oesbw7iyAzIX7M94cSlPz5iwmdJxa1QX79FaLQ8Pp
         LPYMSglcna+8oXqlDmY1294CrYQEsVcN114WokqA+IgTGL6Ii01wkg7RT/mHjE4lGrxB
         Hz5d7hqiYO2P8SrcGKZK0Ip32EzYgXw0FjYVCDuNHX7NYzbnP32erHNXFB7gdwriJ/qV
         JAPw==
X-Forwarded-Encrypted: i=1; AJvYcCX71/ml//VFKCBOYaX5xfRQMhWZnEbdGkfM+zYUnxNQMrZ7N40V3wzWBZJFDP4kNa93aKQuo9KqNsRZZ4wj1Sd+aCWryJLT7HpnWJY1uKMGmoLuHkpIyi4+Y97YaPxHtqqcX+QUYGueCg97rdHYowfNU/RBxfMoNjJ/6iPaJZy4Rzox
X-Gm-Message-State: AOJu0Yxw0u1iQQIgmpwhAufBd7fZddkpQnZA6Dl352pPFVUtBWDJ2MpA
	q2jC+O7rirUZSfccLbUTHavbYrfGfHCYoG8KgroK2ZQ0YbpKSfGFm0F38EvZuXrYTydt0zXs8EN
	yRFGoV/3FTgMukZVCq+kDKYERs2k=
X-Google-Smtp-Source: AGHT+IFNDspAwtyzoDLuNze7g9mcZhGYAjP0GU2W7ymEHWo1OP7lcHugnImIwqWWiKNTUnOO1zZoCH3B7ZuG5lEgDsE=
X-Received: by 2002:a05:6512:1c8:b0:51c:3e9e:98ee with SMTP id
 2adb3069b0e04-5220fb6b067mr6954023e87.23.1715654265932; Mon, 13 May 2024
 19:37:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509023937.1090421-1-zhaoyang.huang@unisoc.com>
 <20240509023937.1090421-3-zhaoyang.huang@unisoc.com> <Zjw_0UPKvGkPfKFO@casper.infradead.org>
 <CAGWkznGZP3KUBN2M6syrjTmVOdSM0zx23hcJ6+hqE8Drgz2f-A@mail.gmail.com>
 <Zj2R_UH0JMspexp5@casper.infradead.org> <CAGWkznHX3OBeMh7-jvAP1HyVaT=TN6Fs2ArUCkUHtE3nVadaDA@mail.gmail.com>
In-Reply-To: <CAGWkznHX3OBeMh7-jvAP1HyVaT=TN6Fs2ArUCkUHtE3nVadaDA@mail.gmail.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 14 May 2024 10:37:34 +0800
Message-ID: <CAGWkznGYBAWQCBFRbFCVkFcUZsZ77+yf+Pun6NS8EpmdKdsaBQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] mm: introduce budgt control in readahead
To: Matthew Wilcox <willy@infradead.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 3:35=E2=80=AFPM Zhaoyang Huang <huangzhaoyang@gmail=
.com> wrote:
>
> On Fri, May 10, 2024 at 11:18=E2=80=AFAM Matthew Wilcox <willy@infradead.=
org> wrote:
> >
> > On Fri, May 10, 2024 at 10:43:20AM +0800, Zhaoyang Huang wrote:
> > > Thanks for the prompt. I did some basic research on soft RAID and
> > > wonder if applying the bps limit on /dev/md0 like below could make
> > > this work.
> >
> > No.  Look at btrfs' raid support, for example.  it doesn't use md0.
> If I understand the below command correctly, btrfs uses one of the
> volumes within RAID as the mount block device, not /dev/md0. However,
> I think this is a problem of blkio.throttle rather than this commit
> which means this readahead budget control will work accordingly as
> long as blkio.throttle's parameter is configured correctly(eg. 50/50
> on sdb and sdc)
>
> mkfs.btrfs -m raid0 -d raid0 /dev/sdb /dev/sdc
> mount -t btrfs /dev/sdb /mnt/btr
>
>
>
> >
> > > I didn't find information about 'RAID internally'. Could we set the
> > > limit on the root device(the one used for mount) to manage the whole
> > > partition without caring about where the bio finally goes? Or ask the
> > > user to decide if to use by making sure the device they apply will no=
t
> > > do RAID?
> >
> > No.

@all, Please find below for more test results where we can find this
commit has the result meet the desired value more closely and enhance
it by 3% than mainline.

echo "254:48 20000000" > blkio.throttle.read_bps_device
fio -filename=3D/data/ylog/ap/000-0101_000015_poweron.ylog -rw=3Dread
-direct=3D0 -bs=3D4k -size=3D2000M -numjobs=3D8 -group_reporting -name=3Dmy=
test

    before : IOPS=3D37.9k, BW=3D148MiB/s (155MB/s)(11.6GiB/80333msec)
    after  : IOPS=3D39.0k, BW=3D153MiB/s (160MB/s)(15.6GiB/104914msec)

    before : clat (usec): min=3D4, max=3D1056.6k, avg=3D197.23, stdev=3D100=
80.69
    after  : clat (usec): min=3D4, max=3D193481, avg=3D188.83, stdev=3D4651=
.29

    before : lat (usec): min=3D5, max=3D1056.6k, avg=3D200.48, stdev=3D1008=
0.76
    after  : lat (usec): min=3D5, max=3D193483, avg=3D192.68, stdev=3D4651.=
87


echo "254:48 30000000" > blkio.throttle.read_bps_device
fio -filename=3D/data/ylog/ap/000-0101_000015_poweron.ylog -rw=3Dread
-direct=3D0 -bs=3D4k -size=3D2000M -numjobs=3D8 -group_reporting -name=3Dmy=
test

    before : IOPS=3D57.2k, BW=3D224MiB/s (234MB/s)(15.6GiB/71561msec)
    after  : IOPS=3D58.5k, BW=3D229MiB/s (240MB/s)(15.6GiB/69996msec)

    before : clat (usec): min=3D4, max=3D1105.5k, avg=3D126.20, stdev=3D641=
9.22
    after  : clat (usec): min=3D4, max=3D183956, avg=3D120.60, stdev=3D2957=
.28

    before : lat (usec): min=3D5, max=3D1105.5k, avg=3D129.45, stdev=3D6419=
.29
    after  : lat (usec): min=3D5, max=3D183958, avg=3D124.40, stdev=3D2958.=
18

