Return-Path: <cgroups+bounces-7558-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8917A8921C
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 04:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C789817D520
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 02:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D836218AD7;
	Tue, 15 Apr 2025 02:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hA4TWiGa"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731CF218AB4
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 02:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685221; cv=none; b=Y1yMhyWjq4TOTaDBmj5JgcKkLv9Lk5xmSoPPRF74+XzA+5HhVEhjlTgL6Su9k5e5qDluqiuWJDkgRDfqufok5DqMEqV7CuonfqVYBJD1sDH84xrt86IcJT/IwpzlpYuMmHz8mZJ3AP0uu+VnI0XnHRwdDPRPXXmx/v1XHcrPCEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685221; c=relaxed/simple;
	bh=8KxT6StpABCnUuNQIAeV85jX8gee7ZWYN/zcNFzGT4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fLeWiZuAbZH2x7Nrxcpin5CsWPweD7kqgiTQHNvycTJSBxeqk35yysVvOHdBwDFSB+LUi+7RPUiFDDHQvn2yBgi0xCLSdijvjDJGKB1xr9EzXXqZ/7psl7J+93BUrBj0+vf37fyqPqO9pilp8XtuJN6/kbWjOJ2VnAd5Eedn/AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hA4TWiGa; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2264aefc45dso74528055ad.0
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 19:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744685219; x=1745290019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ubou74n5eLeoB4dEz2IgWAHxjcUZtEwt6QUiSiKGpOQ=;
        b=hA4TWiGaBdT+RW5VnjUM6tC4UrKaXvoCPUwBytpgIhn/60hJksyYg3EemIvna66WTJ
         4oQ2MyLj1R4QC6qwP1kYEoaaIFtxDafQCqNH0qYeYf7d26FaHhm5g3FtJZCkEeHnYzUu
         jhaiLwX0sANJm6szjo3VJkePNru5Y5H11vsAzCBrmnjKETwNr48YWjW9A3n8EJghXGX1
         iKdJilALnEpKuIayKEAHdS4dvHPG+iMpW1zynIzZnF5ZCQoNbNmJLFJzrgxQy2OP1k8N
         ZZv7lz3CEus9KZnw8uPutC61wd+ZcPGVh67pTvso5bQfsq69/7G6eF4ZUDIGhFiD1XBL
         fhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744685219; x=1745290019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ubou74n5eLeoB4dEz2IgWAHxjcUZtEwt6QUiSiKGpOQ=;
        b=CB7AMYtPbyPk9cpI3Q/KuHBsshmBBhKSxUXGPQ547bwPfF0+AfF2DFIpP0J6nwzays
         RIQYwDVde627CiThEhs2Y4+J/V7AaeEqfqUUjJsoc48xYt3nBCNlsa9thly0tzJzMHAo
         8wRm92LRjPjCumf0rHa9bjMVF3AghAu3TnQp1i1lueH/VfyeCQLKN/ooxf0B/EH3ok6u
         0EG7ejpyE8trtN4EiOdbqtaV7wp8q1HXK5wyt3357oJVuenL/XByJrCF2Q80vxgYSdou
         ECXSq1zIheBRwRwh7HyyKR4BVDe/VE4OPGBejs2sEZYElPA/ZeElY2Xla9EDgxlL5n5Y
         kGCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6E1nTERdL4MM9ke8N+g02wmByzugTdX7TWYzprTvJDbivj/SqrzBwy6wD/yunzItg6gRp3VEZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyaM33cNRy/Jm707l4lue3iYmMRXz5yY4AJnoPTxaqIDcRyd+pn
	potOH56dejDVdXwmhPo/BMylhcTCZS2ui/rrVFJEu6NtL8OjlhMeUEsZr8+3xgY=
X-Gm-Gg: ASbGncv+kAMGiHJnhTI166sLRJG5j/rJD4U49VkeDru8MBUJSgvnDhNiJc9QLJe+gD4
	ZX1uSVmHxDmNptB3cmkSaKDBpNriIHXHGX2cCia8WBtk8HkbqN4rp0hoNO9U+vPHfMKRGX3qo+k
	YSU/V43bkhg7QbT1JzaXHOU8vjteBjcsenMROcNalfr8JKppuuaomU3bXh8WHf1H6w9CnWVZ6cw
	LI2FEa+/M+8H/Yk+AWML9H2N569vGEUxRTGKWKv/3zre5LRPRtRzebwEialBvkxfarrFyB1Ninq
	DuW7zdxGdxanTZ6ia1APc+6jzLXAyFNKB2y20R1oGtGMVZ13Z90v3O4P9nhu3V2Reb5UgYWg
X-Google-Smtp-Source: AGHT+IFRGP6yJdpVqApS9S/aczCeDW7cEdxeVDyn5gX3MHZ0LzmgIuZG2begu5ay7gyJ3d0hK4lbIw==
X-Received: by 2002:a17:902:db0e:b0:224:23be:c569 with SMTP id d9443c01a7336-22bea4adf49mr221463895ad.22.1744685219616;
        Mon, 14 Apr 2025 19:46:59 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccac49sm106681185ad.217.2025.04.14.19.46.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Apr 2025 19:46:59 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	david@fromorbit.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH RFC 12/28] buffer: prevent memory cgroup release in folio_alloc_buffers()
Date: Tue, 15 Apr 2025 10:45:16 +0800
Message-Id: <20250415024532.26632-13-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250415024532.26632-1-songmuchun@bytedance.com>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the near future, a folio will no longer pin its corresponding
memory cgroup. To ensure safety, it will only be appropriate to
hold the rcu read lock or acquire a reference to the memory cgroup
returned by folio_memcg(), thereby preventing it from being released.

In the current patch, the function get_mem_cgroup_from_folio() is
employed to safeguard against the release of the memory cgroup.
This serves as a preparatory measure for the reparenting of the
LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index c7abb4a029dc..d8dca9bf5e38 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -914,8 +914,7 @@ struct buffer_head *folio_alloc_buffers(struct folio *folio, unsigned long size,
 	long offset;
 	struct mem_cgroup *memcg, *old_memcg;
 
-	/* The folio lock pins the memcg */
-	memcg = folio_memcg(folio);
+	memcg = get_mem_cgroup_from_folio(folio);
 	old_memcg = set_active_memcg(memcg);
 
 	head = NULL;
@@ -936,6 +935,7 @@ struct buffer_head *folio_alloc_buffers(struct folio *folio, unsigned long size,
 	}
 out:
 	set_active_memcg(old_memcg);
+	mem_cgroup_put(memcg);
 	return head;
 /*
  * In case anything failed, we just free everything we got.
-- 
2.20.1


