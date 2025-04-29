Return-Path: <cgroups+bounces-7915-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65570AA3C64
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 01:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9E21B65364
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 23:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AAD2DDCFA;
	Tue, 29 Apr 2025 23:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HN8sTkWu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6E72DCB5D;
	Tue, 29 Apr 2025 23:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745969934; cv=none; b=lxP/pXsJQTdm3xHBUBzFEoOubB+T43rAR3vKNUcSLg/6M2P9nis0C5Fcu/HUx9zYX9BKwUxsw5U/8KbXuZHT5kjQ59FGvq04zbM+tcnHqGVwUR3d0oWsxpoLBhlhoo6JFBLUOtoFZrPGohQ8xsCoKrpHh9UPFjP/3v9q/Q8LZD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745969934; c=relaxed/simple;
	bh=Q4DB29dSrYsP+LDqQSDdApEPVzxvdtk+efseOmHmDYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mIyaQmF1SoSlWBHz7tlziEnAHcMQHwnQuy/HSnJc3QsQEeepNWM8wcvWgEpb1h+q8gMmiC5e+aBDv6n5A0ueIXKRz06dhli+sNCfxWBbSm+IQZSvBW5y0xN9JQacGC6wJ+TGKLz8dCn4CQ+7V/mfMjIdANDkwZq1buk2lZFxdHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HN8sTkWu; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7082ad1355bso56756487b3.1;
        Tue, 29 Apr 2025 16:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745969932; x=1746574732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14KDt7UXK6qD0EIwc8xBiPaJIpnP0mlTkZz3fHF5ExI=;
        b=HN8sTkWukVlEQwesuSEq5TeksGULB9/iNGatOS7MMyFkHq6gySjlj2Ac/w81ImOoHd
         xamNYk+O0M7e5lt/mJS4h0N0CDiXx4DpndOrB6y9aJz1DuOTrwIOMrvPsvfIJVjBF8VG
         lcXo7+xbXoFLOM816GhM7Vhy4S10kooz2LN28Lo/NZkSFW9yd9p0XKQ/ejidM7dleIFl
         6XElCOfrQj+R5sYjH2qK461kdvNyJ2y8PlfyFUImIkXv5IV2zMutZvs4zUfjngQshXtJ
         hH55p3IaTGF71+zGHbeFxpaiFQAvZnHLXLys7g7OlXHgiIUEB90OFO9yv6MN+5iBoKVO
         NGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745969932; x=1746574732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14KDt7UXK6qD0EIwc8xBiPaJIpnP0mlTkZz3fHF5ExI=;
        b=cYN30HzlxAbRtV2iDhB59rV2/HdrvPlbCZEWf+vKMX7zh+KHR8izNBkJNFDxYvu8p5
         AzdkHq/jmLBIPU5Zbi8he8w5iUjLBlyAbUlklhtaQGkpezPlANHF/2Y6DyX5zmcJ6xrV
         kzKO0HvvWA7ZMoUvxag0/roXP2YheS9yJ4ZlJlSUk3HR1WkqKj1ksfAQDSqSeTm0ZqfC
         6lO8zOPVJ3GQUPNLBbfdc3g7l+IZ8H8VoSfOWZ/5w+FpG4pTzWaF5H1b8qRO0xDuwvqq
         x66EdQNtFvQykpcR+eA0WzV4J5Y1tdjOzEZcuoLcX/vLD1+WFvhu0wHZHGo+dQxexEQb
         5kag==
X-Forwarded-Encrypted: i=1; AJvYcCUPguLr7eImgbrMrjN7VUMcggTdufOTpEcNAtjMV4NW566GgQKfpiMxCkKIKaomjDFJZ81eNoWu@vger.kernel.org, AJvYcCWOUN09ZVBKQswmM/2y2n7ScG6KHl9yY8w0dzOd2tCqEvGOstYAPPQNyEtxPXU8xoh1B1DZv+pm1SI=@vger.kernel.org, AJvYcCXSn3yUj7pFVKaAmi8aVyINwzBIoZZupkLqd9owEdhgvuN4S/6LpGA12Xc5hkvSO1gOGLY6D+//t/FbUrIK@vger.kernel.org
X-Gm-Message-State: AOJu0YxVmvudE5ANZuXF2u8YzMgGB/waBTQbXWUgT8W5Qouf+EsqXp17
	zZHHTinTL5x6qL5TWMqPsNvex3qkpOAXlPNSJk5EaRQfmC5qxZYg
X-Gm-Gg: ASbGnctvq+KeN6ppL7IDB8kgPlbu2Z2WtwmPhtkAy61ea1UQes8D0ojCQj7zFBckOHD
	F0DDx+C9d7mRAHrn6RGvYrFwol93ngUX3QHPR4KcO+6+VRiTXIYUqkCLfC0W+kxH8Yn9qfvgkqG
	6fcdAHkEzHzZany4YZyZTdPIPxf3xMXk2s2KaxOmLbx4SMzzBkCpSuzEpQ3tDYX6UfQCfHYG4V+
	LtuJ96COFozVk8G+FRGeSBKQNeypz/8UGZuZk9BOBk4CaqZjrZw6mlSh1pkDRxJBT7K94KkXktT
	6M2mOYl2B+sOonhp0UTIPlgwZw+dEBI=
X-Google-Smtp-Source: AGHT+IFL1V6HRFg2K9+CUxVQ7bHrWgmJ7ZUqXAol+JA4ERhhSJiPwEl2QI+sts6PXu02TZGnUD2BvA==
X-Received: by 2002:a05:690c:1b:b0:6fe:bfb7:68bd with SMTP id 00721157ae682-708abd46579mr21773787b3.1.1745969932210;
        Tue, 29 Apr 2025 16:38:52 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-708ae068ee9sm753227b3.53.2025.04.29.16.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 16:38:51 -0700 (PDT)
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
Subject: [RFC PATCH v2 03/18] swapfile: rearrange freeing steps
Date: Tue, 29 Apr 2025 16:38:31 -0700
Message-ID: <20250429233848.3093350-4-nphamcs@gmail.com>
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

In the swap free path, certain steps (cgroup uncharging and shadow
clearing) will be handled at the virtual layer eventually. To facilitate
this change, rearrange these functions a bit in their caller. There
should not be any functional change.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/swapfile.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 426674d35983..e717d0e7ae6b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1129,6 +1129,8 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 	void (*swap_slot_free_notify)(struct block_device *, unsigned long);
 	unsigned int i;
 
+	clear_shadow_from_swap_cache(si->type, begin, end);
+
 	/*
 	 * Use atomic clear_bit operations only on zeromap instead of non-atomic
 	 * bitmap_clear to prevent adjacent bits corruption due to simultaneous writes.
@@ -1149,7 +1151,6 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 			swap_slot_free_notify(si->bdev, offset);
 		offset++;
 	}
-	clear_shadow_from_swap_cache(si->type, begin, end);
 
 	/*
 	 * Make sure that try_to_unuse() observes si->inuse_pages reaching 0
@@ -1502,6 +1503,8 @@ static void swap_entry_range_free(struct swap_info_struct *si,
 	unsigned char *map = si->swap_map + offset;
 	unsigned char *map_end = map + nr_pages;
 
+	mem_cgroup_uncharge_swap(entry, nr_pages);
+
 	/* It should never free entries across different clusters */
 	VM_BUG_ON(ci != offset_to_cluster(si, offset + nr_pages - 1));
 	VM_BUG_ON(cluster_is_empty(ci));
@@ -1513,7 +1516,6 @@ static void swap_entry_range_free(struct swap_info_struct *si,
 		*map = 0;
 	} while (++map < map_end);
 
-	mem_cgroup_uncharge_swap(entry, nr_pages);
 	swap_range_free(si, offset, nr_pages);
 
 	if (!ci->count)
-- 
2.47.1


