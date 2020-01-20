Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4103E143340
	for <lists+cgroups@lfdr.de>; Mon, 20 Jan 2020 22:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgATVK7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Jan 2020 16:10:59 -0500
Received: from mail-pj1-f43.google.com ([209.85.216.43]:51737 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgATVK6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Jan 2020 16:10:58 -0500
Received: by mail-pj1-f43.google.com with SMTP id d15so299863pjw.1
        for <cgroups@vger.kernel.org>; Mon, 20 Jan 2020 13:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=SSadIyR7qVLBxGpfBtC2uRk5NBC+TncNZKu7gCEZ7pA=;
        b=e4c5GH3yb99tS4U3zqHkIHT5zq1PHemkzbJQ92TpbvDrMbCVfVqwabuhKEcIkWE7Bh
         sAr74tq9kNLnOcxliIkDllPWCaggxJJZHdNJcM7gieitVYuq2XQac8TrMmY8lQYtifoJ
         3QdaLVI/+OJNhSQZkv23hZAWELVCl/TWUfHLdHReQ9zLjUChBhD2GiFsjtiw9au6skhY
         eubc51eHF6ddYbcLVSGjVrF7psbbypJu8Dwzowo7/2+/6Qi2qGHcc8qzwzr9fbRFURgC
         0WwM1o+ZzL4xpJj1ZwnQdbzV5CXuKZXYVga+2FGM+yTAH2tV5ATQAvhA1SCDU3CUqqH7
         Kuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=SSadIyR7qVLBxGpfBtC2uRk5NBC+TncNZKu7gCEZ7pA=;
        b=eGlHHucuyHQlTB4JY3rB9yx6EIGu+pKrcKL/wSqju35cS64Rp/I/R91YxBn0HqqUO3
         MsCdAdJxsPDjhqeiUwxzCxfglyZHyngChT6Q/le9bWO/KNblgum4d33Z64kTkpi6KFG0
         lFmuhGlvgAr6UsDcR74t8KuEYsyEkjrJ3URGRIrMEFLN8dV4Z24uXwCGB+HlMztH6+HI
         MqccljDrzZXd0oCMB6XjNkkMbCPBLbQTnSMPrQ0prJ/o72+LLwNA105AyCWxMVHtDnYn
         ac356vI7feShFinctQy5xJam+ecLrkPtTkrcen3kNa+ZyYXBqlD+GSk/Ca/3/0tGRYK1
         iLQA==
X-Gm-Message-State: APjAAAWLQ6kuAcZtkMjdY4AsqfL+IbM8yiB5pCW8D2L4yNEfDf2WY4/0
        PLKCMr5ZwAe0LUKB/oXpqHQrBg==
X-Google-Smtp-Source: APXvYqwVcFkW1ppmvT8X3m7D+blK3vBxTjJDijtegUcyGaMfvlBh63AN6tKuiyhKNGXLfow1BgyhVQ==
X-Received: by 2002:a17:90a:e397:: with SMTP id b23mr1018122pjz.135.1579554657933;
        Mon, 20 Jan 2020 13:10:57 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id j14sm38145864pgs.57.2020.01.20.13.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 13:10:57 -0800 (PST)
Date:   Mon, 20 Jan 2020 13:10:56 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richardw.yang@linux.intel.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, ktkhai@virtuozzo.com,
        kirill.shutemov@linux.intel.com, yang.shi@linux.alibaba.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
        stable@vger.kernel.org
Subject: Re: [Patch v4] mm: thp: remove the defer list related code since
 this will not happen
In-Reply-To: <20200120072237.GA18451@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.2001201307520.259466@chino.kir.corp.google.com>
References: <20200117233836.3434-1-richardw.yang@linux.intel.com> <20200118145421.0ab96d5d9bea21a3339d52fe@linux-foundation.org> <alpine.DEB.2.21.2001181525250.27051@chino.kir.corp.google.com> <20200120072237.GA18451@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 20 Jan 2020, Michal Hocko wrote:

> > When migrating memcg charges of thp memory, there are two possibilities:
> > 
> >  (1) The underlying compound page is mapped by a pmd and thus does is not 
> >      on a deferred split queue (it's mapped), or
> > 
> >  (2) The compound page is not mapped by a pmd and is awaiting split on a
> >      deferred split queue.
> > 
> > The current charge migration implementation does *not* migrate charges for 
> > thp memory on the deferred split queue, it only migrates charges for pages 
> > that are mapped by a pmd.
> > 
> > Thus, to migrate charges, the underlying compound page cannot be on a 
> > deferred split queue; no list manipulation needs to be done in 
> > mem_cgroup_move_account().
> > 
> > With the current code, the underlying compound page is moved to the 
> > deferred split queue of the memcg its memory is not charged to, so 
> > susbequent reclaim will consider these pages for the wrong memcg.  Remove 
> > the deferred split queue handling in mem_cgroup_move_account() entirely.
> 
> I believe this still doesn't describe the underlying problem to the full
> extent. What happens with the page on the deferred list when it
> shouldn't be there in fact? Unless I am missing something deferred_split_scan
> will simply split that huge page. Which is a bit unfortunate but nothing
> really critical. This should be mentioned in the changelog.
> 

Are you referring to a compound page on the deferred split queue before a 
task is moved?  I'm not sure this is within the scope of Wei's patch.. 
this is simply preventing a page from being moved to the deferred split
queue of a memcg that it is not charged to.  Is there a concern about why 
this code can be removed or a suggestion on something else it should be 
doing instead?
