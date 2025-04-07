Return-Path: <cgroups+bounces-7415-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E811A7F16A
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 01:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45CDD3AE03A
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 23:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A9E255E40;
	Mon,  7 Apr 2025 23:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti61MM7H"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D772550C4;
	Mon,  7 Apr 2025 23:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744069357; cv=none; b=OPguwdWgYb5iYkw2/44K+wjYYjU0SH8HnUdKyQ/ujHRAN2esiTjqcPctudJztZnYbPGWSAFCUuXsbiwbXPqG9ixlYUBf9pGl2c22hudF5QyDMJGcXpsDglQB+qOKSHSSTVETS7nbIbs3LW01sZII3srx4UcfFeI5wxmFPwXbBKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744069357; c=relaxed/simple;
	bh=Er3hegLgwCFhC/Ruck5UgO4+9V5jnr65pYLNSjYW1MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FzZwJmYXWfVWQTtTqsKNU4KcHAwHvUq/FAAKHRm5y7ao8PaWtGXOuD/WItf01MTvztFa4fYJ16sORVG/ceSD9yTpEbM/wuV1ZF8eMl+VXKYobQFHk+MDl5VUE8GgwMKHnv4IRTEnTWpLlXRfPvhlBnghzUOfzgmYR4vK5ErloMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ti61MM7H; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so4814441276.3;
        Mon, 07 Apr 2025 16:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744069354; x=1744674154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEZyehd4zLYWxImC6V7ghpPr92k+M9DC2r20TkQaMas=;
        b=Ti61MM7HWNyWGxAGkK+rdoqDbhonstrgswtIPK/sJ33RR48soOjZdyxRQnTvG+NlWM
         Gf/2/Go2X+r3QfiyWtGoVRVlkcRMG7lvpxedO1fmHGz4JqkR2JxiZyG3JAZGbS7jFZYq
         ZkDpCk6AqmU1sW2doh99GqpGO9MwU9vo1HVP5qPqyFhQZagcsv1L27PH1AKbtgLbtCFC
         ublMWZ0f9phdDG75OIP/IoSYAn9tBcw9RcJ2rkL6KGs7uzCQ7A0XB+pc2A3/3xGx3NB9
         zOVYvT6I0DkBAw8NIzHo5/dMFdVf5oZCUlYbC4rK9CbZB1Du47UCHIE0EUKyqV3d8Vtz
         Pi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744069354; x=1744674154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEZyehd4zLYWxImC6V7ghpPr92k+M9DC2r20TkQaMas=;
        b=p+turHNdpdPl9mvW6lttIxZvY47TgumlkQZqtfe5cB6CX2Xni8g370gETDVAKuojzj
         WIrGKgHn/xJNYuHjF7E1jcinGqvMslgvRptEajs8EC0YLWnCUMsCd9e0E2GGPGpK3C5+
         TnHRc7oiA5CfVcxzqx5BfjUFy3Pf8+FCXmwU+0Lhe85E+1xlxxazXT+pBDqGuaPHeoEH
         v/uecBZyR95P0cyNmJENSafzz5g0CsB1ApnJfwga9xdWKLjCD/SMPv05AlbQSt+KDlfN
         pK7UU4X+tVG+mbYyq6BRg87nZerxAJJYt6uNuNUfJ+Z8LHUkNP50966u3Zdg0aFHZmYm
         5xbA==
X-Forwarded-Encrypted: i=1; AJvYcCV5C2GoZLX3clRCJlvngpqQttVm4edTGTy0BIgHe/bvOzC4fGMVFvEHq2ThH011QkGhltKq0LKw@vger.kernel.org, AJvYcCWbNfDUg+mH7ordX9CHaj7j9vlpPDZRO7ZP8V/0g/Ahu2QtQV/OX9r53gP9mtFDUSQ+UGgNmvMXSW+lF2IE@vger.kernel.org, AJvYcCXHaKP7XkVpgU4Q4oZP7Xo/CQ3GST96yBQLjkrrGU6Dm3Ta9UN9EHb2hv4jx6dcOPVBIOfLqs34lmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRoWBbrWFufbUt8wJzKMjcOU+ezVPf09Fc0GR7rYheTrXPLBfM
	P3/lIR5cxXya5nkPRypM4p29lKr14IJQTDF/yaS8n+Cj6NDWF9vL
X-Gm-Gg: ASbGncuemmYSTcW2BngIxlk6rTr5xwbc7QxcXCD0aQk40vd08BqglPiJ9ws9VH7HXb0
	LbTqwL347jPx5u4GQqJYf96yQjj3oEzjZLXlCxQlJL8AZGdfWdp8WACo8rHeBQFfMqEe54+lc3q
	urRPRtjP5MzpCVqT3hh+ZSjO+Atd5K817uNLoilGqkrzyYYQn4ZNyLuQpzZoF+XA+nrFMzZ0FGU
	80zMyP+qBy9AQHm3bbwyiC3vcQ00us6vbfqnuQi2z0uWrp+BrndBulGV8Q1ZFr7NvaeghQOdcjo
	LTEtgrRtDIX5ZQ653wlo3P+WEfteUYZoK5Jl
X-Google-Smtp-Source: AGHT+IE5QNAfFkOFKjfUYz3+47925/olDBVlwaEQV+A5zw8RcFXQs1h3huSyPi7xSOcPqQJx6E0RTA==
X-Received: by 2002:a05:6902:480e:b0:e6d:deb9:6381 with SMTP id 3f1490d57ef6-e6e1c2dc239mr23407047276.43.1744069353752;
        Mon, 07 Apr 2025 16:42:33 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e6e0c8cf2d7sm2583871276.14.2025.04.07.16.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 16:42:33 -0700 (PDT)
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
	linux-pm@vger.kernel.org
Subject: [RFC PATCH 14/14] zswap: do not start zswap shrinker if there is no physical swap slots
Date: Mon,  7 Apr 2025 16:42:15 -0700
Message-ID: <20250407234223.1059191-15-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250407234223.1059191-1-nphamcs@gmail.com>
References: <20250407234223.1059191-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When swap is virtualized, we no longer pre-allocate a slot on swapfile
for each zswap entry. Do not start the zswap shrinker if there is no
physical swap slots available.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index 15429825d667..f2f412cc1911 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1277,6 +1277,14 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	if (!zswap_shrinker_enabled || !mem_cgroup_zswap_writeback_enabled(memcg))
 		return 0;
 
+	/*
+	 * When swap is virtualized, we do not have any swap slots on swapfile
+	 * preallocated for zswap objects. If there is no slot available, we
+	 * cannot writeback and should just bail out here.
+	 */
+	if (IS_ENABLED(CONFIG_VIRTUAL_SWAP) && !get_nr_swap_pages())
+		return 0;
+
 	/*
 	 * The shrinker resumes swap writeback, which will enter block
 	 * and may enter fs. XXX: Harmonize with vmscan.c __GFP_FS
-- 
2.47.1


