Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601B11BC0A4
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2020 16:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgD1OHE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Apr 2020 10:07:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39120 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728015AbgD1OHD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Apr 2020 10:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588082821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EalMZto1mc2jYDESRAloX1UBpj60CFWLwUGGzQdq+d4=;
        b=Cqvf7PgM9Sx0kBAqxrqGZhwTJph1/KXXlayRiBpQgh6js4qLELNRtIjH78cZ/WrZ6ZBtJZ
        HyLpg2ej849lQt56znB/C0L47dTeQNsdKXd0jYuIjMUs66gppmzJ6RlE68aykknhb3zjr9
        GJT6myKMqYeUG/dcuSD426lUTctjxrQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-sUfjVckgPIqi01aWVs2SQw-1; Tue, 28 Apr 2020 10:06:57 -0400
X-MC-Unique: sUfjVckgPIqi01aWVs2SQw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55CFD1899522;
        Tue, 28 Apr 2020 14:06:55 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-148.rdu2.redhat.com [10.10.118.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 50B1819C58;
        Tue, 28 Apr 2020 14:06:49 +0000 (UTC)
Subject: Re: [PATCH v2 4/4] mm/slub: Fix sysfs shrink circular locking
 dependency
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>
References: <dbbfe685-7374-9a96-b7c2-684142746e30@redhat.com>
 <28BB8A1C-CFDF-4F5A-8686-537C3CE04818@lca.pw>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <56327de0-fa44-d5f3-2409-69cf2b97a209@redhat.com>
Date:   Tue, 28 Apr 2020 10:06:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <28BB8A1C-CFDF-4F5A-8686-537C3CE04818@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/27/20 10:11 PM, Qian Cai wrote:
>
>> On Apr 27, 2020, at 9:39 PM, Waiman Long <longman@redhat.com> wrote:
>>
>> The sequence that was prevented by this patch is "kn->count --> mem_ho=
tplug_lock.rwsem". This sequence isn't directly in the splat. Once this l=
ink is broken, the 3-lock circular loop cannot be formed. Maybe I should =
modify the commit log to make this point more clear.
> I don=E2=80=99t know what you are talking about. Once trylock succeed o=
nce, you will have kn->count =E2=80=94> cpu/memory_hotplug_lock.
>
Trylock is handled differently from lockdep's perspective as trylock can=20
failed. When trylock succeeds, the critical section is executed. As long=20
as it doesn't try to acquire another lock in the circular chain, the=20
execution will finish at some point and release the lock. On the other=20
hand, if another task has already held all those locks, the trylock will=20
fail and held locks should be released. Again, no deadlock will happen.

Regards,
Longman

