Return-Path: <cgroups+bounces-13222-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E381FD213AA
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 21:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9620A3038006
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 20:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019FE357735;
	Wed, 14 Jan 2026 20:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZTsLmkD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D37D3570A6
	for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 20:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768423988; cv=none; b=RukzqCPJe37P6sCmxGp+5IkZGgvRwkCqJA1/yuY+x1ZpUOPtxxSk0zFet+slRDhTuw73O7hycnyDYCQ2F8EncdPap8I0jXyEb1/eKSZ/o5wqhSZEQFIf61TrM/KN4ZrY3dhD5EuRgYCfj1ZHlXDk2PeDOwjBEGDhjWZDxVkorEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768423988; c=relaxed/simple;
	bh=TtCLXs2pTBtJPCxHUMI6r5ZGmhBpGezHH5+nvl+813M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uTkxr43AuknN5Ksri8PhlPbLTXyR7vONATb7SfkSs8fimb1N5M8n7zTLkXXuVE7j34PP0uVehkRQzy1DyELFjha3dhKW4PzwxOBTNBQ8rpZZlOx/95J+aH6ZtUlFMiHmSCCcJnpEx3aKt6XIkZ9OuLE/vIh92RsPuVbnLLVbEGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aZTsLmkD; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b0530846d3so396946eec.0
        for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 12:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768423986; x=1769028786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s3bxOGWS6glvYwDy8bUAmdDe2eUabDyr0vbAJE9zJUk=;
        b=aZTsLmkDVv57wIi0wDC6HQMj+tlDTufeWr/USaEmMBFFxAl6Ps2FeXllpIanh+nRR2
         tO4osh15uu/gXT5g9Ls2Pa3NnxhWNLjkUMd5g+XUPTwpo5iRBF1s4St80KcmiVi6JQ0R
         81scpdmxNjT5hZodvXFhavdLlXIOB/usz60LQnk/aI7thVjZUXQw8rjjSL2CyEDeiz+/
         puHnx7wGbfoR3mSTkp4WSnVBFc6tcRVVwZi+pzvSQPv4pl7v6pO+1qpHfkd0h8O4xeVZ
         xGRLbeoI5vFo5sH7gXFg/vh8ZaQjHnMavkrwSuAEnE0xleU/sibCXjCv56ysssLHkqpM
         ukoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768423986; x=1769028786;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s3bxOGWS6glvYwDy8bUAmdDe2eUabDyr0vbAJE9zJUk=;
        b=HLFUpNfmPtd9G0mJQNq/Hg88Yhp0AvAUgvssIqObXpzWwl2ee2T4L/jbsG7sfPc+nH
         Kc8/4wG7sOu6p4oqt7lkn2TyzdLLNouwOE7zmINhNoUmJzRAlfqLZa3kWGCfnTn12eHx
         A6cN+1zzHHH7knv3arzc7ythSO2a/P0InD1odmCzHLgP60/nZghyX/4o8v/x2yp9v6By
         l3r+wR8s2UZ8bsjiSPFqlp1dhskRTtSLyKVAeU5DdrhzAESXCCjiYPaNoukHRnHnwsqy
         cY0TXiiE4Vre6ngo2tHYNyhdTR5HlkscplOpDKaINRYa0NkwD3qMWPi2TMSp3kYpIuMD
         /4WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhXSbMghfzfJ4/T42E1UDt2oDwjDCi76dUmRfwenCgX/vuM9RwlsWJDK9HZTKQk3xrW0qRcRY1@vger.kernel.org
X-Gm-Message-State: AOJu0YxpSydepJiC+m3fkGCbn18uMQcaMDZPpIY6LZRYkxzsX8iaVgWM
	bfHGshmRavvuvdUizcYBWJMZAO4NQtERBFj+fGoExvmhmpl9XvIdZSrkKuSYdV2WJQ0tXBVzSNf
	32fJ1txc7UOt6dw==
X-Received: from dlbcy2.prod.google.com ([2002:a05:7022:b82:b0:119:9f33:34a6])
 (user=bingjiao job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2206:b0:119:fb9c:4ebb with SMTP id a92af1059eb24-12336a67917mr2995405c88.30.1768423986476;
 Wed, 14 Jan 2026 12:53:06 -0800 (PST)
Date: Wed, 14 Jan 2026 20:53:01 +0000
In-Reply-To: <20260114070053.2446770-1-bingjiao@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260114070053.2446770-1-bingjiao@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260114205305.2869796-1-bingjiao@google.com>
Subject: [PATCH v9 0/2] mm/vmscan: fix demotion targets checks in reclaim/demotion
From: Bing Jiao <bingjiao@google.com>
To: bingjiao@google.com
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, muchun.song@linux.dev, roman.gushchin@linux.dev, 
	tj@kernel.org, longman@redhat.com, chenridong@huaweicloud.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch series addresses two issues in demote_folio_list(),
can_demote(), and next_demotion_node() in reclaim/demotion.

1. demote_folio_list() and can_demote() do not correctly check demotion
   target against cpuset.mems_effective, which will cause (a) pages are
   demoted to not-allowed nodes and (b) pages are failed to demote even
   if the system still have allowed demotion nodes.

   Patch 1 fixes this bug by update cpuset_node_allowed() and
   mem_cgroup_node_allowed() to return effective_mems, allowing directly
   logic-and operation against demotion targets.

2. next_demotion_node() returns a preferred demotion target, but it does
   check the node against allowed nodes.

   Patch 2 ensures that next_demotion_node() filters against the allowed
   node mask and selects the closest demotion target to the source node.

=3D=3D=3D

Hi Andrew,

Sorry for the extra noise in your inbox.

I=E2=80=99m resubmitting the full refreshed patch series together this time=
.
I just realized it is better to include the unmodified patches alongside
the modified ones to ensure compatibility with upstream automated tools
and to simplify your review process.

The refreshed patch series replaces some commits in mm-untable,
including:

  - Commit 809cc3db1831 ("mm/vmscan: fix demotion targets checks in
    reclaim/demotion")
  - Commit fd8cb9a8cedc ("mm/vmscan: select the closest preferred node
    in demote_folio_list()")
  - Commit 127714c76c46 ("mm/vmscan: fix uninitialized variable in
    demote_folio_list()")

Thanks!

Best regards,
Bing

Bing Jiao (2):
  mm/vmscan: fix demotion targets checks in reclaim/demotion
  mm/vmscan: select the closest perferred node in demote_folio_list()

 include/linux/cpuset.h       |  6 ++--
 include/linux/memcontrol.h   |  6 ++--
 include/linux/memory-tiers.h |  6 ++--
 kernel/cgroup/cpuset.c       | 54 ++++++++++++++++++++++++------------
 mm/memcontrol.c              | 16 +++++++++--
 mm/memory-tiers.c            | 21 ++++++++++----
 mm/vmscan.c                  | 31 +++++++++++++--------
 7 files changed, 95 insertions(+), 45 deletions(-)

--
2.52.0.457.g6b5491de43-goog


