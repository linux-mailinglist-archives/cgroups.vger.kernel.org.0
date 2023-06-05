Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5165A722FF9
	for <lists+cgroups@lfdr.de>; Mon,  5 Jun 2023 21:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjFETo1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Jun 2023 15:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjFETo1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Jun 2023 15:44:27 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D832F2
        for <cgroups@vger.kernel.org>; Mon,  5 Jun 2023 12:44:26 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-650352b89f6so2802793b3a.0
        for <cgroups@vger.kernel.org>; Mon, 05 Jun 2023 12:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685994266; x=1688586266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Q8kSKP9++RgTXV8bTvJUl35GTdFE0i1aFw7qo8YRcA=;
        b=mcCqNm9aLTatcZ+DCzOVdIfakRTzR5SoeQUbRhmM2TRd0UufQ0UIqqxJX64OyG0Ovq
         NU9ChFX7kmq79p1Y2uuoMX8JRJ1qPeNp9e6z2c93x0/dudPk3+F6ANSmz37oAIT9cKN/
         clcLk363NM9yPrEaE9ybbiGePQZ0vSE49M93nntYBJSp9IzqcUgyS0tP7Xd0fNL9JFqh
         OcV2/kYHsjyAWqO+7kKUjmV339RG2mnuo6m3gZWVc2sveuoUgiXqBe26CZfgWgoF8ro1
         MuaOSPQ03t9rrgE20I8d4xwF9/X/3gUWJMt9XSPJQu/+sX/itfnTWALRzsDWbQ6FcsLb
         1T6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685994266; x=1688586266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Q8kSKP9++RgTXV8bTvJUl35GTdFE0i1aFw7qo8YRcA=;
        b=dwBceRlJ+rywtTu2yqav8YiCkoeKDerHaiAPa8vtdu6OeSvHCrXwbj1NTmxRPpie3a
         UMk/f7y+fd5OqIH1OOrN05hkQcmCSgUdNHpA5z0L/yt7L+DsBoElI9tuCiAwvXT3bas7
         uil/y5kj3ypMROIdr0UwWB2sZVoYMXJ93OrbS9DRuFau9OKtPHTZWoRGxsL8kEP/SRjK
         5vXA70P9hzJrzoJcJXycq0G1l39I3w1cJJna8J+S24t3PnY6Uf7RhV357rDx3JRFWxlE
         S29dFc0j2nrFF4Lek75L92RG6IC7MpVAmT5KxAFRLC+USoY2dG85hDNYJ94w53/NAonT
         8hbA==
X-Gm-Message-State: AC+VfDylN8eHOEj0pVi3gRIh8eF2/QzHyENTXApqTbqqsa5OzjtmYabv
        3D94Am6hEyHZT4Tgptc4/r4=
X-Google-Smtp-Source: ACHHUZ59OI4/nk6E89XdzHKabq6D+qRvEHmqXu7LLSVzV2l7m5RmXF8fcc3Lxyq0QR0AC0DB6TDtBA==
X-Received: by 2002:a05:6a00:a22:b0:64a:5cde:3a7d with SMTP id p34-20020a056a000a2200b0064a5cde3a7dmr774403pfh.27.1685994265786;
        Mon, 05 Jun 2023 12:44:25 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:b318])
        by smtp.gmail.com with ESMTPSA id fe16-20020a056a002f1000b00653dc27acadsm4592385pfb.205.2023.06.05.12.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 12:44:25 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 5 Jun 2023 09:44:23 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH -next] cgroup: Replace the css_set call with cgroup_get
Message-ID: <ZH47F1bNZC5HWK8u@slm.duckdns.org>
References: <20230602074346.333276-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602074346.333276-1-cuigaosheng1@huawei.com>
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

On Fri, Jun 02, 2023 at 03:43:46PM +0800, Gaosheng Cui wrote:
> We will release the refcnt of cgroup via cgroup_put, for example
> in the cgroup_lock_and_drain_offline function, so replace css_get
> with the cgroup_get function for better readability.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Applied to cgroup/for-6.5.

Thanks.

-- 
tejun
