Return-Path: <cgroups+bounces-2185-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B04C288F0EE
	for <lists+cgroups@lfdr.de>; Wed, 27 Mar 2024 22:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DCA21F2993E
	for <lists+cgroups@lfdr.de>; Wed, 27 Mar 2024 21:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24DE153815;
	Wed, 27 Mar 2024 21:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S4etqny1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFBB15359D
	for <cgroups@vger.kernel.org>; Wed, 27 Mar 2024 21:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575093; cv=none; b=i0A3wIoLdKEBkaGg+evvaQNJKfyH+lUxJhRz62kH2MdxbBgCIXEKCkxhGCvTrTsG81IH2KwJOr7cWRGNXgBQCyOPft1UgZrJfyg0wXoYoSatN2/H3ANQuNbdg2cDmfkYxbDmINdX+yeSyw674c9PA4r/7OZG6XEsNKrgFDzAMK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575093; c=relaxed/simple;
	bh=NB7Q6As5LCuC5IWAkmAIMr9K7a1mke7uPnTHkJnbklI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k1M2Eo0iXg7unBnC2V0EGA2Act4uBHlxdwpyrnqOVgaF0gO8P1/IYR+svXt78iKsXFxxhj3KQPUnnQwwJ93uhqHDYlYd4VApKMPWq6jtpX1H8tb3NS1+KwLv4yDkr+8wH/CP3vGO38VLW07y6ou/hz22ERAZUIw2Y9vXXmyVbOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S4etqny1; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd169dd4183so335759276.3
        for <cgroups@vger.kernel.org>; Wed, 27 Mar 2024 14:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711575090; x=1712179890; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J7Eobqr0LFBQ4KWjEX1Ii2cj/j9a00dqkQu19UHFfuM=;
        b=S4etqny1LdnIfyfzpyk2YSUzXWSmvUC7xsEss2xNipHRbf/fhB/MCe/OMJWvfy+lIS
         /9QIldAWBdbcSLKYDwoADXt2CnhpwjcJ3h1WxbtY49Sbh97kIb4J9aeMHEJltDGhucQO
         ijKZcONCUZGSKvajoGqrYL4hh0Cw4lD+h0WsZet/KD514cF7eF/0CNl97pNB9TAkdRKT
         bJ9LKWeqwVThDGUEI9vuqUpgb+SWx9dJHMRdtcvswfNn7GiUwfzp4U/DyfseM7FYwkBw
         kzPdPKJ4U+NjoIfEOzZuOjcj7BoPzIPd7pC/aq43X/1lgxtXGGLqmVAfCvZfYD/5kFjR
         tCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711575090; x=1712179890;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J7Eobqr0LFBQ4KWjEX1Ii2cj/j9a00dqkQu19UHFfuM=;
        b=P6TjFD7IwiuBj9MDUR6v7GibgUFhASFBSEtjkT0+dHo+vQvwiHU5OBgfuRq8w010qp
         sLzsIFcJ+FAMyGCslHhbPswVieEWj7fbp0g28u0UvM/INl72oMS/qllnVs8+YAGbWjcM
         N2Tea6scmxjPJ2QuDv+COswUYvMeer3ViJmHi8bdMXJ430qi9Ss3lSeOFGLdoH6cIm0p
         dyZYEORzn9oKxMh9vpbU7+kY6Usa5bz1UV5/Mdn+up32O4kh3X6WAB32sG2aUZ6ybCCA
         H4k7cISxyj/rboRHAlzy3cP3YLMkmCZ0HiGLZ08l+Enw55zCGUUpEJ1AkSeYnf0wKeR/
         VDgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVInjU/Rcp32BZeRZ438fsYB0nvqeBt5U7HokyC/IpR2LjhYZMX7woZyMT9FbtFbWP33y+CMX14oNXcxcB1cckZRdIdBWrP1w==
X-Gm-Message-State: AOJu0YzowxrAnGHfI/egN3ryZJ5C1EKYd/Bqe9ZlvFFxyyUlmJO8loE3
	E87tc1nqcZnp8Y46oBcfXuTcPFtU/NQU9ZT85lzueaAPSCCiiGKa5YfTQ1xFNJKkyO2Q/CAVE9u
	j00sBPw==
X-Google-Smtp-Source: AGHT+IEtjKFm0aB/GkGE7TLyxEpzw6bgXLiicKkfzUR/Ki0/1kiBkWenomFbSpLy63KHaGIYhCLu0OSP/VuU
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:6df3:ef42:a58e:a6b1])
 (user=yuanchu job=sendgmr) by 2002:a05:6902:2311:b0:dbe:d0a9:2be8 with SMTP
 id do17-20020a056902231100b00dbed0a92be8mr116972ybb.0.1711575090119; Wed, 27
 Mar 2024 14:31:30 -0700 (PDT)
Date: Wed, 27 Mar 2024 14:31:00 -0700
In-Reply-To: <20240327213108.2384666-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327213108.2384666-1-yuanchu@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240327213108.2384666-2-yuanchu@google.com>
Subject: [RFC PATCH v3 1/8] mm: multi-gen LRU: ignore non-leaf pmd_young for force_scan=true
From: Yuanchu Xie <yuanchu@google.com>
To: David Hildenbrand <david@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
	Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>, 
	Yu Zhao <yuzhao@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Gregory Price <gregory.price@memverge.com>, Huang Ying <ying.huang@intel.com>
Cc: Wei Xu <weixugc@google.com>, David Rientjes <rientjes@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>, Kairui Song <kasong@tencent.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Vasily Averin <vasily.averin@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Abel Wu <wuyun.abel@bytedance.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Yuanchu Xie <yuanchu@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When non-leaf pmd accessed bits are available, MGLRU page table walks
can clear the accessed bit and promptly ignore the accessed bit on the
pte because it's on a different node, so the walk does not update the
generation of said page. When the next scan comes around on the right
node, the non-leaf pmd accessed bit might remain cleared and the pte
accessed bits won't be checked. While this is sufficient for
reclaim-driven aging, where the goal is to select a reasonably cold
page, the access can be missed when aging proactively for measuring the
working set size of a node/memcg.

Since force_scan disables various other optimizations, we check
force_scan to ignore the non-leaf pmd accessed bit.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4f9c854ce6cc..1a7c7d537db6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3522,7 +3522,7 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 
 		walk->mm_stats[MM_NONLEAF_TOTAL]++;
 
-		if (should_clear_pmd_young()) {
+		if (!walk->force_scan && should_clear_pmd_young()) {
 			if (!pmd_young(val))
 				continue;
 
-- 
2.44.0.396.g6e790dbe36-goog


