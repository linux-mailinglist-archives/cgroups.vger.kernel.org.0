Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116F45FBDF8
	for <lists+cgroups@lfdr.de>; Wed, 12 Oct 2022 00:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiJKWwB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Oct 2022 18:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJKWwA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Oct 2022 18:52:00 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA84367164
        for <cgroups@vger.kernel.org>; Tue, 11 Oct 2022 15:51:58 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id q62-20020a17090a17c400b0020d334fbe19so172923pja.0
        for <cgroups@vger.kernel.org>; Tue, 11 Oct 2022 15:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XusyGq/BtMQpus8wnubVaoCLzcnzByi/X6aLyv7q1P0=;
        b=UlX7ihEkCl9FTBOFGfPO3DjyEi8CbSe6MA2faSMYt79GLuSxcIOtuzUSEFmFkHCPYh
         gi7YM1+Nt+S5BAVbQvLteUDGKHWYm03X6cCGqMHwq7pv2G85gNAdFTiS77dnLorKJ1f6
         nYqCJ+6PS3v5vJ9YPhfBWZ94wmXD01ITcD2kdxwtyIWriAd2itVtC7Ig/JdhFbyErTe9
         ZHhCGmy9Pi/DwtUnITIdz86i0G4SjZIfe599rMN5YW1SpazJSg3G4t/2kqFRouwhSa8f
         9Wr8bWO6+LF96EpW1TT9pJbuISKI9P12B7iyro72q13+yU3cPqym7NizIvJ046Qax/Qb
         cyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XusyGq/BtMQpus8wnubVaoCLzcnzByi/X6aLyv7q1P0=;
        b=VMjvy8pnwIJvM7SMt41teRyvx9ZZpmTaU3G8NoSBwNqGw56umi39J+aPr8Idstm+Nr
         38LzvxjUIulbL2gURvxANLOBOCk78dCpEE9O9K32NvqL34m4HY1x6KEpYnJSn8BRc9NL
         3gNqamPJqfI4Il4ymwd0MdJK8pMMK5PbKP2Aa7P6P2agxQPRrU50YhXflSJmwRQyK4LJ
         ggshcjpR8uAp2Jmfe7YYdI6ioRrNcOZ+qzjRESEqf5AwAFjCzviAHQDUM8bERgcLIWka
         ad6NI7qgM6c4/x2O6mNkCoCXAs55CAq0KG+nErCGvgtkkg6+sHrPuD8WwtndntvD6uz3
         WXpA==
X-Gm-Message-State: ACrzQf1+o7RpFZl8PC5dCggIUbLDrC4SUlzlnToHHOVIC5gh8ZBdECEM
        Vi8lT1NXTutxqiqt4FC1GdmW6o1tQC6xKTQx
X-Google-Smtp-Source: AMsMyM7BbZniYAkhXHjl+6EW/unOoIqSD0+K1jLc1Zwy4q0lNdSkkSR5TfuTFzWgjoCHzU3+UyoNLsubxOdef7jC
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:903:1211:b0:178:9353:9e42 with SMTP
 id l17-20020a170903121100b0017893539e42mr26440622plh.45.1665528718016; Tue,
 11 Oct 2022 15:51:58 -0700 (PDT)
Date:   Tue, 11 Oct 2022 22:51:55 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221011225155.4055415-1-yosryahmed@google.com>
Subject: [PATCH cgroup/for-6.1-fixes] mm: cgroup: fix comments for get from
 fd/file helpers
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Fix the documentation comments for cgroup_[v1v2_]get_from_[fd/file]().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
I cannot reproduce the warning so I cannot make sure it's fixed by this.

Again, apologies for missing updating the comment in the first place.
---
 kernel/cgroup/cgroup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 6349a9fe9ec1..d922773fa90b 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6246,6 +6246,7 @@ static struct cgroup *cgroup_v1v2_get_from_file(struct file *f)
 /**
  * cgroup_get_from_file - same as cgroup_v1v2_get_from_file, but only supports
  * cgroup2.
+ * @f: file corresponding to cgroup2_dir
  */
 static struct cgroup *cgroup_get_from_file(struct file *f)
 {
@@ -6753,7 +6754,7 @@ struct cgroup *cgroup_get_from_path(const char *path)
 EXPORT_SYMBOL_GPL(cgroup_get_from_path);
 
 /**
- * cgroup_get_from_fd - get a cgroup pointer from a fd
+ * cgroup_v1v2_get_from_fd - get a cgroup pointer from a fd
  * @fd: fd obtained by open(cgroup_dir)
  *
  * Find the cgroup from a fd which should be obtained
@@ -6778,6 +6779,7 @@ struct cgroup *cgroup_v1v2_get_from_fd(int fd)
 /**
  * cgroup_get_from_fd - same as cgroup_v1v2_get_from_fd, but only supports
  * cgroup2.
+ * @fd: fd obtained by open(cgroup2_dir)
  */
 struct cgroup *cgroup_get_from_fd(int fd)
 {
-- 
2.38.0.rc1.362.ged0d419d3c-goog

