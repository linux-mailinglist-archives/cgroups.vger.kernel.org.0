Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15A4D6AD73
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2019 19:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfGPRLA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Jul 2019 13:11:00 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35259 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbfGPRLA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Jul 2019 13:11:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so10440986plp.2
        for <cgroups@vger.kernel.org>; Tue, 16 Jul 2019 10:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kwpOpWT2eWiCeBhDjuSXvGXNhdNaH2c1UD5BkyTJoqs=;
        b=knBTmABIgOoXo69WB++c8IiWB76RVPwIFTQLPCH60rHTf+UJ7FGF+ss1UJhIMPAq8x
         0EwUItQ8ZgDKhh+54f7rBkRV7MSkUDhNen+cxQRpDwq4odvt0AmVDnfhd5gDsDsim6Oc
         /NPzqJO1Ut/8JkDliDODiF4nieSIiOvRtiA2DDTkydoPrCpwaekiYCu4HxFCBNUMOdrv
         Kh+4kgtRPjClbTdLMdYDm8rTNtWJmYgbqv8d+6z8dyl0uMeRa9N2RZCdxwR9l/flo6FS
         TgIxRET8UFzLd1mskmgymFDDldbBvFBtSzi+kDwEtAaFdE8OH18mOJU1usfuTg9ZgWuu
         4sBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kwpOpWT2eWiCeBhDjuSXvGXNhdNaH2c1UD5BkyTJoqs=;
        b=ujqhw3tiBnX39tSrZgYMK1RZck7/2qUqKH/pWyw97bXhB+xhEULbAB61lmvYFlFCks
         mMJ6refyeGE6R1GZ+CWlJvzhvB5aLCivqfM4P80fYLEgEdq7AzpzvuWHfdj4fhmfc8ER
         OMEQCMlViwSPPXEYPin+S4P/TF23VU2o7JdXPyo8m6aUDmrjzltrYL2s4+1oK5jhkICF
         nBweXrZf+qMVHNyfqsjOpcVXNLdys/rzASzaMBCshy2U4e7F4wjYxsave013d1sTgh/C
         jIGfBUS+9UafYIsoFkgW/uLKfDkWmiu1nzvQILRSc8aCQdHZMbseQ3U6jQa4cl3NIjEG
         WY+A==
X-Gm-Message-State: APjAAAVibWOSSNKbNeTkUS5x2StUY/7FlDyg/j9V8fKbFM6ldkZoR98B
        NFzLqQfsCymRDOFZeuaFgXA=
X-Google-Smtp-Source: APXvYqzOUwUunYYbiDg94VvgRJzmfWkkNNf3nkG+b6uwrilA1j4IQ0R4BL7eXG7mU0JZW5y6MGQ9bg==
X-Received: by 2002:a17:902:381:: with SMTP id d1mr36353848pld.331.1563297059292;
        Tue, 16 Jul 2019 10:10:59 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::1:dd93])
        by smtp.gmail.com with ESMTPSA id j13sm20092099pfh.13.2019.07.16.10.10.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 10:10:58 -0700 (PDT)
Date:   Tue, 16 Jul 2019 13:10:56 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH REBASED] mm, memcg: Make scan aggression always exclude
 protection
Message-ID: <20190716171056.GA16575@cmpxchg.org>
References: <20190228213050.GA28211@chrisdown.name>
 <20190322160307.GA3316@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322160307.GA3316@chrisdown.name>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Mar 22, 2019 at 04:03:07PM +0000, Chris Down wrote:
> This patch is an incremental improvement on the existing
> memory.{low,min} relative reclaim work to base its scan pressure
> calculations on how much protection is available compared to the current
> usage, rather than how much the current usage is over some protection
> threshold.
> 
> Previously the way that memory.low protection works is that if you are
> 50% over a certain baseline, you get 50% of your normal scan pressure.
> This is certainly better than the previous cliff-edge behaviour, but it
> can be improved even further by always considering memory under the
> currently enforced protection threshold to be out of bounds. This means
> that we can set relatively low memory.low thresholds for variable or
> bursty workloads while still getting a reasonable level of protection,
> whereas with the previous version we may still trivially hit the 100%
> clamp. The previous 100% clamp is also somewhat arbitrary, whereas this
> one is more concretely based on the currently enforced protection
> threshold, which is likely easier to reason about.
> 
> There is also a subtle issue with the way that proportional reclaim
> worked previously -- it promotes having no memory.low, since it makes
> pressure higher during low reclaim. This happens because we base our
> scan pressure modulation on how far memory.current is between memory.min
> and memory.low, but if memory.low is unset, we only use the overage
> method. In most cromulent configurations, this then means that we end up
> with *more* pressure than with no memory.low at all when we're in low
> reclaim, which is not really very usable or expected.
> 
> With this patch, memory.low and memory.min affect reclaim pressure in a
> more understandable and composable way. For example, from a user
> standpoint, "protected" memory now remains untouchable from a reclaim
> aggression standpoint, and users can also have more confidence that
> bursty workloads will still receive some amount of guaranteed
> protection.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Reviewed-by: Roman Gushchin <guro@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: kernel-team@fb.com

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
