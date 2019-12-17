Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5628122EE7
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2019 15:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfLQOhX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Dec 2019 09:37:23 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39844 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbfLQOhX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Dec 2019 09:37:23 -0500
Received: by mail-wm1-f68.google.com with SMTP id b72so3429825wme.4
        for <cgroups@vger.kernel.org>; Tue, 17 Dec 2019 06:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UOW3PJT7DR1Clt88oSFTkiVAEW1rUNAQCHLVMZndGtA=;
        b=rd71+yX/Y3zYrvfVV0ocR9HmI+QhbtozLkZX8U/xhZ3MvWkP8M45IIwe5JLcvFqmx4
         eU1/11ACeoRAG78LOllpOsqgjuF8jIsHETbh7DAYF19cesIvYRXneiL9fkYUdL1NIFkE
         aAi8jir3zKgxfr1bqJHDJx8czIhCWivZvyMl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UOW3PJT7DR1Clt88oSFTkiVAEW1rUNAQCHLVMZndGtA=;
        b=Re6ohSagoveoTtUIOBkVTIBlbeNENwe6kDJK1oKydibYEy8ygPD4shCfos1hNuzW5E
         7WEF9For7npnP3SPEbzMMgaz8OzTm2AkHvUL5wa4Z3zUbzJR+IfV9EDzQFWdoNp4ciYz
         Bet0CPjZDklb2yaNLTXg5oCY8MZDvQAEsdsbIR70wyoLlSXeEoDyLj4Np+N0oYayNQ/k
         r3dMui6ozdsBCv7EIQdrtZ66whb9UEEzi4Fxo1zsj5zyEvp+Hcvn1zbdhUjEelgYfudH
         t7bBW/craflc3IWy660m5HRYvK9sTW7Yu5LhhIKD9CofnA53N6Ou/EPV2Y+7V8+nBCo9
         qczA==
X-Gm-Message-State: APjAAAUucbsLwSU4QLxnNV0g/1ww5bTjv/Gq3lT4bsCfe15u3T/K8JY3
        /+ppDDlEph/8jviSczq0JgVFKQ==
X-Google-Smtp-Source: APXvYqyrlajOW9NAfjUpvQY9iSAefHRgSoJbSWwdLvTxpNtWYbJlX2DkjylLu/3+HwkvkiYdqvGcRQ==
X-Received: by 2002:a1c:a9c2:: with SMTP id s185mr5901592wme.119.1576593441693;
        Tue, 17 Dec 2019 06:37:21 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:f184])
        by smtp.gmail.com with ESMTPSA id e18sm24183043wrw.70.2019.12.17.06.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 06:37:21 -0800 (PST)
Date:   Tue, 17 Dec 2019 14:37:20 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Qian Cai <cai@lca.pw>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol.c: move mem_cgroup_id_get_many under
 CONFIG_MMU
Message-ID: <20191217143720.GB131030@chrisdown.name>
References: <20191217135440.GB58496@chrisdown.name>
 <392D7C59-5538-4A9B-8974-DB0B64880C2C@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <392D7C59-5538-4A9B-8974-DB0B64880C2C@lca.pw>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Qian Cai writes:
>__maybe_unused should only be used in the last resort as it mark the compiler 
>to catch the real issues in the future. In this case, it might be better just 
>ignore it as only non-realistic compiling test would use !CONFIG_MMU in this 
>case.

While that's true, I'd rather not end up with getting more patches based on 
tests like these. On balance the risk of adding __maybe_unused here with a note 
to remove it later seems better than having to reply to every patch removing 
warnings :-)

I struggle to imagine a real issue this would catch that wouldn't already be 
caught by other means. If it's just the risks of dead code, that seems equally 
risky as taking time away from reviewers.

We should probably also review the coding style doc again, since this looks 
suspect:

>If you have a function or variable which may potentially go unused in a
>particular configuration, and the compiler would warn about its definition
>going unused, mark the definition as __maybe_unused rather than wrapping it in
>a preprocessor conditional.  (However, if a function or variable *always* goes
>unused, delete it.)
