Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9A97B8D70
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 21:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244298AbjJDTb6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Oct 2023 15:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244749AbjJDTbo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Oct 2023 15:31:44 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599CF90;
        Wed,  4 Oct 2023 12:31:41 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c60a514f3aso972225ad.3;
        Wed, 04 Oct 2023 12:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696447901; x=1697052701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W5HfVM4fCCGY68ob5MM+ty4dyWUo6GBaDagauhTzLa4=;
        b=Oa4MzZ0JEIgnoPl4BhpcvNMRm+cW1j9ZmGBxLQ04OuZTUIumiSBxsMI+kZ732pMQxo
         ROAWWtOF9hCO4+tXRrpEuQdwWbcbnAfitkThEjtqtpzF3lDxFqGIa53Lh/Oef7Gm9A7o
         6ayfbiL99VoEOReq4xUvUG1/2703xw9ZawpExyMeWVX0r0o+Vdp/kEhRS+UPmqAbv69L
         BJC33+qhGI8XP7/wFEYatGuzWHFiPyOroAiHLe/OJrXoVZFmaiJPCiWAFdwmV/5Sgd56
         T8qmOwNY1Z31JoLpYhbhYPqIxihmiNFH7wfo3Uzbb7qVorkaIeTuVvDI6zTFluqY7WSD
         H1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696447901; x=1697052701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5HfVM4fCCGY68ob5MM+ty4dyWUo6GBaDagauhTzLa4=;
        b=A8qR6aTvNELXhIE4NdlAwbyFhz9ma4FUNYa2S5OLzu6VqyzSphUaYd8cNVw0Tw+8Ba
         8lf7fpdBLR+Bt9Pn/Jqrlzsu258YBoPX8dHj7280FZpPQ1rnMzm9506XujNFtSsGEnye
         +JGrdKa9RcQy5b8DBFMaTjkiQmxpcWoNn1E5AtGxCCJPx9Vkignv6ESZfxu777SYqyuh
         qd17qP1IkCd+ASkZ4F3HcyEfPEKj+FY2lbt8tj3tZ6PNsvMy14bbwbAI6uRfIY+9R9oC
         Ammqpz4LVnYq9A4JTXlowpK+Wc2YnUDQprVJ8RXUBO6spYAle3nWMLTcig3JIExXEMxQ
         fwxg==
X-Gm-Message-State: AOJu0YxJUQzZLvsyTgNgjCleZ4DwmT0YGQ2gf+SFvZTTETfnm6nFVNGi
        31vw9crrhFXqr9X7j2HYkpk=
X-Google-Smtp-Source: AGHT+IGZVPAbnXzw1VU0d3EYLakJJsXUlO6LA/FUAriMf/+lkcNF8C6IYLBjMpnG89KJvtciD7X+lQ==
X-Received: by 2002:a17:902:6946:b0:1bf:27a2:b52b with SMTP id k6-20020a170902694600b001bf27a2b52bmr3238653plt.58.1696447900827;
        Wed, 04 Oct 2023 12:31:40 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:cef])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b001bc6e6069a6sm4079064plh.122.2023.10.04.12.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 12:31:40 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 4 Oct 2023 09:31:38 -1000
From:   Tejun Heo <tj@kernel.org>
To:     linan666@huaweicloud.com
Cc:     josef@toxicpanda.com, axboe@kernel.dk, yukuai3@huawei.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linan122@huawei.com,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] blk-throttle: Calculate allowed value only when the
 throttle is enabled
Message-ID: <ZR29mvoQMxcZcppw@slm.duckdns.org>
References: <20230928015858.1809934-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928015858.1809934-1-linan666@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Sep 28, 2023 at 09:58:58AM +0800, linan666@huaweicloud.com wrote:
> From: Li Nan <linan122@huawei.com>
> 
> When the throttle of bps is not enabled, tg_bps_limit() returns U64_MAX,
> which is be used in calculate_bytes_allowed(), and divide 0 error will
> happen.

calculate_bytes_allowed() is just

  return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64)HZ); 

The only division is by HZ. How does divide by 0 happen?

Thanks.

-- 
tejun
