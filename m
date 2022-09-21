Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40B35BFB13
	for <lists+cgroups@lfdr.de>; Wed, 21 Sep 2022 11:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiIUJfX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Sep 2022 05:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiIUJfW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Sep 2022 05:35:22 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009C182D31;
        Wed, 21 Sep 2022 02:35:21 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id v1so5050483plo.9;
        Wed, 21 Sep 2022 02:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=EhnBpCpoeRYQHc027CvFJhCGZMSO3kz4CSNF4MCSNW0=;
        b=kVgHRrSzTLNMS7eqZGl2QTHvGOioL1m/DacQIY37AIn5NlUE+7WtjZL2IOapjMEv7t
         9eGAUGhzhwvg5i21Sv6uCQOfBv84TV9JJ9TS3gPAyojcOFP9xMjN0t5tYEx3aQX+YxZW
         lroMzn6Go11/EeSOOR8I1wUlbnVg+bzLfK0lSOPSJXtqrTlzv/uejD03/l40ulBM/Gru
         XAObuW4umiyFXBSL9IcS/xu+RzEuAE7uZXcRZSxoODMN4CgyR95hiZGDnsBZCi8br7Wx
         10C8rUAS4X+GFPE7RbmHrNIb9uR2du0+/7Ewp8Rrho2MQq73GsDv3K8FoPrJtD0wYpRu
         zQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=EhnBpCpoeRYQHc027CvFJhCGZMSO3kz4CSNF4MCSNW0=;
        b=FCZTfDQc4iFjOrE49Sz14ZqKzTU6f2OKtSaQrx0bjUYyd1cFWNsJhHRNHAQ99EdGsZ
         8dqXGjEiIQeCC7A/AUJHOB2B2//out05Xvu2NbwC45VnAZiDfMV99u5RedsDVbJS41hQ
         0cfDYvn20adqaCFf1iIeLMEu1gHc0LULjF2/aJHTc5fdQitEsw+TUiTqkwTTj52geEBl
         z1WUNfmlk9tneLt6tkC2+uSYBe6NAW0e0UFE69lyKp/V5Zhkgih9UAmSYgdYY5wH/WNM
         yX2QOIZoS1QGETlDYs2BsfxzE/xYYzu9Kk3zBbVWv1KMeiSUI7WYy7ocCdC4+5uwJVzH
         8k4g==
X-Gm-Message-State: ACrzQf2+ErCf7WhI/MeMMBZh5Qfm1gZvrQdCKBdzkaJqaOmMr0rz1o6J
        qKPGElzwZgiqnND7WN7oH3E=
X-Google-Smtp-Source: AMsMyM6sznCwBf5tSLVKL+x7mLR4EfcL3gD/X9uZO6evzhZrAg0sEHyGNQOekZs6DjGiFXs/lSxd+g==
X-Received: by 2002:a17:902:f54a:b0:176:c443:e885 with SMTP id h10-20020a170902f54a00b00176c443e885mr3865592plf.28.1663752921558;
        Wed, 21 Sep 2022 02:35:21 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d6-20020a170903230600b001767f6f04efsm1528682plh.242.2022.09.21.02.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:35:21 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     tj@kernel.org
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>
Subject: [PATCH linux-next] cgroup: use strscpy() is more robust and safer
Date:   Wed, 21 Sep 2022 09:35:17 +0000
Message-Id: <20220921093517.230745-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

The implementation of strscpy() is more robust and safer.

That's now the recommended way to copy NUL terminated strings.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 829aa42e773e..48a8e8fb3e91 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2374,7 +2374,7 @@ int task_cgroup_path(struct task_struct *task, char *buf, size_t buflen)
 		ret = cgroup_path_ns_locked(cgrp, buf, buflen, &init_cgroup_ns);
 	} else {
 		/* if no hierarchy exists, everyone is in "/" */
-		ret = strlcpy(buf, "/", buflen);
+		ret = strscpy(buf, "/", buflen);
 	}
 
 	spin_unlock_irq(&css_set_lock);
-- 
2.25.1
