Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E1B3B8A18
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 23:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbhF3VXq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 17:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhF3VXq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 17:23:46 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44A5C061756
        for <cgroups@vger.kernel.org>; Wed, 30 Jun 2021 14:21:16 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so5256998pjs.2
        for <cgroups@vger.kernel.org>; Wed, 30 Jun 2021 14:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fr9/V6zIlyWck7HPPeS/TCISALLUxUMSsg+X8S97SXI=;
        b=IHSBJTW86/4n83zVuVdOYB3dXkYzVbUh3RZq3+9raR0OesfrwlcgGpsCSG22rwBLa8
         5tZM0tz7yNIlyQ+UukH++/9forrJNhx71wU56uudMVEHfT2eTLz5FuzvcvabzL/b3DgS
         FaexCwnP9dqgR81LBpnq6dPUvVokwVh5E20tfSclZYpmarmNA7Gv6IwQbkZPafS7J2cv
         gjjX251lVq3VJrcWOK821GgzrLCMxir0gtU9TFP6uyc3qbggepQByhTqmPgI3rZWGAFn
         jIGyjmjG4ynnEbfjtC52ENZpDkYsnDVjrCdguiGd9tq6+9bvVAiI+DQbWD3QWATYCWbp
         Pf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fr9/V6zIlyWck7HPPeS/TCISALLUxUMSsg+X8S97SXI=;
        b=fXeqsZCBqbjPEZirht2omT/zT2c1JrzzJYYPDspgFmaFwReL7ppZcIl1bsGK1K0KTE
         7sLkhGfyMghHchCBEs2itUVeyYbf9IGodU4Fiu/squCrSCOZKKf0IxibGu+X3hKGq3Qg
         HyFTrzWSX64mVxUKBRLherqB6WYO3/BopUg32LavOXMIYG2TfKH2rh1srhXJ7XxfEtk5
         sbQbfbXphdQOWVVBJHlsSU5S9urb/VZ+9dhJN2GDulAq6sM2kMmumDaBgboYqsJpCSsd
         tNuhic7rsoLRFObC/AsqDTZZwi8Nm2chIy4+OwMGWBrpgR8T+/JkAbYGwra0xAzvYjGb
         ZeGA==
X-Gm-Message-State: AOAM532GtkpoDCj/CvjNbUJW/5ImdAJpOI3enKij2LPx/nG5PaWqY279
        e+cvDN9UsQN6H/0dDZQA7KxJGQ==
X-Google-Smtp-Source: ABdhPJzg0SlYb5DEfXzjiZKgf2sG7J7p/O1fYQHzHmIAbYU6pKKs+GWIUg5CMb3JadmDuddP0koIuQ==
X-Received: by 2002:a17:90a:3fcd:: with SMTP id u13mr6639295pjm.182.1625088076271;
        Wed, 30 Jun 2021 14:21:16 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:14ba])
        by smtp.gmail.com with ESMTPSA id i18sm10900990pfa.37.2021.06.30.14.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 14:21:15 -0700 (PDT)
Date:   Wed, 30 Jun 2021 17:21:12 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v3 15/18] mm/memcg: Add mem_cgroup_folio_lruvec()
Message-ID: <YNzgSOkl77FHdfhV@cmpxchg.org>
References: <20210630040034.1155892-1-willy@infradead.org>
 <20210630040034.1155892-16-willy@infradead.org>
 <YNzDiTFZpRgKY0CE@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNzDiTFZpRgKY0CE@casper.infradead.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 30, 2021 at 08:18:33PM +0100, Matthew Wilcox wrote:
> On Wed, Jun 30, 2021 at 05:00:31AM +0100, Matthew Wilcox (Oracle) wrote:
> > This is the folio equivalent of mem_cgroup_page_lruvec().
> 
> I'm just going through and removing the wrappers.
> 
> Why is this function called this?  There's an odd mix of
> 
> lock_page_memcg()

This was chosen to match lock_page().

> page_memcg()

And this to match page_mapping(), page_zone() etc.

> count_memcg_page_event()

count_vm_event()

> split_page_memcg()

split_page(), split_page_owner()

> mem_cgroup_charge()
> mem_cgroup_swapin_charge_page()

These are larger, heavier subsystem API calls that modify all kinds of
state, not just the page. Hence the namespacing.

With the smaller getter/setter type functions on pages we have
traditionally used <verb>_<object> rather than page_<verb>, simply
because the page is such a low-level object and many functions do
sequences of page manipulations. Namespacing would turn them into:

	page_do_this(page);
	page_set_that(page);
	page_lock(page);
	if (page_is_blah(page))
		page_mark_foo(page);
	page_unlock(page);
	page_put(page);

which is hard on the reader because it obscures the salient part of
each line behind repetetive boiler plate.

> mem_cgroup_lruvec()

This is arguably not a namespace prefix, but rather an accessor
function to look up the memcg's lruvec.

> mem_cgroup_from_task()

This is a pattern to look up memcgs from various objects:

- mem_cgroup_from_css()
- mem_cgroup_from_counter()
- mem_cgroup_from_id()
- mem_cgroup_from_seq()
- mem_cgroup_from_obj()

and we used to have mem_cgroup_from_page() at some point...

> I'd really like to call this function folio_lruvec().

That would be a better name indeed.

However, pairing renames with conversion is worrisome because it means
having two unintuitively diverging names for the same operation in the
API during a time where everybody has to relearn the code base already.

Please either precede it with a rename to page_lruvec(), or keep the
existing naming pattern in the conversion.

> It happens to behave differently if the folio is part of a memcg,
> but conceptually, lruvecs aren't particularly tied to memcgs.

Conceptually, lruvecs are always tied to a memcg. On !CONFIG_MEMCG
kernels that just happens to be the root cgroup.

But because it's an accessor to a page attribute, dropping the
namespacing prefix is in line with things like page_memcg().
