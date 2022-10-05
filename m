Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D305F5893
	for <lists+cgroups@lfdr.de>; Wed,  5 Oct 2022 18:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiJEQrk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Oct 2022 12:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiJEQrj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Oct 2022 12:47:39 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC6A7EFEA;
        Wed,  5 Oct 2022 09:47:35 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so2312097pjk.2;
        Wed, 05 Oct 2022 09:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ia5DV0kmXQ4W+QZoJTRIPPIOgQcIdbHe/HPFhl2BDnY=;
        b=ks9cRP9wbCsBLQ96ncXMLBVGQ4M/qtxeyVrB8bpTTHWKQ9HRtbBJyWXEtz6wSqcSs3
         cSG28f0WA6XQB1HTFnLyKoTwrU5x8E7zQNRqjRxgDKnWnpAdtX9U/Llx1n6T3PrHBE4O
         QAXOQ+PJJD/4a4vI6OmZFFQDNK24GoWc3xWbHB0eO0vdAJj12UjHfz1rxu6A9DGc1QFM
         z2b1bZgndjJMspxfyWEXrSI7nE0A4ei6Xjgzjoj2ZSCH+m5CAQUqhSIz7F9gCAQRY1M4
         xB6/gE+33rH1Uls6YaDyc+YP6nFoEpnTyoFQOoGK1KDEu63LqpFR8KtnGIoL721WQaMW
         mUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ia5DV0kmXQ4W+QZoJTRIPPIOgQcIdbHe/HPFhl2BDnY=;
        b=lzqGjT67wYtpKauYSrbQedzCiL2acPt9ekIr5e1108zKB0TUUx50qwSjX7FpCKn7dH
         QM1wiQrEJCD3T521o2KeSoit0i/rX+Zq0t7KFMFNB0fKBXMNgkZ6tbyl59DntNPbccTW
         txDi8VJVeL4PNvmT3SeS2hbdow1UKThVvQrydU4DaSghw0cgaGeBxZB6sRgNVo+Alc4D
         jdmS/PUcmLxzQ4l97BW8ZNFJlZ7sW7yZdhpUHkvDsRhmF6/tAGMlppncmIAe9qwqwkTR
         U/nFy4FXw+jmv150rbz+otw8VEddgMXc97shouGYd1XfdXEm2eq1gcThS9rumyb7SAc0
         kiqQ==
X-Gm-Message-State: ACrzQf3a6K/sNSmImDKNhzq3MyWtjC6c9E0LAYO8xDFKZdbZYq1p8AJp
        iv5HwMPpn6AoU/TnJmQI9c4=
X-Google-Smtp-Source: AMsMyM6q9Tb6RSG+c7aPNe3N1fOpK/fK3Y24c2BqbUWk0NLGP53xwuK6VBGQX5P2vRn4tk0apyH0Kw==
X-Received: by 2002:a17:902:da89:b0:17f:8a16:69e2 with SMTP id j9-20020a170902da8900b0017f8a1669e2mr613404plx.82.1664988454232;
        Wed, 05 Oct 2022 09:47:34 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id c15-20020aa7952f000000b005609d3d3008sm7567399pfp.171.2022.10.05.09.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 09:47:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 5 Oct 2022 06:47:31 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] cgroup: Reorganize css_set_lock and kernfs path
 processing
Message-ID: <Yz21I9UpXafWMU0K@slm.duckdns.org>
References: <20220905170944.23071-1-mkoutny@suse.com>
 <Yxd/sUQ/NB3NlC6f@slm.duckdns.org>
 <YzQw/EvH9Sb58Au2@blackbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzQw/EvH9Sb58Au2@blackbook>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, Sep 28, 2022 at 01:33:16PM +0200, Michal Koutný wrote:
...
> I realized the pinning with reference taking won't really work
> generally. The code would get the reference within RCU read section, so
> it'd have to be cgroup_get_live() and if that fails there's not much to
> do.

Hmm... isn't current's root cgrp guaranteed to be alive? How would
cgroup_get_live() fail? Also, shouldn't cgroup_get() enough for path
walking?

> @@ -6673,8 +6678,8 @@ struct cgroup *cgroup_get_from_path(const char *path)
>  
>  	spin_lock_irq(&css_set_lock);
>  	root_cgrp = current_cgns_cgroup_from_root(&cgrp_dfl_root);
> -	kn = kernfs_walk_and_get(root_cgrp->kn, path);
>  	spin_unlock_irq(&css_set_lock);
> +	kn = kernfs_walk_and_get(root_cgrp->kn, path);

If you really wanna do it this way, can you please add a detailed comment
here why this is safe? But I'd prefer just doing a strightforward ref
inc/dec around it.

Thanks.

-- 
tejun
