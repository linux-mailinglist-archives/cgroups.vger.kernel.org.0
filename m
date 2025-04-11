Return-Path: <cgroups+bounces-7485-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE610A868CA
	for <lists+cgroups@lfdr.de>; Sat, 12 Apr 2025 00:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E56E1BA52E8
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 22:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C47423BF9B;
	Fri, 11 Apr 2025 22:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="t+BtqV8g"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3708629AAFE
	for <cgroups@vger.kernel.org>; Fri, 11 Apr 2025 22:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744409492; cv=none; b=VUwFk//rorxQtZqN5WX2H/9KcYCdmNQWzwx4nFLHe7JyOejB5NCr1Y/RXWZoCNjiGDY37B3Pvz1jZH7/2QzfdnpGKCzlD9EbrlLqQBjh/tksQoRQ5JiwObTfZIOlB32Nxi6dNI7Bk8xc28TPu/Y8LHwK76yyW1W4gYlvbJ9n6Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744409492; c=relaxed/simple;
	bh=ewxzTYz7FpHsua4MPn9Pv3cPqlKa0+soWzYQ4CxwUFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/Hqmiche8AgaCs1HqPedD9vB8rRqWL8Ge9P9zVy+n4D952eBCicbXQrjf2Nmk+DX+Y9EdWhP7RlISuLllmakyH4T4vIg4t1M2YUCiz8wfagi31TSjKlvE5VwDMRuegH3Ze87ZLAKdTTtO1aZV+8KYFuJToqp6iAUnqy0xS6h48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=t+BtqV8g; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c54a9d3fcaso254120585a.2
        for <cgroups@vger.kernel.org>; Fri, 11 Apr 2025 15:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1744409490; x=1745014290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4knjTgfLUxexllxquvgcrExMdcCrRUJpeZqsZVIgbfQ=;
        b=t+BtqV8gRJZQaaZdxNACxutghKtvSgfTfabl9T89dypDzxrvW1WSxbgX2Ss1z2Ye/e
         o0eBN8QwpmBT4nSdTooH9TGRtrEBLad/tZt/fAj/NkrbwcAbJNgQgwK+dF8qKea21c1/
         3Jr+BZk+Qj8JGtyd1DCDnH0ZavW2bS7gM3Fac7K+3Uu7aRu24v70x0IZ+U9dQTdqR1hB
         8nc15RJo9MLsLATOwSPE3jhXPJGVNuzwnKXJeL9U2RvOC+Bh9pt4RACjQbI4HRlNovRn
         6/s9CdXg9mYzhnDwZY10DWf2zveU+2HIC71sbbVcwSubBVRcnSwEfYnznbOl6Zm90SGW
         Jnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744409490; x=1745014290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4knjTgfLUxexllxquvgcrExMdcCrRUJpeZqsZVIgbfQ=;
        b=RDSDgXXBrsMZe5X6fdO+AbzQ4bN8zZeKOkuDUB3qzMWGz/VYpwQh5wbu+ob26iJt+0
         3LKA9AmMUF1PSZoQeW3WgZfT5JxxvTiZoSKqSQVqYPFNJUqbGJPcXouidV6wx/SycrPg
         Ta0+Mm6ESxGBZjDnPeQKHlLYcBSkb7cUwKqIE+fWg5nsKoXbaZBIR9G2MJY5IzDfWcNg
         l8lDVFjdgiO9KJZ56CG1a1qYKHuLn4VpZysShQ8Q0Bd/VLi6Tnb8sQcXW6xZbDTi4afS
         UXayrzwR7DlkIjgFkyVn9c2abwUjJlVNWegB35CD8LfIV3ez0M1DeQ5gYpWCGww1pCA7
         xkyg==
X-Gm-Message-State: AOJu0Yxvd13tO6TBC+6n0fHsUQJETjhbnHXNp5zIt5pk1bRn8x6l/C+H
	Qq4NzLOBIHhhc3HFg2RjoKFTqU/YKg29iwzufZmKivTMWNx+eFQEPdZQLepes9A=
X-Gm-Gg: ASbGncsVwKX4b8t2EweRkFDOYtlosFnSoLc0Jm42vn/UbHtUp+aAPojOcwiqx56mjiW
	W8XGeA4LMVUd/gZOczvZVH4E00jP8+hP8mxvtF8AwVIfyxPlLV4S9mXJpUs6urlhkp1Baf+Mhv6
	IaJdGqUawTh3IWMg2MiVEUkKmOI4o6RmE47aT4PGKV+trC1BMt0Whky1OVvFQji2KbS6Ng/IFjV
	Q+Jgd3qnyjK7xZTm0JQCbDUiIp719Fc5C1865ja45bFhz6GAlSQbbK7WO7kHnjwyOSVBEljw6n4
	3FDImRvApuUmcSsZD1Gs3fT2d2N6d3dXfgRYjQn68lukGyL9JjLGBKivr/gufdxl70PKTMZz0TG
	6veUd+KxaGN5SYhpGaxgSQSe/I9cd
X-Google-Smtp-Source: AGHT+IFPrHSgjpnA70GEzyNSzThI5+wEmoFgLTgJqJozp7Gixhu+QP1bFfbShzpASwZwh2CD62666w==
X-Received: by 2002:a05:620a:4405:b0:7c5:5768:40b9 with SMTP id af79cd13be357-7c7af1cabd4mr698339585a.43.1744409489819;
        Fri, 11 Apr 2025 15:11:29 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a8943afcsm321264485a.16.2025.04.11.15.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 15:11:29 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	donettom@linux.ibm.com
Subject: [RFC PATCH v4 1/6] migrate: Allow migrate_misplaced_folio_prepare() to accept a NULL VMA.
Date: Fri, 11 Apr 2025 18:11:06 -0400
Message-ID: <20250411221111.493193-2-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411221111.493193-1-gourry@gourry.net>
References: <20250411221111.493193-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

migrate_misplaced_folio_prepare() may be called on a folio without
a VMA, and so it must be made to accept a NULL VMA.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index f3ee6d8d5e2e..047131f6c839 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2654,7 +2654,7 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
 		 * See folio_maybe_mapped_shared() on possible imprecision
 		 * when we cannot easily detect if a folio is shared.
 		 */
-		if ((vma->vm_flags & VM_EXEC) && folio_maybe_mapped_shared(folio))
+		if (vma && (vma->vm_flags & VM_EXEC) && folio_maybe_mapped_shared(folio))
 			return -EACCES;
 
 		/*
-- 
2.49.0


