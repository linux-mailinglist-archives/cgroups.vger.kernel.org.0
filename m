Return-Path: <cgroups+bounces-6822-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B65C0A4E5B4
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 17:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B11903BE3FE
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 15:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7585B2980DA;
	Tue,  4 Mar 2025 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QgTw9Ucc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E61290BC6
	for <cgroups@vger.kernel.org>; Tue,  4 Mar 2025 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102746; cv=none; b=aqOPUq/sRFRkjajLOjJPixrKyuNgZq+Iy4Vgr92sMONO9wfvDJmevXyHCiSZRXQkCP7/JMnmnVCFOFMt0FfEvEhYn0pq2AaHC2FqOisK0sVGPNuDoJsxe7B2Fda9man8SeK8eyNjYizuZn5JCU/FO22WOhpAl8aPg4/QU6uyAgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102746; c=relaxed/simple;
	bh=uEBo2XwkWIu1kEQdFfc+UP0MGpzG764Wn7p6Ra7wCqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dz3m3Ch1U7WuWyiyDU8msf/V89UuzzNRP3iL+4objCBpWLTcfvW9o+qrR614XU2FzIq9xOBgEAKyLal36miNVttF1DzefzO4Jq+pE8bVQLYnapIxKO3y8WOelbO1PDr5yGtBb5b15JUs9f5g1FEg7oY1yfJychnDu+q2XaRjceE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QgTw9Ucc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43bcc85ba13so6784885e9.0
        for <cgroups@vger.kernel.org>; Tue, 04 Mar 2025 07:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741102742; x=1741707542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhMHstYP/DAcPBOLk4EEWApjXQhALePsm/Er/3v899M=;
        b=QgTw9UccyVFux+Vzt527ZlRdEEyF6sGd6zoXTXS0p45mPX9AzYejJpkn2vqR7TsLpx
         R52dwdvY571HVzEMMaFSL6H9goHxavWIFiL7FS8K4VxUFvHSP25zU1TmLdfEfitFzC/f
         GOhvhPpio+foB3nG1G2wj7z+mLTUKtvGH6AWSQqU/qr3INofgfHz4uzZFWBLs9iyqDjz
         74STZli9eGyHQlKwYEG5OBAf59pLUHkhdvJPlNhI2KW2uoj/q02A0L2PmPwC/F/FjAhw
         81qFOHe8SDmPP1exWfvOrNvZeNPqe+yRULlrBJn20zOSzMnvO9GUr5RRcGrpnLLR4cF1
         V4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102742; x=1741707542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhMHstYP/DAcPBOLk4EEWApjXQhALePsm/Er/3v899M=;
        b=LX5lGMPJFGDhaDfziZblFwfMvSDJqTLw8CqqoqunE7UkcYnkdUCUr5NgByjSohADh2
         X/Hz8JbZHvHyOatMWLcdYU4DLoV5xEr12AerylYQFUx5bcZevCoQGIOs92/QqmIpSDdS
         vX6IYTz3+51yeSXF0KlRP8pW3tdhbkLbFTTtjh3/ZH1qVmu9cWY5q8ptX939168luOGT
         OT3JBtatp7bDarlA/1WVYSkWdOAkTA1mIVIa01NTXZNaH8sC1B74gLJyhQrKoSlcDAuf
         ymH/s5DduH8VImps7uCS0zd8RhjsYzlwa+96axx65mNLkr+QHADKvc7VQW2LwavYuzl1
         Pv8w==
X-Gm-Message-State: AOJu0YztJdUbHV7PyoWiR6+boOtZOrrqOZjK9ncdnSuagJJVAZXVByRU
	PIdkgOFxxlIiUtJco8M90cGeTK6cXT5bTNCkx8lGu872+WaTKmdvrPNdTOaD8PRG7hV65vEmzn+
	CVQg=
X-Gm-Gg: ASbGnctTMnk9KHuWVf/8lKs2VB2fXz1w99GzlzYwLQ8mjBW5iBCMXQgwbH6Rzu17+7D
	+y5erUxJ8kmUj0K11gIg/sZys2dDBfsRvTts+Uvw7yKsdEgmU3NsBNuZF3o1bTsLRmRlVIfw+TH
	/rV6bc1ngJgJeGTtGtnITZl/8ZD1rutEBsXsQkDe+dxIEJYcBi55gFWJsSvL2zo3caGrBu8fTV+
	1PjC0zhzH+oCauu8xUTr4i0bkj8YBWZPxt1N1hRwnccJDvKntyL0geOPznv+dtYo7VpD3AG1IcQ
	bxQi9pPSpUkOHEMf4Q8JViN2Xcq1Sb9wO5aenfKdPpdloMw=
X-Google-Smtp-Source: AGHT+IGgG3j37XPpBlw8fV8aejT9Y282Zg84Ylxu78/13gmSg1k/Grk33Ygxi04T6savqD/zyfoG5w==
X-Received: by 2002:a05:600c:478a:b0:43b:c7bb:84ee with SMTP id 5b1f17b1804b1-43bc7bb85bfmr53809865e9.2.1741102742506;
        Tue, 04 Mar 2025 07:39:02 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm238670625e9.26.2025.03.04.07.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:39:02 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 8/9] cgroup: Update file naming comment
Date: Tue,  4 Mar 2025 16:38:00 +0100
Message-ID: <20250304153801.597907-9-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304153801.597907-1-mkoutny@suse.com>
References: <20250304153801.597907-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This changed long time ago in commit 8d7e6fb0a1db9 ("cgroup: update
cgroup name handling").

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 include/linux/cgroup-defs.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 17960a1e858db..561a9022ec100 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -619,9 +619,8 @@ struct cgroup_root {
  */
 struct cftype {
 	/*
-	 * By convention, the name should begin with the name of the
-	 * subsystem, followed by a period.  Zero length string indicates
-	 * end of cftype array.
+	 * name of the subsystem is prepended in cgroup_file_name().
+	 * Zero length string indicates end of cftype array.
 	 */
 	char name[MAX_CFTYPE_NAME];
 	unsigned long private;
-- 
2.48.1


