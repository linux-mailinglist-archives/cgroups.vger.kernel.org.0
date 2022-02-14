Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0240C4B5A67
	for <lists+cgroups@lfdr.de>; Mon, 14 Feb 2022 20:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiBNTFo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Feb 2022 14:05:44 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiBNTFV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Feb 2022 14:05:21 -0500
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAE893995;
        Mon, 14 Feb 2022 11:05:00 -0800 (PST)
Received: by mail-pj1-f51.google.com with SMTP id v4so15476588pjh.2;
        Mon, 14 Feb 2022 11:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b9IZjTswnZ1iUB9QT+cr1Wj9o8flIHUShxrRz7LR2AY=;
        b=hq4XAe/+8zUJOL7TaevyVlyRAm0inKyh0npqK/CTm41Cd4954DnlPK/JP2Pf+d2Zlz
         ec+rIRhHieKvs8YzlFJ8I7Q3Bbd1daycnvc2MB5yQCQGkvJyX9eggG7E9VRYWrMKZfl0
         7xGINYcqaJOdATGQyx+FgOkhdCi5iPKDgOv8DSKuhOOLKBYAiYRHqlsohInZN++DNr3V
         ciVownfJPlGcIQwi6GZH5T0b7UnAX0OvcMsdXfmaBuFD1V0xVrPLhqVFLgz2ruwHflin
         2C7BxdkSlgAXUBEI7Mo38KYeMczl2swk0w+dbefn4GbwIuidwHH+yKAbu0xK+q0vSjQI
         5LHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=b9IZjTswnZ1iUB9QT+cr1Wj9o8flIHUShxrRz7LR2AY=;
        b=VGrLNCUFsXSEplsWPq18Hg73nU3Lo+swWZCKRRHUJw+wswht5Mm7mE4GMdCgK6E0GK
         9iDJjBFEo4XiqFEzIU79CBSEIFDdXN+5XEpLSGjY9ZrLrZyDayPK/YqW6QQ3H//Eqk4o
         x2pw1Gq1CsL9mZ7Rn3yqURJdp7n7sbJgIS5VdmWFcst2+SIM3VQaV+D3E5/eM2K+PPbD
         vd3IgeIsj2GjwR13bznDOgqXxxABS9iRc17VpdZFFipKNCAiRn93o1rjZM6K12FaKgY7
         bXnwRotkaj7gb9Oj3Rkk5vs54dN3VRlRgjp7B37k9jMYqL7BB0KmKIoOCSbZJLXmucoP
         cV9g==
X-Gm-Message-State: AOAM531IMrukNVjxfBtMnJaSaBDhwkXKjUZSdObnqVSSf91cp3IgYjWu
        ZyhtXcIruwYy5wXPfQZS53M=
X-Google-Smtp-Source: ABdhPJysZBUSrwdyj1e3zOC7f5puZMI0DtdNub2vOnjMtHbFWpCx5t0iqlDmLMscS4zXC2Cw4gq2tQ==
X-Received: by 2002:a17:902:aa90:: with SMTP id d16mr140317plr.89.1644865167586;
        Mon, 14 Feb 2022 10:59:27 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id hk3sm10314466pjb.12.2022.02.14.10.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 10:59:27 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Feb 2022 08:59:26 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     axboe@kernel.dk, boris@bur.io, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-cgroup: set blkg iostat after percpu stat aggregation
Message-ID: <Ygqmjsbu96+UZDw+@slm.duckdns.org>
References: <20220213085902.88884-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220213085902.88884-1-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Feb 13, 2022 at 04:59:02PM +0800, Chengming Zhou wrote:
> Don't need to do blkg_iostat_set for top blkg iostat on each CPU,
> so move it after percpu stat aggregation.
> 
> Fixes: ef45fe470e1e ("blk-cgroup: show global disk stats in root cgroup
> io.stat")

I'm not sure Fixes tag is necessary here.

> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

but other than that,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
