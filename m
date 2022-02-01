Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02CB4A543F
	for <lists+cgroups@lfdr.de>; Tue,  1 Feb 2022 01:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiBAArC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 19:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiBAArC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 19:47:02 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CD4C06173B;
        Mon, 31 Jan 2022 16:47:01 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id r10so30751718edt.1;
        Mon, 31 Jan 2022 16:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GYfi12SpmN0g9NqCoQ6tYL22xFi8Uo1iR/vTcnK9fck=;
        b=M8JyDPdDdfrEs1luJVidkqPn7+qgD4TNYcQAXFMm0RPY0nfJUSyFdHSYKBx3dzqcfJ
         wjDKrCKhJEa/VH4upcSnRwzq43GqdetPEPK02terNMKeobZISvpFpg+OLMKkXJIiRohZ
         RKqi01JwhYCy97rwRMiRDbzaxzb7rFt6NuXoaObwhZSU6MTauJT/320Lbr2K3otV2rLo
         Nuw4NPg3mzoRAe6gyu1kt9BqCIoF+9Xk5c/wWEfuPFviHOP6UP8XDExpwUO22re57moT
         9zqp6p8fUCanOl1R2fgrr3/wsQNlHOg0JwBcUVs2xoTaxLS7VIuHmzQwu7gj1gXlEdkW
         cIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GYfi12SpmN0g9NqCoQ6tYL22xFi8Uo1iR/vTcnK9fck=;
        b=lWCj96RU7ErJ0JWpqWoH+W1KB5RLRs5sdHqADQNlR36KWqbc6UBvDajoiw+vrmJCud
         mBAkG0vn0QAsh1zXNPqH5ZMk+cJ5jhIpGgt8UuiRHLSRGEqa75UZhsyHxpyem6FLoCTS
         C6Rnzph0hWLEXTS0k4NkgJFzdb0DaHVkUxP0enj15l630QPqFfex7oF38c/QB9j+39l0
         sshHPTKr9W3/48aTyrCvXwf4TDzKy7ezYrIAZ/e8sruTRU3kPTO+9TWMmL4MNwRpdgre
         GyRMiR143vGH3p0nCmbjVOkHfWOPeoxY72gAEuPE4PJWyYcQrPa4iRsUpGH0GjAw0S2J
         zyOA==
X-Gm-Message-State: AOAM530I9sSfE5a5astSOYeBLa3LmbCdwg2wEcLPOLTNwRTnA8N7SEDU
        vmUpr1UgmBfUqo9A6sjggmmQYTD6agY=
X-Google-Smtp-Source: ABdhPJxlpF/0P8RQcRZyxNk3LwNbmTSQP+mAUSu26uEJPUvLBUp70MI2dhcbvJ2xJt+TjQ5nHnrtPw==
X-Received: by 2002:a05:6402:228e:: with SMTP id cw14mr23041894edb.378.1643676420231;
        Mon, 31 Jan 2022 16:47:00 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id gv34sm13977377ejc.125.2022.01.31.16.46.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Jan 2022 16:46:59 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        willy@infradead.org, songmuchun@bytedance.com, shy828301@gmail.com,
        surenb@google.com
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 2/2] mm/memcg: retrieve parent memcg from css.parent
Date:   Tue,  1 Feb 2022 00:46:43 +0000
Message-Id: <20220201004643.8391-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220201004643.8391-1-richard.weiyang@gmail.com>
References: <20220201004643.8391-1-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The parent we get from page_counter is correct, while this is two
different hierarchy.

Let's retrieve the parent memcg from css.parent just like parent_cs(),
blkcg_parent(), etc.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0c5c403f4be6..12bf443f7b14 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -886,9 +886,7 @@ static inline struct mem_cgroup *lruvec_memcg(struct lruvec *lruvec)
  */
 static inline struct mem_cgroup *parent_mem_cgroup(struct mem_cgroup *memcg)
 {
-	if (!memcg->memory.parent)
-		return NULL;
-	return mem_cgroup_from_counter(memcg->memory.parent, memory);
+	return mem_cgroup_from_css(memcg->css.parent);
 }
 
 static inline bool mem_cgroup_is_descendant(struct mem_cgroup *memcg,
-- 
2.33.1

