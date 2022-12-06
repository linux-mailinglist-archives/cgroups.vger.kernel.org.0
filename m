Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733AE644A14
	for <lists+cgroups@lfdr.de>; Tue,  6 Dec 2022 18:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbiLFROu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Dec 2022 12:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbiLFRO3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Dec 2022 12:14:29 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EDE32044
        for <cgroups@vger.kernel.org>; Tue,  6 Dec 2022 09:14:25 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id l11so21264250edb.4
        for <cgroups@vger.kernel.org>; Tue, 06 Dec 2022 09:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7DLHKnfgUHUqbOM/z8uZ79UX5oa3K/ENnh6OCW5tqs=;
        b=SVtFnYIHXMecHvxYJx77nJRHucuFwk5/9UG0Gzc0VixuyFsGI76/q4dIZTOj1/SyqT
         O82nl1FhPWAuz6lthA4angI6hMP1oZ1qGqag/8sKuVxBGm3pxTJTOWSvPrnOqtbj5jfd
         dswMPCRu9hqrDyIeHIcBn4yV+mIpsTk4mtqkiH6YM7R3FEaAd3SHSxjIa0Zn6WW0paME
         3RAvrTuiv3qqMZnPDfVp3gFd0wYptMFNXnJ/2pl0ugruoWzEj4p0JQBQjH47NBbb0t+v
         fuorAUnWM8LTnOrOiOvW4DKQWz57wcJP0qAtpCExb4/f/oq8NDnkZRVOa6F4b3YFJBO1
         Hedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7DLHKnfgUHUqbOM/z8uZ79UX5oa3K/ENnh6OCW5tqs=;
        b=FgRx7GDXhpQCW7E12pjCiupZu44YmGLtUl29BT4HLRySI5ShgP+PUBYLgX8rItCC8D
         XtT+zALYGKMz3Dw/R4Zr0Zeod7yDZNI2TW/tR4GNPGrlhXGwjXF14gQU5O2IpHIMLjl+
         YyjHwLs3kqnxcsLESYCHkiJfoLe5P6/xkQYzaTeloaeCVGFLbs3MT4pX8TpxiuTfqqal
         4yLCkFbNn4sHElnG9FJ1nwZaOkYMF90CeIMpY+m78omiHqm+sHbJzQRjPWrlRHugDBeS
         kG0ZbuRcpiiqjoJC7gGP1O4gS6aOOsZVuBFOzV9PXD20KJ8o+MqukJZq2NKY4FUqLJh+
         UbDA==
X-Gm-Message-State: ANoB5pmwX2jpEBoK6OGLirlapWuHj1A71YPeTmgZodjp9bzwHPIkZNE3
        6HOC6cBnuTxl74SLsxxY7T/Qvg==
X-Google-Smtp-Source: AA0mqf4zM0Xfm3o50FPw1HED00hbjDIYwQEpUTYuG4CSMG/pv2gDG2TkVQ9Z4W/PFOBStf5o5pM4yg==
X-Received: by 2002:a05:6402:2213:b0:46b:1d60:f60a with SMTP id cq19-20020a056402221300b0046b1d60f60amr37331636edb.193.1670346865233;
        Tue, 06 Dec 2022 09:14:25 -0800 (PST)
Received: from localhost ([2a02:8070:6387:ab20:15aa:3c87:c206:d15e])
        by smtp.gmail.com with ESMTPSA id kw25-20020a170907771900b007c0ae8569d6sm1458481ejc.146.2022.12.06.09.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 09:14:24 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mm: memcontrol: deprecate charge moving
Date:   Tue,  6 Dec 2022 18:13:41 +0100
Message-Id: <20221206171340.139790-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206171340.139790-1-hannes@cmpxchg.org>
References: <20221206171340.139790-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Charge moving mode in cgroup1 allows memory to follow tasks as they
migrate between cgroups. This is, and always has been, a questionable
thing to do - for several reasons.

First, it's expensive. Pages need to be identified, locked and
isolated from various MM operations, and reassigned, one by one.

Second, it's unreliable. Once pages are charged to a cgroup, there
isn't always a clear owner task anymore. Cache isn't moved at all, for
example. Mapped memory is moved - but if trylocking or isolating a
page fails, it's arbitrarily left behind. Frequent moving between
domains may leave a task's memory scattered all over the place.

Third, it isn't really needed. Launcher tasks can kick off workload
tasks directly in their target cgroup. Using dedicated per-workload
groups allows fine-grained policy adjustments - no need to move tasks
and their physical pages between control domains. The feature was
never forward-ported to cgroup2, and it hasn't been missed.

Despite it being a niche usecase, the maintenance overhead of
supporting it is enormous. Because pages are moved while they are live
and subject to various MM operations, the synchronization rules are
complicated. There are lock_page_memcg() in MM and FS code, which
non-cgroup people don't understand. In some cases we've been able to
shift code and cgroup API calls around such that we can rely on native
locking as much as possible. But that's fragile, and sometimes we need
to hold MM locks for longer than we otherwise would (pte lock e.g.).

Mark the feature deprecated. Hopefully we can remove it soon.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 Documentation/admin-guide/cgroup-v1/memory.rst | 11 ++++++++++-
 mm/memcontrol.c                                |  4 ++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 60370f2c67b9..87d7877b98ec 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -86,6 +86,8 @@ Brief summary of control files.
  memory.swappiness		     set/show swappiness parameter of vmscan
 				     (See sysctl's vm.swappiness)
  memory.move_charge_at_immigrate     set/show controls of moving charges
+                                     This knob is deprecated and shouldn't be
+                                     used.
  memory.oom_control		     set/show oom controls.
  memory.numa_stat		     show the number of memory usage per numa
 				     node
@@ -717,9 +719,16 @@ Soft limits can be setup by using the following commands (in this example we
        It is recommended to set the soft limit always below the hard limit,
        otherwise the hard limit will take precedence.
 
-8. Move charges at task migration
+8. Move charges at task migration (DEPRECATED!)
 =================================
 
+THIS IS DEPRECATED!
+
+It's expensive and unreliable! It's better practice to launch workload
+tasks directly from inside their target cgroup. Use dedicated workload
+cgroups to allow fine-grained policy adjustments without having to
+move physical pages between control domains.
+
 Users can move charges associated with a task along with task migration, that
 is, uncharge task's pages from the old cgroup and charge them to the new cgroup.
 This feature is not supported in !CONFIG_MMU environments because of lack of
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b696354c1b21..e650a38d9a90 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3919,6 +3919,10 @@ static int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
+	pr_warn_once("Cgroup memory moving is deprecated. "
+		     "Please report your usecase to linux-mm@kvack.org if you "
+		     "depend on this functionality.\n");
+
 	if (val & ~MOVE_MASK)
 		return -EINVAL;
 
-- 
2.38.1

