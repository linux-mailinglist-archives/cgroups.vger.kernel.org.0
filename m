Return-Path: <cgroups+bounces-5037-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8E0991AF2
	for <lists+cgroups@lfdr.de>; Sat,  5 Oct 2024 23:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EE66B2186F
	for <lists+cgroups@lfdr.de>; Sat,  5 Oct 2024 21:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EE7165F05;
	Sat,  5 Oct 2024 21:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRJ+/4Om"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3511BC58;
	Sat,  5 Oct 2024 21:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728164996; cv=none; b=HQ5MeGCs/l/bIijvyiTlydKzT7jMXPdd86QgHTm7DEFpLGBDM3buF9gTuQxdY6qs400cWiQMsR/BRwKUe3uyuHss1sBnXUvVP3OwRGZX4BA+GZCY5DqaRi9ZGnaNoAgXIliGb7jQJt1i5Yo+9YxOTHQ1p8K8cizXHUheyRycL78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728164996; c=relaxed/simple;
	bh=4wjajMKCNGdDDCrc9L4MzfhX58BcF2pXpjqqWGnSF0k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C3QaOqUrBCgV/9tVllqCCehnZ76bq09axZ38E/qq3qpknCwwE3x/DpDqsS12a5LM29vS+mpd7QZFI3UOB22xehloY/pjcpboJLBbSR2stTQJtAwHsZzGKFpRpxGvhQmRu5xhiczLtzq+AU0tqWhK4qKw9EqIMwaQz0CK012Qjj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRJ+/4Om; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7c1324be8easo3122461a12.1;
        Sat, 05 Oct 2024 14:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728164994; x=1728769794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OXsRPEi8UDWbny4OJt56VdnBUYcq9T18wduabgzpSGg=;
        b=CRJ+/4OmWITmrjzhxp2FA9nojhLjimdlpPuYt1OteYkglhCxEs56C+r24zi55VSRfZ
         0iyQUmQVPTPtzBuzTjRWA5PlOvyYUbEO9GjvIW64AH4C77OMi3wqiYw2mvG3a6XPbA+W
         EMXQU4pqFGkLGAULiM7CMoxbKS+fXPvxKyZaG84bC+PrycDYZMNNufz9/hm5jqtBTuJ2
         29pH/VwkLTCcypRd09Pz/27OMT7ZdQ5Z9AAW/j1GbDUcfFQFGBrB6pneax8QO0oJSY2C
         WZyb3vgeqNN03wK+a2zYoedxCmu2Idc/eLsxWkxjAFNXXfpIci6Xd4Sz7dW9wpyXv0C7
         4R2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728164994; x=1728769794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OXsRPEi8UDWbny4OJt56VdnBUYcq9T18wduabgzpSGg=;
        b=VrKRtjMihWYAoEXp+rj1wqP0bt45aEs5+G3oVqQCgkeYNqRv+abh0iQXFLqO3Y6YEO
         FFlpxAigyu3vc1+x5asqkJbLTWoIrZjUDJ39RTb/c9AuG5BkPARR7BZFAZCnER5e2UrH
         sdMf6xnK2Nqpa0s5AgvyttUpKKPsdoEhgcv7funWUp/WLtY/pMSCKnS/Loh9xiLqC2kg
         niHXyVO6d1/Mv1UqKi7Ckyo9o9z5Rg+dj7ePFjQvCInJl8oXlOw4+tYKylWyyBIszeOI
         xKw4b76APx05zsqmrZKH7ikuSnsq2y49AfgH4uwuArLvOAbpYvIBg77HJ8Gt99AvLhRR
         zUOA==
X-Forwarded-Encrypted: i=1; AJvYcCXApTnoMsthik57/zrYDAOruGezFQZVBSn52iQhAeoFKCBmyKEuPwm8uN3mXNz6YUuBfKjAux3ghBQKLD3e@vger.kernel.org, AJvYcCXlHUXazTbgAtYVRK3MieSRlJHIH6u3Juv5WlMdnsDwngVEEAVSQkmTayTiXKnf4m76McdbXs6u@vger.kernel.org
X-Gm-Message-State: AOJu0YyYFrk/9ctkX0H5y4FNsQvkMOyyQ90OohMPjDNyhHqxzhh58oWs
	ayWDMF5uGWkah4/cA/aGMDWENeCO9MzKL1QYUDpHySzyWB5Cb0V0
X-Google-Smtp-Source: AGHT+IEMZJKwXQuD7nE2BwYc2v1gi+Qj1SxkukDWiWFSEeGPQZWQKYVvnEHK6LNDEAymJRDWYDpawQ==
X-Received: by 2002:a17:902:d492:b0:20b:6208:b874 with SMTP id d9443c01a7336-20be1914506mr167354345ad.21.1728164993892;
        Sat, 05 Oct 2024 14:49:53 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13931055sm17165135ad.139.2024.10.05.14.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 14:49:53 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: xavier_qy@163.com,
	longman@redhat.com,
	lizefan.x@bytedance.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	akpm@linux-foundation.org
Cc: jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 0/5] Enhance Union-Find with KUnit tests and optimization improvements
Date: Sun,  6 Oct 2024 05:49:33 +0800
Message-Id: <20241005214938.2147393-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds KUnit tests for the Union-Find implementation
and optimizes the path compression in the uf_find() function to achieve
a lower tree height and improved efficiency. Additionally, it modifies
uf_union() to return a boolean value indicating whether a merge
occurred, enhancing the process of calculating the number of groups in
the cgroup cpuset.

Regards,
Kuan-Wei

Kuan-Wei Chiu (5):
  lib/union_find: Add EXPORT_SYMBOL() for uf_find() and uf_union()
  lib/union_find: Change uf_union() return type to bool
  lib: Add KUnit tests for Union-Find implementation
  lib/union_find: Optimize uf_find() with enhanced path compression
  cgroup/cpuset: Optimize total domain count using updated uf_union()

 MAINTAINERS                |  1 +
 include/linux/union_find.h |  2 +-
 kernel/cgroup/cpuset.c     | 10 ++----
 lib/Kconfig.debug          | 12 +++++++
 lib/Makefile               |  1 +
 lib/union_find.c           | 20 ++++++++---
 lib/union_find_kunit.c     | 74 ++++++++++++++++++++++++++++++++++++++
 7 files changed, 108 insertions(+), 12 deletions(-)
 create mode 100644 lib/union_find_kunit.c

-- 
2.34.1


