Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB520F74C8
	for <lists+cgroups@lfdr.de>; Mon, 11 Nov 2019 14:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKKN2P (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Nov 2019 08:28:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:51762 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726910AbfKKN2P (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 11 Nov 2019 08:28:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 52D3FAD00;
        Mon, 11 Nov 2019 13:28:13 +0000 (UTC)
Date:   Mon, 11 Nov 2019 14:28:12 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, guro@fb.com, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/vmscan: fix an undefined behavior for zone id
Message-ID: <20191111132812.GK1396@dhcp22.suse.cz>
References: <20191108204407.1435-1-cai@lca.pw>
 <64E60F6F-7582-427B-8DD5-EF97B1656F5A@lca.pw>
 <20191111130516.GA891635@chrisdown.name>
 <20191111131427.GB891635@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111131427.GB891635@chrisdown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 11-11-19 13:14:27, Chris Down wrote:
> Chris Down writes:
> > Ah, I just saw this in my local checkout and thought it was from my
> > changes, until I saw it's also on clean mmots checkout. Thanks for the
> > fixup!
> 
> Also, does this mean we should change callers that may pass through
> zone_idx=MAX_NR_ZONES to become MAX_NR_ZONES-1 in a separate commit, then
> remove this interim fixup? I'm worried otherwise we might paper over real
> issues in future.

Yes, removing this special casing is reasonable. I am not sure
MAX_NR_ZONES - 1 is a better choice though. It is error prone and
zone_idx is the highest zone we should consider and MAX_NR_ZONES - 1
be ZONE_DEVICE if it is configured. But ZONE_DEVICE is really standing
outside of MM reclaim code AFAIK. It would be probably better to have
MAX_LRU_ZONE (equal to MOVABLE) and use it instead.

-- 
Michal Hocko
SUSE Labs
