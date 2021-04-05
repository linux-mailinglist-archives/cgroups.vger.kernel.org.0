Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E28353A35
	for <lists+cgroups@lfdr.de>; Mon,  5 Apr 2021 02:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhDEA2M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 4 Apr 2021 20:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbhDEA2K (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 4 Apr 2021 20:28:10 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EA8C061756
        for <cgroups@vger.kernel.org>; Sun,  4 Apr 2021 17:28:01 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i26so15168947lfl.1
        for <cgroups@vger.kernel.org>; Sun, 04 Apr 2021 17:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZF918p7w2NV7GDL6H66e14qUO918kYzYBoimRTX60mw=;
        b=B6aS04PjlBqAA2vflWypWTUhJI210MxW1PaPH1BDPRndkBlXgPSIvRcj4swDoEnRfe
         w+7CBj5c2TykbIXuD7EO51fppLYfu97EaJvdj6CK2LyrV94bYp6YD0UblBLsQE6p3Ujd
         thmdDtdqEunD6gglL47FCsEe5cOjfs+Bi8SlOdoduJt1/Te3Fq27sXeaEAC37xBME2kN
         hpoYyPFllmrsv+xns6mHWoOkGLtQ8bm0KAcUnAm22pOvICyBCh2QCsc9B4VOTIcU+9kC
         Z623CHribd6n+QENTCr/qvwQtpOpWibsePCCtqIrQeH2YhZsNC1Ly3WWV1yzOJPZb2KD
         SGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZF918p7w2NV7GDL6H66e14qUO918kYzYBoimRTX60mw=;
        b=ulSaRBuePrtP97DJkEneCvgHZk5NNwAMDg009PXxn6R9CoEI8ixwyAtFsT+dwnY/Rx
         Y+4X3T7vRg938Ata3CbVJoomOw4h/uxUTIGpSPFsO6lgHe71EFvL9lMIVKX52w9DUT1h
         1Z7r/2jIRqh3qLN7/a4lCJMNfohYpH3fLuz0v50s0zv/lCjIw3rWY+IoL13L8Y9gEZsq
         11187HLUaJyb28ZfUzNuEhnV800ZkA+lLuL5lVj+c8NrXyaand71L6SiXVOa8jSnEInC
         G1d0Nhv7X+2XiRf9sZfeHFnSPJ/o32NsrfXojBZGZo473rrCKwMynFHj8xy5vBgoYQ8b
         hN4w==
X-Gm-Message-State: AOAM531ptY/IB2n/VmChuqxkCbzWXsNMF/kAKNMZAmZLuaTc5X8RcDfa
        G3JvS7HpXjCo76ydjqJneklJUBfhlZwomZhoY15P2Q==
X-Google-Smtp-Source: ABdhPJzwVqup78Vy3hiX8TNtCPQ4y/cXp3hJaHr5DVyeVHS3puE9TBG0zmDMrTWH61c4gOmZlVUFaiPQyYQj3lG0o9c=
X-Received: by 2002:a19:e210:: with SMTP id z16mr14970547lfg.576.1617582478196;
 Sun, 04 Apr 2021 17:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <202104050523.t4Om6TmY-lkp@intel.com> <YGo+f3XoA4CtRAPt@mtj.duckdns.org>
In-Reply-To: <YGo+f3XoA4CtRAPt@mtj.duckdns.org>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Sun, 4 Apr 2021 17:27:41 -0700
Message-ID: <CAHVum0d1A7pbVEOy8U6iCXCtf8YOfAEkAXwhhyFgkxXHFPGjFQ@mail.gmail.com>
Subject: Re: [cgroup:for-next 3/3] include/linux/misc_cgroup.h:98:15: warning:
 no previous prototype for function 'misc_cg_res_total_usage'
To:     Tejun Heo <tj@kernel.org>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        cgroups@vger.kernel.org, David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Apr 4, 2021 at 3:32 PM Tejun Heo <tj@kernel.org> wrote:
>
> Applied the following patch to cgroup/for-5.13.
>
> Thanks.
> ----- 8< -----
> From dd3f4e4972f146a685930ccfed95e4e1d13d952a Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Sun, 4 Apr 2021 18:29:37 -0400
> Subject: [PATCH] cgroup: misc: mark dummy misc_cg_res_total_usage() static
>  inline
>
> The dummy implementation was missing static inline triggering the following
> compile warning on llvm.
>
>    In file included from arch/x86/kvm/svm/sev.c:17:
> >> include/linux/misc_cgroup.h:98:15: warning: no previous prototype for function 'misc_cg_res_total_usage' [-Wmissing-prototypes]
>    unsigned long misc_cg_res_total_usage(enum misc_res_type type)
>                  ^
>    include/linux/misc_cgroup.h:98:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    unsigned long misc_cg_res_total_usage(enum misc_res_type type)
>    ^
>    static
>    1 warning generated.
>
> Add it.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  include/linux/misc_cgroup.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
> index c5af592481c0..da2367e2ac1e 100644
> --- a/include/linux/misc_cgroup.h
> +++ b/include/linux/misc_cgroup.h
> @@ -95,7 +95,7 @@ static inline void put_misc_cg(struct misc_cg *cg)
>
>  #else /* !CONFIG_CGROUP_MISC */
>
> -unsigned long misc_cg_res_total_usage(enum misc_res_type type)
> +static inline unsigned long misc_cg_res_total_usage(enum misc_res_type type)
>  {
>         return 0;
>  }
> --
> 2.31.1
>

Thanks for the quick patch Tejun. Sorry about the issue.
