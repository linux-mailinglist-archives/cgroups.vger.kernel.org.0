Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFD042E9B0
	for <lists+cgroups@lfdr.de>; Fri, 15 Oct 2021 09:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbhJOHJz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Oct 2021 03:09:55 -0400
Received: from submit01.uniweb.no ([5.249.227.132]:45695 "EHLO
        submit01.uniweb.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbhJOHJz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Oct 2021 03:09:55 -0400
Received: from [10.20.0.41] (helo=mail.uniweb.no)
        by submit01.uniweb.no with esmtpa (Exim 4.93)
        (envelope-from <odin@digitalgarden.no>)
        id 1mbHJj-00Gq1D-8Z; Fri, 15 Oct 2021 09:07:47 +0200
Date:   Fri, 15 Oct 2021 09:07:45 +0200
From:   Odin Hultgren van der Horst <odin@digitalgarden.no>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     tj@kernel.org, cgroups@vger.kernel.org
Subject: Re: [Question] io cgroup subsystem threaded support
Message-ID: <20211015070745.zbzpistqrj6g4zxa@T580.localdomain>
References: <20211001110645.uzw2w5t4rknwqhma@T580.localdomain>
 <20211007133916.mgk6qb65d2r57fc2@T580.localdomain>
 <20211011153416.GB61605@blackbody.suse.cz>
 <20211015065135.5hauecjmri2lytpv@T580.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211015065135.5hauecjmri2lytpv@T580.localdomain>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 14, 2021 at 11:29:38AM +0200, Michal Koutný wrote:
> On Thu, Oct 14, 2021 at 10:38:30AM +0200, Odin Hultgren van der Horst <odin@digitalgarden.no> wrote:
> > On Mon, Oct 11, 2021 at 05:34:16PM +0200, Michal Koutný wrote:
> > > What do you want to achieve actually?
> > If a application use a thread per client that is connected, and a client
> > decides to do a large read on a io device it will cause all other clients
> > to be starved of io. I want to avoid this.
> 
> IIUC, the application would have to be collaborative anyway (dividing
> threads into cgroups) and given you're concered about reads,
> set_ioprio(2) might be enough for this case.
> 
> Also, if you've seen starvation (likely depends on IO scheduler), you
> may raise this with linux-block ML.
> 
> HTH,
> Michal

I also want to be able to limit amount of io for a given thread, just
like you could to with io.max. So a given client cant just use all my io
even though there is no competing thread.

Thanks,
Odin
