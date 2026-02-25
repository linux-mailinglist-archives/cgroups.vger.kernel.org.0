Return-Path: <cgroups+bounces-14393-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GoOITt5n2nScAQAu9opvQ
	(envelope-from <cgroups+bounces-14393-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 23:35:39 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F50A19E54B
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 23:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35A2030D3EBC
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 22:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA7133BBBF;
	Wed, 25 Feb 2026 22:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BxzG4G3L"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DE933C18B
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 22:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772058856; cv=none; b=mdy/FvpTj/dRBFTwIrCeXQqkjGw3LJsxvEkttD194DDDW3dik4/I2x53GjyuLxye83vRbkbjbHKOF+I3izgKzqViqtlGgl84dEhyCxB3prs7I2YBPeLnopI7RPnARPxPzGSgNl+XUb7NZUUAcIihginSrult0ky2+kGhOBoPCmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772058856; c=relaxed/simple;
	bh=d/Njxo6LsxfyrmnJNgQrbf4Jrkxu+B4X3AZ0DsjVEVo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SpEbpM6yEvTBDBeP3lKiFVLW2TqCiq8I7ZLs9QoDaoyV9bu7gBbCIlSwMvBUj9LA8bIfiVDTqlcGhV4lticJK6wTB3pIfAvRq2wTU2Ip8PJZLQrRQkKWLP7DutfjrSgCWD0vP11LJBBgsAbbrQf4vr5E3Z/GTN59hAWdqenvcdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BxzG4G3L; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-827185c410dso997067b3a.3
        for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 14:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772058854; x=1772663654; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ej8LZF1b2o/Ks4R9g/3WwRmZsBfUCiZmdJJkOcGo2tM=;
        b=BxzG4G3LajyWmNwxkvDlwpBcseYaD7ZbGndoatMSkBckWFxRfxbphZtibZ0hyraLjE
         Kl10IbA+mdZ32WOc6bbNFoMajjDCVWlXW2FDSPFQyOmfCaoCW1aoRg8Vuw4i8d7DdPCZ
         u69sgXA9X1oIeXkAb2reT67dShvUYVs7nJ79FiAUJv++cS349qRgf7EoNYbNs2UeRY+j
         o3MckmvdIhfSHceJBaSjUbrTSOgWXofI/CrlR54a+ydm7a7n4Ld/M9AwyrSMEGhGI3xC
         +/JOek7nLoMpUlB4CvMOIVx4GZ4LalpntsluNLyqeItkaRTOKt7rXOCSMMXpQtZrpJNZ
         DKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772058854; x=1772663654;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ej8LZF1b2o/Ks4R9g/3WwRmZsBfUCiZmdJJkOcGo2tM=;
        b=UG6KbXIzOky68gyc7hkklYYoCwDh9ihv5L0N7kJNSKi5S22hW7a8HJWFLdbNjTmtEH
         SPnsiEANAFutVrExkqW/CUgX0q790mUHzYwqej7k4kCGnEggrnh+Yzvwgm5GKa055jvE
         +4/s8sJ+CS3mFrFJMFgxz+YV0h4H8Tfr/Q6+ZVi7VqykKFI8kR5l/2FMleJ9d6xU9VUk
         smmkyWh9ulDGCdOkXN9M04EsX2aK62QHGQDzWwF5rCVlP9fPyWdjsBb2phBVp1G8x5yr
         Djx0U+CPjyUHOCcGg4W6awcm9uOXj4cgZbu4nIPkknpRVzdbU2kG0OWrIGSj3PhZs6ok
         Q6Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWN9nxioA0TNRZoyjFRH19aLrw74H9HlK5Tdormsgm7/ot1u7JpLVdbWj2XLWouqECfWImj/EF7@vger.kernel.org
X-Gm-Message-State: AOJu0YyEDa8v+1kPushgUeLS6GfI5/aLOOoF7TYhk6IvwR7lOQgc6Xl/
	wITddceNqyskDz7mDmBquqM3IRhU3hBl7//g21UaTMQAob9qwWrrbnX0GbsiOIpruxwLIFBSAIJ
	/Xjn9Nf5J5XXqUqAmiA==
X-Received: from pfbey14.prod.google.com ([2002:a05:6a00:38ce:b0:824:b235:888c])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:930a:0:b0:823:533d:5559 with SMTP id d2e1a72fcca58-826da9ee9b0mr17908704b3a.39.1772058854168;
 Wed, 25 Feb 2026 14:34:14 -0800 (PST)
Date: Wed, 25 Feb 2026 14:34:02 -0800
In-Reply-To: <20260225223404.783173-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260225223404.783173-1-tjmercier@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260225223404.783173-2-tjmercier@google.com>
Subject: [PATCH v5 1/3] kernfs: Don't set_nlink for directories being removed
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14393-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lists.linux.dev,vger.kernel.org,suse.cz,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F50A19E54B
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


