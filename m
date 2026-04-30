Return-Path: <cgroups+bounces-15570-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEW8Ho+382mW6QEAu9opvQ
	(envelope-from <cgroups+bounces-15570-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2026 22:11:59 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D794A79CC
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2026 22:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14B5C30315EF
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2026 20:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8454338CFFA;
	Thu, 30 Apr 2026 20:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gVIHnFv1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B1136215A
	for <cgroups@vger.kernel.org>; Thu, 30 Apr 2026 20:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777579913; cv=none; b=SJm7NxGfxTInU7fyNYtqwK6qD3NXKS4LBmTcKqzDSD5aK05QdvKYRpZCLwcjv3jqkOg55sH4wYOOpg5VSjozlwCXrxx8k7/femWGR3Q7P2pHf6dXo4AxSGv4WV7znaRZ5s4POtvc/jQmyoGCIxbXR7bov2nO6rLY0pJ42euVn2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777579913; c=relaxed/simple;
	bh=1+hpSCCKz9Tr5wIL77vj24aX2y/HLkl7RxaMJT3XcQ4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ShVvg4zsEwyWvTVC2SXCz/yPUZgBKICVBzLXUOoc4BY3qEqwuRPkgk6JhoyhzpU7/sUEWD7KBhBm8EyPdrMu7liJbJGzvN0DlOyyYDs5xLunJnImJvkzpkpxQUUh66aAMKtMdjEQETw4HNfu5L5r1ZMIWIp0Y7HO0mA8MlveSxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gVIHnFv1; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b458add85aso12914015ad.2
        for <cgroups@vger.kernel.org>; Thu, 30 Apr 2026 13:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777579911; x=1778184711; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jBnnijQoTJ0z094ImigPUqqRjs6fvQAetKUiJNmcMt8=;
        b=gVIHnFv1VYt4zTIZ9ztr10F9Isk+M0I0mWLzNo1ChB1vGM1o+cFam5+jUn249HGGKF
         bR3NNq+KjKIKcmvT016BvdaH1HVpH4YsrMwqxGNNzNXNsezBkONwqHI17EwJ61vt73BX
         MZPF82FUbyZJ1ot6GAa6ux09CNe+ma9L4+FnIP2Ugzq2LiHyB/crGH+JcEFnBqGG4vIM
         RTdCMMprFsaSrRDwWPt0jlraHs/PpJ/AGMG1UYsjvsA9SmshTAv2mTh2ECCi5U2EUifJ
         zNNzKpRGaPdGaTR7rAMCWWWQY1gIEBXK+hH9SpQjQMt7la5bQxo7NiYpcxM9SisFFXrk
         R8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777579911; x=1778184711;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jBnnijQoTJ0z094ImigPUqqRjs6fvQAetKUiJNmcMt8=;
        b=Jvx9X/HC+JRVMl5LBsBYMbT59iqehluDS8Ee/aaPlJApPHpjEAHBdYLTJzXT+Pp95t
         5hr10rmKOPgS/2MCxrPg1gZTOZzwd3SU53KUDiBcgi9CaIPNimi4pfwydMCmEi3eGzQc
         cFvPKSLrHh1fhbl3a73X/LGg4pUauHaXJ2yYJmm1n91NebRwTQFSAaDigvSHGelguY2y
         3S9YJ2WHbTapCo6QVL5oucgUwErnGczpe+U6uvTbriRldbNupzG6wQ18nljqqnqx5rg9
         z8lfE9soyawJdn6zNCcLCrlgQaZ0zSqEZ+vq4TCjKNOM6Fni6vYiEuGrxHTjNR7rL4MO
         5xqg==
X-Forwarded-Encrypted: i=1; AFNElJ+M7zs8QeJYjTOFXkh8zv0zf4ZTF9h6p2NuB4UkFXuBxa05I8FZM9tEbkzWa8J8DaQG3WNpPN5M@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqqs7TbpdronNfNwm4mQB+ykvAzY3T6b3pue2K4Oq9NH9S4xNX
	SU4cSd8eP306puQ7e62dptcVsVUwi5mhJWBdOS5BaZH7YNEYkfbggQ46zhzAHB1BGEhRQr8+Bk8
	2D9quN/lpt4qfnBwu9w==
X-Received: from plhi13.prod.google.com ([2002:a17:903:2ecd:b0:2b2:3f89:e9d2])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:be0d:b0:2b4:5ff5:e51f with SMTP id d9443c01a7336-2b9a252be1amr35053285ad.36.1777579911404;
 Thu, 30 Apr 2026 13:11:51 -0700 (PDT)
Date: Thu, 30 Apr 2026 13:11:42 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430201142.240387-1-tjmercier@google.com>
Subject: [PATCH] docs: cgroup-v1: Update charge-commit section
From: "T.J. Mercier" <tjmercier@google.com>
To: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, 
	cgroups@vger.kernel.org
Cc: corbet@lwn.net, skhan@linuxfoundation.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 14D794A79CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15570-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Commit 1d8f136a421f ("memcg/hugetlb: remove memcg hugetlb
try-commit-cancel protocol") removed mem_cgroup_commit_charge() and
mem_cgroup_cancel_charge(), but the docs still refer to those functions.
There is no longer any charge cancellation.

Update the docs to match the code.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 Documentation/admin-guide/cgroup-v1/memcg_test.rst | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memcg_test.rst b/Documentation/admin-guide/cgroup-v1/memcg_test.rst
index 9f8e27355cba..7c7cd457cf69 100644
--- a/Documentation/admin-guide/cgroup-v1/memcg_test.rst
+++ b/Documentation/admin-guide/cgroup-v1/memcg_test.rst
@@ -47,21 +47,19 @@ Please note that implementation details can be changed.
 	  Called when swp_entry's refcnt goes down to 0. A charge against swap
 	  disappears.
 
-3. charge-commit-cancel
+3. charge-commit
 =======================
 
 	Memcg pages are charged in two steps:
 
 		- mem_cgroup_try_charge()
-		- mem_cgroup_commit_charge() or mem_cgroup_cancel_charge()
+		- commit_charge()
 
 	At try_charge(), there are no flags to say "this page is charged".
 	at this point, usage += PAGE_SIZE.
 
 	At commit(), the page is associated with the memcg.
 
-	At cancel(), simply usage -= PAGE_SIZE.
-
 Under below explanation, we assume CONFIG_SWAP=y.
 
 4. Anonymous
-- 
2.54.0.545.g6539524ca2-goog


