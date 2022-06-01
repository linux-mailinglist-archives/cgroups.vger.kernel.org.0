Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC1F53AC34
	for <lists+cgroups@lfdr.de>; Wed,  1 Jun 2022 19:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356014AbiFARst (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 13:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbiFARss (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 13:48:48 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598796A034;
        Wed,  1 Jun 2022 10:48:47 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so2724476pjf.5;
        Wed, 01 Jun 2022 10:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XQNVv3TuiqkXfJLicoHS/WLsewT+IhkJwNNY/yOQl9g=;
        b=SKU2z8FWFcS1GugMMFLbBI+MuKmAOThdo/dalT5Ltb3g/svDPwBjGIwhtVZ01dUZps
         1308bR9i3vI6Fd+2mS93Un2RwJpHcPnieky5g4cs6b6G076AAEbIz87pg92Bz2Zj/Mqn
         Odm4Ap+9X20du139FLWLRcy+MX1I6soMhKNWaYhoy3oqAmke5/rHadrkh2vRIkcWAUP+
         d0o070W8/zcaWi7YtljW7DRU6NQ1g1J0Ko4o2zGSvswFbgMoE0KVFjE7vFOgSfmehOXZ
         Ndw7QFIX4Y0EPCURlETvCM9ZB1asysMjtFMp5IIQjdFcZi7897WgKu2aCwjPHWz6kQvd
         OYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XQNVv3TuiqkXfJLicoHS/WLsewT+IhkJwNNY/yOQl9g=;
        b=vhdZrmsl/ps2A0uwLXTZTHzlsUvVPpisMFQShB10WDbzFEsVamAQynXR/T3+T2cg/2
         PX3EPLieoxArhRQ1pUedcIYLLoiUQkgM6ThIIDoVuiWOjmKDK3UMz10ZNrcnLNDexlSb
         Liu8hg4BjkZzu5CKSD92ge9VCXYyJ+LhEQDdRg2kqLqsEVBtcUrtdpilBbvovAiiVx9F
         cdeHL4f9FwhqE6rOychj8qPt2Q/zsvjgADcfhYAOWqJqK/DfUXVHH1Bqj+jLHU8auyEf
         QAjIUfEdnFHitbzbp1O0zio7hEI3tQrdzMHfqgVKbStoRp2NOaPr4fpAAdHzVu2tmMey
         4vYg==
X-Gm-Message-State: AOAM530XE9hPmeN9cfKQUSOGloJ9wodwO9nuOM4rfOdtVq5ijMfShmzk
        4+Gwf6ptTJ0fFPnxjz4jPz4=
X-Google-Smtp-Source: ABdhPJyXxA2uUZPmOeErU/thJ/ykj3J4znMzHz6cRYk5375UuCPx9fX2CsmYX0DsQLzoi0erMMf4qA==
X-Received: by 2002:a17:90a:4209:b0:1df:b907:ed3d with SMTP id o9-20020a17090a420900b001dfb907ed3dmr583884pjg.40.1654105726777;
        Wed, 01 Jun 2022 10:48:46 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id f7-20020aa79d87000000b0050dc76281f2sm1729219pfq.204.2022.06.01.10.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 10:48:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 1 Jun 2022 07:48:45 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2 1/2] blk-cgroup: Correctly free percpu iostat_cpu in
 blkg on error exit
Message-ID: <YpemfZkI2G88qdQF@slm.duckdns.org>
References: <20220601165324.60892-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601165324.60892-1-longman@redhat.com>
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

On Wed, Jun 01, 2022 at 12:53:23PM -0400, Waiman Long wrote:
> Commit f73316482977 ("blk-cgroup: reimplement basic IO stats using cgroup
> rstat") changes block cgroup IO stats to use the rstat APIs. It added
> a new percpu iostat_cpu field into blkg. The blkg_alloc() was modified
> to allocate the new percpu iostat_cpu but didn't free it when an error
> happened. Fix this by freeing the percpu iostat_cpu on error exit.
> 
> Fixes: f73316482977 ("blk-cgroup: reimplement basic IO stats using cgroup rstat")
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
