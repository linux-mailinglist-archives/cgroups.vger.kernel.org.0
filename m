Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90F8718A64
	for <lists+cgroups@lfdr.de>; Wed, 31 May 2023 21:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjEaTp0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 31 May 2023 15:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjEaTpZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 31 May 2023 15:45:25 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677999F
        for <cgroups@vger.kernel.org>; Wed, 31 May 2023 12:45:23 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-517bad1b8c5so50999a12.0
        for <cgroups@vger.kernel.org>; Wed, 31 May 2023 12:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685562323; x=1688154323;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PpDJlNrnAO4fvUz0RfTCu45Wzom8uht2t6b0Eby6tSU=;
        b=CvwTOcZ+TPBW93dVo+GG+czxQgBJ4WRtQUZ1hKODLz7NuLQPGgy7BYqE7Y9Tdkzjs2
         y9tozNN7oF4sU7BsyHzJbWPgNPvoSqYlMRj7uvKxy2fkxrWhoH/SmrTTamAvlmKzi73n
         W8mGe+0pczU1OXBLkd9m6kH3YhP81peoXSGI7ypFYEQjAIAOGwvke5aVDbsNuxKBxx3g
         MOnvBekiaK0TO9D2/JhS+c/l+b0tzOEqCm96tealv8uLdXS4aRGyO8bnFdb0QJST5yjO
         WtjQXe1h3uwVrRpHfxidaBd5zAxB8fKm6q3xgsTzuj02HlikkhGtotuFCckThw1vLK4o
         eh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685562323; x=1688154323;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PpDJlNrnAO4fvUz0RfTCu45Wzom8uht2t6b0Eby6tSU=;
        b=K6MlFgbW7G0D3z1fklwN7hsoDZuCaQ3DPOXnNj++jh6/g2N+tIwRJKGf87Coigts+d
         +5GDrOQi/QJLUYfz3yuYs1vnyHx6NphlEqwNjaQtyRk8LcEF7LtuUuUmjAdypJmwS45s
         LkYVhutqFTWd1Kz0ZuzybJPkSApT+L3fhF/a54mnindbjky5QfjITZRS9pNagItgAOzh
         07CS/5hL9AtkPSACHsOA9FpPvZaE8pjE5tB2ucsWromsCc0L/qVzs3HA5RPUYC4OuceR
         9BO6dgNIWY0wbtbCCPTHdDkmuwVNUVX57tXpFqDnJKAuFzSjZG255emRxo/XJub5CXxE
         SB3w==
X-Gm-Message-State: AC+VfDz6G39KkJDGoLdFZVCvYts2zw7mEc44Jm6vM6XtWWXsFqd5Yh0M
        BSWP2lw5msPIIXV954kL4F1qY6w1+9HvQw==
X-Google-Smtp-Source: ACHHUZ7EFiKlZ4gS71wAZQDIsRXSnDj9UCINMOrYFP75CVF1jUuIsU9mLwwAaZXYcFWu4QQgX0+DtXdtklf0Dg==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a63:48c:0:b0:53f:a2d1:99d4 with SMTP id
 134-20020a63048c000000b0053fa2d199d4mr1385933pge.1.1685562322852; Wed, 31 May
 2023 12:45:22 -0700 (PDT)
Date:   Wed, 31 May 2023 19:45:20 +0000
In-Reply-To: <ZHcJUF4f9VcnyGVt@xsang-OptiPlex-9020>
Mime-Version: 1.0
References: <CH3PR11MB7345DBA6F79282169AAFE9E0FC759@CH3PR11MB7345.namprd11.prod.outlook.com>
 <20230512171702.923725-1-shakeelb@google.com> <CH3PR11MB7345035086C1661BF5352E6EFC789@CH3PR11MB7345.namprd11.prod.outlook.com>
 <CALvZod7n2yHU8PMn5b39w6E+NhLtBynDKfo1GEfXaa64_tqMWQ@mail.gmail.com>
 <CH3PR11MB7345E9EAC5917338F1C357C0FC789@CH3PR11MB7345.namprd11.prod.outlook.com>
 <CALvZod6txDQ9kOHrNFL64XiKxmbVHqMtWNiptUdGt9UuhQVLOQ@mail.gmail.com>
 <ZGMYz+08I62u+Yeu@xsang-OptiPlex-9020> <20230517162447.dztfzmx3hhetfs2q@google.com>
 <ZHcJUF4f9VcnyGVt@xsang-OptiPlex-9020>
Message-ID: <20230531194520.qhvibyyaqg7vwi6s@google.com>
Subject: Re: [PATCH net-next 1/2] net: Keep sk->sk_forward_alloc as a proper size
From:   Shakeel Butt <shakeelb@google.com>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Zhang Cathy <cathy.zhang@intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Brandeburg Jesse <jesse.brandeburg@intel.com>,
        Srinivas Suresh <suresh.srinivas@intel.com>,
        Chen Tim C <tim.c.chen@intel.com>,
        You Lizhen <lizhen.you@intel.com>,
        "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        philip.li@intel.com, yujie.liu@intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Oliver,

On Wed, May 31, 2023 at 04:46:08PM +0800, Oliver Sang wrote:
[...]
> 
> we applied below patch upon v6.4-rc2, so far, we didn't spot out performance
> impacts of it to other tests.
> 
> but we found -7.6% regression of netperf.Throughput_Mbps
> 

Thanks, this is what I was looking for. I will dig deeper and decide how
to proceed (i.e. improve this patch or work on long term approach).

