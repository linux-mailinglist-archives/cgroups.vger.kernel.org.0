Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E02BEE4C8F
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2019 15:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfJYNor (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Oct 2019 09:44:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36064 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfJYNoq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Oct 2019 09:44:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id v19so1623940pfm.3
        for <cgroups@vger.kernel.org>; Fri, 25 Oct 2019 06:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GB66w5zMnO6g29s6wAcFRJIvcQvj59wk11SwJfYrvKA=;
        b=Qq1IRmOU8QQXXK5dP7qVkmSaMc2yq7Rpi0+jYuWk5ryK9uF4E/5Q5RAo6IRi5rQpYO
         MijLDpKbtbCl53iC6+V6cSZa6ckR+CG9NvnGZp30+L7k1AHj4QImzgeXM8RnK6zDGsxq
         bVKbAvbgwnymLXAiH9nIW3DslByuA/r3z+vVz91vWhYVOQeXG4OoYJsj+3h4TlAZKdJD
         jZjGj8QlSuEFEGqmfb6p9Jd2kqOSjwRtjpebArzGY1EAP86Y2gQqvnJ3LHir/ZHbMuIJ
         ZLFAs2oRcdHHpbtABfKICAgOeJspOrdnp/ZB5wjPI65JZEcHb1rljP+Du8ppywyo5RBY
         OAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GB66w5zMnO6g29s6wAcFRJIvcQvj59wk11SwJfYrvKA=;
        b=er4hyfe9MUzPtzDkPoK33gMkxcGl0U8ivckT8mvArTWDl4e2UwEGgDsCq0/3sBrZuN
         KiYcBovG2jReOiLNq0j8edjyhKJ8uHoGXDQNN4P616UHIqHDbn9qHfC8B+jbspbqh1kZ
         Pzhqpj4fb3Y5n3/zsdNFQo3RPHA6AhmH2zoFWFVUU+LRwrxkypk+iJ7rIODKVsrkTPUI
         /6H9YcMLmLoK+AQ/U+Ge9fW7B+kIfHLGTVanl52zPG6JdZ8Dm4gaPcld7A2oO6V+p72Q
         pAEWeFgkao4PSJ3KKfmtvc2U8rVq+ceEi4Vtw8VQ573IMVhuy0/7pFZrlMs6YoeeL//7
         5Dyg==
X-Gm-Message-State: APjAAAXzd8rtxnn52Y30X09K2Frg/XW8r1Np2EZYWnrcsc1qFbL8V3aJ
        ZzeB/IgDF2TN0kU9Thii6LHGxQ==
X-Google-Smtp-Source: APXvYqyiEFjS0AsnLhLndE+VCdtmMKp2KjunxS32g/fNq7UVoFTUkMLRgGPV3k3rKDum27SdorNUaw==
X-Received: by 2002:a17:90a:9f94:: with SMTP id o20mr4347710pjp.76.1572011086048;
        Fri, 25 Oct 2019 06:44:46 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::553e])
        by smtp.gmail.com with ESMTPSA id y17sm2913564pfo.171.2019.10.25.06.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 06:44:45 -0700 (PDT)
Date:   Fri, 25 Oct 2019 09:44:43 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 5/8] mm: vmscan: replace shrink_node() loop with a retry
 jump
Message-ID: <20191025134443.GA385668@cmpxchg.org>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
 <20191022144803.302233-6-hannes@cmpxchg.org>
 <20191023141857.GF17610@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023141857.GF17610@dhcp22.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 23, 2019 at 04:18:57PM +0200, Michal Hocko wrote:
> On Tue 22-10-19 10:48:00, Johannes Weiner wrote:
> > Most of the function body is inside a loop, which imposes an
> > additional indentation and scoping level that makes the code a bit
> > hard to follow and modify.
> 
> I do agree!
> 
> > The looping only happens in case of reclaim-compaction, which isn't
> > the common case. So rather than adding yet another function level to
> > the reclaim path and have every reclaim invocation go through a level
> > that only exists for one specific cornercase, use a retry goto.
> 
> I would just keep the core logic in its own function and do the loop
> around it rather than a goto retry. This is certainly a matter of taste
> but I like a loop with an explicit condition much more than a if with
> goto.

Yeah, as the changelog says, I'm intentionally putting the looping
construct into the "cold path" of the code flow: we only loops in a
very specific cornercase, and having the whole body in a loop, or
creating another function nesting level for it suggests otherwise.

A goto seems like the perfect tool to have a retry for one particular
caller without muddying the code flow for the common call stack.

Matter of taste, I guess.
