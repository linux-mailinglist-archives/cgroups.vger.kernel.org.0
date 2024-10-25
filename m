Return-Path: <cgroups+bounces-5242-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B90B39AF62B
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 02:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0511C2165B
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 00:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0BB6FC5;
	Fri, 25 Oct 2024 00:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dtegkbvl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7C122B669
	for <cgroups@vger.kernel.org>; Fri, 25 Oct 2024 00:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729815967; cv=none; b=UZOTixFu7ITcF3eW1KXCPhq6qbjs+rNwJ9SyEPlgFD7LKbrzOwGTlZVMNIlwrtgkYvjyxXI2YMW5w7U1xwjIo9s575WgZSSg06gv4cEeOcPCFmF49L5jtadUR+n4sCqQi3IKnkbzwPpp5aBIL30/pxnVWmFYXAmqzWLH9mYWaWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729815967; c=relaxed/simple;
	bh=r8OhxRKJ6BzPgXdG6Y12PAAtY2CRGg+YHwmQgdrQz18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X2Jf2YupIjuWZxcjFkA1lsZpjTNG7Oj4GM0Qw71jlNqmi0CftyaGglaX7EOd61vg3QTx6jn50oQQy0h3MO7o1FQ2AufUDZdpOigaqy+MCyr7qjtiIdyFzeRZtDFIx2QY+Dk15kCbQWcqHHMkGqpEcG7oZGbGv/NO/pMq2zax5nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dtegkbvl; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e681bc315so1034103b3a.0
        for <cgroups@vger.kernel.org>; Thu, 24 Oct 2024 17:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729815964; x=1730420764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3PJgz9Jmj/D7t9EGN9OuBjc1HkWfB/KHbUE7yCQWc4s=;
        b=DtegkbvlEh1981HlVDRQgyNKXplSR/rKZdkiK6dAhk0FX7j3RIHVZcpsAqD1pE3s55
         AN85k9X9c1Uj9/uyvKVXiZut8R6dajksJveOzvbL5RpCgkELaOcemcqgBMNlgCp7/h6e
         Ju66AtyHeRMZDlgxOCDBAqJIRu4LFJq/Bm6rTuFXpWYHvmI22P8NXnZ1z8Zh/DhTlwZJ
         Lentgw/5v0a4mexlLzf/DbEN+yQQVopahekVM3ds1ltwp+O8bbqZ80ximGju2J4m3O1P
         Zr9NiX87U7C3/WMP06X72cunRdMj+BjHhBlZvQJGxgec6r1GgNP4Kgb5+LAzDMYNPz+1
         TpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729815964; x=1730420764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3PJgz9Jmj/D7t9EGN9OuBjc1HkWfB/KHbUE7yCQWc4s=;
        b=Frad+dufPs2ICDcAkXp+TqPxF3QntSdtDCE6zjq0fZWGtgD+yUtcqkHpvuNsLT1yN5
         ZQHb/HCsFFrhop18Clq/2m3XJBeQwwFSs/Uj6qaUEAIM3NumXLmO/9pYcZhBhyzRuFaT
         UzbWKmvMknmtTtHHsINU1Puyiy8LbJzSLiU0jnxEFvbJuDEM2V/pblt8/3EpZEEUIEpt
         amWVnw3kXiqRFPo2unkjTDMHZ+u1rlVEC5HG2nPe828Ws4FLk2LdhxQ483vv4QqxvASp
         uYU52ZRjENlTHaMpDWa+74mMgXeF24l43mDWOf9uw+WepipF+Kjv+8VP5cH+yCTgxHRz
         Q12w==
X-Forwarded-Encrypted: i=1; AJvYcCVgj+Iz5aVHaVdcs6dh4IHwKlXrHlmh795cUloQeN1qYv3NMgmd6hey+3Npa7oyY+bpDJaOv8w3@vger.kernel.org
X-Gm-Message-State: AOJu0YwmjwQ1ysFmjnAELOQeS31uZtS0CcmW7VfZimFMjO4TRi9PsyH+
	zgno92f7AhoeBEDwVpi0mdFamSKyYFUlcVeSlVUStoOIScYG5F4m
X-Google-Smtp-Source: AGHT+IHut0Io/j7owEZ53fDog2k2XL9946DasnUkHS4TNS7nxJl69tKH2Wbylp/q+23jSWkLxNqSQg==
X-Received: by 2002:a05:6a00:1888:b0:71e:6f09:c0a8 with SMTP id d2e1a72fcca58-72045436b6cmr7175651b3a.10.1729815964311;
        Thu, 24 Oct 2024 17:26:04 -0700 (PDT)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0b707sm21572b3a.128.2024.10.24.17.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 17:26:03 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org,
	rostedt@goodmis.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: [PATCH 0/2] memcg: tracepoint for flushing stats
Date: Thu, 24 Oct 2024 17:25:09 -0700
Message-ID: <20241025002511.129899-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This tracepoint gives visibility on how often the flushing of memcg stats
occurs, along with the reason for the flush. It can help with understanding
how readers are affected by having to perform the flush; the event captures
the info on whether the flush was skipped or not. The information collected
could help in determining the effectiveness of the background work where
the flush is scheduled periodically. Paired with the recently added
tracepoints for tracing rstat updates, it can also help show correlation
where stats exceed thresholds frequently.

Note there is one reason called "zswap" that was included to distinguish
one special case where a zswap function makes a direct call to
do_flush_stats().

JP Kobryn (2):
  add memcg flush tracepoint event
  use memcg flush tracepoint

 include/trace/events/memcg.h | 56 ++++++++++++++++++++++++++++++++++++
 mm/memcontrol.c              |  7 ++++-
 2 files changed, 62 insertions(+), 1 deletion(-)

-- 
2.47.0


