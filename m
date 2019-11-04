Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD45EF182
	for <lists+cgroups@lfdr.de>; Tue,  5 Nov 2019 01:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbfKDX76 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Nov 2019 18:59:58 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41322 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730113AbfKDX75 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Nov 2019 18:59:57 -0500
Received: by mail-qt1-f196.google.com with SMTP id o3so26754809qtj.8;
        Mon, 04 Nov 2019 15:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SQgKhoULLgpN26sBK1npG8blVNvYYPuT5k6zRrCfbuc=;
        b=E9gf9aVvFMkz1lD8vFX9/CcbHC1OyTNXGazo/M1XsS1m3bhgmD+UvjrqrlJ65k5wI7
         qQ66oJXI10YCmqviDik0+MwQabB1EEcF5rQoqQ4QsxryfL9RDHvL0xStAkQv4/Qd+We3
         FWz08V0STScpMZC8fAGN9NGH0imGFgjf2+kynhuHZHNgC9hYcItUeaz3/EHOXGeGxFk2
         np8T8yuyjfUW31mmSwIEhstNfNFc1buNpHsw2DB5UyTOG9TYJG2BDxiVbUCeAdkw/jbY
         dMkbbXBTjGrLh16j+LcsSxsF5ZDveaz8/17s0ioH+umtvFGVazB6Lea+WoVTgL8XbKZ6
         WG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=SQgKhoULLgpN26sBK1npG8blVNvYYPuT5k6zRrCfbuc=;
        b=rcGYoxEP8doGQ/2TA25+mHiMVZI+gjvvoslDNB6FugvG14hEzlZ/2OPBBCn0C8lc4z
         iNczqeshNuf5GAX+WtE5kQ2Po+to/eZYQyhEAvVaA8zvfIZhHpm/pPd1WDNA2AVy11/V
         IbOtnlm+jPPK6vN8+zVKOxtK19uE26JAGK136hDoOwOVOBzjMWgmIynCEurbymelcF/+
         rGQ2ONsLuTWIgSdFkWe9tpdEvq6Nxzj4pOkJctOUnK9ZBTi6YgafmZTSBwjXcKfFirZJ
         mkBOCp3lipIU4nAVkbbnZLcuIQ2tqB6nlGlmystbOkLnnf57C5y8KAEAH+DS5DKPl554
         zYfQ==
X-Gm-Message-State: APjAAAUoKEGe6pURGSmQOVyuaex9aXcLWpjQLLNr+95sYn+I/kVGnt1J
        h3CT3vjBQ5ZqLIg1px1y4m+xdI0W
X-Google-Smtp-Source: APXvYqwPMzn6Ks77SqF5/H7qSzj6/LDaU4AvNaOILEU4jpc1+gZZlK+l2HH9j/qNTnifsbTRqvQHUQ==
X-Received: by 2002:ac8:5317:: with SMTP id t23mr15318686qtn.228.1572911995153;
        Mon, 04 Nov 2019 15:59:55 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:51f8])
        by smtp.gmail.com with ESMTPSA id r126sm9448800qke.98.2019.11.04.15.59.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 15:59:54 -0800 (PST)
From:   Tejun Heo <tj@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        namhyung@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Tejun Heo <tj@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH 03/10] netprio: use css ID instead of cgroup ID
Date:   Mon,  4 Nov 2019 15:59:37 -0800
Message-Id: <20191104235944.3470866-4-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104235944.3470866-1-tj@kernel.org>
References: <20191104235944.3470866-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

netprio uses cgroup ID to index the priority mapping table.  This is
currently okay as cgroup IDs are allocated using idr and packed.
However, cgroup IDs will be changed to use full 64bit range and won't
be packed making this impractical.  netprio doesn't care what type of
IDs it uses as long as they can identify the controller instances and
are packed.  Let's switch to css IDs instead of cgroup IDs.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Neil Horman <nhorman@tuxdriver.com>
Cc: Namhyung Kim <namhyung@kernel.org>
---
Hello,

This is to prepare for kernfs 64bit ino support.  It'd be best to
route this with the rest of kernfs patchset.

Thanks.

 include/net/netprio_cgroup.h | 2 +-
 net/core/netprio_cgroup.c    | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/netprio_cgroup.h b/include/net/netprio_cgroup.h
index cfc9441ef074..dec7522b6ce1 100644
--- a/include/net/netprio_cgroup.h
+++ b/include/net/netprio_cgroup.h
@@ -26,7 +26,7 @@ static inline u32 task_netprioidx(struct task_struct *p)
 
 	rcu_read_lock();
 	css = task_css(p, net_prio_cgrp_id);
-	idx = css->cgroup->id;
+	idx = css->id;
 	rcu_read_unlock();
 	return idx;
 }
diff --git a/net/core/netprio_cgroup.c b/net/core/netprio_cgroup.c
index 256b7954b720..8881dd943dd0 100644
--- a/net/core/netprio_cgroup.c
+++ b/net/core/netprio_cgroup.c
@@ -93,7 +93,7 @@ static int extend_netdev_table(struct net_device *dev, u32 target_idx)
 static u32 netprio_prio(struct cgroup_subsys_state *css, struct net_device *dev)
 {
 	struct netprio_map *map = rcu_dereference_rtnl(dev->priomap);
-	int id = css->cgroup->id;
+	int id = css->id;
 
 	if (map && id < map->priomap_len)
 		return map->priomap[id];
@@ -113,7 +113,7 @@ static int netprio_set_prio(struct cgroup_subsys_state *css,
 			    struct net_device *dev, u32 prio)
 {
 	struct netprio_map *map;
-	int id = css->cgroup->id;
+	int id = css->id;
 	int ret;
 
 	/* avoid extending priomap for zero writes */
@@ -177,7 +177,7 @@ static void cgrp_css_free(struct cgroup_subsys_state *css)
 
 static u64 read_prioidx(struct cgroup_subsys_state *css, struct cftype *cft)
 {
-	return css->cgroup->id;
+	return css->id;
 }
 
 static int read_priomap(struct seq_file *sf, void *v)
@@ -237,7 +237,7 @@ static void net_prio_attach(struct cgroup_taskset *tset)
 	struct cgroup_subsys_state *css;
 
 	cgroup_taskset_for_each(p, css, tset) {
-		void *v = (void *)(unsigned long)css->cgroup->id;
+		void *v = (void *)(unsigned long)css->id;
 
 		task_lock(p);
 		iterate_fd(p->files, 0, update_netprio, v);
-- 
2.17.1

