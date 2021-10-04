Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB0D420797
	for <lists+cgroups@lfdr.de>; Mon,  4 Oct 2021 10:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhJDIv3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Oct 2021 04:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhJDIv1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Oct 2021 04:51:27 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A246C061745;
        Mon,  4 Oct 2021 01:49:38 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r18so61764618edv.12;
        Mon, 04 Oct 2021 01:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OexIHL7yzlEUfmmS4I0SOBuDrj/gY0LWs9jL52+pYx8=;
        b=dVemWq3a+2beKnz+1YiJJNW7FjJjN+OMKxBI84+hIT78TOpTeokN1DKavY06NryK/G
         NSlkpM3BEIz/E0QR0Vuc1mDjYlW2qc1JQNFOx+uPebZib3UiQj5abKYXuW2qS6/CFWXw
         9ekjXV0RAfOt9Z/qAg14xStUshEMGk6hfUd5u7jhudiQdowDJ7WpYKwaTkPx8bXwIcHU
         CAOrs1p0ezq+CElVjzy/BjgVVOdKTohTdD31IHlhuQrjkGYO8VsGRwtkJ1CXydpypGPD
         ENSepy47rm13rLAIbt02xFUF42yUX/VjML4/KvrY/JsnMN9iz7sukRqSYIuX/rp+dqBt
         jBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OexIHL7yzlEUfmmS4I0SOBuDrj/gY0LWs9jL52+pYx8=;
        b=sDa+L2J8wRfUyAQHYZ/AxncwF2kIUdT02GAaMjuv3ky55MVvsCFRz02p70KMliIjH/
         SN/APXgHUCV8z4CU4oGJpf9eNdUkV/ae9moqLZ2cgC+/ssIcRHKMXgPIMK9YRyqWBViy
         zNaSayJAdqu+JaPe0EDLA4pb7+ZqxHw2zRV83oDgjbp8xfyIokiBTVGcIGRGfiA7fvP/
         PJly14q/8MwThDzdDKhj944TQ0ruoFyVnS2HdgT6yVTZdkTNsMax6dIgUzTGoBNF8hPj
         lXAU4Idl3EwCFNA1JGkjyAiAUkxmocTe/0jFmfWmb/bP4kyQcXZ+0rvLBlUeyRPXu/LP
         N2Xw==
X-Gm-Message-State: AOAM532yNsoWMN4OuCz8PzUVGB3X372/cTL5edrZvBP4EPdSyrEJz4gP
        Q7TDKfYM12M0AvWU4Lc+Tp1oyWuWlt4=
X-Google-Smtp-Source: ABdhPJzaKAs8L7W912RsveXF3iNq96aFo1bfGteyhbOrbHG3IbMzLfCKT6DUunLobPY0pKdObkpPLA==
X-Received: by 2002:a17:906:2b84:: with SMTP id m4mr15662756ejg.179.1633337375880;
        Mon, 04 Oct 2021 01:49:35 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id q17sm6962651edd.57.2021.10.04.01.49.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Oct 2021 01:49:35 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 4/4] cgroup: use parent directly instead of cgroup_parent()
Date:   Mon,  4 Oct 2021 08:49:28 +0000
Message-Id: <20211004084928.17622-4-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211004084928.17622-1-richard.weiyang@gmail.com>
References: <20211004084928.17622-1-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

During cgroup_create(), we are sure who is our parent.

Let's use parent directly instead of fetch it from cgroup hierarchy.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 457353aeb0ca..694b1c7803c2 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5368,7 +5368,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 	cgrp->self.serial_nr = css_serial_nr_next++;
 
 	/* allocation complete, commit to creation */
-	list_add_tail_rcu(&cgrp->self.sibling, &cgroup_parent(cgrp)->self.children);
+	list_add_tail_rcu(&cgrp->self.sibling, &parent->self.children);
 	atomic_inc(&root->nr_cgrps);
 	cgroup_get_live(parent);
 
-- 
2.23.0

