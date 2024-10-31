Return-Path: <cgroups+bounces-5357-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D5F9B863B
	for <lists+cgroups@lfdr.de>; Thu, 31 Oct 2024 23:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098821C20FF0
	for <lists+cgroups@lfdr.de>; Thu, 31 Oct 2024 22:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F19C1E25FB;
	Thu, 31 Oct 2024 22:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hrCEItuH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505FE1BBBED
	for <cgroups@vger.kernel.org>; Thu, 31 Oct 2024 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730414822; cv=none; b=NscH18umbHeE9k21ux4/KyuO8Fu0ARVJHMXvj+ZtmqU7yUNr74I9lHQs7c8odetIdl78oUKFVTLL3+XwH+Hy5Wd1JrSTCcTgux9l6cA1efe4Fqnm+n7Lrt4Cn4syu1IZZIst37BfhrER9GOiS6ZzKEOCNdxb9u27l0ioLZJ9H04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730414822; c=relaxed/simple;
	bh=04KvvfgHt4U76Y7cMYLzYC1kJSgpABtfwHo8vWKZHTo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IEtiYbSjaNj4leZk+MubwZ6+eWXaB30u5Ef9m06QXPtqov4gt0LgsQY2D77j0g9udcOHBgFmw0blbDNkrHrG2aN3Xctcd2If25VYohlfuUOsGdCzoXZ1dFSVM5okhd7if3bDUCPZBg3cxo7g3y/X6LgWXpMQ44/7TyQNa+f7n5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hrCEItuH; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7ea0069a8b0so1490254a12.0
        for <cgroups@vger.kernel.org>; Thu, 31 Oct 2024 15:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730414816; x=1731019616; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xsh0ecj9Etn04xB/gBU/50JDS6BBsG2RgrIM+NKe2T8=;
        b=hrCEItuHj0gaHJOSLsiz9a6G9n5EaeDUIgvd5SPoiX4w6CJ9UXgG7Mi7n3YsV2h1q/
         izFcnd6/GKm1bvwXJzKe6WVoqsYdmPRtWY5nCIHJRNEWODloKh0mUEbEZW2afPPLGFWT
         +R+YgSV8sWiwySx0wGUYOcL/Lgz4X4FL0UeFg7YjSW9gmOCxM1pIeiohYE8eAbtIk0GD
         t7K4gRDtadQewUho6+/iGL1SeYg5nMQ/bKKSrIJM+2Wj+k5DFpBTZq/L3vMMymQARejf
         DL+PTp9Ol/VIEo0ho9eFj8blJHYXI1csHvumfp0Tfn+IdhIht7gz/w0/DW5gk1DPlKjG
         z5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730414816; x=1731019616;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xsh0ecj9Etn04xB/gBU/50JDS6BBsG2RgrIM+NKe2T8=;
        b=vjObUYW4XG2zGit2Yj5QsLO4egqZ6yn7NpGSgfShyENLOs/ONL9aqS/yksPxzX17LC
         /Ae7vO+e8WS0Td6bs+5uXtv/VoiqXNe8Tfw2zx/lDszeORNOGQjbAQteuhM+UTT6+RUg
         5fqWpkOzGDW2K7Pg2RQR/ZFrx6B8VnRSfrQrQP286OfKSvRGwR27iB/EVwH+cmL6nrfX
         Dyz8BGTIAHpsWc2dM6+UpUNSz5yyZWTo+2FLY9H+V+PwMhgyljuQmP1aGKBcLhNE05KO
         cYFE+MWf7orrGulfAcxG35KnbFVAiDl7r9UfhBzKMXpmXZDDs7Ug4DCfR2rvxQ9e1FsA
         Y1Og==
X-Forwarded-Encrypted: i=1; AJvYcCWdK2xazdLfRVzw1H1xpxz1zE0pk0x04tKDPlRMwvZM7n1zlAi8Vx/M3P+ojTUqXgJ5IbZuO2jt@vger.kernel.org
X-Gm-Message-State: AOJu0YyCVS/GNjHgQmRAgk4vLI12HknVwqkwJ7pLK2KMKc1RvmIhP8oY
	9T3zeFWyPcxcknWWQCYr9SDa9iUYiZAB5uvO9gr/UmyZlSZdq/9WAXBtYzr1w92qkLXY1d8ZdDG
	lrWHZzKybUw==
X-Google-Smtp-Source: AGHT+IHArSVwIyggeWsU6JRSK21WNKSRntcwjMdlKacSUh+G18VKzCn39+gQ7DKViVCf1aeNUXLCZjBpRJnC0A==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:a1:836b:ac13:31a5])
 (user=kinseyho job=sendgmr) by 2002:a63:34c1:0:b0:7ea:c554:d831 with SMTP id
 41be03b00d2f7-7ee290c2030mr8465a12.7.1730414815657; Thu, 31 Oct 2024 15:46:55
 -0700 (PDT)
Date: Thu, 31 Oct 2024 22:45:51 +0000
In-Reply-To: <20241031224551.1736113-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031224551.1736113-1-kinseyho@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241031224551.1736113-3-kinseyho@google.com>
Subject: [PATCH mm-unstable v1 2/2] mm, swap: add pages allocated for struct
 swap_cgroup to vmstat
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

Export the number of pages allocated for storing struct swap_cgroup in
vmstat using global system-wide counters.

Signed-off-by: Kinsey Ho <kinseyho@google.com>
---
 include/linux/vmstat.h | 3 +++
 mm/swap_cgroup.c       | 3 +++
 mm/vmstat.c            | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index ac4d42c4fabd..227e951d1219 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -41,6 +41,9 @@ enum vm_stat_item {
 	NR_DIRTY_BG_THRESHOLD,
 	NR_MEMMAP_PAGES,	/* page metadata allocated through buddy allocator */
 	NR_MEMMAP_BOOT_PAGES,	/* page metadata allocated through boot allocator */
+#if defined(CONFIG_MEMCG) && defined(CONFIG_SWAP)
+	NR_SWAP_CGROUP_PAGES,	/* allocated to store struct swap_cgroup */
+#endif
 	NR_VM_STAT_ITEMS,
 };
 
diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
index da1278f0563b..82eda8a3efe1 100644
--- a/mm/swap_cgroup.c
+++ b/mm/swap_cgroup.c
@@ -53,6 +53,8 @@ static int swap_cgroup_prepare(int type)
 		if (!(idx % SWAP_CLUSTER_MAX))
 			cond_resched();
 	}
+	mod_global_page_state(NR_SWAP_CGROUP_PAGES, ctrl->length);
+
 	return 0;
 not_enough_page:
 	max = idx;
@@ -228,6 +230,7 @@ void swap_cgroup_swapoff(int type)
 			if (!(i % SWAP_CLUSTER_MAX))
 				cond_resched();
 		}
+		mod_global_page_state(NR_SWAP_CGROUP_PAGES, -length);
 		vfree(map);
 	}
 }
diff --git a/mm/vmstat.c b/mm/vmstat.c
index e5a6dd5106c2..259574261ec1 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1295,6 +1295,9 @@ const char * const vmstat_text[] = {
 	"nr_dirty_background_threshold",
 	"nr_memmap_pages",
 	"nr_memmap_boot_pages",
+#if defined(CONFIG_MEMCG) && defined(CONFIG_SWAP)
+	"nr_swap_cgroup_pages",
+#endif
 
 #if defined(CONFIG_VM_EVENT_COUNTERS) || defined(CONFIG_MEMCG)
 	/* enum vm_event_item counters */
-- 
2.47.0.163.g1226f6d8fa-goog


