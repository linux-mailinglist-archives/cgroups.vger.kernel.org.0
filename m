Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D5A50CBCF
	for <lists+cgroups@lfdr.de>; Sat, 23 Apr 2022 17:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbiDWPgX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Apr 2022 11:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiDWPgW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 23 Apr 2022 11:36:22 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F771E2C34;
        Sat, 23 Apr 2022 08:33:25 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id f14so7580083qtq.1;
        Sat, 23 Apr 2022 08:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qJrUJVGVT6gqJK4KN8HDJusUJ1FB5XVpIwvyKJbnkls=;
        b=k6FpbbMMBnbTlsX4CQCthBCen/1Kr7VPQfLSHOIvEEGwgwvviL5VLKueOMvS+RNiVt
         +fa6sYL00wUT4yXeW2tdYTb6aVUVqAQHuJeXFp5aXd8L9cxFoc+zXFObAwI8A8yIi+bt
         A4ErT1vJiPcoMazNW5xa7QpVKb1lcf7hE4hVBorzf+zVxiIGTfXovdCvxjTQK0Wdwlfs
         9zsfcU+0UVUPHY0FIHPGrmxo56T9giQ1mBYXFoz5gPHLJ3kmrBt6YwtNDYGg7zmd48Lo
         /1zSsH0gIBqLYbpekyQ7tEtQq5RmSbJDWplxxcbuq84C6wDZlmbNTSWcA3kDz43dgY3G
         M1gQ==
X-Gm-Message-State: AOAM531CzIV9tcTdNopeJ3XiOJGcliohb8etJwchhJymI4w+VHryD9PX
        PL9QCR1s5FKvwOypp6Vf5IU=
X-Google-Smtp-Source: ABdhPJydqQZ+KYP1B8EgK79hxqm7VtvY1k4CpTZbNBftmTVxThWugowAhDIPkdk/lE5nCghmUeiGlw==
X-Received: by 2002:a05:622a:651:b0:2f2:600:d146 with SMTP id a17-20020a05622a065100b002f20600d146mr6920846qtb.88.1650728004508;
        Sat, 23 Apr 2022 08:33:24 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-005.fbsv.net. [2a03:2880:20ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id g11-20020ac84b6b000000b002f35e802a55sm1754224qts.1.2022.04.23.08.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 08:33:24 -0700 (PDT)
Date:   Sat, 23 Apr 2022 08:33:21 -0700
From:   David Vernet <void@manifault.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     akpm@linux-foundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com
Subject: Re: [PATCH 1/5] cgroups: Refactor children cgroups in memcg tests
Message-ID: <20220423153321.cts6qhlybkghoe2o@dev0025.ash9.facebook.com>
References: <20220423113037.gnfysktiuzmfnpmp@dev0025.ash9.facebook.com>
 <EEC47283-0467-4C97-AAB2-73F17A97CE15@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EEC47283-0467-4C97-AAB2-73F17A97CE15@linux.dev>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Apr 23, 2022 at 08:19:12AM -0700, Roman Gushchin wrote:
> 
> > On Apr 23, 2022, at 4:30 AM, David Vernet <void@manifault.com> wrote:
> > 
> > ﻿On Fri, Apr 22, 2022 at 04:04:15PM -0700, Roman Gushchin wrote:
> >> 
> > 
> > Thanks for the reviews on this patchset, Roman. FYI I think Andrew already
> > merged these patches to the -mm tree. I'll send out a follow-on patch that
> > fixes everything you pointed out, both here and on the other patches in the
> > set.
> 
> The mm tree isn’t a git tree, but a collection of the text patches, managed by Andrew. So you can send a new version and Andrew can update it in place. It’s happening all the time: mostly for adding reviewed-by/acked-by tags etc, but for code updates as well.
> It’s not uncommon for some patchset to mature while being in the mm tree, this allows to include them into linux-next and give some more testing, but without doing many reverts/fixups (Andrew is often squashing fixups into the original patch too). So long story short, you can just send a new version, especially because all changes all minor.

Ah, that makes sense. Thanks for explaining that. I'll send out a v2 of the
patches shortly, then!
