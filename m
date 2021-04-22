Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC34367FC5
	for <lists+cgroups@lfdr.de>; Thu, 22 Apr 2021 13:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbhDVLpf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 07:45:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:33110 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230510AbhDVLpf (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 22 Apr 2021 07:45:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619091900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jMEV+geuzllYzFQ8Z/TUZlHiYsSrdySAp1JVDStV2gA=;
        b=r/6dqE5AP0rYw1YYAbFz66SiZuRW/+7cE1RXdpAHrLWoronP+/qPsCjXgmrL962Qs0ddgu
        ILhPw+2qe/6j93/kY2gJ/q88mYATZKVh8IkYgfpCDb8H9J+sKBBw53rbMStq9WBppnAcWO
        RTLcfE1HrMLwb00nEW69gDg40l4Ie6w=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EEB4EAEE6;
        Thu, 22 Apr 2021 11:44:59 +0000 (UTC)
Date:   Thu, 22 Apr 2021 13:44:59 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vasily Averin <vvs@virtuozzo.com>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v3 15/16] memcg: enable accounting for tty-related objects
Message-ID: <YIFhuwlXKaAaY3IU@dhcp22.suse.cz>
References: <dddf6b29-debd-dcb5-62d0-74909d610edb@virtuozzo.com>
 <da450388-2fbc-1bb8-0839-b6480cb0eead@virtuozzo.com>
 <YIFcqcd4dCiNcILj@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIFcqcd4dCiNcILj@kroah.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 22-04-21 13:23:21, Greg KH wrote:
> On Thu, Apr 22, 2021 at 01:37:53PM +0300, Vasily Averin wrote:
> > At each login the user forces the kernel to create a new terminal and
> > allocate up to ~1Kb memory for the tty-related structures.
> 
> Does this tiny amount of memory actually matter?

The primary question is whether an untrusted user can trigger an
unbounded amount of these allocations.
-- 
Michal Hocko
SUSE Labs
