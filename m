Return-Path: <cgroups+bounces-5435-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D689BC0EA
	for <lists+cgroups@lfdr.de>; Mon,  4 Nov 2024 23:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B3BAB22752
	for <lists+cgroups@lfdr.de>; Mon,  4 Nov 2024 22:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946301FE11C;
	Mon,  4 Nov 2024 22:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1RWd7Bvv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08DB1FE10E
	for <cgroups@vger.kernel.org>; Mon,  4 Nov 2024 22:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759298; cv=none; b=R0+8Mw07KxJVnjNpGW32kqfKtoMBDoEE/2IZ8mKb9uMDwr/hwfgHSIHmG66v5neYNcchiJQ4/X335tOFbQb39QPx7TmH3YQjsA9VcM4Xv1dR/Rg3TJM431cVwnqdrHK1DZD9uJ6ntSDRtv8ApsdJzQLe3e9M/nIGUj4/MVtXP4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759298; c=relaxed/simple;
	bh=jS3VhDQe0RHXucAy7fChPZMlDpJINb08hArPK+wtgmU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NoF64uEdGhhbMlaiRutZkz/4nKUFliCeNtxXEvcm0lAkWwHE4vo4RjNx8cjGE0OQ/DJvyPRz8e7vRgY0F3Wpw7kHmewwfD4tlYQPWKRoK9y+MSPRDipdt5sLoDQWN1n8zqr7UGCUxa5eg8Ks7V/DQJ9sYtV7GYqi1h4NZzkbtww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kerensun.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1RWd7Bvv; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kerensun.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e9d6636498so92887357b3.2
        for <cgroups@vger.kernel.org>; Mon, 04 Nov 2024 14:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730759296; x=1731364096; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1YSqDn0sbFO9SXEJcmAUmq+AuYyNB6VQvHAGKw4UO8=;
        b=1RWd7Bvvundou4AKtP3w4KX4AnJF8pVzjJVliEC9YSRGHDjeWLkeIEvfd8Hcn9bS/A
         MtGwsRfSkIrDT1cIOvzks70dr5M6kQoF09O3epxCRzVmZFQSNRf7iS+I2HUaO8mUSlcE
         cfGFi8UPMKFPWBXmbvfp18g+ueZ1hF9eWsMWAdC6d/u+hG/x3cEFtDTJ1twnqgZ1SNNU
         t13uWSlaG8Rnw5OMa+hzs2xqbrGRZ/2L+G2uU8YUfXI8Br67pZeLfct2EXAup1FgRl7W
         Ux4d+80gbICiMzZ6uAmW1XIoPcocX4bYVZjavMccepPY/m40eyYCng9XdbT5Kbaf/pFo
         xP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730759296; x=1731364096;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1YSqDn0sbFO9SXEJcmAUmq+AuYyNB6VQvHAGKw4UO8=;
        b=xGA8kAXTQACQ+uBYBe8k5kVfmeFb0vWLq2J6JFIsWh/vmT1GR1Zcrg8O1Tj0KLZvxo
         w6IOu0uOa70199ztd+9HBBQQUP4PELo7E6CZ7/PuHrFAHKSkrUvCBsa1bjWioSvtBuu1
         lcUs8lLC5KBJBurh4kaiqqAbZWcDmY9mtRXNJDX4MLHsIWVNnLDY4KRoEuzBCd1Htss9
         5yIO6/kuDmXqaIbek2o1Q8GGTA9zZEMtjlJzMBT/LSVjPoyFAXVm7U8c/+FlHfA8DfPy
         YgGQrUM6+CELQypVKWBwddP+GiSoEpWpKRRNKXpDY65e9JkRzmnkIFkFVBcYtHy+U4fX
         oZHg==
X-Forwarded-Encrypted: i=1; AJvYcCXe4fbRf1lR+vO0cnkworbCfgFA09p5tJB3kMgyyIsl/J5FnxzShLgbWMo1yIO13l6S/5TEakwS@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkvy/mE4VxN+9P4l69idoj0xwPcqS3FTkp64OryAN6WAMJmma3
	vzDWWUfjYMOfhzBpWwf9ArOkQtoVuYw0M92czot8ODf5Yz06ADUgBF7K7ZZAv+7DLRmGzJaqY71
	SFqbtAqspuw==
X-Google-Smtp-Source: AGHT+IEwJ6XoH9jYvE9XepfbYW66gSHe6pDYBUEJ6j7mRhsOIIUs4LZTeXXSxAJhVRpRqXv6MfH+lzcIHJo1EQ==
X-Received: from kerensun.svl.corp.google.com ([2620:15c:2c5:11:2520:b863:90ba:85bc])
 (user=kerensun job=sendgmr) by 2002:a05:690c:802:b0:6ea:1f5b:1f5e with SMTP
 id 00721157ae682-6ea52518ac3mr273147b3.4.1730759295937; Mon, 04 Nov 2024
 14:28:15 -0800 (PST)
Date: Mon,  4 Nov 2024 14:27:37 -0800
In-Reply-To: <20241104222737.298130-1-kerensun@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241104222737.298130-1-kerensun@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241104222737.298130-5-kerensun@google.com>
Subject: [PATCH 4/4] mm: Replace simple_strtoul() with kstrtoul()
From: Keren Sun <kerensun@google.com>
To: akpm@linux-foundation.org
Cc: roman.gushchin@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Keren Sun <kerensun@google.com>
Content-Type: text/plain; charset="UTF-8"

simple_strtoul() has caveat and is obsolete, use kstrtoul() instead in mmcg.

Signed-off-by: Keren Sun <kerensun@google.com>
---
 mm/memcontrol-v1.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 5e1854623824..260b356cea5a 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#include "linux/kstrtox.h"
 #include <linux/memcontrol.h>
 #include <linux/swap.h>
 #include <linux/mm_inline.h>
@@ -1922,17 +1923,15 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 
 	buf = strstrip(buf);
 
-	efd = simple_strtoul(buf, &endp, 10);
-	if (*endp != ' ')
+	kstrtoul(buf, 10, efd);
+	if (*buf != ' ')
 		return -EINVAL;
-	buf = endp + 1;
+	buf++;
 
-	cfd = simple_strtoul(buf, &endp, 10);
-	if (*endp == '\0')
-		buf = endp;
-	else if (*endp == ' ')
-		buf = endp + 1;
-	else
+	kstrtoul(buf, 10, cfd);
+	if (*buf == ' ')
+		buf++;
+	else if (*buf != '\0')
 		return -EINVAL;
 
 	event = kzalloc(sizeof(*event), GFP_KERNEL);
-- 
2.47.0.163.g1226f6d8fa-goog


