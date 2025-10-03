Return-Path: <cgroups+bounces-10540-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A722FBB81CF
	for <lists+cgroups@lfdr.de>; Fri, 03 Oct 2025 22:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BB544E38BD
	for <lists+cgroups@lfdr.de>; Fri,  3 Oct 2025 20:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41F623A989;
	Fri,  3 Oct 2025 20:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqJ/d9ql"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D9F156F20;
	Fri,  3 Oct 2025 20:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759523934; cv=none; b=BWLdzoG7ghmRV8Rzucqf7yh8vER755pdEcCBjfkyuMSlN5tjRuK8z/5zxZ+DcB1j59m5BX1bZXAzKA/WDDYiFClhyAzZ0dHkmOTANWTRGhTx0cMJU8gE8WAwrhIFex9FT6ZN5aEkdonAE55UDPUISdVmT5fC08vunbvOyqt+EKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759523934; c=relaxed/simple;
	bh=8Kylk+IGScGVl68XY62G0IZ7hqRC6OFEitrMjSrCFis=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AKec1Uf0YIpSb2z2YeQcDWrGiulzUFeVB715BYcUrLvD/XhbOaelzNCGdSJOlp4k/OlsXKkwZ5s6FU6zMCkuYnKDGaVJTdlQUD11DYBLrJYFnlsqrigr+YagJblArkQh/TFuc8Fm7BUmNzfMoRGXDh/t+IuvWAh/Zio4x/tE5k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqJ/d9ql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB82C4CEF5;
	Fri,  3 Oct 2025 20:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759523934;
	bh=8Kylk+IGScGVl68XY62G0IZ7hqRC6OFEitrMjSrCFis=;
	h=From:To:Cc:Subject:Date:From;
	b=ZqJ/d9qlMsYouwfCYmYg3wszEYzw8EOZv8jG1Utxyek0uCcIgTzGt3A1ekVkuEV8/
	 OAnoFpAtFI/a0+DKGJnUnGH2EVvrQmNv0iZWMmmegz05Sv22XotbcOk2/ld5Qz+TYl
	 QDyKE+VWzCBMQ9JLUR6n1p93F6JWzuoGqeAUAUYwCAJEvTEJK3vx3blOcW7T1R5nFM
	 1EjxKBGNH6HB31vrPWvaasZXlGgl2spFk+6bJlEqw33NCIvhmgZPrx3NulvezhqlLN
	 aTPcz2gBpZCSHccRx6QiVpr0upiomnXZ7yOad9xBR9a5ZTpXk5G2RY0wyV+OEkxl9v
	 0SY1aFcD4xiAQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	cgroups@vger.kernel.org,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/4] mm/zswap: misc cleanup of code and documentations
Date: Fri,  3 Oct 2025 13:38:47 -0700
Message-Id: <20251003203851.43128-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleanup an unnecessary local variable write in incompressible pages
handling, typos (s/zwap/zswap/) and outdated comments/documentations
about the zswap's red-black tree, which is replaced by xarray.

SeongJae Park (4):
  mm/zswap: remove unnecessary dlen writes for incompressible pages
  mm/zswap: fix typos: s/zwap/zswap/
  mm/zswap: s/red-black tree/xarray/
  Docs/admin-guide/mm/zswap: s/red-black tree/xarray/

 Documentation/admin-guide/mm/zswap.rst | 10 +++++-----
 mm/memcontrol.c                        |  2 +-
 mm/zswap.c                             |  7 +++----
 3 files changed, 9 insertions(+), 10 deletions(-)


base-commit: 2e943d9cc1fdd399a2f95d1c1d6b865d04bfa239
-- 
2.39.5

