Return-Path: <cgroups+bounces-6095-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EE1A0AA36
	for <lists+cgroups@lfdr.de>; Sun, 12 Jan 2025 15:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16CAC1886F5D
	for <lists+cgroups@lfdr.de>; Sun, 12 Jan 2025 14:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3AC1B87E3;
	Sun, 12 Jan 2025 14:50:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1591F1B85C5;
	Sun, 12 Jan 2025 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736693423; cv=none; b=P88aHJhLI+14uvtL38f8/9QdSe1kqhlYUHTDSKIS8hVE9eM+3l8NqB2pf8y2jf7ViIPaIT71LImTnZ2T44OdASVfyFxdIZowHPlCqIkJ79YTVClbnBJn4ngJUys0cfXLX9jttOB6/08sCRb5/ZTImHvCoI1PPsuKL8DKUaYIXFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736693423; c=relaxed/simple;
	bh=AAQ5kitbUKVxf0MWOLvAk+HLmeBOw7YzJcSZO/8d/Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nowcM+GUVm43akql0RAAEQ/bhPV4YnnHc1QE/6dOC2LnbvXsumQU6Pmt+dnTt4Ef5/r2pfQhHZ/zGpS5yNQvllexMSPYhmFoz194Wc1FNdRQQlPahnEO2d7WtfCl/8yK4ZZFqBYluqcCcCM5h7rmeh0f1CODJyNc+6UWeupB+zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=hehaorui.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=hehaorui.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2164b1f05caso58850065ad.3;
        Sun, 12 Jan 2025 06:50:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736693420; x=1737298220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uhy698aVp2re67sHRs+SXrFxmynjNM+DF6S2D2BFOF8=;
        b=FUMqptmgH2Lq6MJxB/M61Z8F1tJMwBwpwByc9Kbkq6blOUdc01tyd0L6Ju9U2jannz
         nlKyT+KEZZxAoCFq/ZnnhLkxZzw9vRRdVwcqBPigkQEc3HnmRtVlCqeM7FST0Q9aZ/R5
         SHocwkqVJYmRRS6l6+6kXtW1ik2FJTNXNLXxwAFTHeg/PyLvJgx1vx1idHX6XU9xwyiW
         MCWZd2r536UttabcwuR0TZgVaWYgIM+gNH/6QNjXhffqWsggI9a9o3W01Frn24/wNqnc
         gacZyEERpO+1oJ5ZVe96pN2dg5tWYtRCgVY86STcgEQqqp4FKXD/5rpRiF0SnS6TWNnM
         Qfkg==
X-Gm-Message-State: AOJu0YwZ4DmO3D+lUPY/y6HnvplGNldJ8lXpSGEFLsw0efQL5hngvWQR
	P1tV1aGjL3qYpVggVONeXAornYjqd8BrdkckYFSnWAH4qWJCnGgQS3xV/SaKp9FbFA==
X-Gm-Gg: ASbGncskOntLJx+JcZ7CH8II+ceA/wWEEnoUKcYD96gSKaw8ZJCJkQ4O8YBPEUHzLvR
	XqdS82+PI7GpafvMpM0sUUNG3Jg+dR0RHtrXAe+xQMk/79Bu9A0fRIfEBn12pyZRuD+YwI8qYS/
	TM8YW7CplAKnKHxvtbvbf9poiJtU0gSFbj32yrcO8j6PRE4zdh/Om0EQ58pzg2b3Arsx8KUlAWk
	bRqtWDN/lQehdaYcwRJH1HQEy+CgKpmj3kTY/K+uOiVqBIMelmJqeRgBfk=
X-Google-Smtp-Source: AGHT+IErdutXYq+ZXiiWBvc3ZAW+CiSNU0IgGAkJTG8NePpFBsWZ8oa4RweLp8cYwzyvgRowDlbmXw==
X-Received: by 2002:a05:6a21:4a4b:b0:1e1:ce4d:a144 with SMTP id adf61e73a8af0-1e88cd2943emr26698706637.0.1736693420417;
        Sun, 12 Jan 2025 06:50:20 -0800 (PST)
Received: from localhost.localdomain ([2001:da8:c800:d70a:0:740:2:113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4056a5c3sm4529517b3a.62.2025.01.12.06.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 06:50:19 -0800 (PST)
From: Haorui He <mail@hehaorui.com>
To: cgroups@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	tj@kernel.org,
	Haorui He <mail@hehaorui.com>
Subject: [PATCH] cgroup: update comment about dropping cgroup kn refs
Date: Sun, 12 Jan 2025 22:49:20 +0800
Message-ID: <20250112144920.1270566-1-mail@hehaorui.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

the cgroup is actually freed in css_free_rwork_fn() now
the ref count of the cgroup's kernfs_node is also dropped there
so we need to update the corresponding comment in cgroup_mkdir()

Signed-off-by: Haorui He <mail@hehaorui.com>
---
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index d9061bd55436..805764cf14e2 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5835,7 +5835,7 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
 	}
 
 	/*
-	 * This extra ref will be put in cgroup_free_fn() and guarantees
+	 * This extra ref will be put in css_free_rwork_fn() and guarantees
 	 * that @cgrp->kn is always accessible.
 	 */
 	kernfs_get(cgrp->kn);
-- 
2.47.1


