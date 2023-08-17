Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D90478003B
	for <lists+cgroups@lfdr.de>; Thu, 17 Aug 2023 23:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355437AbjHQV53 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Aug 2023 17:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355505AbjHQV5G (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Aug 2023 17:57:06 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098502D44;
        Thu, 17 Aug 2023 14:57:05 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-689f4fb1c29so222893b3a.0;
        Thu, 17 Aug 2023 14:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692309424; x=1692914224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z0omXZny2n+CByL2k7ciGeHHMSQ9u/agRJB2cjviSi4=;
        b=hr056v+KwQCD7KsAAiffnt/3sSt1kTIcf8ne4SKRK1o44FszUJAWCBrFUQsZHgYJDd
         bTx5INJz3ICUgZz0sm7keyITgp8HsgzZ5fohuetFK5lXFrlPf34LBKJauHkvKMfd+HWR
         rSkXHrHmvgzDtHH9FbA4JhNetRxt06m8trUlP4HeA8yKYy4R9AoHI/uo/u4JVQy+wmR+
         NRbSgaY2wzwBttQN0mjQtVyq6GMvxh+wPKKLjiow1eQwe/MqfXp0XZ08TJ0tD85qGHep
         zaK8DfYd9FSX3Ds78+mMzfluB+IRK6o7PCoOqHPsCa8To8OnwauvRZPsxxGUDk3gt1Bu
         GyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692309424; x=1692914224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0omXZny2n+CByL2k7ciGeHHMSQ9u/agRJB2cjviSi4=;
        b=ehfewPl48+urRuG5CTpf0R+GLtAAYRp3yqYhjEedLfUR7JSsJ/AyFiGNCpvkqHo+7f
         ILI4z688slSi+udDavgPofzoIndtgwAkOfbQlkkCMc0QBD/HSxVygZzD6mYh440jzWzm
         MedpMh6YSgf8H8EpVEpevUpfnmh8F1QZkxut5ORpaNk71xKkDxmahyFFZOzoB4Elcscs
         Bfptl52NokDimh2x9/KHWyTuYlBqsyY1KYgUD3g6VR1WRgxkSlQ4NLbDLrJunjh/Xdtv
         C7mBH6CRVyjtp4cLIx448sPaFI3Op71C7qWTlk0mMrsRurAAU+CEtuwB4PPCIDPZFCkS
         oejQ==
X-Gm-Message-State: AOJu0YxwNWfTDqFGmsnOait8gJ49SXkUQ84NOXe/bty8JSU4Ef2Qef9l
        ak76Ap7TpE1aVSalqaLleLU=
X-Google-Smtp-Source: AGHT+IEP+XwGLfMhFD6DTODFTV5Plu4zVyjwNVkF/Rry609CkvL+6YWELYMGm624RG7P+zNerxL1bw==
X-Received: by 2002:a05:6a00:3028:b0:686:5f73:4eac with SMTP id ay40-20020a056a00302800b006865f734eacmr5175534pfb.13.1692309424406;
        Thu, 17 Aug 2023 14:57:04 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:93bd])
        by smtp.gmail.com with ESMTPSA id ff20-20020a056a002f5400b0065da94fe917sm235379pfb.36.2023.08.17.14.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 14:57:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 17 Aug 2023 11:57:02 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3][next] cgroup: Avoid -Wstringop-overflow warnings
Message-ID: <ZN6Xrsssr4Pys8YQ@slm.duckdns.org>
References: <ZN5WkbPelHUSTXOA@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN5WkbPelHUSTXOA@work>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 17, 2023 at 11:19:13AM -0600, Gustavo A. R. Silva wrote:
> Change the notation from pointer-to-array to pointer-to-pointer.
> With this, we avoid the compiler complaining about trying
> to access a region of size zero as an argument during function
> calls.
> 
> This is a workaround to prevent the compiler complaining about
> accessing an array of size zero when evaluating the arguments
> of a couple of function calls. See below:
> 
> kernel/cgroup/cgroup.c: In function 'find_css_set':
> kernel/cgroup/cgroup.c:1206:16: warning: 'find_existing_css_set' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
>  1206 |         cset = find_existing_css_set(old_cset, cgrp, template);
>       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> kernel/cgroup/cgroup.c:1206:16: note: referencing argument 3 of type 'struct cgroup_subsys_state *[0]'
> kernel/cgroup/cgroup.c:1071:24: note: in a call to function 'find_existing_css_set'
>  1071 | static struct css_set *find_existing_css_set(struct css_set *old_cset,
>       |                        ^~~~~~~~~~~~~~~~~~~~~
> 
> With the change to pointer-to-pointer, the functions are not prevented
> from being executed, and they will do what they have to do when
> CGROUP_SUBSYS_COUNT == 0.
> 
> Address the following -Wstringop-overflow warnings seen when
> built with ARM architecture and aspeed_g4_defconfig configuration
> (notice that under this configuration CGROUP_SUBSYS_COUNT == 0):
> 
> kernel/cgroup/cgroup.c:1208:16: warning: 'find_existing_css_set' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
> kernel/cgroup/cgroup.c:1258:15: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
> kernel/cgroup/cgroup.c:6089:18: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
> kernel/cgroup/cgroup.c:6153:18: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/316
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied to cgroup/for-6.6.

Thanks.

-- 
tejun
