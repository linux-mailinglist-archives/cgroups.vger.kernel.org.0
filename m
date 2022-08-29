Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485275A537B
	for <lists+cgroups@lfdr.de>; Mon, 29 Aug 2022 19:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiH2Rtf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Aug 2022 13:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiH2Rte (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Aug 2022 13:49:34 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FD981B1D;
        Mon, 29 Aug 2022 10:49:30 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y141so8917142pfb.7;
        Mon, 29 Aug 2022 10:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=GldkU/h9E+n5JOZ7ToIB/cVKuwIFqjSjpJq/es1t7Xg=;
        b=fB9q9zF4XqP67FyYM7Iv61AuQ77MaSzVus59AWlWVNi5fpF0a9f9QzJmqNJwL7faef
         22Q5q/tee/SwfCuIQyXbGg+5yJnEN8+CrdPZn6TQDlHlYR0BvIxSFbdkGlz9hIIIBGyt
         KifX/c5l4CyZ/Dgq/QpM1ggDc9JJqgNBmJ4HURCNWw9hP1fo3c3FR8AcPSv4+DMhrOUh
         jFigQEPQ5HFlAzq2G3kZQ8eok85E/Q6aDq37F1zJvwKO9B9e9aOUQksXqA6F1Fk4q6+c
         UNYutjitCES3kEp7ag91ULXSFJHjTGaXQGDIKleERmQ5sp0sj8U4o4xLbHfDnA6UD9r4
         5Tag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=GldkU/h9E+n5JOZ7ToIB/cVKuwIFqjSjpJq/es1t7Xg=;
        b=MU1lltcHwL4lnxRsLD/vf+V6oYIkrsUKsijSO4b3sANglFoOpfDKD0Iid8eKWkF/LK
         ++Pblft2E9VS3mj1OIrfsbn8BzGtJOWDsQbf0hcuHXn3bZF15wIPE+u18Bik0RJCIU2g
         O6s4lEVoz7lE+xRRInX0ftRFZKmzRO4Keec/KNJGlBYdNbq1ciL4aGcWGX91nb7Ea6Bt
         LML5NTAoKOb3Cmseqam1myGwkdF/5CetjkAbi27nxQ+elfyCgAzbSqrD1OOUg7CJNuxU
         PCvCAsPjIFAjvEataNCGVPwYb19a0IruHp7RIXJAuvXFiOt/Ymuw033Na8e5VBXGhFL9
         oR4A==
X-Gm-Message-State: ACgBeo2M0MvnFAjnNn2S0+TMijho85RFBm6WDT3+tGVrLI2Y9mI5N61Y
        JbKQlJhd3IRRkykfINYwV7g=
X-Google-Smtp-Source: AA6agR4bimUSudwnCXou8WpqyWlF34nOFvCjk4viTCTeDxrogpXFczWap3FPyqQJ6vy95s3vQbqAQQ==
X-Received: by 2002:a63:6a48:0:b0:42a:3cab:cc36 with SMTP id f69-20020a636a48000000b0042a3cabcc36mr15026062pgc.135.1661795369594;
        Mon, 29 Aug 2022 10:49:29 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090301c300b00172cb8b97a8sm8059454plh.5.2022.08.29.10.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 10:49:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 29 Aug 2022 07:49:27 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Aditya Kali <adityakali@google.com>,
        Serge Hallyn <serge.hallyn@canonical.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yonghong Song <yhs@fb.com>,
        Muneendra Kumar <muneendra.kumar@broadcom.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH 4/4] cgroup/bpf: Honor cgroup NS in cgroup_iter for
 ancestors
Message-ID: <Ywz8J70t3508J62n@slm.duckdns.org>
References: <20220826165238.30915-1-mkoutny@suse.com>
 <20220826165238.30915-5-mkoutny@suse.com>
 <CAJD7tkZZ6j6mPfwwFDy_ModYux5447HFP=oPwa6MFA_NYAZ9-g@mail.gmail.com>
 <20220829125957.GB3579@blackbody.suse.cz>
 <CAJD7tkZySzWgJgp4xbkpSstc_RMN_tJqt83-FFrxv6jASeg8CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZySzWgJgp4xbkpSstc_RMN_tJqt83-FFrxv6jASeg8CA@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 29, 2022 at 10:30:45AM -0700, Yosry Ahmed wrote:
> > I'd like to clarify, if a process A in a broad cgroup ns sets up a BPF
> > cgroup iterator, exposes it via bpffs and than a process B in a narrowed
> > cgroup ns (which excludes the origin cgroup) wants to traverse the
> > iterator, should it fail straight ahead (regardless of iter order)?
> > The alternative would be to allow self-dereference but prohibit any
> > iterator moves (regardless of order).
> >
> 
> imo it should fail straight ahead, but maybe others (Tejun? Hao?) have
> other opinions here.

Yeah, I'd prefer it to fail right away as that's simple and gives us the
most choices for the future.

Thanks.

-- 
tejun
