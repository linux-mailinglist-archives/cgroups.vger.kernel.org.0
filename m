Return-Path: <cgroups+bounces-12783-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9848CE5075
	for <lists+cgroups@lfdr.de>; Sun, 28 Dec 2025 14:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55ADE30155CD
	for <lists+cgroups@lfdr.de>; Sun, 28 Dec 2025 13:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F6128689B;
	Sun, 28 Dec 2025 13:20:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1D11FCFEF;
	Sun, 28 Dec 2025 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=36.139.52.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766928039; cv=none; b=KqL+ZGRdqbj+t684tNEysf0NUR21cFr/6DNkW+O9z+U+4v3ZEw9AydU9yzB2YRUZYNSDE58usFEr47DXs4NER9K1BHETog//gSViyjk5lolG0RBfvQihggBwPgKXLnyyZP6gRFYWd5i3ZMMbQOZInSarvhjbN6BULnoT1cfau3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766928039; c=relaxed/simple;
	bh=rraAIeYWyeXjlLCJBeDVFKlc3kOVMML2rWF9cRFsSNQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=igkP5TKA92l81ofP7PTEMwWigXVEQIPnn1oODVXBK2bnkI2fWEdSuTatesgSn8aVGSGfqp+Op26dz6aQ+17iuGTfJngeVJ29wTw5RTTg7bVCtSy9lmtQBAYFnKzfvm2JW+yYw+FsfEncdTpeuQILbda8YJDFEMEOrQzUmAK9jaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com; spf=pass smtp.mailfrom=xfusion.com; arc=none smtp.client-ip=36.139.52.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxpheds03048.xfusion.com (unknown [10.32.143.30])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4dfKJz1cbtzBBx3m;
	Sun, 28 Dec 2025 21:02:59 +0800 (CST)
Received: from DESKTOP-Q8I2N5U.xfusion.com (10.82.130.100) by
 wuxpheds03048.xfusion.com (10.32.143.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20;
 Sun, 28 Dec 2025 21:04:38 +0800
From: shechenglong <shechenglong@xfusion.com>
To: <yukuai@fnnas.com>, <axboe@kernel.dk>
CC: <cgroups@vger.kernel.org>, <chenjialong@xfusion.com>,
	<josef@toxicpanda.com>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stone.xulei@xfusion.com>, <tj@kernel.org>,
	shechenglong <shechenglong@xfusion.com>
Subject: [PATCH v2 0/1] block,bfq: fix aux stat accumulation destination
Date: Sun, 28 Dec 2025 21:04:25 +0800
Message-ID: <20251228130426.1338-1-shechenglong@xfusion.com>
X-Mailer: git-send-email 2.37.1.windows.1
In-Reply-To: <71df89fb-1766-40d5-8dd5-5d0c6f49519e@fnnas.com>
References: <71df89fb-1766-40d5-8dd5-5d0c6f49519e@fnnas.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: wuxpheds03045.xfusion.com (10.32.131.99) To
 wuxpheds03048.xfusion.com (10.32.143.30)

> Please change the title and follow existing prefix:
> block, bfq: fix aux stat accumulation destination
> Otherwise, feel free to add:
> Reviewed-by: Yu Kuai <yukuai@fnnas.com>

Thanks to Yu Kuai for the review and helpful feedback.

shechenglong (1):
  block,bfq: fix aux stat accumulation destination

 block/bfq-cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


Best regards,

shechenglong
-- 
2.43.0


