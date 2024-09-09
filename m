Return-Path: <cgroups+bounces-4767-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA82971F48
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 18:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BE10B23641
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 16:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CC916A955;
	Mon,  9 Sep 2024 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eTejcysy"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FE0165F05
	for <cgroups@vger.kernel.org>; Mon,  9 Sep 2024 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899549; cv=none; b=LJGfWmXKdoipulx6jtMZw9bdp6bcGDgSukc+SsKyFpLqssV73a87FcaVltCoXNw1lCKCPhLp3UheZqA+xtANRTo8MMxabnYGW6ks3SwRMYjryqWhcqpC27uwB9YHt+Dms4yzExW6oaIQ2zA5T/AQPk8UT97uWeFPwOJ4g7prwAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899549; c=relaxed/simple;
	bh=5wi8Dcw3wd8SAW+yjS2gtvuUpo3vzMFwvlt6X1nV1HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ka+7ru1N9TVZqTljiuoRc0bX2K1RPtpI48s+Y+VUuHN8S/6PjZ6uDXyyMAIR63Ka4G7kLYONI3FhzP/+/PEC1j366GFZ5fU6RCa486v4od83oiwb7fuP84tJvKqc+3MvbrWMCReufeqoC/Cq8B+uOCHPi5Sf2kQb/DfJMcdhXLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eTejcysy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb0f28bfbso19937895e9.1
        for <cgroups@vger.kernel.org>; Mon, 09 Sep 2024 09:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725899546; x=1726504346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcEdQE9kkUNRmd1oSgPgT8tBtd/F56AnD10peYUx9eU=;
        b=eTejcysyVlGYCEHDZ4Lx3IWvY73sExclGQ0Lfu6SGEjAMvz+rDx0nqemrVY7OzGEXm
         vI/IAw0xT+hvV1wyyzGO8uNF4clDjkVTUrIe+gFfXqBbZE6BAtEvK6RtSOxFhjKyFxN3
         MNX/4i/pwigu5QVoroJr0P5HhTi2i8j9R165J7JkuW2zq0d5srrc73PCN8jWC/W4WAYx
         0cGTdJQUvVU5bvzrfV8M+BeAx3+N7bJ/JiHjE03VgXoiByOvfTrini/FaIj409EyNctP
         qYhlQzEjtZ60jgJ1E4Ch8iekHi7asfpokYK3qX1slxYVEwgUFxlOmKDZ6MIKERgsIRo6
         6FhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725899546; x=1726504346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcEdQE9kkUNRmd1oSgPgT8tBtd/F56AnD10peYUx9eU=;
        b=GmnZdgjqa36r3OA+qJPOb09VYJ4IS32UyKx/X9JKOGcrWCZ29zWkOJ/sIASvHC+mAf
         dNWhetiaQZeJzqlN5ehA9UI0eQl5kpXewCBIvHOzl/PVZbvK8bRWYg2b75PxgGdfMXV+
         nEHUGL7D/7EuWppgxP/q6d9o57CRWyYGtL+RRxwmasdFMsIsFQ7f/RHQt27S2t7JK3ls
         /i6LUUyMlqrtKa2jdqYrGSGd09nqdtscL00Tyh7lKcHALlvQteK+wK/zcAlKD8nKKvCk
         YJBOvnvjijLTO45bZY5SAmyjDY4/zsIIcV+Dnf7FNVpLBJ9Jpcq1/VcDdGoiyYb0QS03
         uAWQ==
X-Gm-Message-State: AOJu0YybBkE9cRbqTuYQFcwakOphrrHBv7GgmpMWT4pERZgZ6hdvz3lM
	OkmPnKYgYpbS9CmSHdq2SUHfd0NvIqY3yg798N46TeiBzcYP9gzs56OJzLDy8LlZ6Ne6nLdiFwL
	T
X-Google-Smtp-Source: AGHT+IFYKssoeiQ8071s5mgXvgeKUkJPqXfUO0b5wcMLkjdGWzc7MF/UiF8wCm6ppGL882KotfQOTg==
X-Received: by 2002:a05:600c:1c81:b0:42c:bbd5:af70 with SMTP id 5b1f17b1804b1-42cbbd5b273mr10759625e9.30.1725899545970;
        Mon, 09 Sep 2024 09:32:25 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a072sm6478606f8f.2.2024.09.09.09.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 09:32:25 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chen Ridong <chenridong@huawei.com>
Subject: [PATCH 1/4] memcg: Cleanup with !CONFIG_MEMCG_V1
Date: Mon,  9 Sep 2024 18:32:20 +0200
Message-ID: <20240909163223.3693529-2-mkoutny@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909163223.3693529-1-mkoutny@suse.com>
References: <20240909163223.3693529-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Extern declarations have no definitions with !CONFIG_MEMCG_V1 and no
users, drop them altogether.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 mm/memcontrol-v1.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 56d7eaa982741..db2ebf8bea6c5 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -140,8 +140,6 @@ static inline bool memcg1_charge_skmem(struct mem_cgroup *memcg, unsigned int nr
 				       gfp_t gfp_mask) { return true; }
 static inline void memcg1_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages) {}
 
-extern struct cftype memsw_files[];
-extern struct cftype mem_cgroup_legacy_files[];
 #endif	/* CONFIG_MEMCG_V1 */
 
 #endif	/* __MM_MEMCONTROL_V1_H */
-- 
2.46.0


