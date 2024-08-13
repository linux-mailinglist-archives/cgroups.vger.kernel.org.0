Return-Path: <cgroups+bounces-4221-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E505794FD18
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 07:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14EFF1C22821
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 05:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C9C225AF;
	Tue, 13 Aug 2024 05:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IycqIcAQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAC623741;
	Tue, 13 Aug 2024 05:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723525924; cv=none; b=BerdiVMQVHqHLYlU1NyFU38q6H9mBiMmEgk6XyzVubPja9ruTH8PhuNjGQI0WdwUJa2V8yRVYE6jLMOCmAly846hpZ661TGAs7xvfWxB4AxgRr4zOYjjPinCOUiBOzFq9EAHi4Ut2B1ab6bjLnYnnp3U0Im/nRFzIgFK03mMi+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723525924; c=relaxed/simple;
	bh=HNZ4GYQXMWOoLmkS3WzlJc5HrZQW/hblLbhux2481/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVeBPMEVXu6cXEYKto35Nk5l7p673oGNvBqQKnuf3z2DlNTHG6qRAb+0rFi+BmK3WVZHNLXaDaElJoj/G5R8RnBQlGFSSIQBP1b/KR6i8fYrycNmT/Le0MBwshmkJgvO1zEtY13zh7oE22EXz9BRUzejXQy5pH7lmT0VZoab2yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IycqIcAQ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a10bb7bcd0so6254101a12.3;
        Mon, 12 Aug 2024 22:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723525921; x=1724130721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhT2Y2oF/uJ6fCpK+SpF85ANnuI7c6Ysyk5Jyojf0og=;
        b=IycqIcAQboXiO/yq/CXFqUpT22Sf2QrIYkgPGgdHOBabkcsmQFiFXmZxY2HjGZjcqy
         LLxCzFtlF6Vke0DLDp5tILZbeK/F+UldxjQpDuJt76DE9dMzyOzx20Kv+zipf/dbec2p
         wBzm3zyTkyKk1gMQeK7B9uTAGWur5cq+VEr5Q9JtO4HDTZOV+a4kW+AxLuh/otcOcjHe
         F64HtOLMSnsjURlioaMeGr/8PdTNudW00Fc3+3n5h+OQG/6vlhTmjBSUga6XfqPsPoXp
         qVb246D8ZlvInNtdJHvcOrrabQGI/IWcwASpuzxiyLhmcAJq0N1tPmSdxvyWf89vvqyL
         r+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723525921; x=1724130721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhT2Y2oF/uJ6fCpK+SpF85ANnuI7c6Ysyk5Jyojf0og=;
        b=Sh+nXna6S1DXunR/740CdjD1tOIJ4GCGPZgsdsX98jP86PM1n3UnQQd41ajKMtY1Yr
         kk9KFUVb6sH+zquhE+dZWAjLXRoj/pOfTw97ZMfIOgcL9ZObPOdUEzP8H2qbVs05T9ha
         3s8+mrCb2b9cHQRUVdLrKZJ7hq8zAOW7lbf1dabINBkgzNgIkXFotwQ0/AscnQbfBHf2
         3h6cxiAouGswIl2BUY+7UMeC4olPID3OXbddw0AjPQRaLMLkE3LohuuVePsq1NCbrTMn
         Y01rI57ZCJxjjZfyfhna5fB3dx2aMgjZWttD2GdvTyb4qCMT3flt3SBLTZYklvEz+lXF
         FHTA==
X-Forwarded-Encrypted: i=1; AJvYcCUFD+IcT1VLo+MEBRos2+aj21WS4VzGHYfhlQz3vOI2Zj6ThAyewnbMFUuEFwAAhErUqF+QuWD4AzFJcCRRovCsAFncAjMfAaot+JhJ6IkWmduTYiunX8Vj7rBX6rc3sO6IeHGpmp0c1w8+DEIKFA0YkTs1RT8MCj1SsDmhXO48mtMR
X-Gm-Message-State: AOJu0YwV3zaT5znuhUaB3uuOGwJRQQeH0ydS/F1+Tk/ZNuJ95DEg+ejr
	hFDjVwi3GCdhehoyKU9fiHTMDQ6WwjEjDX878+Wkhaxix0LOUZzZrPj+P7fFW8VMzlv6+8+MJym
	QEaQOmemPCIHB2oNrVLNw9cZFDDuvQFe9ddI=
X-Google-Smtp-Source: AGHT+IHY9qm5hOo0rihOZU0LIYFyLAAviDBaIbzofcC8Ywjoc5SlO7vwoHvwiGbR5dMn7tBFWDnGueFQeDifIUQjjIY=
X-Received: by 2002:a05:6402:3511:b0:5a0:e62c:61bd with SMTP id
 4fb4d7f45d1cf-5bd44c698b1mr1424586a12.29.1723525920619; Mon, 12 Aug 2024
 22:12:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812150049.8252-1-ioworker0@gmail.com> <zjbn575huc6pk7jpv2ipoayfk4bvfu5z5imb5muk5drksa7p3q@xcr5imtt4zro>
In-Reply-To: <zjbn575huc6pk7jpv2ipoayfk4bvfu5z5imb5muk5drksa7p3q@xcr5imtt4zro>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 13 Aug 2024 13:11:24 +0800
Message-ID: <CAK1f24=QwFrh3CfpV8kBrBsGVcyyLtfaNpy6ju8JJZctXqF+Xg@mail.gmail.com>
Subject: Re: [BUG] cgroupv2/blk: inconsistent I/O behavior in Cgroup v2 with
 set device wbps and wiops
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, cgroups@vger.kernel.org, josef@toxicpanda.com, 
	tj@kernel.org, fujita.tomonori@lab.ntt.co.jp, boqun.feng@gmail.com, 
	a.hindborg@samsung.com, paolo.valente@unimore.it, axboe@kernel.dk, 
	vbabka@kernel.org, david@redhat.com, 21cnbao@gmail.com, 
	baolin.wang@linux.alibaba.com, libang.li@antgroup.com, 
	Yu Kuai <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal,

Thanks a lot for jumping in!

On Mon, Aug 12, 2024 at 11:43=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.c=
om> wrote:
>
> +Cc Kuai
>
> On Mon, Aug 12, 2024 at 11:00:30PM GMT, Lance Yang <ioworker0@gmail.com> =
wrote:
> > Hi all,
> >
> > I've run into a problem with Cgroup v2 where it doesn't seem to correct=
ly limit
> > I/O operations when I set both wbps and wiops for a device. However, if=
 I only
> > set wbps, then everything works as expected.
> >
> > To reproduce the problem, we can follow these command-based steps:
> >
> > 1. **System Information:**
> >    - Kernel Version and OS Release:
> >      ```
> >      $ uname -r
> >      6.10.0-rc5+
> >
> >      $ cat /etc/os-release
> >      PRETTY_NAME=3D"Ubuntu 24.04 LTS"
> >      NAME=3D"Ubuntu"
> >      VERSION_ID=3D"24.04"
> >      VERSION=3D"24.04 LTS (Noble Numbat)"
> >      VERSION_CODENAME=3Dnoble
> >      ID=3Dubuntu
> >      ID_LIKE=3Ddebian
> >      HOME_URL=3D"https://www.ubuntu.com/"
> >      SUPPORT_URL=3D"https://help.ubuntu.com/"
> >      BUG_REPORT_URL=3D"https://bugs.launchpad.net/ubuntu/"
> >      PRIVACY_POLICY_URL=3D"https://www.ubuntu.com/legal/terms-and-polic=
ies/privacy-policy"
> >      UBUNTU_CODENAME=3Dnoble
> >      LOGO=3Dubuntu-logo
> >      ```
> >
> > 2. **Device Information and Settings:**
> >    - List Block Devices and Scheduler:
> >      ```
> >      $ lsblk
> >      NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
> >      sda     8:0    0   4.4T  0 disk
> >      =E2=94=94=E2=94=80sda1  8:1    0   4.4T  0 part /data
> >      ...
> >
> >      $ cat /sys/block/sda/queue/scheduler
> >      none [mq-deadline] kyber bfq
> >
> >      $ cat /sys/block/sda/queue/rotational
> >      1
> >      ```
> >
> > 3. **Reproducing the problem:**
> >    - Navigate to the cgroup v2 filesystem and configure I/O settings:
> >      ```
> >      $ cd /sys/fs/cgroup/
> >      $ stat -fc %T /sys/fs/cgroup
> >      cgroup2fs
> >      $ mkdir test
> >      $ echo "8:0 wbps=3D10485760 wiops=3D100000" > io.max
> >      ```
> >      In this setup:
> >      wbps=3D10485760 sets the write bytes per second limit to 10 MB/s.
> >      wiops=3D100000 sets the write I/O operations per second limit to 1=
00,000.
> >
> >    - Add process to the cgroup and verify:
> >      ```
> >      $ echo $$ > cgroup.procs
> >      $ cat cgroup.procs
> >      3826771
> >      3828513
> >      $ ps -ef|grep 3826771
> >      root     3826771 3826768  0 22:04 pts/1    00:00:00 -bash
> >      root     3828761 3826771  0 22:06 pts/1    00:00:00 ps -ef
> >      root     3828762 3826771  0 22:06 pts/1    00:00:00 grep --color=
=3Dauto 3826771
> >      ```
> >
> >    - Observe I/O performance using `dd` commands and `iostat`:
> >      ```
> >      $ dd if=3D/dev/zero of=3D/data/file1 bs=3D512M count=3D1 &
> >      $ dd if=3D/dev/zero of=3D/data/file1 bs=3D512M count=3D1 &
> >      ```
> >      ```
> >      $ iostat -d 1 -h -y -p sda
> >
> >          tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wr=
tn    kB_dscd Device
> >      7.00         0.0k         1.3M         0.0k       0.0k       1.3M =
      0.0k sda
> >      7.00         0.0k         1.3M         0.0k       0.0k       1.3M =
      0.0k sda1
> >
> >
> >       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn =
   kB_dscd Device
> >      5.00         0.0k         1.2M         0.0k       0.0k       1.2M =
      0.0k sda
> >      5.00         0.0k         1.2M         0.0k       0.0k       1.2M =
      0.0k sda1
> >
> >
> >       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn =
   kB_dscd Device
> >     21.00         0.0k         1.4M         0.0k       0.0k       1.4M =
      0.0k sda
> >     21.00         0.0k         1.4M         0.0k       0.0k       1.4M =
      0.0k sda1
> >
> >
> >       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn =
   kB_dscd Device
> >      5.00         0.0k         1.2M         0.0k       0.0k       1.2M =
      0.0k sda
> >      5.00         0.0k         1.2M         0.0k       0.0k       1.2M =
      0.0k sda1
> >
> >
> >       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn =
   kB_dscd Device
> >      5.00         0.0k         1.2M         0.0k       0.0k       1.2M =
      0.0k sda
> >      5.00         0.0k         1.2M         0.0k       0.0k       1.2M =
      0.0k sda1
> >
> >
> >       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn =
   kB_dscd Device
> >   1848.00         0.0k       448.1M         0.0k       0.0k     448.1M =
      0.0k sda
> >   1848.00         0.0k       448.1M         0.0k       0.0k     448.1M =
      0.0k sda1
> >      ```
> > Initially, the write speed is slow (<2MB/s) then suddenly bursts to sev=
eral
> > hundreds of MB/s.
>
> What it would be on average?
> IOW how long would the whole operation in throttled cgroup take?
>
> >
> >    - Testing with wiops set to max:
> >      ```
> >      echo "8:0 wbps=3D10485760 wiops=3Dmax" > io.max
> >      $ dd if=3D/dev/zero of=3D/data/file1 bs=3D512M count=3D1 &
> >      $ dd if=3D/dev/zero of=3D/data/file1 bs=3D512M count=3D1 &
> >      ```
> >      ```
> >      $ iostat -d 1 -h -y -p sda
> >
> >       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn =
   kB_dscd Device
> >     48.00         0.0k        10.0M         0.0k       0.0k      10.0M =
      0.0k sda
> >     48.00         0.0k        10.0M         0.0k       0.0k      10.0M =
      0.0k sda1
> >
> >
> >       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn =
   kB_dscd Device
> >     40.00         0.0k        10.0M         0.0k       0.0k      10.0M =
      0.0k sda
> >     40.00         0.0k        10.0M         0.0k       0.0k      10.0M =
      0.0k sda1
> >
> >
> >       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn =
   kB_dscd Device
> >     41.00         0.0k        10.0M         0.0k       0.0k      10.0M =
      0.0k sda
> >     41.00         0.0k        10.0M         0.0k       0.0k      10.0M =
      0.0k sda1
> >
> >
> >       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn =
   kB_dscd Device
> >     46.00         0.0k        10.0M         0.0k       0.0k      10.0M =
      0.0k sda
> >     46.00         0.0k        10.0M         0.0k       0.0k      10.0M =
      0.0k sda1
> >
> >
> >       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn =
   kB_dscd Device
> >     55.00         0.0k        10.2M         0.0k       0.0k      10.2M =
      0.0k sda
> >     55.00         0.0k        10.2M         0.0k       0.0k      10.2M =
      0.0k sda1
> >      ```
> > The iostat output shows the write operations as stabilizing at around 1=
0 MB/s,
> > which aligns with the defined limit of 10 MB/s. After setting wiops to =
max, the
> > I/O limits appear to work as expected.
> >
> >
> > Thanks,
> > Lance
>
> Thanks for the report Lance. Is this something you started seeing after
> a kernel update or switch to cgroup v2? (Or you simply noticed with this
> setup only?)

I just switched to cgroup v2 to begin testing, as we intend to have
containers run
in cgroup v2. Testing on both the 5.14.0 and mainline versions ;)

Thanks again for your time!
Lance

>
>
> Michal

