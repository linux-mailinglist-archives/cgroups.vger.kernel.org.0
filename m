Return-Path: <cgroups+bounces-4427-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1730695CC3F
	for <lists+cgroups@lfdr.de>; Fri, 23 Aug 2024 14:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AFF9B21F37
	for <lists+cgroups@lfdr.de>; Fri, 23 Aug 2024 12:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958CE184548;
	Fri, 23 Aug 2024 12:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xa6v6zEA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BEE9457;
	Fri, 23 Aug 2024 12:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724415598; cv=none; b=AXf/6i9y690jAndxsSn/pyOZ8lHa+3ASqCrtHlg8VWmcvRD9ktyeEiQi8wQA1eT62sMEko58s7Wo66wZ5fvDleXFE5vCF1Z7wxxjqhWj592hmP1SLqpOQdLIwayc9hujAZfyH2eAgFJnigiDi/SlrZY8OB2qEqMgUEqB5gTi99M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724415598; c=relaxed/simple;
	bh=UNUCMHj/hyaQMFc8KHdZF7HyFyUqAA9VUiUHkYXLnpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEQKhnPrBB9/1iaUqhwp94lUU/9oVPS9As8CP948Oe/ZaTAfSa2jCmqfLngdLZ1Uq5zeWc5CQll8HSKKLQBcqBjQP4xxMPu0decOBOgI3tpxL/iZWQJxGcy4QJaHxRHaWx37nz79GAKqDQDosUoxcTtPHNDex2XfXbdcAm4HRmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xa6v6zEA; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7140ff4b1e9so1564857b3a.3;
        Fri, 23 Aug 2024 05:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724415596; x=1725020396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNUCMHj/hyaQMFc8KHdZF7HyFyUqAA9VUiUHkYXLnpM=;
        b=Xa6v6zEA7tUCKrIb6hfZzLzdaLXhpfT2d2451CCsYTs4yXdJX4Kz4r7iLdu4VE2Blj
         2Lf8rVGpxBdHDIuYerhg3qfo9+TRgmlRMsK3N9NYQl37FHC9fEnG7PzqUr6ludPTb3do
         9+G0/OOE6QiUmVPVOVzdEPvssmdYdCtGlDmH/fkE7UoFxulZBvucPnuRtf90lZszHlH6
         lYQNkmZwMv/1ua27NiRDVurAeMC4avrRL5/OSoG9NK+lWn2RHkmz4DtapRGltGI5231D
         NaUE+M5fRqXPmQUgYLuUwMa/6Ub/iaA3Afm4g6MoccobCzRxrynXRif0Apg7UoIPR1Da
         9CBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724415596; x=1725020396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNUCMHj/hyaQMFc8KHdZF7HyFyUqAA9VUiUHkYXLnpM=;
        b=kq/jVRHk7tJZgDjImDSRD7lft69ECCOxnygvZ2zX9UWBpW5qljDLXyJ/tbtoZRGt1S
         Ft65jKSe2L4m6QeSZwLMJPnks8flOYyltoWQ+c2SuPQTfEyYOwlYVGO43N3r5pWsCT5X
         ti2hHestAcBCNscn1FDGHp7HaEDF4jccWOFjOhvtpgFfQupLcGPVz6dr919kNvbyKzsa
         Zbno8aRxoB2jBPzY65t8LCVsD4kwME4Nuq9UU3QDT43qS/eFzgIP943ljZiz/y/rINkg
         0SEm5e5aeC6LWBZuweTTdxPvZbhn0Fb+3eE0w8H355w6jLQaY/PPEKugDaBrGnRODLb+
         Pl0A==
X-Forwarded-Encrypted: i=1; AJvYcCVK1XWCsQ3DNBxNzMrf7ZCh09js8gagqBHBpFGOG6Z247diqJvZ38+v91NfolAS6o0lUpdGi1/sahfjWYwm@vger.kernel.org, AJvYcCWvgtBX8whVrmU74OeKF0PzBBDL1SKIRErg0tcjCXgknszoWpMvuYrowNxsAsIz6yNcPPgHah7L@vger.kernel.org, AJvYcCXCKfaHkFI5dmLEb/b/hmKholwPHhghpBZK6NQi5NJXZaLMMBEGUArqVIN+w+K0BlAgEynYodElts8QYMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY8J8ym/cyqBUUCBGmW3hLzxTV6s80VyiW7S+YtAQk4/IoQzaX
	WV8spB+fWgdF1kGxxvvXyvLbmN1do+liqHfgfIAdykDyiLy6xneA
X-Google-Smtp-Source: AGHT+IGzc7ioPCbQCUlxcip72zBvSMtYRgGsnomQD6AMKfga1Ybtd8vRCH2kemIvGrXuqleOIpl3tQ==
X-Received: by 2002:a05:6a20:e18a:b0:1c3:ff33:246b with SMTP id adf61e73a8af0-1cc89ed999cmr2643659637.40.1724415595687;
        Fri, 23 Aug 2024 05:19:55 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad5529csm2955543a12.68.2024.08.23.05.19.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Aug 2024 05:19:55 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: yukuai1@huaweicloud.com
Cc: 21cnbao@gmail.com,
	a.hindborg@samsung.com,
	axboe@kernel.dk,
	baolin.wang@linux.alibaba.com,
	boqun.feng@gmail.com,
	cgroups@vger.kernel.org,
	david@redhat.com,
	fujita.tomonori@lab.ntt.co.jp,
	ioworker0@gmail.com,
	josef@toxicpanda.com,
	libang.li@antgroup.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mkoutny@suse.com,
	paolo.valente@unimore.it,
	tj@kernel.org,
	vbabka@kernel.org,
	yukuai3@huawei.com
Subject: Re: [BUG] cgroupv2/blk: inconsistent I/O behavior in Cgroup v2 with set device wbps and wiops
Date: Fri, 23 Aug 2024 20:19:39 +0800
Message-ID: <20240823121939.65934-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <7c3499ac-faa7-cc0c-2d90-b8291fce5492@huaweicloud.com>
References: <7c3499ac-faa7-cc0c-2d90-b8291fce5492@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forget to add the test result of buffered IO:

With wiops, the result is as follows:

```
$ echo "8:0 wbps=10485760 wiops=100000" > io.max

$ rm -rf /data/file1 && dd if=/dev/zero of=/data/file1 bs=50M count=1
1+0 records in
1+0 records out
52428800 bytes (52 MB, 50 MiB) copied, 0.062217 s, 843 MB/s

$ dmesg -T
[Fri Aug 23 12:09:10 2024] __blk_throtl_bio: bio start 16384 ffff0000ce5ac500
[Fri Aug 23 12:09:10 2024] __blk_throtl_bio: bio start 16384 ffff0000ce5adb80
[Fri Aug 23 12:09:10 2024] __blk_throtl_bio: bio start 16384 ffff0000ce5ac140
[Fri Aug 23 12:09:10 2024] __blk_throtl_bio: bio start 16384 ffff0000ce5acdc0
[Fri Aug 23 12:09:10 2024] __blk_throtl_bio: bio start 16384 ffff0000ce5ac280
[Fri Aug 23 12:09:10 2024] __blk_throtl_bio: bio start 16384 ffff0000ce5ada40
[Fri Aug 23 12:09:10 2024] __blk_throtl_bio: bio start 4096 ffff0000ce5adcc0
[Fri Aug 23 12:09:10 2024] blk_throtl_dispatch_work_fn: bio done 16384 ffff0000ce5ac500
[Fri Aug 23 12:09:10 2024] __blk_throtl_bio: bio start 13824 ffff0000ce5ac500
[Fri Aug 23 12:09:11 2024] blk_throtl_dispatch_work_fn: bio done 16384 ffff0000ce5adb80
[Fri Aug 23 12:09:11 2024] __blk_throtl_bio: bio start 13824 ffff0000ce5adb80
[Fri Aug 23 12:09:12 2024] blk_throtl_dispatch_work_fn: bio done 16384 ffff0000ce5ac140
[Fri Aug 23 12:09:12 2024] __blk_throtl_bio: bio start 13824 ffff0000ce5ac140
[Fri Aug 23 12:09:13 2024] blk_throtl_dispatch_work_fn: bio done 16384 ffff0000ce5acdc0
[Fri Aug 23 12:09:13 2024] __blk_throtl_bio: bio start 13824 ffff0000ce5acdc0
[Fri Aug 23 12:09:14 2024] blk_throtl_dispatch_work_fn: bio done 16384 ffff0000ce5ac280
[Fri Aug 23 12:09:14 2024] __blk_throtl_bio: bio start 13824 ffff0000ce5ac280
[Fri Aug 23 12:09:14 2024] blk_throtl_dispatch_work_fn: bio done 16384 ffff0000ce5ada40
[Fri Aug 23 12:09:14 2024] __blk_throtl_bio: bio start 13824 ffff0000ce5ada40
[Fri Aug 23 12:09:15 2024] blk_throtl_dispatch_work_fn: bio done 4096 ffff0000ce5adcc0
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 1536 ffff0000ce5adcc0
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 1536 ffff0000ce5adcc0
[Fri Aug 23 12:09:15 2024] blk_throtl_dispatch_work_fn: bio done 13824 ffff0000ce5ac500
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 11264 ffff0000ce5ac500
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 11264 ffff0000ce5ac500
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 8704 ffff0000ce5ac500
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 8704 ffff0000ce5ac500
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 6144 ffff0000ce5ac500
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 6144 ffff0000ce5ac500
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 3584 ffff0000ce5ac500
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 3584 ffff0000ce5ac500
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 1024 ffff0000ce5ac500
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 1024 ffff0000ce5ac500
[Fri Aug 23 12:09:15 2024] blk_throtl_dispatch_work_fn: bio done 13824 ffff0000ce5adb80
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 11264 ffff0000ce5adb80
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 11264 ffff0000ce5adb80
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 8704 ffff0000ce5adb80
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 8704 ffff0000ce5adb80
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 6144 ffff0000ce5adb80
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 6144 ffff0000ce5adb80
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 3584 ffff0000ce5adb80
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 3584 ffff0000ce5adb80
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 1024 ffff0000ce5adb80
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 1024 ffff0000ce5adb80
[Fri Aug 23 12:09:15 2024] blk_throtl_dispatch_work_fn: bio done 13824 ffff0000ce5ac140
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 11264 ffff0000ce5ac140
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 11264 ffff0000ce5ac140
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 8704 ffff0000ce5ac140
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 8704 ffff0000ce5ac140
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 6144 ffff0000ce5ac140
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 6144 ffff0000ce5ac140
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 3584 ffff0000ce5ac140
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 3584 ffff0000ce5ac140
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 1024 ffff0000ce5ac140
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 1024 ffff0000ce5ac140
[Fri Aug 23 12:09:15 2024] blk_throtl_dispatch_work_fn: bio done 13824 ffff0000ce5acdc0
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 11264 ffff0000ce5acdc0
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 11264 ffff0000ce5acdc0
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 8704 ffff0000ce5acdc0
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 8704 ffff0000ce5acdc0
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 6144 ffff0000ce5acdc0
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 6144 ffff0000ce5acdc0
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 3584 ffff0000ce5acdc0
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 3584 ffff0000ce5acdc0
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 1024 ffff0000ce5acdc0
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 1024 ffff0000ce5acdc0
[Fri Aug 23 12:09:15 2024] blk_throtl_dispatch_work_fn: bio done 13824 ffff0000ce5ac280
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 11264 ffff0000ce5ac280
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 11264 ffff0000ce5ac280
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 8704 ffff0000ce5ac280
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 8704 ffff0000ce5ac280
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 6144 ffff0000ce5ac280
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 6144 ffff0000ce5ac280
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 3584 ffff0000ce5ac280
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 3584 ffff0000ce5ac280
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 1024 ffff0000ce5ac280
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 1024 ffff0000ce5ac280
[Fri Aug 23 12:09:15 2024] blk_throtl_dispatch_work_fn: bio done 13824 ffff0000ce5ada40
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 11264 ffff0000ce5ada40
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 11264 ffff0000ce5ada40
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 8704 ffff0000ce5ada40
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 8704 ffff0000ce5ada40
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 6144 ffff0000ce5ada40
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 6144 ffff0000ce5ada40
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 3584 ffff0000ce5ada40
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 3584 ffff0000ce5ada40
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio start 1024 ffff0000ce5ada40
[Fri Aug 23 12:09:15 2024] __blk_throtl_bio: bio done 1024 ffff0000ce5ada40
```

And without wiops, the result is quite different as well:

```
$ echo "8:0 wbps=10485760 wiops=max" > io.max

$ rm -rf /data/file1 && dd if=/dev/zero of=/data/file1 bs=50M count=1
1+0 records in
1+0 records out
52428800 bytes (52 MB, 50 MiB) copied, 0.0791369 s, 663 MB/s

$ dmesg -T
[Fri Aug 23 12:16:50 2024] __blk_throtl_bio: bio start 16384 ffff0000f87ca3c0
[Fri Aug 23 12:16:50 2024] __blk_throtl_bio: bio start 16384 ffff0000f87ca000
[Fri Aug 23 12:16:50 2024] __blk_throtl_bio: bio start 16384 ffff0000f87cb2c0
[Fri Aug 23 12:16:50 2024] __blk_throtl_bio: bio start 16384 ffff0000f87cb040
[Fri Aug 23 12:16:50 2024] __blk_throtl_bio: bio start 16384 ffff0000f87cac80
[Fri Aug 23 12:16:50 2024] __blk_throtl_bio: bio start 16384 ffff0000f87cb400
[Fri Aug 23 12:16:50 2024] __blk_throtl_bio: bio start 4096 ffff0000f87ca640
[Fri Aug 23 12:16:51 2024] blk_throtl_dispatch_work_fn: bio done 16384 ffff0000f87ca3c0
[Fri Aug 23 12:16:52 2024] blk_throtl_dispatch_work_fn: bio done 16384 ffff0000f87ca000
[Fri Aug 23 12:16:53 2024] blk_throtl_dispatch_work_fn: bio done 16384 ffff0000f87cb2c0
[Fri Aug 23 12:16:54 2024] blk_throtl_dispatch_work_fn: bio done 16384 ffff0000f87cb040
[Fri Aug 23 12:16:54 2024] blk_throtl_dispatch_work_fn: bio done 16384 ffff0000f87cac80
[Fri Aug 23 12:16:55 2024] blk_throtl_dispatch_work_fn: bio done 16384 ffff0000f87cb400
[Fri Aug 23 12:16:55 2024] blk_throtl_dispatch_work_fn: bio done 4096 ffff0000f87ca640
```

Thanks,
Lance

