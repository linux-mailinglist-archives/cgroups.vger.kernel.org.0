Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF4063E27B
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 22:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiK3VIS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 16:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiK3VIQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 16:08:16 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E420454374;
        Wed, 30 Nov 2022 13:08:15 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id r7so476976pfl.11;
        Wed, 30 Nov 2022 13:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8GLeq4y1VkLChDK5qxV6t3jjI/iORg+c6M0TmX7kjP0=;
        b=Apb1iWUbB5ph59NuwWq3GeIe1SG2Xnc2Ghfh+Z512kKQUVy0BHy8Xe+4CIpU3ulszy
         ub8Y8NyUuKCdKtNJLSmNvH4De+/haJKxfuhQ7yUKzGvKD1mvcWbguLuzaHQmzJJTc1S6
         /33FyHfpujuR0xIbLnLep+jOM+VjSELx9XKKIcX3B71jHSbtdZbUMu51k2Oq4nuBYwbO
         ulz6t7yHPpy26DRout3+gghJB/gLn8kQ1gWJZrzKRVxd811jlCPKStDzfP24BW0sAJvL
         wtUHeT/WqoRZm5jQ9rEiykrgkPYa8C8TCSNaPo3WKCnH5E4kabr+VplL0w8PkcLQW1Ah
         kiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GLeq4y1VkLChDK5qxV6t3jjI/iORg+c6M0TmX7kjP0=;
        b=eYYdI+dTNhQp6Xocdw70S6ou6VSF8LPMwuGiOkf1EbOHPHeRHoedWH0Hudxx1gW8Uq
         1m7z3WIA9iKh2UTaYvsEurZMxuhz3dJprtQn1LJid4Syi3c6y48Qp1uINZyvbJFIoOX5
         inc607EIiW66P6u4c7pf9Og0lgezQI5sg7JDPvZTQiEdoSXWO+I1FrddzJwaB2OBcDNC
         d9JdJSKm1XjfWFmVlic0OyK43AtqvYxliV7anON8QRsmeTrw0V4yTM6zy8Yuy+LQlKAK
         JZTR4gEBEFaXT1GyqOuKqCRI1MDo1IBHa5FKwRXkE/uWd3Nm28W9ahagJefXFzMgbjTe
         w2rA==
X-Gm-Message-State: ANoB5pkXFwLSp/XRsG5nGZWYk6hFP0NA0tfQD5W3cpZw2RryZqStrUzr
        +RtfxUR03keWdCA/K7lgIBQ=
X-Google-Smtp-Source: AA0mqf5vWRyTIyu007lBQW6ThPpGsX/6ucDzIPHV91olGo/xHAU3N4ehoDFdv44MIDwmSFZJ7/0DKA==
X-Received: by 2002:aa7:9f0f:0:b0:575:f36c:967f with SMTP id g15-20020aa79f0f000000b00575f36c967fmr3178291pfr.54.1669842495022;
        Wed, 30 Nov 2022 13:08:15 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id u24-20020a631418000000b0047022e07035sm1348111pgl.47.2022.11.30.13.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 13:08:14 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Nov 2022 11:08:13 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] blk-throttle: correct stale comment in
 throtl_pd_init
Message-ID: <Y4fGPUBBExrm51IH@slm.duckdns.org>
References: <20221129030147.27400-1-shikemeng@huawei.com>
 <20221129030147.27400-2-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129030147.27400-2-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 29, 2022 at 11:01:38AM +0800, Kemeng Shi wrote:
> On the default hierarchy (cgroup2), the throttle interface files don't
> exist in the root cgroup, so the ablity to limit the whole system
> by configuring root group is not existing anymore. In general, cgroup
> doesn't wanna be in the business of restricting resources at the
> system level, so correct the stale comment that we can limit whole
> system to we can only limit subtree.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

> +	 * read_bps limit is set on a "parent" group, summary bps of
> +	 * "parent" group and its subtree groups can't exceed 16M for the

but why the quotes around parent?

-- 
tejun
