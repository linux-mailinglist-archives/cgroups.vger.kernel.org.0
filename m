Return-Path: <cgroups+bounces-4205-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D7394F11F
	for <lists+cgroups@lfdr.de>; Mon, 12 Aug 2024 17:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03101280E03
	for <lists+cgroups@lfdr.de>; Mon, 12 Aug 2024 15:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC8F184540;
	Mon, 12 Aug 2024 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpl1q4FI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF3B1E877;
	Mon, 12 Aug 2024 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474873; cv=none; b=ZPtINduobIrd1Av3o0RdJfJYwHcnWsMFMC3Xgcuw/T4l1P3wRY3ZeBWfSqnCI6HvsDloAO/DlFnQdjLrUQtLx2HvHym1ti/XJdLDwDxxHCHWlBcwxap7jq6idIAWGTIUIz0lpcnt/l4YlB770KZZaQnuGlGbIs/tqJhWJ3uaoaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474873; c=relaxed/simple;
	bh=qtB7NZu+mhN/3RRkvOviezr09/JmUlBr4PSiAywVbTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aMKG4dyeC8GBaRg35bldouywZKlFQKBDQA5WnFKEYByOI2I3THD4fwICwPV0GVpa8Ru8T/ytm9wZ00b81ZOz4S1NRxjlIz8vXWptQVMnBHG8Gn+UGkkcCu6VHLDNN/FcnZfDm8VEruzC3ihhKm9golua5EX5NaUB1YLOFtLngQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpl1q4FI; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7107b16be12so3659627b3a.3;
        Mon, 12 Aug 2024 08:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723474871; x=1724079671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lSAp163vx0UuVbaXPTfbO7fD1LAtlFyXrCv1ZVeziqY=;
        b=hpl1q4FIHzgHp/3Vs9ujeFq63Iper3bv4arqOBqbS8cA1V75iKzw12Kwtt9mZHRfag
         ZlcSZkCZCvf8w6rFrt5oFXJUsqJRWGQ0e7jPRfe48OYmpJg9qp13NMwQcOkLD2XZxobR
         bDKmcz0Ojesk27b6n6VZFJBU6oU+vOljF7dI55Gq8uOSMgPunu2hDmPvZwSuIF0Ys4Ur
         03zZjeGW5wz/NZK+BdIb+k0lRtJRMLZo76pd2bK+r0QcSk4IIb++EkM2uLJmv+0MWNra
         I2spaAlcD3Qc/fI1MGYaYPXUzQfMUgp56jodnin3P20DaW7tXIgLh8B5E3B1XFX27R9r
         EubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723474871; x=1724079671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lSAp163vx0UuVbaXPTfbO7fD1LAtlFyXrCv1ZVeziqY=;
        b=rwb7mNuqS8eb1cFVP19Q4fiFXzM+hwVn5X7tIWIqCkmIBQMDus5SYRou9OOd35B5MM
         Lc9v01yxT5njyWc+P070lgTej4fjNDhBvLJCG5gf71DbpiTPpxj4m1AT9Yr0yzdO20oO
         5RKnIkOi3bZBTvf+V04osGXU+RPkCeLNO3Ysw1pfFtXg/la+8v4pS5Yd2YtTMETkWLBQ
         1x8lqKCXNvefJ7/lDKdv8aqkdxkWfrQiPw+YqBZ4aKaMU48ABl1vbbfsZlKSyHKMMkFG
         8UGjbPBonCcKFceHqaZbV0bNtykgs2/YGJPN1OLgNtfp/kE78YTw/f4jZ+aidepIxzUi
         pGDw==
X-Forwarded-Encrypted: i=1; AJvYcCXkINiCmIaDSOHQZQmpEkvlm/+XTW2hKrsZ2Ykvj4CGP4KnWIFBFTQfGlUdFUlWzUS1xktCnnIhRnSr91uqJhcjeJHODgySy9D4glTOeujLoweCwgEXdYDwpO5GwW1FlOwiMLH4Xw/prNJojji7ZM03+haLnL0iuLAheXxSSkk4iygq
X-Gm-Message-State: AOJu0YxwhQcX7SilAgUDJXh0xFNeS1qrOpQqT4P4CHDaMPkJr5qLgi7j
	jkZOjSJJNqcpHnNvU/m8BoR6hrjQdzJpEtDdJjbLZ5+LBOjWlFwF
X-Google-Smtp-Source: AGHT+IGh3SqpY5xyiidrIgiDY1lk35G5U0l0oc4IB+YQwEgHl2mDIOEsvV2Sz1kosVyBw1Tu78RqqQ==
X-Received: by 2002:a05:6a21:3945:b0:1c2:8eb7:19cd with SMTP id adf61e73a8af0-1c8d758ff6emr832729637.42.1723474870466;
        Mon, 12 Aug 2024 08:01:10 -0700 (PDT)
Received: from localhost.localdomain ([43.129.202.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbea9527sm4298859a12.93.2024.08.12.08.01.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Aug 2024 08:01:10 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: josef@toxicpanda.com,
	tj@kernel.org,
	fujita.tomonori@lab.ntt.co.jp,
	boqun.feng@gmail.com,
	a.hindborg@samsung.com,
	paolo.valente@unimore.it,
	axboe@kernel.dk,
	vbabka@kernel.org,
	mkoutny@suse.com,
	david@redhat.com,
	21cnbao@gmail.com,
	baolin.wang@linux.alibaba.com,
	libang.li@antgroup.com,
	Lance Yang <ioworker0@gmail.com>
Subject: [BUG] cgroupv2/blk: inconsistent I/O behavior in Cgroup v2 with set device wbps and wiops
Date: Mon, 12 Aug 2024 23:00:30 +0800
Message-ID: <20240812150049.8252-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

I've run into a problem with Cgroup v2 where it doesn't seem to correctly limit
I/O operations when I set both wbps and wiops for a device. However, if I only
set wbps, then everything works as expected.

To reproduce the problem, we can follow these command-based steps:

1. **System Information:**
   - Kernel Version and OS Release:
     ```
     $ uname -r
     6.10.0-rc5+

     $ cat /etc/os-release
     PRETTY_NAME="Ubuntu 24.04 LTS"
     NAME="Ubuntu"
     VERSION_ID="24.04"
     VERSION="24.04 LTS (Noble Numbat)"
     VERSION_CODENAME=noble
     ID=ubuntu
     ID_LIKE=debian
     HOME_URL="https://www.ubuntu.com/"
     SUPPORT_URL="https://help.ubuntu.com/"
     BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
     PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
     UBUNTU_CODENAME=noble
     LOGO=ubuntu-logo
     ```

2. **Device Information and Settings:**
   - List Block Devices and Scheduler:
     ```
     $ lsblk
     NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
     sda     8:0    0   4.4T  0 disk
     └─sda1  8:1    0   4.4T  0 part /data
     ...

     $ cat /sys/block/sda/queue/scheduler
     none [mq-deadline] kyber bfq

     $ cat /sys/block/sda/queue/rotational
     1
     ```

3. **Reproducing the problem:**
   - Navigate to the cgroup v2 filesystem and configure I/O settings:
     ```
     $ cd /sys/fs/cgroup/
     $ stat -fc %T /sys/fs/cgroup
     cgroup2fs
     $ mkdir test
     $ echo "8:0 wbps=10485760 wiops=100000" > io.max
     ```
     In this setup:
     wbps=10485760 sets the write bytes per second limit to 10 MB/s.
     wiops=100000 sets the write I/O operations per second limit to 100,000.

   - Add process to the cgroup and verify:
     ```
     $ echo $$ > cgroup.procs
     $ cat cgroup.procs
     3826771
     3828513
     $ ps -ef|grep 3826771
     root     3826771 3826768  0 22:04 pts/1    00:00:00 -bash
     root     3828761 3826771  0 22:06 pts/1    00:00:00 ps -ef
     root     3828762 3826771  0 22:06 pts/1    00:00:00 grep --color=auto 3826771
     ```

   - Observe I/O performance using `dd` commands and `iostat`:
     ```
     $ dd if=/dev/zero of=/data/file1 bs=512M count=1 &
     $ dd if=/dev/zero of=/data/file1 bs=512M count=1 &
     ```
     ```
     $ iostat -d 1 -h -y -p sda
     
	   tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd Device
     7.00         0.0k         1.3M         0.0k       0.0k       1.3M       0.0k sda
     7.00         0.0k         1.3M         0.0k       0.0k       1.3M       0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd Device
     5.00         0.0k         1.2M         0.0k       0.0k       1.2M       0.0k sda
     5.00         0.0k         1.2M         0.0k       0.0k       1.2M       0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd Device
    21.00         0.0k         1.4M         0.0k       0.0k       1.4M       0.0k sda
    21.00         0.0k         1.4M         0.0k       0.0k       1.4M       0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd Device
     5.00         0.0k         1.2M         0.0k       0.0k       1.2M       0.0k sda
     5.00         0.0k         1.2M         0.0k       0.0k       1.2M       0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd Device
     5.00         0.0k         1.2M         0.0k       0.0k       1.2M       0.0k sda
     5.00         0.0k         1.2M         0.0k       0.0k       1.2M       0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd Device
  1848.00         0.0k       448.1M         0.0k       0.0k     448.1M       0.0k sda
  1848.00         0.0k       448.1M         0.0k       0.0k     448.1M       0.0k sda1
     ```
Initially, the write speed is slow (<2MB/s) then suddenly bursts to several
hundreds of MB/s.

   - Testing with wiops set to max:
     ```
     echo "8:0 wbps=10485760 wiops=max" > io.max
     $ dd if=/dev/zero of=/data/file1 bs=512M count=1 &
     $ dd if=/dev/zero of=/data/file1 bs=512M count=1 &
     ```
     ```
     $ iostat -d 1 -h -y -p sda

      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd Device
    48.00         0.0k        10.0M         0.0k       0.0k      10.0M       0.0k sda
    48.00         0.0k        10.0M         0.0k       0.0k      10.0M       0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd Device
    40.00         0.0k        10.0M         0.0k       0.0k      10.0M       0.0k sda
    40.00         0.0k        10.0M         0.0k       0.0k      10.0M       0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd Device
    41.00         0.0k        10.0M         0.0k       0.0k      10.0M       0.0k sda
    41.00         0.0k        10.0M         0.0k       0.0k      10.0M       0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd Device
    46.00         0.0k        10.0M         0.0k       0.0k      10.0M       0.0k sda
    46.00         0.0k        10.0M         0.0k       0.0k      10.0M       0.0k sda1


      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd Device
    55.00         0.0k        10.2M         0.0k       0.0k      10.2M       0.0k sda
    55.00         0.0k        10.2M         0.0k       0.0k      10.2M       0.0k sda1
     ```
The iostat output shows the write operations as stabilizing at around 10 MB/s,
which aligns with the defined limit of 10 MB/s. After setting wiops to max, the
I/O limits appear to work as expected. 


Thanks,
Lance

