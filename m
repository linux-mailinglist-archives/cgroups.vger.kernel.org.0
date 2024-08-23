Return-Path: <cgroups+bounces-4430-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B5E95D34D
	for <lists+cgroups@lfdr.de>; Fri, 23 Aug 2024 18:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3C3A1C23386
	for <lists+cgroups@lfdr.de>; Fri, 23 Aug 2024 16:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4B118BC38;
	Fri, 23 Aug 2024 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b="DQHbWinR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5549218B49C
	for <cgroups@vger.kernel.org>; Fri, 23 Aug 2024 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430445; cv=none; b=NI4G6NiwISJiHj6ODw6RBFIchzqGZsvecb78jQnBmXIdGzSnuDdMlhAVci/BwaSbyvbFFnuI07LelM/CLUALFAPa6q91s9XE7sdwP3Yfd3/jBpwxb/oLN+pewStxnODx+ook4spk3gR5Om8CGfMYyW+bShQG5Pq9I945PrzCtSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430445; c=relaxed/simple;
	bh=0tWunSXFDZ1yWnXSWuVl55xeq0RST5tuq2LjnMj+T6Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6uFuN0+azgamXQLqWAGixR4Ickf2y84iqaOZuWwEXCIcWFYKoCgMnDRSZzULWpklf75eABjUggRxppSkFERUJYmKd3FM9/Y1aoZkcXDyDC4ri6nsgz9kUhhD8iBBEB9PNLro9rFuAV8n26fBI14sIpKWCORmzih+uLDsaLTTMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com; spf=pass smtp.mailfrom=yhndnzj.com; dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b=DQHbWinR; arc=none smtp.client-ip=185.70.40.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yhndnzj.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yhndnzj.com;
	s=protonmail; t=1724430435; x=1724689635;
	bh=q54uHymsuuCJEUwRG3OoSXXb4G9nERztgFbdZCGsU1k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DQHbWinRSf8CSE01rY0HlqkE38LF2s/U/brRHorICuBLyeylZpqxeaAgxSWjFF4Bk
	 GzMcMuahFDfIY90587qr4QwIu0Qm/PZOnlvDfWMJporXBGgkzG+Xn0mA8PKjAu+9Us
	 x0ppn3sJfYmNs9baC0DW+jm11o3S2HdS9wyH2hSj4qaR/vmJsHf9E0WCaQCDrVD9Jv
	 elGMu0jSg3pn3KrMGO2UfyWmE0jaHb/To++mf7eX5rMWiOTW6qliZCz7uYCZvwz1o3
	 /G/RmNPfP8a2wZOx5w38D+DH27NBNp1caftLqeDNqnE4hPFJU/YSsQD1cPhDrecrH2
	 gv8yWTiimiHTQ==
Date: Fri, 23 Aug 2024 16:27:11 +0000
To: linux-kernel@vger.kernel.org
From: Mike Yuan <me@yhndnzj.com>
Cc: Mike Yuan <me@yhndnzj.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>
Subject: [PATCH v3 3/3] Documentation/cgroup-v2: clarify that zswap.writeback is ignored if zswap is disabled
Message-ID: <20240823162506.12117-3-me@yhndnzj.com>
In-Reply-To: <20240823162506.12117-1-me@yhndnzj.com>
References: <20240823162506.12117-1-me@yhndnzj.com>
Feedback-ID: 102487535:user:proton
X-Pm-Message-ID: 9391cbe5faffb78cda607cff6563b688bbb16fc0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

As discussed in [1], zswap-related settings natually
lose their effect when zswap is disabled, specifically
zswap.writeback here. Be explicit about this behavior.

[1] https://lore.kernel.org/linux-kernel/CAKEwX=3DMhbwhh-=3DxxCU-RjMXS_n=3D=
RpV3Gtznb2m_3JgL+jzz++g@mail.gmail.com/

Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>

Signed-off-by: Mike Yuan <me@yhndnzj.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-=
guide/cgroup-v2.rst
index 95c18bc17083..a1723e402596 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1731,6 +1731,8 @@ The following nested keys are defined.
=20
 =09Note that this is subtly different from setting memory.swap.max to
 =090, as it still allows for pages to be written to the zswap pool.
+=09This setting has no effect if zswap is disabled, and swapping
+=09would be allowed unless memory.swap.max is set to 0.
=20
   memory.pressure
 =09A read-only nested-keyed file.
--=20
2.46.0



