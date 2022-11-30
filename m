Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6C263E2D5
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 22:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiK3VgL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 16:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiK3VgK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 16:36:10 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C9F9135F;
        Wed, 30 Nov 2022 13:36:10 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so3254054pjc.3;
        Wed, 30 Nov 2022 13:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eK6V1Iwqa8K2Cx4KZBhR6JdQyqcABL42POC5cN5uPd8=;
        b=hLqeV7uirai+WjRpqhtSE0U3RAdVMqJVdFGUPQL0QBlYwqYbxRVGxmZuLy4C7svch8
         rUpcA46/fiSWdxgqy/Xneo1ADSX2ac2tEJeZZv4LpRUMaMogrJd3f1X5vG6IwZxXt9yb
         YGXC2tNer8sHejbOuUg9T8QFikzVXopGQN+qJwUTzjAppe0y+G6q0gimx/QyauhPxDc1
         KdrkkzgxP9uONjaH60oXkm/233B2SwcsWyhp5F1EFa6pfhKGfH6t1S2WVbqb1OSR6rDZ
         062xhcp8WkK7/ILwpuL+1V6j2ae+6uV9zjJiYTbM1j5dg+I+iy2y6HK18XlTiDcg8KPo
         GKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eK6V1Iwqa8K2Cx4KZBhR6JdQyqcABL42POC5cN5uPd8=;
        b=KF2E8MQe4GApTM9FK+vPJUIGwBOqFzW02CZRjXOeBn4nD/Y3kY8TNuIXL58s9pqc9/
         CWgzh6qIicf+v6DN4YrX3mJf8DIhSYJHqjhDZWlKu6dOgX5G/g2PG0d2Hb9Q3LuKSCKX
         7pzgarqi4YpTEHgYsvYv/eJuSsCdMPDUJTBQWtNEcCABe98z0jDZcYNJUsavVKJSC1hb
         ET5wnQH6dUybqdYioB8oFbjksXgPlYAAvtfX670rMC6ABx3dRuriNcRd8zw9w99rzHZe
         AckYB/S1lfpRRa/VhOQvc6l+nxI80l/UBgYQgfz/906LLgbUEky5ixFDAWjYGXQjB0Nd
         yBFg==
X-Gm-Message-State: ANoB5pk4EubPFFrt9JwF3KcP3vX8xO0hOsLNM4qc1CGT3pQjVgdGsqp/
        SJ0wss9y0NBi42AuCs4WofkPOXpqCWJOBA==
X-Google-Smtp-Source: AA0mqf49EZMwQNNOXRJInQdlpBvgsSkdp9jEv3JIYqKK1KSIn8OEmCcJgYOMRz2aU8fW/tAvsfA1/g==
X-Received: by 2002:a17:90a:1a07:b0:212:fbab:446b with SMTP id 7-20020a17090a1a0700b00212fbab446bmr68391290pjk.146.1669844169515;
        Wed, 30 Nov 2022 13:36:09 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 137-20020a62198f000000b0056b9ec7e2desm1812695pfz.125.2022.11.30.13.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 13:36:09 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Nov 2022 11:36:08 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/10] blk-throttle: avoid dead code in
 throtl_hierarchy_can_upgrade
Message-ID: <Y4fMyEo0dxPl/Kt1@slm.duckdns.org>
References: <20221129030147.27400-1-shikemeng@huawei.com>
 <20221129030147.27400-11-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129030147.27400-11-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 29, 2022 at 11:01:47AM +0800, Kemeng Shi wrote:
> Function throtl_hierarchy_can_upgrade will always return from while loop,
> so the return outside while loop is never reached. Break the loop when
> we traverse to root as throtl_hierarchy_can_downgrade do to avoid dead
> code.

I don't know why this is an improvement.

-- 
tejun
