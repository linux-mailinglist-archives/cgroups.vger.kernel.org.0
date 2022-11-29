Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF99363C859
	for <lists+cgroups@lfdr.de>; Tue, 29 Nov 2022 20:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbiK2T1d (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Nov 2022 14:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236870AbiK2T02 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Nov 2022 14:26:28 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C926D943
        for <cgroups@vger.kernel.org>; Tue, 29 Nov 2022 11:23:49 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id z17so10569354qki.11
        for <cgroups@vger.kernel.org>; Tue, 29 Nov 2022 11:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n82HVyeen1bMmFClFboMPGWDCdQZFtBvU3cG7O5fWI8=;
        b=MRtFC7hP8CY2xCqHP7rCYvfijtDEx8rfOpofNAGAenjjigPd8l2z/ynJKCzqdXRCs8
         8HqKcLlgR/Mh3Tm8fr5tI6H4dPIaUzK6LWHUAO8HRk8hG7k2Hl4tln+GqsEjL9CQGtlL
         znctiN96cf02+vcvkm8/vyh2JwKTdgt8JgeZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n82HVyeen1bMmFClFboMPGWDCdQZFtBvU3cG7O5fWI8=;
        b=i3UxM50XaI94ZuPx06K9jbynQ3haveHt1Q4Ezeq+6q5Ty238VcfyqpwOkKdUq4EH25
         2muivwFsPXtfDc72Qae3loGAHdIc7ZJ+B3uyidwgjQ//fRYeT3WrkOFcLmaL78V/n1Se
         meTBpco+4rpYpCXT+hc7/UK4aJ5Gg2gHaywLnvT2Pv4wpgNICKOY7h/9COG05f5XyxNU
         iuKlI0h3QVmXzZEU6l7RFG93Kha8DbLXoJwmYwWLNOWdrFL9J1Kok1WFD5mVqMxs94ve
         zs0JYsxv0KFzwWK6sHJBlC2y6nXWe76yOUHS4vqwsHgQ8y9z19By5vEW5cchPVIAAe9u
         oiRw==
X-Gm-Message-State: ANoB5pnMGzTxgKqlq/Ogms0afl2UHgsIoV22IW/+9KuS0zBewJV2fltP
        hUVD7C1IB7/SELt0xUdfPCdKmX8kt/lyaQ==
X-Google-Smtp-Source: AA0mqf7KZjZakCrdTfIkjrtvkQK/dQzWTGMgKt/r6hiiuOR66BTSkfrM9cibCZaWWikkyjO4K8mPTQ==
X-Received: by 2002:a05:620a:1649:b0:6fa:6eef:50c6 with SMTP id c9-20020a05620a164900b006fa6eef50c6mr36326321qko.44.1669749828756;
        Tue, 29 Nov 2022 11:23:48 -0800 (PST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com. [209.85.219.42])
        by smtp.gmail.com with ESMTPSA id s32-20020a05622a1aa000b0039cd4d87aacsm9208108qtc.15.2022.11.29.11.23.46
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 11:23:47 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id o12so10180890qvn.3
        for <cgroups@vger.kernel.org>; Tue, 29 Nov 2022 11:23:46 -0800 (PST)
X-Received: by 2002:a0c:80e6:0:b0:4c7:1ae2:2787 with SMTP id
 93-20020a0c80e6000000b004c71ae22787mr1804495qvb.89.1669749826624; Tue, 29 Nov
 2022 11:23:46 -0800 (PST)
MIME-Version: 1.0
References: <20221123181838.1373440-1-hannes@cmpxchg.org> <16dd09c-bb6c-6058-2b3-7559b5aefe9@google.com>
 <Y4TpCJ+5uCvWE6co@cmpxchg.org> <Y4ZYsrXLBFDIxuoO@cmpxchg.org>
In-Reply-To: <Y4ZYsrXLBFDIxuoO@cmpxchg.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Nov 2022 11:23:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjMrsHq2ku9LeO23DnzGMZfQpZVSBFd86rZLLo3Q+H0VQ@mail.gmail.com>
Message-ID: <CAHk-=wjMrsHq2ku9LeO23DnzGMZfQpZVSBFd86rZLLo3Q+H0VQ@mail.gmail.com>
Subject: Re: [PATCH] mm: remove lock_page_memcg() from rmap
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 29, 2022 at 11:08 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> We can try limiting move candidates to present ptes. But maybe it's
> indeed time to deprecate the legacy charge moving altogether, and get
> rid of the entire complication.

Please. If that's what it takes..

           Linus
