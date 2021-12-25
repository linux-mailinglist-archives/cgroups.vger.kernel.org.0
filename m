Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD87947F18A
	for <lists+cgroups@lfdr.de>; Sat, 25 Dec 2021 01:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhLYAJr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Dec 2021 19:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhLYAJq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Dec 2021 19:09:46 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCE3C061401;
        Fri, 24 Dec 2021 16:09:46 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id m21so39307343edc.0;
        Fri, 24 Dec 2021 16:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=//AViHdrOkDwbr9ESPP9D2TYL4WUSf1TSQKhaGcWJOs=;
        b=Ja/D3/ZnRALj1OtqXz6jKBTHUXDL+cBRBD9mdyU4YWX2JcI6BasWZ3eqUvwrqzV9CN
         ktlduhuv0yuX3x3rBjlMrChHQQuv2a4lbAY1IXzKLhpNm2vvVkfBCvC/4waVtB27CH2M
         +d1EPxi4bDJ6Wj2EQzEMazj4SBJI/kreutAor2Fw5+4yIpv4E6v+exUKj6fQN4dbWtZK
         lJOByPTXrHCxK/33YWF4U+2MeHRvREY+dG9f51N07WvpwImbSRamgY/R5NvdMwwM7KH4
         7OP6RCD7VraAEmc20FmYNAE9CkbGc2CGUdZuu5XcOhF+a9ED2YqS92oMJZlQ4SdLcdaq
         o19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=//AViHdrOkDwbr9ESPP9D2TYL4WUSf1TSQKhaGcWJOs=;
        b=B/x/0ttcTLwHkz1X+zyt8ZQrNp22JMvYDUOTiQYt58RQrwVgQMIpnPppwL4kprgYq5
         1C9/PclGf8Jj2V4rHaPffZZfT2V3ujlZFOPVYHcNznQ1QIZp5MIeLAaMvZMeX7cuTgbJ
         rWYkKOQjzg3pZpiYyGMyW1xfGL3e8elGS0tavQ44vSCxkBPok+duKKaxTmI1lY1iZ4eH
         BInT/NsAh4zN+DpbXyGkmK/eao2oujZLvmBbaJOmv7x1/q3V0UHggbJn5/P2UoVpysxU
         CugUVoQ2ER4x4nhFku44h7+4fQwNWV6M77QbwJoJE7jtZXwT12mhh1V+1yTuzZqvrAQg
         BQ+w==
X-Gm-Message-State: AOAM533y2IIHGHOUvm5CyvgGn5lTx8rq3/cqdcB291+WKGSV9fRSAcff
        hf3XNB7OA3yyKBfD9gF/SnA=
X-Google-Smtp-Source: ABdhPJxICviwQFUxhjkg+tGOJW8yi++z/GFnhinwpeAG33pO9zQiSO2M9XhraM+5b52XzrIlCahWag==
X-Received: by 2002:aa7:da8a:: with SMTP id q10mr7628207eds.302.1640390984771;
        Fri, 24 Dec 2021 16:09:44 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id lg17sm3007413ejb.194.2021.12.24.16.09.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Dec 2021 16:09:44 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 2/2] cgroup/rstat: check updated_next only for root
Date:   Sat, 25 Dec 2021 00:09:32 +0000
Message-Id: <20211225000932.7253-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211225000932.7253-1-richard.weiyang@gmail.com>
References: <20211225000932.7253-1-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

After commit dc26532aed0a ("cgroup: rstat: punt root-level optimization to
individual controllers"), each rstat on updated_children list has its
->updated_next not NULL.

This means we can remove the check on ->updated_next, if we make sure
the subtree from @root is on list, which could be done by checking
updated_next for root.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 kernel/cgroup/rstat.c | 46 +++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index a9d344e0521d..a00875375f7d 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -88,6 +88,7 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
 						   struct cgroup *root, int cpu)
 {
 	struct cgroup_rstat_cpu *rstatc;
+	struct cgroup *parent;
 
 	if (pos == root)
 		return NULL;
@@ -96,9 +97,12 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
 	 * We're gonna walk down to the first leaf and visit/remove it.  We
 	 * can pick whatever unvisited node as the starting point.
 	 */
-	if (!pos)
+	if (!pos) {
 		pos = root;
-	else
+		// return NULL if this subtree is not on-list
+		if (!cgroup_rstat_cpu(pos, cpu)->updated_next)
+			return NULL;
+	} else
 		pos = cgroup_parent(pos);
 
 	/* walk down to the first leaf */
@@ -115,31 +119,25 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
 	 * However, due to the way we traverse, @pos will be the first
 	 * child in most cases. The only exception is @root.
 	 */
-	if (rstatc->updated_next) {
-		struct cgroup *parent = cgroup_parent(pos);
-
-		if (parent) {
-			struct cgroup_rstat_cpu *prstatc;
-			struct cgroup **nextp;
-
-			prstatc = cgroup_rstat_cpu(parent, cpu);
-			nextp = &prstatc->updated_children;
-			while (*nextp != pos) {
-				struct cgroup_rstat_cpu *nrstatc;
-
-				nrstatc = cgroup_rstat_cpu(*nextp, cpu);
-				WARN_ON_ONCE(*nextp == parent);
-				nextp = &nrstatc->updated_next;
-			}
-			*nextp = rstatc->updated_next;
-		}
+	parent = cgroup_parent(pos);
+	if (parent) {
+		struct cgroup_rstat_cpu *prstatc;
+		struct cgroup **nextp;
 
-		rstatc->updated_next = NULL;
-		return pos;
+		prstatc = cgroup_rstat_cpu(parent, cpu);
+		nextp = &prstatc->updated_children;
+		while (*nextp != pos) {
+			struct cgroup_rstat_cpu *nrstatc;
+
+			nrstatc = cgroup_rstat_cpu(*nextp, cpu);
+			WARN_ON_ONCE(*nextp == parent);
+			nextp = &nrstatc->updated_next;
+		}
+		*nextp = rstatc->updated_next;
 	}
 
-	/* only happens for @root */
-	return NULL;
+	rstatc->updated_next = NULL;
+	return pos;
 }
 
 /* see cgroup_rstat_flush() */
-- 
2.33.1

