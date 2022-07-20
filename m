Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E306757B6B3
	for <lists+cgroups@lfdr.de>; Wed, 20 Jul 2022 14:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240860AbiGTMqw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Jul 2022 08:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240966AbiGTMqu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Jul 2022 08:46:50 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6A82C132
        for <cgroups@vger.kernel.org>; Wed, 20 Jul 2022 05:46:48 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id r186so16297376pgr.2
        for <cgroups@vger.kernel.org>; Wed, 20 Jul 2022 05:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=sEGQ7L1KrUZZSjc5lTCBdg4P620qJO0ftLSgZHwILC8=;
        b=rwUDwbnnw3bPn47kNfg7ezqzV/LZChu0a3v2CN0AynDdb4B+/tvtYW8/uAOhGtObcZ
         jdMz1+jCJ13tg2VyNFIzZPhKJMc7Ob2J0tf6XGCs9xkgJA/nrmYYJUXRUHBi0tUDuQmj
         v79GFiy1F8xNZ7qkRqvQzBaOyUzpSCbt2HEHzsViyqik+g6/sisTG7KHot3xgK9bWkbA
         SJQ83R0YkKJ6jYgdD1HuOk/8/NmH1MmCioP9T8sQD3DJRieSUOW7MGmgP6Ej+rLEdg//
         DEOGINokGsTjCA7yDSww75D/W4A1AhfCxEmU4SbMXhlSs0PN5n/iF3nOL2lr+c/vdHve
         w/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=sEGQ7L1KrUZZSjc5lTCBdg4P620qJO0ftLSgZHwILC8=;
        b=IUvSpdT/yGUgoxSvzzKIY8jCNTAvWUjW6oZdr2/7lwCdpgvuxbOshmDua8aiLq1UJQ
         xWX6gNjY+SkbvCdv0YbyOkIG5tzmpXJ/Q2fP3vQPriU10o7mnWJnu/bFGrWMUd07z3OI
         1/5R77v6M33eIDTtz7FYwShoIoPJ/hdxqRiwLzH4+rOl0O+CGAQzroOhZ3B6M4+XoySL
         1XGnhWJjVm8YBEFMsbqq89vVy/OGIBnc6qJP80FJjcarirYiOXoe7Lkpj3s2/Fi2EPgB
         90SF1MqD3em1CT/OYlSlnQCa/rT3B9JV3/9DA0dIpFoxUox7N7jWGACYW/e7ColKi//o
         UL6A==
X-Gm-Message-State: AJIora8kgsw5x91Qo6s08S8TbGKwz3ce8cRW5SntCOIBA9GRxE20BD/P
        UWVxU8caCTMB42zsxBP9VjP4kg==
X-Google-Smtp-Source: AGRyM1t7wriEhr2mqYC6echsB2BY8+c43mOtwnGP0h8SWWvTQ+c/TMAVrHpPIfdz3GHa7zH8ZeSiww==
X-Received: by 2002:a65:6d98:0:b0:41a:6331:cffe with SMTP id bc24-20020a656d98000000b0041a6331cffemr3365206pgb.297.1658321207565;
        Wed, 20 Jul 2022 05:46:47 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ru7-20020a17090b2bc700b001f219ace0acsm1544392pjb.16.2022.07.20.05.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 05:46:47 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, hanjinke.666@bytedance.com
Cc:     linux-block@vger.kernel.org, songmuchun@bytedance.com,
        cgroups@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220720093616.70584-1-hanjinke.666@bytedance.com>
References: <20220719165313.51887-1-hanjinke.666@bytedance.com> <20220720093616.70584-1-hanjinke.666@bytedance.com>
Subject: Re: [PATCH v4] block: don't allow the same type rq_qos add more than once
Message-Id: <165832120656.248441.6551351074316660910.b4-ty@kernel.dk>
Date:   Wed, 20 Jul 2022 06:46:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 20 Jul 2022 17:36:16 +0800, Jinke Han wrote:
> From: Jinke Han <hanjinke.666@bytedance.com>
> 
> In our test of iocost, we encountered some list add/del corruptions of
> inner_walk list in ioc_timer_fn.
> 
> The reason can be described as follow:
> cpu 0						cpu 1
> ioc_qos_write					ioc_qos_write
> 
> [...]

Applied, thanks!

[1/1] block: don't allow the same type rq_qos add more than once
      commit: 14a6e2eb7df5c7897c15b109cba29ab0c4a791b6

Best regards,
-- 
Jens Axboe


