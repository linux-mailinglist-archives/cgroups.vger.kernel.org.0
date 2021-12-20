Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC0847B2F9
	for <lists+cgroups@lfdr.de>; Mon, 20 Dec 2021 19:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238583AbhLTSiv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Dec 2021 13:38:51 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56634 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbhLTSiv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Dec 2021 13:38:51 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3E4211F3A0;
        Mon, 20 Dec 2021 18:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1640025530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v/9c5gDuVgYGPEXeFQjyL6TtNmD9bzJ8bgZ19uB6v1k=;
        b=NxACriKiD9VfNr/HENL9Ce2ZX4rfRo8PXWOsGU+p7d2CAZNZRTldE/Rnb1Kqa+SNLscpa1
        PbXqVJeJpgtnnw5YduqE1JooFKHaeghDBwkJl2uN9TPIrZzdiqHNyqNyp1Nl88zFBwx5fG
        zKaKJKgK8XF1Nwk9l5tMEWTF4BbsSkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1640025530;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v/9c5gDuVgYGPEXeFQjyL6TtNmD9bzJ8bgZ19uB6v1k=;
        b=+3gj5ZGsU3khQ/XTi1/rwgFxLBoXlFJN9my/l3GKNoGi3FNIQqmZzdlIrnMI93TLMDEwmw
        X8pN1lMAKIbNjYDA==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id 2E6D3A3B84;
        Mon, 20 Dec 2021 18:38:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 63BDF1F2CFB; Mon, 20 Dec 2021 19:38:44 +0100 (CET)
Date:   Mon, 20 Dec 2021 19:38:44 +0100
From:   Jan Kara <jack@suse.cz>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Jan Kara <jack@suse.cz>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, fvogt@suse.de, cgroups@vger.kernel.org
Subject: Re: Use after free with BFQ and cgroups
Message-ID: <20211220183844.GA2386@quack2.suse.cz>
References: <20211125172809.GC19572@quack2.suse.cz>
 <20211126144724.GA31093@blackbody.suse.cz>
 <20211129171115.GC29512@quack2.suse.cz>
 <f03b2b1c-808a-c657-327d-03165b988e7d@huawei.com>
 <20211213173354.GE14044@quack2.suse.cz>
 <896161a3-922c-63b3-6e6f-9f6005a46bd4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <896161a3-922c-63b3-6e6f-9f6005a46bd4@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 14-12-21 09:24:58, yukuai (C) wrote:
> 在 2021/12/14 1:33, Jan Kara 写道:
> > Hello!
> > 
> > On Thu 09-12-21 10:23:33, yukuai (C) wrote:
> > > 在 2021/11/30 1:11, Jan Kara 写道:
> > > > On Fri 26-11-21 15:47:24, Michal Koutný wrote:
> > > > > Hello.
> > > > > 
> > > > > On Thu, Nov 25, 2021 at 06:28:09PM +0100, Jan Kara <jack@suse.cz> wrote:
> > > > > [...]
> > > > > +Cc cgroups ML
> > > > > https://lore.kernel.org/linux-block/20211125172809.GC19572@quack2.suse.cz/
> > > > > 
> > > > > 
> > > > > I understand there are more objects than blkcgs but I assume it can
> > > > > eventually boil down to blkcg references, so I suggest another
> > > > > alternative. (But I may easily miss the relations between BFQ objects,
> > > > > so consider this only high-level opinion.)
> > > > > 
> > > > > > After some poking, looking into crashdumps, and applying some debug patches
> > > > > > the following seems to be happening: We have a process P in blkcg G. Now
> > > > > > G is taken offline so bfq_group is cleaned up in bfq_pd_offline() but P
> > > > > > still holds reference to G from its bfq_queue. Then P submits IO, G gets
> > > > > > inserted into service tree despite being already offline.
> > > > > 
> > > > > (If G is offline, P can only be zombie, just saying. (I guess it can
> > > > > still be Q's IO on behalf of G.))
> > > > > 
> > > > > IIUC, the reference to G is only held by P. If the G reference is copied
> > > > > into another structure (the service tree) it should get another
> > > > > reference. My naïve proposal would be css_get(). (1)
> > > > 
> > > > So I was looking into this puzzle. The answer is following:
> > > > 
> > > > The process P (podman, pid 2571) is currently attached to the root cgroup
> > > > but it has io_context with BFQ queue that points to the already-offline G
> > > > as a parent. The bio is thus associated with the root cgroup (via
> > > > bio->bi_blkg) but BFQ uses io_context to lookup the BFQ queue where IO
> > > > should be queued and then uses its parent to determine blkg which it should
> > > > be charged and thus gets to the dying cgroup.
> > > 
> > > After some code review, we found that the root cause of the problem
> > > semms to be different.
> > > 
> > > If the process is moved from group G to root group, and a new io is
> > > issued from the process, then bfq should detect this and changing
> > > bfq_queue's parent to root bfq_group:
> > > 
> > > bfq_insert_request
> > >   bfq_init_rq
> > >    bfq_bic_update_cgroup
> > >     serial_nr = __bio_blkcg(bio)->css.serial_nr; -> from root group
> > >     bic->blkcg_serial_nr == serial_nr -> this do not pass，because
> > > bic->blkcg_serial_nr is still from group G
> > 
> > So in the crashdump I have available, I can see that
> > _bio_blkcg(bio)->css.serial_nr is 4. Also bic->blkcg_serial_nr is 4. But
> > bic->bfqq[1] is a bfq_queue that has its entity->parent set to already
> > offlined bfq_group. Not sure how that is possible...
> > 
> > >     __bfq_bic_change_cgroup -> bfq_queue parent will be changed to root group
> > > 
> > > And we think the following path is possible to trigger the problem:
> > > 
> > > 1) process P1 and P2 is currently in cgroup C1, corresponding to
> > > bfq_queue q1, q2 and bfq_group g1. And q1 and q2 are merged:
> > > q1->next_bfqq = q2.
> > 
> > I agree shared queues are some factor in this - the problematic bfq_queue
> > pointing to the dead bfq_group has 'coop' flag set, pid == -1, bic ==
> > NULL. So clearly it has been merged with another bfq_queue.
> > 
> > > 2) move P1 from C1 to root_cgroup, q1->next_bfqq is still q2
> > > and flag BFQQF_split_coop is not set yet.
> > 
> > There's no next_bfqq in the kernel I'm looking into... Generally the merge
> > code seems to be working somewhat differently to what you describe (I'm
> > looking into 5.16-rc3 kernel).
> 
> Hi, Jan
> 
> Sorry, It should be new_bfqq, which will be set if the queue is merged
> to other queue.
> > 
> > > 3) P2 exit, q2 won't exit because it's still referenced through
> > > queue merge.
> > > 
> > > 4) delete C1, g1 is offlined
> > > 
> > > 5) issue a new io in q1, q1's parent entity will change to root,
> > > however the io will end up in q1->next_bfqq = q2, and thus the
> > > offlined g1 is inserted to service tree through q2.
> > > 
> > > 6) P1 exit, q2 exit, and finially g1 is freed, while g1 is still
> > > in service tree of it's parent.
> > > 
> > > We confirmed this by our reproducer through a simple patch:
> > > stop merging bfq_queues if their parents are different.
> > > 
> > > diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> > > index 1ce1a99a7160..14c1d1c3811e 100644
> > > --- a/block/bfq-iosched.c
> > > +++ b/block/bfq-iosched.c
> > > @@ -2626,6 +2626,11 @@ bfq_setup_merge(struct bfq_queue *bfqq, struct
> > > bfq_queue *new_bfqq)
> > >          while ((__bfqq = new_bfqq->new_bfqq)) {
> > >                  if (__bfqq == bfqq)
> > >                          return NULL;
> > > +               if (__bfqq->entity.parent != bfqq->entity.parent) {
> > > +                       if (bfq_bfqq_coop(__bfqq))
> > > +                               bfq_mark_bfqq_split_coop(__bfqq);
> > > +                       return NULL;
> > > +               }
> > >                  new_bfqq = __bfqq;
> > >          }
> > > 
> > > @@ -2825,8 +2830,16 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct
> > > bfq_queue *bfqq,
> > >          if (bfq_too_late_for_merging(bfqq))
> > >                  return NULL;
> > > 
> > > -       if (bfqq->new_bfqq)
> > > -               return bfqq->new_bfqq;
> > > +       if (bfqq->new_bfqq) {
> > > +               struct bfq_queue *new_bfqq = bfqq->new_bfqq;
> > > +
> > > +               if(bfqq->entity.parent == new_bfqq->entity.parent)
> > > +                       return new_bfqq;
> > > +
> > > +               if(bfq_bfqq_coop(new_bfqq))
> > > +                       bfq_mark_bfqq_split_coop(new_bfqq);
> > > +               return NULL;
> > > +       }
> > > 
> > > Do you think this analysis is correct?
> > 
> > Honestly, I'm not sure. At this point I'm not sure why the bfqq pointed to
> > from bic didn't get reparented to the new cgroup when bio was submitted...
> 
> After queue merging, bic is set to the new bfqq, for example:
> 
> __bfq_insert_request
>  new_bfqq = bfq_setup_cooperator
>  bfq_merge_bfqqs -> before this is done, bic is set to old bfqq
>   bic_set_bfqq(bic, new_bfqq, 1); -> bic is set to new bfqq
>  rq->elv.priv[1] = new_bfqq;
> 
> I think current problem is that if bfq_queue is merged, task migration
> won't break such cooperation，thus issue io from one cgroup may endup to
> a bfq_queue that is from another cgroup, which might be offlined.

OK, I now understand what you mean. Indeed the full code is like:

bfq_insert_request()
  ...
  bfq_init_rq()
    bfq_check_ioprio_change(bic, bio);
    bfq_bic_update_cgroup(bic, bio);
      - this correctly moves bfqq of the process to appropriate blkcg
    bfqq = bfq_get_bfqq_handle_split()
    ... now associate request with bfqq ...
  __bfq_insert_request()
    new_bfqq = bfq_setup_cooperator()
    ... move request to new_bfqq ... there is no guarantee about the
    parent of new_bfqq, it may be a different cgroup if bic->stable_merge_bfqq
    predates process move, it may point to a dead cgroup or whatever.

Now I think there are several things wrong about the current code:

1) A process can submit IO for multiple cgroups (if e.g. fsync() is doing
writeback of pages created in the page cache by a process from different
cgroup). Thus bfqq can at the same time contain IO from multiple cgroups
and reparenting of bfqq in bfq_bic_update_cgroup() is going to have
interesting side-effects on the scheduling decisions. This is going to be
difficult to fully solve - probably bfqq in bic should have as a parent
cgroup pointed to by css of the process and if we detect currently
submitted bio belongs to a different cgroup, we need to lookup & create new
bfqq with appropriate parent and queue the request there. But this is not
critical issue at this point so we can leave it for later, I just wanted to
mention this to set frame for the problems below.

2) Bfqq merging (bfq_setup_cooperator() and friends) happens in
__bfq_insert_request() rather late during request queueing. As a result we
have to redo several things when we decide to merge queues (as request is
already queued in the previous queue) and we miss to update cgroup parent.
IMHO we should reorganize the code flow so that all the queue merging &
splitting happens first, we get final bfqq out of that and we associate
request with that bfqq (including cgroup handling). This will also fix the
use-after-free issue.

3) If the process is moved to a different cgroup (or just submits bio for a
different cgroup) The bic->stable_merge_bfq may point to bfqq from a
different cgroup and thus merging them is undesirable. Solution for 1) will
also deal with this problem but until then, I think that if
bfq_bic_update_cgroup() notices a cgroup mismatch, it also clears
bic->stable_merge_bfq to avoid this problem. As a side-effect this will
also fix the use-after-free issue even without solving 2).

4) I find it fragile that we may have around bfqqs with dead cgroups as a
parent and if we mistakenly activate these bfqqs (and thus parent cgroups)
and insert them in the service tree, use-after-free problem is here. So I
think that my patch to actively reparent all bfqqs from a dying cgroup
makes sense (alternatively we could make sure service tree holds a ref for
the cgroups it contains but that seems like a more expensive and intrusive
fix) and I'd keep it as a safety measure for the future.

So my current plan is:

Implement 3) as a quick and easily backportable fix for the use-after-free
issue. Then work on 2) and submit it with 4) as cleanups & future-proofing.
Once this is done, we can think about 1) but probably we should try to
see how bad that problem is in practice and whether the solution is worth
it.

What do people think?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
