Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A362AADAB
	for <lists+cgroups@lfdr.de>; Sun,  8 Nov 2020 22:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgKHVYa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 8 Nov 2020 16:24:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:51918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbgKHVYa (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 8 Nov 2020 16:24:30 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7D5F206DC;
        Sun,  8 Nov 2020 21:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604870669;
        bh=vxmvo8miQMzTKLGrFkPnE/1C253hjdvDi75bzDKNigs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=D1Pwm4DU8rJIviPoYdLiBzgsCCxy6gVSQcFf1yNazQCs+JB9zxJgdTwWlBtlWRalj
         k2rJwirfrbAQI2n0Itq5h0UBa8J2Ry4ts8q+vOdavz1Ka+WsmrIB+R41zTp0+6m9mA
         oqXolKCTPHqB4f3SCxZi/a4bOJ+qs5NnZQON7P5w=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8CD313522777; Sun,  8 Nov 2020 13:24:29 -0800 (PST)
Date:   Sun, 8 Nov 2020 13:24:29 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Li Zefan <lizefan@huawei.com>
Subject: Re: [PATCH 0/4] RFC: support for global CPU list abbreviations
Message-ID: <20201108212429.GA8195@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201108160816.896881-1-paul.gortmaker@windriver.com>
 <20201108180222.GA17637@paulmck-ThinkPad-P72>
 <ca462940-c81d-d968-c870-e1a991331522@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca462940-c81d-d968-c870-e1a991331522@windriver.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Nov 08, 2020 at 03:21:40PM -0500, Paul Gortmaker wrote:
> On 2020-11-08 1:02 p.m., Paul E. McKenney wrote:
> 
> > Or I can carry them if you wish.  My expected changes in response to
> > this series are shown below, and are also what I used to test it.
> 
> Thanks Paul - that would get linux-next exposure w/o me pestering sfr.
> If nobody else has objections, having them in rcu-next would be great.

Unless/until someone objects, you got it!

							Thanx, Paul
