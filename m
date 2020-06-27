Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF24D20BF9F
	for <lists+cgroups@lfdr.de>; Sat, 27 Jun 2020 09:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgF0HdH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 Jun 2020 03:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgF0HdG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 Jun 2020 03:33:06 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76FCC03E97A;
        Sat, 27 Jun 2020 00:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/aQSpo4n3xdtcdftvKvpaQvh2VA9RA7aMy8HIr4zPtc=; b=Ct6ICbrdi+RdZnvBXmsBtJLXgd
        JyygBSI7zac+fAOFdtzFfO5pB3w5jxxzoRyF3zvrexxkDBNYOfEBbAHTAaZaOcFQ4YsnFdnEW9lCA
        redVfqYvEHSd2b+evoixC9bsJJ3lipbPl9SX/+Usc95saeL0OIIc2NZGNhV52k3SVtDbtXSnWFZIE
        ZyiuwFNKcsJgY/seQavqFWtu9yydvuhdZcQRPYZtdGVCV5h/VUHHyenRHE2wo1+bS9V4pSQmmOUag
        dJx3sW2qxWhk1UdRNYfGgF8MHs+8WRmq9wnFoCbgKD9djg5otbgJvNW7VYmRzFgoPqFXSDe/ZNnnt
        v6cdokcA==;
Received: from [2001:4bb8:184:76e3:595:ba65:ae56:65a6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jp5KH-0006o1-7C; Sat, 27 Jun 2020 07:32:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 11/14] cgroup: unexport cgroup_rstat_updated
Date:   Sat, 27 Jun 2020 09:31:56 +0200
Message-Id: <20200627073159.2447325-12-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200627073159.2447325-1-hch@lst.de>
References: <20200627073159.2447325-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

cgroup_rstat_updated is only used by core block code, no need to
export it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/cgroup/rstat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index b6397a186ce9c8..d51175cedfca4f 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -64,7 +64,6 @@ void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 
 	raw_spin_unlock_irqrestore(cpu_lock, flags);
 }
-EXPORT_SYMBOL_GPL(cgroup_rstat_updated);
 
 /**
  * cgroup_rstat_cpu_pop_updated - iterate and dismantle rstat_cpu updated tree
-- 
2.26.2

