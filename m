Return-Path: <cgroups+bounces-4206-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E98E694F1EB
	for <lists+cgroups@lfdr.de>; Mon, 12 Aug 2024 17:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A89B1C220B5
	for <lists+cgroups@lfdr.de>; Mon, 12 Aug 2024 15:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49E918454C;
	Mon, 12 Aug 2024 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dQnFbALU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A99B184537
	for <cgroups@vger.kernel.org>; Mon, 12 Aug 2024 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477390; cv=none; b=NfLWRkAftUMRngDfsLTjTsDlS6Jsa4OsOedCorB58v/GO3pOK207ZoHHcUyCIQNVWo3MrfwRXfd2x6Xoh9fChvwUVK8z4BZuYTPxZEynw6QT7N5uZCgig9Hcqik/2vCevQI7w+vvvrhSdRFjj/g1SvFx62GpY7b0EqzqD//aYeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477390; c=relaxed/simple;
	bh=ZH931ECWocAwRFg2I1K5DByOFyknsxAWzsXpgjkZhPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixZ7w5ufvFyoH2Jq/QgCPVAm/5x5NtVOaZ9MeX8cKD68as2gcA/OWKTNqpO5hpNQLUuw9s+iySN6Z+BKwYod2KIwAFMhiXStoXIsx8ykwJAQIXj0nFNBs3o4m0F5KpKiA+W4gBuVk4lfRuoLkZY0fNgwP07cDMWeCDgiad/F0I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dQnFbALU; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a156557026so4510815a12.2
        for <cgroups@vger.kernel.org>; Mon, 12 Aug 2024 08:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723477386; x=1724082186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Kd2QxG6rPBQQCGR+f4zRNeOOb8mEAgkCnPSorAh8lE=;
        b=dQnFbALUeo1MUSu8OgkEFRs9rMSrXZpfeMecgt8oe/d3jM7Ii7r2hC06N2CVsRculb
         e6bl/TRbo6QtD4E7GyMv9ZXvw4O1hANw+eHAuBhKETdFjhaHuIqXfLhgOLWCIV0rVnNo
         v6ds0Zx7BaoPvxqmQHb26z8Km/TMBdsjFnqyROh4cAlKj7fg5SnJbjsHXWkl21f4Fa4F
         MbZ6YQHVaW/jNhBBPKctp9yW16TzYnDfd8AIlCKPETL7sO5HT/Ccjh/eex8ZteQxUfw2
         7Ad3WrpHKesCUhZdm1fqSh9XhRheLbt2z5bvfSxpg/59/yvyvOdR4at1oVtfnAWfPElq
         jm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723477386; x=1724082186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Kd2QxG6rPBQQCGR+f4zRNeOOb8mEAgkCnPSorAh8lE=;
        b=ZVn0NfaXuzZRinDs9G8OED3RIDclVNK4kv4xXZ/QG0rKf0dsyykcw1O4Zo2fuE5wcm
         H6uA6kDqgcZAZMcAZM4pnOn6iuDoHuzK8q3qxlCw9d8sdZUlCxmmmmZ4YEGHg6kUBK4X
         2Bko3Qa5IUDI1Dc3KntEruQedZewpFaBa6Np+OQq1Tu7HpG9kwBtIBoJPi0Ge+VO2Uoo
         z2GWIxk/lDmlDje3qBt9enXlx3id3FcN4YmLrGCxAYjJMsyituiB2iFcvY9SGTMtegVC
         MwfdIr1DYEG0AdzW/hu0t0d7ZC/hmWB7Etzy7qI8ihlObacB00o3FixzBYIyngJTim1s
         1UhA==
X-Forwarded-Encrypted: i=1; AJvYcCWAf8NZ0cieO9R2QC/yMr3xwDzbcQJjozYPtEE9jauxCxBsUznX0q8kyr/cf366iiErYN5Ytexyw2Y4iUM0QOqcKBd2lX/FcA==
X-Gm-Message-State: AOJu0YzcXapfP2h1V5E1uSZfqIeessQYcI9oP+9f8w1c/5c2nFGeKs46
	++jdFUyz65bqonWDuQdg2hjaW+Hrx1mGjS+HNo1Jjqw296ypr+x2YqcyOiwK8p0=
X-Google-Smtp-Source: AGHT+IHZmIqej7ltDGnyTqGaSC79yZq9Lw/8TPyw7oq1fSnTNGiUK0CDNwWrb22vPVedQEiictjEFg==
X-Received: by 2002:a50:8dc7:0:b0:595:71c7:39dd with SMTP id 4fb4d7f45d1cf-5bd44c79eafmr415317a12.34.1723477386380;
        Mon, 12 Aug 2024 08:43:06 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd196a756esm2190058a12.52.2024.08.12.08.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:43:05 -0700 (PDT)
Date: Mon, 12 Aug 2024 17:43:04 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, cgroups@vger.kernel.org, josef@toxicpanda.com, tj@kernel.org, 
	fujita.tomonori@lab.ntt.co.jp, boqun.feng@gmail.com, a.hindborg@samsung.com, 
	paolo.valente@unimore.it, axboe@kernel.dk, vbabka@kernel.org, david@redhat.com, 
	21cnbao@gmail.com, baolin.wang@linux.alibaba.com, libang.li@antgroup.com, 
	Yu Kuai <yukuai3@huawei.com>
Subject: Re: [BUG] cgroupv2/blk: inconsistent I/O behavior in Cgroup v2 with
 set device wbps and wiops
Message-ID: <zjbn575huc6pk7jpv2ipoayfk4bvfu5z5imb5muk5drksa7p3q@xcr5imtt4zro>
References: <20240812150049.8252-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mkaklzxm72eg2bej"
Content-Disposition: inline
In-Reply-To: <20240812150049.8252-1-ioworker0@gmail.com>


--mkaklzxm72eg2bej
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

+Cc Kuai

On Mon, Aug 12, 2024 at 11:00:30PM GMT, Lance Yang <ioworker0@gmail.com> wr=
ote:
> Hi all,
>=20
> I've run into a problem with Cgroup v2 where it doesn't seem to correctly=
 limit
> I/O operations when I set both wbps and wiops for a device. However, if I=
 only
> set wbps, then everything works as expected.
>=20
> To reproduce the problem, we can follow these command-based steps:
>=20
> 1. **System Information:**
>    - Kernel Version and OS Release:
>      ```
>      $ uname -r
>      6.10.0-rc5+
>=20
>      $ cat /etc/os-release
>      PRETTY_NAME=3D"Ubuntu 24.04 LTS"
>      NAME=3D"Ubuntu"
>      VERSION_ID=3D"24.04"
>      VERSION=3D"24.04 LTS (Noble Numbat)"
>      VERSION_CODENAME=3Dnoble
>      ID=3Dubuntu
>      ID_LIKE=3Ddebian
>      HOME_URL=3D"https://www.ubuntu.com/"
>      SUPPORT_URL=3D"https://help.ubuntu.com/"
>      BUG_REPORT_URL=3D"https://bugs.launchpad.net/ubuntu/"
>      PRIVACY_POLICY_URL=3D"https://www.ubuntu.com/legal/terms-and-policie=
s/privacy-policy"
>      UBUNTU_CODENAME=3Dnoble
>      LOGO=3Dubuntu-logo
>      ```
>=20
> 2. **Device Information and Settings:**
>    - List Block Devices and Scheduler:
>      ```
>      $ lsblk
>      NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
>      sda     8:0    0   4.4T  0 disk
>      =E2=94=94=E2=94=80sda1  8:1    0   4.4T  0 part /data
>      ...
>=20
>      $ cat /sys/block/sda/queue/scheduler
>      none [mq-deadline] kyber bfq
>=20
>      $ cat /sys/block/sda/queue/rotational
>      1
>      ```
>=20
> 3. **Reproducing the problem:**
>    - Navigate to the cgroup v2 filesystem and configure I/O settings:
>      ```
>      $ cd /sys/fs/cgroup/
>      $ stat -fc %T /sys/fs/cgroup
>      cgroup2fs
>      $ mkdir test
>      $ echo "8:0 wbps=3D10485760 wiops=3D100000" > io.max
>      ```
>      In this setup:
>      wbps=3D10485760 sets the write bytes per second limit to 10 MB/s.
>      wiops=3D100000 sets the write I/O operations per second limit to 100=
,000.
>=20
>    - Add process to the cgroup and verify:
>      ```
>      $ echo $$ > cgroup.procs
>      $ cat cgroup.procs
>      3826771
>      3828513
>      $ ps -ef|grep 3826771
>      root     3826771 3826768  0 22:04 pts/1    00:00:00 -bash
>      root     3828761 3826771  0 22:06 pts/1    00:00:00 ps -ef
>      root     3828762 3826771  0 22:06 pts/1    00:00:00 grep --color=3Da=
uto 3826771
>      ```
>=20
>    - Observe I/O performance using `dd` commands and `iostat`:
>      ```
>      $ dd if=3D/dev/zero of=3D/data/file1 bs=3D512M count=3D1 &
>      $ dd if=3D/dev/zero of=3D/data/file1 bs=3D512M count=3D1 &
>      ```
>      ```
>      $ iostat -d 1 -h -y -p sda
>     =20
> 	   tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    k=
B_dscd Device
>      7.00         0.0k         1.3M         0.0k       0.0k       1.3M   =
    0.0k sda
>      7.00         0.0k         1.3M         0.0k       0.0k       1.3M   =
    0.0k sda1
>=20
>=20
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn   =
 kB_dscd Device
>      5.00         0.0k         1.2M         0.0k       0.0k       1.2M   =
    0.0k sda
>      5.00         0.0k         1.2M         0.0k       0.0k       1.2M   =
    0.0k sda1
>=20
>=20
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn   =
 kB_dscd Device
>     21.00         0.0k         1.4M         0.0k       0.0k       1.4M   =
    0.0k sda
>     21.00         0.0k         1.4M         0.0k       0.0k       1.4M   =
    0.0k sda1
>=20
>=20
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn   =
 kB_dscd Device
>      5.00         0.0k         1.2M         0.0k       0.0k       1.2M   =
    0.0k sda
>      5.00         0.0k         1.2M         0.0k       0.0k       1.2M   =
    0.0k sda1
>=20
>=20
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn   =
 kB_dscd Device
>      5.00         0.0k         1.2M         0.0k       0.0k       1.2M   =
    0.0k sda
>      5.00         0.0k         1.2M         0.0k       0.0k       1.2M   =
    0.0k sda1
>=20
>=20
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn   =
 kB_dscd Device
>   1848.00         0.0k       448.1M         0.0k       0.0k     448.1M   =
    0.0k sda
>   1848.00         0.0k       448.1M         0.0k       0.0k     448.1M   =
    0.0k sda1
>      ```
> Initially, the write speed is slow (<2MB/s) then suddenly bursts to sever=
al
> hundreds of MB/s.

What it would be on average?
IOW how long would the whole operation in throttled cgroup take?

>=20
>    - Testing with wiops set to max:
>      ```
>      echo "8:0 wbps=3D10485760 wiops=3Dmax" > io.max
>      $ dd if=3D/dev/zero of=3D/data/file1 bs=3D512M count=3D1 &
>      $ dd if=3D/dev/zero of=3D/data/file1 bs=3D512M count=3D1 &
>      ```
>      ```
>      $ iostat -d 1 -h -y -p sda
>=20
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn   =
 kB_dscd Device
>     48.00         0.0k        10.0M         0.0k       0.0k      10.0M   =
    0.0k sda
>     48.00         0.0k        10.0M         0.0k       0.0k      10.0M   =
    0.0k sda1
>=20
>=20
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn   =
 kB_dscd Device
>     40.00         0.0k        10.0M         0.0k       0.0k      10.0M   =
    0.0k sda
>     40.00         0.0k        10.0M         0.0k       0.0k      10.0M   =
    0.0k sda1
>=20
>=20
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn   =
 kB_dscd Device
>     41.00         0.0k        10.0M         0.0k       0.0k      10.0M   =
    0.0k sda
>     41.00         0.0k        10.0M         0.0k       0.0k      10.0M   =
    0.0k sda1
>=20
>=20
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn   =
 kB_dscd Device
>     46.00         0.0k        10.0M         0.0k       0.0k      10.0M   =
    0.0k sda
>     46.00         0.0k        10.0M         0.0k       0.0k      10.0M   =
    0.0k sda1
>=20
>=20
>       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn   =
 kB_dscd Device
>     55.00         0.0k        10.2M         0.0k       0.0k      10.2M   =
    0.0k sda
>     55.00         0.0k        10.2M         0.0k       0.0k      10.2M   =
    0.0k sda1
>      ```
> The iostat output shows the write operations as stabilizing at around 10 =
MB/s,
> which aligns with the defined limit of 10 MB/s. After setting wiops to ma=
x, the
> I/O limits appear to work as expected.=20
>=20
>=20
> Thanks,
> Lance

Thanks for the report Lance. Is this something you started seeing after
a kernel update or switch to cgroup v2? (Or you simply noticed with this
setup only?)


Michal

--mkaklzxm72eg2bej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZrothQAKCRAt3Wney77B
SSR7AQDYbqxZijycGMxpcelGXyctNdIBM47M8Why3R2HzYQBSQEA47s0N6yTrlnt
VHfknkNUobpvCMF9U3kDAj3zaVwfMw0=
=+ZWt
-----END PGP SIGNATURE-----

--mkaklzxm72eg2bej--

