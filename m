Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEAF7E056C
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2019 15:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732115AbfJVNqF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Oct 2019 09:46:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26568 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730540AbfJVNqE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Oct 2019 09:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571751963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AZ2Lyz8vnWq4qiRDaCZkUIbSRXAGjuYLj75pS2gsmNI=;
        b=NY+2VCjCiaheWshCAhwD0AZh8QhgqG4GLQn7rwMer1GedJycaK7Q43wIvJdH0QFYmGAgA8
        MqZ/6kAfZxZKUVNX35nsiaY67C+E0P3by+ZQZXe+nrl24yOInztLndjRJF7FDYC/b+aWNd
        JmtpXwGfP4BVFAIWmyukExSB2pu42mQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-meLleCh0PF2g2JXH-ncNiA-1; Tue, 22 Oct 2019 09:45:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A194980183E;
        Tue, 22 Oct 2019 13:45:58 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id AAEB11001B22;
        Tue, 22 Oct 2019 13:45:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 22 Oct 2019 15:45:58 +0200 (CEST)
Date:   Tue, 22 Oct 2019 15:45:55 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Honglei Wang <honglei.wang@oracle.com>
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, guro@fb.com
Subject: Re: [PATCH] cgroup: freezer: don't change task and cgroups status
 unnecessarily
Message-ID: <20191022134555.GA5307@redhat.com>
References: <20191021081826.8769-1-honglei.wang@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20191021081826.8769-1-honglei.wang@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: meLleCh0PF2g2JXH-ncNiA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/21, Honglei Wang wrote:
>
> @@ -230,6 +230,15 @@ void cgroup_freezer_migrate_task(struct task_struct =
*task,
> +=09/*
> +=09 * It's not necessary to do changes if both of the src and dst cgroup=
s
> +=09 * are not freeze and task is not frozen.
> +=09 */
> +=09if (!test_bit(CGRP_FREEZE, &src->flags) &&
> +=09    !test_bit(CGRP_FREEZE, &dst->flags) &&
> +=09    !task->frozen)
> +=09=09return;
> +

If we want to optimize cgroup_freezer_migrate_task()... I am sure I missed
something, but can't we do better ?

If a frozen task enters or leaves cgrp, this should never change the state
of FROZEN bit?

Oleg.

--- x/kernel/cgroup/freezer.c
+++ x/kernel/cgroup/freezer.c
@@ -238,14 +238,14 @@ void cgroup_freezer_migrate_task(struct
 =09if (task->frozen) {
 =09=09cgroup_inc_frozen_cnt(dst);
 =09=09cgroup_dec_frozen_cnt(src);
+=09} else {
+=09=09if (test_bit(CGRP_FREEZE, &src->flags))
+=09=09=09cgroup_update_frozen(src);
+=09=09if (test_bit(CGRP_FREEZE, &dst->flags)) {
+=09=09=09cgroup_update_frozen(dst);
+=09=09=09cgroup_freeze_task(task, true);
+=09=09}
 =09}
-=09cgroup_update_frozen(dst);
-=09cgroup_update_frozen(src);
-
-=09/*
-=09 * Force the task to the desired state.
-=09 */
-=09cgroup_freeze_task(task, test_bit(CGRP_FREEZE, &dst->flags));
 }
=20
 void cgroup_freeze(struct cgroup *cgrp, bool freeze)

