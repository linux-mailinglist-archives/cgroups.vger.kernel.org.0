Return-Path: <cgroups+bounces-2861-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 721438C3011
	for <lists+cgroups@lfdr.de>; Sat, 11 May 2024 09:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33DC1C21673
	for <lists+cgroups@lfdr.de>; Sat, 11 May 2024 07:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8416C2FD;
	Sat, 11 May 2024 07:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVoAdqTG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90D3522A;
	Sat, 11 May 2024 07:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715412924; cv=none; b=n//LUOi99TLMfQYzANLPA9EOihFAjoHVtqgIHoaxEkCwPzX5/GNYMxT/jLqpurU+7a/7JpdkiWxGIFOGdVmp6uA/yE3OPUxAJFAvvu0YLO1SukrbxPLOV6vpks9L6shK8t7kWoTgP/hhU8jBR3/phfHEXnHqnbEnRxWxiZk7NW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715412924; c=relaxed/simple;
	bh=RCnR/Narod92mFqDOefmW4qo56aOWbIqph2R20YVQuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbnKWih/uJbfgWPVzNIadFZLcxZ3X72Pn2jl/iN7gY61eqlTi9w5mraj7UetLteMfq1a7kmZmprzMaDKItR+jDgFBGWL/fJLZuejPO0Ia1MXcjjlyaLEHfPgGqrghDfTx5ccNcS3r9uR/Fkm4HqQxMLfZAd39lKLt7QjbDDC94o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVoAdqTG; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51f1bf83f06so3266029e87.1;
        Sat, 11 May 2024 00:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715412921; x=1716017721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onldwQIzp78LG59n3NFElPNcsr9m2UJ7FD1wkPedMlM=;
        b=CVoAdqTG7Nz4W5HmK6Hov3YAsmJWnHzP9cZKnywWoDXkUlQYN5E0ZyviXAKFFYgbpn
         5A9Bn9I5ZFzWzm8WCwcxFWeGsOzNC2Xw79xljYTYAHCPRRcn9XXPtHF1PcuMJr3Ob7LL
         LQr6oGntS7dr5Faia9Cv49ryhrMftZ7VRRK7f/K+5QRLQRIzi46H9ENcKGPXaY/K+VxI
         Vvacm7wo2eiPi/sL8iW5u0uozMEfkpYcesA62fgsR4+EWcExuUri3rDxxUXStBa7NkrK
         YJDT4Uvfqk2G8evVuWreHxe+NB32Ki+JmVhNdwo2YxljOWL7G1qMoTCusyz8HDDDVOv2
         sUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715412921; x=1716017721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onldwQIzp78LG59n3NFElPNcsr9m2UJ7FD1wkPedMlM=;
        b=XPVQKa5f1r5/kKo9UUlW0+UKjrV9SotbyzCpDlMuzsxcJLIZnyr5ZSNvMxreVR57sG
         N3pESC5ZE7luja6weNIL1DVbDUoc3GKofMwUp/e2bNEw4rY6eq7r/h44Rg6sP/Op1d/x
         SMyc0NU+dlWGWXeUGUcqt5EOnwIxx5trrN3nwQQJVwyO4/Uz2hk7yB4Sm4+1I2Rv8Lgs
         NMt8DThPdCxIqCxpnswDL5mCEsuhnAx1laj2pQU0N3UmWTM0cj7qtJII7oWSWT9xK492
         zGDYxmKFYQ/rReBzvaQNLOo5mGjopqyi28YRo4uSdvlSa6wUgFW0jWhrNFj0mvLcY+tW
         J2kA==
X-Forwarded-Encrypted: i=1; AJvYcCURf+1644oYoT+1Zz8xihTN+sL1BWumctP0MdWzCjS2kRE8fb8tUoN7+6cEYEf9J0o5wgck3P45KIUFx2I0UHKg4oIvqphNxKNYFNI+vAB1l8KtSQ9yNfGzYns1Z7PPP8HWrmrfr8ZPZZ6jQKoev+KUzb42xiuHVi8rR9XSceQeLGET
X-Gm-Message-State: AOJu0YzIrvd1tMaeE/2MOfst0ivHWsY0BxGGQg4Ll3NNoPie+yxwrN5/
	F0fmtKRUdA5jr9jkCYqE5z2XrVSZ8aeioVT/GE7NTENdCaNAK2W6GLEeoptqO+u7AZz1hLDZmey
	lQI6de4LlYivXzZML6+mSzuyiOfA9lVIv
X-Google-Smtp-Source: AGHT+IGwYg82We3uLuR2mZ/xbiWuGjRpwEPg+Yy/6af9O3ukcvNdq4tIg71vISFu90ZIh+8muwTg9jg1Bla+rXCh2xI=
X-Received: by 2002:a05:6512:38d1:b0:51f:1853:25f with SMTP id
 2adb3069b0e04-5220fc79467mr2836408e87.19.1715412920609; Sat, 11 May 2024
 00:35:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509023937.1090421-1-zhaoyang.huang@unisoc.com>
 <20240509023937.1090421-3-zhaoyang.huang@unisoc.com> <Zjw_0UPKvGkPfKFO@casper.infradead.org>
 <CAGWkznGZP3KUBN2M6syrjTmVOdSM0zx23hcJ6+hqE8Drgz2f-A@mail.gmail.com> <Zj2R_UH0JMspexp5@casper.infradead.org>
In-Reply-To: <Zj2R_UH0JMspexp5@casper.infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Sat, 11 May 2024 15:35:09 +0800
Message-ID: <CAGWkznHX3OBeMh7-jvAP1HyVaT=TN6Fs2ArUCkUHtE3nVadaDA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] mm: introduce budgt control in readahead
To: Matthew Wilcox <willy@infradead.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 11:18=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Fri, May 10, 2024 at 10:43:20AM +0800, Zhaoyang Huang wrote:
> > Thanks for the prompt. I did some basic research on soft RAID and
> > wonder if applying the bps limit on /dev/md0 like below could make
> > this work.
>
> No.  Look at btrfs' raid support, for example.  it doesn't use md0.
If I understand the below command correctly, btrfs uses one of the
volumes within RAID as the mount block device, not /dev/md0. However,
I think this is a problem of blkio.throttle rather than this commit
which means this readahead budget control will work accordingly as
long as blkio.throttle's parameter is configured correctly(eg. 50/50
on sdb and sdc)

mkfs.btrfs -m raid0 -d raid0 /dev/sdb /dev/sdc
mount -t btrfs /dev/sdb /mnt/btr



>
> > I didn't find information about 'RAID internally'. Could we set the
> > limit on the root device(the one used for mount) to manage the whole
> > partition without caring about where the bio finally goes? Or ask the
> > user to decide if to use by making sure the device they apply will not
> > do RAID?
>
> No.

