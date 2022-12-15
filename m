Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8320864DEEE
	for <lists+cgroups@lfdr.de>; Thu, 15 Dec 2022 17:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiLOQrM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Dec 2022 11:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiLOQq6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Dec 2022 11:46:58 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CF72A953;
        Thu, 15 Dec 2022 08:46:58 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gt4so11098189pjb.1;
        Thu, 15 Dec 2022 08:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NtuasfiQwAVb7T7lHLup3YJ84O51YLi79K4mOD3jS5A=;
        b=hZ4Cot94gaF1e87/TucVOwB8o680736L461Il3xZ+KPnmu5CDTodnJjoxNhGI8jm/P
         ezzK6dmlX/iVzaI7KzXIoaOBAJ5qVX+ZsNI1FmMinXUp7f25Ja3zydw9ku6cOyd3u3+N
         j4nsXWLh/j2KY6m/XKiuAkRuwaLR7sGHukq0kX3UPrF00AMnQQTj5WRPw7fqziSIWjtD
         FS821KiSlWhilmJ2BKonUoauhCstgpIzJcskq9dEH0djxjxX7IwfuBbzIj/EFqkYwvRa
         9g5rakZUJwAy+N1If+4CzOizhNWKm/7dRP1W/6Cu7Zmriycj7YQjkSssTxulOU7U6ZrK
         HZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NtuasfiQwAVb7T7lHLup3YJ84O51YLi79K4mOD3jS5A=;
        b=Gu+MwE9Pcz6M4a4vfV2AdC7FrykQ4Vr2hXtOtvT/1v78o2/F26+f02cgggGA3CgnEf
         4Wi3R81x8XUb5/o1h9v5yKQEYma71POXGqEAPF+jOsmEdKl6mH9eXws4pZoXJaZ0CH23
         3x08Ur863J/tOrmAwil/IhfKS6GZ5/9kHql8+7ac4dOODDjLdwzad9x/EZRInhUJmq67
         oSizJJz06NFY4alIfghDwF+YKgTjtHEoodgSESqKj/ztNLtjjezKGiB8Oe2Q6Gd30xu4
         lChs7aAjYwO3WKLzSe55D8NJpEF61TJo3iB3FPgwzAWvjhN4ytXj7nsSQDF8xyjBvyPZ
         IGTg==
X-Gm-Message-State: ANoB5pl3t1SRY3WVFCmeGShpf/dBUjcWMgN++kus+RHWiBfR92m1Wx+0
        SDfz/xpuGvyKQcEqTr8noNwepXPM9M0CsA==
X-Google-Smtp-Source: AA0mqf62eTzXyDSBZkE/AtV0fC7U8HTdv0sT57bbTCTkhk2WzwAApDGDQRoS8K8YGJBnVcAhA+Xtwg==
X-Received: by 2002:a05:6a20:d492:b0:a5:df86:f2c3 with SMTP id im18-20020a056a20d49200b000a5df86f2c3mr34110935pzb.32.1671122817363;
        Thu, 15 Dec 2022 08:46:57 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id r7-20020a17090a1bc700b00217090ece49sm3376132pjr.31.2022.12.15.08.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 08:46:55 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 15 Dec 2022 06:46:54 -1000
From:   Tejun Heo <tj@kernel.org>
To:     hanjinke <hanjinke.666@bytedance.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [RFC PATCH] blk-throtl: Introduce sync queue for
 write ios
Message-ID: <Y5tPftzjXN6RcswM@slm.duckdns.org>
References: <20221206163826.10700-1-hanjinke.666@bytedance.com>
 <Y5et48VryiKgL/eD@slm.duckdns.org>
 <1e53592f-b1f1-df85-3edb-eba4c5a5f989@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e53592f-b1f1-df85-3edb-eba4c5a5f989@bytedance.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, Dec 14, 2022 at 12:02:53PM +0800, hanjinke wrote:
> Should we keep the main category of io based READ and WRITE, and within READ
> / WRITE the subcategory were SYNC and ASYNC ? This may give less intrusion
> into existing frameworks.

Ah, you haven't posted yet. So, yeah, let's do this. The code was a bit odd
looking after adding the sync queue on the side. For reads, we can just
consider everything synchrnous (or maybe treat SYNC the same way, I don't
know whether reads actually use SYNC flags tho).

Thanks.

-- 
tejun
