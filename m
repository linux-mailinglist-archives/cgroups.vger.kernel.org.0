Return-Path: <cgroups+bounces-1608-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D989B855D6B
	for <lists+cgroups@lfdr.de>; Thu, 15 Feb 2024 10:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17FE71C20BE9
	for <lists+cgroups@lfdr.de>; Thu, 15 Feb 2024 09:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915A018637;
	Thu, 15 Feb 2024 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCf1m1/r"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79A21B800;
	Thu, 15 Feb 2024 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987950; cv=none; b=Mxw194j1p75T7nN94NNWgS4szjn79qzmnpWdLSo+GNYMTrZzkiGWM+w2tMFmzfl63dbFwhbm4natQVnMjTnPnTaML4PJVkJ6zBreiJhAaqUmNADXYdRL1xpys4G8sfw9BJyXgaiEewSc3DX7YvSE4qMnUJGJoGJp5x+xBs/EOgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987950; c=relaxed/simple;
	bh=JnikygGTV0L1C0s7aATZU4oIRtYgq/3UVngA0/kIiig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SGrajMR8fHPZYKvmYhN3jG1xoW3bHFzryXCu6XtHRvs4Y2IaGzlJecrtx8V3wH8+LzfGlSsQj7fMm2mzZCotT77eUvmcGjg4JlNMdvkpQ0xV4R+3YU4BEcOgXxtJQtN9LMKxlKJzW4yYKtiTHs1BH2/5bgmfLuf4it7oL5r5TnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCf1m1/r; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33b29b5ea96so277179f8f.0;
        Thu, 15 Feb 2024 01:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707987947; x=1708592747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GHSqObUcmXJP/v//6zzr6d18EETteUmBGUGblKDjj8M=;
        b=dCf1m1/rgJYHMUmVmhXmaiCvDRdv81SULFNUsZ/uSaRgCuWQR7QJ0UARSSnalFTxOy
         ulRzfLP6WvkUl8Mh9YdbXxuK++Ex6w6qdDSm9q5AJThjQItTDl0c+p6Vqv8StAbInSb6
         xb0upvyNNojea5RX9gmgXWBdHT22LfUG+kkpqy+fEgqsyS43Nj6kNUa3eOnoNTmGXiLF
         /sPCTesHMtuWT2jKsr3jXPzUsM1YHnoMNUsHI/1PNclJZYcfxu37IwMCTZH/OQ5YjXRD
         E2/2BhK4Rk6NsLxk8QAGWZkDa+7OL1MTy7GntIy9zcXx2y/fydS9T1uO2ZC/vdbFNbo9
         3Bjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707987947; x=1708592747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHSqObUcmXJP/v//6zzr6d18EETteUmBGUGblKDjj8M=;
        b=m4Ubgy5DHpaX6Xp6a27jv6fTPLHvcD+unKf7hjGJuB/u3EsfVeMhCbweWbR2cnFms8
         Ul+MMKHjHmLNZnHQR7JaCm0adkOuHK2WMhqjrAjGJlCKxhcFHrwlF7sohnQRRYYPbwoV
         crI6cgrdJph94AsXMP1Kk/slCA+EeUrSyBYpxjZrK7X3NVOpu1X7YVcLtIDiXSvASnUX
         YhccYwMZ5clkKkyh6hcCvw4je+ZrmGlMGlKmlFTLJbbLkTS+MUAWR3uDCk7MmGKUDTb7
         dPdvEiJqwF55i3DSLR6zAcGV/n9DziSceYdUK06jVzmuiOc9fASP4AvzkzOCj1LrQjsQ
         bVyw==
X-Forwarded-Encrypted: i=1; AJvYcCXnako06/VV0gKOTbHPx4DMqnl7iezYD7bpo0NOAZhoBTYCFp6sQPHIS6Tsdg8nHp4RR2ovWTJFNbkQldrxmvn05BxZ43U5GY5JKxskIwwO45JfVTKnthyhWYyZg8PnO/V8r3zCOA==
X-Gm-Message-State: AOJu0Yx+Pq0KeqCEJikNd4AnGkwKzvC7w1KDOpybAjSkqHSuNPRk6Cec
	P/4e80vLe5pH2mnbyg+rjjESq9R6p6JEz/0on2XLraxntwp33sMc
X-Google-Smtp-Source: AGHT+IGfSgQG3rzh4ImzyU27EoL5o9Uf5mWzcTnJu2/3PsopHrQdJnxYzivkze4hObQPMUMgckdpJw==
X-Received: by 2002:adf:fe08:0:b0:33b:1aed:c084 with SMTP id n8-20020adffe08000000b0033b1aedc084mr4135464wrr.22.1707987946588;
        Thu, 15 Feb 2024 01:05:46 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id k19-20020a7bc413000000b00410d897765asm4343273wmi.17.2024.02.15.01.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 01:05:45 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] mm: Fix spelling mistake "commdandline" -> "commandline"
Date: Thu, 15 Feb 2024 09:05:44 +0000
Message-Id: <20240215090544.1649201-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a pr_warn_once message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 94d1b278c458..95c3fccb321b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -8014,7 +8014,7 @@ static int __init setup_swap_account(char *s)
 	bool res;
 
 	if (!kstrtobool(s, &res) && !res)
-		pr_warn_once("The swapaccount=0 commdandline option is deprecated "
+		pr_warn_once("The swapaccount=0 commandline option is deprecated "
 			     "in favor of configuring swap control via cgroupfs. "
 			     "Please report your usecase to linux-mm@kvack.org if you "
 			     "depend on this functionality.\n");
-- 
2.39.2


