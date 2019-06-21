Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94BFC4E1D5
	for <lists+cgroups@lfdr.de>; Fri, 21 Jun 2019 10:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbfFUIXH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jun 2019 04:23:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39858 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfFUIXH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jun 2019 04:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hSWwJMZClWxLlMFotPRfl8SxjdwJbH68GW2swFT/BBg=; b=Tx8dE9kfJC7z1d5Gqf19YDrRe
        TvvK5sFndH6tXKiL1bOn6pqiHumzmY1zHpqUBCVt05Q6UnZaOPLMGzZoUlwDD6w8qwsxCapzULZ+2
        1miP4tqVjKX+N7eyjTMEfsX+KARFU8Azkc8fYGu7FRkHMjJexsCBJwf/3uiTK3yHwRr1doGAZBKgC
        Ff6kOVVtfhCg01WsiGtJB6DwjW7TJJoUEwB/5MXz028hzinT9rKYbpj4KNF6LMihNei5ExbxVWF6Y
        edj6cHjjPXBWzxEHyePXY1waQsh+ypgrbjvKBWWZ7JKXUoN4p6BmzR+IK315qfHzih3Gl0SCIHhCF
        jtLfOydHg==;
Received: from 212095005057.public.telering.at ([212.95.5.57] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1heEp3-0002VG-63; Fri, 21 Jun 2019 08:23:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, linux-block@vger.kernel.org
Cc:     cgroups@vger.kernel.org
Subject: [PATCH for-block] cgroup: export css_next_descendant_pre for bfq
Date:   Fri, 21 Jun 2019 10:22:48 +0200
Message-Id: <20190621082248.11427-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The bfq schedule now uses css_next_descendant_pre directly after
the stats functionality depending on it has been from the core
blk-cgroup code to bfq.  Export the symbol so that bfq can still
be build modular.

Fixes: d6258980daf2 ("bfq-iosched: move bfq_stat_recursive_sum into the only caller")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/cgroup/cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 426a0026225c..30aba80858e3 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4221,6 +4221,7 @@ css_next_descendant_pre(struct cgroup_subsys_state *pos,
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(css_next_descendant_pre);
 
 /**
  * css_rightmost_descendant - return the rightmost descendant of a css
-- 
2.20.1

