Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7BC520A12
	for <lists+cgroups@lfdr.de>; Tue, 10 May 2022 02:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiEJAXD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 May 2022 20:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbiEJAW3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 May 2022 20:22:29 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5D328E4D4
        for <cgroups@vger.kernel.org>; Mon,  9 May 2022 17:18:31 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id v10-20020a17090a0c8a00b001c7a548e4f7so398156pja.2
        for <cgroups@vger.kernel.org>; Mon, 09 May 2022 17:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Dj8G52Ku/C8Y7g0RB9bNxhRV9jY61G7LwBKsHFtUSBY=;
        b=T2/IAHh55Gjn5HeBRFdMbJMuKc4A52+bUpWlUzeffogFLw8TTHeFLtYgq22aCDSH0T
         9m4JTdgAoZuuUHr5I3kddwnsxcs8TQAQHDjK0UzNNzDxg/le5nOw/ffd5aukwJ4o5odv
         hqrUXfaotL2uO9PHctmV7H/6ClL+ttTG+dlAwNNowSl/QZnHkF0tmiub103C3Lc+H366
         YaCrxgdzJ1UEE5C+opIeGU7M6jGjOoESS0Kq0WQGfx5CJSHP7FogfGa56LdFw0/8ZBX/
         QYaa6FmxrCLIdWPx0PReW/umNNuLKbGeFGSlAXTWp7OOLAXyLtxRE/8udLP34ZfvVWyw
         p5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Dj8G52Ku/C8Y7g0RB9bNxhRV9jY61G7LwBKsHFtUSBY=;
        b=zqc34HE8iBtEl85Sfx3gEBn4+LdbM9oeosaJURsBQqoACK1eS7XC4qnSEA5qke5wRA
         cChjR15GPEwGd1wIBsPIca2ZQN0gChG4C4fRZtFVqwTZbXnRoqkU8jUImtZyuX3sXST8
         k6RDlvkzZ7IiIs5LZJoQZNoVzJ0czLmljwy4+VrHx0Jai0XTh8vzgAFaz9jig+bIBolP
         6ja+x1ET2Kn7vIWqdKIt0LAVlbjHrCcG2jhhP285ZMUBlt5wdNqjViOZMQPCida5SJ44
         ynnfpchPzelm96wu/AGmdBL7OnWZBj8DmnOiBuPxgoTzJHk2QBEADo2glhuYem/1YQpJ
         Hq0A==
X-Gm-Message-State: AOAM532AeOpc6CGh09v6xZsXlNrdaSjaAxhF7lxDTeuZBKKPf2qju8Ln
        R7Jooh4GPenU/SFA+rt0ey5KLmOswy4aJm4l
X-Google-Smtp-Source: ABdhPJwJDYWCoQr30dyGFQU8Ug2nQEwX5PR9g5M5GMtyX4z/IRwxNHeNkD3NdPQj8xC89ISB2tVjV9cDHDleViKi
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a62:fb0f:0:b0:4f2:6d3f:5ffb with SMTP
 id x15-20020a62fb0f000000b004f26d3f5ffbmr17950305pfm.55.1652141910739; Mon,
 09 May 2022 17:18:30 -0700 (PDT)
Date:   Tue, 10 May 2022 00:18:04 +0000
In-Reply-To: <20220510001807.4132027-1-yosryahmed@google.com>
Message-Id: <20220510001807.4132027-7-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220510001807.4132027-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [RFC PATCH bpf-next 6/9] cgroup: add v1 support to cgroup_get_from_id()
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Stanislav Fomichev <sdf@google.com>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, cgroups@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The current implementation of cgroup_get_from_id() only searches the
default hierarchy for the given id. Make it compatible with cgroup v1 by
looking through all the roots instead.

cgrp_dfl_root should be the first element in the list so there shouldn't
be a performance impact for cgroup v2 users (in the case of a valid id).

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 kernel/cgroup/cgroup.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index af703cfcb9d2..12700cd21973 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5970,10 +5970,16 @@ void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
  */
 struct cgroup *cgroup_get_from_id(u64 id)
 {
-	struct kernfs_node *kn;
+	struct kernfs_node *kn = NULL;
 	struct cgroup *cgrp = NULL;
+	struct cgroup_root *root;
+
+	for_each_root(root) {
+		kn = kernfs_find_and_get_node_by_id(root->kf_root, id);
+		if (kn)
+			break;
+	}
 
-	kn = kernfs_find_and_get_node_by_id(cgrp_dfl_root.kf_root, id);
 	if (!kn)
 		goto out;
 
-- 
2.36.0.512.ge40c2bad7a-goog

