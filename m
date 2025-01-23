Return-Path: <cgroups+bounces-6248-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEB0A1A922
	for <lists+cgroups@lfdr.de>; Thu, 23 Jan 2025 18:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71FA4188A186
	for <lists+cgroups@lfdr.de>; Thu, 23 Jan 2025 17:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8403815A863;
	Thu, 23 Jan 2025 17:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="M0X2Ccyz"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3032D1494BF
	for <cgroups@vger.kernel.org>; Thu, 23 Jan 2025 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737654485; cv=none; b=WDU9ddxuuY59483a39AtDX5RiEhrTR42VI9SjeC+4QkZeH4kJTskKdneDO3A+Bj1BXiPVFwhNo+Tp+gF25OnnHVBaTf02h2zX2M5x6uiqLKgw8zDXc+PrkfpQB/s1VU5ufXZmG7kqO9EqG97tReDkuWDoU3SXnqSvyKsaomz/nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737654485; c=relaxed/simple;
	bh=RHF4i/l5LW4d4IbdACORunoa5g+HM7CGS5YYODqMgbI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kf8imtTW+zb6paLmijy5rjTrYwhm4PFalW5Mr7894lXqXjAQEyS8dubeTdgkscjwzx8ZUs4HWqPkVqwIXSe95Psz2Q8UK0Bb5s86EytRGWXf+n5CB5M8RvS3wXQ4ZVY+HEP4W+zGlr6NaQP+CX/WaCf++/b8wbkmrULEtwkUkDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=M0X2Ccyz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2161a4f86a3so2387635ad.1
        for <cgroups@vger.kernel.org>; Thu, 23 Jan 2025 09:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737654482; x=1738259282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qe8IrzoFwADLguy0v3lFQpR+NU5Cc1g2+yi9jBnzrJw=;
        b=M0X2CcyzF1Kztoiip/puw6BPHJJdcrIOIrCWxvPKMIINBBDOzt5SQgq72tkO/KhrVT
         qZZF1nE+tRHkJhLdt3+0tJOwguCUGKdFuryehWi88HHS8KHhXrIP50LV4t4BU7lzk0os
         CikbDxrnTB1QvJd6eyTHuTYa7eKBoSy06doQn8Doa1KyYCtRHiecuKAXMjrZgNZk0SLg
         ROLL+cQ7svtIbJcG7OCB6HwMrRTzNiwRy0+0f5HSvo4qZ9psIBpd99jHFYEufMv1LBqX
         6corcfXvgB8eGu+nU+TlhIC++j2yNAHVYlojBPWmP+fpmK8mbl/OIhTYhYCkgvI37dNh
         eNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737654482; x=1738259282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qe8IrzoFwADLguy0v3lFQpR+NU5Cc1g2+yi9jBnzrJw=;
        b=UOh0gMl/qPyUkHY9GAGzgDqKUSXzJTUh2M059jJDCSh8wBXz8UucZYI9XG0Oqu2Ef5
         5ABrQMve/v2CSHTOEIcw/9jP8GY404RMqK6CRYJ9nh428FtLQs+vVQ48hZFBT22is/Sc
         ZpYfs/xAhYHQbEmg9D7wxS8r03771aByhpvS3Q6nIh78Y1qwrR57QZ4zjIFyFMQ5iEQ9
         G8/TzcWVy8qtbPyknmRipaJW/OOtwLYLuWeRXl9vT58wQhwRm+1k7xby/fy4uuzqPWz4
         XawdfbeW9p7AXGJhRrdzQltFe56q01ywF92I8553ZAqEIeBv3fQ9V4q2TDtAqInNhxiz
         Dzbw==
X-Gm-Message-State: AOJu0YyunvaVXkz19YKDZ/UnG24lGiIlS8waUfX0H5U0fW0hbIZhZXMj
	gAYAfrOdgwtBNKnVCF9Yc8MAHEoQK8z2WCdrzff9eYpuNP16CFiEI7IXJwgtGENxSdRAk5O8q/5
	F
X-Gm-Gg: ASbGncv03g76ychM/Sw8J+Dmo+z4h1tlAmf9ImxFVNdaUVy39DrZIE7daM6kfdWgflD
	j4MJCxFwhQd08Mn/EDgVuFgCnXNVnb1+4H+bzwKBxiDrJ6sdC9pAW0pWdndlD8BAqnCU+LqWwe3
	uI6uCWeXaFd+CzqGxME+k6q5HwIv83aOaSkv45INf5GpgrkkNrPDmG1ipY+SL4H2yvBnmNm+xWO
	zGznF5CfZs+DnneaCUQ7+Vj5nrXQVlwO88sK4Y6wGDrPOTVSzulubNpfj/4C9TLzCw2YRTUQVxB
	mdRmHF+G1VWxUnQWbYgK0fC//8TOWFrijzipEY6+noA=
X-Google-Smtp-Source: AGHT+IEFoHNDWziiLPhLiLTskGb/T298gEKfOKRb5IKlpAL3Otku0Mv1eBtYO91eTmkPq17kmZdnvQ==
X-Received: by 2002:a17:903:1108:b0:20b:9b07:777a with SMTP id d9443c01a7336-21d79b26072mr53418795ad.10.1737654482391;
        Thu, 23 Jan 2025 09:48:02 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da4141c4esm1620765ad.110.2025.01.23.09.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 09:48:01 -0800 (PST)
From: Abel Wu <wuyun.abel@bytedance.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Bitao Hu <yaoma@linux.alibaba.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Chen Ridong <chenridong@huawei.com>
Cc: cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/3] Fix and cleanup and extend cpu.stat
Date: Fri, 24 Jan 2025 01:47:00 +0800
Message-Id: <20250123174713.25570-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1: fixes an issue that forceidle time can be inconsistant with
other cputimes.

Patch 2: cleans up the #ifdef mess in cpu.stat.

Patch 3: extend run_delay accounting to cgroup to show how severely
a cgroup is stalled.

Abel Wu (3):
  cgroup/rstat: Fix forceidle time in cpu.stat
  cgroup/rstat: Cleanup cpu.stat once for all
  cgroup/rstat: Add run_delay accounting for cgroups

 Documentation/admin-guide/cgroup-v2.rst |  1 +
 include/linux/cgroup-defs.h             |  3 +
 include/linux/kernel_stat.h             | 14 +++++
 kernel/cgroup/rstat.c                   | 74 +++++++++++++++----------
 kernel/sched/cputime.c                  | 12 ++++
 kernel/sched/stats.h                    |  2 +
 6 files changed, 78 insertions(+), 28 deletions(-)

-- 
2.37.3


