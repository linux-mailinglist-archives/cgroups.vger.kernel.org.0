Return-Path: <cgroups+bounces-4606-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62782965DE1
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 12:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D831C230DF
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 10:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444BE17B428;
	Fri, 30 Aug 2024 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wnTjAowH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEC116D302
	for <cgroups@vger.kernel.org>; Fri, 30 Aug 2024 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012257; cv=none; b=Ht8WbDtAg6i2jathT63IRIqQZR/vkUX0nQlScXN4YXbGOFe/NvXAAs/ayD3+NB7w+i8/rk+O8SZauVOlRseY/YFQRsUR93DxeX9ZelR3DNgMD4QYq39uJp1q7tyiXGa3kuCFKMGwCyYqaWSwMgMJE684CX9pHbLxvrkbamkVs/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012257; c=relaxed/simple;
	bh=rB5RQoOEvZgZP+NkbrNvUyrH/QmtFkl8k1kEu/UtBHE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TzER/2ZzBDXLYn6U2AK+A5RJP7r7JJ3HDTJOiaX3IWViHu4oCcNOJOYWxVJsX+YBv7vU2TSIxfRoPgkRgYw5T2w0bHfyFhZGKVUNLyCK8sZmAa8qhFvUbWkOxgVa6hpHuMvZw9erZEx3/jZUVUobXe1ocKmsws4DwUTjScShot0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wnTjAowH; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-39e6a1e0079so6323255ab.0
        for <cgroups@vger.kernel.org>; Fri, 30 Aug 2024 03:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725012254; x=1725617054; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3lZ9Hn/+qhJZklOxutGWnGoGesi1GdFiMvyIIRsd9s4=;
        b=wnTjAowHTlVPpq8BiM9fvpO+XwgwjSzb/rPhLXCtrj4yYqUOB3BwCOJHXCObNsHg/+
         CBG2DZ2PKk6PfMW2KzcIGERWrujCNN/ESjcVTlENOmCMXlwvy0DuKlGsM+/ajh9YzVho
         yZc/Y4frLr+YomzXgK3CFEoqj2uPDJyYq7WOO2NRdpBwFygOsRubcPHIAWRO84BniFu6
         rPuecBYUYG7uwInY6PLpE4j152rv+eVwBqalQI824jNzXofKzv5xSljTv91Um5zJaov+
         iHO3oX6t754C0DGVQK7do6DlLsSYV/LsxaOQbFAhUbflJZvKgQkDy6ajod2CZ5ubb8ch
         TfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725012254; x=1725617054;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3lZ9Hn/+qhJZklOxutGWnGoGesi1GdFiMvyIIRsd9s4=;
        b=fdJbANQvlE2P60uue70cTHO1Q2Mq6zaiTQQXtA9TT6gR/ikxj5JLVqzb7crdys+CnF
         YJJgRdYWBef6P0CKQ1N0jWSQSbB6UPMwlSkZxVpzju6kxs7t1j2SbsoVwS3fGJjvuvD4
         NOdy3lOrqy/bvYtDdYAF5pJ9G0Ek3ORM0FnJo/hMaYoW5331J91SY72nG4GJDEdWGmu/
         /ZnWXHjB1wnr5rYnj39ofvGKAiJaR8MI5kOdds7GDvtwzYH03BwZpFGDg1OaNJ+rDQ37
         7a+QKnlzQNVBoMkXbSy4UIT2UQVAod55TeB0Lfghma7dWjwfSahECo87Obj3lSo7hfKK
         mlmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN1D8Ch/U46b387BZ11ldsq/zVNPrn83DgDDt4SVxxZpPmwg/jE5h5UsQ32VP9G4EkrVsDUYVc@vger.kernel.org
X-Gm-Message-State: AOJu0YxBb4WD+3RzEwybs7ZDtgMfMHfzKYvGa9zQe93fmBTzvNvVeOvU
	u6r2qj4vWTnOGY9BXYqpRdfjr5aGS16niS7KZRyE3d30T4f6gHv1juYqXgAeuA==
X-Google-Smtp-Source: AGHT+IFHoSWzOOyn/+aRzsSVpFBM0RLJuqHCe/Z7Zw6PGRR+A0tTUlzRXDP9DWiAX4B3kTu48B1vIQ==
X-Received: by 2002:a05:6e02:178f:b0:39d:47cf:2c7f with SMTP id e9e14a558f8ab-39f3788c68bmr64439415ab.24.1725012254489;
        Fri, 30 Aug 2024 03:04:14 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e774c6fsm2618822a12.35.2024.08.30.03.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 03:04:13 -0700 (PDT)
Date: Fri, 30 Aug 2024 03:04:01 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Kinsey Ho <kinseyho@google.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
    Yosry Ahmed <yosryahmed@google.com>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
    Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
    Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
    mkoutny@suse.com, baolin.wang@linux.alibaba.com, tjmercier@google.com, 
    hughd@google.com
Subject: Re: [PATCH mm-unstable v3 4/5] mm: restart if multiple traversals
 raced
In-Reply-To: <20240827230753.2073580-5-kinseyho@google.com>
Message-ID: <56d42242-37fe-b94f-d3cb-00673f1e5efb@google.com>
References: <20240827230753.2073580-1-kinseyho@google.com> <20240827230753.2073580-5-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 27 Aug 2024, Kinsey Ho wrote:

> Currently, if multiple reclaimers raced on the same position, the
> reclaimers which detect the race will still reclaim from the same memcg.
> Instead, the reclaimers which detect the race should move on to the next
> memcg in the hierarchy.
> 
> So, in the case where multiple traversals race, jump back to the start
> of the mem_cgroup_iter() function to find the next memcg in the
> hierarchy to reclaim from.
> 
> Signed-off-by: Kinsey Ho <kinseyho@google.com>

mm-unstable commit 954dd0848c61 needs the fix below to be merged in;
but the commit after it (the 5/5) then renames "memcg" to "next",
so that one has to be adjusted too.

[PATCH] mm: restart if multiple traversals raced: fix

mem_cgroup_iter() reset memcg to NULL before the goto restart, so that
goto out_unlock does not then return an ungotten memcg, causing oopses
on stale memcg in many places (often in memcg_rstat_updated()).

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/memcontrol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6f66ac0ad4f0..dd82dd1e1f0a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1049,6 +1049,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 		if (cmpxchg(&iter->position, pos, memcg) != pos) {
 			if (css && css != &root->css)
 				css_put(css);
+			memcg = NULL;
 			goto restart;
 		}
 
-- 
2.35.3

