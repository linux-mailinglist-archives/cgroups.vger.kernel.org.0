Return-Path: <cgroups+bounces-5302-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D65C9B4035
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2024 03:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90409B213E9
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2024 02:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183601917E7;
	Tue, 29 Oct 2024 02:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9tqjuoR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C27D18E75A
	for <cgroups@vger.kernel.org>; Tue, 29 Oct 2024 02:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730167876; cv=none; b=akmqWcOotoNP6u5KYbTgp4onR57AxzjgyhjgyfErIq58Ph+zNRQLGt6dbJlI/ukTGD/VuMHpDoKAVK+DKPQ8qD0ZRwvoMcmeSjm2rESquA6jMtXY+ZdLJRe2gpKCpuMPNsOaeffo/YjCNqcznRgVHkuCaQ4FfeyXUyPzS7lEkdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730167876; c=relaxed/simple;
	bh=iidPeOqFlsf0Zv3BUDRFeUgjJIRwB4X6ZXA+mG0aEsw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KMv2u4+OkaHs9Io/s9KFA1HGItbPhoUVWBKcpe8M/m9a/Nk78DSe+TF3vaV0fkwXedT5gFtbCci1tyaCn2G3Ar7+49HyqC5/izdwrb14fow3R9N/UhznIUQ0dKfNTSI/s9CyXHSHIlD9pvZumBZbgtS7Dkv897SNBgs5gSKgrGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9tqjuoR; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso4013308b3a.2
        for <cgroups@vger.kernel.org>; Mon, 28 Oct 2024 19:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730167874; x=1730772674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Heu1Loo347AjsVkt9yoc/YdnKyEyMw+abyd+XAoD0YQ=;
        b=D9tqjuoR/DdgeFTS5jU4+tOSO8B91uicmYf8D5Z6MXtG3iTtSue25f5F88aMKRSKvY
         HxSxB2kdjUec4hGgSiOd6LqhNRnq69yuvbR7pJv9QYWh9eeVEuE7EUqjyNJLMvYHFUiM
         Dj8D3ZEg0+VjgU1+CHCjJsjqODcqzV7IlXOy1iUTlZhqR2fXIGv8rBO8d4X6TZ8ZrHYD
         fNoGTs5zDrl1YydxOTBzPMHWrv2sfkkeyv3mQv9d1lFh0XhGxTMO0/B4LCzEy1/esBgY
         W0Hu99QvkeCkpkPJ4rMyJ5EyXVSbhVMqNqaOkSkOkpydZsE6eMpxp91z0+zTxkxJbKYl
         dJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730167874; x=1730772674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Heu1Loo347AjsVkt9yoc/YdnKyEyMw+abyd+XAoD0YQ=;
        b=kDrbZE+go2bD9U3OCQAGoigs/rH8qsFsRi9r0/9/r4B3t88rBuELfXCjG8ljT/MLpR
         FDtB8Vt7905nC6k/8BsH+umWq6oSt5I7l9z3u3Xqvclp3YFwvFi6753ye3Vbbh9t4JbF
         dpxtDzDJeVkfXlwtIvlLk7RXXzje7gN8hv/vrCyzHn6Kgdo64rU08KO1mQbrUcInl8qc
         sYz04TESCbE356ngwW4rPRLDaNwYzDuZDkzA1LXr41IZzOhbdom/RshK8Nc2QQifyFzq
         whNoWy9TvPmygs8Y0QDAhuqY6WXtu6sgCDquL3aGQUw1voIdgRccvsGSfpks2HVef9nx
         dTfw==
X-Forwarded-Encrypted: i=1; AJvYcCUParKMoFhi1+hSwKz/MAFpmLYAX5I+Q884tsHKnluy77Q9jjA8YCX1tyX2c9TYZbVxBKNP5As5@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9KwdyeVRw4ci/G55lyww9lKeO5bHUrpyjr4SQEgTY1pT5Qa2x
	cb9lMFvTzcrkouzp7zw9aexEdogsZVSqbXYNIwkkfeoGry6ZoPr/N+1fBSvP
X-Google-Smtp-Source: AGHT+IGFUAizA4mgjJZscdQ+ovhzJKMyTFhhbQF5SFsjSEZ07tTYj8CCbgXU9YFfG7HUwORU9Msu7w==
X-Received: by 2002:a05:6a21:e88:b0:1d8:d3d1:cbed with SMTP id adf61e73a8af0-1d9a83a9b44mr13412420637.1.1730167874393;
        Mon, 28 Oct 2024 19:11:14 -0700 (PDT)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0df99sm6500884b3a.118.2024.10.28.19.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 19:11:13 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org,
	rostedt@goodmis.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: [PATCH 0/2 v3] memcg: tracepoint for flushing stats
Date: Mon, 28 Oct 2024 19:11:04 -0700
Message-ID: <20241029021106.25587-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds new capability for understanding frequency and circumstances
behind flushing memcg stats.

Changelog v2:
- remove tracepoint enum and call sites where enum was used
- rename do_flush_stats() and include forced flag
- add forced and needs_flush flags, stats_updated to tracepoint event

Changelog v3:
- split renaming and flag into separate patch
- re-order patches so that the tracepoint comes after the preliminary code
  changes

JP Kobryn (2):
  rename do_flush_stats and add force flag
  add flush tracepoint

 include/trace/events/memcg.h | 25 +++++++++++++++++++++++++
 mm/memcontrol.c              | 22 +++++++++++++---------
 2 files changed, 38 insertions(+), 9 deletions(-)

-- 
2.47.0


