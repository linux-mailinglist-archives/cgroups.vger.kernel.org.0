Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937AA36811D
	for <lists+cgroups@lfdr.de>; Thu, 22 Apr 2021 15:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbhDVNEK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 09:04:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:47678 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230005AbhDVNEJ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 22 Apr 2021 09:04:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619096614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UMX8rj+pcEc6/XojbFh62HaWVLwaQEd+1bKoCKxPFkA=;
        b=Eu4e4G6peBU/rnxHUzFMyC1GmuKI7w8Ttf5/JJQZoHGIN/Vzgt+t7xGDt530g9IcWHK8CX
        6SF5E09+5SSGaRC60AFwhLRKzDQzaJ4LTbm2n5WdPSJxCRXom5fJv/daUbrJK3szXxXtry
        8GpzcnWumcC/56MaWDVO/TkkB7EjKao=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 34179B016;
        Thu, 22 Apr 2021 13:03:34 +0000 (UTC)
Date:   Thu, 22 Apr 2021 15:03:33 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dragos Sbirlea <dragoss@google.com>,
        Priya Duraisamy <padmapriyad@google.com>
Subject: Re: [RFC PATCH] Android OOM helper proof of concept
Message-ID: <YIF0JZ2uLS4sV6hv@dhcp22.suse.cz>
References: <CALvZod7vtDxJZtNhn81V=oE-EPOf=4KZB2Bv6Giz+u3bFFyOLg@mail.gmail.com>
 <YH54pyRWSi1zLMw4@dhcp22.suse.cz>
 <CALvZod4kjdgMU=8T_bx6zFufA1cGtt2p1Jg8jOgi=+g=bs-Evw@mail.gmail.com>
 <YH/RPydqhwXdyG80@dhcp22.suse.cz>
 <CALvZod4kRWDQuZZQ5F+z6WMcUWLwgYd-Kb0mY8UAEK4MbSOZaA@mail.gmail.com>
 <YIA2rB0wgqKzfUfi@dhcp22.suse.cz>
 <e01ee3aa-cbcb-dae2-ebcc-aba8b01d8aef@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e01ee3aa-cbcb-dae2-ebcc-aba8b01d8aef@sony.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 22-04-21 14:33:45, peter enderborg wrote:
[...]
> I think we very much need a OOM killer that can help out,
> but it is essential that it also play with android rules.

This is completely off topic to the discussion here.
-- 
Michal Hocko
SUSE Labs
