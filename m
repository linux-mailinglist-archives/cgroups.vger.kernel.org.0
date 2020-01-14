Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D737913B3DD
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2020 21:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgANU5Y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Jan 2020 15:57:24 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37237 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANU5Y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Jan 2020 15:57:24 -0500
Received: by mail-pj1-f67.google.com with SMTP id m13so6426019pjb.2
        for <cgroups@vger.kernel.org>; Tue, 14 Jan 2020 12:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Yw4+mImP3xYemjNvEkTXmDMcGpXxaxAKM4GUBoCUQVE=;
        b=meEWzXz0iIiGD+szilzJbFn93Ka67aSbLRJ9wne3w2YWA+jsC7qemaDkmGSUrhndjx
         6LzOtL6Vvux8f8xKsXQz0p5sHQTf7/Z14qIDx7ZCfiRZLg11JY86JF48ZSFoSYisTPgD
         Z3hyNfR+nHSLcmiWbGyA1E0X3mCdGHa1iLNwBOIXcLHS1cEhv5502Gjcp/H3L4bYi5VM
         EhWQLy65l4h/wnaGDxqWu+Ve/UMFwaq3Cx79sI7wDGUNcwpMuwUnuJFvI5Z7bewxIlR9
         7Ol2MY1JtdE0ZkhBTpaPEv+yR8x1MNHBaqg+G2fPLK1WiBBZ2VGvkUhAq2WVsHpdcF7A
         JonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Yw4+mImP3xYemjNvEkTXmDMcGpXxaxAKM4GUBoCUQVE=;
        b=DWdlvLjbCbazOfDIazTZ37/7OOtfSTeqRlCS2AJK3LRTtdQUuDhU7YP8ywtQfEFYJd
         4R8LoxbsYL9cWDnJZDkSTV5hLHrqp0CnoFBC68kaBe/GuvfdgrZKFbtNFtFOO/R6UBp4
         EJ7Ve5JiAylJVfO/gj80C/UboobGaL69yeaSoBhtqBHLHWN1PRTelbh+m5S156s3rTHc
         teQuqA4XcZ8dDzLWIVuoF6d21G4RoAh3rKsVZWyfkciW+eEuy/R75cB75c0Fk+3v09/O
         Gk4WRSM3qWg0D7bmrbBGE+I8Sgokc4wLTiZPaCMsWAthwEzYubyyA6UQwNLnF8HKgM/K
         3FBQ==
X-Gm-Message-State: APjAAAURuTIp15MJfIKZ6PFHiNAYrxexI+jSeb9DBit+xeFubDX/1Kr0
        snTbuMrrxtyKsLkHs175axlE0A==
X-Google-Smtp-Source: APXvYqz7YJQ9CTCHO6hNIZZYM+ZTeUZfAdGByWSmm119Y5+Eq0RdJ4hmTUZWY3fJDjxiiqFGyvET8A==
X-Received: by 2002:a17:90a:868b:: with SMTP id p11mr31206212pjn.60.1579035443905;
        Tue, 14 Jan 2020 12:57:23 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id t63sm19315754pfb.70.2020.01.14.12.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 12:57:22 -0800 (PST)
Date:   Tue, 14 Jan 2020 12:57:22 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richardw.yang@linux.intel.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        yang.shi@linux.alibaba.com, alexander.duyck@gmail.com
Subject: Re: [Patch v2] mm: thp: grab the lock before manipulation defer
 list
In-Reply-To: <20200114105921.eo2vdwikrvtt3gkb@box>
Message-ID: <alpine.DEB.2.21.2001141254460.84781@chino.kir.corp.google.com>
References: <20200109143054.13203-1-richardw.yang@linux.intel.com> <20200111000352.efy6krudecpshezh@box> <20200114093122.GH19428@dhcp22.suse.cz> <20200114103112.o6ozdbkfnzdsc2ke@box> <20200114105921.eo2vdwikrvtt3gkb@box>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 14 Jan 2020, Kirill A. Shutemov wrote:

> split_huge_page_to_list() has page lock taken.
> 
> free_transhuge_page() is in the free path and doesn't susceptible to the
> race.
> 
> deferred_split_scan() is trickier. list_move() should be safe against
> list_empty() as it will not produce false-positive list_empty().
> list_del_init() *should* (correct me if I'm wrong) be safe because the page
> is freeing and memcg will not touch the page anymore.
> 
> deferred_split_huge_page() is a problematic one. It called from
> page_remove_rmap() path witch does require page lock. I don't see any
> obvious way to exclude race with mem_cgroup_move_account() here.
> Anybody else?
> 
> Wei, could you rewrite the commit message with deferred_split_huge_page()
> as a race source instead of split_huge_page_to_list()?
> 

I think describing the race in terms of deferred_split_huge_page() makes 
the most sense and I'd prefer a cc to stable for 5.4+.  Even getting the 
split_queue_len, which is unsigned long, to underflow because of a 
list_empty(page_deferred_list()) check that is no longer accurate after 
the lock is taken would be a significant issue for shrinkers.
