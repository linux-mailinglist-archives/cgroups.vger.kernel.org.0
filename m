Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91C5614FFA
	for <lists+cgroups@lfdr.de>; Tue,  1 Nov 2022 18:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiKARFu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Nov 2022 13:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiKARFs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Nov 2022 13:05:48 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107B513EA8
        for <cgroups@vger.kernel.org>; Tue,  1 Nov 2022 10:05:48 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q1so13921394pgl.11
        for <cgroups@vger.kernel.org>; Tue, 01 Nov 2022 10:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPK2zn5iH+4/8Do8MqFipb61XMSTHdDc79uVt62ln2c=;
        b=dSy2+/kvn81Hhe3kSpPj6p+kwaeinfvOAuvg9QTW2spXOeF25dVN22tLddv56zUVqw
         IgNtM75ja/S/MqrzUEWIwRxjWFZRi2VcPkjfLXIwzEM1xT2Iur7vVC53xhvIxWZQMBQ6
         rvrs4a8iHc77jpbfqQuR96nC8vpVAmUFX+ZFVvfaYoFQdWNYswpXGk//ZBC6348LZv+E
         n6WzzoB219LjIMBcOtuglzD0jrt9+MLfOnH1d7BeUgM+66sNrQjaulQUs0NLZam/j+vA
         VrxKKVju/WzX6UXoQkwxYoDrmhRgO4YNwANfei3cayl/pR/OSv3aWz4rWVZUxSLfPx8s
         9WRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPK2zn5iH+4/8Do8MqFipb61XMSTHdDc79uVt62ln2c=;
        b=a4h2mWyAR1g1TtyMn+bFQuwNQsaipYjGWsIp/GVjiTqVVsM7yoKLgOjF58kce9gj7A
         J3NpNvQDMKYmpp8N/JmocWKzcq5pkSBG/4xePiXFAYePpYChAMog/RXzZeSPYSst4KB7
         5nvjzZCR3qxtNoSdUyAcs37cta6/IdTznQCTH+ULYIpbKY2eRgdg4EugVms8YotPPg5y
         3IHn6jCWcdYj/abULyVw+cYj44JyT7NFkxkpYBoXFMKrt/jAmWNP8DMcneVZgua3kQyv
         aensobvtdoffZ5exzKG/bN/SJD18eYG1AHUtU2hBZiqIaExksqEZ9cHVMbAc4iwxin+S
         /jKQ==
X-Gm-Message-State: ACrzQf3A8p+YrLWE4L6+XFnBSTqFkzOlIzmp/03eOEikhnK+fjEsJ8dR
        0g8brhdLFrJimCH5pVWm4gw=
X-Google-Smtp-Source: AMsMyM6vYWluUxTmn5ocnCOvlO+s85g41rs/UMa6JBnaWb8bzq5cPdFDnyWzye51BoV3cORQQBb/+g==
X-Received: by 2002:aa7:9421:0:b0:56b:b2a8:6822 with SMTP id y1-20020aa79421000000b0056bb2a86822mr20440134pfo.86.1667322347343;
        Tue, 01 Nov 2022 10:05:47 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:f37f])
        by smtp.gmail.com with ESMTPSA id qe13-20020a17090b4f8d00b001fe39bda429sm6241802pjb.38.2022.11.01.10.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 10:05:47 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 1 Nov 2022 07:05:45 -1000
From:   "tj@kernel.org" <tj@kernel.org>
To:     "Accardi, Kristen C" <kristen.c.accardi@intel.com>
Cc:     "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: clarification about misc controller and capacity vs. max
Message-ID: <Y2FR6SYazbxyK5nj@slm.duckdns.org>
References: <2f7b7d6b10bdcbc9a73ea449d3636575124afa25.camel@intel.com>
 <Y2FPSqOaQGnISvXu@slm.duckdns.org>
 <14c21f13ebbcdbd0ea4f75b7fff790b31a05a5aa.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14c21f13ebbcdbd0ea4f75b7fff790b31a05a5aa.camel@intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 01, 2022 at 05:03:25PM +0000, Accardi, Kristen C wrote:
> So to be clear, if I have this:
> 
> /sys/fs/cgroup/misc.capacity
> some_res 10
> 
> and this:
> /sys/fs/cgroup/test
> 
> test.current will never be allowed to exceed 10.

Yes, but test.max can be whatever. So, the resources themselves can't be
over-committed. The max limits (ie. the promises) can be.

Thanks.

-- 
tejun
