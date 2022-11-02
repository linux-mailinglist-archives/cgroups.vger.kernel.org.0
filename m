Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44DA61690D
	for <lists+cgroups@lfdr.de>; Wed,  2 Nov 2022 17:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiKBQcT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Nov 2022 12:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbiKBQal (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Nov 2022 12:30:41 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B592F2DA85;
        Wed,  2 Nov 2022 09:27:49 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c2so17049790plz.11;
        Wed, 02 Nov 2022 09:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XOnTIwSkLdz0Y256VHM03IJIqS86treru+v0xLpx+F0=;
        b=TSWa57P1ikjpGFCx0r7ilDPFqEDtPVd3KC8p2+bfITDvY+qgxXOhl/TxGYJIPL8HKw
         1FAG5fB5ofC4QbMSaaU2lNl3GcDir6a2aQx/Z9Fu6JVPm894KAXlZvEJ+xsgusNCqqza
         NhDO1Mw9eSPwcyGqeebl2KKJ4x+2fpwGevQ8j22Do7C7344WtfBMf/EJDTg4QRgEWlGr
         qwhwF8T6Dd/42zvmmTRa47pRMCKV6mjfETEqrCWEc5cHFJhXsJeKsryaMPZsu/E5Nx8b
         jBviskxJiTgDjC3nxI/YYsC1dG8PZqpmRUyhK+9HaalZ6GWbSwlt0+qe4HBRsiqY96A6
         jqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOnTIwSkLdz0Y256VHM03IJIqS86treru+v0xLpx+F0=;
        b=nHia3AKzR7HptIvCzVlAB7xzIhVt20jnh/ayfD6UjUViFu7UYOAtZK6DqZvPy4e7G1
         MZukaUsv18WIKbezc7qOkkDvTzEYFNpW81hIZyaAAIV6EeDfXytEN8xJu91ULRCe0rSm
         41gjPyDm0IBIzWRIa845VD+zWGpCTgr66oaGtJoKbYH/X9VFUU9DTR0Gh8FhLplmbbKA
         ujzn5N/fbXc1D7zlq8c6e03Uf/u+jN4Pdt0XbijMIiqVpHkQ0LBVQE6Hi4fnKQz9XzFc
         Rs9xGw1ziqjqfgkLyNofIUDSTF1Rz7oxe4sqaOBcTkg4kUlHttPXbRbJG7cOnV1ToeH9
         34Sw==
X-Gm-Message-State: ACrzQf3uv9cUKSoy/Cq9G6U193lYfzMXNoH5DOyepQn4w/BoZVFs7yTB
        p733QrnhlTyp2ZjImc7e8pY=
X-Google-Smtp-Source: AMsMyM7E2quPmXEsuYj49alVoNVVsWh6p89cJPYFs1P3dPWc/mnKd8dL5eFZdh1eX6wV5Y7Mx9Z2QA==
X-Received: by 2002:a17:90a:d990:b0:214:2404:19f3 with SMTP id d16-20020a17090ad99000b00214240419f3mr6559132pjv.125.1667406468787;
        Wed, 02 Nov 2022 09:27:48 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090322cd00b00176d347e9a7sm8614361plg.233.2022.11.02.09.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:27:47 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 2 Nov 2022 06:27:46 -1000
From:   'Tejun Heo' <tj@kernel.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Martin Liska <mliska@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block/blk-iocost (gcc13): cast enum members to int in
 prints
Message-ID: <Y2Kaghnu/sPvl0+g@slm.duckdns.org>
References: <20221031114520.10518-1-jirislaby@kernel.org>
 <Y1++fLJXkeZgtXR2@infradead.org>
 <Y2AMcSPAJpj6obSA@slm.duckdns.org>
 <d833ad15-f458-d43d-cab7-de62ff54a939@kernel.org>
 <Y2FNa4bGhJoevRKT@slm.duckdns.org>
 <2b975ee3117e45aaa7882203cf9a4db8@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b975ee3117e45aaa7882203cf9a4db8@AcuMS.aculab.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 02, 2022 at 08:35:34AM +0000, David Laight wrote:
> I think the enums have to be split.
> There will be other side effects of promoting the constants to 64bit
> that are much more difficult to detect than the warnings from printf.

idk, I think I can just add LLU to everything and it should be fine.

> I'm also not sure whether the type is even consistent for 32bit
> and 64bit builds.
> Casts are (sort of) horrid.

Yeah, I don't think casts are the solution either. Lemme add LLU to
everything and see how it works.

Thanks.

-- 
tejun
