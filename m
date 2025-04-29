Return-Path: <cgroups+bounces-7930-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDCFAA3CCC
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 01:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396544A4385
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 23:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0242F255F55;
	Tue, 29 Apr 2025 23:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9jFu3cz"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1470246779;
	Tue, 29 Apr 2025 23:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745969948; cv=none; b=jx3h1wWsr7Wgv7RZRtvgMbxCJB4Dny/7fLjJrnlPRN22h6HM8zBdOPiBv0joGRBvCA/GByOku5EQMnC77TGUltN+fFhX08DTgR2QM9Mzy2PMf9Pb8S/zKwIq6FVRNdk1N1WL4+8GAjMwJrpCkxR2ZWCJ1lUR3qyH6wyRL6nTe3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745969948; c=relaxed/simple;
	bh=kgzMDwXSzbL/BzkDP8KOyhv89b4/e2QeN1j/eudgfgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Izm+M8LRPUHwbJR/MTz7HGfjrQ4H7pa4fLH6nGyL4rrg/aPrWp932eXyyjx+uXc7nhjjm8CmfOQs0NQpRtMoW24vjcW24V+PswnLrelsidRwsFRNRpLfFHgNQT7iwfIJGon50Xb1oaoSrZhTnQNB6WL5tBa4AQp5coJCgMywbmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9jFu3cz; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ff4faf858cso46293167b3.2;
        Tue, 29 Apr 2025 16:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745969945; x=1746574745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7Y1LUcjO0i0d9KEbjRFxqx4ocs8427R84SBdDQ2ggo=;
        b=k9jFu3czpzY3WCQqNMvyOQLDYvHqeeH+s9g/k5CqGMJF6ANAfm9qQILmiL1icnk+WJ
         BUNN/lgnllIcwXRpr/ED1BA8h6vlw7GwN+saxEzDa33+T2ai9jQTQ6T8x3nUzfZpfRg1
         Aii8ciRs5+HVQ/UXCISeiV9F1afbV7EgK7zIuZsGNHDmCcIheaqmN5uQS3jAT8cLQSjM
         2yun1rJyVq3kNvwmbaYA7CEdcYs11JQeIRj60eI1Gaxoj4HUo72nxFeTLR5QCy0bJ8BB
         mzTfcv3hqbXhla60aQe9z01VKcCyOW7n7ajwfU6AquizyA7T1Jxp1oCGg13MxSfnMARt
         JVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745969945; x=1746574745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7Y1LUcjO0i0d9KEbjRFxqx4ocs8427R84SBdDQ2ggo=;
        b=eemKO0yvbeU5jSbzRcKjYEDR19y4xHrWf/QOOMREKtZfCtC7hSffAS3cDjEvtWI0nc
         mrJ8tlvNCCidfmMJ5JtNTKsw5IMhQTwZ+LjMeohV21IhznupFAi2GF8NmswR2duv7S1s
         aG6FF9Uv5ZOcw7ap+NMVEkX/v5yM+4Og5AMViYBXmSv3jLU9tOpmw3A1cQB6TNlTX4Zd
         3jSrT7BdAgtxEijfsJHP7h5tKyp8c0b4HYq38Yj55Ig52kUwKvQX/w+M1il9UwcvsRtk
         FND73AhEQe+DchvmOitkaNKrwirG4YP1TDxHcd2k6X72eEdys3MBlb4Y1Z7xz4epkhSA
         BEMw==
X-Forwarded-Encrypted: i=1; AJvYcCVqGz1oodZk3svNihA3pyG9mvF2GbgrbdO/ymnSilpOFjlwAqEL501BhkbEE+ikZxjr/zBCnIi3UYs=@vger.kernel.org, AJvYcCXXhNwy68oWfvrADj6ZtCv6YZhJGZIMFeqZ5+CYF+HoMeFKmdaP8UfFCtGOwk3rLrJ6ZR4AKwr9kXWnZ3YH@vger.kernel.org, AJvYcCXnrgncbcRclZVSyS0DpTCt2L7AjTnsLZYgOfWAKbqsD07LcbXVG9E2emKjaZ8dwJgXPOWsjmes@vger.kernel.org
X-Gm-Message-State: AOJu0YwzG970gcPWPTV/CweSGb9eY4e1FI/cjdsqSVDWZkiz/31N73ER
	z/A5F38mfudy1MAt4HYRA4QCVFWi8jyTxk2bZYSxWkiaSGznLy/1
X-Gm-Gg: ASbGncu/ylqlLYl7XsOxHhEWrAC3bKvzFDjjai/Ns3a2qyrnxvhPf03IZ4WDbemn5et
	TvXdAdd5YQJjdBBJRHoOnKpQ38EheGdvSwZpMlPalkaIj8UjG2WKpOz/Ocb1TA0rFDX91LQeuY1
	dslgjj7jjtuOxIX7zGhZGC5cniFTwLIRx94GiRlLSuwMRl4Mso2g45M1mZYpZPOPTHZDvuHHnv0
	utaozFDn9wuF3cDgEifC0ZcLfFAVbH2RKQliHciZMprL9LhamU2L2ceo6JCgvtAbvB9YZkb1lYy
	a/HA91XbodnPS/aE+VPvXYj+k2Y3
X-Google-Smtp-Source: AGHT+IGWumwdLV+HkJwjKnK300YNBa45olDNOQIScWwSpDt70t/8c1Fec7a0C3Mk2LkTlhHYM6Jf2A==
X-Received: by 2002:a05:690c:39b:b0:703:c3be:24ad with SMTP id 00721157ae682-708abd7d5a6mr19013757b3.14.1745969945613;
        Tue, 29 Apr 2025 16:39:05 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-708ae1e6038sm707687b3.97.2025.04.29.16.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 16:39:05 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	hughd@google.com,
	yosry.ahmed@linux.dev,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	len.brown@intel.com,
	chengming.zhou@linux.dev,
	kasong@tencent.com,
	chrisl@kernel.org,
	huang.ying.caritas@gmail.com,
	ryan.roberts@arm.com,
	viro@zeniv.linux.org.uk,
	baohua@kernel.org,
	osalvador@suse.de,
	lorenzo.stoakes@oracle.com,
	christophe.leroy@csgroup.eu,
	pavel@kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org,
	peterx@redhat.com
Subject: [RFC PATCH v2 18/18] swapfile: remove zeromap in virtual swap implementation
Date: Tue, 29 Apr 2025 16:38:46 -0700
Message-ID: <20250429233848.3093350-19-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429233848.3093350-1-nphamcs@gmail.com>
References: <20250429233848.3093350-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are not using the zeromap for swapped out zero-filled pages in the
virtual swap implementation. Remove it. This saves about 1 bit per
physical swap slot.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h |  2 ++
 mm/swapfile.c        | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 0c585103d228..408368d56dfb 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -312,7 +312,9 @@ struct swap_info_struct {
 	signed char	type;		/* strange name for an index */
 	unsigned int	max;		/* extent of the swap_map */
 	unsigned char *swap_map;	/* vmalloc'ed array of usage counts */
+#ifndef CONFIG_VIRTUAL_SWAP
 	unsigned long *zeromap;		/* kvmalloc'ed bitmap to track zero pages */
+#endif
 	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
 	struct list_head free_clusters; /* free clusters list */
 	struct list_head full_clusters; /* full clusters list */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 3ed7edc800fe..3d99bd02ede9 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2824,7 +2824,9 @@ static void enable_swap_info(struct swap_info_struct *si, int prio,
 	spin_lock(&swap_lock);
 	spin_lock(&si->lock);
 	setup_swap_info(si, prio, swap_map, cluster_info);
+#ifndef CONFIG_VIRTUAL_SWAP
 	si->zeromap = zeromap;
+#endif
 	spin_unlock(&si->lock);
 	spin_unlock(&swap_lock);
 	/*
@@ -2885,7 +2887,9 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 {
 	struct swap_info_struct *p = NULL;
 	unsigned char *swap_map;
+#ifndef CONFIG_VIRTUAL_SWAP
 	unsigned long *zeromap;
+#endif
 	struct swap_cluster_info *cluster_info;
 	struct file *swap_file, *victim;
 	struct address_space *mapping;
@@ -3000,8 +3004,10 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	p->max = 0;
 	swap_map = p->swap_map;
 	p->swap_map = NULL;
+#ifndef CONFIG_VIRTUAL_SWAP
 	zeromap = p->zeromap;
 	p->zeromap = NULL;
+#endif
 	cluster_info = p->cluster_info;
 	p->cluster_info = NULL;
 	spin_unlock(&p->lock);
@@ -3014,7 +3020,9 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	kfree(p->global_cluster);
 	p->global_cluster = NULL;
 	vfree(swap_map);
+#ifndef CONFIG_VIRTUAL_SWAP
 	kvfree(zeromap);
+#endif
 	kvfree(cluster_info);
 	/* Destroy swap account information */
 	swap_cgroup_swapoff(p->type);
@@ -3601,6 +3609,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		goto bad_swap_unlock_inode;
 	}
 
+#ifndef CONFIG_VIRTUAL_SWAP
 	/*
 	 * Use kvmalloc_array instead of bitmap_zalloc as the allocation order might
 	 * be above MAX_PAGE_ORDER incase of a large swap file.
@@ -3611,6 +3620,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		error = -ENOMEM;
 		goto bad_swap_unlock_inode;
 	}
+#endif
 
 	if (si->bdev && bdev_stable_writes(si->bdev))
 		si->flags |= SWP_STABLE_WRITES;
@@ -3722,7 +3732,9 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	si->flags = 0;
 	spin_unlock(&swap_lock);
 	vfree(swap_map);
+#ifndef CONFIG_VIRTUAL_SWAP
 	kvfree(zeromap);
+#endif
 	kvfree(cluster_info);
 	if (inced_nr_rotate_swap)
 		atomic_dec(&nr_rotate_swap);
-- 
2.47.1


