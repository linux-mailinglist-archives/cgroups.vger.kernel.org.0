Return-Path: <cgroups+bounces-184-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D0E7E2BB5
	for <lists+cgroups@lfdr.de>; Mon,  6 Nov 2023 19:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D65828161C
	for <lists+cgroups@lfdr.de>; Mon,  6 Nov 2023 18:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5382C865;
	Mon,  6 Nov 2023 18:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AocWBtuf"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AD129412
	for <cgroups@vger.kernel.org>; Mon,  6 Nov 2023 18:10:47 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE8BD69;
	Mon,  6 Nov 2023 10:10:42 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc1e1e74beso43210235ad.1;
        Mon, 06 Nov 2023 10:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699294241; x=1699899041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6aeaOI8MbYrugaPJQaJX+2xkIjaYuj35oOxvaZJrJ1M=;
        b=AocWBtufpEGONulTPtfyxORMMyVf53nZku/owOleGGbP32u4pZChHoVjQ/XbHgQjdl
         r60TkqnESc70VpHXayaYbemMih0SEUDyafkKIX8feJNMGJ2LSQYLR7zuRBNqTYzylV2m
         7xPQSZ9EpAmRNaPA01341n5NfD9Tv48MKjcYcRf0XM9LvqP/+AzucJA/Ip+L8QtyBH70
         f/YNqzgb7saz1/1d4kttN28faD3uLCaRRDGfOGTabsJ05A138GCLre4zZGwCfbw9vWfv
         HGRU44Uq2HsGqguxqQI4u/kreOrvxZPRFuvluaKRrFFYXzV23MmeYjdMpFyXRyiSpxE9
         QGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699294241; x=1699899041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6aeaOI8MbYrugaPJQaJX+2xkIjaYuj35oOxvaZJrJ1M=;
        b=YWy6WaMwhQPknC8Uyjg4kjS+Ojy8xU1jQAhm0aUKRAV2kvWitm8FvHNxurGkrsTWBG
         Rpn+GH/2wccV2Hu3soHR+UGaXAeP3pH33D2pNIYzUVr3HPywKIuUGH1P6JcVArmJh2iX
         SMbC7rkFbQlo7lHJRUKqiZDn5OvDKQN41ffj6NN+n4HqPEt+rk5vV/piRGeiNWxM+DKx
         Qojzwj0zba3SOtejI8cmYNinbwW2TeSIbamPBIqY+xB+DsHf2+T5WOa6KgP3NcCGFeFE
         pffAluGeeQP7Wzhj1CTzdYb/PEhhTzIURgZBFIqgyj+ln8yZqKzYzDz0z3evB4n1F/EO
         Hcdg==
X-Gm-Message-State: AOJu0YygDCE/gVFoiu99rIdAfGjONPwc2h9RgoYOFQOe8XSfN26vuGMP
	pZZosI85EQ3zqz4SsnM6ci0=
X-Google-Smtp-Source: AGHT+IGPxAyjEIGTW0SVOf1c4n9pmp4SZmAl1KUT4gerqyFGpmwdD+PCMRj2sgL+m38KjWxF0YGP4w==
X-Received: by 2002:a17:902:f686:b0:1cc:510c:a0b9 with SMTP id l6-20020a170902f68600b001cc510ca0b9mr28510882plg.34.1699294241376;
        Mon, 06 Nov 2023 10:10:41 -0800 (PST)
Received: from localhost.localdomain ([2405:201:6815:d829:2ad7:8520:6556:6c40])
        by smtp.gmail.com with ESMTPSA id t13-20020a170902e84d00b001bb3beb2bc6sm6167173plg.65.2023.11.06.10.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 10:10:40 -0800 (PST)
From: Atul Kumar Pant <atulpant.linux@gmail.com>
To: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	shuah@kernel.org
Cc: Atul Kumar Pant <atulpant.linux@gmail.com>,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] selftests: cgroup: Fixes a typo in a comment
Date: Mon,  6 Nov 2023 23:40:34 +0530
Message-Id: <20231106181034.117120-1-atulpant.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
---
 tools/testing/selftests/cgroup/test_freezer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_freezer.c b/tools/testing/selftests/cgroup/test_freezer.c
index ff519029f6f4..8845353aca53 100644
--- a/tools/testing/selftests/cgroup/test_freezer.c
+++ b/tools/testing/selftests/cgroup/test_freezer.c
@@ -740,7 +740,7 @@ static int test_cgfreezer_ptraced(const char *root)
 
 	/*
 	 * cg_check_frozen(cgroup, true) will fail here,
-	 * because the task in in the TRACEd state.
+	 * because the task is in the TRACEd state.
 	 */
 	if (cg_freeze_wait(cgroup, false))
 		goto cleanup;
-- 
2.25.1


