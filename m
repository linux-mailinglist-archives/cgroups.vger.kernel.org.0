Return-Path: <cgroups+bounces-11977-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D649DC5FA29
	for <lists+cgroups@lfdr.de>; Sat, 15 Nov 2025 00:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8376A35C256
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 23:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4071F30E85C;
	Fri, 14 Nov 2025 23:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XG9IpBMU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788CB306D58
	for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 23:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763164491; cv=none; b=K3e2vcpcmlLkLsRXl/cHv2R3mG+7OMRlnHoZ5k8RCAqVzHVx0fJ05FjrKqrCE8AUve4a+bR5KEBYlqNFeEM6qNZOvCG7lCxOFNLhioC2J2xsXjV8Iy+lTCS80WvB0G4cw0hio+FQdZ07x4A8pYGHQfFNNm0rmOF7+ZTOFNSHrPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763164491; c=relaxed/simple;
	bh=8b2K75exTopC25Duwa3XNxKklUYHIMlCaizUVN8+ses=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OaaFlrIYKhQ6rGAenvHkuAA8gkTaY4p9wntmMvZaeStGmR9PYnOV7PwkKn3EjatRVO9lC5W8gfMkINDZcI4MT5wOoJb+RsCcdGchokENkn3ENQzKosQSexgW+2lQAvJSLMvjlYKCxrq1dd3NA13fAOWyvj0EmQeiHVNKQ204c98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XG9IpBMU; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-bc0e89640b9so1742093a12.1
        for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 15:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763164488; x=1763769288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hgM/nvnBybHbCEHd2i0eoRGXYVypUnH143ZWqlNySO0=;
        b=XG9IpBMUV0srPz359pUU2bxfv81KKJ8BdUnkYM7bRM4lugMjRLsirrAptlLdjT+PMK
         mgRooc0l4Bbo2x20R2MKMzNoFkzNSq9WV54gyzt2Zshr39vm+gmcQN2zUfYLR/Ai8rtT
         bixudUWnqwbF8uU5jOwbdqIt1M4nSQGf4EDGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763164488; x=1763769288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgM/nvnBybHbCEHd2i0eoRGXYVypUnH143ZWqlNySO0=;
        b=Zxwb70tJvMtjW9XcFGHJtfVMF1UAhjEMvdfkGCJq4SOi9kdw55ynSJ39mQBsYXY36C
         xlne3NgE3oeoKuYkBBJl2JV6qzeEqa6sa7sfjnvFNOdPX3jgdstu5zQfI0DF/s6Sa4BK
         qIdYgA3Vs0hElEyR8AzsilLEUEzq2zUCx9I0/GA6Rt0MEc1odNqVqxFGM/iZptrrXESY
         oqLylxQE01t2NMqFoxx45FyfzDIALPTUZOnlbpENhniDOhQHkgrHn5LFGYCh9wFUIXCf
         1vcL5zhWX+YDYxKrm/AnxzHl6ORO70k/cxlzoHEGuAkxJ62btcIzyOHEsgLY5i+FbZol
         CkkQ==
X-Gm-Message-State: AOJu0Yz6DHRLxvT70R94C1Vae8OYwzoW1jqUmkGpeowHfPn8zTm4Ambz
	06TbAFuszmB1Nl6LFvwCCEmgL1uInSJIv4Lp8vX1JOFGL1CG3KPXPn8j6EyhEd91Qg==
X-Gm-Gg: ASbGncuT7CNs1sD2/eqqISxMrjBZ+jRZ8okKTOfBm9h+x3RlY9/8SvQ/o97aKY/PrhC
	6xq6gi4WCg+dOPllKZZXWfmWpen8clwmgIFkQbR3v9tUgE2LNcTdwywM3Huupqqd8X7smxZCNLD
	u1xRZlteZqQm3B8KNmQzPBNsYKmz+UOI+I2E5a+BVhUpHkJ+xh6b8OQ38c35yOG2SCfyE1KDs8T
	HRGpQK8qpBHjlAY3YbIo1rETfSOdERLQP7/fnxG8OqQFI35g11OLUKb56aHdo1yvo4iC0+Y4TcX
	N2Zyu+rpvSLFaf3ZQz0UaVTJFhGsHA7DwSCXrzlP4hs3UIdqb3Ii1em5msxhgEXLqx2mA3Jwvml
	uWmyZN16CgNRSbdFphWusTzOEeRqFwTaP9Yat70FFOLkcJzwe2U4yI2Vo8Bj6FzqghigHOfzqWq
	PZuhCYS1jjHF1GpO8eGcg3v3GrEdqzr0g/MT4FY4ffNjgekzRsHJJ3xB8e6tYzgy4A8d4qRTE=
X-Google-Smtp-Source: AGHT+IG3JcoLJMtRbmF6VRDQOY9UH+gOZKPuPSg70/zIMIlY7t2a6Vyb+8LbWG8aqa1hQUqyH5V/Ag==
X-Received: by 2002:a05:7301:d194:b0:2a4:617a:418a with SMTP id 5a478bee46e88-2a4abaa252cmr1665974eec.13.1763164487804;
        Fri, 14 Nov 2025 15:54:47 -0800 (PST)
Received: from khazhy-linux.svl.corp.google.com ([2a00:79e0:2e5b:9:bb76:6725:868a:78e5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49db7a753sm14114818eec.6.2025.11.14.15.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 15:54:47 -0800 (PST)
From: Khazhismel Kumykov <khazhy@chromium.org>
X-Google-Original-From: Khazhismel Kumykov <khazhy@google.com>
To: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khazhismel Kumykov <khazhy@google.com>
Subject: [PATCH v2 0/3] block/blk-throttle: Fix throttle slice time for SSDs
Date: Fri, 14 Nov 2025 15:54:31 -0800
Message-ID: <20251114235434.2168072-1-khazhy@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit bf20ab538c81 ("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW"),
the throttle slice time differs between SSD and non-SSD devices. This
causes test failures with slow throttle speeds on SSD devices.

The first patch in the series fixes the problem by restoring the throttle
slice time to a fixed value, matching behavior seen prior to above
mentioned revert. The remaining patches clean up unneeeded code after removing
CONFIG_BLK_DEV_THROTTLING_LOW.

Guenter Roeck (3):
  block/blk-throttle: Fix throttle slice time for SSDs
  block/blk-throttle: drop unneeded blk_stat_enable_accounting
  block/blk-throttle: Remove throtl_slice from struct throtl_data

 block/blk-throttle.c | 45 ++++++++++++++------------------------------
 1 file changed, 14 insertions(+), 31 deletions(-)

-- 

v2: block accounting fix into separate patch

2.52.0.rc1.455.g30608eb744-goog


