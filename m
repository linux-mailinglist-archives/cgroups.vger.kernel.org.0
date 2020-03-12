Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBDDA1837AF
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2020 18:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgCLRdS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Mar 2020 13:33:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42907 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgCLRdS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Mar 2020 13:33:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id v11so8565634wrm.9
        for <cgroups@vger.kernel.org>; Thu, 12 Mar 2020 10:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NoiaqPMaLbyoL7WcV9VE9eKkmobOKnQ4L0s3bngIbSs=;
        b=qaWsULht3bWoY5iXQLEcDGdBTFV6hjN7lpV33RTCtB3xWc1PLX/WRxZQohX8Xrl/9w
         UmohlrmtFgTmdaoEpFrPYYLSu55234z8uvo9TnjcyiBJbYmm2fJpmw10ZPHUC3T9G4Z3
         CvKX3yFDACoE48iNQsDgNcSOYv8fqeVuxR4Rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NoiaqPMaLbyoL7WcV9VE9eKkmobOKnQ4L0s3bngIbSs=;
        b=Rxx27OaBaphEj7vWsoq88rB22uZ7/b98/aBeq0sVf1LOOd+X14dPEsagkoX7Gt9cvZ
         wJF1XINIit+K1WZUvtXeZYEH2DofYr8dADGaN2agA1L1vrnXiGf7wqxQfouztRstk9C4
         QrFC+BBJ9RkEqRvzjWFHIqZEt+a/c5O4GQR1w5yWfuKIZbyID6kxW6Kr1oMVjnAH5MoI
         T7weIppYChi8v3gOdAp3v8LLhMaG+LuOq92k02Baa6ZSPyBFFmQ7KFT2HYebl1M7JK6R
         xXXITxlEs80QVePyGbG5KX88rOyRYHSTABoOyjT/npiNyoday1hZNXSbjaT/ysz9CG+w
         2RLw==
X-Gm-Message-State: ANhLgQ2rI7V2VebEtaNaAg0/qT1oB9YTJ7ai/Ett+AfgDXiYssjYAiMg
        ilDgwtl0Ai0FWadQGI3GQGvJzw==
X-Google-Smtp-Source: ADFU+vvYbyeKzXBtFBZm5+Qqw3wXcJUdTLliut8wUu0quaYaNk9IXP08ecLQIM8cttCro0Cmn5Mn+Q==
X-Received: by 2002:a5d:63c7:: with SMTP id c7mr11956491wrw.384.1584034396977;
        Thu, 12 Mar 2020 10:33:16 -0700 (PDT)
Received: from localhost ([89.32.122.5])
        by smtp.gmail.com with ESMTPSA id o3sm14396506wme.36.2020.03.12.10.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 10:33:16 -0700 (PDT)
Date:   Thu, 12 Mar 2020 17:33:16 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 6/6] mm, memcg: Prevent mem_cgroup_protected store tearing
Message-ID: <d1e9fbc0379fe8db475d82c8b6fbe048876e12ae.1584034301.git.chris@chrisdown.name>
References: <cover.1584034301.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1584034301.git.chris@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The read side of this is all protected, but we can still tear if
multiple iterations of mem_cgroup_protected are going at the same time.

There's some intentional racing in mem_cgroup_protected which is ok, but
load/store tearing should be avoided.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@fb.com
---
 mm/memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 57048a38c75d..e9af606238ab 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6301,8 +6301,8 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 	}
 
 exit:
-	memcg->memory.emin = emin;
-	memcg->memory.elow = elow;
+	WRITE_ONCE(memcg->memory.emin, emin);
+	WRITE_ONCE(memcg->memory.elow, elow);
 
 	if (usage <= emin)
 		return MEMCG_PROT_MIN;
-- 
2.25.1

