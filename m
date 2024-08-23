Return-Path: <cgroups+bounces-4426-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E26D95CBFE
	for <lists+cgroups@lfdr.de>; Fri, 23 Aug 2024 14:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0241F24EAA
	for <lists+cgroups@lfdr.de>; Fri, 23 Aug 2024 12:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2BA18454D;
	Fri, 23 Aug 2024 12:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLyY1w48"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56586469D;
	Fri, 23 Aug 2024 12:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414732; cv=none; b=N6HStA3Z1Us/6pYWx0WgSQW9LWWEKehRrHaY9HGeHZD+bg0VD5ZEI49GSJshf5gYUlJYzS5rg9ef9eOsbi5i2SaBsc8AaSyVMJiQEXMcYvJxncBpthJSRov/HFC8EWq4gJRSbP3SRmIQO679sOqaJ46oCtXMvkDPIesfyxzwISk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414732; c=relaxed/simple;
	bh=l+hCrY5l9keGyncU+U1dVQs3d0AfB9D3PDkeHQUNa08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NmcpecUnUeUK/1hjzqUCO9nIIyliqDh+54XHdusRCdYZ8ag1/dzY3NE9euCswA0XDebRh+wnlo3oA5QnPZAN/dwyJCtC5n3+RJsWVA3pFTgjR/Rzlmq+BrPcI8pcjtA7PhuTH7hu+XNNysi97wofobQu9YegKzpaWeTdfb5gCbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLyY1w48; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20227ba378eso16925775ad.0;
        Fri, 23 Aug 2024 05:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724414730; x=1725019530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0VE6+ZYrN9BjyYYtqs8go1pj9o6RckfxkFxS0nV9kY=;
        b=kLyY1w48Lg+OzqNxBlDTnDXDZJ/7Lc8YCLAWw61fkW3XC0R86pYHMjd0LHHHIR7bpi
         MZtDmRUMDMwCiCSkr0CykUdCK32XX2aQE6j8G5xI4BbxNnQS4U6fCpCCt5UkzQc37qF+
         yTSRd1NOCB9oZ77hp+eAk0EIsyE10PpsWgqc0HrU67y1i8beew9kA10DNzQfTpknRiDj
         SkP7q8HTj6md98i+sbso7zlhvT9u438oz4Pm8PPVxYKWiST7tqDATmVvKYtHLIFEKfAj
         VUqbwIQW4UNhaN6meM4VCt6r6TzTKp2DtBMwrmqmmt3vB4ajlXMO01dFchwZqE9XbiDO
         3Wdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724414730; x=1725019530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0VE6+ZYrN9BjyYYtqs8go1pj9o6RckfxkFxS0nV9kY=;
        b=BnLCtUUjktCVJXzNMjz4O8TgZGL6p8n/mOkrQqtNOOykSh3xwOxqqA4vnIkELLFrl+
         JgUySQeAkVMefhl6tsPg0NcVnKh3v4PiWinNc5zRR3z2vtKjPA1I2BQXPW/dvN8qzo2o
         Jx2YC4cMJUPQu8JtUuz3ErtjsKeuHhhFVUUMo83R1QMF13zhJLFk/8Tna8PNBoozkpmC
         9M/99SGQDKDd+IPSzaVxrz7wfhTLF4IUxoc+AVPkkpHSdOkF0CkeRE0UBJ0uNnOGBX1j
         pyo4Z+Abtf22jO0kl2+JkWb59K8rkn0B+maMYVP5HUxuGA8rpzWnWnmH31iHNe95SRWO
         IlWw==
X-Forwarded-Encrypted: i=1; AJvYcCUATl0drz2vfIROQtvPZixz/cLHqF1LMxK5ENDbWLDTkVxqvxyV1kdLMKKzUM/HADR+Xv3mJDpL@vger.kernel.org, AJvYcCUrhDWktRQMvg8RECBDGtT0h2jgJzw5rsfTVoRN6sH/IaJCbKyPDTqPQrhQgrPuBhSz3W7fOeTn3ZjW9v8=@vger.kernel.org, AJvYcCWNyhFZXnMFRgSkyXm2bPkHQb9wJVGjN+4AO8g2DGkuOvNCvVRoMiB8/z+AGw7KvWcQLTL1/3vb5bS4zgqF@vger.kernel.org
X-Gm-Message-State: AOJu0YzFlyDzqLFbCP0P91pDLaVtgkbwy5g3ZRv0NlaORGcBoIndvKXm
	9jVczmVWi4xwN2Dw/rjI+JdPwb18Xk1dI3xUMtq5xu0EocuetOJN
X-Google-Smtp-Source: AGHT+IEO6vi7aDxUStR4vKn6XDyg1NSSxU2zhFU6iMHn0Wj3RSHkrpPNZRQJloReLTJaYDsR8rgAIA==
X-Received: by 2002:a17:902:e88f:b0:1fd:96e1:801e with SMTP id d9443c01a7336-2039e4f6ae6mr17650795ad.51.1724414729187;
        Fri, 23 Aug 2024 05:05:29 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385609dddsm27009595ad.196.2024.08.23.05.05.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Aug 2024 05:05:28 -0700 (PDT)
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
Date: Fri, 23 Aug 2024 20:05:02 +0800
Message-ID: <20240823120510.61853-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <7c3499ac-faa7-cc0c-2d90-b8291fce5492@huaweicloud.com>
References: <7c3499ac-faa7-cc0c-2d90-b8291fce5492@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

My bad, I got tied up with some stuff :(

Hmm... tried your debug patch today, but my test results are different from
yours. So let's take a look at direct IO with raw disk first.

```
$ lsblk
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda      8:0    0   90G  0 disk
├─sda1   8:1    0    1G  0 part /boot/efi
└─sda2   8:2    0 88.9G  0 part /
sdb      8:16   0   10G  0 disk

$ cat  /sys/block/sda/queue/scheduler
none [mq-deadline]

$ cat  /sys/block/sda/queue/rotational
0

$ cat  /sys/block/sdb/queue/rotational
0

$ cat  /sys/block/sdb/queue/scheduler
none [mq-deadline]

$ cat /boot/config-6.11.0-rc3+ |grep CONFIG_CGROUP_
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
CONFIG_CGROUP_MISC=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y

$ cd /sys/fs/cgroup/test/ && cat cgroup.controllers
cpu io memory pids

$ cat io.weight
default 100

$ cat io.prio.class
no-change
```

With wiops, the result is as follows:

```
$ echo "8:16 wbps=10485760 wiops=100000" > io.max

$ dd if=/dev/zero of=/dev/sdb bs=50M count=1 oflag=direct
1+0 records in
1+0 records out
52428800 bytes (52 MB, 50 MiB) copied, 5.05893 s, 10.4 MB/s

$ dmesg -T
[Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 2984 ffff0000fb3a8f00
[Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 6176 ffff0000fb3a97c0
[Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 7224 ffff0000fb3a9180
[Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb3a8640
[Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb3a9400
[Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb3a8c80
[Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb3a9040
[Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb3a92c0
[Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 4096 ffff0000fb3a8000
[Fri Aug 23 11:04:08 2024] blk_throtl_dispatch_work_fn: bio done 2984 ffff0000fb3a8f00
[Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 1400 ffff0000fb3a8f00
[Fri Aug 23 11:04:08 2024] blk_throtl_dispatch_work_fn: bio done 6176 ffff0000fb3a97c0
[Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 3616 ffff0000fb3a97c0
[Fri Aug 23 11:04:08 2024] blk_throtl_dispatch_work_fn: bio done 7224 ffff0000fb3a9180
[Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 4664 ffff0000fb3a9180
[Fri Aug 23 11:04:09 2024] blk_throtl_dispatch_work_fn: bio done 16384 ffff0000fb3a8640
[Fri Aug 23 11:04:09 2024] __blk_throtl_bio: bio start 13824 ffff0000fb3a8640
[Fri Aug 23 11:04:10 2024] blk_throtl_dispatch_work_fn: bio done 16384 ffff0000fb3a9400
[Fri Aug 23 11:04:10 2024] __blk_throtl_bio: bio start 13824 ffff0000fb3a9400
[Fri Aug 23 11:04:11 2024] blk_throtl_dispatch_work_fn: bio done 16384 ffff0000fb3a8c80
[Fri Aug 23 11:04:11 2024] __blk_throtl_bio: bio start 13824 ffff0000fb3a8c80
[Fri Aug 23 11:04:12 2024] blk_throtl_dispatch_work_fn: bio done 16384 ffff0000fb3a9040
[Fri Aug 23 11:04:12 2024] __blk_throtl_bio: bio start 13824 ffff0000fb3a9040
[Fri Aug 23 11:04:12 2024] blk_throtl_dispatch_work_fn: bio done 16384 ffff0000fb3a92c0
[Fri Aug 23 11:04:12 2024] __blk_throtl_bio: bio start 13824 ffff0000fb3a92c0
[Fri Aug 23 11:04:13 2024] blk_throtl_dispatch_work_fn: bio done 4096 ffff0000fb3a8000
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 1536 ffff0000fb3a8000
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 1536 ffff0000fb3a8000
[Fri Aug 23 11:04:13 2024] blk_throtl_dispatch_work_fn: bio done 1400 ffff0000fb3a8f00
[Fri Aug 23 11:04:13 2024] blk_throtl_dispatch_work_fn: bio done 3616 ffff0000fb3a97c0
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 1056 ffff0000fb3a97c0
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 1056 ffff0000fb3a97c0
[Fri Aug 23 11:04:13 2024] blk_throtl_dispatch_work_fn: bio done 4664 ffff0000fb3a9180
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 2104 ffff0000fb3a9180
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 2104 ffff0000fb3a9180
[Fri Aug 23 11:04:13 2024] blk_throtl_dispatch_work_fn: bio done 13824 ffff0000fb3a8640
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 11264 ffff0000fb3a8640
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 11264 ffff0000fb3a8640
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 8704 ffff0000fb3a8640
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 8704 ffff0000fb3a8640
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 6144 ffff0000fb3a8640
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 6144 ffff0000fb3a8640
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 3584 ffff0000fb3a8640
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 3584 ffff0000fb3a8640
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 1024 ffff0000fb3a8640
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 1024 ffff0000fb3a8640
[Fri Aug 23 11:04:13 2024] blk_throtl_dispatch_work_fn: bio done 13824 ffff0000fb3a9400
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 11264 ffff0000fb3a9400
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 11264 ffff0000fb3a9400
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 8704 ffff0000fb3a9400
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 8704 ffff0000fb3a9400
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 6144 ffff0000fb3a9400
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 6144 ffff0000fb3a9400
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 3584 ffff0000fb3a9400
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 3584 ffff0000fb3a9400
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 1024 ffff0000fb3a9400
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 1024 ffff0000fb3a9400
[Fri Aug 23 11:04:13 2024] blk_throtl_dispatch_work_fn: bio done 13824 ffff0000fb3a8c80
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 11264 ffff0000fb3a8c80
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 11264 ffff0000fb3a8c80
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 8704 ffff0000fb3a8c80
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 8704 ffff0000fb3a8c80
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 6144 ffff0000fb3a8c80
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 6144 ffff0000fb3a8c80
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 3584 ffff0000fb3a8c80
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 3584 ffff0000fb3a8c80
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 1024 ffff0000fb3a8c80
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 1024 ffff0000fb3a8c80
[Fri Aug 23 11:04:13 2024] blk_throtl_dispatch_work_fn: bio done 13824 ffff0000fb3a9040
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 11264 ffff0000fb3a9040
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 11264 ffff0000fb3a9040
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 8704 ffff0000fb3a9040
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 8704 ffff0000fb3a9040
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 6144 ffff0000fb3a9040
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 6144 ffff0000fb3a9040
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 3584 ffff0000fb3a9040
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 3584 ffff0000fb3a9040
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 1024 ffff0000fb3a9040
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 1024 ffff0000fb3a9040
[Fri Aug 23 11:04:13 2024] blk_throtl_dispatch_work_fn: bio done 13824 ffff0000fb3a92c0
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 11264 ffff0000fb3a92c0
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 11264 ffff0000fb3a92c0
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 8704 ffff0000fb3a92c0
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 8704 ffff0000fb3a92c0
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 6144 ffff0000fb3a92c0
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 6144 ffff0000fb3a92c0
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 3584 ffff0000fb3a92c0
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 3584 ffff0000fb3a92c0
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 1024 ffff0000fb3a92c0
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 1024 ffff0000fb3a92c0
```

And without wiops, the result is quite different:

```
$ echo "8:16 wbps=10485760 wiops=max" > io.max

$ dd if=/dev/zero of=/dev/sdb bs=50M count=1 oflag=direct
1+0 records in
1+0 records out
52428800 bytes (52 MB, 50 MiB) copied, 5.08187 s, 10.3 MB/s

$ dmesg -T
[Fri Aug 23 10:59:10 2024] __blk_throtl_bio: bio start 2880 ffff0000c74659c0
[Fri Aug 23 10:59:10 2024] __blk_throtl_bio: bio start 6992 ffff00014f621b80
[Fri Aug 23 10:59:10 2024] __blk_throtl_bio: bio start 92528 ffff00014f620dc0
[Fri Aug 23 10:59:10 2024] blk_throtl_dispatch_work_fn: bio done 2880 ffff0000c74659c0
[Fri Aug 23 10:59:11 2024] blk_throtl_dispatch_work_fn: bio done 6992 ffff00014f621b80
[Fri Aug 23 10:59:15 2024] blk_throtl_dispatch_work_fn: bio done 92528 ffff00014f620dc0
```

Then, I retested for ext4 as you did.

```
$ lsblk
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda      8:0    0   90G  0 disk
├─sda1   8:1    0    1G  0 part /boot/efi
└─sda2   8:2    0 88.9G  0 part /
sdb      8:16   0   10G  0 disk

$ df -T /data
Filesystem     Type 1K-blocks     Used Available Use% Mounted on
/dev/sda2      ext4  91222760 54648704  31894224  64% /
```

With wiops, the result is as follows:

```
$ echo "8:0 wbps=10485760 wiops=100000" > io.max

$ rm -rf /data/file1 && dd if=/dev/zero of=/data/file1 bs=50M count=1 oflag=direct
1+0 records in
1+0 records out
52428800 bytes (52 MB, 50 MiB) copied, 5.06227 s, 10.4 MB/s

$ dmesg -T
[Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 2984 ffff0000fb3a8f00
[Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 6176 ffff0000fb3a97c0
[Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 7224 ffff0000fb3a9180
[Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb3a8640
[Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb3a9400
[Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb3a8c80
[Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb3a9040
[Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb3a92c0
[Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 4096 ffff0000fb3a8000
[Fri Aug 23 11:04:08 2024] blk_throtl_dispatch_work_fn: bio done 2984 ffff0000fb3a8f00
[Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 1400 ffff0000fb3a8f00
[Fri Aug 23 11:04:08 2024] blk_throtl_dispatch_work_fn: bio done 6176 ffff0000fb3a97c0
[Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 3616 ffff0000fb3a97c0
[Fri Aug 23 11:04:08 2024] blk_throtl_dispatch_work_fn: bio done 7224 ffff0000fb3a9180
[Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 4664 ffff0000fb3a9180
[Fri Aug 23 11:04:09 2024] blk_throtl_dispatch_work_fn: bio done 16384 ffff0000fb3a8640
[Fri Aug 23 11:04:09 2024] __blk_throtl_bio: bio start 13824 ffff0000fb3a8640
[Fri Aug 23 11:04:10 2024] blk_throtl_dispatch_work_fn: bio done 16384 ffff0000fb3a9400
[Fri Aug 23 11:04:10 2024] __blk_throtl_bio: bio start 13824 ffff0000fb3a9400
[Fri Aug 23 11:04:11 2024] blk_throtl_dispatch_work_fn: bio done 16384 ffff0000fb3a8c80
[Fri Aug 23 11:04:11 2024] __blk_throtl_bio: bio start 13824 ffff0000fb3a8c80
[Fri Aug 23 11:04:12 2024] blk_throtl_dispatch_work_fn: bio done 16384 ffff0000fb3a9040
[Fri Aug 23 11:04:12 2024] __blk_throtl_bio: bio start 13824 ffff0000fb3a9040
[Fri Aug 23 11:04:12 2024] blk_throtl_dispatch_work_fn: bio done 16384 ffff0000fb3a92c0
[Fri Aug 23 11:04:12 2024] __blk_throtl_bio: bio start 13824 ffff0000fb3a92c0
[Fri Aug 23 11:04:13 2024] blk_throtl_dispatch_work_fn: bio done 4096 ffff0000fb3a8000
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 1536 ffff0000fb3a8000
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 1536 ffff0000fb3a8000
[Fri Aug 23 11:04:13 2024] blk_throtl_dispatch_work_fn: bio done 1400 ffff0000fb3a8f00
[Fri Aug 23 11:04:13 2024] blk_throtl_dispatch_work_fn: bio done 3616 ffff0000fb3a97c0
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 1056 ffff0000fb3a97c0
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 1056 ffff0000fb3a97c0
[Fri Aug 23 11:04:13 2024] blk_throtl_dispatch_work_fn: bio done 4664 ffff0000fb3a9180
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 2104 ffff0000fb3a9180
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 2104 ffff0000fb3a9180
[Fri Aug 23 11:04:13 2024] blk_throtl_dispatch_work_fn: bio done 13824 ffff0000fb3a8640
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 11264 ffff0000fb3a8640
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 11264 ffff0000fb3a8640
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 8704 ffff0000fb3a8640
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 8704 ffff0000fb3a8640
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 6144 ffff0000fb3a8640
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 6144 ffff0000fb3a8640
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 3584 ffff0000fb3a8640
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 3584 ffff0000fb3a8640
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 1024 ffff0000fb3a8640
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 1024 ffff0000fb3a8640
[Fri Aug 23 11:04:13 2024] blk_throtl_dispatch_work_fn: bio done 13824 ffff0000fb3a9400
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 11264 ffff0000fb3a9400
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 11264 ffff0000fb3a9400
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 8704 ffff0000fb3a9400
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 8704 ffff0000fb3a9400
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 6144 ffff0000fb3a9400
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 6144 ffff0000fb3a9400
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 3584 ffff0000fb3a9400
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 3584 ffff0000fb3a9400
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 1024 ffff0000fb3a9400
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 1024 ffff0000fb3a9400
[Fri Aug 23 11:04:13 2024] blk_throtl_dispatch_work_fn: bio done 13824 ffff0000fb3a8c80
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 11264 ffff0000fb3a8c80
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 11264 ffff0000fb3a8c80
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 8704 ffff0000fb3a8c80
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 8704 ffff0000fb3a8c80
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 6144 ffff0000fb3a8c80
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 6144 ffff0000fb3a8c80
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 3584 ffff0000fb3a8c80
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 3584 ffff0000fb3a8c80
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 1024 ffff0000fb3a8c80
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 1024 ffff0000fb3a8c80
[Fri Aug 23 11:04:13 2024] blk_throtl_dispatch_work_fn: bio done 13824 ffff0000fb3a9040
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 11264 ffff0000fb3a9040
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 11264 ffff0000fb3a9040
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 8704 ffff0000fb3a9040
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 8704 ffff0000fb3a9040
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 6144 ffff0000fb3a9040
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 6144 ffff0000fb3a9040
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 3584 ffff0000fb3a9040
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 3584 ffff0000fb3a9040
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 1024 ffff0000fb3a9040
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 1024 ffff0000fb3a9040
[Fri Aug 23 11:04:13 2024] blk_throtl_dispatch_work_fn: bio done 13824 ffff0000fb3a92c0
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 11264 ffff0000fb3a92c0
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 11264 ffff0000fb3a92c0
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 8704 ffff0000fb3a92c0
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 8704 ffff0000fb3a92c0
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 6144 ffff0000fb3a92c0
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 6144 ffff0000fb3a92c0
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 3584 ffff0000fb3a92c0
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 3584 ffff0000fb3a92c0
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio start 1024 ffff0000fb3a92c0
[Fri Aug 23 11:04:13 2024] __blk_throtl_bio: bio done 1024 ffff0000fb3a92c0
```

And without wiops, the result is also quite different:

```
$ echo "8:0 wbps=10485760 wiops=max" > io.max

$ rm -rf /data/file1 && dd if=/dev/zero of=/data/file1 bs=50M count=1 oflag=direct
1+0 records in
1+0 records out
52428800 bytes (52 MB, 50 MiB) copied, 5.03759 s, 10.4 MB/s

$ dmesg -T
[Fri Aug 23 11:05:07 2024] __blk_throtl_bio: bio start 2904 ffff0000c4e9f2c0
[Fri Aug 23 11:05:07 2024] __blk_throtl_bio: bio start 5984 ffff0000c4e9e000
[Fri Aug 23 11:05:07 2024] __blk_throtl_bio: bio start 7496 ffff0000c4e9e3c0
[Fri Aug 23 11:05:07 2024] __blk_throtl_bio: bio start 16384 ffff0000c4e9eb40
[Fri Aug 23 11:05:07 2024] __blk_throtl_bio: bio start 16384 ffff0000c4e9f540
[Fri Aug 23 11:05:07 2024] __blk_throtl_bio: bio start 16384 ffff0000c4e9e780
[Fri Aug 23 11:05:07 2024] __blk_throtl_bio: bio start 16384 ffff0000c4e9ea00
[Fri Aug 23 11:05:07 2024] __blk_throtl_bio: bio start 16384 ffff0000c4e9f900
[Fri Aug 23 11:05:07 2024] __blk_throtl_bio: bio start 4096 ffff0000c4e9e8c0
[Fri Aug 23 11:05:07 2024] blk_throtl_dispatch_work_fn: bio done 2904 ffff0000c4e9f2c0
[Fri Aug 23 11:05:07 2024] blk_throtl_dispatch_work_fn: bio done 5984 ffff0000c4e9e000
[Fri Aug 23 11:05:08 2024] blk_throtl_dispatch_work_fn: bio done 7496 ffff0000c4e9e3c0
[Fri Aug 23 11:05:09 2024] blk_throtl_dispatch_work_fn: bio done 16384 ffff0000c4e9eb40
[Fri Aug 23 11:05:09 2024] blk_throtl_dispatch_work_fn: bio done 16384 ffff0000c4e9f540
[Fri Aug 23 11:05:10 2024] blk_throtl_dispatch_work_fn: bio done 16384 ffff0000c4e9e780
[Fri Aug 23 11:05:11 2024] blk_throtl_dispatch_work_fn: bio done 16384 ffff0000c4e9ea00
[Fri Aug 23 11:05:12 2024] blk_throtl_dispatch_work_fn: bio done 16384 ffff0000c4e9f900
[Fri Aug 23 11:05:12 2024] blk_throtl_dispatch_work_fn: bio done 4096 ffff0000c4e9e8c0
```

Hmm... I still hava two questions here:
1. Is wbps an average value?
2. What's the difference between setting 'max' and setting a very high value for 'wiops'?

Thanks a lot again for your time!
Lance

