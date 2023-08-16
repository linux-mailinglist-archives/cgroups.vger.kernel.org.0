Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1FB77EB36
	for <lists+cgroups@lfdr.de>; Wed, 16 Aug 2023 23:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346316AbjHPVBb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Aug 2023 17:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346322AbjHPVBZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Aug 2023 17:01:25 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EF6E69;
        Wed, 16 Aug 2023 14:01:24 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a7a180c3faso5643595b6e.2;
        Wed, 16 Aug 2023 14:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692219683; x=1692824483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FuKq3/l4OyQ+0bhsP63oq+yhF5v+FLjFlawMMB3oE90=;
        b=MAh9iyXCBy3uqvElWQriYDbdgKgL+HrzzmoeT8qdzq+naxquZKPbT/q0tywqRJLP/R
         xC3i88CpffAvT4J8QwBM7kPi6qMYTPnc96qL7r+EbRY6IBW0sNMYxpWXfVsno6+sAUsI
         lLymeXyS08FEio/NjL5JfwFpy1hDbuqmZ9UBPMiDmokDvyoTgvE32X/QjGbV5/QE1pBy
         CrKWHxVmhs49ORnTdd7rKKMZohHwV3sxSgDHbgBLh+dZ1An7cRQqAtCmgsKRBT7sHyRN
         NdQbbDSBRevBrJSYPBNsfE2n0kNF1giWo5DGf7Et2o4n0cH+pmLED7zTf5MbTp1Hp93l
         0xJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692219683; x=1692824483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuKq3/l4OyQ+0bhsP63oq+yhF5v+FLjFlawMMB3oE90=;
        b=aqRuZ5by9CggXDKJOQrQL5fK5oLkFHevUMuqZ2JKF/TqtuAV4PiOVIemSpYZJmx3JN
         2uhFfhuNr4vfpoQncGzHzlIRh8v17h+uZuKHBSkLQZcgFp024XLZzwh9+KXOmo+n6UAI
         UvpybkU4V3GbsWE8uhwif8ObxWpwGTvyw0YMcZp1xXzPVtw3J42BlQjP1xRPJ9XP4lQv
         jLM8Y2dVZRL1jxzmGoq+0dfg6Q4bJmZGuPkQjeZmlTzvdv4/pd3TCbBwHMzH6jdZ+iys
         vG3T6IFZgF1syJj/EtZW0m1ZqIjsiyVZUXZcZK6j9OL82dlsFiOby8+mW1M7En+XRYio
         HzQw==
X-Gm-Message-State: AOJu0YzoNLT5zmaPgWRr2CphlrSxZPzwBLnyI6aE5juzpSEubfftiXW/
        yrXmz8fZYUYALGpFMtHqDCg=
X-Google-Smtp-Source: AGHT+IG+yzPUAjw4Lc846dID2+AAZMxbCZc7opWpv5g4lnRQBSCAFJ+jgJL9X5U5VAfAWdPScg4cxA==
X-Received: by 2002:a54:4508:0:b0:3a7:4b9b:55cb with SMTP id l8-20020a544508000000b003a74b9b55cbmr3438751oil.3.1692219683218;
        Wed, 16 Aug 2023 14:01:23 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:93bd])
        by smtp.gmail.com with ESMTPSA id q3-20020a63ae03000000b00563ff7d9c4bsm12604663pgf.73.2023.08.16.14.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 14:01:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 16 Aug 2023 11:01:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] cgroup: Avoid -Wstringop-overflow warnings
Message-ID: <ZN05IZBfaKkPKJfH@slm.duckdns.org>
References: <ZN02iLcZYgxHFrEN@work>
 <ZN02wFqzvwP2JI-K@slm.duckdns.org>
 <202308161356.4AED47263E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308161356.4AED47263E@keescook>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 16, 2023 at 01:57:16PM -0700, Kees Cook wrote:
> On Wed, Aug 16, 2023 at 10:51:12AM -1000, Tejun Heo wrote:
> > Hello,
> > 
> > On Wed, Aug 16, 2023 at 02:50:16PM -0600, Gustavo A. R. Silva wrote:
> > > Change the notation from pointer-to-array to pointer-to-pointer.
> > > With this, we avoid the compiler complaining about trying
> > > to access a region of size zero as an argument during function
> > > calls.
> > 
> > Haha, I thought the functions were actually accessing the memory. This can't
> > be an intended behavior on the compiler's side, right?
> 
> I think it's a result of inlining -- the compiler ends up with a case
> where it looks like it might be possible to index a zero-sized array,
> but it is "accidentally safe".

Ah I see. It's not that the compiler knows that ** access is safe. It's more
that it only applies the check on arrays. Is that right? Gustavo, I don't
mind the patch but can you update the patch description a bit explaining a
bit more on what's going on with the complier? It doesn't have to be the
full explanation but it'd be useful to explicitly point out that we're just
working around the compiler being a bit silly.

Thanks.

-- 
tejun
