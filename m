Return-Path: <cgroups+bounces-17848-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1UoPLXdpV2qlMwEAu9opvQ
	(envelope-from <cgroups+bounces-17848-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 13:05:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2796675D499
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 13:05:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=oFeUzVQw;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17848-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17848-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C801307B5C8
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 11:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE8A44210B;
	Wed, 15 Jul 2026 11:03:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1961942CB14
	for <cgroups@vger.kernel.org>; Wed, 15 Jul 2026 11:03:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784113421; cv=none; b=jtbfTvZQk0rH3CKdLY76+7phk7blYBixTe/P71FGQPCrlv35aTDbn8ihlEA81+PW7SoLeguV1w8dNw4pJjVkPm9Ny3u3Ii2d+4wKx3ZtP+jmD3VcvSWb9qMMgw66ZSJrULebuta7OKokqJXZ2Ofz3UZhYVduJUAqoFmokAn4Zk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784113421; c=relaxed/simple;
	bh=OuHNTKCxUIMX67vpWylAoqXnFPUPv0sLTOv0JBYEmnM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tYyYf9447pqiozqeg1nedC2jesIQWerI+qQc3koJGp9JDDlXhw6LD2e7iU9phJxf9vpBPyEQ82ozFf1iX//D3NfdW8P/8Gp7GY3oSMeCAiMJHtBQKpCbI5ARgCHFnvHMWk2tJG4v/bwjbBh044Wkpd2lYOSLMeNkAkbvzkHtj+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oFeUzVQw; arc=none smtp.client-ip=209.85.128.73
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-493c526df6bso17621315e9.3
        for <cgroups@vger.kernel.org>; Wed, 15 Jul 2026 04:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784113417; x=1784718217; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BvOk2rkLE/yZxPV4YYeXjAMJoxjIiJfLSZRx9VhA7SI=;
        b=oFeUzVQwqtx+v7NZENqyVgL5XpqXndqq/1Tcni5EF//rBKuPbSA0sYnebZtFJOiEsG
         PvuOwq8gO9pXXnAvealfvY4KvDUFCq9UFrqi3vVTtg7NHs2ppChxzsX8yXRFotPKjwbj
         b8J4N2Nr1zXf0pLsu0tw+mQrGsKkU/smCQQvpoZ+BhAEAqfL1X9MCadJpbAkRdo5CGSK
         yC8D/3qm0nfXF3FQ8723fs4tb4InuvnQvjIPuyz8EXHsUpMjr1g9zUH7oZe1v99K0oz6
         eqoUTa/qI/RQOVHntn++qL/LFztW/tP1yzVGSqd7VvHzehkX3HI2ZApKdi7TlzUdPaoG
         Y6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784113417; x=1784718217;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BvOk2rkLE/yZxPV4YYeXjAMJoxjIiJfLSZRx9VhA7SI=;
        b=FiQUSMohNKWKp3aicIK4zUy5ZfUFlY3YNrpVZkjz36IKF8aci4p2umC+hCOxXXULYr
         1EaCXk7PTnspxB68BfnpMlDvMXtfCV0I8jtUeozF+f+864O4MKl9aBxBH9GfS5KPEEG/
         dZea3h4m3JYsdvjudDCD1gjRNErHKke/oTkHl8HhlsyZ2ka8WwTe3Hn6YrzZTU9pXhLG
         em+MlyDL/Djh1I97HD1Ng0jpS6Z7Pyw9M9MCDzcNcKRDPrypffm7VcRobX0JDyl14rZy
         HRhtqo+LhNWYOdNDyVLJfYSfG4wNRHjfbMP+PiHy8VbJtbpxxePfOaUGDXGO8uGn2Ar4
         pbfA==
X-Forwarded-Encrypted: i=1; AHgh+RoK4jiKynEepLkryRzslxaKn/veci8wwD1Jj59uthhExEIJL4GSiAvKButdv1ZLA7pLZp0pVeB6@vger.kernel.org
X-Gm-Message-State: AOJu0YxbVJ0ysO58NceKSpI7HLe0bfJhWX28SPVn+93LCwwlS3UUUzbf
	pMNZqbJW0WJVLTwD0vp5fxgm1WsokEEQTgPwJV0GDJNvejWTElW1R8ETc2wJdbGMQiAwDKNyoL9
	CxJzB/FsHFjrUuA==
X-Received: from wmoq16.prod.google.com ([2002:a05:600c:46d0:b0:493:b593:ca9f])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f8a:b0:493:f7c8:eae2 with SMTP id 5b1f17b1804b1-493f87e6e9cmr175096055e9.15.1784113417076;
 Wed, 15 Jul 2026 04:03:37 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:03:17 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPVoV2oC/4XNQQ6CMBQE0KuQrq35tIDBlfcwLqD8QrVS0kKVE
 O5uixtdGJeTzLxZiEOr0JFjshCLXjll+hD4LiGiq/oWqWpCJgxYAYcUqBtUT0c7ayNuVBqtzWM
 aKOdMFLxAaMqShO1gUarn5p4v7+ym+opijFhsdMqNxs7bsU9j79+HTynQSso6l5hjA3BqjWk17 oW5k3ji2SeT/WJYYLhgEAjO6jT7YtZ1fQEIegvxFAEAAA==
X-Change-Id: 20260710-spin-trylock-followup-332c636e0d99
X-Mailer: b4 0.15.2
Message-ID: <20260715-spin-trylock-followup-v3-0-fc4d246f705d@google.com>
Subject: [PATCH v3 0/4] mm/page_alloc: couple of followups for recent cleanups
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Waiman Long <longman@redhat.com>, 
	Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>, 
	"=?utf-8?q?Michal_Koutn=C3=BD?=" <mkoutny@suse.com>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, sashiko-bot@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:vbabka@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:jackmanb@google.com,m:hannes@cmpxchg.org,m:ziy@nvidia.com,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:longman@redhat.com,m:ridong.chen@linux.dev,m:tj@kernel.org,m:mkoutny@suse.com,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:rppt@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jackmanb@google.com,cgroups@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-17848-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jackmanb@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2796675D499



---
Changes in v3:
- Fixed Sashiko Links: (Zi Yan)
- Fixed kerneldoc syntax (Sashiko)
- Removed extra VM_BUG_ON() (Sashiko)
- Link to v2: https://patch.msgid.link/20260714-spin-trylock-followup-v2-0-=
3c20ed032b14@google.com

Changes in v2:
- Separated from functional fixes
- Added cpuset cleanup, comment fixup, VM_BUG_ON() removal from Zi Yan's
  review of [0].
- Link to v1: https://patch.msgid.link/20260710-spin-trylock-followup-v1-0-=
affb5fe5ed00@google.com

Based on mm-new, these are followups to [0]

The alloc_pages_nolock_noprof() comment fixup could be squashed into
"mm/page_alloc: relax GFP WARN in nolock allocs" - currently
11770f8836f44 in mm-new.

The VM_BUG_ON() removal could be squashed into "mm: remove
__alloc_pages_node()", currently fba100a6cdfc5.
[0]: https://lore.kernel.org/all/20260703-alloc-trylock-v5-0-c87b714e19d3@g=
oogle.com/

To: Andrew Morton <akpm@linux-foundation.org>
To: Vlastimil Babka <vbabka@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
To: Michal Hocko <mhocko@suse.com>
To: Brendan Jackman <jackmanb@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
To: Zi Yan <ziy@nvidia.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Clark Williams <clrkwllms@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
To: Waiman Long <longman@redhat.com>
To: Ridong Chen <ridong.chen@linux.dev>
To: Tejun Heo <tj@kernel.org>
To: Michal Koutn=C3=BD <mkoutny@suse.com>
To: David Hildenbrand <david@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev

---
Brendan Jackman (4):
      mm/page_alloc: rename FPI_TRYLOCK -> FPI_NOLOCK
      cgroup/cpuset: update some comments about the page allocator
      mm/page_alloc: fixup alloc_pages_nolock_noprof() comment
      mm/page_alloc: remove a couple of VM_BUG_ON()st

 include/linux/gfp.h    |  1 -
 kernel/cgroup/cpuset.c | 13 +++++--------
 mm/page_alloc.c        | 22 +++++++++++-----------
 3 files changed, 16 insertions(+), 20 deletions(-)
---
base-commit: 59c684a9908d2e6f7a791f7f033eae57ec2b3a61
change-id: 20260710-spin-trylock-followup-332c636e0d99

Best regards,
-- =20
Brendan Jackman <jackmanb@google.com>


