Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1E183009
	for <lists+cgroups@lfdr.de>; Tue,  6 Aug 2019 12:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbfHFKuH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Aug 2019 06:50:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:43022 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730868AbfHFKuH (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 6 Aug 2019 06:50:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D2D8FAFCC;
        Tue,  6 Aug 2019 10:50:05 +0000 (UTC)
Date:   Tue, 6 Aug 2019 12:50:04 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masoud Sharbiani <msharbiani@apple.com>,
        Greg KH <gregkh@linuxfoundation.org>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Possible mem cgroup bug in kernels between 4.18.0 and 5.3-rc1.
Message-ID: <20190806105004.GS11812@dhcp22.suse.cz>
References: <20190802191430.GO6461@dhcp22.suse.cz>
 <A06C5313-B021-4ADA-9897-CE260A9011CC@apple.com>
 <f7733773-35bc-a1f6-652f-bca01ea90078@I-love.SAKURA.ne.jp>
 <d7efccf4-7f07-10da-077d-a58dafbf627e@I-love.SAKURA.ne.jp>
 <20190805084228.GB7597@dhcp22.suse.cz>
 <7e3c0399-c091-59cd-dbe6-ff53c7c8adc9@i-love.sakura.ne.jp>
 <20190805114434.GK7597@dhcp22.suse.cz>
 <0b817204-29f4-adfb-9b78-4fec5fa8f680@i-love.sakura.ne.jp>
 <20190805142622.GR7597@dhcp22.suse.cz>
 <56d98a71-b77e-0ad7-91ad-62633929c736@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56d98a71-b77e-0ad7-91ad-62633929c736@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 06-08-19 19:26:12, Tetsuo Handa wrote:
> On 2019/08/05 23:26, Michal Hocko wrote:
> > On Mon 05-08-19 23:00:12, Tetsuo Handa wrote:
> >> On 2019/08/05 20:44, Michal Hocko wrote:
> >>>> Allowing forced charge due to being unable to invoke memcg OOM killer
> >>>> will lead to global OOM situation, and just returning -ENOMEM will not
> >>>> solve memcg OOM situation.
> >>>
> >>> Returning -ENOMEM would effectivelly lead to triggering the oom killer
> >>> from the page fault bail out path. So effectively get us back to before
> >>> 29ef680ae7c21110. But it is true that this is riskier from the
> >>> observability POV when a) the OOM path wouldn't point to the culprit and
> >>> b) it would leak ENOMEM from g-u-p path.
> >>>
> >>
> >> Excuse me? But according to my experiment, below code showed flood of
> >> "Returning -ENOMEM" message instead of invoking the OOM killer.
> >> I didn't find it gets us back to before 29ef680ae7c21110...
> > 
> > You would need to declare OOM_ASYNC to return ENOMEM properly from the
> > charge (which is effectivelly a revert of 29ef680ae7c21110 for NOFS
> > allocations). Something like the following
> > 
> 
> OK. We need to set current->memcg_* before declaring something other than
> OOM_SUCCESS and OOM_FAILED... Well, it seems that returning -ENOMEM after
> setting current->memcg_* works as expected. What's wrong with your approach?

As I've said, and hoped you could pick up parts for your changelog for
the ENOMEM part, a) oom path is lost b) some paths will leak ENOMEM e.g.
g-u-p. So your patch to trigger the oom even for NOFS is a better
alternative I just found your ENOMEM note misleading and something that
could improve.
-- 
Michal Hocko
SUSE Labs
