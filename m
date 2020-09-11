Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156BB26760A
	for <lists+cgroups@lfdr.de>; Sat, 12 Sep 2020 00:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgIKWkx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Sep 2020 18:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgIKWkw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Sep 2020 18:40:52 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3DAC061573;
        Fri, 11 Sep 2020 15:40:52 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q63so10696093qkf.3;
        Fri, 11 Sep 2020 15:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YYtbWxsMj/6n0uZf9WI97Rz4VWxjIwP6xqNBdneeUNo=;
        b=JkeVh8VK3P/IsY0yYuXRdbFDfSKwWuZBsdVeYQRNJXfK2KGyYQA/AQG1w6u3J0hR27
         xeKsvGfP60teeylfKsR7sGVXFMV23UrkcYS7IDmwba1mQ6wUDlymmXWC2YHbSd29ru18
         pt2KX5E/s3IOIPopfD1+EeR9VSvm3ykan7xzxtVrzfWo4ez/vOxR+5JrJjTOwyjKrpFu
         TuMTwzTuMnCHWaDumPkGYbWJTCWoxq4zR3eSIPh7oON1BRWWNFipreIaAwRz8hYzfHqT
         1o5fPvv/NulyfvabHbVdfiQCigpSGk1nVtsUJ2oyfjGmIk7eh233XREeAOk/JxjqdGzp
         66JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=YYtbWxsMj/6n0uZf9WI97Rz4VWxjIwP6xqNBdneeUNo=;
        b=Z+j1neCA+DIyHAVJooW8hbEFVzaoyF6pPlF3Q7SJAXBl5EuAEUzNro/cHXNwKgZtp2
         5HfIB7HfJzgDmPbsdvcM8vMg5TfO2nIxCG9E8jwhMYFlpnpdCT65zoIs1vlcmUhPUgiQ
         yhJn9E789zcob3AecRt43nn7v01W47oUzBGpVLN3ycsfbSusT+8rrqslCO+BUsxNp7sw
         JbfUi5oe2rjAHOqJzV2L5zSyJ+cU+zQvfUkp863A/FexSB8QpsRcGsk/CEDoWQ0hH0C9
         /GNRr+M86Tr7+CJtS1eDf6nRS8fQijZgWMz/85ytIc81lFq+usl6vZx9boKkJ1IuNaoA
         QafQ==
X-Gm-Message-State: AOAM533K0jI0eXmGgFQJ8YXZF7Hg6asyGiVMGjlrl+gLXmMMKQDaL9Bz
        gDtfa/DquL6bgx7hbcXnzdc=
X-Google-Smtp-Source: ABdhPJzYGdYMQAwnuAGDo9b4JV7knr1wG0BIH42y4L824JuZkGPlSDZvBU9CfgyDOTI4FYI1TP5zbA==
X-Received: by 2002:a37:5684:: with SMTP id k126mr3444195qkb.43.1599864051399;
        Fri, 11 Sep 2020 15:40:51 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:95ac])
        by smtp.gmail.com with ESMTPSA id b43sm4570299qtk.84.2020.09.11.15.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 15:40:50 -0700 (PDT)
Date:   Fri, 11 Sep 2020 18:40:49 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org
Subject: [PATCH v2 block/for-next] blk-iocost: fix divide-by-zero in
 transfer_surpluses()
Message-ID: <20200911224049.GA865564@mtj.thefacebook.com>
References: <20200911170746.GG4295@mtj.thefacebook.com>
 <ff46ca79-433e-3279-a8eb-35156639be7b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff46ca79-433e-3279-a8eb-35156639be7b@kernel.dk>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Conceptually, root_iocg->hweight_donating must be less than WEIGHT_ONE but
all hweight calculations round up and thus it may end up >= WEIGHT_ONE
triggering divide-by-zero and other issues. Bound the value to avoid
surprises.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: e08d02aa5fc9 ("blk-iocost: implement Andy's method for donation weight updates")

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Jens, I was flipping between doing max_t(, 1) over the whole divider and
doing min_t(, WEIGHT_ONE - 1) for hweight_donating. I thought that I as
testing after the last change but it obviously wasn't and the previous patch
doesn't compile due to missing type argument. Can you please apply this
patch instead? I can send an incremental patch if that'd be better. My
apologies.

Thanks.

 block/blk-iocost.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index fc897bb142bcd..6e29b4dcf3566 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1881,15 +1881,21 @@ static void transfer_surpluses(struct list_head *surpluses, struct ioc_now *now)
 
 	/*
 	 * Calculate the global donation rate (gamma) - the rate to adjust
-	 * non-donating budgets by. No need to use 64bit multiplication here as
-	 * the first operand is guaranteed to be smaller than WEIGHT_ONE
-	 * (1<<16).
+	 * non-donating budgets by.
+	 *
+	 * No need to use 64bit multiplication here as the first operand is
+	 * guaranteed to be smaller than WEIGHT_ONE (1<<16).
+	 *
+	 * We know that there are beneficiary nodes and the sum of the donating
+	 * hweights can't be whole; however, due to the round-ups during hweight
+	 * calculations, root_iocg->hweight_donating might still end up equal to
+	 * or greater than whole. Limit the range when calculating the divider.
 	 *
 	 * gamma = (1 - t_r') / (1 - t_r)
 	 */
 	gamma = DIV_ROUND_UP(
 		(WEIGHT_ONE - root_iocg->hweight_after_donation) * WEIGHT_ONE,
-		WEIGHT_ONE - root_iocg->hweight_donating);
+		WEIGHT_ONE - min_t(u32, root_iocg->hweight_donating, WEIGHT_ONE - 1));
 
 	/*
 	 * Calculate adjusted hwi, child_adjusted_sum and inuse for the inner
