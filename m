Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CBF5AF1FF
	for <lists+cgroups@lfdr.de>; Tue,  6 Sep 2022 19:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbiIFRLg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Sep 2022 13:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240148AbiIFRJ3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Sep 2022 13:09:29 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110432186;
        Tue,  6 Sep 2022 09:58:29 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id w63so2704191pgb.7;
        Tue, 06 Sep 2022 09:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date;
        bh=dyT2g59rUzulB+5aRGJcwTyIEc/5vl4B4tRvr2YBao4=;
        b=NfbjvVMxPPL7Dy613X81VrnkQmnmjHUtnljibbjjtpTvw9wvfljsZw5JSjDsxdaB8K
         WU4wUYSV50CRpMj5k/n0BYFscvLZWYkqcG7TeArCU85/Co+VjMEj6XSZhknRUmggElDB
         p0n5uVQl6z4Xvqx5V4nBG7iwfNq29Wx8dAF8cH53rtLsVCOpRUB/i1sxvOdIXp9XimXK
         GFRWkwrEwcDGPwCr37vthmcvu2NDvzFLHuB/SiFfC2C9DqD6rGUPAxntv8gaObjpTS7b
         HoDomdGTOnPNdcRK3Jr9Y4aCFXhY2/nUgt9brp/jhDRXRsO1EfAjf2L3xhVWCePjRlfe
         TS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=dyT2g59rUzulB+5aRGJcwTyIEc/5vl4B4tRvr2YBao4=;
        b=pjBNIrEzV1niV7u99kU0yBjdpSxwd/DRreBT8CFgGZCK8oIKLJFnSai9QG5GrfohFm
         LzlY+0WkTFUifFVnPSe5QFDKKRmSR7gIoMH9cTGFcXPMHZaNxz9PTLrdIEHQ96BES+QA
         A0RtC875bjzHmhpI7wI6KLHaT61qikfvge3SP6figsLI3rsBlZYCtp3e2iOUBQmClljV
         rTcTTo6xFYnhmlPx7P68aAYdJveY0ngSYsmmtkZkqzVDTWgsXwwLvIYDKX7qOqdqWARD
         ZmehZ6Edad3X8KgSpMInkM2znfb4f+wrKOPsKb70l4EAA7EbGjMj8oYq6Ndl6BsrZyQF
         Zxlw==
X-Gm-Message-State: ACgBeo2Fm3RR4nLo3Jqj0OcVvOGBZtdnoUD/GDzRFyXcEWpT5ZVHginR
        rwp1oN69TSbOPLu2Yc+iaaeBkFBNKp4=
X-Google-Smtp-Source: AA6agR5vtSP8ZqKMGMUDDMOtCISEty6QH2BzmD2PcJKmjuPExQEy2OuWN/d1+gOIF9+BmTd2cwotow==
X-Received: by 2002:a63:2c47:0:b0:434:4bb3:de35 with SMTP id s68-20020a632c47000000b004344bb3de35mr10060159pgs.444.1662483508006;
        Tue, 06 Sep 2022 09:58:28 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id v63-20020a622f42000000b0053e20a0333fsm2318318pfv.93.2022.09.06.09.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:58:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 6 Sep 2022 06:58:25 -1000
From:   Tejun Heo <tj@kernel.org>
To:     cgroups@vger.kernel.org
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH cgroup/for-6.0-fixes] cpuset: Add Waiman Long as a cpuset
 maintainer
Message-ID: <Yxd8MUTOPbxvZVOk@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Waiman has been very active with cpuset recently and I've been cc'ing him
for cpuset related changes for a while now. Let's make him a cpuset
maintainer.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Waiman Long <longman@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d30f26e07cd3..336bf8b97123 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5245,6 +5245,7 @@ F:	block/blk-throttle.c
 F:	include/linux/blk-cgroup.h
 
 CONTROL GROUP - CPUSET
+M:	Waiman Long <longman@redhat.com>
 M:	Zefan Li <lizefan.x@bytedance.com>
 L:	cgroups@vger.kernel.org
 S:	Maintained
-- 
2.37.3

