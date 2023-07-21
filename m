Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8848475D0FD
	for <lists+cgroups@lfdr.de>; Fri, 21 Jul 2023 19:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjGUR6a (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jul 2023 13:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjGUR63 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jul 2023 13:58:29 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4B610D2;
        Fri, 21 Jul 2023 10:58:28 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b8b318c5a7so16397125ad.3;
        Fri, 21 Jul 2023 10:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689962308; x=1690567108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MMbeZmEn/swkwXIwhi1G20TJgN07f15MbpFEH7XJldc=;
        b=MZVVaJCSJBESRhr44VQl7fRqn1vS0H3bwcrQB8k9au2IGSxCbBIJeZSaUnZyczg1We
         ceJ9z12LH/pQVCq1gfMKMxVNw7QDr2/EXK8ksWcab4fIbflvH0CYdK4JEUz/lg8UTisF
         tiFLFaTAAy7ddvrVD1Xqb9inzgg5zxAhJ1Rwdmsll7XFF4uPTNd7GoqahY5GwCzcn3YS
         aZacoedWo8fACF6ntfMjyh8skU5gM0mWEwz7hkKZ6PCEs/JjzBIfybibTCnf4qmVmc0j
         0kuSq7AMF4GPNJhMro4tyVSsGyhkHMxNIkFkobQs8pnD2Cz9a3TgWpX2od2nUd7LGafq
         Fjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689962308; x=1690567108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMbeZmEn/swkwXIwhi1G20TJgN07f15MbpFEH7XJldc=;
        b=Df+MQqL/ERd+4KhdfzTHylvQj4Pi3MUjKPrEgnB/ZSO0T4uv+ouj25BfAOCqdsGPhc
         yCf7didZNdkS73ylSPuInLXXLGSyH7KzSq80bEOXLFqx6VtVCStXAFdL7WRUTZjLVrPs
         /cbPj0oAzjuqq8oazIlZxLedMjpyQwcDsn9Z0f4K89SmS123jd8J70tgQ69d+2vLTNij
         qUHMjlGhL2mmOuzyHVb2GitKYdhw3UzHAhUGBuioCPULzcwKWF38sWkNJ6NI0mIo7kYY
         p4ZtN60Ihj89tnTvKSqyFvobTRX662iqDQ45xDgvPhcuWYBsQ+0InLv3OPgBQhfL9a79
         SYTA==
X-Gm-Message-State: ABy/qLaZV4I0Hh4rWn3L4/BGUgpHAePx3y73IJIy9f++qdKo+2ryy5WG
        r/3L+tcMh29wkWf6N7+ODf4=
X-Google-Smtp-Source: APBJJlFZOxA85hb2alsHxftA/O54YBS4xLQYPlm4wLRgmBlKtHl4K87dLtCcuzdTj3L5ZeuP44pv6A==
X-Received: by 2002:a17:902:d512:b0:1b6:c229:c350 with SMTP id b18-20020a170902d51200b001b6c229c350mr3400923plg.18.1689962308024;
        Fri, 21 Jul 2023 10:58:28 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:fbd8])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090301cd00b001b83dc8649dsm3767352plh.250.2023.07.21.10.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 10:58:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 21 Jul 2023 07:58:26 -1000
From:   'Tejun Heo' <tj@kernel.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Carlos Bilbao <carlos.bilbao@amd.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        amd <amd@localhost.localdomain>
Subject: Re: [PATCH] blk-iocost: fix seq_printf compile type mismatch error
Message-ID: <ZLrHQgIb8jnm5biX@slm.duckdns.org>
References: <20230717141852.153965-1-carlos.bilbao@amd.com>
 <ZLWNHuTGk0fy8pjE@slm.duckdns.org>
 <2b4540aadc3c4449a192aeed6211f232@AcuMS.aculab.com>
 <ZLmT3mXuDlYY61w0@slm.duckdns.org>
 <fd89f72848da4569a19ec8a1ac9ec94e@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd89f72848da4569a19ec8a1ac9ec94e@AcuMS.aculab.com>
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

Hello,

On Fri, Jul 21, 2023 at 08:05:59AM +0000, David Laight wrote:
> In any case it is enough to split the enum.
> If you really need unrelated constants to be defined in an enum
> them maybe use a separate enum for each.
> Using (on one line):
> 	enum { name = constant };

Yeah, I'm hoping it won't come down to that. Hopefully, we can limp along
like this until we can always assume the new behavior. Right now, the
problem is that both gcc<13 and gcc=13 have to supported when the two assign
different types to the same enum definitions.

Thanks.

-- 
tejun
