Return-Path: <cgroups+bounces-6867-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 455A2A54DF2
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 15:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4AC47A6ED6
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 14:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A098176AC8;
	Thu,  6 Mar 2025 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="o08iJocy"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56CB13CFA6
	for <cgroups@vger.kernel.org>; Thu,  6 Mar 2025 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271865; cv=none; b=L4tllief9/n9aajbt9NArbNStiU8l20t7QhTag+olovChO/R1oOfmnUDvMb72v4mTlbUt8Vw7p3luxcQ1WTFOoK/0Rq/FbP4K7YK1DdnFNNX40MEYmcjsOoJV9CLKafmtXxu3xLk3QnJqqlZ+CE5lmNotcSP3VR97c9o3W6P20g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271865; c=relaxed/simple;
	bh=gF3YkWOhDXWK+rQ4xDnI05H9mTCsTY1efQ9MZ8j7GiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJ5Qc85ET5nEezzl7ArJ53Cxfr6YC1HBdbuZrjCopJouWoDwD8JOFG3Ubv8j6q5weXxSjM/NdfRKfTr1Si6EEmVSBvGxLmQ847OL1ZvLl8MtGdT+kIRJT1VoJK0FBLYayaFUDM+D8NDLNEn6IHI7RSCRH5B6hNLHl/i/MWl86UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=o08iJocy; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e8efefec89so5943776d6.3
        for <cgroups@vger.kernel.org>; Thu, 06 Mar 2025 06:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741271860; x=1741876660; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GkwQ0oLvEDj707o8NQ6UwhxGkpQaxXqiDQ8oga7M5qc=;
        b=o08iJocyF4q6cQLocHMoKYohAiOO/tgkRZH2jr/h51nK+Y0zJ5NqByHA8ow+NkCcsl
         ZATDyTW9YUSMmf426xyHRbZ9iiyNvgNdYiHkMPqTpBYdwCjgpgQUZLdtX+DL2E8DMbBE
         f8Z7K3KsvAOlGhWiKcUS2Ow6C0xLyrzydBUr7Apdk1vvwtanO5uotYkA5oPd+5pTjWVT
         kgDYTUhh/7P8A2FQqSVaiRb9LERiayjW93frFWlJdtvMGKyKFlePWBmm5Ct/G0ucwdQt
         cKLBeeI87/+PPX1T7R0Oa/r1QCs/+CCLd46zsbGiojhdjuJukHtx5Qrn557npW8+zw+V
         BmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741271860; x=1741876660;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GkwQ0oLvEDj707o8NQ6UwhxGkpQaxXqiDQ8oga7M5qc=;
        b=GlG6CY42a7nzXFMZlDKrrSEZSGPeNGA6wsebh3KsIm+azswPNQmUAsL37UV+3hPUpP
         nkQBXloZfn1jvdtzL8OpWVkVnwPJegxUFHebRMlRDjZVMtrZy4x20Cep7M8IxubO9onY
         qg8aNbPVKPCKp3SbHr4C0VyEmoFjo6kGvZBi+9Pcg1wrdkv9ckbnO7uBsxyKgItOuq15
         zkAtfqtpz3EJhRslTiGKQcjW2KBpYAxjgvAEaPg7GNvIqd4emIA2WjFRXhKCmXSuJ6ui
         PY69BLx4FkSVTHBbphgxTHKU+lQOzDiH039uDtniieXXkqB3a9SU7p93h654uNlCYbzU
         X2JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFRpABLdZ5RGrCc5K5VO7YsZN60atIZEHPc/MWB2c3JrOQ4nO58dFQMMC3Ofs431r8X6MUxs0Q@vger.kernel.org
X-Gm-Message-State: AOJu0YxBe08Xx1UsChuTaKxVL4YqiYSYIH4SjaJkpf5wQxNAQSQaHy+u
	MMpkdrca85C0S7OKKSivWTzkkrnygAyIqwcN4nd9HVGtReiFE0buo9xswGNRbLQ=
X-Gm-Gg: ASbGnct13tyKHmdiJAMxXPUN+O6FK2mEhzl5E1G8ztq0aslvuxPlXmozzrOYutjGehh
	rT9jrATX/RmkrO5J9PxXN62kVQakmi3Cf4S0sldZicAEbOcoKXbXnQ2OWKi4eatQARnvp4oB3Jd
	hDXYkCXw88KQt0AxVZ3ZhXzyAdoe00sfMqnR6rNLBc2qBCxLIDAnPaiR92+28/j+rhWQMvGRLNt
	wM++e6oVOc7CrtoFpjzYqiXTP3lp/Ija1bmXlY2VtfQpp44ok54MCfUP8+p4neG5fgGJHa2aDxr
	+efQZ2h2ii/wlNNIUvXfSFIc048oW35WWpTniQh3zuU=
X-Google-Smtp-Source: AGHT+IE69KzW444Tq3MFt1OkLKjayfvH3XmFTp4VbrSWCKV4Vo0xqPzJpBTl6QpVk0gBd6/iM0+Njg==
X-Received: by 2002:a05:6214:f61:b0:6e8:fb8c:e6dd with SMTP id 6a1803df08f44-6e8fb8ce9b4mr14514736d6.5.1741271860418;
        Thu, 06 Mar 2025 06:37:40 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e8f70a4495sm7760056d6.52.2025.03.06.06.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:37:39 -0800 (PST)
Date: Thu, 6 Mar 2025 09:37:35 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: Muchun Song <songmuchun@bytedance.com>, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org, chrisl@kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: fix swap counter leak from offline cgroup
Message-ID: <20250306143735.GB290530@cmpxchg.org>
References: <20250306023133.44838-1-songmuchun@bytedance.com>
 <CAMgjq7B5SyqYFbLhbgNCvQejqxVs5C6SaV_iot4P64EZLHZ8Gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7B5SyqYFbLhbgNCvQejqxVs5C6SaV_iot4P64EZLHZ8Gg@mail.gmail.com>

On Thu, Mar 06, 2025 at 10:54:12AM +0800, Kairui Song wrote:
> On Thu, Mar 6, 2025 at 10:32 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > The commit 6769183166b3 has removed the parameter of id from
> > swap_cgroup_record() and get the memcg id from
> > mem_cgroup_id(folio_memcg(folio)). However, the caller of it
> > may update a different memcg's counter instead of
> > folio_memcg(folio). E.g. in the caller of mem_cgroup_swapout(),
> > @swap_memcg could be different with @memcg and update the counter
> > of @swap_memcg, but swap_cgroup_record() records the wrong memcg's
> > ID. When it is uncharged from __mem_cgroup_uncharge_swap(), the
> > swap counter will leak since the wrong recorded ID. Fix it by
> > bring the parameter of id back.
> >
> > Fixes: 6769183166b3 ("mm/swap_cgroup: decouple swap cgroup recording and clearing")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Looking at the original commit again, we also should do this:

---

From 2685ca87d73d0c2b91cfd6959e381a40db235119 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Thu, 6 Mar 2025 09:31:42 -0500
Subject: [PATCH] mm: swap_cgroup: remove double initialization of locals

Fixes: 6769183166b3 ("mm/swap_cgroup: decouple swap cgroup recording and clearing")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/swap_cgroup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
index 1007c30f12e2..de779fed8c21 100644
--- a/mm/swap_cgroup.c
+++ b/mm/swap_cgroup.c
@@ -92,8 +92,7 @@ void swap_cgroup_record(struct folio *folio, unsigned short id,
  */
 unsigned short swap_cgroup_clear(swp_entry_t ent, unsigned int nr_ents)
 {
-	pgoff_t offset = swp_offset(ent);
-	pgoff_t end = offset + nr_ents;
+	pgoff_t offset, end;
 	struct swap_cgroup *map;
 	unsigned short old, iter = 0;
 
-- 
2.48.1

