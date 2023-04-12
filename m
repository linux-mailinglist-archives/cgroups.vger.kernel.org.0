Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4FA6DFC76
	for <lists+cgroups@lfdr.de>; Wed, 12 Apr 2023 19:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjDLRPZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Apr 2023 13:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjDLRPS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Apr 2023 13:15:18 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A269F9017;
        Wed, 12 Apr 2023 10:14:57 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1a66b9bd7dfso2383475ad.2;
        Wed, 12 Apr 2023 10:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681319694; x=1683911694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0VRajwDCS1Rg/Spw2tnj0AXocI1N336v8O1yep9+DQ=;
        b=XJVCAGJvep9wSQoZc+nwUbfW82+Of3wXWE/YDZ5k0WnQWWtRGPvsWU0H12x3yS5WtG
         QGdKQe78HYFpYAlup1V8VDN/C/EESxfacz/ioZawPOwehU9KWuxpOjpbglXradyFQ8WB
         mGwncSrB8+h2DUjD0Kp/61qCFlso9DW858E4XFAYV80UB/2lez035y2GRlhqU0M56l+D
         YWKJYvgpYwwUQSqYiV8DFfXOeRHehET1hiNu79Rk6o9vvr16Sfy6pA91D6uveMcFulQs
         TdqScjNKaV7gS67hcMlK3bHH+iQAhYjg2AotxU3ZYiwJuCFkKHWs2RT31Pj4JN28H7/S
         an2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681319694; x=1683911694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0VRajwDCS1Rg/Spw2tnj0AXocI1N336v8O1yep9+DQ=;
        b=b9EAPo3Csc6UsmyKN1lRh6bNXIgZndQV7bdLObPqmrBrHJVvhd8InpqkTFiKKGPiMl
         zRQwGICIT2YDEmp+SYSJ8OZnOgKxt9oYIGqNajlhZIYDPvdrwns7SNuP29EnHPaPg8qk
         cOHLBv0DkxcwtkdtD78KjonjMI5efMRUUqTdxgMgN38GswHf7DTtTI5VutkV/JxNf99j
         5JWq/pcuFXX3KCue0O2GARS4EVHpvNZyqR4IGR/xO5QMbQ/fEUzG6zBWmIttjKekgPog
         GU0/MDUX4U5JKNK6xn2lB5dFQH7eJ9LT29kRgXHv6JD1CYcR7jwoTgz9BHnwv2m5HzBz
         FwSA==
X-Gm-Message-State: AAQBX9dGTslM40LB4LsWYHOVDydeqYlfWqS9AdkACOyNTqoXgYUwtHKl
        GQ+njDXYVBi3MWhSecLMgpXDPw0CsHk=
X-Google-Smtp-Source: AKy350Z0vUTuk5tXpAtjcbIy4MewVWo55OtCq7e4e3rWpWq1+y2u/9J0cfM4XbFUmXDwsMKWezO3QQ==
X-Received: by 2002:a62:1bc4:0:b0:636:206b:8595 with SMTP id b187-20020a621bc4000000b00636206b8595mr7069889pfb.8.1681319693639;
        Wed, 12 Apr 2023 10:14:53 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id e21-20020a62ee15000000b0062e10435843sm11853981pfi.217.2023.04.12.10.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 10:14:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 12 Apr 2023 07:14:52 -1000
From:   Tejun Heo <tj@kernel.org>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH 2/2] blk-throttle: only enable blk-stat when
 BLK_DEV_THROTTLING_LOW
Message-ID: <ZDbnDGtoY3q_ow-R@slm.duckdns.org>
References: <20230412160754.1981705-1-chengming.zhou@linux.dev>
 <20230412160754.1981705-2-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412160754.1981705-2-chengming.zhou@linux.dev>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 13, 2023 at 12:07:54AM +0800, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> blk_throtl_register() will unconditionally enable blk-stat for gendisk
> when register, even when we have no BLK_DEV_THROTTLING_LOW config.
> 
> Since the kernel always has only BLK_DEV_THROTTLING config and the
> BLK_DEV_THROTTLING_LOW config is still in EXPERIMENTAL state, we can
> just skip blk-stat when !BLK_DEV_THROTTLING_LOW.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
