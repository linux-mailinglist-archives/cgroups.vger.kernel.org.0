Return-Path: <cgroups+bounces-6964-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8C2A5C172
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 13:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBBDB1888828
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 12:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12502571A3;
	Tue, 11 Mar 2025 12:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BqeD8fBG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9990256C90
	for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696621; cv=none; b=Ya+gsJPqj13rTDuLKz+bCWzhbFHmXuYywVmxLNtKev2B+dfreH1H6WcsHsUOsdH78q5BBcFCCJLo771aUXmcLuYUzetHSggV+RjUwCnpsmZwbk0krlG5AAEnJh/emyqGlNvw0PEN63/4/uKiovAOfW1YVQp6tllbliCV+D5iclI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696621; c=relaxed/simple;
	bh=3fO27bZgRSLX+ZjJteSn+272IeY/0JUe6KT6vJpgZF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UjuPIVCZ0bsnSPirf9cchmyCU/TQAtMfNXRXTBzaSzG5owWkGWH/BnwhFMZLBKtWNFTJTM5Bzy7d/rhVDrj9z1yPdQO1+pGEexX/EyiUmxpEejK5pgeY2tKjZ54rDjwQvjc/oL3/xNXSUsZkVSo9JisbDW0IgTQNTOfaN1b3K8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BqeD8fBG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso17325725e9.3
        for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 05:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741696617; x=1742301417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeNwiCAXtv8YYTGNB6COQ1c83CjJXd/IUXH7xE+l9C0=;
        b=BqeD8fBGYb1N+2ZDPxv3fuEKAJAbnrhqj5BWeyODaWECtWw8uiaNIdYzfJuBv/J2LB
         qU4is8T0u/FhQAiwteu9Q67uW3iOwo0Qc1POzeV2mxzundKw27KMuqhmoNDnImApMWNM
         MPa74CnVj4s7EbLTdurkNzitpcQiagnrtviu5vB0LxkEpC5ejENwdmCDbuUw1rkPBgYO
         W69f6+tYWr2zAQkshkkRYqz0z7w4C1NiGiiYKcDOAD5VVo17bujgBoYpWgQORstw5sw9
         5siLzL5867/f25Qnr0CX7iM6NHV/dzXdrR7ENmNP2fy+mcgFDVxXDXoKOoxgYisGcksH
         kelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696617; x=1742301417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeNwiCAXtv8YYTGNB6COQ1c83CjJXd/IUXH7xE+l9C0=;
        b=pD8Zhjte80h8fCUUhsC8pg2lhkiFGuBMlMHxuI0enjTKvgeyG3NWdy2gmKY1qqrwR+
         3A5/YqeX7FTvpdUWIbagySvZi6s+RaJ0BFRXSlLcIfHHUrb6x20jSF5xG4k9cbWzzYTV
         0yeYHtJF2ysohx7QYCNsNY1Y+DVD/CJxtkr9kPIQJB+2YuwQRglSECp41hXwzMl4g+ds
         0LudQnTVxhp4FdQDYz/mxtbWiAh3tsoaAxKVF2n2DTeQ9L6rHTn/OOnKmzvu/VsgAIpQ
         74RbhUM6HSdKEzNsYitiQ5dUkY2vPuP9QAhVV4hq/cIEJ8SzslPw4ZNGweyjKEZvGtHL
         GcMg==
X-Gm-Message-State: AOJu0YzMyDUki/Ba8HRVzF9kcwPw6OTIM4A4S6/hf5jHy2+qTak5K10x
	LctgkJrWOWG6FvKKXgNzoVHqXO1wTSm94aOQ94lLVHNhZZh1nRa2oUSZReubcVuL8gS3fNe6q5M
	6pKE=
X-Gm-Gg: ASbGncsI7KbWD5Y8nA4GBHKDN3G8BttK8yv0yZn85GlXqAFxYKx2I9N6tJq5OPDZkRP
	dhlGmlf7ApAygfX4ChZIiV+zgfDCulGqXFwd8ATf6McG3KheSWOjJpZHpv8AgFOsryidlPh7LMy
	qI0MvqMjoMw799/z+GtlXAHw/IL6El8oQ0XEwOI1sVZOqFP2hhGN7qv4hkLMralixmTpGOIQe0o
	3VjskZrQNK29eE/qzQLb3HXqudL5NxeUdsrGGtQU83gy1FG18Li+rCjsrpp4xYq+/9fZ8T/9zmu
	WpaNA8QSZRByTljIW8DPnPGlgtfig4seE/8fWP/dbaUysKw=
X-Google-Smtp-Source: AGHT+IHn6PvkpQKJBbjtpTZtl/brCs+22CGDxaMUBRMoRp7lTvofXIIlLNevzeSErD/52v0LpfOABA==
X-Received: by 2002:a05:600c:4f8b:b0:43d:649:4e50 with SMTP id 5b1f17b1804b1-43d064952fbmr18361755e9.13.1741696617111;
        Tue, 11 Mar 2025 05:36:57 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d04004240sm9742265e9.3.2025.03.11.05.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:36:56 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 03/11] cgroup/blkio: Add deprecation messages to reset_stats
Date: Tue, 11 Mar 2025 13:36:20 +0100
Message-ID: <20250311123640.530377-4-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311123640.530377-1-mkoutny@suse.com>
References: <20250311123640.530377-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It is difficult to sync with stat updaters, stats are (should be)
monotonic so users can calculate differences from a reference.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 block/blk-cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 9ed93d91d754a..1464c968eeb0c 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -659,6 +659,7 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 	struct blkcg_gq *blkg;
 	int i;
 
+	pr_info_once("blkio.%s is deprecated\n", cftype->name);
 	mutex_lock(&blkcg_pol_mutex);
 	spin_lock_irq(&blkcg->lock);
 
-- 
2.48.1


