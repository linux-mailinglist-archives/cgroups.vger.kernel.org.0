Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9656CF295
	for <lists+cgroups@lfdr.de>; Wed, 29 Mar 2023 20:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjC2S7c (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Mar 2023 14:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjC2S7a (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Mar 2023 14:59:30 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027F5359B;
        Wed, 29 Mar 2023 11:59:24 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j13so15002296pjd.1;
        Wed, 29 Mar 2023 11:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680116364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJfV/EDnHa0A2JJ1AesjXORYSgBsKU2wVwRQ4vy/4iQ=;
        b=FKaRnypaQDkZ4l8caHAGiLzNJrsI9T/qkI3o1WjciLQxnvIT5nqZmeoU2y2X2UJ50o
         o+9veybnwPzpDwC216zieg0Z51t/l+P4o9agFbIL60MDJ4DWn9H6WsqPjGA7LGnzRYNH
         t5B848SJZVl3dwJN0TDEIayEToErYSLiDNzBG1cBuA3RKKEjmh+tpz/TiIsmi5wkKebT
         KKevTWRdYDjlS3joQpYK3peN4xY1PsjJ8nZ4DRuvuaJUr4Z3Fk6ySh0SM9O9NDV2mX8Q
         12bwDpgiCXja6r+jdbrtZkTCWor73mD1+S1C/pRB8grwYrSRvvLKDlyn/t3OJJ36OzN5
         /nQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680116364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJfV/EDnHa0A2JJ1AesjXORYSgBsKU2wVwRQ4vy/4iQ=;
        b=dz+qvBBjfvLz0yDRq9nshnswOS0VKohkb0pVPNj+jsfie4Ze93EJc1y+sAjQZ3cPXf
         LAxOdlZxAIUA/Du0HZ5ggWpCAO7QYoN4RXlWhQDItHic5J+xQHP8i5jxLCiUpX0gWunX
         9Q93jB75Xr6ZAg0zTBxPIvfjs27/QLlOWIqp9P2evMgBKbKFN+RdKOykNnvTeg5N8Xuf
         EC6Slf37eTCESxg+R8ORFHbyyVghIeoyz01FmJp3nTIczp64pZU3t2h4ybeYDloLQ8Ro
         +oGmP0J1v8wNCxh1J2EB+Im82TtAIAjmG8ua7yL0Yz7UTvlEUMs7ONzenJAdS0KX4Djj
         BeRg==
X-Gm-Message-State: AAQBX9dCiFsexUQtVSJvyyp/VaICzBrqpFJYiehTCRDJJTrlgTyyn70B
        86Aa4kJ+LfVMZaOJZQldLe0=
X-Google-Smtp-Source: AKy350ZzJAxCafCSge6IqB39v2mdxiIhKLHwNPGjcalm+oY5iUDpBwEC5w5sq6pJBRu8n5FzV8dGOQ==
X-Received: by 2002:a17:902:f9c6:b0:1a2:85f0:e748 with SMTP id kz6-20020a170902f9c600b001a285f0e748mr310378plb.20.1680116364278;
        Wed, 29 Mar 2023 11:59:24 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902758400b001a285269b70sm133296pll.280.2023.03.29.11.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:59:24 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 29 Mar 2023 08:59:22 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     paolo.valente@linaro.org, axboe@kernel.dk, josef@toxicpanda.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] block, bfq: remove BFQ_WEIGHT_LEGACY_DFL
Message-ID: <ZCSKirFH8f1JdQS2@slm.duckdns.org>
References: <20230328145701.33699-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328145701.33699-1-zhouchengming@bytedance.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 28, 2023 at 10:56:58PM +0800, Chengming Zhou wrote:
> BFQ_WEIGHT_LEGACY_DFL is the same as CGROUP_WEIGHT_DFL, which means
> we don't need cpd_bind_fn() callback to update default weight when
> attached to a hierarchy.
> 
> This patch remove BFQ_WEIGHT_LEGACY_DFL and cpd_bind_fn().
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

For 1-3,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
