Return-Path: <cgroups+bounces-13818-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AOENCB+imnVLAAAu9opvQ
	(envelope-from <cgroups+bounces-13818-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 01:38:56 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C98D115AEA
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 01:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD42B3031F3C
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 00:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7370F23E350;
	Tue, 10 Feb 2026 00:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RWcy9Fsr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EB62459E1
	for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 00:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770683912; cv=none; b=ubwWVCAjGP+ljIyf+G8WuGBNAcPdtjU366BgcUNwQRgA+3xuvcAbp9P4AP50Qdns63rviENu11MxdUWdv5yHoPg9RL0yBdPBAGX8zjL6zG1jWas76kwP5LGasLJ2kLvCb7igVhXY9T2L/amIGD7NMzGTQSzJQHsQIv65M/hQkog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770683912; c=relaxed/simple;
	bh=xUZ6aO6Vonw0GmRwLJmSzeGDgxD5B5jYUwBGyhliZYQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cRyXIBLCMFObUd1dTdgfIgjRf4RMnF4p4IWh08TsISTM96p09Cic0KIZLDRAveG+2zEIiLTe2jNXAA0ZUqB06qJuRUQ6F//a7CKZOudrgCvLt6mmt+H3Og+Fhqc32OVQXUb0iheWvSTvUwQ83/6RBQMoPVEKYkX8BrOVi3PbSFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RWcy9Fsr; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-81f2481ab87so294652b3a.0
        for <cgroups@vger.kernel.org>; Mon, 09 Feb 2026 16:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770683909; x=1771288709; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tip76l+g47OdHjbnqUq9WcMpsS2PZvPoe5KfSjLBVzA=;
        b=RWcy9FsrN2bax19CnztshhDysUsqmrhqmi0k6shl208zzWKSDywAMQERfNmyU7nleo
         XpZ3ldY0rK4GxtXzmZQis9Qn5wWQFTdoc4r04IPIqGXEmJzDwJQFSVlQAa3wet3DKJ5N
         jO+iwQNPIB0+SaSmOqfck9sk5dsk8wlGAUO5Bpif2synIclkS/ytxycKK+L9/bsKDbgT
         OjisM9QdKqa4Rp81cEDmX3c4Auhsq0yFCZw6V24lzngK3ZJXT9Dwjy4NDvRupvDB3mrP
         gvxhhf7ntwn+8OCdRbOJFntwPTTN20AEL69bAGhpgGPrN4NJyZFeBxyguiQszaQjU2T/
         C7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770683909; x=1771288709;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tip76l+g47OdHjbnqUq9WcMpsS2PZvPoe5KfSjLBVzA=;
        b=W5/xGFu80/B7SqQSV2LxlpVuV0ae63zTgylY+/4kSWPdX/fvsfs/jye3DdCYOl7rdd
         f2MxQGRHQ9YM0pHx1gyxviYyMZfN4d2okOHtviKVRvGwHl3JU200dmx/0R1Sr7M4/vGB
         aviGiRd93kAWPr7paKIyFJ4PiB/eF8x2/GfpBcoCgXDCVv3XIpxzcQV/Fgvoc4YDBTmi
         9T1ECHUs4/ArdciHf+4AlR8/hwTsqaEiOwkY6fk/T1/CQfuJ2fD5GZC+xFXdy8V15Qbg
         f/s8rJWlVM266gJVdrRPf7NQO2J8AfYqxI8FMTJF68ha3Wl9+LJlg6d2SjrSkyylJHJ0
         hwuw==
X-Forwarded-Encrypted: i=1; AJvYcCUzgBahU3Ow8m2F14Jv3rmWFFHTO1KuZllnz7y2vUrDxEDqLekzjU+LnZzmwZCWUi/tfOXZMK2F@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Z50NY4c4zeR7wmPN2gNMuyQ83/RUJIfmkIw2D2Zdf9dyA2G+
	jL4IJ/cammiz2HBkkOTpwe2CTWn2lleVSSOy2ZqETwN8J2nB6qO8yKHkUT/WT6+HMM+qoDDWesc
	pytTgL99RlG+ochH/NA==
X-Received: from pfbls21.prod.google.com ([2002:a05:6a00:7415:b0:822:4e8c:2c9e])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3914:b0:823:9e5:855e with SMTP id d2e1a72fcca58-824413c8e09mr12457964b3a.0.1770683909153;
 Mon, 09 Feb 2026 16:38:29 -0800 (PST)
Date: Mon,  9 Feb 2026 16:37:59 -0800
In-Reply-To: <20260210003801.2834976-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260210003801.2834976-1-tjmercier@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260210003801.2834976-2-tjmercier@google.com>
Subject: [PATCH 1/3] kernfs: allow passing fsnotify event types
From: "T.J. Mercier" <tjmercier@google.com>
To: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13818-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C98D115AEA
X-Rspamd-Action: no action

The kernfs_notify function is hardcoded to only issue FS_MODIFY events
since that is the only current use case. Allow for supporting other
events by adding a notify_event field to kernfs_elem_attr. The
limitation of only one queued event per kernfs_node continues to exist
as a consequence of the design of the kernfs_notify_list. The new
notify_event field is protected by the same kernfs_notify_lock as the
existing notify_next field.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 fs/kernfs/file.c       | 8 ++++++--
 include/linux/kernfs.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 9adf36e6364b..e978284ff983 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -914,6 +914,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	struct kernfs_node *kn;
 	struct kernfs_super_info *info;
 	struct kernfs_root *root;
+	u32 notify_event;
 repeat:
 	/* pop one off the notify_list */
 	spin_lock_irq(&kernfs_notify_lock);
@@ -924,6 +925,8 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	}
 	kernfs_notify_list = kn->attr.notify_next;
 	kn->attr.notify_next = NULL;
+	notify_event = kn->attr.notify_event;
+	kn->attr.notify_event = 0;
 	spin_unlock_irq(&kernfs_notify_lock);
 
 	root = kernfs_root(kn);
@@ -954,7 +957,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		if (parent) {
 			p_inode = ilookup(info->sb, kernfs_ino(parent));
 			if (p_inode) {
-				fsnotify(FS_MODIFY | FS_EVENT_ON_CHILD,
+				fsnotify(notify_event | FS_EVENT_ON_CHILD,
 					 inode, FSNOTIFY_EVENT_INODE,
 					 p_inode, &name, inode, 0);
 				iput(p_inode);
@@ -964,7 +967,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		}
 
 		if (!p_inode)
-			fsnotify_inode(inode, FS_MODIFY);
+			fsnotify_inode(inode, notify_event);
 
 		iput(inode);
 	}
@@ -1005,6 +1008,7 @@ void kernfs_notify(struct kernfs_node *kn)
 	if (!kn->attr.notify_next) {
 		kernfs_get(kn);
 		kn->attr.notify_next = kernfs_notify_list;
+		kn->attr.notify_event = FS_MODIFY;
 		kernfs_notify_list = kn;
 		schedule_work(&kernfs_notify_work);
 	}
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index b5a5f32fdfd1..1762b32c1a8e 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -181,6 +181,7 @@ struct kernfs_elem_attr {
 	struct kernfs_open_node __rcu	*open;
 	loff_t			size;
 	struct kernfs_node	*notify_next;	/* for kernfs_notify() */
+	u32			notify_event;   /* for kernfs_notify() */
 };
 
 /*
-- 
2.53.0.rc2.204.g2597b5adb4-goog


