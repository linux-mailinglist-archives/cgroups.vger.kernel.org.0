Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0228D649023
	for <lists+cgroups@lfdr.de>; Sat, 10 Dec 2022 19:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiLJSdQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 10 Dec 2022 13:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJSdP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 10 Dec 2022 13:33:15 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A8310FEA;
        Sat, 10 Dec 2022 10:33:13 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id s7so8112789plk.5;
        Sat, 10 Dec 2022 10:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=erjJZ3BPLuF4fh5E96B8USxD9G40KMRBirufYCK/yho=;
        b=m87yCXDKsTffULppu3iMrVZ6qDGYyGYS8EBcgLw4eBJkmuxFpBVOL+7JEw4XErKQGC
         vLtJw+xsdY5BZlrCtOvEQGtNbgh7czgcay3iDqkEGsbY4qDA6JAhhC2RiQiGf63eUABC
         p9+USAbJEUvcTLi71QGdGxt+iPBTZorJbWqNoxIguBi8PAHdHsS1LV+Ib0F4XuB/96Fu
         8yUp988BD3BKPfsWqy4viBsrVQe6N010fxyG8HGst1vYlbmeW/qSYikPO0cUhHobDrDO
         hFAvxy0vvncTEfbkphhPsS0ZkUBk0i0VcT20KQsFijHFyxfG8rtA7mEhMXuDiPy24wFs
         N1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=erjJZ3BPLuF4fh5E96B8USxD9G40KMRBirufYCK/yho=;
        b=RnlBDRFGbyRfzHT5+gJTMpqPSsfPVxwoJWc08TbJneCGFogZCEJ3B6W8CyouVTT8XN
         0nXvoHvHbNBgQ+SHr3pghDAtaGEAsf/jM5HRQrhrB+EzqLNo8PnvMgt7cfLpfRZerH0k
         TVAD/39U0uZV4T3xLwgitAvmpLzySrOD7PV+yvlM+up7BN6Hc5qxvSqDBiBiAQ3AKTUE
         fZsJMB9CUclJ/LyCAadgKlUtJlQbO/SUPK6tdRXDlCceV9v17+EsAKvyzVBs+AFqt3qz
         e+81Wxg/tIJcjluZFrPxmocDBZvQJYmqei9NIEp1onJAZpQb7i4aFW62TUl29i4zAzEf
         Tebw==
X-Gm-Message-State: ANoB5pnBqCIU/uB0HAswcYdXpbVYIpo9Hq+KdZWVv1dQeKs8TZZASl15
        LAbooYmKKjT+xQyhY+v/Xuvn2Zemc3gPbw==
X-Google-Smtp-Source: AA0mqf7IM/h/sKpCbZ5v9LMPJBptNljSVRd+DB/beyA2pSYIvoWdAuZWxxlsqtPH9n99+jqe2zXwHQ==
X-Received: by 2002:a17:903:138a:b0:189:5f5c:da1f with SMTP id jx10-20020a170903138a00b001895f5cda1fmr10668384plb.5.1670697192213;
        Sat, 10 Dec 2022 10:33:12 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id jj12-20020a170903048c00b0018996404dd5sm3284296plb.109.2022.12.10.10.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 10:33:11 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 10 Dec 2022 08:33:10 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        darklight2357@icloud.com, Josef Bacik <josef@toxicpanda.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        cgroups@vger.kernel.org
Subject: [PATCH 1/2 block/for-6.2] blk-iolatency: Fix memory leak on
 add_disk() failures
Message-ID: <Y5TQ5gm3O4HXrXR3@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When a gendisk is successfully initialized but add_disk() fails such as when
a loop device has invalid number of minor device numbers specified,
blkcg_init_disk() is called during init and then blkcg_exit_disk() during
error handling. Unfortunately, iolatency gets initialized in the former but
doesn't get cleaned up in the latter.

This is because, in non-error cases, the cleanup is performed by
del_gendisk() calling rq_qos_exit(), the assumption being that rq_qos
policies, iolatency being one of them, can only be activated once the disk
is fully registered and visible. That assumption is true for wbt and iocost,
but not so for iolatency as it gets initialized before add_disk() is called.

It is desirable to lazy-init rq_qos policies because they are optional
features and add to hot path overhead once initialized - each IO has to walk
all the registered rq_qos policies. So, we want to switch iolatency to lazy
init too. However, that's a bigger change. As a fix for the immediate
problem, let's just add an extra call to rq_qos_exit() in blkcg_exit_disk().
This is safe because duplicate calls to rq_qos_exit() become noop's.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: darklight2357@icloud.com
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Fixes: d70675121546 ("block: introduce blk-iolatency io controller")
Cc: stable@vger.kernel.org # v4.19+
---
Hello,

I'm posting two patches for the iolatency memory leak issue after add_disk()
failure. This one is the immediate fix and should be really safe. However,
any change has risks and given that the bug being address is not critical at
all, I still think it'd make sense to route it through 6.2-rc1 rather than
applying directly to master for 6.1 release. So, it's tagged for the 6.2
merge window.

Thanks.

 block/blk-cgroup.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -33,6 +33,7 @@
 #include "blk-cgroup.h"
 #include "blk-ioprio.h"
 #include "blk-throttle.h"
+#include "blk-rq-qos.h"
 
 /*
  * blkcg_pol_mutex protects blkcg_policy[] and policy [de]activation.
@@ -1322,6 +1323,7 @@ err_unlock:
 void blkcg_exit_disk(struct gendisk *disk)
 {
 	blkg_destroy_all(disk);
+	rq_qos_exit(disk->queue);
 	blk_throtl_exit(disk);
 }
 
