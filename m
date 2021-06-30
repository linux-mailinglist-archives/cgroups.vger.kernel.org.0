Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221423B7DC6
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 08:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhF3HBv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 03:01:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60598 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbhF3HBu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 03:01:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1C8E81FE3A;
        Wed, 30 Jun 2021 06:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625036361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CBX5W0P8DL2x/XCJkVNccKGv5Jq305wfaEnKjkBFQbU=;
        b=tQDnM997hmtRMIDHmNoz8iYve7UjLjIA9Xnyf1hZOU7z059jrks20PJMzWuIZ6sseJT5r0
        kZXRR5Ot0CdSeaOBAGXmyTCvnH0LuoP/CiuIrso4go+5g8N9ZBirBRb2aQSJOjj4nGmuwd
        cwOOLPE1ENmq3zIH0sLfD9BV68EIjLU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DE318A3B88;
        Wed, 30 Jun 2021 06:59:20 +0000 (UTC)
Date:   Wed, 30 Jun 2021 08:59:20 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v3 05/18] mm/memcg: Convert memcg_check_events to take a
 node ID
Message-ID: <YNwWSNjGV6/vdfHk@dhcp22.suse.cz>
References: <20210630040034.1155892-1-willy@infradead.org>
 <20210630040034.1155892-6-willy@infradead.org>
 <YNwWC8Nb3QfhMOTs@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNwWC8Nb3QfhMOTs@dhcp22.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 30-06-21 08:58:20, Michal Hocko wrote:
> On Wed 30-06-21 05:00:21, Matthew Wilcox wrote:
> > memcg_check_events only uses the page's nid, so call page_to_nid in the
> > callers to make the folio conversion easier.
> 
> It will also make the interface slightly easier to follow as there
> shouldn't be any real reason to take the page for these events.
> So this is a good cleanup in general.
> 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Btw. patches 2-5 seem good enough to go to Andrew even without the rest
so that you do not have to carry them along with the rest which is quite
large I can imagine.
-- 
Michal Hocko
SUSE Labs
