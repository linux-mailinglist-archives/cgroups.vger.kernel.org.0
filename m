Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697EA5141B3
	for <lists+cgroups@lfdr.de>; Fri, 29 Apr 2022 07:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbiD2FU5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Apr 2022 01:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiD2FU5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Apr 2022 01:20:57 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC7866FA5
        for <cgroups@vger.kernel.org>; Thu, 28 Apr 2022 22:17:39 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bu29so12170625lfb.0
        for <cgroups@vger.kernel.org>; Thu, 28 Apr 2022 22:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=s9wfiyI3JBIiISlABF9nzSzidRhd08PN5K7/7gRJUwU=;
        b=zgh0lqmxqjAmYpfMJeInqwyar5RpKgn6nKPhjU0zE/mRkRAEOsvk01q11mzTkDptGi
         TwBcOx3EARcSI0hAy15m/EW2/0NDVnNDO95agwC6gbWdQLW4BjUE7CMli5n1iR5y8wOa
         g2LGTfB+wEs9BisfMzb6MrrgDQhrA5OanuAZ+TT5md3h2aag3jDAPyzctlDCCG97MKPQ
         e06ZJtfPG7utnP0hWSxpaUVfENEu7U2BcFuBCJbGdkJRiMjrPXJVr2P3nK0MraYFi6sz
         dmNYSv5MxKsD7AUI5Bf0T5Y0G9OWIbekQq8sNqNLeTRfjuqk1lZZeNVGgx24s+tILIfP
         7Q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s9wfiyI3JBIiISlABF9nzSzidRhd08PN5K7/7gRJUwU=;
        b=pJrxd113BnmaZWOEUHfWdjZ+zHkn1Ku7WMWsoLR9FVGaO8JRhO6fELsB7tRPQ5iHN9
         dCWoO7mTBL7eawYpkg/jlmEuoEi9vnUKblRIVouiaWGtGBOIHyiu1CJUAn2c3nh1X59u
         Bekw4HgyhCg4XODakvGG5Wo9F+QyNPF2ah/3NModZJ7Io7xkJcjYQ1poMRCDEWl8fcVn
         DBnVvcAn1K03dCMgtUbV1pMAXxhEr8Okomqt0EBACpuxJ/EpGwVuDWZXXMsgEvJHBKmn
         A7QP27fQeW4tOHXs1bAymvi4l5SUweY9TgZ3r9qHjOf0tmSBZvzCKyfoxe6DKDBWzgTF
         eNEQ==
X-Gm-Message-State: AOAM532g6YvygMwMZtxUT8iGV2dL1cpVap/EPvc3ALGAt3jTcnFgOp9W
        3vy3IhZ0YBnOhAVc4vP+cJJPfm8jYAcJ/Q==
X-Google-Smtp-Source: ABdhPJwelcg5eDVRHLImUr0uIk1M3llTR4bkoNPEBZ5hH7LEHpAFRJhhOG5cuBf+CacuskRyT5R8Qg==
X-Received: by 2002:a05:6512:902:b0:46b:c03f:19e5 with SMTP id e2-20020a056512090200b0046bc03f19e5mr26524304lft.118.1651209457725;
        Thu, 28 Apr 2022 22:17:37 -0700 (PDT)
Received: from [192.168.43.196] ([185.174.128.251])
        by smtp.gmail.com with ESMTPSA id y14-20020a19914e000000b00472085bfdf4sm141451lfj.133.2022.04.28.22.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 22:17:37 -0700 (PDT)
Message-ID: <0b28d49b-605c-ac1a-df85-643164e69039@openvz.org>
Date:   Fri, 29 Apr 2022 08:17:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: [PATCH net] net: enable memcg accounting for veth queues
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        cgroups@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>
References: <1c338b99-8133-6126-2ff2-94a4d3f26451@openvz.org>
 <20220427095854.79554fab@kernel.org>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <20220427095854.79554fab@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

veth netdevice defines own rx queues and allocates array containing
up to 4095 ~750-bytes-long 'struct veth_rq' elements. Such allocation
is quite huge and should be accounted to memcg.

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 drivers/net/veth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index d29fb9759cc9..bd67f458641a 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1310,7 +1310,7 @@ static int veth_alloc_queues(struct net_device *dev)
 	struct veth_priv *priv = netdev_priv(dev);
 	int i;
 
-	priv->rq = kcalloc(dev->num_rx_queues, sizeof(*priv->rq), GFP_KERNEL);
+	priv->rq = kcalloc(dev->num_rx_queues, sizeof(*priv->rq), GFP_KERNEL_ACCOUNT);
 	if (!priv->rq)
 		return -ENOMEM;
 
-- 
2.31.1
