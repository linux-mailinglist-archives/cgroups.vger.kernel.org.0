Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FDF5FF25F
	for <lists+cgroups@lfdr.de>; Fri, 14 Oct 2022 18:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiJNQlB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Oct 2022 12:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiJNQlA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Oct 2022 12:41:00 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8220164BC4;
        Fri, 14 Oct 2022 09:40:59 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id z20so5219190plb.10;
        Fri, 14 Oct 2022 09:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdQA2IQ/Zdiw0tfXrnTykfoypuZKZExhaq/VdDsyQcg=;
        b=lCZxuDQ0UPruEZ3c6zkM+o+qq6D1nO1fap4bCgiQi6n4b6TbYBoDGep63xEa6p+6rW
         pGtFf0jMeYoePHiirDy6OlVQFAYU6X/0q4u7KJkWUETFT8OVwV9kiiJQTbBK634iY4+o
         gcChe/p66whQgzhN44BnnLULT/bBd5I9GdAZ2oFfNP6QTTMqCDG2p/5Rz1divNDUdNk8
         ivCY6FR9gM7s7d2MOyIHRmcgTAyq5BzepvRQ/9ba6jdLX34SpmaflPJjZNYdYK/1I/E2
         1tPi3+nEkB8mvEwQJzulQFruvebnBL8Oqt9v+jLs+DcxuHOD8ojUteRDXLXKF0w15HSc
         5MNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdQA2IQ/Zdiw0tfXrnTykfoypuZKZExhaq/VdDsyQcg=;
        b=GyGIHeV0QS4oR8SkFGtJM3tErVvAsbq0H4pqo0PkC11oBpcgKHKBKbgnXE9AceV+F/
         uGgbfa/0Ns2TPSrEv4qeDlCdxuLO3rZP68hcvLtLQVBaL8aHhkFepLPOvd4I6d7T0CAb
         653qG6VYBVbqbr0XGxOTCdSWg7AEVCPdk46sF5SERKxjQKQ82Uj+Wh2y3G/3HnmsdhA8
         /4Z56QsNmh0iIWfMDgQi3H/e5pVz5jJHM/DcA9NOyPOzFgILqX8p0py9kQMNGdzhTSRU
         DLkgxv9ptRr/E07RD1o3UdARBKOcUAamREh5X6qkmikZEUDmD9bLw9D5fPjWLw4lxNbJ
         5xGQ==
X-Gm-Message-State: ACrzQf34xfLd1mgVrnvgYqF5RLd1aK1syKsU7Ed2ytImqvAH0LCjVxFZ
        ISBA4UCuBumWF2b8OrcYvZ8=
X-Google-Smtp-Source: AMsMyM5hz9KlxdRbCJVb4RjTHgSMw6cypfg1KV1GzzYbBdOYpMMFZTtaGR/jfmjS2D3jGJFMtbSjxw==
X-Received: by 2002:a17:90a:b00a:b0:203:87a3:9e70 with SMTP id x10-20020a17090ab00a00b0020387a39e70mr6578164pjq.218.1665765658559;
        Fri, 14 Oct 2022 09:40:58 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id y187-20020a6264c4000000b0056328e4d466sm2001005pfb.146.2022.10.14.09.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 09:40:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 14 Oct 2022 06:40:56 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v2] perf stat: Support old kernels for bperf cgroup
 counting
Message-ID: <Y0mRGJx4Mc7t7fGB@slm.duckdns.org>
References: <Y0Sx2KWX4gPlLytq@slm.duckdns.org>
 <20221011052808.282394-1-namhyung@kernel.org>
 <Y0Wfl88objrECjSo@slm.duckdns.org>
 <Y0ljzN920sWalEHR@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0ljzN920sWalEHR@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Oct 14, 2022 at 10:27:40AM -0300, Arnaldo Carvalho de Melo wrote:
> Hey, I noticed that the perf build is broken for the
> tools/perf/util/bpf_skel/bperf_cgroup.bpf.c skell, so I tried using b4
> on this Namhyung patch, it ended up getting a newer version, by Tejun,
> that mixes up kernel code and tooling, which, when I tried to apply
> upstream didn't work.
> 
> Please try not to mix up kernel and tools/ changes in the same patch to
> avoid these issues.

I didn't write a newer version of this patch. What are you talking about?

-- 
tejun
