Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6DB13546A
	for <lists+cgroups@lfdr.de>; Thu,  9 Jan 2020 09:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgAIIen (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Jan 2020 03:34:43 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51908 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbgAIIen (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Jan 2020 03:34:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id d73so1878034wmd.1;
        Thu, 09 Jan 2020 00:34:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fiwxWAj6fl4uwgdSmX0Unt2fU/7yP6zeVqus9FvcYXs=;
        b=D7HzYqOL7WqTqVbg2qaO5huOgJ3JcCWJul5lkRpqUbSFB9YE+EhsWyK7NUJuWQJV0U
         qeSpkBuWo5wtJcmx9DNCVSPbqqNYos5N3Xgt2STowQYD8IFFc+xmhvlDzviuYhjYASMZ
         wV7MXCwwzWj4wLzkaHQ65FYsIySXAaVIccSlFGLIcecfKJ4rW4QslazubolRN6M7vURo
         77BOoIfiXws7SuU5sLuPc1lNi0lBSjvZ2wlHEAy4d4TbwpimymoIMo7j5QTzkA5jV6xj
         Rt5J5Y/4GcdGtvqYeUzEv/6O0AUndM203Spxd3bAQleHm3C8P0WdmAiBqaGhDJk+5+Ty
         a1Ng==
X-Gm-Message-State: APjAAAU2MQ+L7unYM3+jZKPbQoBD5EX3zcHgzYePdwD4ZBZYZTeoFl/r
        MJGHXiJhDe8A4i/dvskI36c=
X-Google-Smtp-Source: APXvYqx4Cv5JAPMoeQkqJYvH87tv4chG76QXbvlEdXUPoXz7ilcprLQ5fU9+kfYuT8G1cJVUkoch0Q==
X-Received: by 2002:a7b:c946:: with SMTP id i6mr3313642wml.28.1578558881074;
        Thu, 09 Jan 2020 00:34:41 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id m7sm1998800wma.39.2020.01.09.00.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 00:34:40 -0800 (PST)
Date:   Thu, 9 Jan 2020 09:34:38 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com
Subject: Re: [RFC PATCH] mm: thp: grab the lock before manipulation defer list
Message-ID: <20200109083438.GG4951@dhcp22.suse.cz>
References: <20200103143407.1089-1-richardw.yang@linux.intel.com>
 <20200106102345.GE12699@dhcp22.suse.cz>
 <20200107012241.GA15341@richard>
 <20200107083808.GC32178@dhcp22.suse.cz>
 <20200108003543.GA13943@richard>
 <20200108094041.GQ32178@dhcp22.suse.cz>
 <20200109020319.GB31041@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109020319.GB31041@richard>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 09-01-20 10:03:19, Wei Yang wrote:
> On Wed, Jan 08, 2020 at 10:40:41AM +0100, Michal Hocko wrote:
[...]
> >Moreover, look at the code you are trying to fix. Sure extending the
> >locking seem straightforward but does it result in a correct code
> >though? See my question in the previous email. How do we know that the
> >page is actually enqued in a non-empty list?
> 
> I may not get your point for the last sentence.
> 
> The list_empty() doesn't check the queue is empty but check the list, here is
> the page, is not enqueued into any list. Is this your concern?

My bad. For some reason I have misread the code and thought this was
get_deferred_split_queue rather than page_deferred_list. Sorry about the
confusion.
-- 
Michal Hocko
SUSE Labs
