Return-Path: <cgroups+bounces-8669-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0875CAF5EE1
	for <lists+cgroups@lfdr.de>; Wed,  2 Jul 2025 18:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342CA162BFD
	for <lists+cgroups@lfdr.de>; Wed,  2 Jul 2025 16:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC43E2F508C;
	Wed,  2 Jul 2025 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/z1kNqZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1834179A7
	for <cgroups@vger.kernel.org>; Wed,  2 Jul 2025 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751474420; cv=none; b=C5FyoP5O3qQfrFaL3AU9GW5vn7IHaykHVb5JIjZbbhk/9TJxL5yhwOZ2HV0Ahty+U4kg6UzP/NHyN2jZfl/meomCZriZP1Qt3t732sZtkVIx6UX1j6BISFwPOLdH41WhBHdF+uvZLbTmrmPBer6uZto9uzUL+5PtHwJIlPjtEOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751474420; c=relaxed/simple;
	bh=kBWu8vFnnKdFQ2W4ZeBgGknT/XFCB4pu3lSwCZCvQkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jJusl0rBkGGD3ooBZHlEaaOhHwJiF5zoBS5CAEesd5kWnDSbcUeJM35Xyneh5jYZus6iJt3T8tq91ucJURRY8nKHi8cLA4WUDauqBXtlnB+vwTatkUu2p9Q3n5IljBQwx+v3FihOcvxSyBiHsOtkyFUH77RSQqY7TN9iXNRpyzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/z1kNqZ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso4156009f8f.2
        for <cgroups@vger.kernel.org>; Wed, 02 Jul 2025 09:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751474417; x=1752079217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LYT9JW6r88EyVDlNRFXW7BnBMbTsGCIOQXAVcj0hrFQ=;
        b=Y/z1kNqZ/HhZrLcaO84r4+d6dfoYjgcrOZ26zS6cRVfoTqH8EkdjTef969aQJ4898+
         JhuUPtsWEh7AcCRXsmv/Sxm3YeunXVKA97P4uDInHo6yrpiLkAKoDrOkSrhExlZ2fQ/S
         cHeqyW9iHNWGHXH2mHuxjEOBFERBeaScgECY+V9A5ZS74/dbUPgYvkCrJHUTrjE1PzZX
         b6lWsrMP2rzvEz1b1Zzgv8YdaqccUQ4zZf6vA7D0y1i0ZXmaO6VTrxRYjb+ooyrKisBE
         JinnppsZbnbfGYsUPuuZSYpRn1sDjqyN0WAIA7AWcCjeBcPKFoqeiRGD/UwG+s/MLVbw
         cnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751474417; x=1752079217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LYT9JW6r88EyVDlNRFXW7BnBMbTsGCIOQXAVcj0hrFQ=;
        b=VxM33uuMLWuPefL1diuT1ZOHp2CbuQIl0JyAZ6I5IPN/Jb8kouW+jQpqkYorcuHzcj
         bHwKUc0Fx5Qdpy/E2z1DamtOreI8gMi7RCGzfHeZCZLNf9uycn7/rhWNSg/FIkmBqWI5
         OG2KVXyoeV17Fqg768Eek3dRejHaPO10j2CqUpLds4c1O4u/QNP7rGplVzXrl5k8sIe3
         xj+O2dGeusGBKOu414Nrk7EBNqRbwdjJiLJkXshNrQ2gL0WBb+mI/kyzacxWbeu7F5su
         cBf3jlO1bM94ytQXbWGuCcIjyomgeN/VI8OFEt11yqWuFQpZ4x48j2KjlQDJKho3CS1B
         3h5Q==
X-Gm-Message-State: AOJu0Ywp4Ov4QjEI00sCVLKYXJpnaQwbUwzYtjLCYiRUMAjWxXM9HQYY
	WPnfaqrDFwWPLyQFZBsZLOOg5oN/JHHmNEABas481QlTwYPslKhf6+aZwjjxJA==
X-Gm-Gg: ASbGncsTrpKazDWdFL0cGdFSUWALwf7oDtgvsyfSFTiM0KaE89speufxs2F7gCqeYEg
	+8lvTA3R5Rcp6uWF7y4L6m+hIFgZPrRf6ckR3HGTAhuMhqbUatsrN7dzMpXZZCPDSKQgWOxHZtW
	vRENG3HkYiMYkZE+sSs4I/a7ubNzZg3xY+3ItgJ5AWlepbGMQdg4yey19rEnXGbyhRII3MJ9th0
	NDxLH4h3VMl/enjglAbEzq6gKgI9mPSAYGmMBg+26WrLROzkya8ejhASbmIvqyqQlE4r3qHBybw
	SMUorluJ9pEAt/XCWA/u+5ki7WTntdbAUdxwbVtzAmiknd1Z/3RzAJkOjBpwD0y/MDuIAl2GQBY
	=
X-Google-Smtp-Source: AGHT+IFeIaTQqe6FlNIzP1UHmY6tYXC13gNTJEpcLnrSBPmjWamAWB+RyR8KCmdbFJf7biu152h1Fw==
X-Received: by 2002:a05:6000:310b:b0:3a3:63d3:369a with SMTP id ffacd0b85a97d-3b1fe2ddc3bmr2826215f8f.25.1751474416597;
        Wed, 02 Jul 2025 09:40:16 -0700 (PDT)
Received: from localhost.suse.cz ([37.109.164.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5f8absm16756670f8f.95.2025.07.02.09.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 09:40:15 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: cgroups@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH] selftests: cgroup: Fix missing newline in test_zswap_writeback_one
Date: Wed,  2 Jul 2025 18:40:10 +0200
Message-Id: <20250702164010.8874-1-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes malformed test output due to missing newline

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---
 tools/testing/selftests/cgroup/test_zswap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index 40de679248b8..e1f578ca2841 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -338,7 +338,7 @@ static int test_zswap_writeback_one(const char *cgroup, bool wb)
 		return -1;
 
 	if (wb != !!zswpwb_after) {
-		ksft_print_msg("zswpwb_after is %ld while wb is %s",
+		ksft_print_msg("zswpwb_after is %ld while wb is %s\n",
 				zswpwb_after, wb ? "enabled" : "disabled");
 		return -1;
 	}
-- 
2.35.3


