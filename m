Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433C86BF484
	for <lists+cgroups@lfdr.de>; Fri, 17 Mar 2023 22:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjCQVpk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Mar 2023 17:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjCQVpO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Mar 2023 17:45:14 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55AB1CAFA;
        Fri, 17 Mar 2023 14:44:27 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so6647080pjz.1;
        Fri, 17 Mar 2023 14:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679089063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VM4L650jvOHnOrzjxyybDkCmQtbFyLFT1T/BqqmyWcU=;
        b=BMtstbKLHuH8Y2UCzCOd8xm/eCyHo7c5eIYlFb96xgHM115JNQM+OFQ4k59hUkiBnE
         ftqWS3pKGpJsbiYoNoKCWwmz5P18p9hMSLR6skLG3iXxHg4OcB66U65UhRT0YDJ0d3CS
         Xs7YKbDPjetM1g4ow3EMHRk5kYw8gNzC5t7Q/4cOtnFzaZnaWjciLtLKPnC2R+8i0L/5
         2fmcfzvbGluZoFNhqL9IWuH78tneHzxy1LGIdJR8mWsc3YufBwxahT4Yz2GsXRVCRkhB
         LeNU1/n9TxwTTM5LUq83iz4V24ouqBqsjeuXJwFOu+OBPySm82YBfjILXj532EBjLu+e
         xW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679089063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VM4L650jvOHnOrzjxyybDkCmQtbFyLFT1T/BqqmyWcU=;
        b=B/riO2eaTv5w6cWumk0yAMCjV/o3JcYsQXUluaw4APp3s0yOqCBxjHyBBsjtnmFYlx
         WFcqlL4+4xzBXklwUeU0NbNMlJUmEo7R00y1KlofGKo8LNLSy7vovdtnYxbBCZWdKQdo
         D/TwnUUsGv7me06TBxwids/TIrnkn0m4K445MJBCvStJe1u+XK01L/z1BOcXnDUokPaG
         /rFQU73/mYMo9publ5XI5Xso/BpdHxrLlYqtd/QVD1Vzd0of3RMF4I93QSWlQ5F4m1Q+
         YOnj2rMsNPWRREQtojSc8dLOq/Qa8QZfhlfj8lKBQNfvA5zzhMsRf0UpCdq7Qa7i2r+r
         PUZQ==
X-Gm-Message-State: AO0yUKUFTrwi7EMUVgQPwmDTN6eCCK3kSLA+65T4+RUe5uGu8zPOzWp/
        J1boa0o5x9MopBAnXhAUe6g=
X-Google-Smtp-Source: AK7set9GNEiVxeBdO0CFGjfPfAM2MhAmu+ExOcF0+C7WJ5Hy4TYmspAyMRLBJC8H/4V/UdY+FjkJxQ==
X-Received: by 2002:a17:90a:51c5:b0:23d:4a9e:868b with SMTP id u63-20020a17090a51c500b0023d4a9e868bmr9873155pjh.31.1679089063439;
        Fri, 17 Mar 2023 14:37:43 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902b78600b0019edb3ae415sm2000828pls.14.2023.03.17.14.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:37:43 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 17 Mar 2023 11:37:41 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     longman@redhat.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset: Clean up cpuset_node_allowed
Message-ID: <ZBTdpYaBG2nJmWbL@slm.duckdns.org>
References: <9953284e-05da-56b0-047d-ecf18aa53892@redhat.com>
 <20230228083537.102665-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228083537.102665-1-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 28, 2023 at 08:35:37AM +0000, Haifeng Xu wrote:
> Commit 002f290627c2 ("cpuset: use static key better and convert to new API")
> has used __cpuset_node_allowed() instead of cpuset_node_allowed() to check
> whether we can allocate on a memory node. Now this function isn't used by
> anyone, so we can do the follow things to clean up it.
> 
> 1. remove unused codes
> 2. rename __cpuset_node_allowed() to cpuset_node_allowed()
> 3. update comments in mm/page_alloc.c
> 
> Suggested-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>

Waiman, can you review and ack?

Thanks.

-- 
tejun
