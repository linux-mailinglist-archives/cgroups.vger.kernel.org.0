Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA56F71A1
	for <lists+cgroups@lfdr.de>; Mon, 11 Nov 2019 11:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfKKKMv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Nov 2019 05:12:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:34292 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726768AbfKKKMu (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 11 Nov 2019 05:12:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 853F2B29C;
        Mon, 11 Nov 2019 10:12:49 +0000 (UTC)
Date:   Mon, 11 Nov 2019 11:12:48 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, guro@fb.com,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/vmscan: fix an undefined behavior for zone id
Message-ID: <20191111101248.GF1396@dhcp22.suse.cz>
References: <20191108204407.1435-1-cai@lca.pw>
 <64E60F6F-7582-427B-8DD5-EF97B1656F5A@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64E60F6F-7582-427B-8DD5-EF97B1656F5A@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 08-11-19 16:26:52, Qian Cai wrote:
> 
> 
> > On Nov 8, 2019, at 3:44 PM, Qian Cai <cai@lca.pw> wrote:
> > 
> > -    for (zid = 0; zid <= zone_idx; zid++) {
> > +    for (zid = 0; zid < zone_idx; zid++) {
> >        struct zone *zone =
> 
> Oops, I think here needs to be,
> 
> for (zid = 0; zid <= zone_idx && zid < MAX_NR_ZONES; zid++) {
> 
> to deal with this MAX_NR_ZONES special case.

Yep this looks correct.

Thanks!

-- 
Michal Hocko
SUSE Labs
