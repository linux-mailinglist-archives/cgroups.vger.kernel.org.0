Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB04A0D46
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 00:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfH1WGL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Aug 2019 18:06:11 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40534 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfH1WGL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Aug 2019 18:06:11 -0400
Received: by mail-qk1-f195.google.com with SMTP id f10so1195356qkg.7;
        Wed, 28 Aug 2019 15:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=77lPCJVMbm2iaN6uswmaTozVPtpjzTspO9i1Ih4UGx0=;
        b=lkuKDlvcQJNAPDyWqh7z64PzAcgiPoVACIt2kCEHwITSzvm4646qx3UMoaXftENKBP
         qLyFOZlWg14FxVymoH+uPbQl5Gnj4yAngGhap+ZB4Fye+TKJ5t9O9oP3sOU0ECzPLIOu
         wxBCfu1/n/dbUAViCv+xm4hkJguZeixMibUkeKzeq++SwfncBv9StsMNCnbev2XjWe8s
         s+aivSvYkDNyXnvuS80dFmkhr36IlGtUhus4hZmcE4BNJGEROllypy8x7eOngTefjfPV
         NtY5z2iL8XeBKR+WnmNvi5CAGSiOehrdsB49BDNYDXU7nwVWydGk6Zc/AFGP+5IcHCPw
         q23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=77lPCJVMbm2iaN6uswmaTozVPtpjzTspO9i1Ih4UGx0=;
        b=UiKcRkA1+LVWqJvMI2BV/f5g6HbKIirZTg3+JavqPgAivwbSjvkBNXOmt7FRn23gwz
         /TeCfJ5blSkl7iTTUAExclk/M2RWJ9NLlUV8kQB8Sy3NsrEf3vcMKSMjG77jtUBJr35Q
         QKhL8bHxmYjsKXXXhRect/n1zQvxnNKvZqjvD2jUHV5OWJK6qLVve9zVX08tM7FJchEa
         ecLxC54nyoLDk3uIHo70QWxabRPOw6tiXqLknbmKVeV+3w/P1mjiYipMTQZZfy6OaUko
         A00Y9RVjXlREovIvuIK6/Ou/s50Sah4PgB6Pc8fB895SNZ2Zi6nTFcyth5uwECnf2uQa
         vGjA==
X-Gm-Message-State: APjAAAWOOaO+GhDFj28+fKYoZdSm2Wk7SHEL/pvLLpHI52u1u4NRe+ui
        Viug0aCrK+3HO4Up56XdglQ=
X-Google-Smtp-Source: APXvYqybsop+rPif36RViqdPSukYZagr2iIr1DIQccne6MS6izAVmTZCxv4F+8qAhV4mOwjUkACQ2Q==
X-Received: by 2002:a37:a090:: with SMTP id j138mr6458649qke.83.1567029970424;
        Wed, 28 Aug 2019 15:06:10 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:c231])
        by smtp.gmail.com with ESMTPSA id u16sm204671qkj.107.2019.08.28.15.06.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 15:06:09 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 02/10] blkcg: make ->cpd_init_fn() optional
Date:   Wed, 28 Aug 2019 15:05:52 -0700
Message-Id: <20190828220600.2527417-3-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828220600.2527417-1-tj@kernel.org>
References: <20190828220600.2527417-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

For policies which can do enough initialization from ->cpd_alloc_fn(),
make ->cpd_init_fn() optional.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 6a82ca3fb5cf..78ccbdcfe723 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1475,7 +1475,8 @@ int blkcg_policy_register(struct blkcg_policy *pol)
 			blkcg->cpd[pol->plid] = cpd;
 			cpd->blkcg = blkcg;
 			cpd->plid = pol->plid;
-			pol->cpd_init_fn(cpd);
+			if (pol->cpd_init_fn)
+				pol->cpd_init_fn(cpd);
 		}
 	}
 
-- 
2.17.1

