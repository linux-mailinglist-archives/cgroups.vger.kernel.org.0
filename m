Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFD13B7F37
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 10:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbhF3IrF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 04:47:05 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34232 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbhF3IrE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 04:47:04 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 871E021988;
        Wed, 30 Jun 2021 08:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625042675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3OmycjinSN9Rqu4sruLQLeh2JEfTID4e2vPAi+oGGc4=;
        b=U9WkiImBT/o2+XtLjMmAghaMz18IKAS9jksowSX2OspLE+NeTYO+Qvh+GIvndKmNTCRS5/
        o2BZjo2Et6RSgmDKZgTz2ZSZzzb9KlmbWn6em0TCT6IijpH9Ykry6UbFHB5wxYmX+OTQ67
        z9h7bf1Z3tatitHHTzwPjMrjN4S6ReI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 58B68A3B88;
        Wed, 30 Jun 2021 08:44:35 +0000 (UTC)
Date:   Wed, 30 Jun 2021 10:44:34 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v3 00/18] Folio conversion of memcg
Message-ID: <YNwu8qCRpEFNDxRl@dhcp22.suse.cz>
References: <20210630040034.1155892-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630040034.1155892-1-willy@infradead.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 30-06-21 05:00:16, Matthew Wilcox wrote:
> After Michel's comments on "Folio-enabling the page cache", I thought it
> best to split out the memcg patches from the rest of the page cache folio
> patches and redo them to focus on correctness (ie always passing a folio).
> 
> This is fundamentally for review rather than application.  I've rebased
> on Linus' current tree, which includes the recent patchbomb from akpm.
> That upstream version won't boot on any system I have available, and I'm
> not comfortable asking for patches to be applied unless I can actually
> try them.  That said, these patches were fine on top of 5.13.
> 
> There are still a few functions which take pages, but they rely on other
> conversions happening first, which in turn rely on this set of patches,
> so I think this is a good place to stop, with the understanding that
> there will be more patches later.

Thanks for considering the last review feedback. After looking at this
pile the conversion is really straightforward and reasonably easy to
review. There are still some cases where you opted to go with
compatibility wrappers and I would still like to avoid those as it
somehow obfuscates the conversion IMHO. As I've said previously, though,
I do understand that this a tedious work so I do not want to make it
more annoying unnecessarily for you. The replacement with page_folio for
the replaced API looks better to me. If you have strong reasons (e.g.
due to dependencies etc.) please make it explicit in the respective
changelogs.

Thanks!
-- 
Michal Hocko
SUSE Labs
