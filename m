Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5595FB884
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 18:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJKQtX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Oct 2022 12:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiJKQtW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Oct 2022 12:49:22 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516A8A5983;
        Tue, 11 Oct 2022 09:49:21 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x6so13734585pll.11;
        Tue, 11 Oct 2022 09:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hY48VDrSzbNwqgQrTRMw8Ws7A/RJwf4Ei5MNSQeswrs=;
        b=cQC+PH2lZiUHWyj98ZXVBDmjg7/8/df+X98sp8YnymRQhLZid6OYG8dCeBcpYtCXp3
         OrR94346LxPvqCJUKOIqnyS47AKdphHIxh4sBhbUxuGwSJ9Xm8NiGNuqlx/Tkfxat7ZJ
         OI05Ph+FWzJzKhU9pZgLR+fw3xGtvvbJEJkPvR7j5ErCXlJ1Ipj4cGNDv7Fw62e8/IQZ
         aLbMAopbWrhXFm/KnJdshIL+S4mXmKieBiE4oDEXnQL+AMKafIJ1HD7zofgChOG23Cwo
         sOWWR0iSI6ED+g6lBKggEjJnP3uNrHglHK6Yg2myxQCH7EOD4KTjBjgMfoB5+9WTjSv+
         DcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hY48VDrSzbNwqgQrTRMw8Ws7A/RJwf4Ei5MNSQeswrs=;
        b=y9sok9CVO8vSyy3wSLAGDfo3w+blHMm89zmsDtsX4GdFD4pxcnRSpuu4UQwhMxLukr
         W3ouqpW1dqikDpWbBmXe8m9DfDxOTFffuvqy16UZy94Bh5chIHXMYQ//uUlWySphoB9/
         evNYUwiwBlP3fWSBC2f+J6ggd7sCEIhwL5pmusmkpbxSxA1ZCDwmMxvlW2v0itzpQhMr
         i1dCZ5UTKN051JFe6VZmGazixURnv3gPFCHbrTk9dzle8mbxFeykoeCwn03mIJgrQhUQ
         9CUP/4KQ9gNar9fLWRLhsxtbsBJVSAduZaYjj/c9JV3z4mjN3heoayRUd8VkAuS8wYft
         3BwQ==
X-Gm-Message-State: ACrzQf1AqVIIvuBzQNCHoUEnDpwNI7UxEtIY4JMzpqy8NS1pGPHEoGOJ
        ZT9UE+rj0Pfrsqukhp65T7s=
X-Google-Smtp-Source: AMsMyM7Am+Bzxd3hklHFJopJtukJYRIyLTbUYJCtRrFaLonv/LltrsI80he7eUDM7MA5GvCFf6qAig==
X-Received: by 2002:a17:902:f355:b0:180:bdc5:4cf4 with SMTP id q21-20020a170902f35500b00180bdc54cf4mr19705087ple.15.1665506960567;
        Tue, 11 Oct 2022 09:49:20 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id t6-20020aa79466000000b005631af4ece2sm6018478pfq.182.2022.10.11.09.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 09:49:20 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 11 Oct 2022 06:49:18 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Yosry Ahmed <yosryahmed@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 2/2] bpf: cgroup_iter: support cgroup1 using cgroup fd
Message-ID: <Y0WejttpkBmM3yr2@slm.duckdns.org>
References: <20221011003359.3475263-1-yosryahmed@google.com>
 <20221011003359.3475263-3-yosryahmed@google.com>
 <2ba0ee79-2e7e-6807-3312-1a2c5ef3bae0@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ba0ee79-2e7e-6807-3312-1a2c5ef3bae0@linux.dev>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 11, 2022 at 09:46:27AM -0700, Martin KaFai Lau wrote:
> On 10/10/22 5:33 PM, Yosry Ahmed wrote:
> > Use cgroup_v1v2_get_from_fd() in cgroup_iter to support attaching to
> > both cgroup v1 and v2 using fds.
> > 
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >   kernel/bpf/cgroup_iter.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
> > index 0d200a993489..9fcf09f2ef00 100644
> > --- a/kernel/bpf/cgroup_iter.c
> > +++ b/kernel/bpf/cgroup_iter.c
> > @@ -196,7 +196,7 @@ static int bpf_iter_attach_cgroup(struct bpf_prog *prog,
> >   		return -EINVAL;
> >   	if (fd)
> > -		cgrp = cgroup_get_from_fd(fd);
> > +		cgrp = cgroup_v1v2_get_from_fd(fd);
> 
> Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
> 
> Tejun, patch 1 should depend on a recent revert that is not in the bpf tree
> yet.  Do you want to take this set to the cgroup tree?

Yeah, will do.

Thanks.

-- 
tejun
