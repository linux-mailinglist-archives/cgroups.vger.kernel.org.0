Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675A55F1C8B
	for <lists+cgroups@lfdr.de>; Sat,  1 Oct 2022 15:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiJAN6A (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 1 Oct 2022 09:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiJAN57 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 1 Oct 2022 09:57:59 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8E54E622;
        Sat,  1 Oct 2022 06:57:58 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id u21so5078458edi.9;
        Sat, 01 Oct 2022 06:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=S6dQsVfxGBhLNZzfxTxMcZmUo50zQik/XnIunjEq2WM=;
        b=pFReg0bTnNJkev/4BKPuiVH6oyC8lSX9zxw9HhBaHcGwAC8ucCHnRGecOvrhrS0M1Q
         2CjU+x9UhxVWJqGk8bY4wYE8rB80j9QW9gQ1lSXT+nLwxggdZprZUmrP78grsh79jL8Q
         5GwhwQ3MqfHd+eIdp47w7DXwqtCp6GBB3Qf1ox5ungEAkszk0nSwqE9apK26gw8eQhSV
         aj5DZD7SgSQ9o0YI2iuwzWZy+mra7/BbMZGOtm6TAFqFnDV9s7KwOrrUJa7a/N+sU0NU
         VcN4idox4DaIe+AvlpUsjM/pTRRtkeuOS8fMd0TU/lBK3EgylhermRQKD9JHX8pKHkSd
         al3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=S6dQsVfxGBhLNZzfxTxMcZmUo50zQik/XnIunjEq2WM=;
        b=45wVfU/q4i3ZkGBPbudrX6+r7fOTlF6qgcmuWjHiLbJWhs3V1hHtKhK/djTyyS0rdJ
         N9lqt5nsSGvf1jyFnDTgdfwO+JGpR36QJN1eXDspesFIZNcW/f0Iv7DU+qHLMMWIJiOW
         9y805Yv1lPkY0e5rcvLP75tGBx3H56+jZVd8Vl7IFy/TSUGq3vDdgBUXAMtlGeUFdYIK
         ByXcQkOZJ4XE/hfCRu9v8nAqZFBTEcsG8kOiyTRXC12oELv0PTTplLPphtyP4+KxdTHl
         E6w9bUujaR43eHYwVu1u5AXvNVgHVcQxQfbA0A7Txe1ALP6FmSn5orZw+uLc28/nYcos
         dMDg==
X-Gm-Message-State: ACrzQf2asb8DYVRI7E3zFp+0DYF+yuwQVefAd7MImXaZKIfmjq0TZ7zE
        MPkxIfWZVSy67Dv0RfXFL2g=
X-Google-Smtp-Source: AMsMyM6n+WG7e9RMrROUbGz42p38sHMbr+8DCnLDQ8FCe76dzpWNPEHygW5JdKRyczkAqgrXz1j+qA==
X-Received: by 2002:a05:6402:5cd:b0:446:5965:f4af with SMTP id n13-20020a05640205cd00b004465965f4afmr11532730edx.12.1664632676443;
        Sat, 01 Oct 2022 06:57:56 -0700 (PDT)
Received: from krava ([83.240.62.159])
        by smtp.gmail.com with ESMTPSA id d2-20020a50fb02000000b004580296bb0bsm3578164edq.83.2022.10.01.06.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 06:57:55 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sat, 1 Oct 2022 15:57:54 +0200
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        cgroups <cgroups@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] perf stat: Support old kernels for bperf cgroup counting
Message-ID: <YzhHYiTZf45dEWn0@krava>
References: <CAM9d7cjQ20a01YoZi=o-_7HT6TzR0TZgtpscKNvRrMq2yqV1Og@mail.gmail.com>
 <20220922041435.709119-1-namhyung@kernel.org>
 <YzdjHenrJpooKMjv@krava>
 <CAM9d7cjKaZvWQUwGwoTLNzAgHS7ndL_V_5+O+WqMUvuHJ7cWNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjKaZvWQUwGwoTLNzAgHS7ndL_V_5+O+WqMUvuHJ7cWNg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 30, 2022 at 02:56:40PM -0700, Namhyung Kim wrote:
> Hi Jiri,
> 
> On Fri, Sep 30, 2022 at 2:44 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Wed, Sep 21, 2022 at 09:14:35PM -0700, Namhyung Kim wrote:
> > > The recent change in the cgroup will break the backward compatiblity in
> > > the BPF program.  It should support both old and new kernels using BPF
> > > CO-RE technique.
> > >
> > > Like the task_struct->__state handling in the offcpu analysis, we can
> > > check the field name in the cgroup struct.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > > Arnaldo, I think this should go through the cgroup tree since it depends
> > > on the earlier change there.  I don't think it'd conflict with other
> > > perf changes but please let me know if you see any trouble, thanks!
> >
> > could you please paste the cgroup tree link?
> 
> Do you mean this?
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git

yea, wanted to try that.. I cherry-picked the 7f203bc89eb6 ;-)

thanks,
jirka

> 
> Thanks,.
> Namhyung
