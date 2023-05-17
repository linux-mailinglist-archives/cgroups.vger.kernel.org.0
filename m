Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E35706B8C
	for <lists+cgroups@lfdr.de>; Wed, 17 May 2023 16:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbjEQOtZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 May 2023 10:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjEQOtY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 May 2023 10:49:24 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F135140C0;
        Wed, 17 May 2023 07:49:23 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-338335fe6d0so4258415ab.1;
        Wed, 17 May 2023 07:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684334963; x=1686926963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f05y9R3Fl6VbAlQDanAd2cha5Cf54wSBkc374UYz9UI=;
        b=bcV6hwSN/0UMrTECo6qVNLbcumprmfyioJE1mNkB4ZvaLkYCkIocelHX5SOEgYsMXy
         4qohG/wVVQqGw+ecK8qY4Fy8IUXu264edouOtmhBZPY/71Fu3QLqaWfhSP3TcKcQF+In
         ZO0mFghri6ezRm/oh0xOPXiR7FwL2bxHsWI25CcSeWyMwi/LdiWcisGKAXw+Xnq09mvP
         8lzLtMvMEUOQm2xLIdJZdzNQJZR6D2b2F64LumxbPfun64507uFbXaDIIJPE9PDxSFNZ
         +wfoK44iT56GTZxcV4/eUadsFzr09t6Wt4aFaPfQfz655XkMQiTC6ixOHuxsCI6Vzagc
         vLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684334963; x=1686926963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f05y9R3Fl6VbAlQDanAd2cha5Cf54wSBkc374UYz9UI=;
        b=YZqVMYAkaFFJE57OQV8dfs1NPpc24aVX658PDGGUmRPKSTaGfmXIg+xZSx4ij8oyXH
         eknC/UXihP2vgjeYaTczxbXDmyTycgGSQ2Cri/fk7HjJp7bKjST9kxu7mrW0zH8mfZGz
         6AdBijPvXj1y6v89hDvvwAzzGsy2kl+MctLcZjXZjaFVqNLu0kSnJm/RyjsdFYS9Geau
         ZYrWwzJjqIZuZ0gNRiJshx6mToVoZ6cDIv4a07U4VOV3ab/W+vupSb8o337CjDnHzFHY
         oPkBCZ6QbSXuNIWrlg3gniVqyCA8YYmR08g3F50vuXzSsR6ASfGZXN1Gk/rWeQSpuoB6
         FcAQ==
X-Gm-Message-State: AC+VfDwTeIBpkovE2yixqvNbc7K6569flLCG1ytS2qUVwfwuWmV0oUh+
        rYJrcmfkK/Igfhh7dXXAyYLNN7vC3ScWLQ==
X-Google-Smtp-Source: ACHHUZ5PNwtFgZ4TY7EG85CA8qH2DfYwiCJMnE4oFcAfjtFgIfd/LUSDC6uiZ1KAuZ3Wd6kntCwSLA==
X-Received: by 2002:a92:c6cf:0:b0:32a:b78f:e7d5 with SMTP id v15-20020a92c6cf000000b0032ab78fe7d5mr2242319ilm.27.1684334963225;
        Wed, 17 May 2023 07:49:23 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id 18-20020a92c652000000b00335717785ecsm5925900ill.63.2023.05.17.07.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 07:49:22 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cgroup: Replace all non-returning strlcpy with strscpy
Date:   Wed, 17 May 2023 14:49:10 +0000
Message-ID: <20230517144910.1521547-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 kernel/cgroup/cgroup-v1.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index aeef06c465ef..d55216c4cc2d 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -563,7 +563,7 @@ static ssize_t cgroup_release_agent_write(struct kernfs_open_file *of,
 	if (!cgrp)
 		return -ENODEV;
 	spin_lock(&release_agent_path_lock);
-	strlcpy(cgrp->root->release_agent_path, strstrip(buf),
+	strscpy(cgrp->root->release_agent_path, strstrip(buf),
 		sizeof(cgrp->root->release_agent_path));
 	spin_unlock(&release_agent_path_lock);
 	cgroup_kn_unlock(of->kn);
@@ -797,7 +797,7 @@ void cgroup1_release_agent(struct work_struct *work)
 		goto out_free;
 
 	spin_lock(&release_agent_path_lock);
-	strlcpy(agentbuf, cgrp->root->release_agent_path, PATH_MAX);
+	strscpy(agentbuf, cgrp->root->release_agent_path, PATH_MAX);
 	spin_unlock(&release_agent_path_lock);
 	if (!agentbuf[0])
 		goto out_free;

