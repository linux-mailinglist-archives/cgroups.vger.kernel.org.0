Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54115115D2
	for <lists+cgroups@lfdr.de>; Wed, 27 Apr 2022 13:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiD0K6J (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Apr 2022 06:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiD0K6E (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Apr 2022 06:58:04 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233A33C5DA5
        for <cgroups@vger.kernel.org>; Wed, 27 Apr 2022 03:34:33 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y32so2353378lfa.6
        for <cgroups@vger.kernel.org>; Wed, 27 Apr 2022 03:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=s9wfiyI3JBIiISlABF9nzSzidRhd08PN5K7/7gRJUwU=;
        b=F1CrcAo2L4t+g24hKYKTkJrAIVD+uTem+dr8Xe28yedKWFGtVI7PftZuZcQfKZcEOu
         z8H2qRwJPsk95KVz3cKAwjeZpfThWo2YICJwhmyX38kLU48FLwyTc4X1KU+Q0seSVK8o
         SIoNSv6HijNeKMGu+McRx0LPACtUYGfr9OFlNsr53DrbB25SZKsV46crOk2U2kaEeS1v
         n73RzjxPj+Dc+8m9++UWK2PmXlExBoFRwfte8OGfQKin+2u9FYxR9RdC7gS2PlqLFCVi
         1bR/qi42emMrThTa7fgOLHgL2q7KukCh3+iI19VSkvx1t6PsRjP52JxxJxIyWn6CQNYp
         HqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=s9wfiyI3JBIiISlABF9nzSzidRhd08PN5K7/7gRJUwU=;
        b=CzRLPhQ77rtsxEp9JvRoF0YBPX2UwdvwiFvsUz3B8TivgISQXlbPVKVth5hFoZGTvw
         ddFuyiSShflrYlUTzl8JRY6AyZQmXtD3b+gicsnmvs7nQJSq61M/nGfgSOz3BHNpAnW+
         kCBDFG+8AursQ7FY0LJ2VjOKIbxOQCRN8+a7kNE43JQpHC4z5mYWOz3zZo4SQsIx1Gum
         44EC71A+ixvfymj5zrKBrX7o36kQ9IBFyvpjnO/xiI/DTqFddGEVO/pcPB1CDdqTulPK
         o34Z4bz99/G76Vadvcg0n0x1m07lCSsJ/YQeVIpbpSVJPO1fccTPFAsczONGHzebeGmB
         m9CQ==
X-Gm-Message-State: AOAM533dovmPG0d+EWaoxSTo98XVpxmpY7/Ro5ZMwbBNX0HGZxqcvmpH
        c6eOJBU47Li6YfuWYSvRHefFUw==
X-Google-Smtp-Source: ABdhPJxiTFY6rBxC2YzE+gz4kYCDHrExSRB5wTlrCu3KWfOeIv1VagTWKbAP/FWpZ11dpTHTp1793g==
X-Received: by 2002:a05:6512:228e:b0:471:9022:c4d3 with SMTP id f14-20020a056512228e00b004719022c4d3mr19562388lfu.513.1651055671334;
        Wed, 27 Apr 2022 03:34:31 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id l21-20020a194955000000b00471f0aea31fsm1762928lfj.39.2022.04.27.03.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 03:34:30 -0700 (PDT)
Message-ID: <1c338b99-8133-6126-2ff2-94a4d3f26451@openvz.org>
Date:   Wed, 27 Apr 2022 13:34:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH] memcg: enable accounting for veth queues
To:     Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

