Return-Path: <cgroups+bounces-17089-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Wm9tLmSHNmrDAwcAu9opvQ
	(envelope-from <cgroups+bounces-17089-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 20 Jun 2026 14:28:20 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EDB6A8E3F
	for <lists+cgroups@lfdr.de>; Sat, 20 Jun 2026 14:28:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YeIX3trQ;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17089-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17089-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43A923020011
	for <lists+cgroups@lfdr.de>; Sat, 20 Jun 2026 12:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A86392C2A;
	Sat, 20 Jun 2026 12:28:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975D734388C
	for <cgroups@vger.kernel.org>; Sat, 20 Jun 2026 12:28:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781958496; cv=none; b=QqFVn5Da8QQfLRH26UlZIGkaD7aGTMEalHoT6Sv3ymWrvMCJkoj91Mre6CoaZnHHsQLc0IuY4G+anwEG+22iifgafFjo6SL++fjikejOa3T72Rv9g/RfXsc5av15EasvgK8u9PhJFBNE+4FXqdYMkaoqLqhjn2Xfbn7QFk35YRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781958496; c=relaxed/simple;
	bh=J+q2tm0dpONzieAzxCQJ2z9vwqaC+mViTCZ8c5SfpM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FBGFF5RGnatc/SkTtXZ8EpQELK31qBIfqWmJxV3sT6mjTtVBFtYfdnVjBxOxMaTySPl3FnHnDNVOPA4hQLutD+7RX+q3XeYg0htwD+TzsI8j0340+TQ34XmWGOCCTqbqjBgExume6LMHDLyDGkgNgepI0qwT0xTxLXhgYDj1x+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YeIX3trQ; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490d6730461so3212275e9.3
        for <cgroups@vger.kernel.org>; Sat, 20 Jun 2026 05:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781958493; x=1782563293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Im+iZLIRK/53fqygAoYA6+h4HUl3WPCXC1dHO2ua9IA=;
        b=YeIX3trQt8JrXRqVbjPreShbEPIHIvv1dZ+WWLh/gfSaVp0Jen2WsFUD6/BbxWJ2Kq
         ytU+eGD3EDS7kMvdTTR2Y9VBYLY7KguuKxrrS9VO+n4vUQC82LLImTHaEL5gM0orbhxu
         8WBEiXfwdoHv8EKl/FvJc9lwjph4vU4G8HZ+7ytrSij36VFmRodydc7N2lxNwxrgr4sc
         ERPsrGD1jslOQKyX9Snz6cb1M4HvtsZCYD8+PWGg5HaEf63idi36QKPjE4AnFk1RwRBn
         LmvtHDyIA6ohKgL6KnLlbN4AIg7ElRFTJ6/x9wkuieGeGzfvW68fhgtiAS4tprM5wh+6
         vpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781958493; x=1782563293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Im+iZLIRK/53fqygAoYA6+h4HUl3WPCXC1dHO2ua9IA=;
        b=iV8YZm9irreW/6jpTs8tLbPZnP6M3z5RgVqH+amDkRZwaFzsKahMz6zahqwQqe53Xg
         O/PLN8y1knkQOt1kJnROJTZgbSloadNvUOuTursitlnXOaoILl/cXe7+DVIvNDEKcxqX
         op/AG6NbznkrcO1LCAPXVec+IgQEEjKwIlLS0wXTsgrjS/V27eTVSLmYu9OlB5eqOLBv
         /KC73MoHNUgns8duFkqG8iXLZ4G1+9ed8VVkUK7EkZryTVc1YAbzT3DTgNxkampaYseC
         qyCeflXxmem4jcAcyVAi86Dbum5sz0iRWyLdjJO6Y3Wi91KcsqV/JhcvYF/xT8tQsgMB
         G74A==
X-Forwarded-Encrypted: i=1; AFNElJ+YnpG+KpMwCeE5C42bv/2hrWiFV2QhifmYUsWo0crLslo2Tn4X3jBdiLSmlhev42eS7TNUJnvo@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5mQ/9uNXyat9QTP3JDYl5qbj7q04SkteyFlQO0knFLjsOkDLm
	Z2RdTOIYmWUvCmeqTgWjWWqVLyHHLvV7plf4FdZ6Z1ssiefjvWstZ4d4
X-Gm-Gg: AfdE7cmGxQOz4TOSb5EvR5+vMuLy10Szds/ew42+4uqwgf0AqGGoFixDkos/m/Kmsxr
	pl748Nqpug73ng8csDtwnaKHHQDTv4cAIGf74TuQjqdMkWOje6hS/4wyXohkkt7U4IYL+3tfOCW
	5ukok1Imz0Z+mhtnSYWL/Luq644QtQASJQNw77LRyvPvZOZ2G9jHFP6PuLpO7Ciuq61Tfzap94T
	DWidLGNGFv3zqY5f0evKpgwEGh9oRGt9MOeUcOHOUjxWCva+7o896bCP6n3kYWiVwQB6kVISqyk
	LbDArczRb7+1X+2S2edES4/GceUZGBYOvZuEkdXe3FskyRL35AgCnkHlRz/63njMEXZ43CnfuWA
	c5Z4YPcafpp5vBQX0LPjY1VBrXxpSfPfqlaDo8AT/FP+zId7e4SD77js1rT4GTrb9DD2kGgqflo
	FroS44aubBKjfHfgYGEIOuosyAGL3k9E6GmX8KDNnjwZmEhaoLrVxxjeekEiIWNIKkFHrstNiU+
	HoOkg78vyEQk/1i
X-Received: by 2002:a05:600c:630e:b0:492:38cb:a7ff with SMTP id 5b1f17b1804b1-49246e60fc7mr31082325e9.7.1781958492836;
        Sat, 20 Jun 2026 05:28:12 -0700 (PDT)
Received: from doehyun-dev.pradel.rg.cispa.de (x06.xlate.fw.cispa.de. [195.37.157.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49249207dabsm101338325e9.0.2026.06.20.05.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 05:28:12 -0700 (PDT)
From: Doehyun Baek <doehyunbaek@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Yosry Ahmed <yosry@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doehyun Baek <doehyunbaek@gmail.com>
Subject: [PATCH] Docs/admin-guide/cgroup-v2: fix memory.stat doc details
Date: Sat, 20 Jun 2026 12:27:51 +0000
Message-ID: <20260620122751.388770-1-doehyunbaek@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,suse.com,linux-foundation.org,linux.dev,kernel.org,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-17089-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:corbet@lwn.net,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:akpm@linux-foundation.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:yosry@kernel.org,m:nphamcs@gmail.com,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:doehyunbaek@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[doehyunbaek@gmail.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doehyunbaek@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0EDB6A8E3F

Fix minor cgroup v2 memory.stat documentation issues.  Correct the
vmalloc per-node marker now that vmalloc uses the native NR_VMALLOC node
stat, and document zswap_incomp as a byte-valued memory amount instead
of as a page counter.

Fixes: c466412c73c3 ("mm: memcontrol: switch to native NR_VMALLOC vmstat counter")
Fixes: 5ad41a38c364 ("mm: zswap: add per-memcg stat for incompressible pages")
Signed-off-by: Doehyun Baek <doehyunbaek@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 993446ab66d0..ce6741f78f4f 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1570,7 +1570,7 @@ The following nested keys are defined.
 	  sock (npn)
 		Amount of memory used in network transmission buffers
 
-	  vmalloc (npn)
+	  vmalloc
 		Amount of memory used for vmap backed memory.
 
 	  shmem
@@ -1735,7 +1735,7 @@ The following nested keys are defined.
 		Number of pages written from zswap to swap.
 
 	  zswap_incomp
-		Number of incompressible pages currently stored in zswap
+		Amount of memory used by incompressible pages currently stored in zswap
 		without compression. These pages could not be compressed to
 		a size smaller than PAGE_SIZE, so they are stored as-is.
 

base-commit: 1a3746ccbb0a97bed3c06ccde6b880013b1dddc1
-- 
2.43.0


