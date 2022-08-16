Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BA75962C0
	for <lists+cgroups@lfdr.de>; Tue, 16 Aug 2022 20:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbiHPS6V (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 14:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbiHPS6T (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 14:58:19 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B710C54C84;
        Tue, 16 Aug 2022 11:58:16 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-10cf9f5b500so12655867fac.2;
        Tue, 16 Aug 2022 11:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=CzN9U8S3U5wsu3LqNuDxk2kPbUdDS4xzFtJt6PkLgao=;
        b=nEJGoYq9tv3G9+Ot3Wzbzv5hIglYLNiZQq9ZXoTqRMxHgwM8D52w9VWUrDhl3opKDD
         5oF/RI5eAvBaSJMsNaQ0q0kQCgisTMna3oT0Irfh5bOmrLnOKEftArR+a3ajnYK0gITF
         neIIREcQfSomM34o4HRxg4bKaH7isikWJMKJhysVdM7jxIOpLd8JHWGZWZMWeL+QFgQ6
         DfF9Dw6+rZWkljsnOwhdmsIhKU5wEUYGvU+RRxCm65xnOZLkqRd8OZlYjKrFAxwIuIEw
         vR/7Doj33/N+i0VuS+A/XMWQM1Kb3PZCb2sPBXCaOvEOgR/hZn5Ym/gWX/YAvkobcigl
         i02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=CzN9U8S3U5wsu3LqNuDxk2kPbUdDS4xzFtJt6PkLgao=;
        b=LbWBQqbUsvNVrRydut2gSI2w3Rq0dRIjMxy/vNPEL3eLH2jkUZl8HVy7nRsCXQNai/
         2IyxFKrx64GwuHJ3v2rh8YR5iZbM9Zcyc6ZJes6frGkHkyftTX9Kk9mZOpjsffNcofzS
         Mm7psue9WwPpFVqeJH3znOYXFPwwNYc5jRpkXXOHuh7U25W+7oaQVGGZqE2X0SF1ZTwM
         I2LFDD6Hpk12tvkePjSwr4mEneLCVwOc8KlWMGi2G0XB2TSX1cuYYtHFm8eUY+fYPnsc
         BjpTF+4Q+98ynhpWIBX+cgSmpwLWitOmcMrUiSfac8mR9qr0Q8301UWQkalJ0MMkNfjE
         SHOA==
X-Gm-Message-State: ACgBeo0zPxexVyE71qzV8BeeTS30ZutNDJQ/askccE/HPiB380fv0mX8
        URxzKrdYloApFM+m7RwFouVEsgU1xj0=
X-Google-Smtp-Source: AA6agR4rl0FHA6RdwufQUK92DccC/euhsF80M+P7ndnIahAy1WEgG8+guuxUAUPtBOUXE9E6R5+JNw==
X-Received: by 2002:a17:90b:17c8:b0:1f5:4724:981f with SMTP id me8-20020a17090b17c800b001f54724981fmr25564246pjb.205.1660676285155;
        Tue, 16 Aug 2022 11:58:05 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902e54700b0016c78aaae7fsm9471731plf.23.2022.08.16.11.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 11:58:03 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, songmuchun@bytedance.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: memcg: export workingset refault stats for cgroup v1
Date:   Tue, 16 Aug 2022 11:58:01 -0700
Message-Id: <20220816185801.651091-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Workingset refault stats are important and usefule metrics to measure
how well reclaimer and swapping work and how healthy the services are,
but they are just available for cgroup v2.  There are still plenty users
with cgroup v1, export the stats for cgroup v1.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
I do understand the development of cgroup v1 is actually stalled and
the community is reluctant to accept new features for v1.  However
the workingset refault stats are really quite useful and exporting
two new stats, which have been supported by v2, seems ok IMHO.  So
hopefully this patch could be considered.  Thanks.

 mm/memcontrol.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b69979c9ced5..e300437896dc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3975,6 +3975,8 @@ static const unsigned int memcg1_stats[] = {
 	NR_FILE_MAPPED,
 	NR_FILE_DIRTY,
 	NR_WRITEBACK,
+	WORKINGSET_REFAULT_ANON,
+	WORKINGSET_REFAULT_FILE,
 	MEMCG_SWAP,
 };
 
@@ -3988,6 +3990,8 @@ static const char *const memcg1_stat_names[] = {
 	"mapped_file",
 	"dirty",
 	"writeback",
+	"workingset_refault_anon",
+	"workingset_refault_file",
 	"swap",
 };
 
@@ -4016,7 +4020,8 @@ static int memcg_stat_show(struct seq_file *m, void *v)
 		if (memcg1_stats[i] == MEMCG_SWAP && !do_memsw_account())
 			continue;
 		nr = memcg_page_state_local(memcg, memcg1_stats[i]);
-		seq_printf(m, "%s %lu\n", memcg1_stat_names[i], nr * PAGE_SIZE);
+		seq_printf(m, "%s %lu\n", memcg1_stat_names[i],
+			   nr * memcg_page_state_unit(memcg1_stats[i]));
 	}
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_events); i++)
@@ -4047,7 +4052,7 @@ static int memcg_stat_show(struct seq_file *m, void *v)
 			continue;
 		nr = memcg_page_state(memcg, memcg1_stats[i]);
 		seq_printf(m, "total_%s %llu\n", memcg1_stat_names[i],
-						(u64)nr * PAGE_SIZE);
+			   (u64)nr * memcg_page_state_unit(memcg1_stats[i]));
 	}
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_events); i++)
-- 
2.26.3

