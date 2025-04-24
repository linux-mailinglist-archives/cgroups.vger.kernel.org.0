Return-Path: <cgroups+bounces-7804-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 254A9A9B5CE
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 19:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA673B7CB4
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 17:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D066280CCE;
	Thu, 24 Apr 2025 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1kZIoa9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791E1288CA9
	for <cgroups@vger.kernel.org>; Thu, 24 Apr 2025 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745517246; cv=none; b=MnhivUELvqQl4iuhtP2PNs0HkE9S1DY04uCYNDXnKzhUFYUoFt1b0JlUXRvk4NhBT+zp5qbwtF5zPbKKPuQx/kvLnFuRGCvQUF76mUg2+E6uv3t1ixqTtcJg8+X20pa5WJcZeDxF4pieG0Yi2ybB7rdbjRehXP/f4VvJ7QK8/xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745517246; c=relaxed/simple;
	bh=Ut82v2VoyJOyCrQgB8dhalHcgg+a5pDErXS1j9qoIw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tITH0EBg1TI8zY9O5xOrX44Xmls5J3oPjpQCLxKeAvL66gz9+KQs/Sl9CbSmaKN4zIYFkxvxXawhhV9fs4Otp0711Ekvd2wwpiKq1M0U5c9VfBxgctQf2MgD+O1rrw5wqhr58FfBDBNTxSfiCIWIGpWye1pv7aUubDW5+0kPZ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1kZIoa9; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-736aa9d0f2aso1778757b3a.0
        for <cgroups@vger.kernel.org>; Thu, 24 Apr 2025 10:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745517245; x=1746122045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hi/kTsluYJhiIVkGGBLD1BSga2knrh4DPi5oKSd18aE=;
        b=h1kZIoa9yw+ygxVDPnyMMko8nVl1/TGWFVfrB/HVqkGSEbx3iXUapBBA+R6lJRB2MS
         /7P9GhiE2upm4hAc+M43cPqLNFgDOvJSGJWelpAwseJJmog/TPm6S1bmDbI01sfxtRir
         A6AfCSNjoS0YDbEvYlCTRuWceWLW56z3mVn8IJxnu86Ww3KGb3MhacOSdHnjw9RwS0n7
         Lg4gw6j+P4hwFNW9hFqXojj6GT3jsoL9jXOby6y/YhqfPaX9E1t8eAi0elWkMxC/ifzJ
         HxO+1Vzrt95pP6zyAD0x14IlcUQHEopOUDwHpkrlZvDaowMExZY9u0pf5bSytCAnlbBB
         5dcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745517245; x=1746122045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hi/kTsluYJhiIVkGGBLD1BSga2knrh4DPi5oKSd18aE=;
        b=hurRG2fA/2Vn4Or172sz+iu2VprrlblYwa1XO8mSn6sNbAPIvOLv/5bCDaOol33fGH
         vZmOZ/A/RHP1pBUHEn4CucHwEacJrB8mpj4NLuQEoLM3RkBVipMnC0Q6/Y0rhOFLE80+
         igb6YX51ygWmxVTR2GfEItgzXckrAHJ+0rWvI1zbDGOYOlYamvcwx1p96eXHX1uhtW6A
         StANIjxvgBFY4CGnz5TkyCyGzpbzCMZYd4Yn3eRSAkKXO7mYfy2rEStep+LJYJ8MTE0e
         g9Fpa/xhftZ06ha2a7x3KFJKYt3i5II9P1yD3YZYLBV1NeDqqxy0DHnp96szJKixabrX
         ylhw==
X-Gm-Message-State: AOJu0YwgFpchr5j0yMPGmvFRVVt5VVfGG5UrHtNV3n/Mui9BNm7+dfrq
	8sZTx0MMvvK3gwKuOCbAjnr8o4kNUTCw9wYqa8VTy0fYagSLE88qjRKBXw==
X-Gm-Gg: ASbGnctZkLDMpR75xsfDCWfXoPdpw9q2qVnRNRS41dnfEwuqXx9nJgdlWgsuN5So/2M
	pmitBmYwhVftbZAr1xJg1I2UmSPbiMlPVnc+O+1tR4yIqqFvel9selkJ1n6HZQlhdTbV6LfCzHb
	OXsWJ0FW9glIOFkH7lRktV46NS55HlR8CrWrft97JUzriYb3BYO+HjZtAi1cmRzES9jS1FjRreE
	6E5yh/O9vVGvcdg+QDf6uu33GVqIMiiSupowkyMe7aUCXYV/GwCvpmmr9w6nOV5APudQTEr+A9+
	2K7bcDhTw1L1Qcqw0nOA8ayflf5ayI83bKIY3ta31583Onw9aMvh7y2K5JglLuv3O29z
X-Google-Smtp-Source: AGHT+IH6LlSrvTlWK1/8vTT+lGarMidJ0AJ3QOeuGzGezLatB/5YbNC02WGdRWja9y0lD3F7Dv7ZMQ==
X-Received: by 2002:a05:6a00:a801:b0:730:99cb:7c2f with SMTP id d2e1a72fcca58-73e245e2927mr5107244b3a.6.1745517244803;
        Thu, 24 Apr 2025 10:54:04 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::5:5d68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a9a113sm1744417b3a.134.2025.04.24.10.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 10:54:04 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: tj@kernel.org,
	yosryahmed@google.com,
	shakeel.butt@linux.dev
Cc: cgroups@vger.kernel.org
Subject: [PATCH] cgroup: fix goto ordering in cgroup_init()
Date: Thu, 24 Apr 2025 10:53:58 -0700
Message-ID: <20250424175358.68389-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Go to the appropriate section labels when css_rstat_init() or
psi_cgroup_alloc() fails.

This is intended for branch "for-6.16" on "tj/cgroup.git".

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
Fixes: a97915559f5c ("cgroup: change rstat function signatures from cgroup-based to css-based")
---
 kernel/cgroup/cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c284df1efc9f..7471811a00de 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5708,11 +5708,11 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 	 */
 	ret = css_rstat_init(&cgrp->self);
 	if (ret)
-		goto out_stat_exit;
+		goto out_kernfs_remove;
 
 	ret = psi_cgroup_alloc(cgrp);
 	if (ret)
-		goto out_kernfs_remove;
+		goto out_stat_exit;
 
 	if (cgrp->root == &cgrp_dfl_root) {
 		ret = cgroup_bpf_inherit(cgrp);
-- 
2.47.1


