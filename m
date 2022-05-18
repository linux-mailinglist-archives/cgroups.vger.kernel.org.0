Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B9E52BFF9
	for <lists+cgroups@lfdr.de>; Wed, 18 May 2022 19:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240598AbiERQ50 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 May 2022 12:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240594AbiERQ5R (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 May 2022 12:57:17 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306E41053FA;
        Wed, 18 May 2022 09:57:16 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ev18so2642300pjb.4;
        Wed, 18 May 2022 09:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=12ObYYrf99f0yLEIMoJi0RP8wJdhcsztzbMI93JYaGg=;
        b=fJuwr+79VK40EWiLDG7rqWOctqpq6NcDBduZ3aXuqdASFa6Lj98Yc312Y03+qRCODk
         6UQy0HrgZTAejHxAh+UOFjyZ/2CGbXNYAPpBBlCqJf/596yD53ifCnhcJWeyvqTR1jWn
         StEH1xtvTb4qIomCptdjFPb3uHvzEfFHpPeAhK/H8nHOw+r0ReqkF4YQYkrNfAyx0mMz
         /gh/6CpYiO0DC3/99Q7xkRa/pT+GO7sbeXBXM9WdlbVzviKDCA9BJCWHe32m7ZIHVbgE
         4TIuVjndwOW00mw7ya+C+VmsVltd2TM61fvflm1FuS44n9tvhU2RqZZHHkNG5zfOG1rC
         a98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=12ObYYrf99f0yLEIMoJi0RP8wJdhcsztzbMI93JYaGg=;
        b=RBY4XFwaN9rCbv4yyxFIJNZI4dYuB8zOpXXVb4EsjVfWA2er4MhGvZ7UJW1cXEwqzo
         1L4iLs+B31mTgQhthmRJSliOdpxs5YQYDFpQavvIDMm6I2h20aZrady5z4A8vm8vMrS/
         4C2oIDAteGqci+0DYBQgtxE03mgjC5jEoAdrzdt95AX+l1E1irNE79X4agcZMY7gKc43
         27RDHX3uvL743gZxyk44qeUk68C7ADvyodjnnIcO5bt2Ae5oAKjGDRldQMKQ/+88z56r
         7dBB5R9ATUH0LMhdS8uMagbKcGA/JRbjP/x7A7AT8wp/Js55YSfD/X6OijNik/OaLzbo
         GK6g==
X-Gm-Message-State: AOAM530djaCV8SDjSl3ZaVGGrPOPjQWo5xbZN/vtaOO6MRXwyA7QWSeo
        2INi2z/A8VJUe9wlV37tFMo=
X-Google-Smtp-Source: ABdhPJylhb5u15AQQy1AVQPbifeXpL82+iCzqZ7cg7eZcqy/eTZRfq8GLE8Ptw2XSx2cF0B0rRaNxg==
X-Received: by 2002:a17:90b:1d0c:b0:1dd:2c77:ca95 with SMTP id on12-20020a17090b1d0c00b001dd2c77ca95mr336057pjb.151.1652893035107;
        Wed, 18 May 2022 09:57:15 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:62fc])
        by smtp.gmail.com with ESMTPSA id p11-20020a170903248b00b0015ed3a112c9sm1910525plw.280.2022.05.18.09.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 09:57:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 18 May 2022 06:57:13 -1000
From:   Tejun Heo <tj@kernel.org>
To:     xiujianfeng <xiujianfeng@huawei.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cgroup: Make cgroup_debug static
Message-ID: <YoUlaTQrEf+NxINS@slm.duckdns.org>
References: <20220517112523.243386-1-xiujianfeng@huawei.com>
 <YoPWJZ+RJmlvBLwV@slm.duckdns.org>
 <c099059c-2953-232d-3d53-e8863c221cb0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c099059c-2953-232d-3d53-e8863c221cb0@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 18, 2022 at 02:48:36PM +0800, xiujianfeng wrote:
> 
> 在 2022/5/18 1:06, Tejun Heo 写道:
> > On Tue, May 17, 2022 at 07:25:23PM +0800, Xiu Jianfeng wrote:
> > > Make cgroup_debug static since it's only used in cgroup.c
> > > 
> > > Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> > The only thing it does is gating CFTYPE_DEBUG which isn't used anymore.
> > Can you remove both CFTYPE_DEBUG and cgroup_debug() instead?
> 
> It's ok to me, but I found CFTYPE_DEBUG is still used in cpuset subsys,
> 
>   .name = "cpus.subpartitions",
>   .seq_show = cpuset_common_seq_show,
>   .private = FILE_SUBPARTS_CPULIST,
>   .flags = CFTYPE_DEBUG,
> 
> if remove CFTYPE_DEBUG and cgroup_debug,  cpus.subpartitions will be showed
> by default,  is this ok?

Ah, I missed that. You're right. Lemme apply the original path.

Thanks.

-- 
tejun
