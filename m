Return-Path: <cgroups+bounces-5046-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EA2993120
	for <lists+cgroups@lfdr.de>; Mon,  7 Oct 2024 17:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DF361C22C34
	for <lists+cgroups@lfdr.de>; Mon,  7 Oct 2024 15:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6331D9340;
	Mon,  7 Oct 2024 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWZzr5Dh"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674A41D8A0B;
	Mon,  7 Oct 2024 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314929; cv=none; b=PMc7nwax/7I4aonu6JRonAJtoRo5Tppp1H4fD1dgVXAmwgvhGAWVyB8/6UrCCrtjvWdhMAc+ceiYiI4qyjT2Xd6gylqvT0Ddk84GhGWsKDnL5XnTcrIntIS/A/rbW0tsvOitMx7t9W60AXDBybaGrxU5Nby1cVjbqlf+vA+rQHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314929; c=relaxed/simple;
	bh=dJ66qSUhaS4Hdlu8QOl+O0n4+V+I4RKTJF4Ex7jtK20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r9DM++QL4MjUyQNKbKWuP+aeprDGDl8y7ujcpykjPe29bYszwqo4sizyU854O2ihgpCb3tN8NMc9uv2TAPN++LtBmk5PIvcWtTNg/MjdOyAcTu+lgpaPZPHTfusfBUGeXR8YyBkNqIqCp27AwkDj/g2wdZ3bYlJj7zfAWPcGZDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWZzr5Dh; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e05198d1dso665370b3a.1;
        Mon, 07 Oct 2024 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728314928; x=1728919728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voC1g86BkP/+V85qhBuuOhqNyxDK+S1jUgtJ05iE0V4=;
        b=YWZzr5DhS58ZINL91OPEpakgGc3aK6a8DwxdjjLoZzufdnq6vVY1R0PpdERbc4NlAA
         A+TT7z0QOITfk3q47rpKqeTgD8gTr2JqWPaBLCCJcSyzsZlO30Hy/GK1GjK0uKjW18ui
         tMhr/yuZABklWZND8rdOYEFpi/8xfScIr7L1i54dsUsq3pTgibMgguVBVwjzXSB3VWZ8
         1Wfx3zY9+xBkPuTUQCe4BahGihjBwNLvOUaB1ws9fiaNJrXLw4uZlHRhMkvwvsn7DT/R
         KvCywTXmsZWDivzJdKO+VoyFlLnH+7BbLtpY9jvKtGNAKMlkiwYyor8xCkO+Uc47vIOh
         04oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728314928; x=1728919728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voC1g86BkP/+V85qhBuuOhqNyxDK+S1jUgtJ05iE0V4=;
        b=WIUz+f2qsWO9Tgzxl9bCOcTiod5ypwU4KJpN7+k6GRMw887JQ++DVsZcfINBZBft8b
         z5uy766mjdd0pbd/fj6BA7fPbOi8M9XNIyL7WbUUNCIK6gGMiKHj5WDOSk2DvwXkPAxy
         iUh/g4SQfrEx74TZ59qbarzC2YE+1ezSbqs2XpUcfXl5o5jIGgRPbHZLfUec7jS9m2II
         bMZAFaJJTBQOoWpJLjvdIu9AZsFJ23SDL6sSwfOnF408/eQjHtP+xvCMTibZ0IV79IgK
         UaMDRRUFa+elMLZykuDF8+q48ZsWnKexYFOEG/awpAisJrwArfoPRCX2NVgvggFuEoYv
         C5nA==
X-Forwarded-Encrypted: i=1; AJvYcCWejRQ3ncgzDYz0ypd07Xhb0/4erXKcLAq6/FommRi8cz1epgbkjAoXWdFTOxep64MNSYoSnAEL@vger.kernel.org, AJvYcCX9EnHWcYcYdJRrc8z0698Pp5N0fB2P4K4u3rxATKXB75vo/cguWSXpRwv5TeSbfHVsHG+tH1yAI6dvPxEI@vger.kernel.org
X-Gm-Message-State: AOJu0YzgEMQ8bmbDffln/6DNamMejw+uU4Cz459RwZSwhDJUZWKO51Ia
	n0lcNfl1ijJiRZP1pDGFj/bPK5w6+BWfsRgGg2Cax6z9DWSPeHo8
X-Google-Smtp-Source: AGHT+IEcBsvBOoXPaWjMiUr+UCxTG1R4zJVjDWwUz4MPamOaqvtGNKAjDi7vtp2lx7ueJWaymeKvrw==
X-Received: by 2002:a05:6a00:124a:b0:71d:fe40:7e68 with SMTP id d2e1a72fcca58-71dfe40808emr8419097b3a.1.1728314927613;
        Mon, 07 Oct 2024 08:28:47 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c4adeasm4360337a12.84.2024.10.07.08.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:28:47 -0700 (PDT)
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
Subject: [PATCH v2 1/6] lib/union_find: Add EXPORT_SYMBOL() for uf_find() and uf_union()
Date: Mon,  7 Oct 2024 23:28:28 +0800
Message-Id: <20241007152833.2282199-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007152833.2282199-1-visitorckw@gmail.com>
References: <20241007152833.2282199-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add EXPORT_SYMBOL() for the uf_find() and uf_union() functions to allow
kernel modules, including the KUnit tests for the union-find data
structure, to use these functions. This enhances the usability of the
union-find implementation in a modular context, facilitating easier
testing and integration.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 lib/union_find.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/union_find.c b/lib/union_find.c
index 413b0f8adf7a..c9fd30b8059c 100644
--- a/lib/union_find.c
+++ b/lib/union_find.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/export.h>
 #include <linux/union_find.h>
 
 /**
@@ -21,6 +22,7 @@ struct uf_node *uf_find(struct uf_node *node)
 	}
 	return node;
 }
+EXPORT_SYMBOL(uf_find);
 
 /**
  * uf_union - Merge two sets, using union by rank
@@ -47,3 +49,4 @@ void uf_union(struct uf_node *node1, struct uf_node *node2)
 		root1->rank++;
 	}
 }
+EXPORT_SYMBOL(uf_union);
-- 
2.34.1


