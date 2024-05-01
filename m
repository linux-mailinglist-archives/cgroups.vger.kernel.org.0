Return-Path: <cgroups+bounces-2740-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE948B8845
	for <lists+cgroups@lfdr.de>; Wed,  1 May 2024 11:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0F821C230C8
	for <lists+cgroups@lfdr.de>; Wed,  1 May 2024 09:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6355337D;
	Wed,  1 May 2024 09:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibzd4s8U"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE00524BE;
	Wed,  1 May 2024 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714557240; cv=none; b=Le8TPssxiyN5oBqSAGp8rKdks80YdedeUh9woH+mEat4SGr3DZMDcrRUtQeh7ws8j33MsjJZ0JN1osb6ztB6s0S4NLDa/R1oSH0kC65bhk5l7L4o0KWfV7VM+x/MMoYVaIW6KNSfRI+LEGKM98m0OcyOfA+It9GyYJ/raB/BhLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714557240; c=relaxed/simple;
	bh=W8BKYSHno6I/ZDbLlUDxiU42eD/HUO9F/ZG28GDGRHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZxUM0jE59XfYkkKJkilMLBhzQIjbYTZi8PbWmD1Zk4+qDdcxKKCu4JdlFu2JQq14e1NjTKrgQ1XYOzaLXr6aTgcw+efSaaX6/GVVoCaiJuRzHfNB1vnxxYtDEBVLFxXEOwx2DUBjMvOOTZ541nruVDWl2OtNkSA7/28PtwMWtzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibzd4s8U; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7ded074a237so141652239f.1;
        Wed, 01 May 2024 02:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714557238; x=1715162038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sj0HBOnE/AZzpY+aRr1oFb31zLWbK1bfAK1h5C0SYek=;
        b=ibzd4s8UwfWO4GC74Qibo77pjPZs1UGgDT4jm/j1Hi4smz6pZk6Pgm4ilSZXrbOTa8
         5e148zavflprm4OVcDFubjUWLnk1vrMCiWqhnXUux2yv2C52NXGDmVogzKrPhI5kKifW
         3NU7HqlPoqqEGoNYZBErMvoWH/h5apuJiR0a1iZ7z7OpyLUWzWqWTmX/VcZxYLtDiOJw
         MtxZ6i7WKVbXqN7wNShMWdk7yn8GTxtwwy97mIc8OjGwVK+cDfJu2ym9t6/lnPZZM5ex
         94d8DAby2Y/OLw3uyGsOYSA5pkNFljOkBcZeuWDab+bTR99THrQGTksz8fK0gz7CowxE
         CO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714557238; x=1715162038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sj0HBOnE/AZzpY+aRr1oFb31zLWbK1bfAK1h5C0SYek=;
        b=GnTP+oe2/2+6VX2ChEexzPPXA3r64f3+oadTVjpnhY8eRQbEUk0mQQn0u4ii8CDFkz
         d7XEiim9knFrlsZlsc9N2yrdXHHP58r97bVfW213cvW1l+dU8+xv5GQTy6WSCUkjvl9t
         ckj5X/LAACSAOC0DfNFb1OXSRq5ylbBIlA8/s9rK0KzXKPhD5slukLmHUdaR+P4EVcvl
         7fD8J/HQEQGdPPJcgZ5UnvG12OHuQDe+qg9FB4bG2RJ/kNUg+gcpBPWUSCSOfPQFeNeh
         7ekELlC6uVunmSR++cIDLH5187EHsy9uqiBV7A8Qo5ZlgNHUWrZlwGQNuPqOP/DNaaAL
         lvmw==
X-Forwarded-Encrypted: i=1; AJvYcCU3zbx7R6pqWI9JJ2UxkKui1eKFgnNRMLBP0MDJhMMDjACG7iJvH0YO9E7/7XAaUz+03HPo5rq9EtzXa0Tf98csO3B3hiOFVIUySXZTnlKU+kJLOIwBdBfbVC7intd9rNcmZ/777c5fQfjYhigKc2Q43XN/btLvpZM6g8ILWFP4Wg==
X-Gm-Message-State: AOJu0YxXeNMAmM0b7gYc2CBG4u9zd9HoNNEqczf4XYhnALm/5JpeaCYg
	WukKGdJBwdYHnlzKhoDR7mHp+89ss/j49lwrEc+o24N7L7cPiWMZ
X-Google-Smtp-Source: AGHT+IGO+JZlCqTtLRXab1myxfgJ9pjUVq6GTGb3fjNOHplR8ZPlYSayGrHeTaLPwlQNOYDE3S31Rg==
X-Received: by 2002:a5e:a606:0:b0:7de:c3c3:b1f7 with SMTP id q6-20020a5ea606000000b007dec3c3b1f7mr2744011ioi.4.1714557237913;
        Wed, 01 May 2024 02:53:57 -0700 (PDT)
Received: from localhost (fwdproxy-nao-116.fbsv.net. [2a03:2880:23ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id r6-20020a056638130600b00487f87a60besm750356jad.134.2024.05.01.02.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 02:53:57 -0700 (PDT)
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
Subject: [PATCH] cgroup: Add documentation for missing zswap memory.stat
Date: Wed,  1 May 2024 10:53:49 +0100
Message-ID: <20240501095349.1407643-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
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
index 17e6e9565156..48ec54627814 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1454,6 +1454,15 @@ PAGE_SIZE multiple when read back.
 	  zswapped
 		Amount of application memory swapped out to zswap.
 
+	  zswpin
+		Number of pages moved in to memory from zswap.
+
+	  zswpout
+		Number of pages moved out of memory to zswap.
+
+	  zswpwb
+		Number of pages written from zswap to swap.
+
 	  file_mapped
 		Amount of cached filesystem data mapped with mmap()
 
-- 
2.43.0


