Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD9D75B87B
	for <lists+cgroups@lfdr.de>; Thu, 20 Jul 2023 22:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjGTUFb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Jul 2023 16:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjGTUFa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Jul 2023 16:05:30 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823F52118;
        Thu, 20 Jul 2023 13:05:29 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666eec46206so1062390b3a.3;
        Thu, 20 Jul 2023 13:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689883529; x=1690488329;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ShySli6sDETZMpAPGpGb5lvBBzti4dS5P6Lg1E17Uvs=;
        b=hz1Cuka5AmWn4oFd8xD3RyAUehliZu/h3GyLa0qEvCBnGPlUAswENy+LknBCwgcDrO
         aHzNRzQ7Jg4PVCAY/Z9r940jKGI4UClejTJhA0b3L+424a6HsmiaZOSaJeI2Ok1hqqdC
         Ip9e+0/GWLafW040QyOXl1teqgCifhoZLPLaazK47F93L7fVLWOWZoM8VlLLbjRdl6my
         tZXqV/2B9pQGYWhkccYFgJuEbZ9kf1eSMISBb73DopoLsxEQbi1RE9va1oh7PChiGb2B
         L+qUsVBtXpQSxWsENguGaaLb5qtr7udDE5SOgcrpWn9yFbCZ9lF7RIrIo5ov+YksX1ld
         1GdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689883529; x=1690488329;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ShySli6sDETZMpAPGpGb5lvBBzti4dS5P6Lg1E17Uvs=;
        b=TM5fmD5d02yWO38HCymO1q2n7/xobIM3sp+FKrU/3JosC4LqgjAc3AmAA2wsI4fDHb
         10HUHEnRcvoYLPnTyYRew497UT6Irl9jP1FxUtKQtI0pLo8XBPfj+cx0wrOkC9oL6NLs
         9X/BIpxpl7svgWZer+jRy1zUA9GjOWbbNi5HRTAmUGwHOeVrdHbj6I+fqC7K1FbiFT2+
         U0uDhlP3hmTdFQ8ZpJSrKKHt9qrQVmDlcP1ZpCjwVF3nWjtUOb2Q0M3VXpHHzyrj9iFP
         xiJmBMeGRFMRt7bkBxnLCsw/JhpFGEO5K4/1nw+FWgxN0PJxvrOubNNqRYBG6FAPa1C5
         seQA==
X-Gm-Message-State: ABy/qLb9+NKC66NooRJ1DRURWsHIu0N1pCebR0mAUGwHZyT+ee99j3I3
        h/V7o18MMECMenQ88f6Efhk=
X-Google-Smtp-Source: APBJJlG2STMMEfwHgRwBqmoZblu3gm4x6pWp/iJqZswYaybLAJ6Ld086D7JUJArkiVxHpzBph/BmLQ==
X-Received: by 2002:a05:6a00:178d:b0:682:4c9f:aa0 with SMTP id s13-20020a056a00178d00b006824c9f0aa0mr9330133pfg.29.1689883528816;
        Thu, 20 Jul 2023 13:05:28 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:fbd8])
        by smtp.gmail.com with ESMTPSA id n14-20020aa78a4e000000b00666b3706be6sm1566039pfa.107.2023.07.20.13.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 13:05:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 20 Jul 2023 10:05:26 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        amd <amd@localhost.localdomain>
Subject: Re: [PATCH] blk-iocost: fix seq_printf compile type mismatch error
Message-ID: <ZLmThnoXvEqlgf_q@slm.duckdns.org>
References: <20230717141852.153965-1-carlos.bilbao@amd.com>
 <ZLWNHuTGk0fy8pjE@slm.duckdns.org>
 <7044d6b3-a5d1-572d-a755-74f8d4fd31c5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7044d6b3-a5d1-572d-a755-74f8d4fd31c5@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 18, 2023 at 10:37:23AM -0500, Carlos Bilbao wrote:
> On 7/17/23 13:49, Tejun Heo wrote:
> > On Mon, Jul 17, 2023 at 09:18:52AM -0500, Carlos Bilbao wrote:
> > > From: amd <amd@localhost.localdomain>
> > > 
> > > Fix two type mismatch errors encountered while compiling blk-iocost.c with
> > > GCC version 13.1.1 that involved constant operator WEIGHT_ONE. Cast the
> > > result of the division operation to (unsigned int) to match the expected
> > > format specifier %u in two seq_printf invocations.
> > 
> > Can you detail the warnings? Was that on 32bit compiles?
> 
> The concrete error was: "format ‘%u’ expects argument of type ‘unsigned
> int’, but argument 3 has type ‘long unsigned int’". If I run:
> 
> $ echo | cpp -dM | grep __LP64__
> #define __LP64__ 1
> 
> which makes me believe it is not 32 bits.

So, we broke up the enum definitions so that WEIGHT_ONE doesn't end up being
a ulong. Which kernel are you building? Can you plesae try the current
linus#master?

Thanks.

-- 
tejun
