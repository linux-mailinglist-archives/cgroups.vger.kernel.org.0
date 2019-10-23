Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2F7E1C71
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2019 15:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405849AbfJWNYA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Oct 2019 09:24:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38698 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405848AbfJWNX7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Oct 2019 09:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571837039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XS65t5X8f5xPZoXspApVotMSsjhb2vM444RdBlH8BE4=;
        b=Cpd3IysTdLJ1pdDRx5HVaMxpLCsWgwlNSuQUkmQa53Bnz/x7YkyXK0j6/sD4OBoh6NBRPg
        Y8fTgMQvmGtf7kmk56x9ArghZVs6/Fht334b4OetJJJbQGZJtjsFvFlw1Y6f/g7SZVNotw
        GT8iXFHP1kaTKFwys/UOdRc8eoDiox8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-nlJzw3kyPwCIKyrP1kuVCg-1; Wed, 23 Oct 2019 09:23:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50B46476;
        Wed, 23 Oct 2019 13:23:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 61A5760C83;
        Wed, 23 Oct 2019 13:23:51 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 23 Oct 2019 15:23:54 +0200 (CEST)
Date:   Wed, 23 Oct 2019 15:23:50 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Honglei Wang <honglei.wang@oracle.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "lizefan@huawei.com" <lizefan@huawei.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [PATCH] cgroup: freezer: don't change task and cgroups status
 unnecessarily
Message-ID: <20191023132350.GB14327@redhat.com>
References: <20191021081826.8769-1-honglei.wang@oracle.com>
 <20191022134555.GA5307@redhat.com>
 <20191022173113.GD21381@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
In-Reply-To: <20191022173113.GD21381@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: nlJzw3kyPwCIKyrP1kuVCg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/22, Roman Gushchin wrote:
>
> On Tue, Oct 22, 2019 at 03:45:55PM +0200, Oleg Nesterov wrote:
> >
> > --- x/kernel/cgroup/freezer.c
> > +++ x/kernel/cgroup/freezer.c
> > @@ -238,14 +238,14 @@ void cgroup_freezer_migrate_task(struct
> >  =09if (task->frozen) {
> >  =09=09cgroup_inc_frozen_cnt(dst);
> >  =09=09cgroup_dec_frozen_cnt(src);
> > +=09} else {
> > +=09=09if (test_bit(CGRP_FREEZE, &src->flags))
> > +=09=09=09cgroup_update_frozen(src);
> > +=09=09if (test_bit(CGRP_FREEZE, &dst->flags)) {
> > +=09=09=09cgroup_update_frozen(dst);
> > +=09=09=09cgroup_freeze_task(task, true);
> > +=09=09}
> >  =09}
> > -=09cgroup_update_frozen(dst);
> > -=09cgroup_update_frozen(src);
>
>
> > -
> > -=09/*
> > -=09 * Force the task to the desired state.
> > -=09 */
> > -=09cgroup_freeze_task(task, test_bit(CGRP_FREEZE, &dst->flags));
>
> Hm, I'm not sure we can skip this part.

Neither me, but

> Imagine A->B migration, A has just been unfrozen, B is frozen.
>
> The task has JOBCTL_TRAP_FREEZE cleared, but task->frozen is still set.
> Now we move the task to B. No one will set JOBCTL_TRAP_FREEZE again, so
> the task will remain running.
>
> Is it a valid concern?

Not sure I understand... The patch doesn't remove cgroup_freeze_task(),
it shifts it up, under the test_bit(CGRP_FREEZE, &dst).

Oleg.

