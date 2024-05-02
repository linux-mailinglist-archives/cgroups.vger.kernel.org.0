Return-Path: <cgroups+bounces-2752-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E078BA0C4
	for <lists+cgroups@lfdr.de>; Thu,  2 May 2024 20:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F2261F2286E
	for <lists+cgroups@lfdr.de>; Thu,  2 May 2024 18:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3222F17B4F3;
	Thu,  2 May 2024 18:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMzZD6iS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A894017966E;
	Thu,  2 May 2024 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714675996; cv=none; b=WxKwoAKLu5M0uZl7YMVwjGfWAPzp/b2q+Pk2RF1EbqfZAOS0ApAdS5GhCrqQ44yvBOmtpncziNCQ3hy2paOIDOW/7p9lzJpFV+NxfuIIrC3sNMUR2lrOcsDHBiqEGsgF2Y3WmrkVQ2PQFTUG7GdPFEkwjKby76qJC209cZwLnGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714675996; c=relaxed/simple;
	bh=yjFArawzln3BiaOAn6TICMkYyTZn4qj3AlZZURPaCXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpsVtWPFrDfbaXP0T2c6rwgqsBVt0CuP9bDofPoQxKyBeR7/Kl+fd8sxElHXYJEd2PUeDGrEsQYS093Dmi2YvWrYDWFbOOv2pbz0R2IZFZGloApXo96py1DoMQaoWm4eVTWb3MvC+NoRMecEqTHJ5fDyoAooYKZS6AIdVXFFIFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMzZD6iS; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-23bd61fbd64so3456812fac.0;
        Thu, 02 May 2024 11:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714675993; x=1715280793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EL9h0vU7ssp9YttMIiveDaZq+JG2HkazK/XWU9Wfp/4=;
        b=GMzZD6iS5xMDzk5I8ksMtOy94H7Gd0KbxY0YIKRZYFKF0+AeNPf3evudtJIl4xrNA1
         8sHO0DS3G//r+iB/AQs//eE1bL5smBSL6rjPEyhI3NUQjjxVMMoFX0JA3ktxQ8UQVv0A
         cvz0KdZ1Ck3GNb1JSALqGLKkQXi5zkBnUINV2OUF/nkXcM+XIK7pajtU2hCHZUO8MVBD
         tsd3IZ0PLTk906jYdHyp/jSTXQxItuAXmMAiPUrlhruZdgbVjnGnNCjRbcrukyPeSAa6
         1/eYzHq5KBukD2ElDIV0wj38ly9CeuerU6xYIvOyYB3qEZ3Zo6NPi2rMfZBsg/Nak8Rm
         wHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714675993; x=1715280793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EL9h0vU7ssp9YttMIiveDaZq+JG2HkazK/XWU9Wfp/4=;
        b=VQVa8AqxPp100FlenH5MU3taIKAchgcmNdqll/48W4vcF5dhCteJ2eOGhZBCCqPUBc
         y/FzV0jnQP3YnBFI7MREGh83uumnQvKjaMzQGSj7fHBT17dCXvoxgoxONb7ao1XGcAgx
         sEm3O0xBSUCd8f+V66IHHpapuQmyE9VtAX7NcDbTYn+MpXTZtDQpekwn9DDE2qleqg47
         2EduiUszJfB7fl6iNPbSLYnovM/yXKOVMAXsYP/moUi2WFA1O1AaBlEuT7kEnOoocTBw
         jvc29FKLM0RvwIqrz7xmodcxqj4qS7d3Ggs5mDkXmBunogrgqW9s9B92kKMGYjiNd9rN
         HA9w==
X-Forwarded-Encrypted: i=1; AJvYcCVhIuS6DYwgnj/3b0FjRs9yefzh9wPHWMzHnsTjgjzp0UkvuXLE3V9N9J7nlvA3pFYey0LAs5MrDb5wmqmRBosFaBbC7f75OODXPUMepv9MBp9YaE+PcGWDWvpGyLnx3FxZSbfuw+79ufzx+/HmnjRN+4jElBRJJTfW2OWsXpVIow==
X-Gm-Message-State: AOJu0YztRbeqxd+MlTzXuBgy4rE76O6DfHH5H5N4aYTNrdLpehvIWw3x
	Ga1uVL0IZwTrCNp4eOjehnviwGXQAzfUBxRWve2m0hDFNYiYzliH
X-Google-Smtp-Source: AGHT+IGcPZp+Wk/lZM9YS9WRMUtyz7gUA3y6FKzoddlervdlWmo36fHDgNqsGInwDiQIqk9Qh2ww5Q==
X-Received: by 2002:a05:6870:d0c4:b0:22e:e0c7:3d03 with SMTP id k4-20020a056870d0c400b0022ee0c73d03mr852288oaa.23.1714675992727;
        Thu, 02 May 2024 11:53:12 -0700 (PDT)
Received: from localhost (fwdproxy-nao-119.fbsv.net. [2a03:2880:23ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id bp10-20020a05620a458a00b00790f7c28019sm576981qkb.83.2024.05.02.11.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 11:53:12 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: hannes@cmpxchg.org,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	nphamcs@gmail.com,
	corbet@lwn.net
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v2 1/1] cgroup: Add documentation for missing zswap memory.stat
Date: Thu,  2 May 2024 19:50:24 +0100
Message-ID: <20240502185307.3942173-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240502185307.3942173-1-usamaarif642@gmail.com>
References: <20240502185307.3942173-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This includes zswpin, zswpout and zswpwb.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 17e6e9565156..eaf9e66e472a 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1572,6 +1572,15 @@ PAGE_SIZE multiple when read back.
 	  pglazyfreed (npn)
 		Amount of reclaimed lazyfree pages
 
+	  zswpin
+		Number of pages moved in to memory from zswap.
+
+	  zswpout
+		Number of pages moved out of memory to zswap.
+
+	  zswpwb
+		Number of pages written from zswap to swap.
+
 	  thp_fault_alloc (npn)
 		Number of transparent hugepages which were allocated to satisfy
 		a page fault. This counter is not present when CONFIG_TRANSPARENT_HUGEPAGE
-- 
2.43.0


