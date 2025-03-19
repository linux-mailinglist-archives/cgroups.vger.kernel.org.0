Return-Path: <cgroups+bounces-7141-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F918A68535
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 07:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99475424355
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 06:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D2424EAAA;
	Wed, 19 Mar 2025 06:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPLlBOVF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC503211A37;
	Wed, 19 Mar 2025 06:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742366532; cv=none; b=RqA+DWl/2abm1pY+fwDlRbUkbAWFUWRbRuWQOJpcx3ETGVv8DY9LyPIDpBbBl7YQjSBYl/DaW6kVVikBw6HrOxVzzwfPXjpULkwc/VOnbeLLzMs+Okgl8zoCwUowAUnLjiEr/tBcR52HlGCrlXdK6C/y7w5q3g3M06Y/aP4C9jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742366532; c=relaxed/simple;
	bh=WZangOACrcJ/OOGr/Q/oIbs+sGoGm1xxddImOY5r+jM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R6o/82UMxg7yQJgSIMBdnaw6KFgvylfa8LB/YT+Zg4PPvXtxjC8ufhi5dodYRIooEZhVM3Y/KKMky+anQi+YsjbLFfxyfJvbvioaAuTEJJ6HsUN3BvdF/DSHposyjiyg/KO1H9XDX9qNzp/k2aCq4+1oDc3/W6FHdkdlp9+6q3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPLlBOVF; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2243803b776so13118435ad.0;
        Tue, 18 Mar 2025 23:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742366530; x=1742971330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LHND0BFDJrs+LhTa/QjvhqDJDaewhVkAVpjoUp3x2hQ=;
        b=aPLlBOVFG1zkZ9ksMnX9cb494iVCMqZMzQ/zXtzo/kZZAf016PhVkGZpriwH5pNmQc
         Op71lZOO+Yg3yRRgSMyLLB1yUQBiFnsIvjtY7s52TwpbA5B8PDCiHHu+KJOBSIAPsb+n
         IzqNpl46jpQvbWu4DwjwkDSSB5/tRULx/RkKgRgB1gA+gG75WAviKzyfcv2dGWOJJ5Dn
         NVg7XYwITrSIH6KgBOjCk3PELdzlDdnCsoUVuO849VoHJTaJwQ0l7r2GUS8fYzFuThPU
         RxeCdWQdvzNBgrO8yhW/zGskkgR9YDk9/RbWCCI4HxBZKsYVmQzBwhnQgDFD03eXMwoG
         Wyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742366530; x=1742971330;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHND0BFDJrs+LhTa/QjvhqDJDaewhVkAVpjoUp3x2hQ=;
        b=ly7SxgcVlMKLqXvuYfBg0faQ+SbgQynxAInpk1tXANLuZHb0K3ZCWoXxjAt+T9SQJ+
         njIBOc1h0WyGIlJtCxrprJldv85uXJFxUnWzxbQ7YQNlYa3NuQktaNll/9gxrZTJCdlo
         hCKqzlyybDtrKgztd8ATJ69raboFcBz6dl3vnSyq6rdtpMuE2yXpNwAlKO4uuCcLIxUK
         eZfJijfV2ncV4IL85qdT6cV4E+lvQ7NEJvjkhg98d5U/01zAp4pu1xD+keYswvGnI1MD
         a7U2aYOIYfYwYBTt+cDdr8w2Pc0eLW/tiARQO4DvQF2FaB2zlbvYewASl7v8AjwL+iQX
         bscg==
X-Forwarded-Encrypted: i=1; AJvYcCX9D6j000b5YXTz2FeoVrWu1w2ZBsszD1nwTJu8J4GQIry2p+OU6i+aakYA7s50x4Zm0IaoLZxERYoTO13o@vger.kernel.org, AJvYcCXzAnG9r7YCE9B05+esZw4axXi1Qp956sKhhGCG4W1ji7WBsXVk5gaW6XT5mYUkepo5sM4m1nz6@vger.kernel.org
X-Gm-Message-State: AOJu0YyzEQPVoZu97FJFyhKBoQ0yRtaeotM6xQHNouzEAeMuGiGwCm2T
	AJ48V3qXzuF0ROjxcI9MDT6PiCgHjpp7yHncLZp1OBNAivdk5NLM
X-Gm-Gg: ASbGncsG/Z0O0D3CJ3ae1DnOebqBYh4KJhLhG/H9gGwoEqNlOQR9bzs9otxGq7uvZe1
	+Xs0wF+0PG8Gji0XAtZFJOm3q3sS13BFH6HOpDf2TYe7je/iDHwLiMCVXCi9gqR3YcPT236kmz6
	YRL0GBuQ0F6cOdZC+ndUACbiKz4kMd5GE5avrGCCexq1BtxquIi2v5RJX1OXUadfyAyM7fEpw33
	f05Jj3WTBjkGUTugHw2qmdotJzAaUivBhORN3NKzPJdZxVaAGBbvrwMBsaRFpYaufddiU4SC70O
	Fwlm02LVzRHphM2cUv+bAOVrsRU1hZuE9Q1EK/yUkExLj0BOu4v1CVhY41KFkJGlB0EM7ji7u2y
	h7M0MJofkvJkClg==
X-Google-Smtp-Source: AGHT+IFktIe+A5IhTeUDyIJit0JKK1UZdcIDVORGTdzTwsLhLw/GycGscvhNGbqoJ16QaVO1cH0eNA==
X-Received: by 2002:a17:903:41d0:b0:224:24d3:6103 with SMTP id d9443c01a7336-22649a80c3fmr27939045ad.35.1742366529832;
        Tue, 18 Mar 2025 23:42:09 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm106191835ad.70.2025.03.18.23.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 23:42:09 -0700 (PDT)
From: Jingxiang Zeng <jingxiangzeng.cas@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	kasong@tencent.com,
	Zeng Jingxiang <linuszeng@tencent.com>
Subject: [RFC 0/5] add option to restore swap account to cgroupv1 mode
Date: Wed, 19 Mar 2025 14:41:43 +0800
Message-ID: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
X-Mailer: git-send-email 2.41.1
Reply-To: Jingxiang Zeng <linuszeng@tencent.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zeng Jingxiang <linuszeng@tencent.com>

memsw account is a very useful knob for container memory
overcommitting: It's a great abstraction of the "expected total
memory usage" of a container, so containers can't allocate too
much memory using SWAP, but still be able to SWAP out.

For a simple example, with memsw.limit == memory.limit, containers
can't exceed their original memory limit, even with SWAP enabled, they
get OOM killed as how they used to, but the host is now able to
offload cold pages.

Similar ability seems absent with V2: With memory.swap.max == 0, the
host can't use SWAP to reclaim container memory at all. But with a
value larger than that, containers are able to overuse memory, causing
delayed OOM kill, thrashing, CPU/Memory usage ratio could be heavily
out of balance, especially with compress SWAP backends.

This patch set adds two interfaces to control the behavior of the
memory.swap.max/current in cgroupv2:

CONFIG_MEMSW_ACCOUNT_ON_DFL
cgroup.memsw_account_on_dfl={0, 1}

When one of the interfaces is enabled: memory.swap.current and
memory.swap.max represents the usage/limit of swap.
When neither is enabled (default behavior),memory.swap.current and
memory.swap.max represents the usage/limit of memory+swap.

As discussed in [1], this patch set can change the semantics of
of memory.swap.max/current to the v1-like behavior.

Link:
https://lore.kernel.org/all/Zk-fQtFrj-2YDJOo@P9FQF9L96D.corp.robot.car/ [1]

linuszeng (5):
  Kconfig: add SWAP_CHARGE_V1_MODE config
  memcontrol: add boot option to enable memsw account on dfl
  mm/memcontrol: do not scan anon pages if memsw limit is hit
  mm/memcontrol: allow memsw account in cgroup v2
  Docs/cgroup-v2: add cgroup.memsw_account_on_dfl Documentation

 Documentation/admin-guide/cgroup-v2.rst       | 21 +++++--
 .../admin-guide/kernel-parameters.txt         |  7 +++
 include/linux/memcontrol.h                    |  8 +++
 init/Kconfig                                  | 16 ++++++
 mm/memcontrol-v1.c                            |  2 +-
 mm/memcontrol-v1.h                            |  4 +-
 mm/memcontrol.c                               | 55 ++++++++++++++-----
 7 files changed, 93 insertions(+), 20 deletions(-)

-- 
2.41.1


