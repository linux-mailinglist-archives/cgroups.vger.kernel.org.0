Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A390B9F8F2
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2019 05:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfH1DzJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Aug 2019 23:55:09 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41465 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfH1DzD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Aug 2019 23:55:03 -0400
Received: by mail-pl1-f193.google.com with SMTP id m9so551685pls.8
        for <cgroups@vger.kernel.org>; Tue, 27 Aug 2019 20:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mxNtarX9nX57XJxkArjO2AM3QUOz0wzt/JnfD0VPOK0=;
        b=F4caB0aZl1+ljrrlr2ZXzSJ64Udep2IJeA7lQGcAGXBMsyDN9JCNHMO6FT0Ar5vP0v
         UnJCBrHKqZHlbtTQE09XNLLGK9s6lXCj0RfiEUYHCKkZZT3DyfafbE7GpO6RUlwg+E8T
         EDITDAEd81fTvZLyUoEhaX1ib77eZxhg/UoEi81UsG9KE3s0ZgZqgkTAa8cMari6sOBz
         BiasbpjnO/EnhLafHhn/4W5YObrmcFzXPTkbANjmau0q6sNwnLh/HDhWRGDe0dfDU182
         lkes5Qnwe7Mcqt21kTvs3UN/UlyCzS3m/4xDlaMvoRd5eiDJFX2ROW2Xo/vuHPiT5E/i
         l6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mxNtarX9nX57XJxkArjO2AM3QUOz0wzt/JnfD0VPOK0=;
        b=ICrZj9YR+ll+YQZGESUB4hZ4sxUHdlXhlIiabq0n4e/yoeQyHyV3ymboV6pEd5HWqr
         t32qhjlVWSzw0io3Y7M+yvXl5puVrb7jb1aavH7ldgWIYfjZIZUuQVxWMX4LG9MUfyIE
         fcFnKLk6IbFlQqPuAVU9ZEfjwP9gR6n9yNGS/b8jZQIwu+1GtzyPAMHJ5dbbQ+yum0Hv
         6UlVlFU8LLCKXE0w4wHi3qHlAQL/WoLBdUuG+aycgKlZ1bD3EhBSlmMQvFTuQx+C8P4Y
         ag5WhxxP5ghST1GZ2JZOpzgghOQrStfpzyzAUvf6AjhOVVzQVlI1vBeQzyS58uSin0tU
         p9EA==
X-Gm-Message-State: APjAAAUhEAOVX+lu/SyFteuV/6f2Akxuc0Whr0O4CZIoKHxlqMEUpa52
        CosbW+z32GFBvFX+j+sOd98wPQ==
X-Google-Smtp-Source: APXvYqx3e2ELfBN+TGYLKM3FzD+6OoDzIwJzZbWpZcxu0XdIQBMS++7j1DfCl/f6RY1tc9dYTvz3FQ==
X-Received: by 2002:a17:902:aa43:: with SMTP id c3mr2177445plr.11.1566964502988;
        Tue, 27 Aug 2019 20:55:02 -0700 (PDT)
Received: from localhost ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id i124sm902847pfe.61.2019.08.27.20.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 20:55:02 -0700 (PDT)
From:   Fam Zheng <zhengfeiran@bytedance.com>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, paolo.valente@linaro.org, fam@euphon.net,
        duanxiongchun@bytedance.com, cgroups@vger.kernel.org,
        zhangjiachen.jc@bytedance.com, tj@kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH v3 1/3] bfq: Fix the missing barrier in __bfq_entity_update_weight_prio
Date:   Wed, 28 Aug 2019 11:54:51 +0800
Message-Id: <20190828035453.18129-2-zhengfeiran@bytedance.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190828035453.18129-1-zhengfeiran@bytedance.com>
References: <20190828035453.18129-1-zhengfeiran@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The comment of bfq_group_set_weight says the reading of prio_changed
should happen before the reading of weight, but a memory barrier is
missing here. Add it now, to match the smp_wmb() there.

Signed-off-by: Fam Zheng <zhengfeiran@bytedance.com>
Reviewed-by: Paolo Valente <paolo.valente@linaro.org>
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
2.22.1

