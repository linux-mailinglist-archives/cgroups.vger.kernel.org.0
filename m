Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3ED353A15
	for <lists+cgroups@lfdr.de>; Mon,  5 Apr 2021 00:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhDDWcl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 4 Apr 2021 18:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhDDWck (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 4 Apr 2021 18:32:40 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEE7C061756
        for <cgroups@vger.kernel.org>; Sun,  4 Apr 2021 15:32:35 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id g24so7351023qts.6
        for <cgroups@vger.kernel.org>; Sun, 04 Apr 2021 15:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:84;0;0cto;
        bh=SN4VFWPC+wyT3rAIlOFAZrVOzwF1f5acphi1J3LvQE4=;
        b=IcxlWit8/x/S9P/7qVO3qYhsEBUtBlcNWYvDi9nd27E/reKm+n/IP139Q3c/CDGzi0
         Y+U0crP/86CKn2RQW3PWLEnCrs60J0Zbe/s1sAD+HldgpTPoh6RSvTHXayc6WtCXcTCK
         eUGmhJe/zG20v9fqhZY1NxcexG0tFPrkFplpmkuO1dC3Ne+7UdCNptkEcKUnvDkwNmzQ
         do75If8L2N+8xydA5cYJgAuqBDDMnAsxHm+8XVJaLUyNQf8GirA5THfaYU7p7Gmhp6Uz
         6Hj0kEfWuh5fnoIdwtJYB0Gu9X2DQosKLgIPBV0+qJUMn58aaW1ISXjHaP+QZ/uZjV4+
         RKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:84;0;0cto;
        bh=SN4VFWPC+wyT3rAIlOFAZrVOzwF1f5acphi1J3LvQE4=;
        b=DpFQGQvAo7gHmXbyylapkJ2FfOrOBt8SfKkWVb/0gMWsFTzpXr0Xg9W7eh+2uKQm7g
         kdiOE7WiRrzamLZrr95b6CTCXAC6F+ajvIec/dx6Wei4swoLs5oy4PgqBDBIwxH4BnqI
         PklDoTL5tgTqvpCtdDQzzFWM/8uZrO83VDizWdMa15wV3Bp+tIIxbjWlButxQQQXjT1E
         +3tTqPKYVbRvofmqy1VplFJPuKZT2/LmnoIhucDSdTHbj1TFvq5v6+lmYWlbDzWDjCH2
         CKIoPCF/M2wjo7vuUdwtgQl2qCiJ3za/Rw7rNKDJF7v+EA+QSDsO6Zx6rEGSyUa8qb2n
         oG/Q==
X-Gm-Message-State: AOAM532uPIUB480KBFE30FaiFlzs/t+IENsDqpjV88zAORF9fpKnHYgh
        bqpMECqt+ckYWoPjxGEvREQ=
X-Google-Smtp-Source: ABdhPJw7hve2Bl2KHx8aO7dbXn3a0CDMkSXKhtDUxkOsEtUjwtb5W0szLO+A2BOQnLJ/z6+z+WSxuw==
X-Received: by 2002:a05:622a:1701:: with SMTP id h1mr19104342qtk.86.1617575554031;
        Sun, 04 Apr 2021 15:32:34 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id e3sm12879193qkn.99.2021.04.04.15.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 15:32:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 4 Apr 2021 18:32:31 -0400
From:   Tejun Heo <tj@kernel.org>
Cc:     Vipin Sharma <vipinsh@google.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, cgroups@vger.kernel.org,
        David Rientjes <rientjes@google.com>
Subject: Re: [cgroup:for-next 3/3] include/linux/misc_cgroup.h:98:15:
 warning: no previous prototype for function 'misc_cg_res_total_usage'
Message-ID: <YGo+f3XoA4CtRAPt@mtj.duckdns.org>
References: <202104050523.t4Om6TmY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202104050523.t4Om6TmY-lkp@intel.com>
84;0;0cTo: kernel test robot <lkp@intel.com>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Applied the following patch to cgroup/for-5.13.

Thanks.
----- 8< -----
From dd3f4e4972f146a685930ccfed95e4e1d13d952a Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Sun, 4 Apr 2021 18:29:37 -0400
Subject: [PATCH] cgroup: misc: mark dummy misc_cg_res_total_usage() static
 inline

The dummy implementation was missing static inline triggering the following
compile warning on llvm.

   In file included from arch/x86/kvm/svm/sev.c:17:
>> include/linux/misc_cgroup.h:98:15: warning: no previous prototype for function 'misc_cg_res_total_usage' [-Wmissing-prototypes]
   unsigned long misc_cg_res_total_usage(enum misc_res_type type)
                 ^
   include/linux/misc_cgroup.h:98:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   unsigned long misc_cg_res_total_usage(enum misc_res_type type)
   ^
   static
   1 warning generated.

Add it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
---
 include/linux/misc_cgroup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index c5af592481c0..da2367e2ac1e 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -95,7 +95,7 @@ static inline void put_misc_cg(struct misc_cg *cg)
 
 #else /* !CONFIG_CGROUP_MISC */
 
-unsigned long misc_cg_res_total_usage(enum misc_res_type type)
+static inline unsigned long misc_cg_res_total_usage(enum misc_res_type type)
 {
 	return 0;
 }
-- 
2.31.1

