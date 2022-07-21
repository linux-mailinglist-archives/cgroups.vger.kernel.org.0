Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F77557C49F
	for <lists+cgroups@lfdr.de>; Thu, 21 Jul 2022 08:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiGUGqK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Jul 2022 02:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiGUGqK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Jul 2022 02:46:10 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E310F53D2D;
        Wed, 20 Jul 2022 23:46:08 -0700 (PDT)
X-UUID: bde30c7768594db7b4220ebd93a256e9-20220721
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:f34ef06c-0a96-4db9-9901-7f678b49630c,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.8,REQID:f34ef06c-0a96-4db9-9901-7f678b49630c,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:0f94e32,CLOUDID:8f6312d8-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:54f23d73c3e2,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: bde30c7768594db7b4220ebd93a256e9-20220721
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <jing-ting.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 431965892; Thu, 21 Jul 2022 14:46:05 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 21 Jul 2022 14:46:04 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 21 Jul 2022 14:46:03 +0800
Message-ID: <98d738ec5d7d32441f6e62278fff32201fd948de.camel@mediatek.com>
Subject: Re: [Bug] race condition at rebind_subsystems()
From:   Jing-Ting Wu <jing-ting.wu@mediatek.com>
To:     Michal =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
CC:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        "Zefan Li" <lizefan.x@bytedance.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        <wsd_upstream@mediatek.com>, <lixiong.liu@mediatek.com>,
        <wenju.xu@mediatek.com>, <jonathan.jmchen@mediatek.com>
Date:   Thu, 21 Jul 2022 14:46:03 +0800
In-Reply-To: <20220719133512.GD897@blackbody.suse.cz>
References: <1978e209e71905d89651e61abd07285912d412a1.camel@mediatek.com>
         <20220715115938.GA8646@blackbody.suse.cz>
         <YtGaP+e35DZYSQf0@slm.duckdns.org>
         <d8f0bc5e2fb6ed259f9334c83279b4c011283c41.camel@mediatek.com>
         <20220719133512.GD897@blackbody.suse.cz>
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

On Tue, 2022-07-19 at 15:35 +0200, Michal Koutný wrote:
> On Mon, Jul 18, 2022 at 03:44:21PM +0800, Jing-Ting Wu <
> jing-ting.wu@mediatek.com> wrote:
> > Accroding your description, is the following patch corrent?
> 
> Yes, this is what I meant (i.e. grace period before invalidating the
> removed rstat_css_node).
> 
> > If the patch is correct, we will add this patch to our stability
> > test.
> > And we will continue to observe whether the problem is solved.
> 
> It'd be great to have such confirmation.

Thanks for confirm the patch.
We already add patch to our stability test.
We will reply mail if we have any update.

> 
> Thanks,
> Michal



Best regards,
Jing-Ting Wu

