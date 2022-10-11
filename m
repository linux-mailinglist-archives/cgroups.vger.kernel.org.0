Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65475FB88A
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 18:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiJKQva (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Oct 2022 12:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiJKQv2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Oct 2022 12:51:28 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F69E42E6B;
        Tue, 11 Oct 2022 09:51:27 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id fw14so12986927pjb.3;
        Tue, 11 Oct 2022 09:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADBsxLunge1AhqEpSVfGO0kFOloOABIAiXPDugpYJZk=;
        b=XEG0+rifCJBs/VBmh3mu4URmwTT/ffH/L1xVT0nYnfMdL2BvMHjdfRoyoRBRnB7RZ4
         5BnpGQywEA/92cRoaZCZncGb9B0QnB/wtC85n5uLMYxEC2+B9ny+fQ+JvyO5w2UxNfCH
         yITSzjKTNhmdMRklBn3mf5s0m4hr1EL3TNjovWH297zbwGFOtErDgOjzLqcvo7XqrWVR
         1mO90RNcL8plTUjxhbMb4SdUv9U9lJtg/TjZ7eNkJa273jilFF44fYe48Pjeo5VzTGyc
         EZjN7POAOMZAZ5DLeCfJJOR/UzUhHIqwSLGknhAXyfBZJngu4vROfvegVQdXt5YpVyEJ
         tW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADBsxLunge1AhqEpSVfGO0kFOloOABIAiXPDugpYJZk=;
        b=IckhE8arIfxb/rsxzErOp/d/yT+aYSokU0T+6ZQfyAx9j6WOJWPgi+YoRGpa9/SHhV
         Kl5hXBjcQBg1BjaEEaZmxUhHVfhhKvM6QjtnwE5AQ9Sh4hy9LJvgN0ku4S6KT+r8wPY1
         srAKBSWzxrV7KTAsYFeZPhQQkeJB3KjEJiLfw/iUiHDLurkjqlPuy9MO5zXVAjwyUGWL
         S2OZDIamsXI+ukOcMUZ060V4ONIzpQuL7LFMM616iRF9ioNk8gJOiqKAgZK03ZIGKU2w
         Mi8rdF4t8KnG24e/kKkkD5SXdgvCAHosD3PLuxNdwivZHtiO5vLy3i/kT8RWDnNKdXca
         +lAw==
X-Gm-Message-State: ACrzQf1WcEzNotTUG/lQw0zvC1Kf7pkiVoSo8/uIRdU7KulmkSW2qSdO
        LukeZr7WVIqvT2BJcV32vww=
X-Google-Smtp-Source: AMsMyM6W8eb/DSuoEh6zU2DVMjdqlJELxsWR2bijzEn10WkihTKRUct+5nu9+A4xGvYgzeX9gphkkg==
X-Received: by 2002:a17:902:724b:b0:183:16f:fae4 with SMTP id c11-20020a170902724b00b00183016ffae4mr8300979pll.88.1665507087030;
        Tue, 11 Oct 2022 09:51:27 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id w12-20020a170902e88c00b00176b3d7db49sm8978933plg.0.2022.10.11.09.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 09:51:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 11 Oct 2022 06:51:25 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Support cgroup1 in get from fd/file interfaces
Message-ID: <Y0WfDQ95i9lFJKUz@slm.duckdns.org>
References: <20221011003359.3475263-1-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011003359.3475263-1-yosryahmed@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 11, 2022 at 12:33:57AM +0000, Yosry Ahmed wrote:
> commit f3a2aebdd6fb ("cgroup: enable cgroup_get_from_file() on cgroup1")
> enabled using cgroup_get_from_file() and cgroup_get_from_fd() on
> cgroup1, to enable bpf cgroup_iter to attach to cgroup1.
> 
> Apparently, other callers depended on these functions only supporting
> cgroup2, so f3a2aebdd6 was reverted. Instead, add new separate interfaces
> that support both cgroup1 and cgroup2 and use them in bpf cgroup_iter.

Applied to cgroup/for-6.1-fixes.

Thanks.

-- 
tejun
