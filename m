Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2DB520E2F
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2019 19:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfEPRp1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 May 2019 13:45:27 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41238 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfEPRp1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 May 2019 13:45:27 -0400
Received: by mail-qt1-f194.google.com with SMTP id y22so4904850qtn.8;
        Thu, 16 May 2019 10:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TZW9oPjKjF7UuQfNRNZlJhWogoRZGc1JB7uoqoIfv+8=;
        b=U+/Dsbpe3Ev8qOz5ABegg4QwYrxhkHAqm6TrtgUJZMxYDxJyKNRkrRR2BomF+w8bGA
         JeXPRak510vhmmzJ8bRXqpXFQtGibDSo/kyK2zYtiw+D7B7H/6Gb/lGYxPaHanLuyx5i
         gUYWYVTnZ5fNLpvZmPoI1/hpBdL/MlRiTGoXmomSU60h70cP2MeSUERNp3AMtK+BAXOR
         753TXbfYLlPuastYz2vzgY435v4UWD/63ouWJF2lzPjL0KwD1TPbqNzSVAQQTSmrFxD3
         BiH4q8vfb1Vc8YX3FlMIFhHYqPuYMeE0fF9Zpl545yER8ygpzwARFTZi9cGlYGk6xKUt
         f7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TZW9oPjKjF7UuQfNRNZlJhWogoRZGc1JB7uoqoIfv+8=;
        b=rALhC8waL0mjiX2VLLZKV3UrmLDWRWQmqRXe6mxhcEVixh6aRsAoqaHuaUl381LHYi
         1hMLat+r/yvLsRhbH5g4D2DX2mqV28TERoJUSbgN5RG1Gk7ZhY22mDeVVPA7FkaZNlIw
         gFU9vSMoQD+Lu68clyxRDzIa8qdp2uFVqxflgfkJkwRZxT8foAX+fCdyP/sLHfcO0wvX
         SbycO0VwzWyvFw8yX0bi7NABzVj8jIWO7IHNg3JpzsIw4Xr55/A5I91vGR9lqvpHCOO2
         rqX96gSP7a4eYDfMl3Yd724ByPRRok3kNYUJcGIy/zdmPvXWrqC63QJTt7K4ZSdeBieG
         7T+Q==
X-Gm-Message-State: APjAAAWT0rh1A0VCPJGtUSxaRscucZqsDfCYlfeY/XZytfilYg/0iSO5
        BgVB2AderhTof76oBUAccU42NqioRHg=
X-Google-Smtp-Source: APXvYqyUkVz3sqfNMifhOeY7ZDSeqgmGmjvjqqsICWFuayNjL9C3yjroqXXDBYnZFz5G9EOCbhBW9Q==
X-Received: by 2002:a05:6214:41:: with SMTP id c1mr33503890qvr.138.1558028725812;
        Thu, 16 May 2019 10:45:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:e390])
        by smtp.gmail.com with ESMTPSA id e37sm4124575qte.23.2019.05.16.10.45.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 10:45:24 -0700 (PDT)
Date:   Thu, 16 May 2019 10:45:23 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Alex Xu <alex_y_xu@yahoo.ca>,
        kernel-team@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] signal: unconditionally leave the frozen state in
 ptrace_stop()
Message-ID: <20190516174523.GD374014@devbig004.ftw2.facebook.com>
References: <20190516173821.1498807-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516173821.1498807-1-guro@fb.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 16, 2019 at 10:38:21AM -0700, Roman Gushchin wrote:
> Alex Xu reported a regression in strace, caused by the introduction of
> the cgroup v2 freezer. The regression can be reproduced by stracing
> the following simple program:
> 
>   #include <unistd.h>
> 
>   int main() {
>       write(1, "a", 1);
>       return 0;
>   }
> 
> An attempt to run strace ./a.out leads to the infinite loop:
>   [ pre-main omitted ]
>   write(1, "a", 1)                        = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
>   write(1, "a", 1)                        = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
>   write(1, "a", 1)                        = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
>   write(1, "a", 1)                        = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
>   write(1, "a", 1)                        = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
>   write(1, "a", 1)                        = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
>   [ repeats forever ]
> 
> The problem occurs because the traced task leaves ptrace_stop()
> (and the signal handling loop) with the frozen bit set. So let's
> call cgroup_leave_frozen(true) unconditionally after sleeping
> in ptrace_stop().
> 
> With this patch applied, strace works as expected:
>   [ pre-main omitted ]
>   write(1, "a", 1)                        = 1
>   exit_group(0)                           = ?
>   +++ exited with 0 +++
> 
> Reported-by: Alex Xu <alex_y_xu@yahoo.ca>
> Fixes: 76f969e8948d ("cgroup: cgroup v2 freezer")
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Cc: Tejun Heo <tj@kernel.org>

Applied to cgroup/for-5.2-fixes.

Thanks.

-- 
tejun
