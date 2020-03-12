Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7D5B183825
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2020 19:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgCLSDA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Mar 2020 14:03:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45480 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgCLSC7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Mar 2020 14:02:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id m9so8646269wro.12
        for <cgroups@vger.kernel.org>; Thu, 12 Mar 2020 11:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=CRd8IUcL1IWZS04LIYFbzj4WsXVZJS20ANjjPe46vbU=;
        b=Haae2SBurX0dFdW2FA0odm7mGIYVgXxbkX+kRhvt4ySMuKlguBzaUtjNrkfEaiED2N
         mbGRZT1Dix/XuTr0AVw4HxlQ1lhNxqlheMxxT7Vxz3Cz1I+Ulb5n/EARnD4G3g00Lwwn
         6gqr2BrDtb+6qJLFLYJHzj2AY9s6hHt0U7yk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=CRd8IUcL1IWZS04LIYFbzj4WsXVZJS20ANjjPe46vbU=;
        b=Q4mrwxzgAdDeohKILcdLKwQaUf8ODhiJnPQ/a8L+A8FN7VDNOGK0w6JFLQk7S3PByC
         QkGT5szD0APnRvaK0ohRmEkUu6Uxf+ulnrFIYubTRupY6ZUVoWZQ8d7nmM/u9l6J5i9/
         QdiYB2jxV0sirYdXHVErRfdC6AsVEbJHkmVfhS5ZbmEMfyo885WtYf+uNgLPINXKxIRc
         AIteayUpX155Qbsgj8WQMHw+rd7Dc8RzFWzpCBIaXEJeFZeUNDOQPehj3QCKX0cC2ieu
         vXhVFLuTKxij08XufdIKOhhFEVjXycgbXJ3k9XMFTR4+4yarpaDqFmP90Th8/FSB4k2l
         iXfA==
X-Gm-Message-State: ANhLgQ2ZZHJD1MSyceM1cJscfLPKshsAae2NKzeldyRetZChMycBPrnh
        L5E6D5x5mYnl8DhaPAY6Ss1YLQ==
X-Google-Smtp-Source: ADFU+vsZkrnnVJ1X3zqzCkFEciPWmkOFQhOVZNvmD7Ds5YPo0PFp30zOhwIn2DsIoCNmjexoQjXayA==
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr12216319wru.100.1584036176193;
        Thu, 12 Mar 2020 11:02:56 -0700 (PDT)
Received: from localhost ([89.32.122.5])
        by smtp.gmail.com with ESMTPSA id i6sm11878144wru.40.2020.03.12.11.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 11:02:55 -0700 (PDT)
Date:   Thu, 12 Mar 2020 18:02:54 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/2] mm, memcg: Fix corruption on 64-bit divisor in
 memory.high throttling
Message-ID: <80780887060514967d414b3cd91f9a316a16ab98.1584036142.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

0e4b01df8659 had a bunch of fixups to use the right division method.
However, it seems that after all that it still wasn't right -- div_u64
takes a 32-bit divisor.

The headroom is still large (2^32 pages), so on mundane systems you
won't hit this, but this should definitely be fixed.

Fixes: 0e4b01df8659 ("mm, memcg: throttle allocators when failing reclaim over memory.high")
Reported-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@fb.com
Cc: stable@vger.kernel.org # 5.4.x
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 63bb6a2aab81..a70206e516fe 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2339,7 +2339,7 @@ void mem_cgroup_handle_over_high(void)
 	 */
 	clamped_high = max(high, 1UL);
 
-	overage = div_u64((u64)(usage - high) << MEMCG_DELAY_PRECISION_SHIFT,
+	overage = div64_u64((u64)(usage - high) << MEMCG_DELAY_PRECISION_SHIFT,
 			  clamped_high);
 
 	penalty_jiffies = ((u64)overage * overage * HZ)
-- 
2.25.1

