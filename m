Return-Path: <cgroups+bounces-7929-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6528BAA3CC3
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 01:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BBB39A4A66
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 23:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EBD255F2E;
	Tue, 29 Apr 2025 23:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miihjida"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF0B231854;
	Tue, 29 Apr 2025 23:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745969947; cv=none; b=SSO19UPR0rbWCP6dggBkbGWFrz/nyvd/36FgB8PeRel/PjMXq1Qac62yOcO8JVxHlhrwiwKN4T6+Q02uReV0pGgyvpgxKtR9l4d5gbomt8/R7+yJTWdti4NeocYaSIvwVKmogxXxRuLyyPzxks6jb7F4GVIYjxSsnvsWerYq9EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745969947; c=relaxed/simple;
	bh=Nio/aNh97oUUMOeQHZePfI/PfEgYpOnHKeK/atP80i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwLM54TWGWxJxBJmARQcQA17yirVoqLOdENm/C1PDTG90lkAJftXXqemWBXXXrzkcqjRvPrYntrvb68fP5DVDxeCStsEE+YBC8fiXNikS1jApYolHc0a9Tg88QLfPAMqcsgqMZiU4hSiaFgQjTOKka4t9pPb7GV50cgS+kUDBYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miihjida; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e694601f624so5130260276.1;
        Tue, 29 Apr 2025 16:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745969945; x=1746574745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OXJh49ro0Is08VU7l706A8kleEYBYNLH5HPqY/XJZw=;
        b=miihjidaYjzLPuf8G5PMnMcHpEqj55kJi5QLZWloMrDv24i8HBSqNraZfgeHGR67vG
         BjowOcdVaLEaf0QPyXnjnJ27Kyhb/TwoljhPZ601S0HVAZrC6b7T0F1+JrZBfMHMlOIz
         ONY7+yZPTeZ6sXhcvfyviPyaPTIWLp76XkdZV9JKPuH34jNGPffAvq6a3raxnWiQT/hN
         O6ZnFqSWlz/Lgsgte7UEDz8H1t7a2TcAxwEH8Hkz99cE+haVr0mPdy6x9cuLOqBhMRl8
         zccQOwcE023ip/auVMgnjD+WceuPRRLCVITBHQfzEnJbqcrOmqeWATV6mB96F0lwX/pz
         lqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745969945; x=1746574745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2OXJh49ro0Is08VU7l706A8kleEYBYNLH5HPqY/XJZw=;
        b=enwn9BfuT6UtCMftP0n7GD7Q9YOAzqmS7uwsOHDrYoXdPUV5lVaH09IDfFy2jYa233
         /MJrfqRicg9g/cihCoM0vwxU+MNPrM7PKhSNp04CGb2J/Wel5TYOrlixhiPOi0kXhqCJ
         zLT37RUQ++EjmVl5DcnmjPia+9h+ACNoyqpZW4pkLWEDMYs5p8AOETiqvPKuDBSxv2Bv
         ki3lYEjEPjNxD6Tjp3T9y5tTh//Rw2SiQz5fEEYkDNORoEF6RVPlJTFBSVOcQ+tK6Sbb
         DAymd8yB+buZV/pViZoL61LZl+m8RcNT7gNW/E8/fXc0+6GLanCfqu7a4zHZuAhsKVWy
         PDGA==
X-Forwarded-Encrypted: i=1; AJvYcCVMBvC9jWPAAswoTssnh3rzStQEb4dfzWVczTlbkv3l7V6cP2wbKxTnKq6Ydaksc093ws4/io0Z@vger.kernel.org, AJvYcCW9CiCHsLFJ8D44J132eKhHLX3XRYT5AvJj3p/wB/kFbaN1K22xT4dar+NElCJP09ldJ0JwrITRU58=@vger.kernel.org, AJvYcCWeuku8QaRhGF+jygapCweqWRTCZY7Q2p1voRRtmASZnlYRMw10RG5zn5laVPFCkJEMAdxCyM2tyt8Cd6SO@vger.kernel.org
X-Gm-Message-State: AOJu0YwcxBBQo1QLMlxjTtBswx3aRZjZ7jOVMjmgGIqKnxAkySGowh7M
	bBwTUbx2oY5nyIusUkybZ2DTl1Mj+jtoxar/ryrunABeIvoTdAre
X-Gm-Gg: ASbGncvCpV1MOiii8G12xDG0qq82eTrBwo53kqA9HaEvDzbCI2aVQew/TzSP3lk4NGs
	k4JQGDWAhfEZaAz0Q3oXIcb3ape1YGf8Tzexuy7h5mJsp9zK5qhlvcsHsrkxRprqsIaS0rBpadg
	PPb0GQFNYWvbhr2AWve+sgP3itLqBHNbzYngDQjcDlHXiq1C9RPNzr1c3Wv8j7ykuPiK3Eft7ps
	/SaTDb/+INjUQdTFs58Yr1MKC/wKCJSCx3hWTnEH8LvHPsHeIJXFTN1FB5Xz7273vqLIxx0hMl4
	h7j8KYLduLQxSHVcE310h3P7Dyg5P6k=
X-Google-Smtp-Source: AGHT+IFvGhhWkQ9UGzTtXcjIsy+O9RRs3eS+N4X6pVmlww1mm3JHu8MPhztRLEkVipdj5eMNP+HjVw==
X-Received: by 2002:a05:6902:1692:b0:e73:176b:fc28 with SMTP id 3f1490d57ef6-e73ecb8dd29mr1543475276.49.1745969944799;
        Tue, 29 Apr 2025 16:39:04 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7412f1428fsm63359276.24.2025.04.29.16.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 16:39:04 -0700 (PDT)
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
Subject: [RFC PATCH v2 17/18] swapfile: move zeromap setup out of enable_swap_info
Date: Tue, 29 Apr 2025 16:38:45 -0700
Message-ID: <20250429233848.3093350-18-nphamcs@gmail.com>
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

In preparation for zeromap removal in virtual swap implementation, move
zeromap setup step out of enable_swap_info to its callers, where
necessary.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/swapfile.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 3aa3df10c3be..3ed7edc800fe 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2767,8 +2767,7 @@ static int swap_node(struct swap_info_struct *si)
 
 static void setup_swap_info(struct swap_info_struct *si, int prio,
 			    unsigned char *swap_map,
-			    struct swap_cluster_info *cluster_info,
-			    unsigned long *zeromap)
+			    struct swap_cluster_info *cluster_info)
 {
 	int i;
 
@@ -2793,7 +2792,6 @@ static void setup_swap_info(struct swap_info_struct *si, int prio,
 	}
 	si->swap_map = swap_map;
 	si->cluster_info = cluster_info;
-	si->zeromap = zeromap;
 }
 
 static void _enable_swap_info(struct swap_info_struct *si)
@@ -2825,7 +2823,8 @@ static void enable_swap_info(struct swap_info_struct *si, int prio,
 {
 	spin_lock(&swap_lock);
 	spin_lock(&si->lock);
-	setup_swap_info(si, prio, swap_map, cluster_info, zeromap);
+	setup_swap_info(si, prio, swap_map, cluster_info);
+	si->zeromap = zeromap;
 	spin_unlock(&si->lock);
 	spin_unlock(&swap_lock);
 	/*
@@ -2843,7 +2842,7 @@ static void reinsert_swap_info(struct swap_info_struct *si)
 {
 	spin_lock(&swap_lock);
 	spin_lock(&si->lock);
-	setup_swap_info(si, si->prio, si->swap_map, si->cluster_info, si->zeromap);
+	setup_swap_info(si, si->prio, si->swap_map, si->cluster_info);
 	_enable_swap_info(si);
 	spin_unlock(&si->lock);
 	spin_unlock(&swap_lock);
-- 
2.47.1


