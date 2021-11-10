Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FFD44CB34
	for <lists+cgroups@lfdr.de>; Wed, 10 Nov 2021 22:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhKJVWw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Nov 2021 16:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbhKJVWw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 Nov 2021 16:22:52 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129BAC061766
        for <cgroups@vger.kernel.org>; Wed, 10 Nov 2021 13:20:04 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id h35-20020a63f923000000b002d5262fdfc4so2153164pgi.2
        for <cgroups@vger.kernel.org>; Wed, 10 Nov 2021 13:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=ht251uoyJjMbFDL2TxmjV/XN4/hXafLiuH05NGnumYk=;
        b=k0TTN636enCe/ZMmeDII0J/CegZ6ncDK7yKWw7ZeBWMxbKHHazE2DId/yW7TYXbfi8
         O5Yq9ZpclOX9PDD/9UKpxnBf8phr0BrRtW8oaGV0zz7VwAvHi+HacqJd9Ybi1dbenSIQ
         G2rDRoKgXjSvJCuLpzq8xVzz5f+YfSB6NtLHQRKgAIQkIMQUjoaENBgNO2hmVTk/CgU+
         4GOME56bKNUHCfHCryFmpcs8fxuv+Ly8oFnLIxdtYd+35ExNUXICX9Xb04z4oxz0uqoT
         fHBB0jJUl1W6L0lcuF4pEp/RzaEu5oBCvoLucY+O0LjmYUulutUJEWpPV00TsQo+hwkM
         iDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=ht251uoyJjMbFDL2TxmjV/XN4/hXafLiuH05NGnumYk=;
        b=3yf3A99SPgF3HL34CDeDbUlN5vIoM1StpTx4NhLhQrCqo8B2CB/y8MCOPmqEkYNX1e
         7TOenE53KkgzH8QUUcHrlArjK/BmjKM6zcMDtwNmfDDBTGVC51c+BN69qKQzWxq1l11+
         ZLWGXtopVr69HHFs8uaZ35qN9JK3Xjjf2E4b/tiMPOcD4Vyf1cvV5Y5hooBZ2gzkimr5
         PhbA2roPw2I+E/E75KJVnuj5W0CVHE0tkXqBiIGAUMkdAn2r5Wr3DHA5yyTjCs+L4yXN
         l/L7eIH7BGHpD/BwX5zjW40QqCf0bLUplRrHScvWqDGDI0MVeGT7K1LKcHzcbj5GXoHX
         ULQw==
X-Gm-Message-State: AOAM533Rij4NrT2hBrVIT7rLwYy6K/fDqkmvQrWOOxCNv/vucY1mhBPg
        rBA/1yexH/7RLVpiQ5lAAYLpEUdnBfBIKbydTw==
X-Google-Smtp-Source: ABdhPJyA3J75PZdpM4VEzqJ7LUuXb4mr7PMVvzXz4Bmi7qX1+EffLpI4N/pFRQh4ef5Qi9/IqgodmGo1/Z2akphvVQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:59c8:7b4e:e859:9db0])
 (user=almasrymina job=sendgmr) by 2002:a63:2acb:: with SMTP id
 q194mr1266568pgq.384.1636579203523; Wed, 10 Nov 2021 13:20:03 -0800 (PST)
Date:   Wed, 10 Nov 2021 13:19:49 -0800
In-Reply-To: <20211110211951.3730787-1-almasrymina@google.com>
Message-Id: <20211110211951.3730787-4-almasrymina@google.com>
Mime-Version: 1.0
References: <20211110211951.3730787-1-almasrymina@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v2 3/4] mm, shmem: add tmpfs memcg= option documentation
From:   Mina Almasry <almasrymina@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Dave Chinner <david@fromorbit.com>,
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
Cc: Dave Chinner <david@fromorbit.com>
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
2.34.0.rc0.344.g81b53c2807-goog
