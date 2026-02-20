Return-Path: <cgroups+bounces-14048-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCByLLf3l2k4+wIAu9opvQ
	(envelope-from <cgroups+bounces-14048-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 06:57:11 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D13164DFA
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 06:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54A7C304044C
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 05:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9622032E14C;
	Fri, 20 Feb 2026 05:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SZ9kflJm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BFD261B80
	for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 05:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771566916; cv=none; b=GfAsfAnCVPRRgEB+0BeyxjQ/yE/q8jFxYlDCayyX/bqY+0ymaSpKWM8CCwsMS6gO1UaMAJ+rz1PwF1eHf2kRz9SlcKcqia3eUBvrWpGZbwjXcYaGE5Wvzr1GR5AbYSR7lReQeFrktV0d4t40mWtlX5dhTumXd/mKjYfPPMDjwmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771566916; c=relaxed/simple;
	bh=d/Njxo6LsxfyrmnJNgQrbf4Jrkxu+B4X3AZ0DsjVEVo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jI2BPBtnxfv27S/ArK8ygHYPtaw5/ASQPlNaZ32ci5EPOpcVbgVUCORfFRQrPMQodozU4aNYFBI6htBz1HYEZIbVy5rZ8AZdyTt0iPA95IlM02gNTw3uh7+9NV2RRkFRgGbbVOBdsTXbP3N64ozm9qukXMckK4kFrF9zqHPe/pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SZ9kflJm; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ad44941ea2so11390855ad.1
        for <cgroups@vger.kernel.org>; Thu, 19 Feb 2026 21:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771566915; x=1772171715; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ej8LZF1b2o/Ks4R9g/3WwRmZsBfUCiZmdJJkOcGo2tM=;
        b=SZ9kflJmOLf6mfxQZrtOSRooBSwUjxlYGdxn0wXR68/2lgpl9UvUKfnKAVue4uRi7O
         zlf+ld9GMTgb9fO4szslpS75J1Avk2LvZbLEDiOzCVafZteADj2sfHhQXpEyjzE0kWa6
         ZLzDQt0+6QrA1JpfIwn2Wux7dZtwwDsfRD2NeGxKYY8fVCmDa8ktXY4RanZ3vw0RmBK/
         j1AG1U8Ib3IXyE7y1W46/8AC1wgiJzDCSBZrEq2U0vM3+UhwShGaaDFGdOZ5wIwmZiz9
         vuhHTJtiPKXZWH/T3P1TxV14OiIR+T3fEcUpgsPEcSWaqG7hx+S0KMc21HemBrwAFbTK
         6fNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771566915; x=1772171715;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ej8LZF1b2o/Ks4R9g/3WwRmZsBfUCiZmdJJkOcGo2tM=;
        b=aHwo7ROEPJDN2IMYqfkjEO/q5/i37/4XCAqkRaLEyepwAe4QSryNQCBPPDCpZLrO+D
         hNixB3QSzH25s7COGpJ/Fg5qd7a7NWzFoHuljP8AU179tC7qax2MLb1TUEvaQpn8BJ/k
         yiZg8NfyK0JHbGkJBpgWK8XW+y78fzwPU7lQbgRWr+miXtic7b96+KLxXAVQsesWTMMr
         crAViE0x7k08eJhoAAjM91gbz/GKnpzw4CQshoYMD0QfAsvvRrNULG96pt9KstbSs8tX
         KWjYk6oKvB9EYzqq5uGGPtxOFV3Vu+la7daCRjUpB6D0TLJGRKEvMBgRQdyVMWncuvab
         WLBw==
X-Forwarded-Encrypted: i=1; AJvYcCWaykWJkpe+scauPI577MzHteKqbpQhZAks9d3cwdeRvbn8FDfeCtrXPKziUZkSJVwmGOkgp6dP@vger.kernel.org
X-Gm-Message-State: AOJu0YxEYKNF7jWlmpZLE1FE4igLvVyeog54hkV1NXGoosrR3BizVSHS
	9YF2JbiUrHR8USQ1aYlDawNBdvf0l6AhgWaYKq/sMYz3faOvrM2GwF/hBx4abG7EVCEDhaerA58
	TS1qeeu8zJCFv/Xyo3Q==
X-Received: from plma8.prod.google.com ([2002:a17:902:7d88:b0:2a0:92b7:79c1])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3bd0:b0:2aa:dc84:251f with SMTP id d9443c01a7336-2ad5aec750dmr47251955ad.2.1771566914488;
 Thu, 19 Feb 2026 21:55:14 -0800 (PST)
Date: Thu, 19 Feb 2026 21:54:46 -0800
In-Reply-To: <20260220055449.3073-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260220055449.3073-1-tjmercier@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260220055449.3073-2-tjmercier@google.com>
Subject: [PATCH v4 1/3] kernfs: Don't set_nlink for directories being removed
From: "T.J. Mercier" <tjmercier@google.com>
To: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, amir73il@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc: "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14048-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lists.linux.dev,vger.kernel.org,suse.cz,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 60D13164DFA
X-Rspamd-Action: no action

If a directory is already in the process of removal its i_nlink count
becomes irrelevant because its contents are also about to be removed and
any pending filesystem operations on it or its contents will soon start
to fail. So we can avoid setting it for directories already flagged for
removal.

This avoids a race in the next patch, which adds clearing of the i_nlink
count for kernfs nodes being removed to support inotify delete events.

Use protection from the kernfs_iattr_rwsem to avoid adding more
contention to the kernfs_rwsem for calls to kernfs_refresh_inode.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 fs/kernfs/dir.c   | 2 ++
 fs/kernfs/inode.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 29baeeb97871..5b6ce2351a53 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1491,12 +1491,14 @@ static void __kernfs_remove(struct kernfs_node *kn)
 	pr_debug("kernfs %s: removing\n", kernfs_rcu_name(kn));
 
 	/* prevent new usage by marking all nodes removing and deactivating */
+	down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 	pos = NULL;
 	while ((pos = kernfs_next_descendant_post(pos, kn))) {
 		pos->flags |= KERNFS_REMOVING;
 		if (kernfs_active(pos))
 			atomic_add(KN_DEACTIVATED_BIAS, &pos->active);
 	}
+	up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 
 	/* deactivate and unlink the subtree node-by-node */
 	do {
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index a36aaee98dce..afdc4021e81a 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -178,7 +178,7 @@ static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
 		 */
 		set_inode_attr(inode, attrs);
 
-	if (kernfs_type(kn) == KERNFS_DIR)
+	if (kernfs_type(kn) == KERNFS_DIR && !(kn->flags & KERNFS_REMOVING))
 		set_nlink(inode, kn->dir.subdirs + 2);
 }
 
-- 
2.53.0.414.gf7e9f6c205-goog


