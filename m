Return-Path: <cgroups+bounces-5719-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 869879DF583
	for <lists+cgroups@lfdr.de>; Sun,  1 Dec 2024 13:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA2728150B
	for <lists+cgroups@lfdr.de>; Sun,  1 Dec 2024 12:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6365B1B0F2B;
	Sun,  1 Dec 2024 12:42:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C8A1ABEB4;
	Sun,  1 Dec 2024 12:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733056978; cv=none; b=BndP9eXh0kkHaWNATSyHJxCHPvbyPHrTgT985NS7xyEmVVP9Dae5wdttMK8lrl5U/4cyc9dCUahkl87E3QRJEnBMuc8lW5yRrbB91Klki/0L5KkU8MZu2krmpPA/1AeebHgcYE06Q5yop+U03F6SvW9K00eo06b7mhFfh1FJRnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733056978; c=relaxed/simple;
	bh=sGDqa+/61tyT40gjawpHwToPxxji73WCCz7yKsesY18=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CrWaWlkqW368W2oQkDZA/Wxj0aC9R5d3X5e8mXmwtHrU3o+h7YSM0FsKUEW667tY35QJarM+CTsNupDEwScSTDp1jgy6aMFXEo+Qh9LVRVRndoOcv29N5a+smWCvGNzai+cm4tl6oFkm27Zh/MtxydZyvPC3LuPzEc2fFTkP1Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385e5db74d3so622327f8f.0;
        Sun, 01 Dec 2024 04:42:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733056975; x=1733661775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=trrR/KwI3DUl9tlQBEhNM3AQg27dHjgUiWJjFITFwg4=;
        b=dnxc316+J8+dHHluYbAk0uPtjF/bLnxW/y/uywSn/DNfC0EUp3P5jLr8rndCTl+WFk
         OLscOgPR2Tp/PcatqGCUzE/t7O2jsOat+IalaRLTMZMz4w+KJHUeksl8juKMOvA4byo8
         Y8k8nmAPFyw57lNlfGhZBTnnIJY+nbGsCetUhlDW1a1EkBCi5kCnwOdgpOoenQqZy9hQ
         WNqclrCJWhKNjibhayBN/KL0B6DIIw2BXg1yD7tOjjRqEsLXa7WVTUEwJ4V4MLuOyuAp
         64hy3xmu0Y/vzEq8QFCo3wjlhp5pMzV+jfk4bocbF2TdQg5i47FaA0gcvWqRGKxhMkju
         LV6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4tvN9u+DGccWuPDjsoeZ4YHODQZDlhJzfcjp4SFdxhX1nyqGDyOOLqjqsxfWRMiaPHtNHxy5mR2MvKqqZ@vger.kernel.org, AJvYcCUsjyXbN/qxzl85n3piiZGk3d11eEJjQ6zd9ib1q8z97BMf80by23FTkqvqQ4nWwoYNZIMZOPKF@vger.kernel.org
X-Gm-Message-State: AOJu0YyUVmAJQpzCM2p6oPDRCsSmejwJagneTv9SCuRm9JmF+xPVTcTJ
	/r2ViCEC21IuNhn5LOMMVK3EuwggJOE2CMGUSPTN46mYwhZTyKik
X-Gm-Gg: ASbGnctnep+Ac+jBNTrQhGS/dTICx1YV9ZdSPCHHSAxgsEZd+8mF5ullplgdLI8jju2
	s0CZwR+TA4o+z3z4ob32w1tbbvUVAqcTuWkMlJEEqbNWSS6x/5sRxZgAJVKRf58Q0PFHPbPgpaz
	1icqhCPyssIe9anFxxlLSZE4Z327cwxC00rBdraCtbdqMiT/DEw3qAY4bCaU7yKKIGq4rcPBIRX
	yboA0Ci7EiDwHL1HcwAlOXvA+Sb+Nns4HB700ofelcMdrqG4wUw1MJ8SLt5A0op4V8=
X-Google-Smtp-Source: AGHT+IFJfUks9BU4dt3NylYQm1WxOiBri7F/IBaOS2k3VwS4+KEmGbGmxqazgBfjUk80DbN1YKpXrQ==
X-Received: by 2002:a05:6000:401f:b0:382:4f50:be64 with SMTP id ffacd0b85a97d-385c6ec0e53mr17817993f8f.25.1733056974718;
        Sun, 01 Dec 2024 04:42:54 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e280:5300:9068:704e:a31a:c135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f70d91sm114434985e9.39.2024.12.01.04.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 04:42:54 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: longman@redhat.com,
	ming.lei@redhat.com,
	pauld@redhat.com,
	juri.lelli@redhat.com,
	vschneid@redhat.com,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH v4 0/4] genirq/cpuhotplug: Adjust managed interrupts according to change of housekeeping cpumask
Date: Sun,  1 Dec 2024 14:42:40 +0200
Message-ID: <20241201124244.997754-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series of patches is based on series
isolation: Exclude dynamically isolated CPUs from housekeeping masks:
https://lore.kernel.org/lkml/20240821142312.236970-1-longman@redhat.com/
Its purpose is to exclude dynamically isolated CPUs from some
housekeeping masks so that subsystems that check the housekeeping masks
at run time will not use those isolated CPUs.

However, some of subsystems can use obsolete housekeeping CPU masks.
Therefore, to prevent the use of these isolated CPUs, it is necessary to
explicitly propagate changes of the housekeeping masks to all subsystems
depending on the mask.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---

v4:
- Use CPU hotplug as recommended by Thomas Gleixner.

v3:
- Address the comments by Thomas Gleixner.

v2:
- Focus in this patch series on managed interrupts only.

Costa Shulyupin (4):
  cgroup/cpuset: Add HK_TYPE_MANAGED_IRQ to HOUSEKEEPING_FLAGS
  genirq/cpuhotplug: Dynamically isolate CPUs from managed interrupts
  cgroup/cpuset: Restart CPUs whose isolated_cpus bits have changed
  DO NOT MERGE: Test CPU isolation from managed interrupts

 MAINTAINERS             |   2 +
 kernel/cgroup/cpuset.c  |  36 +++++++++++
 kernel/irq/cpuhotplug.c |   3 +
 tests/managed_irq.sh    | 135 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 176 insertions(+)
 create mode 100755 tests/managed_irq.sh

-- 
2.47.0


