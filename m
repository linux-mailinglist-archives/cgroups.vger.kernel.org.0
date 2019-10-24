Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFD9E36F2
	for <lists+cgroups@lfdr.de>; Thu, 24 Oct 2019 17:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409745AbfJXPpY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Oct 2019 11:45:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40307 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2409737AbfJXPpY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Oct 2019 11:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571931923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WVFyVIJdgvmYtwLNTvf4QHaU50gdmmbGImchgdFsTP4=;
        b=YyVSs4+W5wHeQysSLOl/oHDwME2dHhzIp/uz9YS8Oa+0H1oRwdsh4PefMLJ4+uYAqYxLa/
        pLwv0JnFrJLK+8ZnydOXS8R4Fv7757Xya+1CCnAY1UeTdD9UW7zFV/nfeszRLWTdipDT9U
        nx1UD94Xgfx3xDDGWs/VNtJfb12cxZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-w7c5VvFhONu7vHNjMV-xmg-1; Thu, 24 Oct 2019 11:45:16 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F3078B7CE7;
        Thu, 24 Oct 2019 15:29:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id A98E160BF3;
        Thu, 24 Oct 2019 15:29:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 24 Oct 2019 17:29:11 +0200 (CEST)
Date:   Thu, 24 Oct 2019 17:29:09 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Honglei Wang <honglei.wang@oracle.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "lizefan@huawei.com" <lizefan@huawei.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [PATCH] cgroup: freezer: don't change task and cgroups status
 unnecessarily
Message-ID: <20191024152909.GA24363@redhat.com>
References: <20191021081826.8769-1-honglei.wang@oracle.com>
 <20191022134555.GA5307@redhat.com>
 <20191022173113.GD21381@tower.DHCP.thefacebook.com>
 <20191023132350.GB14327@redhat.com>
 <20191023162011.GA27766@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
In-Reply-To: <20191023162011.GA27766@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: w7c5VvFhONu7vHNjMV-xmg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/23, Roman Gushchin wrote:
>
> On Wed, Oct 23, 2019 at 03:23:50PM +0200, Oleg Nesterov wrote:
> >
> > Not sure I understand... The patch doesn't remove cgroup_freeze_task(),
> > it shifts it up, under the test_bit(CGRP_FREEZE, &dst).
>
> Yes, but it does remove cgroup_freeze_task(task, false) if the target
> cgroup is not frozen.

Ah, got it.

Right you are, thanks for correcting me!

Oleg.

