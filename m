Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AADD18DD7E
	for <lists+cgroups@lfdr.de>; Sat, 21 Mar 2020 02:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgCUBkE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Mar 2020 21:40:04 -0400
Received: from mx2.didichuxing.com ([36.110.17.22]:18579 "HELO
        bsf02.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1726840AbgCUBkE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Mar 2020 21:40:04 -0400
X-Greylist: delayed 1153 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Mar 2020 21:39:53 EDT
X-ASG-Debug-ID: 1584753666-0e4108235339cd50001-hhPYk8
Received: from mail.didiglobal.com (bogon [172.20.36.235]) by bsf02.didichuxing.com with ESMTP id 0oVwvWonRB63dX8P; Sat, 21 Mar 2020 09:21:06 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 21 Mar
 2020 09:21:05 +0800
Date:   Sat, 21 Mar 2020 09:21:04 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <tj@kernel.org>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>
Subject: [RFC 1/3] update the real issue size when bio_split
Message-ID: <c35d6607d06b9cdad280f0e0f612e57910bbd4e4.1584728740.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [RFC 1/3] update the real issue size when bio_split
Mail-Followup-To: axboe@kernel.dk, tj@kernel.org,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
References: <cover.1584728740.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1584728740.git.zhangweiping@didiglobal.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS04.didichuxing.com (172.20.36.192) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: bogon[172.20.36.235]
X-Barracuda-Start-Time: 1584753666
X-Barracuda-URL: https://bsf02.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 1990
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.80738
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The split.bi_iter.bi_size was copied from @bio,
bi_issue was initialized in this flow:
bio_clone_fast->__bio_clone_fast->blkcg_bio_issue_init

So the split->bi_issue has a wrong size, so update the size
at here.

Change-Id: I1f9c8c973ac1d41f4aea17a9a766b4c4d532f642
Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 block/bio.c               | 13 +++++++++++++
 include/linux/blk_types.h |  9 +++++++++
 2 files changed, 22 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 0985f3422556..8654c4d692e5 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1911,6 +1911,19 @@ struct bio *bio_split(struct bio *bio, int sectors,
 
 	split->bi_iter.bi_size = sectors << 9;
 
+	/*
+	 * reinit bio->bi_issue, the split.bi_iter.bi_size was copied
+	 * from @bio, bi_issue was initialized in this flow:
+	 * bio_clone_fast->__bio_clone_fast->blkcg_bio_issue_init
+	 *
+	 * So the split->bi_issue has a wrong size, so update the size
+	 * at here.
+	 *
+	 * Actually, we can just use blkcg_bio_issue_init, there is just
+	 * a bit difference for the issue_time.
+	 */
+	bio_issue_update_size(&split->bi_issue, bio_sectors(split));
+
 	if (bio_integrity(split))
 		bio_integrity_trim(split);
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 70254ae11769..56e41ef3e827 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -128,6 +128,15 @@ static inline sector_t bio_issue_size(struct bio_issue *issue)
 	return ((issue->value & BIO_ISSUE_SIZE_MASK) >> BIO_ISSUE_SIZE_SHIFT);
 }
 
+static inline void bio_issue_update_size(struct bio_issue *issue, sector_t size)
+{
+	size &= (1ULL << BIO_ISSUE_SIZE_BITS) - 1;
+	/* set all _issue_size bits to 1 */
+	issue->value |= (u64)BIO_ISSUE_SIZE_MASK;
+	/* set new size */
+	issue->value &= ((u64)size << BIO_ISSUE_SIZE_SHIFT);
+}
+
 static inline void bio_issue_init(struct bio_issue *issue,
 				       sector_t size)
 {
-- 
2.18.1

