Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 782086AD98
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2019 19:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbfGPRZD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Jul 2019 13:25:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39687 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfGPRZD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Jul 2019 13:25:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so5449127pfn.6
        for <cgroups@vger.kernel.org>; Tue, 16 Jul 2019 10:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jmmNrLz05OQxiUsEmtCkS8mBmrl8vj668vZ/xiMeIrY=;
        b=phx1Mq5J6p2gfPq049fRU4kJqr233RVvBA6UMs66Fh5VPoHy5KsLA3yLW7b00Y3rb8
         GTdFxxgsB1P4yFAdo2Qi0lgz4B0At2EUVu95fRfY8Bd7hU1ELdLrEB76Wv/eTo0O/IHK
         cBHGKVh+C260gNquMCThFTjxvff5UR0XDGNu4y01LXooRqWSmV8nFoJlX5Ux8Oc0p4YR
         Ffk+3gQEUfcv+lzY/PFoTBxKXktxFJtv2i/1ZrJEAx+OqMpmcJgHGEZrhE7dlAGzP7Ne
         tVCLPB+rZn10vOY9YPlc33YLioHP5gwh7muhEqrhXj+c2blGXe3qtkyX7eg0lodMWVNf
         3yiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jmmNrLz05OQxiUsEmtCkS8mBmrl8vj668vZ/xiMeIrY=;
        b=bdP0k77A5XAkt2lleK+/JH9HAfLPo9Sk+Va1Fn1w3O5s7stKgAsA2+OUrbNiw1+kVq
         kL45ucbd8hUaQBfXJrtOBLNg0MWKU67lmxLCentR3sPSDeBCJk7kgqSbyu3QsUmw5t+I
         8KlRA5AkRlk5iVstrfOXVMin8TvWJBF6yW3l9QILqEkZFhh7r3Qtf7CFhMidZJsjgNNQ
         QXqhJP3gHqBQAbMbI/x5Ubnks3rwf4owrOdfp96qt94dn8j3M9iX0P9Fk3VyVieSxynY
         aKATDSkgR0TAnvYE9zzNHGo7bUbvYUYWc7C6aOuc81YMT0Gl9lcVEDVG8SMV3Z8C4y0I
         MLqw==
X-Gm-Message-State: APjAAAUsYtYMLwNXqnLlPYaNZxcxMmzJdmboprX1D6fLbOESynX8gT4v
        T0CyHWJC9NCI9UlXQ3JmdIE=
X-Google-Smtp-Source: APXvYqxNNQERGxivXJ3Js3Bxfn7FLjsI5wI5vL3fUqwqk1694sNNijt4himTh6hZUPRXthewU9p3Tw==
X-Received: by 2002:a63:dd17:: with SMTP id t23mr8718560pgg.295.1563297902419;
        Tue, 16 Jul 2019 10:25:02 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::1:dd93])
        by smtp.gmail.com with ESMTPSA id e6sm25465734pfn.71.2019.07.16.10.25.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 10:25:01 -0700 (PDT)
Date:   Tue, 16 Jul 2019 13:24:59 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Chris Down <chris@chrisdown.name>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH] mm: Proportional memory.{low,min} reclaim
Message-ID: <20190716172459.GB16575@cmpxchg.org>
References: <20190124014455.GA6396@chrisdown.name>
 <20190128210031.GA31446@castle.DHCP.thefacebook.com>
 <20190128214213.GB15349@chrisdown.name>
 <20190128215230.GA32069@castle.DHCP.thefacebook.com>
 <20190715153527.86a3f6e65ecf5d501252dbf1@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715153527.86a3f6e65ecf5d501252dbf1@linux-foundation.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 15, 2019 at 03:35:27PM -0700, Andrew Morton wrote:
> On Mon, 28 Jan 2019 21:52:40 +0000 Roman Gushchin <guro@fb.com> wrote:
> 
> > > Hmm, this isn't really a common situation that I'd thought about, but it
> > > seems reasonable to make the boundaries when in low reclaim to be between
> > > min and low, rather than 0 and low. I'll add another patch with that. Thanks
> >
> > It's not a stopper, so I'm perfectly fine with a follow-up patch.
> 
> Did this happen?
> 
> I'm still trying to get this five month old patchset unstuck :(.  The
> review status is: 
> 
> [1/3] mm, memcg: proportional memory.{low,min} reclaim
> Acked-by: Johannes
> Reviewed-by: Roman
> 
> [2/3] mm, memcg: make memory.emin the baseline for utilisation determination
> Acked-by: Johannes
> 
> [3/3] mm, memcg: make scan aggression always exclude protection
> Reviewed-by: Roman

I forgot to send out the actual ack-tag on #, so I just did. I was
involved in the discussions that led to that patch, the code looks
good to me, and it's what we've been using internally for a while
without any hiccups.

> I do have a note here that mhocko intended to take a closer look but I
> don't recall whether that happened.

Michal acked #3 in 20190530065111.GC6703@dhcp22.suse.cz. Afaik not the
others, but #3 also doesn't make a whole lot of sense without #1...

> a) say what the hell and merge them or
> b) sit on them for another cycle or
> c) drop them and ask Chris for a resend so we can start again.

Michal, would you have time to take another look this week? Otherwise,
I think everyone who would review them has done so.
