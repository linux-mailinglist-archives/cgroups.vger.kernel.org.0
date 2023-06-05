Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E11722E50
	for <lists+cgroups@lfdr.de>; Mon,  5 Jun 2023 20:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbjFESGM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Jun 2023 14:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbjFESF4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Jun 2023 14:05:56 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C3C10FD;
        Mon,  5 Jun 2023 11:05:05 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-256931ec244so4382252a91.3;
        Mon, 05 Jun 2023 11:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685988300; x=1688580300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2136RPrE8cIqKFm6zKV8pbC6YzWjr8qGOFW6BAbSLU=;
        b=JlVEo8WjgnOT89+kJYMSrKxEpAoprSjV4/2bNXjFC/7jh3lUEN0ff4hOOeUv+EgfOu
         wGmYHMvrCFJo18+Lj0Ff3lCTRgDTsp+dprXa8SKYXVV0oqA63oDU4WYJNhOnhZnp4cjP
         Nos7N88L+AFufa1BC/J3cKCMwyjRwdfaAxaILKfVDPEiAc5CLuTex8Y9LjPEsY7ISPIU
         OZqcON9mDAoMNWeba1eD72jSl3NYCWJI8Wju+vbW/BsvCfj93bf5jaSyBLt2jv1+VOzo
         KPlDGWq9wwdAcA4AcrMCq5fiaqK4S0SYH3qSnABSs2xiDx1PiBSoF0SFkKQW8FHC3ygB
         GmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685988300; x=1688580300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2136RPrE8cIqKFm6zKV8pbC6YzWjr8qGOFW6BAbSLU=;
        b=X5jdqxDFastSD/3GedwpkDfCvVwcxhZtHMYu80ft5OdPwJRbpmw5v1HTODaF4KHfvY
         OrPLWDsohN7/FOGjUI1Ek8y+Jw/g6Y6iQrSABkXxEBT9fRdf3imw09ZNMH9AvWDQ7zrY
         BjdNKfe1SBvzqbAbWWCb8mlkFTq067zau2yySkvfELtdRYyhLgNhbSYY1aq2vp7i02J3
         pBhY7JH7Ad6D1llD+lvGOQ+22UHlyI4FIdYQML8MuHH7L9W3BNNbovhtSFc8dOHN8iI/
         ZlxUU/1WIRVB4Y4JvLb7XodQ7IADJxsZ6axdQCyYcJnHde2I/2EmHuHNtvYuyphCneCn
         RA4Q==
X-Gm-Message-State: AC+VfDxvnqGQh8lfVRxpVEgfzv/buzbXXj9CGe+5yurCF4xmAnMw0x+M
        LqCNPbJRUD9OWTTjlCSIcqHpIpKX41U=
X-Google-Smtp-Source: ACHHUZ4G5EbFEVFbUgHvfDHyn+GEx/ry6DCqp1Kux+aO+qXvM8xy/gYHe7hg0/NgUrngbL6UptTM4A==
X-Received: by 2002:a17:90a:5e09:b0:256:d262:e686 with SMTP id w9-20020a17090a5e0900b00256d262e686mr8223342pjf.19.1685988299873;
        Mon, 05 Jun 2023 11:04:59 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id m6-20020a17090a34c600b00256471db12bsm6534599pjf.8.2023.06.05.11.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 11:04:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 5 Jun 2023 08:04:57 -1000
From:   Tejun Heo <tj@kernel.org>
To:     linan666@huaweicloud.com
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] blk-iocost: use spin_lock_irqsave in
 adjust_inuse_and_calc_cost
Message-ID: <ZH4jya9ksKbHEf7s@slm.duckdns.org>
References: <20230527091904.3001833-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230527091904.3001833-1-linan666@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, May 27, 2023 at 05:19:04PM +0800, linan666@huaweicloud.com wrote:
> From: Li Nan <linan122@huawei.com>
> 
> adjust_inuse_and_calc_cost() use spin_lock_irq() and IRQ will be enabled
> when unlock. DEADLOCK might happen if we have held other locks and disabled
> IRQ before invoking it.
> 
> Fix it by using spin_lock_irqsave() instead, which can keep IRQ state
> consistent with before when unlock.
...
> Fixes: b0853ab4a238 ("blk-iocost: revamp in-period donation snapbacks")
> Signed-off-by: Li Nan <linan122@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
