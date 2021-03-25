Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E25D3489DE
	for <lists+cgroups@lfdr.de>; Thu, 25 Mar 2021 08:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhCYG6w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Mar 2021 02:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhCYG6X (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Mar 2021 02:58:23 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C18C06174A;
        Wed, 24 Mar 2021 23:58:22 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id v2so832818pgk.11;
        Wed, 24 Mar 2021 23:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ZZvw7/YnAvbuz3MYm/09eOTBXS+Szbh8Xu21JXaDC18=;
        b=A5MwuGnBLXyxo1pNxzLhQUC1BCejhCEC8eQEep08Z+a+m2RfBsIU+6isYbN7js2fpI
         jjkbVmee3EPb+2fDE30FjVmQc7QtHnOLSzFfaObbLfd9T8zni8h2cDnaBBP38ue13hHk
         HR4cNYODcN4OIrVlkNLHh2J5QZjZ+C/qhcS8v5PdccuELOCUhqJ7jnFnKm5JmwL2FmPE
         J+bwS8yOkJv+vk8NCWANCP3/fDkf+GCEHbhYSxD9bsoc8Yk7QgaNZA5zVEsudsJVoxPJ
         4VjLXwuA7INBQdt0tA+RxEroUa9tPBGhx5rUhreTd5MHorZLxDHpWAAyX0W+aN473Zt3
         PM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ZZvw7/YnAvbuz3MYm/09eOTBXS+Szbh8Xu21JXaDC18=;
        b=IF8/YXQ4Jirtsd7Ox0GCYVG9AxtDlOa7+Kd0GKKFYtf/1umsbo/hhAD5CFzQO1r9mA
         DTN+rDYyEaXh05amX7sIFTqPJ+Ly4caLNfzI1ManG3K22vZoslnqoBKAw3LlLNz3CIGq
         +5vdXvqhp38Y1KYr/kJ++dwzOI0xz1hu7wSldkbavOBIQbDEd1XdSSrtoJVPSz2YKOmc
         Lw+40imXs68bvYGURaohja+f3SZf0sFmPCXxBEsQ/vXq8cAMVh1hR5cbq1+ijcRwNaoZ
         OTPe0UEBckF0EwWcGuu71cPAnAWFFGiu83W4Rv1y8RXTCqoRUwcYcXK2B/+rFVceMG6F
         SSOA==
X-Gm-Message-State: AOAM532eAtn4/mIwf1tntSQ9WxjBrAlEJMTFTxNVbyjNSgQv/FUroNAy
        sKENtDMUjonbnGv13KK0+uA=
X-Google-Smtp-Source: ABdhPJz4GVMT2mX8n/en2d18+/nX3G/giX/EAm4ezsje74umQm54W4ZncgnYpzKOZ6sgYaVoBsL2cQ==
X-Received: by 2002:a05:6a00:8c7:b029:20f:1cf4:d02 with SMTP id s7-20020a056a0008c7b029020f1cf40d02mr6628093pfu.49.1616655502496;
        Wed, 24 Mar 2021 23:58:22 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id x19sm4470202pfc.152.2021.03.24.23.58.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Mar 2021 23:58:22 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/14] bfq: disable merging between different groups under better_fairness
Date:   Thu, 25 Mar 2021 14:57:56 +0800
Message-Id: <d31d9a4bc5705adc0b6669b48470fcaabf55074a.1616649216.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1616649216.git.brookxu@tencent.com>
References: <cover.1616649216.git.brookxu@tencent.com>
In-Reply-To: <cover.1616649216.git.brookxu@tencent.com>
References: <cover.1616649216.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

In order to better guarantee the Qos for each group, we do not
allow queues of different groups to be merged.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-iosched.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 5aa9c2c..f4a99f9 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2665,6 +2665,9 @@ static bool bfq_may_be_close_cooperator(struct bfq_queue *bfqq,
 	if (!bfq_bfqq_sync(bfqq) || !bfq_bfqq_sync(new_bfqq))
 		return false;
 
+	if (!bfq_bfqq_may_inject(bfqq, new_bfqq))
+		return false;
+
 	return true;
 }
 
-- 
1.8.3.1

