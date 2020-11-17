Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A2A2B5740
	for <lists+cgroups@lfdr.de>; Tue, 17 Nov 2020 03:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgKQCzz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Nov 2020 21:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbgKQCzy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Nov 2020 21:55:54 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E18AC0613CF;
        Mon, 16 Nov 2020 18:55:54 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id 199so19175341qkg.9;
        Mon, 16 Nov 2020 18:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rph6elS4sVb6X0aZV8oBI4KEro3xkFbil1su2bbIStE=;
        b=USQyK3bB+z/rsRt1AELXV8ctRWtIiY5icuzdfAECiIyyhTqCjd/cubqHwqXKSUrpNW
         jS0x+7FDLMQEfX5d7LQRDJHMhIRUHZF7ZyjiIzz9U1hm4GfyOWrcoaA437AVuzPTV8jD
         gPnd6rltXsXDr1sppsRO9SurjxkcvrJY9DaPtvKkm38dDeNTSA+354EJG7j5ZVdclpAn
         oz/RVsDsjTwbuaICvAL+c02bw1WRI2G1FJ+tljpDFR8an2UnbZAvBcHpkmo4aS1mSE9w
         nBDJ91GZEg6FqhfGkMA0vfYxJtfEqU73B3egT2cKvmkDKOWEzPGV2v85V43YHu74tHYP
         09tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rph6elS4sVb6X0aZV8oBI4KEro3xkFbil1su2bbIStE=;
        b=e1cXfGi0EelZDDCIZL3DCkzrUoE4K0pNQc8qI0XMbNhq2iE3/4DwFCqcvo5Y5x8c7s
         CpWsPgq3IRxEmJnSxtd1EbSWqpVHVts6JC7itRuytO7pA4BjcJXzSbx4Yddl0rP30MTl
         U+l4/Y/8/NoGWagaH6U16x98mTaJe+7mMgxXzYJdS2nANC9oKNWkinZZ+cuK06BOgYap
         Cj17jowHXa8okNS/uZzC1ZHfZBdcPNgaMSxhZq35ot4juhG0wDusRmO2u0jRU8RdrpKK
         il487YLgOnIarnYyAHI/54LIB9+VlAveW9fSL1IX6pmp9IzzUJX2e/r64NUAlsAGbesJ
         R46w==
X-Gm-Message-State: AOAM532qIy0un2715zRgb5+t8nshbfzyjuwkpslq3YdJIOKS6o2VoDMg
        laHbFN3l5oykH5uuArasIFE=
X-Google-Smtp-Source: ABdhPJwMRPqQ+amOILxvnHFquv3aE3v+OBpkNV+6SrgJ/aizT1KI3eZnAQXhApmCEhRAYQUTMxaztQ==
X-Received: by 2002:a37:8305:: with SMTP id f5mr17316880qkd.209.1605581753676;
        Mon, 16 Nov 2020 18:55:53 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id r14sm13431270qtu.25.2020.11.16.18.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 18:55:53 -0800 (PST)
Date:   Mon, 16 Nov 2020 19:55:51 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Tom Rix <trix@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: remove obsolete memcg_has_children()
Message-ID: <20201117025551.GA1103291@ubuntu-m3-large-x86>
References: <20201116055043.20886-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116055043.20886-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Nov 16, 2020 at 06:50:43AM +0100, Lukas Bulwahn wrote:
> Commit 2ef1bf118c40 ("mm: memcg: deprecate the non-hierarchical mode")
> removed the only use of memcg_has_children() in
> mem_cgroup_hierarchy_write() as part of the feature deprecation.
> 
> Hence, since then, make CC=clang W=1 warns:
> 
>   mm/memcontrol.c:3421:20:
>     warning: unused function 'memcg_has_children' [-Wunused-function]
> 
> Simply remove this obsolete unused function.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
