Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16FF6CF286
	for <lists+cgroups@lfdr.de>; Wed, 29 Mar 2023 20:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjC2Syg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Mar 2023 14:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjC2Syf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Mar 2023 14:54:35 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98725251;
        Wed, 29 Mar 2023 11:54:34 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o2so15855888plg.4;
        Wed, 29 Mar 2023 11:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680116074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SvJI0H5Hc+fTAdKMTbT6mE44kRVz6oz6/kFJz7w8sLA=;
        b=YC5lVgwC4h2kPani96r3mkA6vwoBzUZ2d7vme5A2e7AJauPWYlwhzZTESImrRROqVc
         g4z4UkSqsrJZMiMHOfSIT0w7fc7g+oPawMX4cbot2bSCdbhHVelHRMeh1ZpmISpBcaYc
         1tdnnlkV0KxDHcgqQ8KnAECDBJo7YxjufIdr8syQtaPFlwzlY6EZzekoxmqlGnw8+BHn
         p0xiVxUtS14PDNIAv9QLz4EPr/stF6xAJZ3q+TUEL8W90LyewZTGMjOgiYyqSY/73Iea
         yGZ7v4T0swwe8GmcCLb8yb5uXhB3q1tX0vOD9hMQUot3FQKbNE4cA3HbNrKoX2pedSry
         6okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680116074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvJI0H5Hc+fTAdKMTbT6mE44kRVz6oz6/kFJz7w8sLA=;
        b=nH4FveNWItnp9afXtUWsRZ3xvkJa5FuuocI2M2bk3wWxOUS4T/qBTugXPacStTiIPS
         n5E5Ojh0eqk1eBJWi21ogps1s0hbHVvmrfCNj0fDgyKnRLa/bystHRXuWR+H7vM6OWan
         OfmVTDB0rSCbncvISuBgxwCJAzaqFFU6WB2ChO88ckLPHK9xoewvfXM6xTzFlsg9+MAz
         rfzURZIo8CSSKlhjM07kKLY9AfknYYYM94eNylHs7FohTuHq8r2jo2JKLwLTQT9NSex8
         O1sY5A/6wZcKG/aKSCq+q9RWV6jrGH9p7vAcwZP2wwD2+mytjs8ToXZYCeiHWF6Cmf4e
         jDLA==
X-Gm-Message-State: AAQBX9cKlCxRfSXNQ5NF/1W3JZpdQMykll2mIlbvPvlgcvbEY6A4Sz2d
        sbws1qeVacd1X1oteeYpF4txmh+plDM=
X-Google-Smtp-Source: AKy350ahFFWWrbD72Jen5A2yk5ObbvHJB1yYeHQ1sHxxiMcBibzIjUB44CuCfhMZ5cwi02S0n3jdBQ==
X-Received: by 2002:a17:90b:4a50:b0:240:59e8:6dad with SMTP id lb16-20020a17090b4a5000b0024059e86dadmr17931802pjb.25.1680116073996;
        Wed, 29 Mar 2023 11:54:33 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090a3f8100b00230ffcb2e24sm1751009pjc.13.2023.03.29.11.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:54:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 29 Mar 2023 08:54:32 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jinke Han <hanjinke.666@bytedance.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-throttle: Fix io statistics for cgroup v1
Message-ID: <ZCSJaBO8i5jQFC10@slm.duckdns.org>
References: <20230328142309.73413-1-hanjinke.666@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328142309.73413-1-hanjinke.666@bytedance.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 28, 2023 at 10:23:09PM +0800, Jinke Han wrote:
> From: Jinke Han <hanjinke.666@bytedance.com>
> 
> Now the io statistics of cgroup v1 are no longer accurate. Although
> in the long run it's best that rstat is a good implementation of
> cgroup v1 io statistics. But before that, we'd better fix this issue.

Can you please expand on how the stats are wrong on v1 and how the patch
fixes it?

Thanks.

-- 
tejun
