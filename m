Return-Path: <cgroups+bounces-5367-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2659B8E34
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 10:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 943C01F219CE
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 09:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC7515A84E;
	Fri,  1 Nov 2024 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jwQ3JUgC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F349942C0B
	for <cgroups@vger.kernel.org>; Fri,  1 Nov 2024 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730454910; cv=none; b=F/6wyxe16QUjxPCBZ1j6q50gig5ZR8ifIeiMdKJYN9YduXaXJVkoMruYll1rNTQva/lHcKVQbAP4WM+3b9DLZ0yfTZuuVu3mgT1k5xM8T6syEjfweC5xpI0eTzJEwOw3+Hm6EuFolhILlNgQXuDySYuN6TydKKpOit5Ul7KYQYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730454910; c=relaxed/simple;
	bh=fk7KTD9fgJ7VH4wLOaICJs2JRX5gZLgDAq+3FdiAnMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DgGCZRmrqlcqCDzVMaAH+DBQgi33S56HPCDqqRe70GjOnaICNGDBHT01eRuPmC0+VCKw0fD7oEYFunDPgn5I5631CEpG1EZ3ycsw6G4gHBr0pLpPqRuucb0KF12wUM+ny14SZxbvjDlooWlyYmf1sPktcfyIVRIB7TSdeD9atOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jwQ3JUgC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2110a622d76so11504765ad.3
        for <cgroups@vger.kernel.org>; Fri, 01 Nov 2024 02:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730454907; x=1731059707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QUcSqKxh8PfJmGTPunCdl9RD0jnPfoQbCentgp/YDs8=;
        b=jwQ3JUgCdgbZNlvRd5/DgE15O+4x9kfVYDH9u9YXLbWyyvdN3SksugwQByIDFA5o6k
         ST45w5HMAGw2mxVtAfvifdxozIn5XNc4zcA+7gVSlOv4eOK9Cw00qDoapTFRDELoVNt6
         i8ggMuWHkMhfWrCV5wt7C0kyDQIoEV95FwRmBrqpdYDNLXUfoxruvxnjm0FEeY+BH8Va
         GU+qL4DKMy+2qZxaK/mwVYASL0D6BwGObHhcYDYR94wJL+i8IFqjEHmyhKypkORJZtIV
         MA2IYREL+LNMkcBltk8TCp/NEk7BSRZGn5Gk67EJvANYJR7JaMqHY14ZrjaoBhLkhuLl
         5HXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730454907; x=1731059707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QUcSqKxh8PfJmGTPunCdl9RD0jnPfoQbCentgp/YDs8=;
        b=Kbz0jjZVLoUlORRCq24t8fSWSNF4gtlttBKOXmlqQoMnLufy6yGDnGGyaWYcFz9X21
         bXRy5B783h+FxhC+RBPMoyIPk73xkHzFh14D30Z3NTS8nWwM0XfHlqFYonn2B5ZN5kqM
         V6Z3bJhGI/+5jMZotJiWGWjE9oTZfpVwDlb6gJkNdgS/PMxTEvhyCiX7lou9zVcLiZDY
         Rm+heXMXKKmpHZh1/F6EQTKuzvL3e6D69JFIUXKSblvrUxSPcaKUtczFv3g6IJXLRALU
         lPiC/0za8r1gL9hbQjM6HJU1KDViaD8djRQliFyYfPnZn4af1pppP43NVfacYtxC4XHP
         iJyQ==
X-Gm-Message-State: AOJu0YxRBfflCqbDwaoTgvoej/uTsftOXRZZVg9SKCdlZoCGh4TgqX8i
	120HX/1zwM0pXQCbRaEEmXEfYZz7w4iyXw/w0oyL/aHpLwW7CDx22dirs1PjLTE=
X-Google-Smtp-Source: AGHT+IGZ6s2M4wWBQ7i971qYJE8UZ1/VrrNCrsq9Yr/YMhPj/FzgAq7VPvy8g3uqSUyc/PE4fWA34g==
X-Received: by 2002:a17:903:2b03:b0:20c:5e86:9b68 with SMTP id d9443c01a7336-210c68a1a99mr333797045ad.4.1730454907228;
        Fri, 01 Nov 2024 02:55:07 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d99besm18962975ad.286.2024.11.01.02.55.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 01 Nov 2024 02:55:06 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	longman@redhat.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zefan Li <lizf.kern@gmail.com>,
	Zefan Li <lizefan.x@bytedance.com>
Subject: [PATCH] MAINTAINERS: remove Zefan Li
Date: Fri,  1 Nov 2024 17:54:09 +0800
Message-Id: <20241101095409.56794-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

From: Zefan Li <lizf.kern@gmail.com>

Not active for a long time, so remove myself from MAINTAINERS.

Cc: Zefan Li <lizefan.x@bytedance.com>
Signed-off-by: Zefan Li <lizf.kern@gmail.com>
---
 CREDITS     | 3 +++
 MAINTAINERS | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/CREDITS b/CREDITS
index d6cbd4c792a12..a00efbebc3369 100644
--- a/CREDITS
+++ b/CREDITS
@@ -477,6 +477,9 @@ D: Various fixes (mostly networking)
 S: Montreal, Quebec
 S: Canada
 
+N: Zefan Li
+D: Contribution to control group stuff
+
 N: Zoltán Böszörményi
 E: zboszor@mail.externet.hu
 D: MTRR emulation with Cyrix style ARR registers, Athlon MTRR support
diff --git a/MAINTAINERS b/MAINTAINERS
index 32a63c456aa0d..e6db40f53784f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5664,7 +5664,6 @@ F:	kernel/context_tracking.c
 
 CONTROL GROUP (CGROUP)
 M:	Tejun Heo <tj@kernel.org>
-M:	Zefan Li <lizefan.x@bytedance.com>
 M:	Johannes Weiner <hannes@cmpxchg.org>
 M:	Michal Koutný <mkoutny@suse.com>
 L:	cgroups@vger.kernel.org
@@ -5693,7 +5692,6 @@ F:	include/linux/blk-cgroup.h
 
 CONTROL GROUP - CPUSET
 M:	Waiman Long <longman@redhat.com>
-M:	Zefan Li <lizefan.x@bytedance.com>
 L:	cgroups@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
-- 
2.20.1


