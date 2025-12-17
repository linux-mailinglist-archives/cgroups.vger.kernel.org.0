Return-Path: <cgroups+bounces-12435-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B83CC8DA1
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 17:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C7A630BCFF9
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 16:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13510357717;
	Wed, 17 Dec 2025 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JGnvzqj6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F67235580C
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988891; cv=none; b=qtHEseDETHhWyWlIVIzdJTZ/2/Ab4cqofCp4MEQeiS/RHNci2NOkDQqI+tflrNee7BoRPJ3SKvzbJMVuJk08vglNrxevtZiPlV88Km1Aq73YTfdBJ2oU0JnU0JlAMZDrWkAI4HmQG0k0EUpSOEKIKULCsjCOEDicFcy7Zgi932w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988891; c=relaxed/simple;
	bh=EiPp5UR3odiaNu3fVGfrz6bU9tX+nxjcHoSZdd3tcLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLVpNCfFwrib80COvMYwTUBibwM/qzTO5zDzWFtAqSe53uG7P6BdKH6EgBVR/wVEqd7FL9BCcc/p9pcgc5eAi4rz0EtQju+rHq3nOMEOQtJnQeXNkDRUwBfRTZaRtN01DIfVubtTL+C3c5KqkDfRSSD01WsHMmnFbEeIeGgJzzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JGnvzqj6; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42f9ece6387so2359758f8f.0
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 08:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765988886; x=1766593686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfQau0odZ8gUGBEhG5i1wvM039LCZUqSFw7CAdbRE6k=;
        b=JGnvzqj6iCYWKkJNPpK3HGmQrS0fjcwiSI+Vv6QjbjtyBBGiRrOvk0xJq4582XMBFp
         AF5XBJWEyPdY/TFBRUEUnpaZgs4gMigLgvwVUe8KFtMLBG1O8hec9w66FO0VNp4zOc9e
         PHSPcqfBlVF45d33W4IXj8acFy2ZCWV9qdsVS3d/r28BBYZDw6swgAxf9ymC+sN2QDJR
         umKtcGRKZpfUANCVuPyWm9wNAGgYLEvQGoQ/KFkDMpxHRQYasE0P1LC1cKJDdtRek46r
         NVl0k9Ut9nq7MkEhg77shQv5zm3mcEAbUo1yBdqQCmOLJhESqlk4U8iRZuhVQCj79+LQ
         MmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988886; x=1766593686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nfQau0odZ8gUGBEhG5i1wvM039LCZUqSFw7CAdbRE6k=;
        b=ePzYptaRoYYdp0Dv0BJ20D+BBjhQPP2lnAnzBw7KTD+JqRPEu8Fgw6TJMbGh+vVTKq
         YOkYiTCP3u+/MK/kZLKAyujwjzrmG3PjRG/XxRqPtlxyJkj5sR6BzXY3KTmPDgPLCvnM
         EgrTSMJWHkFrUQ6da79997mYr8B22OpmhY0r3kNjgjtzH0Ir6bRTpDKfi4bLVnF8Y6Mi
         CelrgOL9NqWNYQHUd0WocdOIoxFtzeqHqGZHwK9UORYunIvkdmqon/5iZRii0GDzO4Hg
         U+h2LEBHDaRhlOQzGVz8rl+E4BChuvs6hXuFz7tV5UteJnTyJoQ7WqAGf2d08fp3l6fI
         s6XQ==
X-Gm-Message-State: AOJu0YzbcnFCKpYfiqLkMQqUWSIekBLSp2GEFJjP+yY+SYh1iJUBdnDz
	Eio6w0Cfex8hDRTetnHJuhUnVP18qYXtTQ1499CopXcEbHBLUgEqe812RYar2VeauiWif6qH7+x
	+a9Dc
X-Gm-Gg: AY/fxX6exqrIiDaIM/bGeNHYh0Pk3TK5WX3M3/ThFdh4zPaa7GpMaq0jJF6PpbR7GHo
	O6aoU5Vjdcm3wAns2FtDbpe435uxYX/3M0eOgWfYTSOFgdKeqSs/X9KF9AzcW47GpZXsR//hOub
	q+Roh1aHDrzDXiYFKedQGDEpX+ypxu1eMZ+n7iSN8j/I1BNO+ciuESTXYhY4TPd5QUaebDTWMpU
	7xVAQm4KSbVzSS3RTDLCLCW/wtKDaMZuCpYyFPy45Mp/dJUkMgsOh/VMnq66DhI4VnmedHqXzjB
	+oMlgN4144xyvLbV2YfWQm0tj6uprS/rPS0co8x75EJfphSoKftpVAHov0bE8FT4WdSfZSl9g8k
	2zNSD/TnuMQuSokV5G2vhlcrMbWXaSaQT1WSpGO4uEOjdD0OBvLIiY+p2Op58aZmEQxReY0m+AV
	4pEaXXjpT+OR1x0Mh9tkV1nvIeopjeBXc=
X-Google-Smtp-Source: AGHT+IEu4DI9WqCByr7rrTwLwlGd6tkHLE9xiBLfLuxbiSgJPjBw/xrcqlQOuJPymNtVyODbYOHj5A==
X-Received: by 2002:a05:6000:26d0:b0:430:f790:99d7 with SMTP id ffacd0b85a97d-430f790ae20mr15969150f8f.27.1765988885518;
        Wed, 17 Dec 2025 08:28:05 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adeee0esm5728364f8f.29.2025.12.17.08.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:28:05 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 3/4] cgroup: Use __counted_by for cgroup::ancestors
Date: Wed, 17 Dec 2025 17:27:35 +0100
Message-ID: <20251217162744.352391-4-mkoutny@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217162744.352391-1-mkoutny@suse.com>
References: <20251217162744.352391-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

cgroup::ancestors includes self, i.e. root cgroups have one ancestor but
their level is 0. Change the value that we store inside struct cgroup
and use an inlined helper where we need to know the level. This way we
preserve the concept of 0-based levels and we can utilize __counted_by
constraint to guard ancestors access. (We could've used level value as a
counter for _low_ancestors but that would have no benefit since we never
access data through this flexible array alias.)

Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 include/linux/cgroup-defs.h | 19 ++++++++-----------
 include/linux/cgroup.h      |  2 +-
 kernel/cgroup/cgroup.c      |  3 ++-
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 9247e437da5ce..8ce1ae9bea909 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -475,14 +475,6 @@ struct cgroup {
 
 	unsigned long flags;		/* "unsigned long" so bitops work */
 
-	/*
-	 * The depth this cgroup is at.  The root is at depth zero and each
-	 * step down the hierarchy increments the level.  This along with
-	 * ancestors[] can determine whether a given cgroup is a
-	 * descendant of another without traversing the hierarchy.
-	 */
-	int level;
-
 	/* Maximum allowed descent tree depth */
 	int max_depth;
 
@@ -625,13 +617,18 @@ struct cgroup {
 	struct bpf_local_storage __rcu  *bpf_cgrp_storage;
 #endif
 
-	/* All ancestors including self */
 	union {
 		struct {
-			void *_sentinel[0]; /* XXX to avoid 'flexible array member in a struct with no named members' */
-			struct cgroup *ancestors[];
+			int nr_ancestors;	/* do not use directly but via cgroup_level() */
+			/*
+			 * All ancestors including self.
+			 * ancestors[] can determine whether a given cgroup is a
+			 * descendant of another without traversing the hierarchy.
+			 */
+			struct cgroup *ancestors[] __counted_by(nr_ancestors);
 		};
 		struct {
+			int _nr_ancestors;	/* auxiliary padding, see nr_ancestors above */
 			struct cgroup *_root_ancestor;
 			struct cgroup *_low_ancestors[];
 		};
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 0290878ebad26..45f720b9ecedd 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -534,7 +534,7 @@ static inline struct cgroup *cgroup_parent(struct cgroup *cgrp)
  */
 static inline int cgroup_level(struct cgroup *cgrp)
 {
-	return cgrp->level;
+	return cgrp->nr_ancestors - 1;
 }
 
 /**
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e011f1dd6d87f..5110d3e13d125 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2197,6 +2197,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	}
 	root_cgrp->kn = kernfs_root_to_node(root->kf_root);
 	WARN_ON_ONCE(cgroup_ino(root_cgrp) != 1);
+	root_cgrp->nr_ancestors = 1; /* stored in _root_ancestor */
 	root_cgrp->ancestors[0] = root_cgrp;
 
 	ret = css_populate_dir(&root_cgrp->self);
@@ -5869,7 +5870,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 
 	cgrp->self.parent = &parent->self;
 	cgrp->root = root;
-	cgrp->level = level;
+	cgrp->nr_ancestors = parent->nr_ancestors + 1;
 
 	/*
 	 * Now that init_cgroup_housekeeping() has been called and cgrp->self
-- 
2.52.0


