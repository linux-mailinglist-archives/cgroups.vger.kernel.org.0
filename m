Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 147EB349B0
	for <lists+cgroups@lfdr.de>; Tue,  4 Jun 2019 16:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfFDOBJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Jun 2019 10:01:09 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46993 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbfFDOBI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Jun 2019 10:01:08 -0400
Received: by mail-qt1-f194.google.com with SMTP id z19so13778646qtz.13
        for <cgroups@vger.kernel.org>; Tue, 04 Jun 2019 07:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HA9nmzXQ1v1EpP1te6eSn7ZdKChVSouT7677WSi9nIU=;
        b=FjD0vS909bew//7s7kZ4U68BxVAcYNK5lIoo28VJ0iR1cKCHo5uwPCWhKdZwvb5R3h
         l+JLi7kgdhHQ1mXfsVZvplZ78xwVC8/ftBcb4Y1CP7AfT7ECrvsLzhzJmhjoXKQ+9YfW
         jkK1KfkjNxpW1xSRKQnYK4mvUMqCOfcP73zC3WHA+ooGIl+psI9Q4jqvA7bBCK7mH9Ef
         w3/bC3nfoSs3iDZfv8dHX2070J87acrVGFg6U4tChzCNpv8wZEvISzXrFjF4d2cH+dQg
         CW65qtmF/xSV9/UwnhEaWAjNq9r1a+ZARBE5OytTmcBx9/3tgsvUzYwtXDaZM5w9ZTBz
         LD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HA9nmzXQ1v1EpP1te6eSn7ZdKChVSouT7677WSi9nIU=;
        b=VWSPOuTVOKjE2uN1PY2mRtdgP19fc4OVYE4INlmokWaQnkJmSl07D+xRj4Cj4luIGi
         m7QAPRuhyKfpnrDsUioSgvTgEr5CFte/NgEUZE7I1Y25uL/fIvGYBbSRLecl2YoJJt4o
         wBVGxUjezYNPCu73MT8J4r3h9cIpc3VBAwOUANNUcHhvz+1DaFCrfkrpU1f80TphY9F+
         LDo2dCiNalMpuX3zbJ9X7Ftd00ir7LNU/Qrxaikcm2ArM0axdqUi+sYG2Vbo/UihZyHj
         F8GObdgsqdYaUVvlqPIOHl5POrT+Xo6047VFsS3qmWc0eXGrxqvnH30fuaQlUjEIH5bM
         1UVw==
X-Gm-Message-State: APjAAAWjVT0j3K22gvgcio3lMBadB5rmMp8Na+vjgGHBA/EzeVtLFbiL
        7SOMS4t8jw1puPOuWjE8H3pLQw==
X-Google-Smtp-Source: APXvYqyaYFcOVCNNE4EgaFXVtcyiuzl8/nFtl+bPshTs3JbBCrjCSlVZ/oa+7ymTOAx0gJHRKZE4qg==
X-Received: by 2002:a0c:be87:: with SMTP id n7mr8195030qvi.65.1559656867510;
        Tue, 04 Jun 2019 07:01:07 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f189sm2340295qkj.13.2019.06.04.07.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 07:01:06 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     rppt@linux.ibm.com, will.deacon@arm.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] arm64/mm: fix a bogus GFP flag in pgd_alloc()
Date:   Tue,  4 Jun 2019 10:00:36 -0400
Message-Id: <1559656836-24940-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The commit "arm64: switch to generic version of pte allocation"
introduced endless failures during boot like,

kobject_add_internal failed for pgd_cache(285:chronyd.service) (error:
-2 parent: cgroup)

It turns out __GFP_ACCOUNT is passed to kernel page table allocations
and then later memcg finds out those don't belong to any cgroup.

backtrace:
  kobject_add_internal
  kobject_init_and_add
  sysfs_slab_add+0x1a8
  __kmem_cache_create
  create_cache
  memcg_create_kmem_cache
  memcg_kmem_cache_create_func
  process_one_work
  worker_thread
  kthread

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/arm64/mm/pgd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
index 769516cb6677..53c48f5c8765 100644
--- a/arch/arm64/mm/pgd.c
+++ b/arch/arm64/mm/pgd.c
@@ -38,7 +38,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	if (PGD_SIZE == PAGE_SIZE)
 		return (pgd_t *)__get_free_page(gfp);
 	else
-		return kmem_cache_alloc(pgd_cache, gfp);
+		return kmem_cache_alloc(pgd_cache, GFP_PGTABLE_KERNEL);
 }
 
 void pgd_free(struct mm_struct *mm, pgd_t *pgd)
-- 
1.8.3.1

