Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858D321343C
	for <lists+cgroups@lfdr.de>; Fri,  3 Jul 2020 08:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgGCGfw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jul 2020 02:35:52 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:39578 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgGCGfw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Jul 2020 02:35:52 -0400
Received: by mail-ej1-f47.google.com with SMTP id w6so33016532ejq.6;
        Thu, 02 Jul 2020 23:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NojDtPHgyU04BZgerYd3+yccFVPzYnZ7F9ygI7w4DNc=;
        b=VtRda+Ecd2HlpxEH1hLDOocC4PXPYGM0mm9nskZDOVQ8+TJ20ky9Z68YXdPeZwtvqX
         b4sQO1NCOPaMUqrXGL+Xk//ZEupQsBXOy7SmFYhQ/XsghIvTsz9c4E8hI0WpS1AfawbT
         gYKqJwgb5OiVchrOm1YljNi9ThiF+WX7v3+lEbjuMvcsr6OGATr6ElFRGMwXw/uNOiT0
         YeCF+1gYXok1pwtz3T+SzsmsevqQWQz+jSvqQlW8VkF09EZDOm0k7q3Qekjjtv68vR1X
         nZKKP8XEfRkNlcUwS0flOhPEcqoW9cavpOBlv51yTeZmuvIlANeJd97RnBhmGkuB8Wh1
         GMmg==
X-Gm-Message-State: AOAM533h11ikhUboI0iUz4OWKWmQ7jKzNkyrypgwedQ6XUWDBR2pxouy
        ajY2VcozHvKEVaCc+SSokBw=
X-Google-Smtp-Source: ABdhPJwihp/EUddRgogAcW9jNPLdXKXMVfUNhqWuG6Q0n58p0Pz12bOw5FOZ3ev6WXaFzNeayEZexQ==
X-Received: by 2002:a17:906:71d4:: with SMTP id i20mr32649859ejk.533.1593758150250;
        Thu, 02 Jul 2020 23:35:50 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id b11sm11620695edw.76.2020.07.02.23.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 23:35:49 -0700 (PDT)
Date:   Fri, 3 Jul 2020 08:35:48 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PROPOSAL] memcg: per-memcg user space reclaim interface
Message-ID: <20200703063548.GM18446@dhcp22.suse.cz>
References: <20200702152222.2630760-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702152222.2630760-1-shakeelb@google.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 02-07-20 08:22:22, Shakeel Butt wrote:
[...]
> Interface options:
> ------------------
> 
> 1) memcg interface e.g. 'echo 10M > memory.reclaim'
> 
> + simple
> + can be extended to target specific type of memory (anon, file, kmem).
> - most probably restricted to cgroup v2.
> 
> 2) fadvise(PAGEOUT) on cgroup_dir_fd
> 
> + more general and applicable to other FSes (actually we are using
> something similar for tmpfs).
> + can be extended in future to just age the LRUs instead of reclaim or
> some new use cases.

Could you explain why memory.high as an interface to trigger pro-active
memory reclaim is not sufficient. Also memory.low limit to protect
latency sensitve workloads?
-- 
Michal Hocko
SUSE Labs
