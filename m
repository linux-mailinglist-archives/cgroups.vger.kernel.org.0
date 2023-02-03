Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1DE689C91
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 16:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjBCPEW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 10:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjBCPEV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 10:04:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F269317CD8;
        Fri,  3 Feb 2023 07:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=p6drb38Fk8RdhNordfPyoAUltaGgb0aSqtldVyTVQaQ=; b=aQ/AH2M5M8OC+lwn5yKRLql2jo
        +bfcQzcrzfQESEsKUsWNeeSv6iiYsxfnWZ2YIFG2Dd95SfHpXNfMfDN5tAcvuZtmPGRqReTr0UQcg
        nYlJu5VNlM0IIcQpPh32aV+ttKyJbvT+yubmJz2INMmX4k7TwrtCMQWq7sNftx0jbi7iUsJ1j7bVs
        GGWbWp1n/OKVaVV8wlin668+n8DVK04HCpMXoLr1GRl+cbbIJ4EAlMCt6DkMTwkcYKpdtEge82HPd
        +xSJUT8cVjFO2ctdokbeYz67n39v8iVkDlkj5a5VLlF8lJ7q19Me9D80Ky3xd3xiubZ3oV4Ozl9Pc
        /67UcfHw==;
Received: from [2001:4bb8:19a:272a:910:bb67:7287:f956] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNxbu-002a3H-9w; Fri, 03 Feb 2023 15:04:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH 05/19] blk-cgroup: remove the !bdi->dev check in blkg_dev_name
Date:   Fri,  3 Feb 2023 16:03:46 +0100
Message-Id: <20230203150400.3199230-6-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230203150400.3199230-1-hch@lst.de>
References: <20230203150400.3199230-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

bdi_dev_name already performs the same check.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 1038688568926e..0b3226cbf3f25d 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -572,7 +572,7 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 
 const char *blkg_dev_name(struct blkcg_gq *blkg)
 {
-	if (!blkg->q->disk || !blkg->q->disk->bdi->dev)
+	if (!blkg->q->disk)
 		return NULL;
 	return bdi_dev_name(blkg->q->disk->bdi);
 }
-- 
2.39.0

