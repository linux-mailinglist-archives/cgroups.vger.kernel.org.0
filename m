Return-Path: <cgroups+bounces-5356-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EE59B8637
	for <lists+cgroups@lfdr.de>; Thu, 31 Oct 2024 23:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4237A1C211CA
	for <lists+cgroups@lfdr.de>; Thu, 31 Oct 2024 22:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBC21CDFCD;
	Thu, 31 Oct 2024 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="peAe1Elf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B0F13D8AC
	for <cgroups@vger.kernel.org>; Thu, 31 Oct 2024 22:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730414818; cv=none; b=LHnv9zPY3ImFviGf7dMCnTZxuosADkHuhsGoTG8kD2MVgZjlYjAYR5eo5geBJzwp+Cl2xR8NkxUV3/HIfj+ZdajCLqZl0m+4nm1MzsRUosTfIfAf80T01YFzR3AhFxXVF5QHZhQva2nOviwbBGRIuT+kikBMjllRHr9tDonkWYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730414818; c=relaxed/simple;
	bh=Z8tJTDavu88IoBsq3a64RtQ+t4O96S/lMc2DeVsidf0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oITsiGWfbRHWSchnsf8wRI+nHA7yqaT8EFeoKhZ7AXutDgA087GK6l8jfvCGzudHvOD12N9lIPYMJkzGnJOr7KqOT38ADl14aAVix7B+XySSNVGBkFB2ZJgZuEY6RMN/U4VDoJc8IEnUTz/OynjlKkGbNHhfL7Al4OgraBiyhoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=peAe1Elf; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2e3984f50c3so1823332a91.1
        for <cgroups@vger.kernel.org>; Thu, 31 Oct 2024 15:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730414812; x=1731019612; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wWNqofTpO3McnA/xoHsMP4AewEwxFw4lNZTCusoRC/Q=;
        b=peAe1Elf8cxw//DNRCpCGP8Lu+0+2G9VwAo0bN/q4LS4W0iT2+YgfphKfATEEP7s1w
         grrIYZnd+Q18BbnSB0/IxOHsKs4edCrJs++SqoJJL8hS9/EaRb5Gg4rwyNUhBYEpHFt3
         GmlxLLy2gXusmmOcysPDdXKrViClj2ShsCTeLXj/PQcSZ4l7Z16VLZp2CZ/yEkeIfxeC
         IJi82jiNsZCZPNbs2KCgMG6Cw+CkGA9KcA/uy12X6Dnb1g2SwMNiQhXIBuEMHLitW2XN
         E7l+V330M82dosfZET3X76q4iFObaeXdvWv1VrBnOqa1OpLW10h+MjF3eb0yOkS4wuGA
         pWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730414812; x=1731019612;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wWNqofTpO3McnA/xoHsMP4AewEwxFw4lNZTCusoRC/Q=;
        b=IAzBSj8R2ppmDtbpbXh/PuyN2DYRs1T26RCUuS5TInk1BSuSDi1yENa/xupFIb9Pyu
         ph42pi4tt3zU4icwhiFUpb6GBDkN4zrk00/U6QbpWsoH66r5u5qzS1hyYkn2lGby7Cjg
         cf2HJjbpx2Zwr0rqpGoei5hoa0f7NoPiS8Ie7AOLtiMaI83SBLoN66WLkX8boBWVHN4y
         3f5uKtOVEsOnI4SPzOu85NInqKaKBBHS0esxA6UlL4P/iK4GqcAB1QOdvWGYmK2NM8t+
         Ru6p/eLKYrFYW4Z1tZdDmO0VpSWF9h5f2Ht0jM/LpYFo9Lx1N5i36LthUXJ7Du7WiBo8
         Uo9w==
X-Forwarded-Encrypted: i=1; AJvYcCWDI0FbH0E9pTLIeDQWSHIkqwrCoWzPJOKp/1niZfLckHWIgwbEvT0X9G9bOmySHNmK6t0rvawz@vger.kernel.org
X-Gm-Message-State: AOJu0YxSn1PNgasdrUNVmM2zbYAlQ43Jl4C9sXJLzQju8buAc2tdho7H
	GN1VAxmQhbYuLfZkR8RI7IUKSIcUNBPa/z2ByRa2gaMobAU/18qLMceAxRAITG3YKCN9DgqejoY
	Dw3JvKUqqng==
X-Google-Smtp-Source: AGHT+IGaJ2rgqbyyP31Xev0nRBvN2Idh0SQ5a+6516/dGsyioBAnn294ogITAzGgIXJXIh34+WTXqMYsm0jW5g==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:a1:836b:ac13:31a5])
 (user=kinseyho job=sendgmr) by 2002:a17:90b:3e82:b0:2e9:4660:ac84 with SMTP
 id 98e67ed59e1d1-2e94c53ab03mr1455a91.8.1730414812264; Thu, 31 Oct 2024
 15:46:52 -0700 (PDT)
Date: Thu, 31 Oct 2024 22:45:49 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241031224551.1736113-1-kinseyho@google.com>
Subject: [PATCH mm-unstable v1 0/2] Track pages allocated for struct
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Rientjes <rientjes@google.com>, willy@infradead.org, Vlastimil Babka <vbabka@suse.cz>, 
	David Hildenbrand <david@redhat.com>, Kinsey Ho <kinseyho@google.com>, 
	Joel Granados <joel.granados@kernel.org>, Kaiyang Zhao <kaiyang2@cs.cmu.edu>, 
	Sourav Panda <souravpanda@google.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

We noticed high overhead for pages allocated for struct swap_cgroup in
our fleet. This patchset adds the number of pages allocated for struct
swap_cgroup to vmstat. This can be a useful metric for identifying
unneeded overhead on systems which configure swap.

Before adding the new stat, Patch 1 introduces a generic system-wide
counting interface. 

Kinsey Ho (2):
  mm: add generic system-wide page counters
  mm, swap: add pages allocated for struct swap_cgroup to vmstat

 include/linux/vmstat.h | 11 +++++++++++
 mm/swap_cgroup.c       |  3 +++
 mm/vmstat.c            | 35 ++++++++++++++++++++++++++---------
 3 files changed, 40 insertions(+), 9 deletions(-)

-- 
2.47.0.163.g1226f6d8fa-goog


