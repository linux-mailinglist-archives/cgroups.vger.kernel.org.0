Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D383F2B79
	for <lists+cgroups@lfdr.de>; Fri, 20 Aug 2021 13:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbhHTLm7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Aug 2021 07:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239508AbhHTLm6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Aug 2021 07:42:58 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C56C061575
        for <cgroups@vger.kernel.org>; Fri, 20 Aug 2021 04:42:20 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id n6so16774409ljp.9
        for <cgroups@vger.kernel.org>; Fri, 20 Aug 2021 04:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BwSYnZ0fXeyF3ucmVYtCymM5MkqPY89pcO9lgHDkScc=;
        b=RQV3qkbRPB4wYn5rj55IDWMO5Wywf4L6wyjACr5IMbV/zKC36Ab6BeVA76WHo2bs4j
         nyrb7DMkVIXnh0n7r4Pk+OInxYOfLVae9K0ZAQMO+QgJXveyqceQ8lzHCCXFR/9ArfE4
         ZBWCImoPry5Ydl+fvYVRdPdNvVPDC6LXtVpU4uIGo0VjrDaZsYylBJLnI5aSZO3IWar0
         N+IXPS8HSukU8TtqsNWym+9YmCdj9Ed6Luk46mBRNxBJWMaInC8usKVRyomOt5I8HpnZ
         kdez1wm7WCrnD4B9891D85TmVqzs6WU7Ex+eeEozWvPTowdFcxszIdbxiplestG2EdjQ
         zDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BwSYnZ0fXeyF3ucmVYtCymM5MkqPY89pcO9lgHDkScc=;
        b=XdgD4di5FRyGFbI5wU3nzweD1/L42f26i44ZhVmSUrCrzzh9xQUmYkXH0Uqr0KYALO
         oHZ7eM11YnrsnkNHKRQitqjZjc0VFgjcWZZf9XRfXA7s7IFMv455On/n6lYsW+nSA9F0
         oO+H9TWjf5T2uuDaajwNmbJwSs9pCv3c8zpcCzd0vkdDSYCzI0uYwTX/IY6g8gT+Dfkl
         STJ7VDx7uTG1/1wxs9BPYOdDSbEjlynvy/BAGtPUsGyK3ovoUg4rUPNye3F9nqbIMKQa
         5kFnXel88afVhBdDZo13hz/sr8ASDy3AwXrxeqw+uv9GrE+eV4Wr0RiEsvmC3GrPKqzl
         BViw==
X-Gm-Message-State: AOAM530HsO93F+LBX9jfl0+FlphUr8sQSSGncv4I4eTIBED7oFZZREUo
        bLPyJ5P1UD0+NDQHMWm3/yuTQ2OODgTPowktDI+QDtso/K8cow==
X-Google-Smtp-Source: ABdhPJzdXSMf7HClGrUsh7vy9ZlHbcJeSNEIBy+APf+XJPeJIP1M8RavCEv4mkMq21DlHjqlbmlf4vOcBxrETaa+aTY=
X-Received: by 2002:a05:651c:1248:: with SMTP id h8mr13374370ljh.160.1629459738919;
 Fri, 20 Aug 2021 04:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <1629417219-74853-1-git-send-email-wang.yong12@zte.com.cn>
In-Reply-To: <1629417219-74853-1-git-send-email-wang.yong12@zte.com.cn>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 20 Aug 2021 04:42:07 -0700
Message-ID: <CALvZod5usW9OEsJSbeGYBnSGVDNLLKqMoGAx-JQrX6s62r-XiA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Add configuration to control whether vmpressure
 notifier is enabled
To:     yongw.pur@gmail.com
Cc:     Tejun Heo <tj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Roman Gushchin <guro@fb.com>, alexs@kernel.org,
        Wei Yang <richard.weiyang@gmail.com>, Hui Su <sh_def@163.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        wang.yong12@zte.com.cn, Cgroups <cgroups@vger.kernel.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, yang.yang29@zte.com.cn,
        wangyong <wang.yong@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 19, 2021 at 4:54 PM <yongw.pur@gmail.com> wrote:
>
> From: wangyong <wang.yong@zte.com.cn>
>
> Inspired by PSI features, vmpressure inotifier function should
> also be configured to decide whether it is used, because it is an
> independent feature which notifies the user of memory pressure.
>

It is also used by the networking stack to check memory pressure. See
mem_cgroup_under_socket_pressure().
