Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E38C5FA642
	for <lists+cgroups@lfdr.de>; Mon, 10 Oct 2022 22:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiJJUau (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Oct 2022 16:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiJJUaF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Oct 2022 16:30:05 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACF36175;
        Mon, 10 Oct 2022 13:29:39 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s206so11153640pgs.3;
        Mon, 10 Oct 2022 13:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJvdR5sFA7841TfkHWBXVf+L88za68VvtqLkISWSSSU=;
        b=mzi+/WBX/eFPhWGRK9wk25LbdDWrPtoko+QoLbYq0hvYx6m4vETmFUGiPPn3VsV0gA
         i+6WjDzaxoqyRXmWtvngaiuaryYkBi+wK7hwrLWOAH9u1CdCLDXYFeA0iZTQpNeKhY78
         txA6yTR3Po4vsfLRmHO7bUvUB1VB4pNCFef8LirwRR7MmCj8cL64TBK32FD+5V1y5eit
         /ZbkipPrix/XLAUNcNSqLNygx2pwxjox3ZbUIUapUf9darLgWGmBgSe6EaoUlGzs79gg
         T/o8f+CuAjAQoZZsN7jFqFh8VWcmYy9Z0J6GYR1w+ChMabKGOHmxt0j3x+9LyNMxX1EP
         3Jew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJvdR5sFA7841TfkHWBXVf+L88za68VvtqLkISWSSSU=;
        b=b07NXCiIbtwWn5R7nNvx39btWfWlsOQkNF4Oc69Yp1a1Syr5YnjFwlbE/HbVdk0ODL
         1CUdNXnBUa9Y7Vb2C01t3hg3zj6TBkWRJkdbfE+plW3zz/4qM6MG0p9siyGzuvRDoPnR
         kkwmpqHHoTTye98eOtYRrjDQubrdoA2VK7ji8gtmKjW7Abzo8CfrEfnXyxTYGdK61Ro5
         UroRmlFCq2fVANlhsBsRElt1Bf13ZjIIOr/bqv2xwaXOgcbU63zxAZKYXC92KFKp/Shf
         u+bfYF6NyaBHC8If1dGclv4BbfM0yC93yh/Vo8lHdRqYi9S1HV7Mhluje3YdsFIaw5RJ
         KD5A==
X-Gm-Message-State: ACrzQf3HL5dKwErxAH+e5MbA6vtaRtRgJvBmvUSVsnJsDVCG3IAx9vuz
        a36s7/NH+XkMw3rVALVQ7Fg=
X-Google-Smtp-Source: AMsMyM5LtnhoGQVPF1/aZdx0Ww5Twiu2AUPSNLg9xfOIYwLgbnmpUSxpyBsVvLUI4irke88ri3dgig==
X-Received: by 2002:a63:5158:0:b0:45a:8a3d:9da1 with SMTP id r24-20020a635158000000b0045a8a3d9da1mr18164926pgl.539.1665433777637;
        Mon, 10 Oct 2022 13:29:37 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id g7-20020a6544c7000000b0043ae1797e2bsm6460011pgs.63.2022.10.10.13.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 13:29:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Oct 2022 10:29:36 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] blk-cgroup: Fix typo in comment
Message-ID: <Y0SAsFcIgLvkPpPi@slm.duckdns.org>
References: <20221010023859.11896-1-shikemeng@huawei.com>
 <20221010023859.11896-5-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010023859.11896-5-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 10, 2022 at 10:38:59AM +0800, Kemeng Shi wrote:
> Replace assocating with associating.
> Replace assocaited with associated.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
