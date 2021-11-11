Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC1844DE9C
	for <lists+cgroups@lfdr.de>; Fri, 12 Nov 2021 00:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbhKKXpM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 11 Nov 2021 18:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbhKKXpL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 11 Nov 2021 18:45:11 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50270C061766
        for <cgroups@vger.kernel.org>; Thu, 11 Nov 2021 15:42:21 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id w133-20020a62dd8b000000b0049fd6d7b5caso4638461pff.22
        for <cgroups@vger.kernel.org>; Thu, 11 Nov 2021 15:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=QKU2zoRZAY9B8wj0r50tOlnkCOTcLxsxIw+JHt9jziI=;
        b=JocGXKO8vY/Ookh/ASf19pgzF9fbTxKzPIQc9mr3ZW9WLy37prKQp+n3wZnM/xMthM
         2KQx2QAwcupd9pCNoZfYj+6FCwVVh6Jkn9m052frBDQ15Ovd03/ja8SLsW+GW7JuTW7/
         I3epIUBB2H6nOAIkBN9Txbrt0YOYzxDhPkI1ChBp+uj1WGkwN6tJWejpY2LsYHDbTgct
         t+eExB3JvbT+XdeGFGYhdFhDmoi9K+yadiin6mJ9215TXb/QussBIvxWorlBaK7Mu5RX
         61Yl8hcta58kMpcN4IZPjM68lyv1IVyZSGpliCorVZf2XwliHcMa5DkDnOuoS1MPphyS
         L0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=QKU2zoRZAY9B8wj0r50tOlnkCOTcLxsxIw+JHt9jziI=;
        b=n8emoIEUJHki8xTL5OOxLFxgo602Jw5g1S56NyOd+TUtzS6LoVeT5xsZkxHFOP4Opu
         48Duwj5Rn5A3UcgqN5A6topXQBd9m3tnEuIwB92ztfKiG+CHdUYF90S6+lmStTozdIIV
         RHv8fcpxmRz84LddSZ/PTlT00F4Zr2ZomBoohTchI+Iija0eUbC1t56ViEBVitmq3jX+
         8HAA9OGxQq0xYmfAUIGfTGcVbC5no4CgA0gQnAyhQf3dWdgzf61j/rSnySIk47uvhDf2
         SlWizO18yaXbl1wCZsMLRbU3KxkN53bUg6VFdDpMaXPEgAxxI35bbiXMDGHyWHyOamqk
         DUQA==
X-Gm-Message-State: AOAM531TYzinvwgRyWtqVRWiEj5l4IZgBzTLFlknzvtjT3o/DeSDS4HT
        +v03XOkf+nbi6NuymV3Kucs1e+yXO+CDp67ZjQ==
X-Google-Smtp-Source: ABdhPJyv18UxWjHYGcxmL0Hv3Vr6h6XrUEROs+TEjWYMoubdPeYAV2S1MsBJ8jE6zKcEwPC+EOBt3F7jMzJb6sulWA==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:672d:70d0:3f83:676d])
 (user=almasrymina job=sendgmr) by 2002:a62:8683:0:b0:480:edf9:33c0 with SMTP
 id x125-20020a628683000000b00480edf933c0mr10265886pfd.11.1636674140761; Thu,
 11 Nov 2021 15:42:20 -0800 (PST)
Date:   Thu, 11 Nov 2021 15:42:02 -0800
In-Reply-To: <20211111234203.1824138-1-almasrymina@google.com>
Message-Id: <20211111234203.1824138-4-almasrymina@google.com>
Mime-Version: 1.0
References: <20211111234203.1824138-1-almasrymina@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v3 3/4] mm, shmem: add tmpfs memcg= option documentation
From:   Mina Almasry <almasrymina@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>, riel@surriel.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Signed-off-by: Mina Almasry <almasrymina@google.com>

Cc: Michal Hocko <mhocko@suse.com>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Greg Thelen <gthelen@google.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: riel@surriel.com
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Cc: cgroups@vger.kernel.org

---
 Documentation/filesystems/tmpfs.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
index 0408c245785e3..1ab04e8fa9222 100644
--- a/Documentation/filesystems/tmpfs.rst
+++ b/Documentation/filesystems/tmpfs.rst
@@ -137,6 +137,23 @@ mount options.  It can be added later, when the tmpfs is already mounted
 on MountPoint, by 'mount -o remount,mpol=Policy:NodeList MountPoint'.


+If CONFIG_MEMCG is enabled, tmpfs has a mount option to specify the memory
+cgroup to be charged for page allocations.
+
+memcg=/sys/fs/cgroup/unified/test/: data page allocations are charged to
+cgroup /sys/fs/cgroup/unified/test/.
+
+When charging memory to the remote memcg (memcg specified with memcg=) and
+hitting the limit, the oom-killer will be invoked and will attempt to kill
+a process in the remote memcg. If no such processes are found, the remote
+charging process gets an ENOMEM. If the remote charging process is in the
+pagefault path, it gets killed.
+
+Only processes that have access to /sys/fs/cgroup/unified/test/cgroup.procs can
+mount a tmpfs with memcg=/sys/fs/cgroup/unified/test. Thus, a process is able
+to charge memory to a cgroup only if it itself is able to enter that cgroup.
+
+
 To specify the initial root directory you can use the following mount
 options:

--
2.34.0.rc1.387.gb447b232ab-goog
