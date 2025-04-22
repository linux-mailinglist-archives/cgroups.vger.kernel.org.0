Return-Path: <cgroups+bounces-7704-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 595BFA95D00
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 06:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 153AE7A288C
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 04:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EB0186E40;
	Tue, 22 Apr 2025 04:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="RRfGWmmY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A911FB666
	for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 04:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745296270; cv=none; b=hBHona96+xp4t6kLcLyajahArH8FwApgbcE+3bxFq2sMz32bpB8QgnbVp5YTc1lHKVQKtoA6SWnaSucYnshI5QfwnQDwl+UqTl05d8UGcLVaOdQr+SzX6mJd6UwhGaYQpp57YNgT4urglPpereZoZWKj/DgEZCZ5ZdBf+j7ZUNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745296270; c=relaxed/simple;
	bh=bI3gDzhCKMAkJw2iXZ9rkFzBnMcyw7cj4GHPEtHSj2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxye9HY2E+3UuXRFtcD3yvSZx0iwPjeEw4YSz0JoeGMYVpTycm8RBArQ7Q/+nZwt28WKAbLZN32pmqL2QQ7g9h7qcPkWIq4X1BwM7/12UbmrIpFk1PxwuXi+pLydDRF0iw4c0BXwkshAJFqrlH07kf+tOTaxMWNZR9z4+g4NFCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=RRfGWmmY; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e8f254b875so48316526d6.1
        for <cgroups@vger.kernel.org>; Mon, 21 Apr 2025 21:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745296267; x=1745901067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRSMksXpsf52yOD4IubO1aFNXvg4s4nX378ktXQqSPw=;
        b=RRfGWmmYkQL51c3ajNplCbuV2Gd3ETXRduN0H7YYuBC0JJGQKqyckamwphLJQjbrOL
         kdt71fG/uJV3CNZ2UcYQYevv9KMmL4D3ELLcwVgJyERTuDnby68fx7LisaAd0K/Nlv4c
         HrtiIRPC1ZHT6KrQsQVfRU2VglfK0mgBcRf7iGg8YyfG9ElR2yhHravoYjCIMCjvOj4S
         Waf79LFDnBnu2BijZKcpsIsEkqqNRz7pW5qbBi/6Dvb9sIjN7FWnnPsLUHEgovu2j0w9
         6PL6kpADCBj5JxRYggUPZeasEuc0uoSVDPh2vXZ+9o1rn/hFthyeGGNfhE4zOTOtl/t1
         BtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745296267; x=1745901067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRSMksXpsf52yOD4IubO1aFNXvg4s4nX378ktXQqSPw=;
        b=tIdZlkG9OfG/br5ZVNryfK8DddkKcItKhmtnZaAhFpSAnTnK4l4Zm2t7FifPW4qubC
         /uHT+h93+1qQcSFmtCV8CwXk5L3NHFOA3TTsTbCz5XlliUyPkI5ujV/0/GKfMkP2DSBd
         ydkoTcyA/xU8xyvJ4EFwmr+VmhSgesqV9kmH5QMFxiMu0FtQ44yVz+vs+2oAzxD0lNzY
         kn6wVDMntPASxwtknrxh7PZ4ZSmUmQ1QSEwVrtQOu9Uer6aao7/nD/5zsUtE1RxD/+1z
         V5wTpdI7qauFuJgb1ax0I5+JkH5ybjIVwpsbmweBTDKOmHVM0tZbU4qs3r6boYVCyxjF
         uQ9w==
X-Gm-Message-State: AOJu0YxkCL9M58sfgeFY0CCFYjJrYAy+ida0gsEMLCQKgHGVeWOrADaI
	F+JhnUY1noRUXF8UKkAJB432zGxkv5+rYRQAAWuLz0meMVA9MpvaQoBm5NLLMm4=
X-Gm-Gg: ASbGncvdbSfWpOmvq/mMbAlvpQASweAzPGbYdFPwDOAZgQ7pIc1HiGouf2r6hjlcfy3
	ttfWyFAL6c+QLxEHsK9ODtctYpvSBVvavLvZgSRVlMQLalhxt1LvA+TRq2nHuHQBfMK+fP+UGMQ
	nAssdl2die/8KfaR8nWamEFqdTpPhZgqk0y8+4GHokc68dhalwUUH/mWfCF28d+/U8mAIYIId/3
	KlZKi+LJhCSgKdE2jt0rpmebwx0c+dSLIjmCwBDN0/TfmXI8J6fpVZbF9/s6QBM0851zU9LhEzK
	jiWFNb/JQkgv0lJS1YcjKbbFOeBJj2mdEe6aUrHMUtM34qJ61myOXG2umdY7Jw2JXuiZ7KTp+Dj
	v24nJvcfxzmjR+5FNWGpE9Q7zEtiy
X-Google-Smtp-Source: AGHT+IEzQ3PXHur4luJ4jcRF7GRw/fek8cyUhcS6YWFUPEnKas0lDo2Hf0ec4S5N4vxVbonxlQQHOw==
X-Received: by 2002:a05:6214:29c1:b0:6e6:6599:edf6 with SMTP id 6a1803df08f44-6f2c4655ae9mr267147396d6.34.1745296267519;
        Mon, 21 Apr 2025 21:31:07 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2af14easm52745336d6.3.2025.04.21.21.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 21:31:07 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	longman@redhat.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	tj@kernel.org,
	mkoutny@suse.com,
	akpm@linux-foundation.org
Subject: [PATCH] cpuset: relax locking on cpuset_node_allowed
Date: Tue, 22 Apr 2025 00:30:55 -0400
Message-ID: <20250422043055.1932434-1-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250422012616.1883287-3-gourry@gourry.net>
References: <20250422012616.1883287-3-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cgroup_get_e_css reference protects the css->effective_mems, and
calls of this interface would be subject to the same race conditions
associated with a non-atomic access to cs->effective_mems.

So while this interface cannot make strong guarantees of correctness,
it can therefore avoid taking a global or rcu_read_lock for performance.

Drop the rcu_read_lock from cpuset_node_allowed.

Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 kernel/cgroup/cpuset.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index c52348bfd5db..1dc41758c62c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4181,10 +4181,20 @@ bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
 	if (!css)
 		return true;
 
+	/*
+	 * Normally, accessing effective_mems would require the cpuset_mutex
+	 * or RCU read lock - but node_isset is atomic and the reference
+	 * taken via cgroup_get_e_css is sufficient to protect css.
+	 *
+	 * Since this interface is intended for use by migration paths, we
+	 * relax locking here to avoid taking global locks - while accepting
+	 * there may be rare scenarios where the result may be innaccurate.
+	 *
+	 * Reclaim and migration are subject to these same race conditions, and
+	 * cannot make strong isolation guarantees, so this is acceptable.
+	 */
 	cs = container_of(css, struct cpuset, css);
-	rcu_read_lock();
 	allowed = node_isset(nid, cs->effective_mems);
-	rcu_read_unlock();
 	css_put(css);
 	return allowed;
 }
-- 
2.49.0


