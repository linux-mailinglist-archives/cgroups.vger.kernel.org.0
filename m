Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54B579F8F8
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2019 05:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfH1DzJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Aug 2019 23:55:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33983 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfH1DzH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Aug 2019 23:55:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so653496pgc.1
        for <cgroups@vger.kernel.org>; Tue, 27 Aug 2019 20:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Spd8tWh4JGn3fBDEW8q9V28IkZ0ZVpCm4ISnu3nMaQM=;
        b=aQ2B4fFB6wrF6qbAgHFZWLIJBhdhVTA/hv4KAiq7MVYvRbBqWjbP6CrvRB/d4Ulqx1
         tRKuf+FbiNADlKz00WPw49rPF4mULQpIOTB+kw/E2Y6UwD9re9KqwiCxrBa3LvPOQZxB
         CRFelNFwgRThHt/CP9knGc0RrVtZSieKNJrnXkTRCah08mW/Q9Najk8yXZ9lyN05ivTL
         3SXFC3gQHIkTVYriMvQtHHPhHv5EmY5AmL0qwbYs99S9wjJAi8i+NqkhVRSzcgKlLbhX
         lhKWX4P7PqsksULwa+wWvhUYYh/yIn+RxNYVaBrtxNgLQki5OHp17zyR+AGns9sF50HT
         auHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Spd8tWh4JGn3fBDEW8q9V28IkZ0ZVpCm4ISnu3nMaQM=;
        b=SV0x0kcieKi3BkemdolfVpsFY7uxDqsDYj1EkDeH6qETGNNFbbbieGx5ofH1khS8MQ
         /v5pon+tv44Bzo1TcaSdG+OO5OV9qbMXII0ToWGtcCFe4PaYV4SsF3S3GEUzOvJLV8WR
         jAEMNMtEkdrLqvfwPsjbo1P26xbF/U3FA9jM3SC5W01yXkdvpKu6/A8mrz0u04HhX169
         K2q/h5IawPx2XUMr9els0BFkhUoE7YJNYe9q1vOuazn3UK7WjyS7UxB2FFu7mUVfacVK
         FlEX+V+KCWcKd/tG5s1cecTvmL9n4kgJ1SbLqVobDOZmT+mQhyFXd/xR7w+KQojd2WJU
         H//g==
X-Gm-Message-State: APjAAAXGYrKrq0gzVmRYjwXgeoJ+6334icpiiesOYTwJmpiQZrMbcUCr
        rh51TsUD32DC/Ln4k5r7qxnbEA==
X-Google-Smtp-Source: APXvYqy+6Ftbx8LvBpqhPjKILebxq24WFzWwB/gDOQ9g3NCj3QSvlR1tmVSPJXa8Ir3vxCUxmkJFEA==
X-Received: by 2002:a65:608e:: with SMTP id t14mr1619143pgu.373.1566964506583;
        Tue, 27 Aug 2019 20:55:06 -0700 (PDT)
Received: from localhost ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id q10sm944776pfl.8.2019.08.27.20.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 20:55:06 -0700 (PDT)
From:   Fam Zheng <zhengfeiran@bytedance.com>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, paolo.valente@linaro.org, fam@euphon.net,
        duanxiongchun@bytedance.com, cgroups@vger.kernel.org,
        zhangjiachen.jc@bytedance.com, tj@kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH v3 2/3] bfq: Extract bfq_group_set_weight from bfq_io_set_weight_legacy
Date:   Wed, 28 Aug 2019 11:54:52 +0800
Message-Id: <20190828035453.18129-3-zhengfeiran@bytedance.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190828035453.18129-1-zhengfeiran@bytedance.com>
References: <20190828035453.18129-1-zhengfeiran@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This function will be useful when we update weight from the soon-coming
per-device interface.

Signed-off-by: Fam Zheng <zhengfeiran@bytedance.com>
Reviewed-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c | 60 ++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 0f6cd688924f..28e5a9241237 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -918,6 +918,36 @@ static int bfq_io_show_weight(struct seq_file *sf, void *v)
 	return 0;
 }
 
+static void bfq_group_set_weight(struct bfq_group *bfqg, u64 weight)
+{
+	/*
+	 * Setting the prio_changed flag of the entity
+	 * to 1 with new_weight == weight would re-set
+	 * the value of the weight to its ioprio mapping.
+	 * Set the flag only if necessary.
+	 */
+	if ((unsigned short)weight != bfqg->entity.new_weight) {
+		bfqg->entity.new_weight = (unsigned short)weight;
+		/*
+		 * Make sure that the above new value has been
+		 * stored in bfqg->entity.new_weight before
+		 * setting the prio_changed flag. In fact,
+		 * this flag may be read asynchronously (in
+		 * critical sections protected by a different
+		 * lock than that held here), and finding this
+		 * flag set may cause the execution of the code
+		 * for updating parameters whose value may
+		 * depend also on bfqg->entity.new_weight (in
+		 * __bfq_entity_update_weight_prio).
+		 * This barrier makes sure that the new value
+		 * of bfqg->entity.new_weight is correctly
+		 * seen in that code.
+		 */
+		smp_wmb();
+		bfqg->entity.prio_changed = 1;
+	}
+}
+
 static int bfq_io_set_weight_legacy(struct cgroup_subsys_state *css,
 				    struct cftype *cftype,
 				    u64 val)
@@ -936,34 +966,8 @@ static int bfq_io_set_weight_legacy(struct cgroup_subsys_state *css,
 	hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
 		struct bfq_group *bfqg = blkg_to_bfqg(blkg);
 
-		if (!bfqg)
-			continue;
-		/*
-		 * Setting the prio_changed flag of the entity
-		 * to 1 with new_weight == weight would re-set
-		 * the value of the weight to its ioprio mapping.
-		 * Set the flag only if necessary.
-		 */
-		if ((unsigned short)val != bfqg->entity.new_weight) {
-			bfqg->entity.new_weight = (unsigned short)val;
-			/*
-			 * Make sure that the above new value has been
-			 * stored in bfqg->entity.new_weight before
-			 * setting the prio_changed flag. In fact,
-			 * this flag may be read asynchronously (in
-			 * critical sections protected by a different
-			 * lock than that held here), and finding this
-			 * flag set may cause the execution of the code
-			 * for updating parameters whose value may
-			 * depend also on bfqg->entity.new_weight (in
-			 * __bfq_entity_update_weight_prio).
-			 * This barrier makes sure that the new value
-			 * of bfqg->entity.new_weight is correctly
-			 * seen in that code.
-			 */
-			smp_wmb();
-			bfqg->entity.prio_changed = 1;
-		}
+		if (bfqg)
+			bfq_group_set_weight(bfqg, val);
 	}
 	spin_unlock_irq(&blkcg->lock);
 
-- 
2.22.1

