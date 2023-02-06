Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC6868CA93
	for <lists+cgroups@lfdr.de>; Tue,  7 Feb 2023 00:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBFXba (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 18:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjBFXba (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 18:31:30 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CCF31E13
        for <cgroups@vger.kernel.org>; Mon,  6 Feb 2023 15:30:51 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id v3so9318402pgh.4
        for <cgroups@vger.kernel.org>; Mon, 06 Feb 2023 15:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3I5S/XPIxpUgoBauf/+NPXEdSiTaYk3UCKZzofjtfLA=;
        b=Qj9V0ZBwFT0n8JqROyha9p0R+tnoKGnpJ2YXkenvZLANWuEAxElz5cGVevZ7f5Myef
         0dylM8kF3S19N3Ni4NJuD6qvsa+pW/u8S20R52FOceFhlvhzWu0EBHhlbVONcQGVtpes
         57ULIludUKISxLgdmzzcnTQzOppdr1sv/VEwzmQ46HAggY83MvMOD+qekM/RSRL1aeNe
         mJLaJ37mXRbSKxQqSW1JIUOnh0CvmQk9NiLb5JSPtgkTNcRIDDh8c2nMi1lmCIOqyD96
         GzD6WA0vrYg2bdd1Q9RvBqreOpxawJEbsaJYzuefMr5NaWQzNsvyG3v2MVoscZSJcTnc
         TAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3I5S/XPIxpUgoBauf/+NPXEdSiTaYk3UCKZzofjtfLA=;
        b=gB0tdCAczHDhU181JLajZeOHpNTu728z/mHY7+zslZSyBiNwUxMAmbctTcQCwROXod
         Tdr35Xra7wmRug6Yf1GQ7uPpUIB7zQ8V77Dhf1GAXDPa+ulqyYvJaNH98uqDUNMZC/1a
         4eE5IkshKcccI+I/1MVzIpNPtFKl+sdTBz5hwOkKyfBLe2yPH/JOGEaclWIRHOLr0i+a
         j3MjMsGyY3WD7ruOiuxO7Tbm3GrbTrJEdUCDlx/Zt8GD7V1IDF5GTwltyQqtmSuw8/5h
         L1Pt+Ykl+3+f2XF3iyYh/39kNfanVQu04nrzmwuFk0D1rp8Ltx0nX6/9KTxngsW7BBAN
         HLQw==
X-Gm-Message-State: AO0yUKUaXmkZ0Sra0Ju03+YEZwWqZSn/+NU4Jc2BpilvnThX/IPjrvPd
        pgocrOWEAUv/8ue4L1PFvmY=
X-Google-Smtp-Source: AK7set+jYiWPBDYFg/lWgkUj7p6FvYr3FzZx49H59kN0WEW22PrXMt6IctuuoHjQSV6opNmj1IB5mw==
X-Received: by 2002:a62:1703:0:b0:593:9109:4627 with SMTP id 3-20020a621703000000b0059391094627mr1184548pfx.0.1675726249853;
        Mon, 06 Feb 2023 15:30:49 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id a3-20020aa78e83000000b00588e0d5124asm7694091pfr.160.2023.02.06.15.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 15:30:49 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 6 Feb 2023 13:30:47 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "Thomas, Ramesh" <ramesh.thomas@intel.com>
Subject: Re: Using cgroup membership for resource access control?
Message-ID: <Y+GNp4VA1T9pV6nM@slm.duckdns.org>
References: <Y+FvQbfTdcTe9GVu@agluck-desk3.sc.intel.com>
 <Y+F0NA9iI0zlONz7@slm.duckdns.org>
 <Y+F0mXS9z0flDhf7@slm.duckdns.org>
 <SJ1PR11MB6083C61BCA70A31F8C0F12ECFCDA9@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083C61BCA70A31F8C0F12ECFCDA9@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Mon, Feb 06, 2023 at 10:18:11PM +0000, Luck, Tony wrote:
> Imagine some AI training application with one process running per core on
> a server with a hundred or so cores. Each of these processes wants periodically
> to share work so far on a subset of the problem with one or more other processes.
> The "virtual windows" allow an accelerator device to copy data between a region
> in the source process (the owner of the virtual window) and another process that
> needs to access/supply updates.
> 
> Process tree is easy if the test is just "do these two tasks have the same getppid()?"
> Seems harder if the process tree is more complex and I want "Are these two processes
> both descended from a particular common ancestor?"
> 
> Using fd passing would involve an O(N^2) step where each process talks to each
> other process in turn to complete a link in the mesh of connections. This would need
> to be repeated if additional processes are started.

Wouldn't it be more usual for the parent to create the fd and let all the
children share through it? Even if not necessarily the parent, there can
always be a main process that can send the fd to whoever needs it.

> It would be much nicer to have an operation that matches what the applications
> want to do, namely "I want to broadcast-share this with all my peers".
>
> [N.B. I've suggested that these folks should just re-write their applications to
> simply attach to a giant blob of shared memory, and thus avoid all of this. But
> that doesn't fit for various reasons]

I'm not sure it'd be a good idea to introduce a whole new mode of access
control for this when it's something which can be addressed with more
conventional mechanisms. Maybe it's a bit more upfront work but one-off
security / naming mechanism feels like they'd have a reasonable chance to
cause long term headaches.

Thanks.

-- 
tejun
