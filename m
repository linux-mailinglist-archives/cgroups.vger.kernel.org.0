Return-Path: <cgroups+bounces-2981-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 100698CC577
	for <lists+cgroups@lfdr.de>; Wed, 22 May 2024 19:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77E61F23E76
	for <lists+cgroups@lfdr.de>; Wed, 22 May 2024 17:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F611420B9;
	Wed, 22 May 2024 17:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="n56wN4hb"
X-Original-To: cgroups@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6505C2B9C3;
	Wed, 22 May 2024 17:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716398723; cv=none; b=TJ3sib4Ignt2pwekTgIKLnhMlk6VRKC0+Fxlh6ASwx3C5siF+SjQAX1f5UaHc/Oeq+QPhU74KnrO6mQZCgVKD8gX++4JDzyxAh5OWbQ0L9u5ZGYqHBCK6J46Nwt5Ox+rp55uC38zS57T5u94gDB4sCHP8afI8SsT4ZqmfbZaG4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716398723; c=relaxed/simple;
	bh=QnU6TLnYhrKP0IhVowNIjwPrz/U8ertoOdukGfKUadw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uIHOSlPuxU1HOzV25kTB2W942HQ2STeEi2t04Ca8/rUjYWaP2d6Vu47Vs2Z9f3oH1Iw/TcveWs3kdVOylLdbLUL60Nx0rdK2tszRz3AIrs/L4rKzd6iSfdib1Bbr08nSpOzugTiD2xduL95GQfkDzFm50WF8D9UM6JTVmTforo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=n56wN4hb; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=V5gX0iaMm0XLDVaVLLJuDodgb7XRDFc8VwDQ9Wvel1Q=; b=n56wN4hbZpnW7D2u
	TH9ZMYWx5fvF+SHZAV3WEgtpYmRolbhSDhtMmRT1MEnGjnmKEGlGx936t8FTpM0PqFhWK7R0OMke5
	cYsQceOI91L+Z9CFQKXWTcA7xC4hxtYjNONCflFKQtwGwJ07t0BLiyPVhPUoP+Lw+8rh41JLzQn6I
	a6ZMWBXQe70l+akHdh2Fk27xQmHj0z6INJ9mfa4gf6bje35IUwCBN7zjDH92A/YE521McaCYbkxMX
	lC3279B3di7BBQFb6BDc2UEYwLDdfzAUVS0AwF0QNvXAXfuOepaOj1sWTIBBHja+Qzgd+ve0U6sjW
	zWBR3aGVj05yDVsBGA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s9pi0-0025JX-1Q;
	Wed, 22 May 2024 17:25:00 +0000
From: linux@treblig.org
To: tj@kernel.org,
	axboe@kernel.dk,
	yukuai3@huawei.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] blk-throttle: remove unused struct 'avg_latency_bucket'
Date: Wed, 22 May 2024 18:24:58 +0100
Message-ID: <20240522172458.334173-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'avg_latency_bucket' is unused since
commit bf20ab538c81 ("blk-throttle: remove
CONFIG_BLK_DEV_THROTTLING_LOW")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 block/blk-throttle.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 80aaca18bfb0..0be180f9a789 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -39,11 +39,6 @@ struct latency_bucket {
 	int samples;
 };
 
-struct avg_latency_bucket {
-	unsigned long latency; /* ns / 1024 */
-	bool valid;
-};
-
 struct throtl_data
 {
 	/* service tree for active throtl groups */
-- 
2.45.1


