Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E398C1585CC
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2020 23:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgBJWzO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Feb 2020 17:55:14 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35898 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgBJWzO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Feb 2020 17:55:14 -0500
Received: by mail-qt1-f193.google.com with SMTP id t13so6562421qto.3;
        Mon, 10 Feb 2020 14:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=E1/oZoQh9QL4yRF08kP3BiVhpoqJi/RGcTjwu+hD+Uo=;
        b=hI0yzy9uB34lReOpIUa5bR1hl6htD9hFShmppKuHKpzTUWMiE2XXybmh47ht49a69Z
         DRVjdJQgObSRd3M5Dd7zQ5Sfa6PqijHkp6UQjrvMYEiYsmB6IrYIjXg/1sE9Z2eB/pcu
         z71MpR8mvJ5cp9hdOEos3Lx1GFowwlwB8OV0SoNWu9BgPfznqvjqaD9hJA3u4xcBj3C6
         y9gkhGNuixfSRke92qLBiFkAIVTA3ER8EBezXSx1+1H+4276sK80/6Bx7WYNCAzNGtRV
         4v2juLna4MVQPLpxHypsZC9Oh6URw9f7nqYOzN8Zd9Q3q/p2TPkgFbFcF4Jw1l7c8vSo
         L4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=E1/oZoQh9QL4yRF08kP3BiVhpoqJi/RGcTjwu+hD+Uo=;
        b=rMRd4ur2lw8iKlc+RVna72gOFpkEix8QIxhNU9Ex+/uDgqPrUvIhiJodl9aDrHFEC1
         Uqxw/jARF+SI4ODdOiJHcfbH9zE9++APJKqtzsSKQkxfFmPlH1DdaKqeR6eTIF52XJSB
         D4aEweKTHs70b4NpLvEO2j2KGx1U0TMcIFByiqv1fCChhphdrEWk82R5G1sBpF24prWx
         9icoVk7gvbG+0fS0/m7PBQ04aIevcIFoMFpl90cEawLIs9hBjmZLEx8m4/xTprbckAyE
         6aLvI1mrkYGG3ZpCqG8kq5K8gUcHn1n+wETQGNwB3mdMyNfbxfvqvk18HH1Q57UO/L11
         DLwg==
X-Gm-Message-State: APjAAAX8g6na4H5+Kx+jdh5HQIYdJkAMfft12cXmajctp3bEvgeSPR6f
        sT/t5e28OhGfKPprFj0ho88=
X-Google-Smtp-Source: APXvYqzOzjlIU+l4ZuNsD3Q0RT8I1D0aVb2iQfI0Cft3QWQaVC/UzueQCgGhtxD98XBxO1tf+KtU9g==
X-Received: by 2002:aed:29e2:: with SMTP id o89mr11972470qtd.353.1581375313200;
        Mon, 10 Feb 2020 14:55:13 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:b3a6])
        by smtp.gmail.com with ESMTPSA id m95sm940101qte.41.2020.02.10.14.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 14:55:12 -0800 (PST)
Date:   Mon, 10 Feb 2020 17:55:12 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup fix for v5.6-rc1
Message-ID: <20200210225512.GA9161@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Linus.

I made a mistake while removing cgroup task list lazy init
optimization making the root cgroup.procs show entries for the
init_tasks. The 0 entries doesn't cause critical failures but does
make systemd print out warning messages during boot. Fix it by
omitting init_tasks as they should be.

Thanks.

The following changes since commit 39bed42de2e7d74686a2d5a45638d6a5d7e7d473:

  Merge tag 'for-linus-hmm' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2020-01-29 19:56:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.6-fixes

for you to fetch changes up to 0cd9d33ace336bc424fc30944aa3defd6786e4fe:

  cgroup: init_tasks shouldn't be linked to the root cgroup (2020-01-30 11:37:33 -0500)

----------------------------------------------------------------
Tejun Heo (1):
      cgroup: init_tasks shouldn't be linked to the root cgroup

 kernel/cgroup/cgroup.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index b3744872263e..cf8a36bdf5c8 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5932,11 +5932,14 @@ void cgroup_post_fork(struct task_struct *child)
 
 	spin_lock_irq(&css_set_lock);
 
-	WARN_ON_ONCE(!list_empty(&child->cg_list));
-	cset = task_css_set(current); /* current is @child's parent */
-	get_css_set(cset);
-	cset->nr_tasks++;
-	css_set_move_task(child, NULL, cset, false);
+	/* init tasks are special, only link regular threads */
+	if (likely(child->pid)) {
+		WARN_ON_ONCE(!list_empty(&child->cg_list));
+		cset = task_css_set(current); /* current is @child's parent */
+		get_css_set(cset);
+		cset->nr_tasks++;
+		css_set_move_task(child, NULL, cset, false);
+	}
 
 	/*
 	 * If the cgroup has to be frozen, the new task has too.  Let's set

