Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA62B58B9F4
	for <lists+cgroups@lfdr.de>; Sun,  7 Aug 2022 08:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbiHGG7J (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 7 Aug 2022 02:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiHGG7I (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 7 Aug 2022 02:59:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC289FE6;
        Sat,  6 Aug 2022 23:58:58 -0700 (PDT)
X-UUID: e08cd86b6d3340b08fa8571304e2c95b-20220807
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=M95TLiNkwsL0QeZAeys9UAP5FWDjNm0kDQVp7WcThws=;
        b=Flz3Q0i7aGu6lCgW8bJADz/8LXyU4dgAggJHbd18fbZAsbukKzOs25mm4c0RLAEQ9WfEGz59YC3roqCUqjl0XdhH0nRjnk9/cno5J8azRbDcrHlNhkrf6uDVyrQS+h8KMWvSo8t+p26YRhB/xShZTPQbEzutHGDAFsB18nRmwn0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:b3c4d219-f0c5-403a-b01c-3e5e627b973c,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.8,REQID:b3c4d219-f0c5-403a-b01c-3e5e627b973c,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:0f94e32,CLOUDID:8493eb48-f57f-4088-93dd-066979cdb4e6,C
        OID:787d7f499164,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: e08cd86b6d3340b08fa8571304e2c95b-20220807
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <jing-ting.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1186243766; Sun, 07 Aug 2022 14:58:52 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sun, 7 Aug 2022 14:58:50 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Sun, 7 Aug 2022 14:58:50 +0800
Message-ID: <d4f8e1c0dd0a323e5cd6c850083cb126f616bc78.camel@mediatek.com>
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
Date:   Sun, 7 Aug 2022 14:58:50 +0800
In-Reply-To: <98d738ec5d7d32441f6e62278fff32201fd948de.camel@mediatek.com>
References: <1978e209e71905d89651e61abd07285912d412a1.camel@mediatek.com>
         <20220715115938.GA8646@blackbody.suse.cz>
         <YtGaP+e35DZYSQf0@slm.duckdns.org>
         <d8f0bc5e2fb6ed259f9334c83279b4c011283c41.camel@mediatek.com>
         <20220719133512.GD897@blackbody.suse.cz>
         <98d738ec5d7d32441f6e62278fff32201fd948de.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 2022-07-21 at 14:46 +0800, Jing-Ting Wu wrote:
> On Tue, 2022-07-19 at 15:35 +0200, Michal Koutný wrote:
> > On Mon, Jul 18, 2022 at 03:44:21PM +0800, Jing-Ting Wu <
> > jing-ting.wu@mediatek.com> wrote:
> > > Accroding your description, is the following patch corrent?
> > 
> > Yes, this is what I meant (i.e. grace period before invalidating
> > the
> > removed rstat_css_node).
> > 
> > > If the patch is correct, we will add this patch to our stability
> > > test.
> > > And we will continue to observe whether the problem is solved.
> > 
> > It'd be great to have such confirmation.
> 
> Thanks for confirm the patch.
> We already add patch to our stability test.
> We will reply mail if we have any update.
> 
> > 
> > Thanks,
> > Michal
> 

Hi, Michal

Use the patch of previous mail, we pass the stability test at previous
two week and still testing.

I think the patch is helpful to the syndrome.
It passed stability test over two week so far. (as-is: < one week
failed)
Do you help to upstream this patch to mainline?

Thank you.


Best regards,
Jing-Ting Wu





> 
> Best regards,
> Jing-Ting Wu

