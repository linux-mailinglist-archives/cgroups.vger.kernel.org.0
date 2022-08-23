Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5727C59D051
	for <lists+cgroups@lfdr.de>; Tue, 23 Aug 2022 07:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236517AbiHWFLT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Aug 2022 01:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiHWFLT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Aug 2022 01:11:19 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED91BF7F;
        Mon, 22 Aug 2022 22:11:13 -0700 (PDT)
X-UUID: e23580cfd354418cb259c541853515fd-20220823
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ijokMmJKsT0+CBQ8Gdmv6lUHjb9/6ryw7rMwmSGnkVw=;
        b=GByrc0r3KGPbaCEiHMyIryxylUl/rH/AF3p/EIBetbHVoteuc28GINy4DQQZhC3G2vtFfGpjEJ+1SbHZR1GNitPZLcOFZVjjvOA0V8hjwNaJS4C1FSSXg/ilHhI1NBN5o83jhC6g0jQfHM9dOU72A7+kJD5dJRLpoxhkAXvsodU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:90c676c6-7bd7-47ce-bdb3-a80e92190630,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Relea
        se_Ham,ACTION:release,TS:95
X-CID-INFO: VERSION:1.1.10,REQID:90c676c6-7bd7-47ce-bdb3-a80e92190630,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS
        981B3D,ACTION:quarantine,TS:95
X-CID-META: VersionHash:84eae18,CLOUDID:69ca0168-a9d9-4672-a3c8-12721739a220,C
        OID:973335c3ec86,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e23580cfd354418cb259c541853515fd-20220823
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <jing-ting.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 498602566; Tue, 23 Aug 2022 13:11:08 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 23 Aug 2022 13:11:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 23 Aug 2022 13:11:06 +0800
From:   Jing-Ting Wu <Jing-Ting.Wu@mediatek.com>
To:     =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <Jonathan.JMChen@mediatek.com>, <Lixiong.Liu@mediatek.com>,
        <wsd_upstream@mediatek.com>, <Wenju.Xu@mediatek.com>,
        Jing-Ting Wu <Jing-Ting.Wu@mediatek.com>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/1] cgroup: Fix race condition at rebind_subsystems()
Date:   Tue, 23 Aug 2022 13:09:41 +0800
Message-ID: <20220823050943.28619-1-Jing-Ting.Wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Root cause:
The rebind_subsystems() is no lock held when move css object from A
list to B list,then let B's head be treated as css node at
list_for_each_entry_rcu().

Solution:
Add grace period before invalidating the removed rstat_css_node.

Suggested-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Jing-Ting Wu <Jing-Ting.Wu@mediatek.com>
---
 kernel/cgroup/cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index ffaccd6373f1..0d0c959966ed 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1820,6 +1820,7 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 
 		if (ss->css_rstat_flush) {
 			list_del_rcu(&css->rstat_css_node);
+			synchronize_rcu();
 			list_add_rcu(&css->rstat_css_node,
 				     &dcgrp->rstat_css_list);
 		}
-- 
2.18.0

