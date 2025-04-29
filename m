Return-Path: <cgroups+bounces-7924-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D515AA3CB5
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 01:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C2A81B67001
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 23:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B4A231826;
	Tue, 29 Apr 2025 23:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U95xvnwe"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ABB2E3398;
	Tue, 29 Apr 2025 23:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745969944; cv=none; b=D/Noi2lJqKjPPotc3+DjWFAVbYKCMlPBakgFUP+xQQUyRnwY2h3nofc/q0dR0khSxmCSbgRG5kD5UcvUrdFtpYoK9o3Gi/PFgLDslUhMj1J4XTrjpFHoCR8F4F0nxSEBDXb+V7L9+Sr7FiNFdr2JA+5xiclxDlCLn/mnUsNXQtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745969944; c=relaxed/simple;
	bh=Er3hegLgwCFhC/Ruck5UgO4+9V5jnr65pYLNSjYW1MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prldLTghbHaYzahO1FvhiaBKts+R65FAHnkTCk5VjMSxaFw9h7vhi4bLfESGpCyAscpJabTzwVC2d6mzhoIOwGk7NsvIKEFXhKg6z8SgmZXRSxekJ5YbUj0fOIJ+H1RkEuXj3JUJ8BW7yBVJO02RuhMOAfQdHjL49faSzom+Pos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U95xvnwe; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-702628e34f2so4275497b3.0;
        Tue, 29 Apr 2025 16:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745969941; x=1746574741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEZyehd4zLYWxImC6V7ghpPr92k+M9DC2r20TkQaMas=;
        b=U95xvnweWNESnXY6xWsevHatngHnCFVZdL5I+aolh9+rZ/jvm/9feaj3saLEjXzTnl
         4GEclSNVviEZqFC5jXKAt7MUsVIFapPqy25wJ+phZqvvXiGCC2Rn0Khv6+W21OD8hQzc
         k+avANWqL3M3X3xoJoDIs5RZhyLT+xAuPmTqpxShdS9/WEd1ccyET8KAk8GAQxpBCtbH
         8KJdNj3yuakmlyUJize20XPcuHL9W+3cU365aMUWgyXUHXxLcmkUq2xk7lI1fU3IDkRV
         KLKfYw3j6ZbseI4axe7phPPylRDFxNAFlA7f/kPQCGfCajlgRkLN+JipW5+zhlRLDRme
         fyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745969941; x=1746574741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEZyehd4zLYWxImC6V7ghpPr92k+M9DC2r20TkQaMas=;
        b=A5fD4GW8X51OnFEYwPC8ZLGkxmjOmDYurSgrq1kjVmS8wAKSrAC5wUFUrubZiYIkbs
         92TjRdqPPs3wCDbg0LUHOW7UpN/Wjjw/Er/YBL7x3TIgATq04LdWzwtx/mrLZ5epDOIz
         pBJnCBmwFLX3JIbmWpeYAPt8YlhyvZ7FQBjwW7wsikchUOSbvsATlNe019kTD4wjnfQJ
         Knt1mNMk0Q7oWxm1x0hwqdj148dyz+t1oTFi4skUZYhQtNAlfCOps+uXKMg0RqUDtp/f
         gMiWsav5Rsg5WpO5GQpVPkonxtxgJ8ENGg3ckXnX62g8e35+ubqGpOCTc020K5yWzaii
         yQPw==
X-Forwarded-Encrypted: i=1; AJvYcCU9qht3Ugt39MPQEUSoEfW0S9H6BWu4ysC7hQZzbYc0Eg0HSnrGUtOxIEYORjQhriQmsAMWxd6SrMs=@vger.kernel.org, AJvYcCVGmUP5RhSmmRkgmFR/VervJq4AnWsLn9oqNXpl2HcIyPU4RT3uzSnW5VGdTAzt08iRb9P5EKKA@vger.kernel.org, AJvYcCXno4ida7KPkJzhmZlGaffy0iYePXWCtw3fzNUxkzIngodv57LGfvcgDKpGWDvOzBdbCLZQOPeNK9eN4poF@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtd0J+Z42mAIGSs9r0awBsm+7oFXQxLYjHLVjw59fnjPmlKrCH
	XfXfONto+CHhAzuwAdKFz62LrfkgbIEFqCIINx91EMT2VoaPOyhw
X-Gm-Gg: ASbGnctcNaPhMs0YOSLhziFSzoo20JRfNn0VYCHER1kmaMhfPD8GBFP9lOFN2C0wwlc
	qJPQabm16UT0to4QMM4NlE5fBrk96KW84e3iqrJ2ip2nwxnb23LR3Zu7kAg8xEu0UtZYHQ4yKVU
	42q5RFPnbLLJ+roBXsfpehjKbpeVH10I4xZb6xGUH2LOLTGMTlC1Z8+HcXwRODLeuch3jFf1b+p
	VZLw7zPJXwXk+DKkIVwFSxLeA7cbygs73r43mWtkG8jLGnwC2dtqdUKb+pAROMfS7yF12pxKiQB
	9Vb30tJh8Fj5F2ba1B6eqcl/Fv8yy2sDr8Ug20NEwA==
X-Google-Smtp-Source: AGHT+IHLBOt1mg0UkEf7TqpYRdSt7F/Em6EVYpt0sNHt2NR3UzEsMCk2MhPOS7GmiEg/ttkp85F6Dg==
X-Received: by 2002:a05:690c:998a:b0:6fb:9445:d28e with SMTP id 00721157ae682-708ad0cc1bdmr11913687b3.10.1745969941309;
        Tue, 29 Apr 2025 16:39:01 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-708ae035c65sm760327b3.42.2025.04.29.16.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 16:39:00 -0700 (PDT)
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
Subject: [RFC PATCH v2 13/18] zswap: do not start zswap shrinker if there is no physical swap slots
Date: Tue, 29 Apr 2025 16:38:41 -0700
Message-ID: <20250429233848.3093350-14-nphamcs@gmail.com>
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


