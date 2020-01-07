Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95CCA131D76
	for <lists+cgroups@lfdr.de>; Tue,  7 Jan 2020 03:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbgAGCHb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Jan 2020 21:07:31 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36972 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbgAGCHb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Jan 2020 21:07:31 -0500
Received: by mail-pl1-f194.google.com with SMTP id c23so22557947plz.4
        for <cgroups@vger.kernel.org>; Mon, 06 Jan 2020 18:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=FcqVbuH4BEZl+ciRs0e0B8iPKj0+hshWElohx4nDlP8=;
        b=sTFeI61tYPfuAIi6zuNSHzccw82y+IFJQZN/FOERtaSSqtpiXv2rOpO1dyPm4suK9d
         ftLYzVvf4icX0o3N0u/z5HFcxiat1L2XRuge1iX7lbBY2Md2XAs+Vxt04yEGQu7uv2l8
         B9lrwHI36DRK0JUm1QxdEBLBDZl4WkM/Ai4x6+Hqh019u9drIfYC7rQPYih72eXUlL7V
         KOFBxa2toSREPK7LfZYoSs+/8fgvnWy7jTYEu1twlyKcjKroHFNdQjabRMii/TID8Eev
         FBntvssn6jwCDIMA8zHiVazWzc611aei+IvMD9PvhSF9GrFnfsLNykTivOxhqLapB3+P
         +P0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=FcqVbuH4BEZl+ciRs0e0B8iPKj0+hshWElohx4nDlP8=;
        b=XiXSwjnP322WcKeon1ObErsPUj/+uG9aGfx+ma/kEbFClfi4r1hTw7jO/63/IqS6Q1
         A9w0Ks9ChMXkILYAUaXnPy01JE40YvYCvhf7t6ja32gHQjmR1UfaqF2HD5v/SOiVHd8G
         4DiRaf8BDgOaBFZ4vCHsQSHECLLGBVmoITvFkYS2YDIERH15EEwMBI09XeAzUo/T5LVh
         1EjZwenXB8c3GmSp/mPtfkb3FV1JTTInThbTGEKDKtCDHg4bvazMirdgZhPDu0d7sQNF
         9sXDDf+hqU6WZ15SWC8eEJHXb0Chil4XtFGvk74Rml6yV4GxSQ9A44GF/rerYL7m6v1m
         Dmcw==
X-Gm-Message-State: APjAAAVw1VGdpHzUIq2e37n6O1eGo4TMAIwdY+hGLgnfgSGy76UOFkCh
        7PIcLph71gbdR+ghB4gBe8VqHg==
X-Google-Smtp-Source: APXvYqxSmH3jtb3yGf6lQzuN/p1hBfhYZSwhFc2W7ST0vDRyyIEI7Z+ED8qhCWhzRta6FDHArc60zA==
X-Received: by 2002:a17:90a:660b:: with SMTP id l11mr45934270pjj.47.1578362850725;
        Mon, 06 Jan 2020 18:07:30 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id i3sm78670353pfg.94.2020.01.06.18.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 18:07:29 -0800 (PST)
Date:   Mon, 6 Jan 2020 18:07:29 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Wei Yang <richardw.yang@linux.intel.com>
cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, vdavydov.dev@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        cgroups@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [RFC PATCH] mm: thp: grab the lock before manipulation defer
 list
In-Reply-To: <20200107012624.GB15341@richard>
Message-ID: <alpine.DEB.2.21.2001061803200.55132@chino.kir.corp.google.com>
References: <20200103143407.1089-1-richardw.yang@linux.intel.com> <CAKgT0Uf+EP8yGf93=R3XK0Y=0To0KQDys0O1BkG-Odej3Rwj5A@mail.gmail.com> <20200107012624.GB15341@richard>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 7 Jan 2020, Wei Yang wrote:

> >One thing you might want to do is pull the "if (compound)" check out
> >and place it outside of the spinlock check. It would then simplify
> >this signficantly so it is something like
> >if (compound) {
> >  spin_lock();
> >  list = page_deferred_list(page);
> >  if (!list_empty(list)) {
> >    list_del_init(list);
> >    from->..split_queue_len--;
> >  }
> >  spin_unlock();
> >}
> >
> >Same for the block below. I would pull the check for compound outside
> >of the spinlock call since it is a value that shouldn't change and
> >would eliminate an unnecessary lock in the non-compound case.
> 
> This is reasonable, if no objection from others, I would change this in v2.

Looks fine to me; I don't see it as a necessary improvement but there's 
also no reason to object to it.  It's definitely a patch that is needed, 
however, for the simple reason that with the existing code we can 
manipulate the deferred split queue incorrectly so either way works for 
me.  Feel free to keep my acked-by.
