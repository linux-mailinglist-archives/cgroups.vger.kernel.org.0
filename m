Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F50551BF09
	for <lists+cgroups@lfdr.de>; Thu,  5 May 2022 14:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359710AbiEEMRQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 May 2022 08:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359705AbiEEMRM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 May 2022 08:17:12 -0400
Received: from mail-oa1-x63.google.com (mail-oa1-x63.google.com [IPv6:2001:4860:4864:20::63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36327648
        for <cgroups@vger.kernel.org>; Thu,  5 May 2022 05:13:31 -0700 (PDT)
Received: by mail-oa1-x63.google.com with SMTP id 586e51a60fabf-deb9295679so4007572fac.6
        for <cgroups@vger.kernel.org>; Thu, 05 May 2022 05:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:dkim-signature:date:from:to:cc:subject
         :message-id:content-disposition:user-agent;
        bh=t7IyGM1PKLvCYj6DQvv6UjWdSV7ltvFKCoW393kXRNw=;
        b=TW4D1XmL0RbBMV6pER4/giUUhc3BIiwSUIYXAjluWaaMC/hU92kR6ZY51wFIWbq+Hr
         u6DtEQSmxCpOUjNzOP1qvbTV9K9mIG/dNFykEYmV708TxfUc9T5jHWdmvXD2/w37Ig43
         OhcnN+klZAs/LDyD+EqNyEsA38+7A39BIFjfwPs9h+RQ05rL24CULQanUSzQlSbUMUq3
         ICfYTcfBNWsvCEek8e838/1rzBobK9WjKYVgWUgDmSiyLDl5Xn7ZlC0vb7+sbg5xA1c3
         ayRkz6GWTTJQzqawKiOl44/dtUT4OYnuieGv7SboKu5ZSNAHTiD9FjMMFtlJS5RhKeV3
         Mstg==
X-Gm-Message-State: AOAM532SgP/NBmwJjeTu2aKOngDGNrd+qqN4aUsA75KxHXojJB3bAdvO
        PxXIdVoCdod8NS280x3oSdBVuzA/Rg8MS4OGtxtR08xo7xuK
X-Google-Smtp-Source: ABdhPJxUkvnIikJ8E1BXEQ5yQQkxhwMXWA/OpLAcn/gt3X4vfgcVDWDzHy+KFmDWVoeLGB5zxWMtyAUJ90dN
X-Received: by 2002:a05:6870:42cc:b0:ed:5822:c10e with SMTP id z12-20020a05687042cc00b000ed5822c10emr1981057oah.171.1651752810988;
        Thu, 05 May 2022 05:13:30 -0700 (PDT)
Received: from smtp.aristanetworks.com (mx.aristanetworks.com. [162.210.129.12])
        by smtp-relay.gmail.com with ESMTPS id 24-20020a05687010d800b000edd6d3a87asm88495oar.38.2022.05.05.05.13.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 May 2022 05:13:30 -0700 (PDT)
X-Relaying-Domain: arista.com
Received: from us192.sjc.aristanetworks.com (us192.sjc.aristanetworks.com [10.243.24.7])
        by smtp.aristanetworks.com (Postfix) with ESMTP id 46A4D53222C;
        Thu,  5 May 2022 05:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1651752810;
        bh=t7IyGM1PKLvCYj6DQvv6UjWdSV7ltvFKCoW393kXRNw=;
        h=Date:From:To:Cc:Subject:From;
        b=E1j+U2hl6CofJ8uiprGDIHpGd2TFUWswYtuDc/9R27b1EB7Y69W7zoVvtRffljx5Z
         sjAYQQ0Kpsd/xuo7Tk3grwQCOvgXO4VBje31QSr4qeRkDyuL/TgSBrTvHDAByWyGmL
         piIhedVavXg/djHKPya8N8MoAAJoSqgNURHEG0NZ6V/+86tbzw2LTJrI0V/j8ZrAkE
         uNov92hP4YCmKgaktYB+WeffKims7dHVH62bxVsTXc+FiK+lfQ2jGVR8TYDjJxKL50
         8/fEfu+s+495H7MKCSyZnSFJj9QGwIbqC6BhnKFlvxq8C+2wPRHN+4EnMxYHpd5M1z
         AY2l58vGnkRDA==
Received: by us192.sjc.aristanetworks.com (Postfix, from userid 10278)
        id 28A5E6A40F6E; Thu,  5 May 2022 05:13:30 -0700 (PDT)
Date:   Thu, 5 May 2022 05:13:30 -0700
From:   Ganesan Rajagopal <rganesan@arista.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org, rganesan@arista.com
Subject: [PATCH] mm/memcontrol: Export memcg->watermark via sysfs for v2 memcg
Message-ID: <20220505121329.GA32827@us192.sjc.aristanetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

v1 memcg exports memcg->watermark as "memory.mem_usage_in_bytes" in
sysfs. This is missing for v2 memcg though "memory.current" is exported.
There is no other easy way of getting this information in Linux.
getrsuage() returns ru_maxrss but that's the max RSS of a single process
instead of the aggregated max RSS of all the processes. Hence, expose
memcg->watermark as "memory.watermark" for v2 memcg.

Signed-off-by: Ganesan Rajagopal <rganesan@arista.com>
---
 mm/memcontrol.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 725f76723220..57ed07deff3e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6098,6 +6098,14 @@ static u64 memory_current_read(struct cgroup_subsys_state *css,
 	return (u64)page_counter_read(&memcg->memory) * PAGE_SIZE;
 }
 
+static u64 memory_watermark_read(struct cgroup_subsys_state *css,
+				 struct cftype *cft)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+
+	return (u64)memcg->memory.watermark * PAGE_SIZE;
+}
+
 static int memory_min_show(struct seq_file *m, void *v)
 {
 	return seq_puts_memcg_tunable(m,
@@ -6361,6 +6369,11 @@ static struct cftype memory_files[] = {
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = memory_current_read,
 	},
+	{
+		.name = "watermark",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = memory_watermark_read,
+	},
 	{
 		.name = "min",
 		.flags = CFTYPE_NOT_ON_ROOT,
-- 
2.28.0

