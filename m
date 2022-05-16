Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2E55293A0
	for <lists+cgroups@lfdr.de>; Tue, 17 May 2022 00:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbiEPWaY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 May 2022 18:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiEPWaV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 May 2022 18:30:21 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FB830F51
        for <cgroups@vger.kernel.org>; Mon, 16 May 2022 15:30:19 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id f2so15297932wrc.0
        for <cgroups@vger.kernel.org>; Mon, 16 May 2022 15:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=SfNwAhG3H0WFr7m8ORYPNz7dtqzeGJlfJ6gnUv4p940=;
        b=gj1nmb9U1n9DLHipYZgC3NBMcWDJ5bVYuNXQjOsvwVIGUIQ/CcWWoca+1jjdc5LK7s
         ifJDqlmUcsCETFXm7KLp0q5sdkd6xdCjJdVjbB2tTjE7DZcv5kfscr4ocsxgBFbeJf0D
         4gHcQ+F+EOufpbPscNALZB6Ni/Xz/mDvn1UAS5DxK1MNfhIQtSE31jX+oLsQs2jX6m/p
         0kMXKbQuuisx7dhP3sQa3Ovjr1FwNS3D5PuoCQds4MyIvlumtQjInoZSbj6fb6vGifSM
         z0Yky2cbkNNCgm+amQv5WA9eA/+pSCqh8EUpmM2xux0PZWSBvaw87/6l3rzC7k1ZejXK
         Al4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SfNwAhG3H0WFr7m8ORYPNz7dtqzeGJlfJ6gnUv4p940=;
        b=QfVrgZwK2OdVGFtZYzvo3XBxF+XeU44JX8JgeNV71o6x3EsVQ1gIBHvX42fXvy559l
         vmozx83utDyj5BdI6/35EBfik8rnjjTUHY5iEHxCSrx08D96WCQpq8W/zLBKzl8iohK7
         RB5SKyyypu1r2aN5jhwnmN3MqZY81p3Gk1jBQgPvilW4rcp43mXZZbdHFHWT1rUcCQVb
         gsAuTt4rVoLAuxIpR71OWvaw7lldzK6NXESmYjmiaaX0XapU2Fms4Sxjl+FS/Ork2+TX
         0YFj793yyQz9SY5fVsbl0cHhrnJUt+7Juv7qbMlWGOKkogXW/E5WPml7E5bWDom39TEf
         Z+ug==
X-Gm-Message-State: AOAM533CyW36483OMlGpfuwF+V0ggpZDDS0/KvFwcJwlTLnSeKE7sM7N
        OzCvytEa1bUg/V4PPHqZlqIO4c4fIq9mqX3rg/ZEqA==
X-Google-Smtp-Source: ABdhPJzpRSxX7Yzlv8maoFz3VbbYYVw1ANULRNMRGLf7c3HnLdTVCWaZEgvHobugUrcpBYsEP+sjS0F8e36by3XzzB8=
X-Received: by 2002:adf:fb05:0:b0:20a:e113:8f3f with SMTP id
 c5-20020adffb05000000b0020ae1138f3fmr16135659wrr.534.1652740218347; Mon, 16
 May 2022 15:30:18 -0700 (PDT)
MIME-Version: 1.0
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 16 May 2022 15:29:42 -0700
Message-ID: <CAJD7tkbDpyoODveCsnaqBBMZEkDvshXJmNdbk51yKSNgD7aGdg@mail.gmail.com>
Subject: [RFC] Add swappiness argument to memory.reclaim
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Yu Zhao <yuzhao@google.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The discussions on the patch series [1] to add memory.reclaim has
shown that it is desirable to add an argument to control the type of
memory being reclaimed by invoked proactive reclaim using
memory.reclaim.

I am proposing adding a swappiness optional argument to the interface.
If set, it overwrites vm.swappiness and per-memcg swappiness. This
provides a way to enforce user policy on a stateless per-reclaim
basis. We can make policy decisions to perform reclaim differently for
tasks of different app classes based on their individual QoS needs. It
also helps for use cases when particularly page cache is high and we
want to mainly hit that without swapping out.

The interface would be something like this (utilizing the nested-keyed
interface we documented earlier):

$ echo "200M swappiness=30" > memory.reclaim

Looking forward to hearing thoughts about this before I go ahead and
send a patch.

[1]https://lore.kernel.org/lkml/20220331084151.2600229-1-yosryahmed@google.com/
