Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29551132186
	for <lists+cgroups@lfdr.de>; Tue,  7 Jan 2020 09:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgAGIiM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Jan 2020 03:38:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53885 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgAGIiM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Jan 2020 03:38:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id m24so17955766wmc.3;
        Tue, 07 Jan 2020 00:38:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SGM8vCSlpFGCG/2t5WreFm3qVTUhAAZYlmJ6tgri9vo=;
        b=TpYgjrWHZZsEgNbyHx+xRC7GQHx1H0BNGlOyCWxkPJrben0Wc1r/4mhEUmI8M1WDOY
         DgZfmpceEExgmWU5wOtxvmbdRMooIiGDelvi218eRus2O6sCrSACT4UyrfoZiF8nDzsc
         Jes4alkpsBeptNfJ9SqWF/OwzikL8cJiQGGebx9ZKveQLFzboQiyDXoW+X32+cumDNNW
         fFmYf7iANSCKoJlnCKdzezyyMeDholyNddZ5xy2HPg9qu9YU45iMGhkyMkf7QgT8Tj4A
         4QoA6BWRZltG0NVnXuSgh0QAr6027pFd5KWpShwvZWh0LuvL6j4J2h/zZR1omb9/h+4F
         WScA==
X-Gm-Message-State: APjAAAUE/Ck/PgkS3LcFEhHXaBfUJ9ncVI9teQLGkgQWHbXbh/0Uz4Nk
        XJNYjUC/2PyVgkR0MJfou1g=
X-Google-Smtp-Source: APXvYqy0l2pPimu0jmfAhj7eC6jxjBqL6qeDNUL2ENjX4Pdxdm00JiUu0Ra5iiAEjLelBdmYD4+x6w==
X-Received: by 2002:a05:600c:141:: with SMTP id w1mr38077892wmm.61.1578386289713;
        Tue, 07 Jan 2020 00:38:09 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id w19sm25365788wmc.22.2020.01.07.00.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 00:38:08 -0800 (PST)
Date:   Tue, 7 Jan 2020 09:38:08 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com
Subject: Re: [RFC PATCH] mm: thp: grab the lock before manipulation defer list
Message-ID: <20200107083808.GC32178@dhcp22.suse.cz>
References: <20200103143407.1089-1-richardw.yang@linux.intel.com>
 <20200106102345.GE12699@dhcp22.suse.cz>
 <20200107012241.GA15341@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107012241.GA15341@richard>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 07-01-20 09:22:41, Wei Yang wrote:
> On Mon, Jan 06, 2020 at 11:23:45AM +0100, Michal Hocko wrote:
> >On Fri 03-01-20 22:34:07, Wei Yang wrote:
> >> As all the other places, we grab the lock before manipulate the defer list.
> >> Current implementation may face a race condition.
> >
> >Please always make sure to describe the effect of the change. Why a racy
> >list_empty check matters?
> >
> 
> Hmm... access the list without proper lock leads to many bad behaviors.

My point is that the changelog should describe that bad behavior.

> For example, if we grab the lock after checking list_empty, the page may
> already be removed from list in split_huge_page_list. And then list_del_init
> would trigger bug.

And how does list_empty check under the lock guarantee that the page is
on the deferred list?
-- 
Michal Hocko
SUSE Labs
