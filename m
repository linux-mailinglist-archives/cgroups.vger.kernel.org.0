Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5033139A006
	for <lists+cgroups@lfdr.de>; Thu,  3 Jun 2021 13:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhFCLom (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Jun 2021 07:44:42 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:44977 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhFCLom (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Jun 2021 07:44:42 -0400
Received: by mail-lf1-f41.google.com with SMTP id r198so4985676lff.11
        for <cgroups@vger.kernel.org>; Thu, 03 Jun 2021 04:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zoxuOrzcIzq8RN+/4nBQ/3k2NzacgB/FA90ZDc0iE2g=;
        b=B0B/U0Te+oqbPP7glz7wROMs2i1Yf6OIFxaf66AT+lvKHMBwMbKBNs+49GdQYtgSL2
         lmmuxPD4p/aXsOBVDMiuLF4JIeLWsLQFWUiYrxQCyY0/T/BL49JNN0hyHhqsYvY6g9I5
         yKv9tF7FsCeDqKvgCgzBATkoTHw9N97uuXLP6s9IoKXB7iGTtOPqTXJ2ZTZWHgw/NnIK
         5aSZvw9GsU3XDkKfdMIsDn7LlawJXxwFCDpNst9WieGgF/qv9zUj49JIRbcebbNVrJIQ
         GMuNIJlee2UlF/jP9qzRgQGDoVYwqeh/VZJ0IKwEDqHhecSvKvQIdEUaoTIKUWVgB9pU
         34ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zoxuOrzcIzq8RN+/4nBQ/3k2NzacgB/FA90ZDc0iE2g=;
        b=uAgs+4SEb9XWm7KNRZuj8+cuO7ZRfdzropAG2TErvwr4c4sJ+fZRQAMKfPV9IWqCe3
         MCOKbigncTkv4jItnsSUh/iYz5tmNwTQOBlCqIHmRu5s2fm5QNqMxWa795tAwrBqwJY5
         VDHZbTxsbjnRrwKm5Cc618Pww2eSjD60tiOjG5cvsaYvNAXHdXIdfJN5y/GudySZPCb2
         9G3XVMS7gR0t2rg4ac6Qt+1DPZjotSMnnmHUoAY0u6YTk7NSlP6h5qJm4EztVc4lOje0
         NLpmF3yE4xYpYlx/zyN/g6SdhSZDluEKeEfCDfN/eDFcFVcpNp4+w65L/KZJPPdjL1ln
         83og==
X-Gm-Message-State: AOAM530SOlLV21YoDw+fAfQPBS0+Ko/BXw16MysWuwnkgCszTJmWyooF
        o8n1wQevEeT1FqnxZoTdVG++zw==
X-Google-Smtp-Source: ABdhPJyz5OLV8CIcK4HPiGR3l5v2ioTxV7ylqEAakz11SE9zOgXl2uDMFOyJEw3duhJCRIVjKNwTRQ==
X-Received: by 2002:a05:6512:2397:: with SMTP id c23mr1028542lfv.114.1622720516606;
        Thu, 03 Jun 2021 04:41:56 -0700 (PDT)
Received: from localhost.localdomain (ti0005a400-2351.bb.online.no. [80.212.254.60])
        by smtp.gmail.com with ESMTPSA id u24sm295117lfc.162.2021.06.03.04.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 04:41:56 -0700 (PDT)
From:   Odin Ugedal <odin@uged.al>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odin Ugedal <odin@uged.al>
Subject: [PATCH v2] sched/fair: Correctly insert cfs_rq's to list on unthrottle
Date:   Thu,  3 Jun 2021 13:38:47 +0200
Message-Id: <20210603113847.163512-1-odin@uged.al>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This fixes an issue where fairness is decreased since cfs_rq's can
end up not being decayed properly. For two sibling control groups with
the same priority, this can often lead to a load ratio of 99/1 (!!).

This happen because when a cfs_rq is throttled, all the descendant cfs_rq's
will be removed from the leaf list. When they initial cfs_rq is
unthrottled, it will currently only re add descendant cfs_rq's if they
have one or more entities enqueued. This is not a perfect heuristic.

Insted, we insert all cfs_rq's that contain one or more enqueued
entities, or contributes to the load of the task group.

Can often lead to sutiations like this for equally weighted control
groups:

$ ps u -C stress
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root       10009 88.8  0.0   3676   100 pts/1    R+   11:04   0:13 stress --cpu 1
root       10023  3.0  0.0   3676   104 pts/1    R+   11:04   0:00 stress --cpu 1

Fixes: 31bc6aeaab1d ("sched/fair: Optimize update_blocked_averages()")
Signed-off-by: Odin Ugedal <odin@uged.al>
---

Original thread: https://lore.kernel.org/lkml/20210518125202.78658-3-odin@uged.al/
Changes since v1:
 - Replaced cfs_rq field with using tg_load_avg_contrib
 - Went from 3 to 1 pathces; one is merged and one is replaced
   by a new patchset.

 kernel/sched/fair.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 794c2cb945f8..0f1b39ca5ca8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4719,8 +4719,11 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 		cfs_rq->throttled_clock_task_time += rq_clock_task(rq) -
 					     cfs_rq->throttled_clock_task;
 
-		/* Add cfs_rq with already running entity in the list */
-		if (cfs_rq->nr_running >= 1)
+		/*
+		 * Add cfs_rq with tg load avg contribution or one or more
+		 * already running entities to the list
+		 */
+		if (cfs_rq->tg_load_avg_contrib || cfs_rq->nr_running)
 			list_add_leaf_cfs_rq(cfs_rq);
 	}
 
-- 
2.31.1

