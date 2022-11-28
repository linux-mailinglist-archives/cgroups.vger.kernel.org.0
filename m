Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3002C63AE85
	for <lists+cgroups@lfdr.de>; Mon, 28 Nov 2022 18:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiK1RJw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Nov 2022 12:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbiK1RJR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Nov 2022 12:09:17 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E88B7F2;
        Mon, 28 Nov 2022 09:09:04 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id k5so10119435pjo.5;
        Mon, 28 Nov 2022 09:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sznbp6Qjro/lU0fK9+7muhZjge7QWHgQWbjlTiDXzkc=;
        b=a8tTbIcUy2a41TN780C+9J4rBtuAeFTi8gr72QkA0d2fcO8Uwmb6U5OzC3NKdEHsLY
         l2esfexl6uRmQ4ljLpk/ffd0/3DnPY0ik2CPQ9EMfuJCyAmXMrFvJucmchwO+xb3rogv
         ChfoJNtPJVUpaHKP6H3h1Fazd2xWQl+8i0ufLrwSla/QEQbBRXcagCCFTLZwLtwG/vNi
         cS3cSVvO/muC82MOR1B3Ggp1gpjpqH59zMn3yiI+cH1TDFw8WqmR4vC150oMsGUIUunV
         vvT5BSl1bNkGqr2SyZVnOcIaVC59T3osws9U30UgVXRHsDQWjghnfNgIzj3HmDMFyQhS
         pKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sznbp6Qjro/lU0fK9+7muhZjge7QWHgQWbjlTiDXzkc=;
        b=a3W6SI84WnRXAzfqP7GNRHLVm2wRkp8DKWu9MAGgpjGi7V6/DuV/b+AvFa2p47vndr
         Hh5ObyEgXgR663p8ixh4l6oW7N+gMcJzNq2a2rhQJHJbEpQlXd4uk+E5Tkaeltm/q/xn
         W97pFbWf4NSe9GqB+AXZmL8i5g8lrrdWDaUXFpAi2RnMh4to0BX3bDNRKagsnf2fb4xI
         CCFWy57lgn+S++zadinbcXkIuooRAiNiFORDXKuibaCuSuHgYqAO5uhr3d8CFPQ3CCck
         ZLXMPhtaR2Mk+RZpOpiKOsCIIkjUGTfLgWcrzj+4KO4Ro48AuE0brmF+skuD3tI7hJy4
         LwhQ==
X-Gm-Message-State: ANoB5pkxIYMWB8qwp5Z7z4n2zbicT8ggkGRSMb2cVwg0OAxAYHhCT02C
        hrxnXjt3A1LhP3NQlw0uzFU=
X-Google-Smtp-Source: AA0mqf4tKE1nA4FYiGNaJkI6RtdPH+BPsqU9WiX4+2WxKvZ86kVUjsZeLWMxYFAR34Q5vyMPg2wJdw==
X-Received: by 2002:a17:90a:5298:b0:217:e054:9ac8 with SMTP id w24-20020a17090a529800b00217e0549ac8mr61944865pjh.246.1669655343440;
        Mon, 28 Nov 2022 09:09:03 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id ga18-20020a17090b039200b0020a11217682sm7848802pjb.27.2022.11.28.09.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 09:09:03 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 28 Nov 2022 07:09:01 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Li Jinlin <lijinlin3@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        liuzhiqiang26@huawei.com
Subject: Re: [PATCH] blk-iocost: fix shift-out-of-bounds in iocg_hick_delay()
Message-ID: <Y4TrLfOj5sTpXyYR@slm.duckdns.org>
References: <20221126121458.3564942-1-lijinlin3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221126121458.3564942-1-lijinlin3@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Nov 26, 2022 at 08:14:58PM +0800, Li Jinlin wrote:
>  	if (iocg->delay)
> -		delay = iocg->delay >> div64_u64(tdelta, USEC_PER_SEC);
> +		delay = iocg->delay >> min(div64_u64(tdelta, USEC_PER_SEC), 63);

Let's just set delay to 0 if the shift is too big.

Thanks.

-- 
tejun
