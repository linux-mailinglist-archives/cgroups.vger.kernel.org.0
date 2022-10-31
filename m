Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25C9613C5A
	for <lists+cgroups@lfdr.de>; Mon, 31 Oct 2022 18:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiJaRlg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Oct 2022 13:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiJaRlW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Oct 2022 13:41:22 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D0913D67;
        Mon, 31 Oct 2022 10:41:10 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o7so7789985pjj.1;
        Mon, 31 Oct 2022 10:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LQXGndXpyfnn1/1I0XRemNKGO75fMj5OZBqMxSooCo=;
        b=VN0Qli60LvocYqr7xbaQSmrbSHY0rO8Eu/3MOFLouf76aeQakPt2NiDIuondE0WdVc
         HWYqaKOVvc6+UYaz2srlHEuzMgmn0yN36pfgi4tNLuVVCf99edLigZ2ISQZ4O/ZMgDhG
         nz/KqIb4d60ivDCoD5i2VU1y/gcphkIyUlM5IvZH0omBe533hsojAUc57MRnupvOYID2
         g/nVfcWSKxKgRMC6dpem/zCl1gZBbDDo7gTCL+odB+5ZdR2bUD5ltjpWx8c4N8TMufhc
         rw3sV0a67BF8nLdxK42QtBbFeCPnoIkz+wB+YRBa1jB/0cmSDLtn+6bZJnDiZxX23F58
         c46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LQXGndXpyfnn1/1I0XRemNKGO75fMj5OZBqMxSooCo=;
        b=mu1odKg6TiA818KnCj5fmBDsCvo+yZLaTWym8NPm3fi72HXjc79IeUDtCyAKKFXT/K
         EKCY7WTHoDz91HFos8NT9p/LKdaArJ3t4/oGMXlTn4XHPBgr2OZN2t5NtVgd1hBKhhRD
         Ktjjsl4aeBAh8K+wzFN5N1qStUcnnsc7suAS1ZSstRKfoDe68y6nCYQvAc4ZeaAqoKuk
         lGxdfiAfZTD7qnFvobRMoGrCFZoYD4ZRT+mfg8Lk1lqwSCJbozpWcy4YdI3kp/OSDOQG
         9tqZmVd08HmEt77Sg1TvX5+ngdxyjxGJ2ICbadvIqktsF6tF0KHYc7+30OhsRQ03c7tg
         uX2A==
X-Gm-Message-State: ACrzQf0No2+i2KhjX6pIDzBY238e4QH6T1Lta0WaHf9+moiYOVDmJcjh
        N2E37JvBBkb5SEFr08Dgv3B+8xxQMJM=
X-Google-Smtp-Source: AMsMyM4LWC7x9iiWnK96vJR7quMt6Bu3yqI/iqvtrhVg3w9kfUprp8B+Ga/CrT7KnIwJYUG8Bv3fWw==
X-Received: by 2002:a17:902:9b8e:b0:187:30ec:67dd with SMTP id y14-20020a1709029b8e00b0018730ec67ddmr1719367plp.79.1667238070120;
        Mon, 31 Oct 2022 10:41:10 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:ba13])
        by smtp.gmail.com with ESMTPSA id 1-20020a17090a0f0100b00205fafa6768sm4547766pjy.6.2022.10.31.10.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 10:41:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 31 Oct 2022 07:41:08 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: [PATCH cgroup/for-6.1-fixes] cgroup: cgroup refcnt functions should
 be exported when CONFIG_DEBUG_CGROUP_REF
Message-ID: <Y2AItI25gZ5MX6Nk@slm.duckdns.org>
References: <Y1w9EKH/CZhNGLJj@slm.duckdns.org>
 <Y1xGfJGIDIMKrMa7@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1xGfJGIDIMKrMa7@slm.duckdns.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From 79a7f41f7f5ac69fd22eaf1fb3e230bea95f3399 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Mon, 31 Oct 2022 07:12:13 -1000

6ab428604f72 ("cgroup: Implement DEBUG_CGROUP_REF") added a config option
which forces cgroup refcnt functions to be not inlined so that they can be
kprobed for debugging. However, it forgot export them when the config is
enabled breaking modules which make use of css reference counting.

Fix it by adding CGROUP_REF_EXPORT() macro to cgroup_refcnt.h which is
defined to EXPORT_SYMBOL_GPL when CONFIG_DEBUG_CGROUP_REF is set.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: 6ab428604f72 ("cgroup: Implement DEBUG_CGROUP_REF")
---
The previous patch forgot to add symbol exports for modules when the refcnt
functions are forced !inline which broke module builds. Applying to
cgroup/for-6.1-fixes.

Thanks.

 include/linux/cgroup.h        | 1 +
 include/linux/cgroup_refcnt.h | 6 ++++++
 kernel/cgroup/cgroup.c        | 1 +
 3 files changed, 8 insertions(+)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 5c9c07a44706..c8441090ca4c 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -318,6 +318,7 @@ void css_put(struct cgroup_subsys_state *css);
 void css_put_many(struct cgroup_subsys_state *css, unsigned int n);
 #else
 #define CGROUP_REF_FN_ATTRS	static inline
+#define CGROUP_REF_EXPORT(fn)
 #include <linux/cgroup_refcnt.h>
 #endif
 
diff --git a/include/linux/cgroup_refcnt.h b/include/linux/cgroup_refcnt.h
index 1aa89295dac0..2eea0a69ecfc 100644
--- a/include/linux/cgroup_refcnt.h
+++ b/include/linux/cgroup_refcnt.h
@@ -10,6 +10,7 @@ void css_get(struct cgroup_subsys_state *css)
 	if (!(css->flags & CSS_NO_REF))
 		percpu_ref_get(&css->refcnt);
 }
+CGROUP_REF_EXPORT(css_get)
 
 /**
  * css_get_many - obtain references on the specified css
@@ -24,6 +25,7 @@ void css_get_many(struct cgroup_subsys_state *css, unsigned int n)
 	if (!(css->flags & CSS_NO_REF))
 		percpu_ref_get_many(&css->refcnt, n);
 }
+CGROUP_REF_EXPORT(css_get_many)
 
 /**
  * css_tryget - try to obtain a reference on the specified css
@@ -43,6 +45,7 @@ bool css_tryget(struct cgroup_subsys_state *css)
 		return percpu_ref_tryget(&css->refcnt);
 	return true;
 }
+CGROUP_REF_EXPORT(css_tryget)
 
 /**
  * css_tryget_online - try to obtain a reference on the specified css if online
@@ -61,6 +64,7 @@ bool css_tryget_online(struct cgroup_subsys_state *css)
 		return percpu_ref_tryget_live(&css->refcnt);
 	return true;
 }
+CGROUP_REF_EXPORT(css_tryget_online)
 
 /**
  * css_put - put a css reference
@@ -74,6 +78,7 @@ void css_put(struct cgroup_subsys_state *css)
 	if (!(css->flags & CSS_NO_REF))
 		percpu_ref_put(&css->refcnt);
 }
+CGROUP_REF_EXPORT(css_put)
 
 /**
  * css_put_many - put css references
@@ -88,3 +93,4 @@ void css_put_many(struct cgroup_subsys_state *css, unsigned int n)
 	if (!(css->flags & CSS_NO_REF))
 		percpu_ref_put_many(&css->refcnt, n);
 }
+CGROUP_REF_EXPORT(css_put_many)
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index f786c4c973a0..f2743a476190 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -250,6 +250,7 @@ static int cgroup_addrm_files(struct cgroup_subsys_state *css,
 
 #ifdef CONFIG_DEBUG_CGROUP_REF
 #define CGROUP_REF_FN_ATTRS	noinline
+#define CGROUP_REF_EXPORT(fn)	EXPORT_SYMBOL_GPL(fn);
 #include <linux/cgroup_refcnt.h>
 #endif
 
-- 
2.38.0

