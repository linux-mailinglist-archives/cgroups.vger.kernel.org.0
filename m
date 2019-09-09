Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52282AD3E9
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2019 09:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388184AbfIIHcG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Sep 2019 03:32:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39633 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388181AbfIIHcF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Sep 2019 03:32:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id q12so13345948wmj.4
        for <cgroups@vger.kernel.org>; Mon, 09 Sep 2019 00:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zyjk5LLEUpKt0UtgpDlm7KCNgviInbE7D7cMBgrLQBk=;
        b=Nmp2Nta8RxHOTP0Ai3OSlk2CAwu/jWa+KWkMVPpAh2/xBK8uiovcqm4z1wSvte1jkt
         6iUWhoDT5l2W164KcZuTpvo7o1yIZR3IBwSbqkeBHf1lLtqcY7woUt/JKqcVFHlia/bp
         dyGFf2tKxXFEoeNOvzrPNKs4KH22VpTPdZ3+x4mh3CvP5I5G0/N5SGkjK5ArFa2f4qgL
         9VG45Dn9Lz8h/kVWzA7AIyUmgmp1aoFGJQG+vkT7xS+LkH6059pSXqilXqhlkyElhcUx
         U+5tRCgRHVXTi48ZdhKkhy0RG07bPT3w2oob2Fm8r5gBSnBd+ipMK4d1zi7GGWOmrzU+
         YdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zyjk5LLEUpKt0UtgpDlm7KCNgviInbE7D7cMBgrLQBk=;
        b=rEsKN0LcUFSjhpC6wEvhi606Ju+V0ANRY16uFNP75NrY/y3SpZNKdEjkuZh23SFE49
         NirvUNTdtkveqTkfvHWYUiW+jvx9HVosczmzJe6pCy0419HmPxJdvLIxMbaiPnrXOW5k
         hzinOvAGwjfnnTNPPxoFLkYu7ZjJ/LwQiPzpU/VxS/hmmUeVNkMt30c3rsm0Kn9NjLUh
         Nj+1Ax4U3bgNzwgoOKZhdxAJq6UOmqrk1FFyYc0CjKXyZZoOaHSQjWUTYc+0+jH8UWPn
         CBG3C4t/M20TJsVG+OKBby5CavE5Pw20FcC41TWdIq21+yG5RBDjSiX+5Xc4lzvo2/0W
         CEnw==
X-Gm-Message-State: APjAAAWVRTxQLmbX67MUrSO5aO/HooX2EzYcBF9LXJKqXzd+mLQLTckL
        cnnpRnXbpmu+NOSWAGIlLXy1xQ==
X-Google-Smtp-Source: APXvYqzb8JvbKrEGaFkjXOiU6ctU/pbKgFV1vciAQbXJ0cCl7IKOCaM9VTWK3n3BiF6r43GpRzj6NQ==
X-Received: by 2002:a1c:f403:: with SMTP id z3mr12896108wma.74.1568014322015;
        Mon, 09 Sep 2019 00:32:02 -0700 (PDT)
Received: from localhost.localdomain (146-241-7-242.dyn.eolo.it. [146.241.7.242])
        by smtp.gmail.com with ESMTPSA id c8sm617012wrr.49.2019.09.09.00.32.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2019 00:32:01 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 1/1] block, bfq: delete "bfq" prefix from cgroup filenames
Date:   Mon,  9 Sep 2019 09:31:17 +0200
Message-Id: <20190909073117.20625-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909073117.20625-1-paolo.valente@linaro.org>
References: <20190909073117.20625-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Angelo Ruocco <angeloruocco90@gmail.com>

When bfq was merged into mainline, there were two I/O schedulers that
implemented the proportional-share policy: bfq for blk-mq and cfq for
legacy blk. bfq's interface files in the blkio/io controller have the
same names as cfq. But the cgroups interface doesn't allow two
entities to use the same name for their files, so for bfq we had to
prepend the "bfq" prefix to each of its files. However no legacy code
uses these modified file names. This naming also causes confusion, as,
e.g., in [1].

Now cfq has gone with legacy blk, so there is no need any longer for
these prefixes in (the never used) bfq names. In view of this fact, this
commit removes these prefixes, thereby enabling legacy code to truly
use the proportional share policy in blk-mq.

[1] https://github.com/systemd/systemd/issues/7057

Signed-off-by: Angelo Ruocco <angeloruocco90@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 0f6cd688924f..14b7a1160664 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1139,7 +1139,7 @@ struct blkcg_policy blkcg_policy_bfq = {
 
 struct cftype bfq_blkcg_legacy_files[] = {
 	{
-		.name = "bfq.weight",
+		.name = "weight",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = bfq_io_show_weight,
 		.write_u64 = bfq_io_set_weight_legacy,
@@ -1147,42 +1147,42 @@ struct cftype bfq_blkcg_legacy_files[] = {
 
 	/* statistics, covers only the tasks in the bfqg */
 	{
-		.name = "bfq.io_service_bytes",
+		.name = "io_service_bytes",
 		.private = (unsigned long)&blkcg_policy_bfq,
 		.seq_show = blkg_print_stat_bytes,
 	},
 	{
-		.name = "bfq.io_serviced",
+		.name = "io_serviced",
 		.private = (unsigned long)&blkcg_policy_bfq,
 		.seq_show = blkg_print_stat_ios,
 	},
 #ifdef CONFIG_BFQ_CGROUP_DEBUG
 	{
-		.name = "bfq.time",
+		.name = "time",
 		.private = offsetof(struct bfq_group, stats.time),
 		.seq_show = bfqg_print_stat,
 	},
 	{
-		.name = "bfq.sectors",
+		.name = "sectors",
 		.seq_show = bfqg_print_stat_sectors,
 	},
 	{
-		.name = "bfq.io_service_time",
+		.name = "io_service_time",
 		.private = offsetof(struct bfq_group, stats.service_time),
 		.seq_show = bfqg_print_rwstat,
 	},
 	{
-		.name = "bfq.io_wait_time",
+		.name = "io_wait_time",
 		.private = offsetof(struct bfq_group, stats.wait_time),
 		.seq_show = bfqg_print_rwstat,
 	},
 	{
-		.name = "bfq.io_merged",
+		.name = "io_merged",
 		.private = offsetof(struct bfq_group, stats.merged),
 		.seq_show = bfqg_print_rwstat,
 	},
 	{
-		.name = "bfq.io_queued",
+		.name = "io_queued",
 		.private = offsetof(struct bfq_group, stats.queued),
 		.seq_show = bfqg_print_rwstat,
 	},
@@ -1190,66 +1190,66 @@ struct cftype bfq_blkcg_legacy_files[] = {
 
 	/* the same statistics which cover the bfqg and its descendants */
 	{
-		.name = "bfq.io_service_bytes_recursive",
+		.name = "io_service_bytes_recursive",
 		.private = (unsigned long)&blkcg_policy_bfq,
 		.seq_show = blkg_print_stat_bytes_recursive,
 	},
 	{
-		.name = "bfq.io_serviced_recursive",
+		.name = "io_serviced_recursive",
 		.private = (unsigned long)&blkcg_policy_bfq,
 		.seq_show = blkg_print_stat_ios_recursive,
 	},
 #ifdef CONFIG_BFQ_CGROUP_DEBUG
 	{
-		.name = "bfq.time_recursive",
+		.name = "time_recursive",
 		.private = offsetof(struct bfq_group, stats.time),
 		.seq_show = bfqg_print_stat_recursive,
 	},
 	{
-		.name = "bfq.sectors_recursive",
+		.name = "sectors_recursive",
 		.seq_show = bfqg_print_stat_sectors_recursive,
 	},
 	{
-		.name = "bfq.io_service_time_recursive",
+		.name = "io_service_time_recursive",
 		.private = offsetof(struct bfq_group, stats.service_time),
 		.seq_show = bfqg_print_rwstat_recursive,
 	},
 	{
-		.name = "bfq.io_wait_time_recursive",
+		.name = "io_wait_time_recursive",
 		.private = offsetof(struct bfq_group, stats.wait_time),
 		.seq_show = bfqg_print_rwstat_recursive,
 	},
 	{
-		.name = "bfq.io_merged_recursive",
+		.name = "io_merged_recursive",
 		.private = offsetof(struct bfq_group, stats.merged),
 		.seq_show = bfqg_print_rwstat_recursive,
 	},
 	{
-		.name = "bfq.io_queued_recursive",
+		.name = "io_queued_recursive",
 		.private = offsetof(struct bfq_group, stats.queued),
 		.seq_show = bfqg_print_rwstat_recursive,
 	},
 	{
-		.name = "bfq.avg_queue_size",
+		.name = "avg_queue_size",
 		.seq_show = bfqg_print_avg_queue_size,
 	},
 	{
-		.name = "bfq.group_wait_time",
+		.name = "group_wait_time",
 		.private = offsetof(struct bfq_group, stats.group_wait_time),
 		.seq_show = bfqg_print_stat,
 	},
 	{
-		.name = "bfq.idle_time",
+		.name = "idle_time",
 		.private = offsetof(struct bfq_group, stats.idle_time),
 		.seq_show = bfqg_print_stat,
 	},
 	{
-		.name = "bfq.empty_time",
+		.name = "empty_time",
 		.private = offsetof(struct bfq_group, stats.empty_time),
 		.seq_show = bfqg_print_stat,
 	},
 	{
-		.name = "bfq.dequeue",
+		.name = "dequeue",
 		.private = offsetof(struct bfq_group, stats.dequeue),
 		.seq_show = bfqg_print_stat,
 	},
@@ -1259,7 +1259,7 @@ struct cftype bfq_blkcg_legacy_files[] = {
 
 struct cftype bfq_blkg_files[] = {
 	{
-		.name = "bfq.weight",
+		.name = "weight",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = bfq_io_show_weight,
 		.write = bfq_io_set_weight,
-- 
2.20.1

