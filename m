Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6563C65DF21
	for <lists+cgroups@lfdr.de>; Wed,  4 Jan 2023 22:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbjADVjw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Jan 2023 16:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjADVju (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Jan 2023 16:39:50 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D121C40C;
        Wed,  4 Jan 2023 13:39:49 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9so20540293pll.9;
        Wed, 04 Jan 2023 13:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36TwtFKmLPX5g03QeCQ9QWnvENyLGQhIqbG+q6J+tC4=;
        b=MVEhz8XYVOm249fCfkTEHVUxXxB1xpW83zjnPCXy3y9PbRLRWd6eiuNsJ0Du4UU0Xg
         p1A5rhECcWYEsdm0oVKS88LpiH4XucT/7MQi9soMAzW4dDLE6BvV8XiU+9L96ahoQc+p
         lHCorRYHnuq/CfuWx5q+XkcgkZCUF8QlCk5XHfceQzuL5x5lgi/BCxXxpZIymd2LBTCU
         HIxQq2IPptjH37DYJIzU4OnwyIT8obRgMuRGDhkq6V67bdqJolenAS7dEGlxCNN1g12c
         XGIn64Ygz+EeFa7ufq62xp+qMzDYGUsE9dTi4VocfJpFE7nfx7kxwdkbsa1W7ISHEbmc
         xilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36TwtFKmLPX5g03QeCQ9QWnvENyLGQhIqbG+q6J+tC4=;
        b=2O15bLCp/nPQG+HMPvjNt5WtWFp9l2PkDJT51docwkQwpCo7F8PoLn5CaWHZm7DJsG
         dclt3C97zMvqO0oh9p2lxez0oE20PIfTBuqGjI/jR8e5Rsfuaosv/njNYo4lDSZloVyd
         hbfMiS9uYVcBy720WqxXHeCWIr5Wr9Layr2e7qgiUS6iCE0g1zpm/W1tpeI6xtPoNgxC
         r/l8w8oALWh5vvm0U6lzz/E7aG7Ym/SROThV0Vmn0N+eqGfrrj3aCuspBBDI5dvOxAeg
         GlRrjh+qLEOXsrfFI2rTvHWdkpHW8HuhirjB+HT1TjO+WjFqqN4kIlCcD4ibXKX/zG9Z
         S0vw==
X-Gm-Message-State: AFqh2krPbynE/gSXsFxPrsAvJu7X724ngNdgjrAZwuIjQ9ICGDL+kV1G
        Fs516R/uWOziVZl8BlCnVzc=
X-Google-Smtp-Source: AMrXdXtd2btk7HZu9f9C1Chb6/SZpwpiWF+HQuE1InmJOwsYmvWAG6u0mU+1bnGmiJN53DNsjdAH9w==
X-Received: by 2002:a05:6a20:4f88:b0:ac:5a0c:32ad with SMTP id gh8-20020a056a204f8800b000ac5a0c32admr47269905pzb.53.1672868389284;
        Wed, 04 Jan 2023 13:39:49 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79983000000b0057462848b94sm10867372pfh.184.2023.01.04.13.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:39:48 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 4 Jan 2023 11:39:47 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next 3/4] block/rq_qos: use a global mutex to protect
 rq_qos apis
Message-ID: <Y7XyIzGptuqO8EAt@slm.duckdns.org>
References: <20230104085354.2343590-1-yukuai1@huaweicloud.com>
 <20230104085354.2343590-4-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104085354.2343590-4-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jan 04, 2023 at 04:53:53PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> This patch fix following problems:
> 
> 1) rq_qos_add() and rq_qos_del() is protected, while rq_qos_exit() is
>    not.

This part makes sense.

> 2) rq_qos_add() and blkcg_activate_policy() is not atomic, if
>    rq_qos_exit() is done before blkcg_activate_policy(),
>    null-ptr-deference can be triggered.

I'm not sure this part does. I think it'd be better to guarantee that device
destruction is blocked while these configuration operations are in progress
which can be built into blkg_conf helpers.

Thanks.

-- 
tejun
