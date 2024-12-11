Return-Path: <cgroups+bounces-5827-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDEA9ED75C
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 21:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C362F1884392
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 20:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5507C2288D5;
	Wed, 11 Dec 2024 20:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDCmpg0q"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7B62288C1;
	Wed, 11 Dec 2024 20:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733949596; cv=none; b=ES4Hm2XnD7fcasfgr5ME3s/8Gd+KbajVj3av9of6JqrAhtcm+aa+XO6EzW3qtGC/dtlRf8hjrv3+CgIghKs+MvYrAJQUxWdaROdgST+T79UQDUIB/I8riBH3KtrbXL6ni9kAPq26fB6hCKPaSH9+uGNumE+2mZ87i3s7aAp6KcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733949596; c=relaxed/simple;
	bh=NsVgViKJ2o/Ngqlz4oa/6i5zFbvUyUEX4Z7xd7ZNgfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=icO/vs+IE70oDEpi3wmKpPVQwuZKb6X2bjOO9sb49sZJ4d8g/xxP8aBD2wwLA9x3PpWGlLY3nWjuJChovf4F1BQPi40BpvZXhcdsWLj085UqTYxLkfNacOfLNufwgvMu/Mh8boQi9tYdi1UOTANjkNKiN1EbSYwx+oZy/gM5NmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDCmpg0q; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e39fb8548e2so5775437276.3;
        Wed, 11 Dec 2024 12:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733949593; x=1734554393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qpv4gbVjIHmmmrd0tjmZ84YUQmgZGdnFqXfZCW5dIrs=;
        b=JDCmpg0qwm7aW+NPPDFSe18oOHtiuGH3jPxQmto5K8kqTjqlG8B4Sff0ohkvePyQ4V
         1hk2tUENXhBy+5Lrzusq7HUVAEdHK1pf+6JuiJFMmw4AuO0TpZ8TCgfswTvP840m+Afd
         kkep4/pf5qrIah1KZGM+6BT6v9Uz9iOqnGPI8sUvk2f/KHdDhHuuenHS5D7ba9Vq/Pi1
         H8XjNwvHlVCNIolbeSxPtmLh3kzg81mKuZShcouHOU9EHx6O6TAkFsmfSfQ/yloJ0Kb4
         oTgmZPI39BDPWOKbfJdy0hJ9QlO2CU0c3Gck1/GXaSpz/DoJopF5XTnShbdLq3JNLkAP
         EoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733949593; x=1734554393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qpv4gbVjIHmmmrd0tjmZ84YUQmgZGdnFqXfZCW5dIrs=;
        b=GU8+cnOsipLy+BmSip9X/2mFCQH7E3eGiTE/GL2ksZw4Xen3K4mvtAD+vh6NJjMIKj
         npdnV5rOx3tPbGG0UFrXlmWnVpFudjx1Ojltn9p7vifN0I+v0rXUogbSaFO45b6kPz0p
         aTdCl5y2iNM2RpiURICzKkjvZ0NYjsqiR7G0S/WN0R1jrMa48YO0yayKEQpFt6y8rirp
         F7r8btE9jCsiklLe4aWrbHnxc5gxQHh9KOdBIguX1NkyOcaH6SkKiuj3/wDoPacZ1YZ0
         5clp1wkS6UjOQ/cuPfziPyBZ6wp/2iKLpd03/5G2WcS8YqJXMaoXwDSFHVS/7RQejjuH
         V5NA==
X-Forwarded-Encrypted: i=1; AJvYcCWcjVrqjZbALHLix2zATzlJrqsRSVRq2S4gXK6aGJBSr9Ob5L3xo4A5Wqe9vc6D43H46UFw04Nk+ONyHbLb@vger.kernel.org, AJvYcCX4Y1FYfxlc7oKdJi2wllssVuxYTENWk/hPeARFmcr54MYlVfBus3OFNFDzZHZQDUQ7WJRUbLwI@vger.kernel.org
X-Gm-Message-State: AOJu0YzNbtDXZdZw8lPuLhoQhRvneYuZpT5sq/eglzfBJ/N1TjzgF/mI
	vcdbYemTOwPV0zsiG6wE8bqbbdmlHz/QRb4RxV5tSrwRvHiQNBDQ
X-Gm-Gg: ASbGncupsd5isb0+6Spij6cGCnfmbrkCy/HHf/LilD+fIeUAenjmbf+byDzzxHEC866
	ksFdpUvdXackh34MovNFJl+Ca76Z/8chOJAxqfwFxsXaBhvoRVojvqSiP2SKTd+l/MdIHRNjwbd
	eQWz297TTlGWmQwflRlcT5Ze9yYy0OMLhOyBrhppymLRaLhXyNXCBFLzv2psC5iIDLXb38tfGIZ
	4xQr9QCuO6SFJBwcFkIHneAmbghED0+Qi4xTztQ/7lIk+0ImAzQyx6vCDb2ATVV9bmfBt6UbUnm
	beGTTJcg0u6CvJ8=
X-Google-Smtp-Source: AGHT+IHbf62wVMPJS0UI+IgyDaQhHsKZkWwBm5K0XGEL/q3qn17Z/C6mJh+RR0ftqbG79OOrbQ+WJA==
X-Received: by 2002:a05:6902:2309:b0:e3a:9d9:bf59 with SMTP id 3f1490d57ef6-e3da324c3femr626276276.40.1733949592992;
        Wed, 11 Dec 2024 12:39:52 -0800 (PST)
Received: from localhost (fwdproxy-nha-113.fbsv.net. [2a03:2880:25ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e3c949c7022sm457262276.23.2024.12.11.12.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:39:52 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: shakeel.butt@linux.dev
Cc: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	sj@kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [v3 PATCH 0/3] memcg/hugetlb: Rework memcg hugetlb charging
Date: Wed, 11 Dec 2024 12:39:48 -0800
Message-ID: <20241211203951.764733-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up memcg's hugetlb charging logic by deprecating the
current memcg hugetlb try-charge + {commit, cancel} logic present in
alloc_hugetlb_folio. A single function mem_cgroup_charge_hugetlb takes
its place instead. This makes the code more maintainable by simplifying
the error path and reduces memcg's footprint in hugetlb logic.

This patch introduces a few changes in the hugetlb folio allocation
error path:
(a) Instead of having multiple return points, we consolidate them to
    two: one for reaching the memcg limit or running out of memory
    (-ENOMEM) and one for hugetlb allocation fails / limit being
    reached (-ENOSPC).
(b) Previously, the memcg limit was checked before the folio is acquired,
    meaning the hugeTLB folio isn't acquired if the limit is reached.
    This patch performs the charging after the folio is reached, meaning
    if memcg's limit is reached, the acquired folio is freed right away.

This patch builds on two earlier patch series: [2] which adds memcg
hugeTLB counters, and [3] which deprecates charge moving and removes the
last references to mem_cgroup_cancel_charge. The request for this cleanup
can be found in [2].

Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

[1] https://lore.kernel.org/all/20231006184629.155543-1-nphamcs@gmail.com/
[2] https://lore.kernel.org/all/20241101204402.1885383-1-joshua.hahnjy@gmail.com/
[3] https://lore.kernel.org/linux-mm/20241025012304.2473312-1-shakeel.butt@linux.dev/

---
Changelog
v3:
  * Fixed build error where mem_cgroup_charge_hugetlb was defined inside
    an #ifdef CONFIG_MEMCG. It is now defined in the #else case as well.
  * memcg_accounts_hugetlb is no longer forward-declared, just
    statically defined earlier.
  * The #ifdef is moved outside memcg_accounts_hugetlb's definition.
  * lruvec_stat_mod_folio() is now called only except when memcg
    charging fails. That is, even when memcg is not supported or memcg
    does not account hugetlb, we still update the (global) stats.
    * For this to happen, memcg_charge_hugetlb no longer returns
      -EOPNOTSUPP, just returns 0 when it is not supported.
  * kernel-doc comment added for mem_cgroup_charge_hugetlb
  * s/deprecate/remove in commit messages for clarity.
  * Thank you Shakeel, Yosry, and SJ for your input!
v2:
  * Removed declaration of memcg_accounts_hugetlb from memcontrol.h
  * Moved second call to memcg_accounts_hugetlb from 2nd patch to 1st
  * Changed error behavior in alloc_hugetlb_folio: v1 included a bug
    that uncharged hugetlb_cgroup twice when memecg's limit was reached
  * mem_cgroup_charge_hugetlb no longer called with hugetlb_lock held
  * Moved mem_cgroup_hugetlb_{try, charge} deprecation to patch 3
  * mem_cgroup_charge_hugetlb always decrements memcg's refcount
  * Fully cleaned up mem_cgroup_{cancel,commit}_charge
  * Fixed typos

Joshua Hahn (3):
  memcg/hugetlb: Introduce memcg_accounts_hugetlb
  memcg/hugetlb: Introduce mem_cgroup_charge_hugetlb
  memcg/hugetlb: Remove memcg hugetlb try-commit-cancel protocol

 include/linux/memcontrol.h | 21 ++-------
 mm/hugetlb.c               | 35 ++++++---------
 mm/memcontrol.c            | 92 ++++++++++++++++----------------------
 3 files changed, 56 insertions(+), 92 deletions(-)

-- 
base-commit: 9f16d5e6f220661f73b36a4be1b21575651d8833
2.43.5


