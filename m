Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1F511D13C
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2019 23:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfENVXY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 May 2019 17:23:24 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:50313 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfENVXY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 May 2019 17:23:24 -0400
Received: by mail-oi1-f201.google.com with SMTP id p83so190706oih.17
        for <cgroups@vger.kernel.org>; Tue, 14 May 2019 14:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/OYdIOpBJWCaBVUA2Ic/FHOWBWsqkzG28ElRwkV1PdY=;
        b=sMT1RFNIRx5Pslx1X+QRbggc6ZXdETqqUAmpYgQSfraDuAQ8m+rCMJk9uGbN6XrtHs
         tNkvdtsnGfHoH0GanvDXD+Fs6bm/IXQXFezj+d5P3ki8zYgnqAS/EoN5nDZJYNmbLDDZ
         AD+gARqdfYcjkA8KcwkxfSVO5a9PAtkxFAxt3FbP4bS2eGGNq3CxcOuewuBwbiFTdBqU
         r7UgPx4uwRpQE1MDB1pPgHNp+1PjjD8hA3bPI3U9YQ0+0oF6F4BpTGINJsrUutnPzVQ4
         YwgfaJcSrkTC6Jzttdasq2d0xMgnfgYbpVVOKTamjEKDeaSR84z3dR/se+nCH6uaSBCN
         i3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/OYdIOpBJWCaBVUA2Ic/FHOWBWsqkzG28ElRwkV1PdY=;
        b=jpB3BFkzUqt5Z+Z65BqRwtJq5mDm9juH1EdggQW+6GvGo2srSS27Ue1DYsqiM07isi
         60Cqi8Pe5YPkRvVosalMmqcWX3Z9gFC93lfbU2hu9MN1kbvdpfqCP/rVFGayuyHrQI1g
         0s5tv6DqPhJtkXyU16I3MO32FyQr6u0J0uglDEAmRC2HNrAZfcVMW281zdzz46eCCRV3
         vn87tgSpgq2QpvxMFUW8K+ukv/q2UZaZehmtBesvP1ntHxU5r/2MNXndDkqoS3/R1phy
         9BrjX30HfkKh0FsEKUuCDakLQMLO2XG85eO+iE52x4e2E6D1ayhOsI8HBD7B7jHeNg8C
         /1wA==
X-Gm-Message-State: APjAAAWVqZ6Ec76EoypGi17DnK43KwycXFVBrn3wTSpMCXCDVmKirUwg
        5VFEhx9fX39XCvFbfxL7YIPSqADuZCqc8Q==
X-Google-Smtp-Source: APXvYqym1Fqm5pNm2/VExHxbmxANidF+rxgp75ZamTBrHNj9XD2E4iXLCfQcbSoRxPswid69DBp+ecjJ3EluAg==
X-Received: by 2002:a9d:5f13:: with SMTP id f19mr121436oti.219.1557869003332;
 Tue, 14 May 2019 14:23:23 -0700 (PDT)
Date:   Tue, 14 May 2019 14:22:59 -0700
In-Reply-To: <20190514212259.156585-1-shakeelb@google.com>
Message-Id: <20190514212259.156585-2-shakeelb@google.com>
Mime-Version: 1.0
References: <20190514212259.156585-1-shakeelb@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v3 2/2] memcg, fsnotify: no oom-kill for remote memcg charging
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The commit d46eb14b735b ("fs: fsnotify: account fsnotify metadata to
kmemcg") added remote memcg charging for fanotify and inotify event
objects. The aim was to charge the memory to the listener who is
interested in the events but without triggering the OOM killer.
Otherwise there would be security concerns for the listener. At the
time, oom-kill trigger was not in the charging path. A parallel work
added the oom-kill back to charging path i.e. commit 29ef680ae7c2
("memcg, oom: move out_of_memory back to the charge path"). So to not
trigger oom-killer in the remote memcg, explicitly add
__GFP_RETRY_MAYFAIL to the fanotigy and inotify event allocations.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Roman Gushchin <guro@fb.com>
---
Changelog since v2:
- updated the comments.

Changelog since v1:
- Fixed usage of __GFP_RETRY_MAYFAIL flag.

 fs/notify/fanotify/fanotify.c        | 5 ++++-
 fs/notify/inotify/inotify_fsnotify.c | 8 ++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 6b9c27548997..8047d2fd4f27 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -288,10 +288,13 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	/*
 	 * For queues with unlimited length lost events are not expected and
 	 * can possibly have security implications. Avoid losing events when
-	 * memory is short.
+	 * memory is short. For the limited size queues, avoid OOM killer in the
+	 * target monitoring memcg as it may have security repercussion.
 	 */
 	if (group->max_events == UINT_MAX)
 		gfp |= __GFP_NOFAIL;
+	else
+		gfp |= __GFP_RETRY_MAYFAIL;
 
 	/* Whoever is interested in the event, pays for the allocation. */
 	memalloc_use_memcg(group->memcg);
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index ff30abd6a49b..ca1a9dfff0b5 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -99,9 +99,13 @@ int inotify_handle_event(struct fsnotify_group *group,
 	i_mark = container_of(inode_mark, struct inotify_inode_mark,
 			      fsn_mark);
 
-	/* Whoever is interested in the event, pays for the allocation. */
+	/*
+	 * Whoever is interested in the event, pays for the allocation. Do not
+	 * trigger OOM killer in the target monitoring memcg as it may have
+	 * security repercussion.
+	 */
 	memalloc_use_memcg(group->memcg);
-	event = kmalloc(alloc_len, GFP_KERNEL_ACCOUNT);
+	event = kmalloc(alloc_len, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
 	memalloc_unuse_memcg();
 
 	if (unlikely(!event)) {
-- 
2.21.0.1020.gf2820cf01a-goog

