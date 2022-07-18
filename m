Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329BB577CC2
	for <lists+cgroups@lfdr.de>; Mon, 18 Jul 2022 09:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbiGRHoa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Jul 2022 03:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiGRHo3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Jul 2022 03:44:29 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FC56430;
        Mon, 18 Jul 2022 00:44:28 -0700 (PDT)
X-UUID: 77c5818b06ff4a8c869c0201b6b7ce26-20220718
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:aea19736-9353-42cf-ac42-b4365d23b90c,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:54,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:54
X-CID-INFO: VERSION:1.1.8,REQID:aea19736-9353-42cf-ac42-b4365d23b90c,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:54,FILE:0,RULE:Release_HamU,ACTI
        ON:release,TS:54
X-CID-META: VersionHash:0f94e32,CLOUDID:e81dc5d7-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:0882f59e6fa7,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 77c5818b06ff4a8c869c0201b6b7ce26-20220718
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <jing-ting.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 79088243; Mon, 18 Jul 2022 15:44:23 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 18 Jul 2022 15:44:21 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 18 Jul 2022 15:44:21 +0800
Message-ID: <d8f0bc5e2fb6ed259f9334c83279b4c011283c41.camel@mediatek.com>
Subject: Re: [Bug] race condition at rebind_subsystems()
From:   Jing-Ting Wu <jing-ting.wu@mediatek.com>
To:     Tejun Heo <tj@kernel.org>,
        Michal =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        <wsd_upstream@mediatek.com>, <lixiong.liu@mediatek.com>,
        <wenju.xu@mediatek.com>, <jonathan.jmchen@mediatek.com>
Date:   Mon, 18 Jul 2022 15:44:21 +0800
In-Reply-To: <YtGaP+e35DZYSQf0@slm.duckdns.org>
References: <1978e209e71905d89651e61abd07285912d412a1.camel@mediatek.com>
         <20220715115938.GA8646@blackbody.suse.cz>
         <YtGaP+e35DZYSQf0@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 2022-07-15 at 06:47 -1000, Tejun Heo wrote:
> (resending, I messed up the message header, sorry)
> 
> Hello,
> 
> On Fri, Jul 15, 2022 at 01:59:38PM +0200, Michal Koutný wrote:
> > The css->rstat_css_node should not be modified if there are
> > possible RCU
> > readers elsewhere.
> > One way to fix this would be to insert synchronize_rcu() after
> > list_del_rcu() and before list_add_rcu().
> > (A further alternative (I've heard about) would be to utilize
> > 'nulls'
> > RCU lists [1] to make the move between lists detectable.)
> > 
> > But as I'm looking at it from distance, it may be simpler and
> > sufficient
> > to just take cgroup_rstat_lock around the list migration (the
> > nesting
> > under cgroup_mutex that's held with rebind_subsystems() is fine).
> 
> synchronize_rcu() prolly is the better fit here given how that
> list_node's
> usage, but yeah, great find.
> 
> Thanks.
> 

Hi Michal and Tejun,


Thanks for your suggestion.
Accroding your description, is the following patch corrent?

--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1813,6 +1813,7 @@
 
 		if (ss->css_rstat_flush) {
 			list_del_rcu(&css->rstat_css_node);
+			synchronize_rcu();
 			list_add_rcu(&css->rstat_css_node,
 				     &dcgrp->rstat_css_list);
 		}


If the patch is correct, we will add this patch to our stability test.
And we will continue to observe whether the problem is solved.
Thank you.




Best regards,
Jing-Ting Wu

