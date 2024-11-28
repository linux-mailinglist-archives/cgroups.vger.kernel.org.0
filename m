Return-Path: <cgroups+bounces-5710-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E259E9DBCF4
	for <lists+cgroups@lfdr.de>; Thu, 28 Nov 2024 21:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C67DB216BB
	for <lists+cgroups@lfdr.de>; Thu, 28 Nov 2024 20:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8F71C3027;
	Thu, 28 Nov 2024 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kGBruBCr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B951D1C1F1B
	for <cgroups@vger.kernel.org>; Thu, 28 Nov 2024 20:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732826414; cv=none; b=Tu8TX0gq9Fltvxlf13lRUIMxM8pG3u87Y3mePySW1U+egC6dSts1oQuTmoYv92+TA75va+hWql/Ib3n1C74ZCqw3FR7x9cuk3uLD/cl7Brkjw+gyYx7FF+RfxnyMDjPGH54FrpoSg149Piw5KgtPxWA76X2xVctoK/0cALSFiLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732826414; c=relaxed/simple;
	bh=j3gU30II2/wJHQtwPH7ZDMKKCj7DiVdiela1aCY84jE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fYvBPQu/oR8GZaIEBnnDda9WzDwrhHcsMhFkI+MRsNFMFVcnhUXVnvlkMIuD52UU/7kO/ohbrPMQSuWwI6Ll8yhLObu2JbEAISXk8VkyXWZqcRs7gBOKQkpeHolnsnoae1Bl26F7EwHgwpHtm+OiQxY8fjaUQIq9GmP/+pOMZpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jsperbeck.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kGBruBCr; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jsperbeck.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-20e67b82aa6so9449945ad.0
        for <cgroups@vger.kernel.org>; Thu, 28 Nov 2024 12:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732826412; x=1733431212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pGk8bO659Gdwu4si5LtMHbyU77sFm+9rlypvNi4hI1U=;
        b=kGBruBCrers14qF0vK7hBqKtjAhM8f1SPGZbWGLWfd6lQelzzovQhV7TzIl1gRS+zp
         kMfXHmDdyuOsGP7sQm/MKi/uiR6Pxi+W54wgZaazDPAYB/djju2WCIAd43PKdYd699l0
         w+/tsuI3kP6zsJxCyvnRDs3vxNw78dVN7TIPw3LfHD1Ci3j5fcv3baXn/DT4EvhZgcuK
         P7mEfKWVnmnFwy2sAaZ93pdTqUc5iaTQH82zqk+55kRPPDGApuzKJrTipUx5n+EQ2j+t
         9nAWeuo/yxntVYiXUNbQ2dCj+nOEEQf+FXA6LNMEMRGIYxoxAeQHQAjpMi3gh+w6Ax6S
         8xAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732826412; x=1733431212;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pGk8bO659Gdwu4si5LtMHbyU77sFm+9rlypvNi4hI1U=;
        b=p5Cklr6BwPJNIN93v5BYwK/ur34ajK/O9FuJNcou1tcVuIan5ZY+sia0ppiFdxAUTN
         PHqd3kVoNXJ7nVOZ73CeHjPB2A/98sSrrZTk/9y+C0goi8WjhDRFroixfwn+kt6NktSa
         MKUEIwsgQVg6jVabzbX5qWYfqeJg6jUaH9wP5urUIF8473aUUEpqsyA6SKqnxUMAQgEX
         yzR5fJ1iiZnERDZ2UlUiCmVoNUGp7YPgCbXPCpq4MJHPsaS9lHuMxkLspyhNd/ZqHmIx
         NEondqloBZ405Gi+C4ecf5RLlvXODV6My2lQVY8AJhQHF8ydX4HUmIX6go4w/3U1or79
         qgBg==
X-Forwarded-Encrypted: i=1; AJvYcCWTKBp8GasETl4RpdfD6BklJk+JtfTyqQWaplgH7PL79lJ4aLsHUXITnTx/4AaO2f+c63N+AFd0@vger.kernel.org
X-Gm-Message-State: AOJu0YzTfkKohIKjPea65cntAXQGtuTZxz+TtrF5PrOTfXsi+Rv3i1R/
	nSxW5zFe3iDuuH1L4nkoFSVg+asqqZKqSJI+cTWAW7nez13fUVbrcBCm6fUQSHMRjm4i6M7oO0w
	4+ChSejMoCZFppw==
X-Google-Smtp-Source: AGHT+IFDox9vopnXYUEG8CG2I5eMAAIE/yxMUeakJhOILWCxtW68hh+uiFnnogv2HA6ltR7OQxaASLO5KmJUslU=
X-Received: from plxe8.prod.google.com ([2002:a17:902:ef48:b0:212:2d10:e55])
 (user=jsperbeck job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:dacf:b0:211:fb9c:b1ce with SMTP id d9443c01a7336-215010967dfmr104811145ad.17.1732826412132;
 Thu, 28 Nov 2024 12:40:12 -0800 (PST)
Date: Thu, 28 Nov 2024 12:39:59 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128203959.726527-1-jsperbeck@google.com>
Subject: [PATCH] mm: memcg: declare do_memsw_account inline
From: John Sperbeck <jsperbeck@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, John Sperbeck <jsperbeck@google.com>
Content-Type: text/plain; charset="UTF-8"

In commit 66d60c428b23 ("mm: memcg: move legacy memcg event code
into memcontrol-v1.c"), the static do_memsw_account() function was
moved from a .c file to a .h file.  Unfortunately, the traditional
inline keyword wasn't added.  If a file (e.g., a unit test) includes
the .h file, but doesn't refer to do_memsw_account(), it will get a
warning like:

mm/memcontrol-v1.h:41:13: warning: unused function 'do_memsw_account' [-Wunused-function]
   41 | static bool do_memsw_account(void)
      |             ^~~~~~~~~~~~~~~~

Fixes: 66d60c428b23 ("mm: memcg: move legacy memcg event code into memcontrol-v1.c")
Signed-off-by: John Sperbeck <jsperbeck@google.com>
---
 mm/memcontrol-v1.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 0e3b82951d91..144d71b65907 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -38,7 +38,7 @@ void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n);
 	     iter = mem_cgroup_iter(NULL, iter, NULL))
 
 /* Whether legacy memory+swap accounting is active */
-static bool do_memsw_account(void)
+static inline bool do_memsw_account(void)
 {
 	return !cgroup_subsys_on_dfl(memory_cgrp_subsys);
 }
-- 
2.47.0.338.g60cca15819-goog


