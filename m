Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA7F8126B
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2019 08:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfHEGiQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Aug 2019 02:38:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33322 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbfHEGiP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Aug 2019 02:38:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so39108407pfq.0
        for <cgroups@vger.kernel.org>; Sun, 04 Aug 2019 23:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H0yUp64wfUQz7/P14zeAkDAdPbazrBmBRzsKkTj102k=;
        b=HkqdS5JfAzU5BEi1rePzJYVVta7pmYY9kcs8THIOz9I9OoWyVYFoS8yIydBOR4khk5
         NeMe6c/hV8JE8DIvkkaEz8yze8KZ1gP7tzk+8ey9ETPzgPATG5RgLbFTQ2SSaIEtF9ww
         6ZFeXT8qCQpIRrKSxqf1DLd7BnjBrA5abZ3VxSqjTOBPBP18qoUm5LLlvjyrM+cfIHfV
         e0l9CmNfliF9bLK/71XhHxS26xy1KnswmuImQ04lHQJerW1dB/mMVqRBjda0RZ116I6g
         pTFy2Wo6QOPDj2YsB8/flAFkdF3Hi2A7F/xY5Wzj9oBxQdd5g1vbsMV2JkgpPKSUMnfn
         iV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H0yUp64wfUQz7/P14zeAkDAdPbazrBmBRzsKkTj102k=;
        b=e28ZAmHSsyK7nDgv4ARlw6QJlFxO7jkifjNZ4f/Y1Dhb9gO4RXj785ne9gncuJZpkE
         wJg+PZVaCwW3p8qOtMor9ayeW02VB7FmO//8Kf3YisOefe4JkVWRxX0Fzg3NOOun1IXn
         82Dphg3ApwehgcxjeG2HjoOCWJBEkXSL6xcPgQ7vdopw0Vs6L1vN+v74ZuWhQnrKt8HK
         o/e4LyPZkGsw7r/LUek4z59mWcOhh4dAf7sg8SYj89YXqG/yWDpXL5/be9iJfbPDL4ID
         Pd5YajxhwpTVoykdm6VPRi3InrcwDyeEgnr2e3Ckx6gz+EIXiPkY2OU1aALkqz3qYPSG
         1NXw==
X-Gm-Message-State: APjAAAWX1fUaDV8V01RpPqssRJeXjmt0YiB+JnkvYc7VrYLeuF+RuhJ/
        +ieXr9xIYWPXhNj9kQKWWcNhnQ==
X-Google-Smtp-Source: APXvYqyWLOSI2+DYTh0Ld4S5k28wKqb34K9CG5dKxzGU+mc2z+KxEEsAAqZNhQ/hEc/DAJFUjB1lFw==
X-Received: by 2002:a65:64c5:: with SMTP id t5mr62133295pgv.168.1564987094988;
        Sun, 04 Aug 2019 23:38:14 -0700 (PDT)
Received: from localhost ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id f197sm81442794pfa.161.2019.08.04.23.38.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Aug 2019 23:38:14 -0700 (PDT)
From:   Fam Zheng <zhengfeiran@bytedance.com>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, fam@euphon.net, paolo.valente@linaro.org,
        duanxiongchun@bytedance.com, linux-block@vger.kernel.org,
        tj@kernel.org, cgroups@vger.kernel.org,
        zhangjiachen.jc@bytedance.com
Subject: [PATCH v2 1/3] bfq: Fix the missing barrier in __bfq_entity_update_weight_prio
Date:   Mon,  5 Aug 2019 14:38:05 +0800
Message-Id: <20190805063807.9494-2-zhengfeiran@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190805063807.9494-1-zhengfeiran@bytedance.com>
References: <20190805063807.9494-1-zhengfeiran@bytedance.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The comment of bfq_group_set_weight says the reading of prio_changed
should happen before the reading of weight, but a memory barrier is
missing here. Add it now, to match the smp_wmb() there.

Signed-off-by: Fam Zheng <zhengfeiran@bytedance.com>
---
 block/bfq-wf2q.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index c9ba225081ce..05f0bf4a1144 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -744,6 +744,8 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
 		}
 #endif
 
+		/* Matches the smp_wmb() in bfq_group_set_weight. */
+		smp_rmb();
 		old_st->wsum -= entity->weight;
 
 		if (entity->new_weight != entity->orig_weight) {
-- 
2.11.0

