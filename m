Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E905655C8B1
	for <lists+cgroups@lfdr.de>; Tue, 28 Jun 2022 14:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbiF0JJ6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Jun 2022 05:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbiF0JJ5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Jun 2022 05:09:57 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F517265C;
        Mon, 27 Jun 2022 02:09:56 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a11-20020a17090acb8b00b001eca0041455so9597411pju.1;
        Mon, 27 Jun 2022 02:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jzEXo2wNJKuAXzdzPYSnlSN8fixwVSEGJI0x/W31JkM=;
        b=hU4DhJ+W7BPhJkIWmS8d8NgVX/6O0gsSZ6+OJHBNigkHfBGv3KGB2PpoPYMekkqEKc
         G9arIfzZLle4EjKLrbn5G2gG8JvZbK84yRMfRQ76bqdRegXh9PPvm7dqC6NfedlYeZSL
         hcuE2zj95GukfZvGBs6RDpr9Wac/bRrAtRMWrspwqj9gAJrrBwFoiDbGa/J09EoJrN7n
         P8VCUxO15woow6TQJpqoRmYZ+DqaOKhJ750PBDSuTCbHaeIOE4UVtVznqK5v7qwEk5XX
         A/7Ij+mmkNcQH6B8JpcNYPdDrsShy0J34i2C3DiXovN91e2VObvlkiVCM5/AKR/+kljp
         PMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jzEXo2wNJKuAXzdzPYSnlSN8fixwVSEGJI0x/W31JkM=;
        b=A+WCPy0leV1gtI13GSIc4hBgtaUXmHTyhEtgHqmjkm5bRzrhpO+ch+dLStCPzvbB3U
         nsU9hXo91pAB0FjPVVeRWKsXxNSWdeoG+PXknoSgJpjYFsutfD/r0TZK033Jvcq6egxM
         pLrVybeXrNSuufz4uS2Qu4HMkAYhylIE8vmqqoiXZXFzeegO3wiMlAHGUuP4pcaF1cLz
         PEV7dNnWk/XjGdYRh83uWvyKZQhsH2hA0546+7h5m2ohkJYn8IDV0srmkXIb61yD0H6L
         zxFkvXmXowwhBClEC262wTdxhHYDp4yA6e+oJb1OvXSy53tHSpt+pT/Dk/aOS7dndnvF
         dYbw==
X-Gm-Message-State: AJIora/3xAMz+WV7TciSCqeS58Yaa1+l2LpVxRhsDOAGtk+5cXQ2vc1X
        x5XRAsIW2EBiKQOAJwH5Lsc=
X-Google-Smtp-Source: AGRyM1sp3nkuVyFqSoHySHVx5/xqLARUgA6kJuHXjvfDTzveLyniCZLei7v+jKzA8L0ZBNfR1wFl6w==
X-Received: by 2002:a17:902:b215:b0:168:da4b:c925 with SMTP id t21-20020a170902b21500b00168da4bc925mr13285908plr.155.1656320995426;
        Mon, 27 Jun 2022 02:09:55 -0700 (PDT)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902bd8500b001640beeebf1sm6583975pls.268.2022.06.27.02.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:09:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 27 Jun 2022 18:09:52 +0900
From:   Tejun Heo <tj@kernel.org>
To:     Lin Feng <linf@wangsu.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup.c: remove redundant check for mixable cgroup in
 cgroup_migrate_vet_dst
Message-ID: <Yrlz4E4QbrzdOfMF@mtj.duckdns.org>
References: <20220621092358.223594-1-linf@wangsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621092358.223594-1-linf@wangsu.com>
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

On Tue, Jun 21, 2022 at 05:23:58PM +0800, Lin Feng wrote:
...
> so explicitly checking in cgroup_migrate_vet_dst is unnecessary.
> 
> Signed-off-by: Lin Feng <linf@wangsu.com>

Applied to cgroup/for-5.20.

Thanks.

-- 
tejun
