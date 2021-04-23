Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF54368DF2
	for <lists+cgroups@lfdr.de>; Fri, 23 Apr 2021 09:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhDWHfd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Apr 2021 03:35:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbhDWHfd (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 23 Apr 2021 03:35:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4681613CC;
        Fri, 23 Apr 2021 07:34:55 +0000 (UTC)
Date:   Fri, 23 Apr 2021 09:34:52 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Roman Gushchin <guro@fb.com>, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Serge Hallyn <serge@hallyn.com>
Subject: Re: [PATCH] memcg: enable accounting for pids in nested pid
 namespaces
Message-ID: <20210423073452.osm4w7crgfsx4ywj@wittgenstein>
References: <7b777e22-5b0d-7444-343d-92cbfae5f8b4@virtuozzo.com>
 <YIIcKa/ANkQX07Nf@carbon>
 <38945563-59ad-fb5e-9f7f-eb65ae4bf55e@virtuozzo.com>
 <YIIxPAcdd4p4NTxV@carbon>
 <cd6680e3-edd0-88fa-bb83-b9f2d5a65d5b@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd6680e3-edd0-88fa-bb83-b9f2d5a65d5b@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 23, 2021 at 05:53:43AM +0300, Vasily Averin wrote:
> On 4/23/21 5:30 AM, Roman Gushchin wrote:
> > On Fri, Apr 23, 2021 at 05:09:01AM +0300, Vasily Averin wrote:
> >> On 4/23/21 4:00 AM, Roman Gushchin wrote:
> >>> On Thu, Apr 22, 2021 at 08:44:15AM +0300, Vasily Averin wrote:
> >>>> init_pid_ns.pid_cachep have enabled memcg accounting, though this
> >>>> setting was disabled for nested pid namespaces.
> >>>>
> >>>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> >>>> ---
> >>>>  kernel/pid_namespace.c | 3 ++-
> >>>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> >>>> index 6cd6715..a46a372 100644
> >>>> --- a/kernel/pid_namespace.c
> >>>> +++ b/kernel/pid_namespace.c
> >>>> @@ -51,7 +51,8 @@ static struct kmem_cache *create_pid_cachep(unsigned int level)
> >>>>  	mutex_lock(&pid_caches_mutex);
> >>>>  	/* Name collision forces to do allocation under mutex. */
> >>>>  	if (!*pkc)
> >>>> -		*pkc = kmem_cache_create(name, len, 0, SLAB_HWCACHE_ALIGN, 0);
> >>>> +		*pkc = kmem_cache_create(name, len, 0,
> >>>> +					 SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT, 0);
> >>>>  	mutex_unlock(&pid_caches_mutex);
> >>>>  	/* current can fail, but someone else can succeed. */
> >>>>  	return READ_ONCE(*pkc);
> >>>> -- 
> >>>> 1.8.3.1
> >>>>
> >>>
> >>> It looks good to me! It makes total sense to apply the same rules to the root
> >>> and non-root levels.
> >>>
> >>> Acked-by: Roman Gushchin <guro@fb.com>
> >>>
> >>> Btw, is there any reason why this patch is not included into the series?
> >>
> >> It is a bugfix and I think it should be added to upstream ASAP.
> > 
> > Then it would be really useful to add some details on why it's a bug,
> > what kind of problems it causes, etc. If it has to be backported to
> > stable, please, add cc stable/fixes tag.
> 
> I mean, in this case we already decided to account pids, but forget to do it.
> In another cases we did not have final decision about accounting.
> 
> I doubt we specially denied accounting for pids frem nested pid namespaces,
> especially because they consumes more memory.
> We can expect that all pids are accounted -- but it does not happen in fact.

As Roman said you should probably explain this in the cover letter and
essentially justify why this should be backported. The thing with
changes such as this is that it's easy for someone to reply and go
"noone noticed for <n> years so why do we care now?". Otherwise:

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Christian
