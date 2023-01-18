Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760956723C3
	for <lists+cgroups@lfdr.de>; Wed, 18 Jan 2023 17:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjARQnd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Jan 2023 11:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjARQnH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Jan 2023 11:43:07 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037BE36FE7;
        Wed, 18 Jan 2023 08:42:22 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id r21so5355653plg.13;
        Wed, 18 Jan 2023 08:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KQ5UR3/Xa0Iypn0NjAFlzAel5UzlsAahE0Mxf3hKvNI=;
        b=HtEWoLc8/L8ms4jJfUX7yuSxC/Ev6BsvXo78m11rO02Mzvft0bqOU5nHJgEf2x1UOF
         /frnN6FGr41Nzz9l7f4WNhNmhFM+Hfgqp8pt3ow80dUdKeRavboRhpPEoyCbap8j3Fxy
         wEocSwLplENYxRNL0PmIkZOLr9oWalRRzl2+xOKKJawaoTvVPMks6Qc17rxKKr3B5d0V
         qss+BaOxZucT4h29rQah3MOgKACtPm5b+WhTWvXH7xQqoz2v7+pDlfBBlECIGW2XTIIG
         dx5jRtIW6M5uiMLHssv7ZCc8/7Yre8vncxwYpn2gyCTGVEYlUzpml7Flz0KFVJ1gBlwY
         zwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQ5UR3/Xa0Iypn0NjAFlzAel5UzlsAahE0Mxf3hKvNI=;
        b=BH5nny4P2NZUutfGZwJ/DpBMIgxuWu1N0cTASWfC+VlHsz1VbFsj9AHv2q4JgjPAQe
         aP1lcc9tsa754mVV4TtJ/LAcjy9ZbEFSfmg1U6qCh7AFsf2bDrH3G9RLA3uV3Bescosl
         3gZj0pKu8HhCdvJc/5SW7W5CDIz/fcIpx2209fQRkUF6XdNbfoftMiaO5NPL1oQTI0vm
         Xu/8voY1aJidL7hlowI+J1UMBode5EnlekvXXUI+ZDrbLxBhMX6GAo4/yrrxWqhuKpbQ
         4A8LsGSgQqliPU5qUKTijctPpJbNabBiCP1AMFY2sFMT/236kdAx06mpYK5dQb/LLT00
         OQdg==
X-Gm-Message-State: AFqh2kprUe6sgfJwAPmPdvff8cOMhAZg33sdUglCX78ETMRePiYAJ9YL
        NA+JBIQqkre7StsJZ3k3Jms=
X-Google-Smtp-Source: AMrXdXueQTctacY4LEDI4404AeLAbKX2kqptjDwyJqnpB1bBvgnsXJapr6+bC4djWGYj98C7/xZDFQ==
X-Received: by 2002:a17:90a:88c:b0:226:8d3:7ed6 with SMTP id v12-20020a17090a088c00b0022608d37ed6mr7730465pjc.41.1674060141694;
        Wed, 18 Jan 2023 08:42:21 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id t7-20020a17090a024700b00228fe43d959sm1578813pje.5.2023.01.18.08.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:42:21 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 18 Jan 2023 06:42:19 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kemeng Shi <shikemeng@huawei.com>,
        Andreas Herrmann <aherrmann@suse.de>,
        Yu Kuai <yukuai3@huawei.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Jinke Han <hanjinke.666@bytedance.com>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-iocost: avoid 64-bit division in ioc_timer_fn
Message-ID: <Y8gha8kL5yG3RQ2w@slm.duckdns.org>
References: <20230118080706.3303186-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118080706.3303186-1-arnd@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jan 18, 2023 at 09:07:01AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The behavior of 'enum' types has changed in gcc-13, so now the
> UNBUSY_THR_PCT constant is interpreted as a 64-bit number because
> it is defined as part of the same enum definition as some other
> constants that do not fit within a 32-bit integer. This in turn
> leads to some inefficient code on 32-bit architectures as well
> as a link error:
> 
> arm-linux-gnueabi/bin/arm-linux-gnueabi-ld: block/blk-iocost.o: in function `ioc_timer_fn':
> blk-iocost.c:(.text+0x68e8): undefined reference to `__aeabi_uldivmod'
> arm-linux-gnueabi-ld: blk-iocost.c:(.text+0x6908): undefined reference to `__aeabi_uldivmod'
> 
> Split the enum definition to keep the 64-bit timing constants in
> a separate enum type from those constants that can clearly fit
> within a smaller type.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
