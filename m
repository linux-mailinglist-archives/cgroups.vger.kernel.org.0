Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC5F7B8B38
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 20:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbjJDSt2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Oct 2023 14:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjJDSt1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Oct 2023 14:49:27 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BBBAB;
        Wed,  4 Oct 2023 11:49:24 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-27736c2a731so67839a91.3;
        Wed, 04 Oct 2023 11:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696445363; x=1697050163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BAz3Xi9WInvSjrocrUhcW4J3f0UHIpnVDLlDbVgSoaE=;
        b=fs+fv2Hpbh68V+s9jFlzSklT1CNZp6Nfa9jiMofybqYOXsH8Jl25yBmckg+33mPZb3
         P/DaW1/2C3u4XO7TJjsrq7kNbXwZoVWxSS23As8jERpd0oYLaobSNA3Zs+Id8/Fpg1zG
         JcalaIyX2TTHZCtz0DAY76wdPZfGzMwGKtFVUccsdhBla+LiUyCl4D4QRgJMgQJquOHT
         d7veqFcneodAcwrEkiCIaInYiZl4jvODAKl8iUsCaSdX1/fTTc4zPBfoT64P4zhw7bNC
         B+rRy8z2KNNs+y5rpvkHqH0Y62QshQSbKARb9LNaqmkTIE2pS8eNbZcDcQn/y0L45pyN
         RSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696445363; x=1697050163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAz3Xi9WInvSjrocrUhcW4J3f0UHIpnVDLlDbVgSoaE=;
        b=LoY4O8Dm4z8Ux9fqXey36AUTo9ToRIaTM7DD0FEo1Xn4ES7sYVwoZTWOgdE+LrtSda
         5nWFTERZ/8UQd7zKQymY6pGezopX2sztOt6KeJNq+MtG+TvAsWleZBWzOJeA8Bqrp2fX
         08Eot0/mqngJxX5+LQbrt4RPSJwTHv7IxcmndZMDJFPg5ehqSe/SJd51w9+rrdnPNB++
         DHL0EncoC6BruT7ULjdnV/y1mQpERnXPqecb48Qa4d0ijmoWcu4kQvOP4zE0xybjfFFN
         6ifI8fsnD5USqcNaVZp35PwXnQqs9hSfwhhqUz0daCFM3eSB68m86L9BHgrzLmV8b1d8
         LVgQ==
X-Gm-Message-State: AOJu0YwtqAuSHwFvDYak6EWYNSzZ/2zeQUfJd8WVEPnQx3agZ6dR4Cij
        ClIvZHOcYkABe9PVhtAgqFk=
X-Google-Smtp-Source: AGHT+IHxnrSfu8n52VqBPJ77bPAK4g0y4bGQuXjkLBAgPtyBLKF2VjIVJ4W/vvEg4yzkc8B4XdM4gQ==
X-Received: by 2002:a17:90b:3e87:b0:274:755b:63b8 with SMTP id rj7-20020a17090b3e8700b00274755b63b8mr3145433pjb.43.1696445363240;
        Wed, 04 Oct 2023 11:49:23 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:cef])
        by smtp.gmail.com with ESMTPSA id l18-20020a17090a409200b002635db431a0sm1893644pjg.45.2023.10.04.11.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 11:49:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 4 Oct 2023 08:49:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Luiz Capitulino <luizcap@amazon.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        longman@redhat.com, kamalesh.babulal@oracle.com, mkoutny@suse.com
Subject: Re: [RESEND v3] cgroup: add cgroup_favordynmods= command-line option
Message-ID: <ZR2zsZIung0-mWii@slm.duckdns.org>
References: <20230927142539.GB65411@dev-dsk-luizcap-1d-37beaf15.us-east-1.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927142539.GB65411@dev-dsk-luizcap-1d-37beaf15.us-east-1.amazon.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 27, 2023 at 02:25:40PM +0000, Luiz Capitulino wrote:
> We have a need of using favordynmods with cgroup v1, which doesn't support
> changing mount flags during remount. Enabling CONFIG_CGROUP_FAVOR_DYNMODS at
> build-time is not an option because we want to be able to selectively
> enable it for certain systems.
> 
> This commit addresses this by introducing the cgroup_favordynmods=
> command-line option. This option works for both cgroup v1 and v2 and also
> allows for disabling favorynmods when the kernel built with
> CONFIG_CGROUP_FAVOR_DYNMODS=y.
> 
> Also, note that when cgroup_favordynmods=true favordynmods is never
> disabled in cgroup_destroy_root().
> 
> Signed-off-by: Luiz Capitulino <luizcap@amazon.com>

Applied to cgroup/for-6.7.

Thanks.

-- 
tejun
