Return-Path: <cgroups+bounces-10408-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9B4B98260
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 05:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9322E50E8
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 03:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381FF22DF9E;
	Wed, 24 Sep 2025 03:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VwdQtWXj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C4B21C9F4
	for <cgroups@vger.kernel.org>; Wed, 24 Sep 2025 03:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758685268; cv=none; b=UDxxeHcmwGYepCzLaOVE2P7+XFPFZDWqq+j88CD6nG1XSqV3z6BwroFNjYERxmyj/PIMcrW+hicahnnM2uKOr9gHOim03Pr0nRGk7/wf7Fb+4b1UFQkeXbrdam+8pTm0HTdR0386VDmYpteBTz7si3elWInfKqmMI8+qQU+pSXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758685268; c=relaxed/simple;
	bh=T+3/qbPAgyyQ8AOtGCLhNLRG39cRJ4tgCa1PGnwEzHg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QzbwPRg/pUqBKDz/J5blzHXQSRCK/2is68aqPe1QD29SzbmLd2/4ravqXhS2xRElPUiSV0kTHKFV0eCcjCepG+TBQ/5jrdaRW5OS/5PzVV+Z5kOxt5js2jaa/I3FyxezD3MoCIYpUoXa8mXFup3xcZlPkDednItv/sdNQJ2tg3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VwdQtWXj; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77f207d0891so2985862b3a.1
        for <cgroups@vger.kernel.org>; Tue, 23 Sep 2025 20:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758685265; x=1759290065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ontus9bftLc1g9PbXi6snxrE04UjG3Wyk6lDgBoGb8s=;
        b=VwdQtWXjWulfa+6PBeZUm5sEDT3CuwJ/k9bMR1zrzftSXKuTkdVEqWwEj2Ch5fUBzx
         9FkqhmpZhNGFAj88R41xACmhhbcpyXOqXNqWwy3xi8XjWL2fAk9Itrs0IYiT+kSD3NDU
         di02NMsLR+0X2LtWARCagCMkJ/R+Zkgb4qSvzfqvM7o+KJe3XmUwQBw1ju18w3fHjM3v
         KUWupKr+Tt0/LxI8Zwffu2FPxMZSDztoHnQllsCgWgXXY7yU+l+FMI+cZc2O1Y3InSCf
         9WLdko8IFYkW1l5Vhwdoy92MCC81pNpVO6juNO/VB0eh9lM4OoQb0uOcinxnScvEuyhd
         Xrcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758685265; x=1759290065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ontus9bftLc1g9PbXi6snxrE04UjG3Wyk6lDgBoGb8s=;
        b=C9vDZzPeYJ0Ny0XbzGNRk3Sw5evvL+w1dtByvD8RUYSaTZgs/H0HeJeRaZ5bw4vNB0
         VHBTo9aVf7skn439guD/kFa7my/xTgit4GSULhlGVbypKbVc3WHGWEoPChvhfN/6t7yb
         3T7Ped9piDtfU0KrWkHDoQo7COnDrG1sQxY3KhFkgRydxsovP9MMX870c+Rg17rK4u1o
         +jU+PmlsHjy3qdxG4PXUvVgYFcs4J6qI74YmJrRIbFaIBLlTaJ7l32RVFS4BnUfjmURF
         Qh47jI1NJtkULxmOYGZY1Vh5egjHJtgLrGqTw5Y08e/3wA2qDKuLD7pChAPVRGhECBKe
         N6oA==
X-Gm-Message-State: AOJu0YzUYqwr+l6ZZTyJZEYb6ra3A1+I6hihrDvW3aXUyvyU8C7aJCmq
	c0T39JakBv1XqhUBSWK77UVHNdjefTAtP9ho3ScUsNBTlBwwi2IHVLRuM74/GBWYZZdtEFcuyOB
	5MXDb0zKt7A==
X-Gm-Gg: ASbGncvaGv6LzrZiV+UaqPgfMVzGKQoctSl6168sq1jHILjhkcFyYSn8FoyVEFMVrFh
	g1HfKT/zTpX43WnmxlmhRlBWrRVgIDV03dB0k3Iq13VgST/KiECQZ7u7vWNn2FGGvyqyd2qBTcP
	DXAEZZM43+s083u/WhnyeaFoF7SD7Wry7wegDrdU8qxr/pNakXdALhYcir63rWwqAD5Q+SjUM6R
	Q19J0i2+KZ4zICBGgR9lsIEmnSbCQNhW9xQwnc0MaLQVfay/T7UFA9dTg1juTQziUZ8ZQIeaG0B
	L2gL4gNSCPCCCemQKbiq58GqCzH9pdK3A1GBe4Yr1oI+hqw8cOD78QPtT+b//IJyP+gZV6qvoMJ
	HWFUKzNaWf8FxVbYDaKG30UDGBbmp1Ok=
X-Google-Smtp-Source: AGHT+IEDi98HKizARK5fICFnpQr1MYhiHxYWBHLNjcl4h9I6r6dFEDUkUC4ICOYn3zaIm6DYoLTYjA==
X-Received: by 2002:a05:6a20:a110:b0:244:3a85:cd7c with SMTP id adf61e73a8af0-2cfd4836bc6mr7199434637.10.1758685264845;
        Tue, 23 Sep 2025 20:41:04 -0700 (PDT)
Received: from localhost ([106.38.226.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f2f02c15bsm8550793b3a.95.2025.09.23.20.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 20:41:04 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	lance.yang@linux.dev,
	mhiramat@kernel.org,
	yangyicong@hisilicon.com,
	will@kernel.org,
	dianders@chromium.org,
	mingo@kernel.org,
	lihuafei1@huawei.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	tj@kernel.org,
	peterz@infradead.org
Subject: [PATCH v2 0/2] Suppress undesirable hung task warnings.
Date: Wed, 24 Sep 2025 11:40:58 +0800
Message-Id: <20250924034100.3701520-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As suggested by Andrew Morton in [1], we need a general mechanism 
that allows the hung task detector to ignore unnecessary hung 
tasks. This patch set implements this functionality and enables it
in memcg.

Patch 1 introduces touch_hung_task_detector(), which allows a task to 
mark itself and then hung task detector will ignore warnings for it.

Patch 2 uses touch_hung_task_detector() in the final phase of memcg 
teardown to eliminate the hung task warning.

[1]: https://lore.kernel.org/all/20250917152155.5a8ddb3e4ff813289ea0b4c9@linux-foundation.org/

Julian Sun (2):
  hung_task: Introduce touch_hung_task_dector().
  memcg: Don't trigger hung task warnings when memcg is releasing
    resources.

 include/linux/nmi.h |  2 ++
 kernel/hung_task.c  | 13 +++++++++++++
 mm/memcontrol.c     |  5 ++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.39.5


