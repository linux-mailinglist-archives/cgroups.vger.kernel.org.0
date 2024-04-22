Return-Path: <cgroups+bounces-2659-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0356A8ADAAB
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 02:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 769ABB24F08
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 00:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C73619066A;
	Mon, 22 Apr 2024 23:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kU6T7eDD"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B884318413C;
	Mon, 22 Apr 2024 23:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830299; cv=none; b=Zt5QaRhArj0xRK16PyQhbOisrYYc+ufQmRIp1OvYO95x4b8U6U1JIVz7bOqavCBd00D/Mi1v9zYKTDvELakR7oT22DNml18ojBGHnFywQOmL3MJxJ+FtSDDHErFtyHyR1UH/m9EqjlX/jV8dpyVJhkXphbKnYspP9OBNqldDXM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830299; c=relaxed/simple;
	bh=CVL6TEAyAqjPTfgfZ/4FDjwn41Lr4j97Qw71Mbg1Q/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFsZZV1nm6bU2eo1k/QyG6g3pvHAIhr3NsV+KGMLOh1FyJrHQvRJN78fq87rZHozuJVSNjLFQHWommXcXKowtd5xz+vuR+8jLIKTTgVGknvzkos7Si03/LuJLMUNdypOwUxbNm5jsXr5XuZI2u8DmwG+4hxWD3YtJGb1/xeT9rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kU6T7eDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E7FC3277B;
	Mon, 22 Apr 2024 23:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830299;
	bh=CVL6TEAyAqjPTfgfZ/4FDjwn41Lr4j97Qw71Mbg1Q/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kU6T7eDDXnOjiniX1ss89SXQ0KaRaTykvM9q5MyO7+chmDvhOWUMrimYb9KhcZDUs
	 kUw8vJCHbodk9H3qPhRbYTJnBnxwS10+va1UFb/Ro2SAMw+lt6N8aEi+h3mN8JCQpF
	 GMeytPCIdqIhHWjt2v1ibjVP9CptTdROl8yafE+fZEAEFmswG7EprelESXWyusoT2L
	 Kjp2Xw8Sox0HGjEvekyo63+JvAsvM/GVZQbioizmV8/Cr51fSR03H41C+crKhg5CeA
	 jMv36t2WV8eymcA4L0FTbv//P6YXvKqMmGL0OPJ2KwLCV/2ByXkL0zTj7hQN0P5uj7
	 0cRrC3T3ncFYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rik van Riel <riel@surriel.com>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 06/10] blk-iocost: avoid out of bounds shift
Date: Mon, 22 Apr 2024 19:19:19 -0400
Message-ID: <20240422231929.1611680-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231929.1611680-1-sashal@kernel.org>
References: <20240422231929.1611680-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.156
Content-Transfer-Encoding: 8bit

From: Rik van Riel <riel@surriel.com>

[ Upstream commit beaa51b36012fad5a4d3c18b88a617aea7a9b96d ]

UBSAN catches undefined behavior in blk-iocost, where sometimes
iocg->delay is shifted right by a number that is too large,
resulting in undefined behavior on some architectures.

[  186.556576] ------------[ cut here ]------------
UBSAN: shift-out-of-bounds in block/blk-iocost.c:1366:23
shift exponent 64 is too large for 64-bit type 'u64' (aka 'unsigned long long')
CPU: 16 PID: 0 Comm: swapper/16 Tainted: G S          E    N 6.9.0-0_fbk700_debug_rc2_kbuilder_0_gc85af715cac0 #1
Hardware name: Quanta Twin Lakes MP/Twin Lakes Passive MP, BIOS F09_3A23 12/08/2020
Call Trace:
 <IRQ>
 dump_stack_lvl+0x8f/0xe0
 __ubsan_handle_shift_out_of_bounds+0x22c/0x280
 iocg_kick_delay+0x30b/0x310
 ioc_timer_fn+0x2fb/0x1f80
 __run_timer_base+0x1b6/0x250
...

Avoid that undefined behavior by simply taking the
"delay = 0" branch if the shift is too large.

I am not sure what the symptoms of an undefined value
delay will be, but I suspect it could be more than a
little annoying to debug.

Signed-off-by: Rik van Riel <riel@surriel.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Jens Axboe <axboe@kernel.dk>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20240404123253.0f58010f@imladris.surriel.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-iocost.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 645a589edda82..bfdb7b0cf49de 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1336,7 +1336,7 @@ static bool iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now)
 {
 	struct ioc *ioc = iocg->ioc;
 	struct blkcg_gq *blkg = iocg_to_blkg(iocg);
-	u64 tdelta, delay, new_delay;
+	u64 tdelta, delay, new_delay, shift;
 	s64 vover, vover_pct;
 	u32 hwa;
 
@@ -1351,8 +1351,9 @@ static bool iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now)
 
 	/* calculate the current delay in effect - 1/2 every second */
 	tdelta = now->now - iocg->delay_at;
-	if (iocg->delay)
-		delay = iocg->delay >> div64_u64(tdelta, USEC_PER_SEC);
+	shift = div64_u64(tdelta, USEC_PER_SEC);
+	if (iocg->delay && shift < BITS_PER_LONG)
+		delay = iocg->delay >> shift;
 	else
 		delay = 0;
 
-- 
2.43.0


