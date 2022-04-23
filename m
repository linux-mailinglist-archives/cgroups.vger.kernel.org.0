Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB4450C9BC
	for <lists+cgroups@lfdr.de>; Sat, 23 Apr 2022 13:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbiDWLxd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Apr 2022 07:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbiDWLxa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 23 Apr 2022 07:53:30 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389F71F6E6D;
        Sat, 23 Apr 2022 04:50:34 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id e128so7600993qkd.7;
        Sat, 23 Apr 2022 04:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PveZFFy5DjWV6FRcjoJAL/47PpCBgs3g9S6snQO0X6I=;
        b=YE5gyLgzP/JpHpFZI0jlGBFBuh+gBlLtrU+L/28MS0RD9waKFhTBRviDsiVBrPLQ6I
         MfF/TZKbdBuejaPCS9am3ClP+7C7Z7ShA0iHD+M8RPheKnmId9DsoUQcNXM/IkrR0hCh
         KJ3/p9ZEkcu7bxvgQlnD3Kcb4xsvs3DOTEvkJgbQ9wv+C5PNDMRvWOhOoGxs5qAsxgXb
         xAiaH0mdDG/KXxLSplWtf031WB5xjiXgGdiGSTdu3R2b+c/jH6xjIhF8IBbHlgJxIqUc
         MLjHSSH7GDATOMRgVzwh5v7IzS0UqjNTlhfwTgtObQNrpA5F3Thboscwbwi4n0liMAMC
         +17g==
X-Gm-Message-State: AOAM530oaI2OfNoU/EP59zz9He7tq87SjnNA4/TqfyLhHyqSSx86uLrJ
        xrx8lMmdoccfw5andMyLy/Ucvdnr6o31aQ==
X-Google-Smtp-Source: ABdhPJzSNZPXMfHsH4gNHFIZZSEdZMchVyCNRJ7PtwHf6oYnAETrt3eM7zPN/0PyMTHGeSzavJ1UjA==
X-Received: by 2002:a05:620a:2405:b0:69f:2238:989d with SMTP id d5-20020a05620a240500b0069f2238989dmr3391511qkn.318.1650714633308;
        Sat, 23 Apr 2022 04:50:33 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-020.fbsv.net. [2a03:2880:20ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id c13-20020a37e10d000000b0069c268c37f1sm2197836qkm.23.2022.04.23.04.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 04:50:33 -0700 (PDT)
Date:   Sat, 23 Apr 2022 04:50:30 -0700
From:   David Vernet <void@manifault.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     akpm@linux-foundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com
Subject: Re: [PATCH 4/5] cgroup: Removing racy check in test_memcg_sock()
Message-ID: <20220423115030.ee2gxwkwjzetzoby@dev0025.ash9.facebook.com>
References: <20220422155728.3055914-1-void@manifault.com>
 <20220422155728.3055914-5-void@manifault.com>
 <YmM/NCX9FwUY/GvB@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmM/NCX9FwUY/GvB@carbon>
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

On Fri, Apr 22, 2022 at 04:50:12PM -0700, Roman Gushchin wrote:
> On Fri, Apr 22, 2022 at 08:57:28AM -0700, David Vernet wrote:
> > test_memcg_sock() in the cgroup memcg tests, verifies expected memory
> > accounting for sockets. The test forks a process which functions as a TCP
> > server, and sends large buffers back and forth between itself (as the TCP
> > client) and the forked TCP server. While doing so, it verifies that
> > memory.current and memory.stat.sock look correct.
> > 
> > There is currently a check in tcp_client() which asserts memory.current >=
> > memory.stat.sock. This check is racy, as between memory.current and
> > memory.stat.sock being queried, a packet could come in which causes
> > mem_cgroup_charge_skmem() to be invoked. This could cause memory.stat.sock
> > to exceed memory.current. Reversing the order of querying doesn't address
> > the problem either, as memory may be reclaimed between the two calls.
> 
> But just curious, does it fix the flakiness (assuming there is no memory
> pressure)?

Yes, it does fix the flakiness. I saw it fail once or twice in my runs, but
to your point that was only in the presence of memory pressure, which could
make many of the tests in the file fail. Let me know if you'd prefer to put
the check back in, and instead reverse the order of querying memory.current
and memory.stat.sock.

> 
> > Instead, this patch just removes that assertion altogether, and instead
> > relies on the values_close() check that follows to validate the expected
> > accounting.
> 
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> 

Thanks!
